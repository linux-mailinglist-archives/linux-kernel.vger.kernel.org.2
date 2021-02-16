Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F3C31D051
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 19:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhBPSiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 13:38:55 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:33738 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhBPSiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 13:38:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1613500732; x=1645036732;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LAtb7q8KeF6V0S8qBZ40P6liWm7mLq7atnaYX/bcDfc=;
  b=JekclQJlix2CrcNDISJzbbCE29DY6LAa8r6Lu31nvjnnBoLIXqIcwkBQ
   3467qRVgHNRiL4e/mpwWQ9Euufy82ZBSf7uTV/G1lDh23fqONTsNrgMsB
   B2uU4MDZPaSZRQVMl0D+nM11dnfG5ErwrzqYsaxNfLlJrlHWWyN+XJ059
   M=;
X-IronPort-AV: E=Sophos;i="5.81,184,1610409600"; 
   d="scan'208";a="88167432"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 16 Feb 2021 18:38:11 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com (Postfix) with ESMTPS id E4398281E99;
        Tue, 16 Feb 2021 18:38:09 +0000 (UTC)
Received: from EX13D13UWB002.ant.amazon.com (10.43.161.21) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 16 Feb 2021 18:38:09 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D13UWB002.ant.amazon.com (10.43.161.21) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 16 Feb 2021 18:38:09 +0000
Received: from dev-dsk-shaoyi-2b-c0ca772a.us-west-2.amazon.com (172.22.152.76)
 by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 16 Feb 2021 18:38:08 +0000
Received: by dev-dsk-shaoyi-2b-c0ca772a.us-west-2.amazon.com (Postfix, from userid 13116433)
        id 1A94445897; Tue, 16 Feb 2021 18:38:08 +0000 (UTC)
Date:   Tue, 16 Feb 2021 18:38:08 +0000
From:   Shaoying Xu <shaoyi@amazon.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <fllinden@amazon.com>,
        <benh@amazon.com>, <shaoyi@amazon.com>
Subject: Re: [PATCH] arm64 module: set plt* section addresses to 0x0
Message-ID: <20210216183808.GA24095@amazon.com>
References: <20210216183234.GA23876@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210216183234.GA23876@amazon.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So sorry about the double send because I forgot to cc the lists. Please just
ignore the first one. Thank you! 

On Tue, Feb 16, 2021 at 06:32:34PM +0000, Shaoying Xu wrote:
> These plt* and .text.ftrace_trampoline sections specified for arm64 have 
> non-zero addressses. Non-zero section addresses in a relocatable ELF would 
> confuse GDB when it tries to compute the section offsets and it ends up 
> printing wrong symbol addresses. Therefore, set them to zero, which mirrors 
> the change in commit 5d8591bc0fba ("module: set ksymtab/kcrctab* section 
> addresses to 0x0").
> 
> Reported-by: Frank van der Linden <fllinden@amazon.com>
> Signed-off-by: Shaoying Xu <shaoyi@amazon.com>
> Cc: stable@vger.kernel.org
> ---
>  arch/arm64/include/asm/module.lds.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/module.lds.h b/arch/arm64/include/asm/module.lds.h
> index 691f15af788e..810045628c66 100644
> --- a/arch/arm64/include/asm/module.lds.h
> +++ b/arch/arm64/include/asm/module.lds.h
> @@ -1,7 +1,7 @@
>  #ifdef CONFIG_ARM64_MODULE_PLTS
>  SECTIONS {
> -	.plt (NOLOAD) : { BYTE(0) }
> -	.init.plt (NOLOAD) : { BYTE(0) }
> -	.text.ftrace_trampoline (NOLOAD) : { BYTE(0) }
> +	.plt 0 (NOLOAD) : { BYTE(0) }
> +	.init.plt 0 (NOLOAD) : { BYTE(0) }
> +	.text.ftrace_trampoline 0 (NOLOAD) : { BYTE(0) }
>  }
>  #endif
> -- 
> 2.16.6
> 
