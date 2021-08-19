Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78CFA3F1B86
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 16:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240421AbhHSOXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 10:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239252AbhHSOXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 10:23:00 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B03DC061756
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 07:22:24 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id m24-20020a17090a7f98b0290178b1a81700so4867304pjl.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 07:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=78xOaLYOlWGNuqYKX8nJ/razzvdH0eYMQ7PneXUBfCY=;
        b=dbVDI1nlDwGzV0OEvCPALB2HivKy0lvO/YXdyT8JmDytW0hOnL3jHj9F2muK4uacRd
         1uXQMriFlLGmJBef39j1FUwxIW+Z8SAQlFQSkJBMi8uxm4TklgD688N4nkwtIyghuO7C
         AstCXkRX4vvTf8cm3mDSZD4NaEekCEfmBNG2LvacHc6Xu/tQMbH4m1g+YkSIUsrZgdoG
         oQGql8YTn58LxS7N0CDGGJAOyfF7bD6eEiHopdhcc8zccv809nQirmGrGKmnvckj8xgO
         C/0Fy56+MUon8vGkDmqYQJltFmlKeIzLJMF5HDFwFhM5/u3MNh4YF8IciuQEAJCO0Pft
         8UpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=78xOaLYOlWGNuqYKX8nJ/razzvdH0eYMQ7PneXUBfCY=;
        b=afw24+D+6zAAwwK3NVHjDlow77rqMEdCkSleCJohabY2W1XhSN2LqauTXUaBAJPrVr
         vnPqew9ThAAKXRPTAH8rDDFZP53H6AyLU3Ub/tkPwTM7WKSPpGhIoUgWryCW07GfxDvR
         lO/Ns9JX2FR+TEuQnvIsgnhXli02imREa+rALd1kfbpbinsHgyuK8fP1S96EowlK4Wu8
         0WVLDoO8j3PNZFOH+FTWxXXXAAILnMSiKHJQQRUrGr+BIoUOrJva0ijwBWa2fhGvm1ZA
         yLksHjRcMDcT0sfCBvIsWCuM5ZckTsBz4nPg5WINd/tUMkF1hJZZD/Trq71ERbZnFbi+
         uz9g==
X-Gm-Message-State: AOAM533Eofbt3NoqTzHI6dMCey87Ll+hHYPV7t2tYrwzMmydov0a71N0
        MQXY9xOBgjt3jhNMFJWi+QR1
X-Google-Smtp-Source: ABdhPJxorLBc7/gHMqJ2HYnYUAdZ/SuDPgf4Z3jFcOJTcP0BgdY/eDtahab4jECG5N3Cq/Bmvrb7OA==
X-Received: by 2002:a17:903:22c2:b0:12d:a7ad:aceb with SMTP id y2-20020a17090322c200b0012da7adacebmr12214602plg.33.1629382943667;
        Thu, 19 Aug 2021 07:22:23 -0700 (PDT)
Received: from thinkpad ([2409:4072:6298:4497:5a1e:ff34:9091:5bac])
        by smtp.gmail.com with ESMTPSA id e31sm3282655pjk.19.2021.08.19.07.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 07:22:23 -0700 (PDT)
Date:   Thu, 19 Aug 2021 19:52:17 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        smohanad@codeaurora.org
Subject: Re: [PATCH 0/5] PCI: endpoint: Add support for additional notifiers
Message-ID: <20210819142217.GC200135@thinkpad>
References: <20210616115913.138778-1-manivannan.sadhasivam@linaro.org>
 <ef957b1e-9350-c244-6cd7-fbb81ffc0f56@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef957b1e-9350-c244-6cd7-fbb81ffc0f56@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 07:45:06PM +0530, Kishon Vijay Abraham I wrote:
> Hi Manivannan,
> 
> On 16/06/21 5:29 pm, Manivannan Sadhasivam wrote:
> > Hello,
> > 
> > This series adds support for additional notifiers in the PCI endpoint
> > framework. The notifiers LINK_DOWN, BME, PME, and D_STATE are generic
> > for all PCI endpoints but there is also a custom notifier (CUSTOM) added
> > to pass the device/vendor specific events to EPF from EPC.
> > 
> > The example usage of all notifiers is provided in the commit description.
> 
> In my earlier comment I didn't mean you to provide example usage in
> commit description. Rather to be used in a existing endpoint controller
> driver and handled in endpoint function drivers. Otherwise no point in
> adding them to the upstream kernel.
> 

Oh, sorry then I must have misinterpreted your comments. I'll submit this series
along with the MHI stack that makes use of these notifiers.

Thanks,
Mani

> Thanks
> Kishon
> 
> > 
> > Thanks,
> > Mani
> > 
> > Manivannan Sadhasivam (5):
> >   PCI: endpoint: Add linkdown notifier support
> >   PCI: endpoint: Add BME notifier support
> >   PCI: endpoint: Add PME notifier support
> >   PCI: endpoint: Add D_STATE notifier support
> >   PCI: endpoint: Add custom notifier support
> > 
> >  drivers/pci/endpoint/pci-epc-core.c | 89 +++++++++++++++++++++++++++++
> >  include/linux/pci-epc.h             |  5 ++
> >  include/linux/pci-epf.h             |  5 ++
> >  3 files changed, 99 insertions(+)
> > 
