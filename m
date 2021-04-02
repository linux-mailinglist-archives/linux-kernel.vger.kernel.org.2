Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA12352B1C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 15:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbhDBNqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 09:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235307AbhDBNqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 09:46:01 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7ED2C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 06:45:58 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id k25so4997849oic.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 06:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=ADNosmB7KqYRCGME6xSqXcXbOymz1SCXHTBXbg7niS0=;
        b=NB8vLhzIbb5iqa4PaD/2cCkxUYSLlZ/gObM+9XAbLTnK2ujaEMV/lZoRiG62bpwU9X
         Oj8xvWweuAjLIgpglsHVtdMu25RLNubcvr3iVj1bh+WUTcayG15+gRXj28cWlXuYnc9Q
         UfCjEQ/3LOmwhPLCZcPj5OeMnYA87c7zFAQTYADvI8+FZyKSDEf/laKkPiU0j3r9cBEn
         MQfrR69kcycazMF+QzsMTU8RpU7bmNFm8GAgt2I/15BVSDAuOVflUntbZGHu15WkIv9F
         PVtXdNIJLmVO08+AwzmnVxqXF3zaSvJGJvkPdCkNkb/rB0K7H4TC3QlpS7JY1QoTRvS7
         LZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=ADNosmB7KqYRCGME6xSqXcXbOymz1SCXHTBXbg7niS0=;
        b=dMMaJpZC1K93gM/IVGfiutntrRDcHcKSXAqoGH98FB0KGeluRW2i7mc/oeF3InTa3j
         Xv4uH8UTDr16CspUpexe8GRwxDm70HHsWkkO9KvOAZSdcKDsycwfi0Z3Xw7yDkiKyytL
         zrCXg1A0lZyCHBbbF0N9bSiGoqq9n5Yn7PoNyDrK4ZdB5+D4QIzv2w/X9MmvxDl1jeVy
         tYCYGCQS1UP1gl/ZOTEpzrYWvvzoP8TfbsZleKtXt6WIT9qzFOK811Anox337nCx4E7g
         6N54ReagdbxbOhCfo0WrQ7pLQ1p6JcIyJi1aCe6IFRck4EK/2p0V/kNIyikYIuTCOxat
         BcZQ==
X-Gm-Message-State: AOAM530kNuBu1kN1pbSftXHfOHK+ivMj4bvb3l64OPs1P3EOw1wqby+k
        pXWtnZg+Flsikjsd04sECNeBUut7WL/d
X-Google-Smtp-Source: ABdhPJy5x6lVCyoXhsF3MC6WUGa30ePxVN63d+FDsLnKibf7aDKgFTI00f4/E4t2Li1pAuRB+NPfLA==
X-Received: by 2002:aca:2106:: with SMTP id 6mr9858857oiz.150.1617371158022;
        Fri, 02 Apr 2021 06:45:58 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id n6sm1747174oop.48.2021.04.02.06.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 06:45:57 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:f99f:823a:495e:5af])
        by serve.minyard.net (Postfix) with ESMTPSA id 4F029180570;
        Fri,  2 Apr 2021 13:45:56 +0000 (UTC)
Date:   Fri, 2 Apr 2021 08:45:55 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Corey Minyard <cminyard@mvista.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 03/10] ipmi_si: Utilize temporary variable to hold
 device pointer
Message-ID: <20210402134555.GR507977@minyard.net>
Reply-To: minyard@acm.org
References: <20210330181649.66496-1-andriy.shevchenko@linux.intel.com>
 <20210330181649.66496-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330181649.66496-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 09:16:42PM +0300, Andy Shevchenko wrote:
> By one of the previous clean up change we got a temporary variable to hold
> a device pointer. It can be utilized in other calls in the ->probe() and
> save a bit of LOCs.

The description here isn't accurate, there is no previous change where a
temporary variable comes in.  This change adds the temporary variable.

This change is ok, but doesn't add much value.

-corey

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/char/ipmi/ipmi_si_platform.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_si_platform.c b/drivers/char/ipmi/ipmi_si_platform.c
> index 009563073d30..954c297b459b 100644
> --- a/drivers/char/ipmi/ipmi_si_platform.c
> +++ b/drivers/char/ipmi/ipmi_si_platform.c
> @@ -309,6 +309,7 @@ static int find_slave_address(struct si_sm_io *io, int slave_addr)
>  
>  static int acpi_ipmi_probe(struct platform_device *pdev)
>  {
> +	struct device *dev = &pdev->dev;
>  	struct si_sm_io io;
>  	acpi_handle handle;
>  	acpi_status status;
> @@ -318,21 +319,20 @@ static int acpi_ipmi_probe(struct platform_device *pdev)
>  	if (!si_tryacpi)
>  		return -ENODEV;
>  
> -	handle = ACPI_HANDLE(&pdev->dev);
> +	handle = ACPI_HANDLE(dev);
>  	if (!handle)
>  		return -ENODEV;
>  
>  	memset(&io, 0, sizeof(io));
>  	io.addr_source = SI_ACPI;
> -	dev_info(&pdev->dev, "probing via ACPI\n");
> +	dev_info(dev, "probing via ACPI\n");
>  
>  	io.addr_info.acpi_info.acpi_handle = handle;
>  
>  	/* _IFT tells us the interface type: KCS, BT, etc */
>  	status = acpi_evaluate_integer(handle, "_IFT", NULL, &tmp);
>  	if (ACPI_FAILURE(status)) {
> -		dev_err(&pdev->dev,
> -			"Could not find ACPI IPMI interface type\n");
> +		dev_err(dev, "Could not find ACPI IPMI interface type\n");
>  		return -EINVAL;
>  	}
>  
> @@ -349,10 +349,11 @@ static int acpi_ipmi_probe(struct platform_device *pdev)
>  	case 4: /* SSIF, just ignore */
>  		return -ENODEV;
>  	default:
> -		dev_info(&pdev->dev, "unknown IPMI type %lld\n", tmp);
> +		dev_info(dev, "unknown IPMI type %lld\n", tmp);
>  		return -EINVAL;
>  	}
>  
> +	io.dev = dev;
>  	io.regsize = DEFAULT_REGSIZE;
>  	io.regshift = 0;
>  
> @@ -376,9 +377,7 @@ static int acpi_ipmi_probe(struct platform_device *pdev)
>  
>  	io.slave_addr = find_slave_address(&io, io.slave_addr);
>  
> -	io.dev = &pdev->dev;
> -
> -	dev_info(io.dev, "%pR regsize %d spacing %d irq %d\n",
> +	dev_info(dev, "%pR regsize %d spacing %d irq %d\n",
>  		 res, io.regsize, io.regspacing, io.irq);
>  
>  	request_module("acpi_ipmi");
> -- 
> 2.30.2
> 
