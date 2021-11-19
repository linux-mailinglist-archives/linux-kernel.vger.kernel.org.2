Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A63D457762
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 20:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbhKST7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 14:59:47 -0500
Received: from mailscanner01.zoner.fi ([84.34.166.10]:57778 "EHLO
        mailscanner01.zoner.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhKST7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 14:59:46 -0500
X-Greylist: delayed 585 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Nov 2021 14:59:46 EST
Received: from www25.zoner.fi (www25.zoner.fi [84.34.147.45])
        by mailscanner01.zoner.fi (Postfix) with ESMTPS id 0C6B3414F8;
        Fri, 19 Nov 2021 21:46:57 +0200 (EET)
Received: from mail.zoner.fi ([84.34.147.244])
        by www25.zoner.fi with esmtp (Exim 4.94.2)
        (envelope-from <lasse.collin@tukaani.org>)
        id 1mo9qa-0001Yw-UW; Fri, 19 Nov 2021 21:46:56 +0200
Date:   Fri, 19 Nov 2021 21:46:47 +0200
From:   Lasse Collin <lasse.collin@tukaani.org>
To:     Jubin Zhong <zhongjubin@huawei.com>
Cc:     <akpm@linux-foundation.org>, <wangfangpeng1@huawei.com>,
        <liaohua4@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kbuild: Enable armthumb BCJ filter for Thumb-2 kernel
Message-ID: <20211119214647.12932e5c@kaneli>
In-Reply-To: <1637323647-19988-1-git-send-email-zhongjubin@huawei.com>
References: <1637323647-19988-1-git-send-email-zhongjubin@huawei.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-19 Jubin Zhong wrote:
> xz_wrap.sh use $SRCARCH to detect the BCJ filter. However, assigning
> arm BCJ filter to Thumb-2 kernel is not optimal. In my case, about 5%
> decrease of image size is observed with armthumb BCJ filter:
> 
> Test results:
>   hardware:      QEMU emulator version 3.1.0
>   config:        vexpress_defconfig with THUMB2_KERNEL & KERNEL_XZ on
>   arm BCJ:       4029808
>   armthumb BCJ:  3827280
> 
> Choose armthumb BCJ filter for Thumb-2 kernel to make smaller images.

I didn't test the patch but it looks reasonable to me. Below are a small
optimization idea and two very minor style suggestions.

> --- a/lib/decompress_unxz.c
> +++ b/lib/decompress_unxz.c
> @@ -131,6 +131,9 @@
>  #ifdef CONFIG_ARM
>  #	define XZ_DEC_ARM
>  #endif
> +#ifdef CONFIG_THUMB2_KERNEL
> +#	define XZ_DEC_ARMTHUMB
> +#endif
>  #ifdef CONFIG_IA64
>  #	define XZ_DEC_IA64
>  #endif

If a Thumb-2 kernel will always use the ARM-Thumb BCJ filter, one can
save a few bytes from the pre-boot code by omitting the ARM BCJ filter:

--- a/lib/decompress_unxz.c
+++ b/lib/decompress_unxz.c
@@ -129,7 +129,11 @@
 #	define XZ_DEC_POWERPC
 #endif
 #ifdef CONFIG_ARM
-#	define XZ_DEC_ARM
+#	ifdef CONFIG_THUMB2_KERNEL
+#		define XZ_DEC_ARMTHUMB
+#	else
+#		define XZ_DEC_ARM
+#	endif
 #endif
 #ifdef CONFIG_IA64
 #	define XZ_DEC_IA64

> --- a/scripts/xz_wrap.sh
> +++ b/scripts/xz_wrap.sh
> @@ -8,6 +8,7 @@
>  # This file has been put into the public domain.
>  # You can do whatever you want with this file.
>  #
> +. include/config/auto.conf

I suggest adding an empty line before this new line so that it is
clearly separated from the header comment.

> +if [ -n "${CONFIG_THUMB2_KERNEL}" ];then

I suggest adding a space after the semi-colon: ]; then

With or without the above modifications:

Acked-by: Lasse Collin <lasse.collin@tukaani.org>

-- 
Lasse Collin
