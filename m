Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F513F19F9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 15:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbhHSNHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 09:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbhHSNHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 09:07:06 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557C5C061756
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 06:06:30 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id j187so5439380pfg.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 06:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZUuW6CkvogNC0GIMX+IQPONt7G2cLV90jQ7k/cU6WLo=;
        b=tf/HLOQY/32g5RxLsMgCbrCbZDkzKVH4iF2ZSAmdbBGISvFXk9vHoSL1dg+SMbm6DU
         K9N466tC0ovKSLD5KJUcWVpfkJLxtbwo+YRofnPuoJmXRYYMMsq4SBMaUltyo1CuQQpl
         mcrDXXXbp4YABMQIGyEoWivERBzrMDTZ5BguFUgUz4HS/cbshGswy45BDPPCs22wDTLp
         NsCMUe1NXh/npYtCMmJdNRs3xjVMx0yODbOwA7p7VMiIGhmJ+4ICdfqf8J4ZCsNTA7mB
         Hdw7Cf8Gapq8zasc/36S79LXnK/9TgBtVg8TWswH4MbTMiobLZ3ed84BRCkOC3IaCbDu
         nwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZUuW6CkvogNC0GIMX+IQPONt7G2cLV90jQ7k/cU6WLo=;
        b=s7jW80ThjZQFraooGiC6GW1p+VUgcTUWNA2D1Kc8YIoYcFbIJE27Bn75WT30juR2lE
         JXI/sdEle4c8XRgfHfn2J1rizPy5yKcZihO4AZU8AYstYzWBno2bJgoUhyhw4j4CaHLt
         znh4cp5lv9F/CzC1Q+x2aJOB8i5nWHYPQfzz8MoTFJq8jR9raDEtMytOK7q37oVW4ELN
         OarTWjhrJdr0m989T7uXtcxJYXiflvZkMIdnXNM9gk4OWw+bKWTO+adYldhfBqtyUPAV
         HOaB4Zf7t8dztqQO3Fr4pWvAEWoWTDcp92e9V3WzwXjqJKlwz5iTy4TS74mNzG4Lx6b7
         b8Ww==
X-Gm-Message-State: AOAM532XZXN2X/Bhb7M85z1MpEK6Fvw2eRP6J35oyn6r0CQjVfZnefw7
        /TZOzZzvBNjz/OeJl0tlSu4F
X-Google-Smtp-Source: ABdhPJx0Esfl/ZnW3okg0FVANmoc2rkKbzXPAvQstEHgv6gVgEP8FpM2X783udwvgLVHUTym9ud0Uw==
X-Received: by 2002:a63:510a:: with SMTP id f10mr14064796pgb.249.1629378389545;
        Thu, 19 Aug 2021 06:06:29 -0700 (PDT)
Received: from thinkpad ([2409:4072:6298:4497:5a1e:ff34:9091:5bac])
        by smtp.gmail.com with ESMTPSA id oj2sm2944717pjb.33.2021.08.19.06.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 06:06:29 -0700 (PDT)
Date:   Thu, 19 Aug 2021 18:36:23 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        smohanad@codeaurora.org
Subject: Re: [PATCH 0/5] PCI: endpoint: Add support for additional notifiers
Message-ID: <20210819130623.GB200135@thinkpad>
References: <20210616115913.138778-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616115913.138778-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 05:29:08PM +0530, Manivannan Sadhasivam wrote:
> Hello,
> 
> This series adds support for additional notifiers in the PCI endpoint
> framework. The notifiers LINK_DOWN, BME, PME, and D_STATE are generic
> for all PCI endpoints but there is also a custom notifier (CUSTOM) added
> to pass the device/vendor specific events to EPF from EPC.
> 
> The example usage of all notifiers is provided in the commit description.
> 

Ping on this series!

Thanks,
Mani

> Thanks,
> Mani
> 
> Manivannan Sadhasivam (5):
>   PCI: endpoint: Add linkdown notifier support
>   PCI: endpoint: Add BME notifier support
>   PCI: endpoint: Add PME notifier support
>   PCI: endpoint: Add D_STATE notifier support
>   PCI: endpoint: Add custom notifier support
> 
>  drivers/pci/endpoint/pci-epc-core.c | 89 +++++++++++++++++++++++++++++
>  include/linux/pci-epc.h             |  5 ++
>  include/linux/pci-epf.h             |  5 ++
>  3 files changed, 99 insertions(+)
> 
> -- 
> 2.25.1
> 
