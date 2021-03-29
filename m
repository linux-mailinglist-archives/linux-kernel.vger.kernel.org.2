Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C8B34D6DE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 20:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhC2SS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 14:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbhC2SS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 14:18:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E85C061574;
        Mon, 29 Mar 2021 11:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=bTIHTMUAkJkw0BJyN9SHCb13mzroPXcLVQ85NS5ula4=; b=bO5TdfffNiMSNU4XY+uWavCEd1
        dFMbjtbNrX4HPrtHEXZuCwYePrOgtIdoWMIKkPRcRjI0zrQSO86okD1lxk4kkTTS9+Gi3izDJ4dcZ
        tNF16E8wFeMXr0JoA5got9rnHnoILH5uYcP6rGB6HBAcR1blrTBS42biYs4qMGqz0isBdOlQkXVYJ
        ysG3sReuQtlfukiUYAFsk9i4VwmexIPej9d7BUdDNaqC1Ts+Ax7gLgqRbM64Iayb3XzNNAZ/BM8gc
        ZYDE4KV8BVY4wIHCAXv/UGP+0rslnjJTJi2tPHF6Z0/XDv3URbzPYmuzu0rKug/EmUan/SWeRco0q
        vvXNgu2g==;
Received: from [2601:1c0:6280:3f0::4557]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lQwT0-0011Gm-8P; Mon, 29 Mar 2021 18:18:23 +0000
Subject: Re: [PATCH] usb: dwc3: fix incorrect kernel-doc comment syntax in
 files
To:     Aditya Srivastava <yashsri421@gmail.com>, balbi@kernel.org
Cc:     lukas.bulwahn@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210329135108.27128-1-yashsri421@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <15c0a26f-851b-862c-a3ca-52989d428c89@infradead.org>
Date:   Mon, 29 Mar 2021 11:18:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210329135108.27128-1-yashsri421@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/21 6:51 AM, Aditya Srivastava wrote:
> The opening comment mark '/**' is used for highlighting the beginning of
> kernel-doc comments.
> There are certain files in drivers/usb/dwc3, which follow this syntax,
> but the content inside does not comply with kernel-doc.
> Such lines were probably not meant for kernel-doc parsing, but are parsed
> due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
> causes unexpected warnings from kernel-doc.
> 
> E.g., presence of kernel-doc like comment in drivers/usb/dwc3/io.h at
> header causes this warnings by kernel-doc:
> "warning: expecting prototype for h(). Prototype was for __DRIVERS_USB_DWC3_IO_H() instead"
> 
> Similarly for other files too.
> 
> Provide a simple fix by replacing such occurrences with general comment
> format, i.e. '/*', to prevent kernel-doc from parsing it.
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> * Applies perfectly on next-20210326
> 
>  drivers/usb/dwc3/debug.h         | 2 +-
>  drivers/usb/dwc3/debugfs.c       | 2 +-
>  drivers/usb/dwc3/dwc3-keystone.c | 2 +-
>  drivers/usb/dwc3/dwc3-pci.c      | 2 +-
>  drivers/usb/dwc3/io.h            | 2 +-
>  drivers/usb/dwc3/trace.c         | 2 +-
>  drivers/usb/dwc3/trace.h         | 2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
> index 8ab394942360..db231de46bb3 100644
> --- a/drivers/usb/dwc3/debug.h
> +++ b/drivers/usb/dwc3/debug.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -/**
> +/*
>   * debug.h - DesignWare USB3 DRD Controller Debug Header
>   *
>   * Copyright (C) 2010-2011 Texas Instruments Incorporated - https://www.ti.com
> diff --git a/drivers/usb/dwc3/debugfs.c b/drivers/usb/dwc3/debugfs.c
> index 5da4f6082d93..b0e3f434d219 100644
> --- a/drivers/usb/dwc3/debugfs.c
> +++ b/drivers/usb/dwc3/debugfs.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> -/**
> +/*
>   * debugfs.c - DesignWare USB3 DRD Controller DebugFS file
>   *
>   * Copyright (C) 2010-2011 Texas Instruments Incorporated - https://www.ti.com
> diff --git a/drivers/usb/dwc3/dwc3-keystone.c b/drivers/usb/dwc3/dwc3-keystone.c
> index 057056c0975e..1317959294e6 100644
> --- a/drivers/usb/dwc3/dwc3-keystone.c
> +++ b/drivers/usb/dwc3/dwc3-keystone.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> -/**
> +/*
>   * dwc3-keystone.c - Keystone Specific Glue layer
>   *
>   * Copyright (C) 2010-2013 Texas Instruments Incorporated - https://www.ti.com
> diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
> index 4c5c6972124a..4698c43af5ae 100644
> --- a/drivers/usb/dwc3/dwc3-pci.c
> +++ b/drivers/usb/dwc3/dwc3-pci.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> -/**
> +/*
>   * dwc3-pci.c - PCI Specific glue layer
>   *
>   * Copyright (C) 2010-2011 Texas Instruments Incorporated - https://www.ti.com
> diff --git a/drivers/usb/dwc3/io.h b/drivers/usb/dwc3/io.h
> index 76b73b116862..1e96ea339d48 100644
> --- a/drivers/usb/dwc3/io.h
> +++ b/drivers/usb/dwc3/io.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -/**
> +/*
>   * io.h - DesignWare USB3 DRD IO Header
>   *
>   * Copyright (C) 2010-2011 Texas Instruments Incorporated - https://www.ti.com
> diff --git a/drivers/usb/dwc3/trace.c b/drivers/usb/dwc3/trace.c
> index 1b45a9723eeb..088995885678 100644
> --- a/drivers/usb/dwc3/trace.c
> +++ b/drivers/usb/dwc3/trace.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> -/**
> +/*
>   * trace.c - DesignWare USB3 DRD Controller Trace Support
>   *
>   * Copyright (C) 2014 Texas Instruments Incorporated - https://www.ti.com
> diff --git a/drivers/usb/dwc3/trace.h b/drivers/usb/dwc3/trace.h
> index 97f4f1125a41..60883268adfc 100644
> --- a/drivers/usb/dwc3/trace.h
> +++ b/drivers/usb/dwc3/trace.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -/**
> +/*
>   * trace.h - DesignWare USB3 DRD Controller Trace Support
>   *
>   * Copyright (C) 2014 Texas Instruments Incorporated - https://www.ti.com
> 


-- 
~Randy

