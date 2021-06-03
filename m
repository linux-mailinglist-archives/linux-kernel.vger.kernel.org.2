Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7EA39A68D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 19:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhFCRCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 13:02:08 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:14324 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhFCRCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 13:02:08 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622739623; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=/pHlYIqIuh+eZ1QKQJtdnJ5xmRU/hum2lRn0qX6Gm0U=; b=qj3OaMC7RW5Wz1Vj7onovszXRIYtwn1RtR4SPgl/gjbHqopZdoRqgI/sxxwwweA/YlYBW0Wa
 tUTFZr/t0SKyH8qL6TuHlR+2k2fRV0a6Sf7/IzjcEWVLp8ZZVCZ0TqFd7jl8NpnVXkvoA1x2
 Oo0SOlB9+0R+PIPOTnA5/W/TRGM=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 60b90a8fe27c0cc77fe313eb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 03 Jun 2021 16:59:59
 GMT
Sender: bcain=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D7C9FC4323A; Thu,  3 Jun 2021 16:59:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from BCAIN (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bcain)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B4F76C4338A;
        Thu,  3 Jun 2021 16:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B4F76C4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=bcain@codeaurora.org
Reply-To: <bcain@codeaurora.org>
From:   "Brian Cain" <bcain@codeaurora.org>
To:     "'Nathan Chancellor'" <nathan@kernel.org>,
        "'Andrew Morton'" <akpm@linux-foundation.org>
Cc:     "'Nick Desaulniers'" <ndesaulniers@google.com>,
        <linux-hexagon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <clang-built-linux@googlegroups.com>
References: <20210521011239.1332345-1-nathan@kernel.org> <20210521011239.1332345-3-nathan@kernel.org>
In-Reply-To: <20210521011239.1332345-3-nathan@kernel.org>
Subject: RE: [PATCH 2/3] hexagon: Use common DISCARDS macro
Date:   Thu, 3 Jun 2021 11:59:57 -0500
Message-ID: <09a801d75899$e24c97f0$a6e5c7d0$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQImhg45Cwtn7gWc92+5nwbl9gAFPwIEvSIiqlQBjtA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Nathan Chancellor <nathan@kernel.org>
> Sent: Thursday, May 20, 2021 8:13 PM
> To: Brian Cain <bcain@codeaurora.org>; Andrew Morton <akpm@linux-
> foundation.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>; linux-
> hexagon@vger.kernel.org; linux-kernel@vger.kernel.org; clang-built-
> linux@googlegroups.com; Nathan Chancellor <nathan@kernel.org>
> Subject: [PATCH 2/3] hexagon: Use common DISCARDS macro
> 
> ld.lld warns that the '.modinfo' section is not currently handled:
> 
> ld.lld: warning: kernel/built-in.a(workqueue.o):(.modinfo) is being placed
in
> '.modinfo'
> ld.lld: warning: kernel/built-in.a(printk/printk.o):(.modinfo) is being
placed in
> '.modinfo'
> ld.lld: warning: kernel/built-in.a(irq/spurious.o):(.modinfo) is being
placed in
> '.modinfo'
> ld.lld: warning: kernel/built-in.a(rcu/update.o):(.modinfo) is being
placed in
> '.modinfo'
> 
> The '.modinfo' section was added in commit 898490c010b5 ("moduleparam:
> Save information about built-in modules in separate file") to the
> DISCARDS macro but Hexagon has never used that macro. The unification of
> DISCARDS happened in commit 023bf6f1b8bf ("linker script: unify usage of
> discard definition") in 2009, prior to Hexagon being added in 2011.
> 
> Switch Hexagon over to the DISCARDS macro so that anything that is
> expected to be discarded gets discarded.
> 
> Fixes: e95bf452a9e2 ("Hexagon: Add configuration and makefiles for the
> Hexagon architecture.")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/hexagon/kernel/vmlinux.lds.S | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/arch/hexagon/kernel/vmlinux.lds.S
> b/arch/hexagon/kernel/vmlinux.lds.S
> index 20f19539c5fc..57465bff1fe4 100644
> --- a/arch/hexagon/kernel/vmlinux.lds.S
> +++ b/arch/hexagon/kernel/vmlinux.lds.S
> @@ -61,14 +61,9 @@ SECTIONS
> 
>  	_end = .;
> 
> -	/DISCARD/ : {
> -		EXIT_TEXT
> -		EXIT_DATA
> -		EXIT_CALL
> -	}
> -
>  	STABS_DEBUG
>  	DWARF_DEBUG
>  	ELF_DETAILS
> 
> +	DISCARDS
>  }
> --
> 2.32.0.rc0

Acked-by: Brian Cain <bcain@codeaurora.org>

