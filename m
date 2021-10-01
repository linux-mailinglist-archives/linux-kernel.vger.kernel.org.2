Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD88C41F4CE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 20:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355826AbhJASRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 14:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355790AbhJASRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 14:17:10 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D03C06128D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 11:14:16 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id w29so16789935wra.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 11:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=x2CF4O0ztcJ7IpcLT4aDPOmLVAYXmY1hmJHLrb8rfWQ=;
        b=FEuOwWyDjqVKygTrBpQQvAfdaTLx5CRNW/ekMVa8wivoJHug9cwrSvG7EdmEmCpDDH
         vbw/uL7XG30JpxfngASHEzQySGEAzva48SxqpgGLlPYpfBpY9BlOWijv1HVBszCrZnrf
         v+0843/P8Pd3W3Md7FNDK5ociKCkXBz0qGyJD8uokhywGXAMMLDDfYssz1mP8RQEFG4c
         zbFjEChJmNp+gpxiChOuG8zwXolQWR3p+w9Q5SnuTWRwOSum3ZOA+Lld0Nqf8JtupRi8
         nv/z4/kVhHAp8RfdPxIGLw1EnugNpkwIZnKtZDaFvp06ytspawCve4JKlD6eQx5hudCy
         hjCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=x2CF4O0ztcJ7IpcLT4aDPOmLVAYXmY1hmJHLrb8rfWQ=;
        b=tHfZA3yvIk4zIZKg8n07nIox/traJYJou/7Hl3WSyZuEScyYQailSUpRRzHM3VD4dP
         uW87l0IBXfOmsljPTDu6zS4g29lppssT8/uaxCwKgvaNx55QjarI2bPOcTATAxZkxkiD
         2I6YVsYi1cBbxOkiAw3JD3pCg9P3TiKR5hsrMA/LmaLGe2qFrAvWBwuyRAGFEI7+WmTj
         0e9UDhxsq75k9BCSly7J/UZE6V9TkNElsUMc/Uh2CyS4SDXiEkGzjDaKo0UUaj2VAKZt
         SvDF5tK021O76OF00VsA1JxLTo9Y/VeuH8wukzwZcABz54gk4LnWMEZ/WxDMt0vGodk9
         uFyw==
X-Gm-Message-State: AOAM531DMFZcPovgo+QNp+ZbXLIjh5na6MexPncOUBQ0KYhvVP0CwuMz
        la0Ku9fHdTQjRUXIvkoW2TRLUA==
X-Google-Smtp-Source: ABdhPJycRYtwlpTlxRWIiWX/qXwrSHy9TwZUVX+OrhhtuV5C7m1MNgwwqrnW8wqAA6Neck+dcODA4Q==
X-Received: by 2002:adf:fbd1:: with SMTP id d17mr14106256wrs.146.1633112054541;
        Fri, 01 Oct 2021 11:14:14 -0700 (PDT)
Received: from google.com ([95.148.6.233])
        by smtp.gmail.com with ESMTPSA id x21sm8469899wmc.14.2021.10.01.11.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 11:14:13 -0700 (PDT)
Date:   Fri, 1 Oct 2021 19:14:12 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Orlando Chamberlain <redecorating@protonmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: intel-lpss: Add support for MacBookPro16,2 UART
Message-ID: <YVdP9PwNrjmKxKac@google.com>
References: <20211001084905.4133-1-redecorating@protonmail.com>
 <YVbf9J3jgAmBY+ch@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YVbf9J3jgAmBY+ch@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Oct 2021, Andy Shevchenko wrote:

> On Fri, Oct 01, 2021 at 08:51:46AM +0000, Orlando Chamberlain wrote:
> 
> Thanks for your contribution! My comments below.
> 
> > The MacBookPro16,2 has a UART controller with pci id 8086:38a8. Added
> 
> PCI ID
> 
> > this device to the intel_lpss_pci driver. This allows access to its
> > Bluetooth controller.
> 
> > The name of this device is not known, however as it appears to only be
> > found on the one model (MacBookPro16,2), labelling it with that
> > model's name should be sufficient to identify it. (Unless some folks
> > from Intel know what to call it and what its section should be called.)
> 
> No need to put this paragraph into commit message (see below).
> 
> > Records here indicate that this device is only present on the one model:
> > https://linux-hardware.org/?id=pci:8086-38a8-8086-7270
> > 
> > Signed-off-by: Orlando Chamberlain <redecorating@protonmail.com>
> > ---
> >  drivers/mfd/intel-lpss-pci.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
> > index c54d19fb184c..e02bb7026520 100644
> > --- a/drivers/mfd/intel-lpss-pci.c
> > +++ b/drivers/mfd/intel-lpss-pci.c
> > @@ -253,6 +253,8 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
> >  	{ PCI_VDEVICE(INTEL, 0x34ea), (kernel_ulong_t)&bxt_i2c_info },
> >  	{ PCI_VDEVICE(INTEL, 0x34eb), (kernel_ulong_t)&bxt_i2c_info },
> >  	{ PCI_VDEVICE(INTEL, 0x34fb), (kernel_ulong_t)&spt_info },
> 
> > +	/* MacBookPro16,2 */
> 
> Use
> 
> 	/* ICL-N */
> 
> here.

Why is that?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
