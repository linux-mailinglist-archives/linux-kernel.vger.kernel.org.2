Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71CC439F8FE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 16:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbhFHO0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 10:26:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30056 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233339AbhFHO0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 10:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623162289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tEi3Rd6QEWk4RIuQqPyKGWZpdRlhfTcltszbR5N5ITU=;
        b=Bt10VUzTt0d6wyTm0XjppoNvjzup2ivj40LKStfjODzYyPkcZYk6+ilt69KRbF4hQiDTcx
        IEHBCDE9SLilgno0VBk7WncD/s4Mp6+wWwIiAW70ZR6vzQm5DT2fyEzbWUMeY9/7qmB6p7
        Vy6lE8E4inDkNqwnCv0/JpfrrcRFip0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-d84TgJEiNruct7uiXptoiA-1; Tue, 08 Jun 2021 10:24:47 -0400
X-MC-Unique: d84TgJEiNruct7uiXptoiA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A5208049CB;
        Tue,  8 Jun 2021 14:24:44 +0000 (UTC)
Received: from localhost (ovpn-12-148.pek2.redhat.com [10.72.12.148])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4704F19C45;
        Tue,  8 Jun 2021 14:24:35 +0000 (UTC)
Date:   Tue, 8 Jun 2021 22:24:32 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        akpm@linux-foundation.org, Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        Dave Young <dyoung@redhat.com>, Boris Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dave Anderson <anderson@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] crash_core, vmcoreinfo: Append 'SECTION_SIZE_BITS' to
 vmcoreinfo
Message-ID: <20210608142432.GA587883@MiWiFi-R3L-srv>
References: <20210608103359.84907-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608103359.84907-1-kernelfans@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/21 at 06:33am, Pingfan Liu wrote:
> As mentioned in kernel commit 1d50e5d0c505 ("crash_core, vmcoreinfo:
> Append 'MAX_PHYSMEM_BITS' to vmcoreinfo"), SECTION_SIZE_BITS in the
> formula:
>     #define SECTIONS_SHIFT    (MAX_PHYSMEM_BITS - SECTION_SIZE_BITS)
> 
> Besides SECTIONS_SHIFT, SECTION_SIZE_BITS is also used to calculate
> PAGES_PER_SECTION in makedumpfile just like kernel.
> 
> Unfortunately, this arch-dependent macro SECTION_SIZE_BITS changes, e.g.
> recently in kernel commit f0b13ee23241 ("arm64/sparsemem: reduce
> SECTION_SIZE_BITS"). But user space wants a stable interface to get this
> info. Such info is impossible to be deduced from a crashdump vmcore.
> Hence append SECTION_SIZE_BITS to vmcoreinfo.

> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Boris Petkov <bp@alien8.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: James Morse <james.morse@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Dave Anderson <anderson@redhat.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> Cc: kexec@lists.infradead.org
> Cc: x86@kernel.org
> Cc: linux-arm-kernel@lists.infradead.org


Add the discussion of the original thread in kexec ML for reference:
http://lists.infradead.org/pipermail/kexec/2021-June/022676.html

This looks good to me.

Acked-by: Baoquan He <bhe@redhat.com>

> ---
>  kernel/crash_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 825284baaf46..684a6061a13a 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -464,6 +464,7 @@ static int __init crash_save_vmcoreinfo_init(void)
>  	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
>  	VMCOREINFO_STRUCT_SIZE(mem_section);
>  	VMCOREINFO_OFFSET(mem_section, section_mem_map);
> +	VMCOREINFO_NUMBER(SECTION_SIZE_BITS);
>  	VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);
>  #endif
>  	VMCOREINFO_STRUCT_SIZE(page);
> -- 
> 2.29.2
> 

