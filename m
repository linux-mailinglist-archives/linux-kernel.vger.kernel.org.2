Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E90E3A80FE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 15:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbhFONnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 09:43:20 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:50294 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231777AbhFONm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 09:42:58 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 808944126E;
        Tue, 15 Jun 2021 13:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        in-reply-to:content-disposition:content-type:content-type
        :mime-version:references:message-id:subject:subject:from:from
        :date:date:received:received:received; s=mta-01; t=1623764451;
         x=1625578852; bh=xJnhjAU7ZYZev8c9y0P1D2Z4sA2jZW/pEDQvqaSEuGU=; b=
        q1X2+1bdoy+JSbHoNcFcqMRKSnerrho5ZZbCGsV5cmuw4kVcxu3G8H5aPJjseTfa
        BKU+IenozHv0mJHaG+5ZmKSwc5R39epKA9GVWGop7+HmmLgKPX7tNdIaGPTFtgn+
        wyjUnjkYUXtjJKFH6plj9SqqkQTBrPAqvDdkV/sbOeI=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MQOGQMtOCmfq; Tue, 15 Jun 2021 16:40:51 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 9310C41292;
        Tue, 15 Jun 2021 16:40:44 +0300 (MSK)
Received: from localhost (172.22.1.233) by T-EXCH-03.corp.yadro.com
 (172.17.100.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Tue, 15
 Jun 2021 16:40:44 +0300
Date:   Tue, 15 Jun 2021 16:40:43 +0300
From:   Roman Bolshakov <r.bolshakov@yadro.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
CC:     <linuxppc-dev@lists.ozlabs.org>, <dja@axtens.net>,
        <christophe.leroy@csgroup.eu>, <a.kovaleva@yadro.com>,
        <groug@kaod.org>, Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc: Fix initrd corruption with relative jump labels
Message-ID: <YMit22vwhmeK5BvK@SPB-NB-133.local>
References: <20210614131440.312360-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210614131440.312360-1-mpe@ellerman.id.au>
X-Originating-IP: [172.22.1.233]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-03.corp.yadro.com (172.17.100.103)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 11:14:40PM +1000, Michael Ellerman wrote:
> Commit b0b3b2c78ec0 ("powerpc: Switch to relative jump labels") switched
> us to using relative jump labels. That involves changing the code,
> target and key members in struct jump_entry to be relative to the
> address of the jump_entry, rather than absolute addresses.
> 
> We have two static inlines that create a struct jump_entry,
> arch_static_branch() and arch_static_branch_jump(), as well as an asm
> macro ARCH_STATIC_BRANCH, which is used by the pseries-only hypervisor
> tracing code.
> 
> Unfortunately we missed updating the key to be a relative reference in
> ARCH_STATIC_BRANCH.
> 
> That causes a pseries kernel to have a handful of jump_entry structs
> with bad key values. Instead of being a relative reference they instead
> hold the full address of the key.
> 
> However the code doesn't expect that, it still adds the key value to the
> address of the jump_entry (see jump_entry_key()) expecting to get a
> pointer to a key somewhere in kernel data.
> 
> The table of jump_entry structs sits in rodata, which comes after the
> kernel text. In a typical build this will be somewhere around 15MB. The
> address of the key will be somewhere in data, typically around 20MB.
> Adding the two values together gets us a pointer somewhere around 45MB.
> 
> We then call static_key_set_entries() with that bad pointer and modify
> some members of the struct static_key we think we are pointing at.
> 
> A pseries kernel is typically ~30MB in size, so writing to ~45MB won't
> corrupt the kernel itself. However if we're booting with an initrd,
> depending on the size and exact location of the initrd, we can corrupt
> the initrd. Depending on how exactly we corrupt the initrd it can either
> cause the system to not boot, or just corrupt one of the files in the
> initrd.
> 
> The fix is simply to make the key value relative to the jump_entry
> struct in the ARCH_STATIC_BRANCH macro.
> 
> Fixes: b0b3b2c78ec0 ("powerpc: Switch to relative jump labels")
> Reported-by: Anastasia Kovaleva <a.kovaleva@yadro.com>
> Reported-by: Roman Bolshakov <r.bolshakov@yadro.com>
> Reported-by: Greg Kurz <groug@kaod.org>
> Reported-by: Daniel Axtens <dja@axtens.net>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/jump_label.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/jump_label.h b/arch/powerpc/include/asm/jump_label.h
> index 2d5c6bec2b4f..93ce3ec25387 100644
> --- a/arch/powerpc/include/asm/jump_label.h
> +++ b/arch/powerpc/include/asm/jump_label.h
> @@ -50,7 +50,7 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
>  1098:	nop;					\
>  	.pushsection __jump_table, "aw";	\
>  	.long 1098b - ., LABEL - .;		\
> -	FTR_ENTRY_LONG KEY;			\
> +	FTR_ENTRY_LONG KEY - .;			\
>  	.popsection
>  #endif
>  
> -- 
> 2.25.1
> 

Thanks for fixing the issue, Michael.

Perhaps the fix should go to v5.13-rc7 if Linus plans to do it. It'd be
good to avoid broken initrd on pseries guests in the release.

Regards,
Roman
