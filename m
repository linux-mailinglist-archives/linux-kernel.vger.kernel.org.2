Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6451396FFA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 11:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbhFAJKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 05:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbhFAJKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 05:10:52 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F590C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 02:09:10 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l11-20020a05600c4f0bb029017a7cd488f5so1465278wmq.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 02:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cogrqpMO2J9JqAskl52Gu23TLnaCRQ+8Xx3+aypgheg=;
        b=MMDsPYHjJwBRYP+otgtP7X0vz5xo/Amw6qPSoDxysEJjjNQ/Sio5IAA3widyH/SuVl
         7mOsrAV14f9UeRsj7YvpKRm7BwcEGzoDKWXMOLf5vS0nOIcLHOEA/BZMZSjp3fV0t26F
         9R3hHQ1Uw8xruVzihnM3iXyjHPsRa2p4EWPeJgceu03E4xS6i6+WmYqgsaqSJqewDLbI
         ft9FqHI94KR4eAO3TrxZ6fXASy3fpC+JoYsOoQCVkvGO1a6BHnzO4lNbZc56eXXmXcTg
         IkGYP3eApkaBt9KopM404O6sXKcq8C2D1OVLbRISYoVop+djpgA4lograUrIjgiLHcLl
         pgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cogrqpMO2J9JqAskl52Gu23TLnaCRQ+8Xx3+aypgheg=;
        b=QeRrmi7jTX0vR1zNWrjisBnS4KgHVr9lP0xptDvwkdutKN46P3ZjIoByTEqlv/57Np
         ozXXC09tUBu8lTx0tmAIDEVOxWVZZ2vK7GLY7znrujWs/O5lOEtvxexX5fGCq+OziNHN
         Hqe0zy3hGIbXLEsepeO4fQzOKwYbmsX7P4HUk2G3ZUmq0AFxrP/BDKhhY+eHptapFCIb
         jAWMTD3prsc6RJQMFMw19HkeW1jrLvYe9+gtVoDxbRrBM+bmq8iqfxzIZEMLLwWPs7ss
         seOztMtQAvybRdzT0sTqxmfyHeTrCQCNgoNjTOZRT1om+LujjlcwpWyUPkrLV+8obs83
         yScw==
X-Gm-Message-State: AOAM531Y0WNrfSLrlMNz07r+lmW27USm+4s2UDAuTdcnFYCFzSV7V9qn
        sJ20Tx8k6v6eD0FU6+vYttg+kw==
X-Google-Smtp-Source: ABdhPJy5DtM3mvIxzxrbLn1wFfvzclK4+U3jAUojy7Wa+E/UkenjNbNMMH9I4SuMkXTNu3yUUdlfIQ==
X-Received: by 2002:a05:600c:4f48:: with SMTP id m8mr3549847wmq.169.1622538549016;
        Tue, 01 Jun 2021 02:09:09 -0700 (PDT)
Received: from dell ([91.110.221.249])
        by smtp.gmail.com with ESMTPSA id c7sm2507072wrs.23.2021.06.01.02.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 02:09:08 -0700 (PDT)
Date:   Tue, 1 Jun 2021 10:09:07 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Moriis Ku <saumah@gmail.com>
Cc:     linux-kernel@vger.kernel.org, jason_lee@sunix.com,
        taian.chen@sunix.com
Subject: Re: [PATCH] mfd:Add supprt for SUNIX mfd & PCIe driver
Message-ID: <20210601090907.GA543307@dell>
References: <20210528095814.6939-1-saumah@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210528095814.6939-1-saumah@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 May 2021, Moriis Ku wrote:

> From: Morris Ku <saumah@gmail.com>
> 
> Add support for SUNIX mfd & PCIe driver

That's a pretty broad description.


> Cc: Jason Lee <jason_lee@sunix.com>
> Cc: Taian Chen <taian.chen@sunix.com>
> Signed-off-by: Morris Ku <saumah@gmail.com>
> ---
>  Kconfig  | 12 ++++++++++++
>  Makefile |  4 ++++
>  2 files changed, 16 insertions(+)

Patches should be generated from the root of the source directory.

> diff --git a/Kconfig b/Kconfig
> index 17d0ad2..25b7db5 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -2012,6 +2012,18 @@ config RAVE_SP_CORE
>  	  Select this to get support for the Supervisory Processor
>  	  device found on several devices in RAVE line of hardware.
>  
> +config MFD_SUNIX_SDC
> +	tristate
> +	select MFD_CORE
> +	select SERIAL_8250_SDC
> +
> +config MFD_SUNIX_SDC_PCI
> +	tristate "SUNIX SDC PCIe multi-function board support"

What is SDC?

> +	select MFD_SUNIX_SDC
> +	depends on X86 && PCI
> +	help
> +	  Selecting this option will add support for SUNIX SDC PCIe
> +	  multi-function board.

More please.

>  endmenu
>  endif
> diff --git a/Makefile b/Makefile
> index a1872e4..52fa8be 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -256,4 +256,8 @@ obj-$(CONFIG_MFD_ROHM_BD70528)	+= rohm-bd70528.o
>  obj-$(CONFIG_MFD_ROHM_BD718XX)	+= rohm-bd718x7.o
>  obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
>  
> +obj-$(CONFIG_MFD_SUNIX_SDC)		+= sdc_mfd.o

There is no such thing as MFD.

You probably mean 'core'.

> +obj-$(CONFIG_MFD_SUNIX_SDC_PCI)	+= sdc_pci.o
> +
> +

No need for 2 empty spaces.

This patch doesn't actually do anything.

Please submit it squashed into the driver.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
