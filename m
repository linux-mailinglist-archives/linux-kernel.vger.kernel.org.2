Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8353991D4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 19:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhFBRlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 13:41:46 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:37875 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhFBRlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 13:41:44 -0400
Received: by mail-wr1-f48.google.com with SMTP id q5so3139460wrs.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 10:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/02sy6oOViNbHHBaDZqQhDQMJN4Cdi+we0/yqFZJVNw=;
        b=qS3AVkpFkpnspfrdsD/ehcXaEiyjSswgJzpa5IhLCqCha28PWUn6TCa3e2XgapcpDg
         Ca6LBSSZeex3sWlJ8FbB/ofiEf5MJSf1tBsFj4WV2SwnxbiwbmQQnPg+BJNzzNZUTZAM
         h8f5Vf+ol1VPEpFoKxXtG156nbbw/9KdoReNmplwkM2hEO2Zs3kwCDEtxK2MU20XtoYu
         xH0PfUASUc3QpZlXLyl8vuT3gNLgs2FNCyHBbfONYZsMgNbaEe9jtHhiFNdYLtExOneW
         WDXisR+4EkJKk9lx69aVyfJc/r9VdD/XL0J97K6IeSEs3ZSKDm0FQ7BfXXRFSmieYCq5
         Lhrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/02sy6oOViNbHHBaDZqQhDQMJN4Cdi+we0/yqFZJVNw=;
        b=unHBQluP0cuktCokNVAzoMxqBcieynOIpjnSi9bnKlXCpnASjBSVUt8OSLJhSlkkyN
         UQIoRS16Xk+xEF/PNb2BE11Xbgl5EBP+1D2ShkXQoi6HBuc6bBDPp8siXshZmPZOY+9R
         DPpgBYishBhnvHK2GLLcqovM2gYZvD556xl5TFUPnCSvtg6buYZX5WanCkdIBbdb2kA0
         QLiCMrGeEdy/wfNRoW/JtwxMUtZOxpx2y5nfrCG74uFafooXajIWOmaDim35VOP3KFiA
         zWqt5YWZsPtiGFBGrrPFbWUNjt+B1sDzKCfn77yQEZKfK2dVRSCLnYE611BBOm9Fn2S4
         KT6Q==
X-Gm-Message-State: AOAM5311hdrYu7eLiejS8WAZ49Aye1PL1QexN0yMBT2CccrlgMzVS4bc
        KUL7qcvCR0r02s9gcNV6k/9rZS4bPX67kA==
X-Google-Smtp-Source: ABdhPJyQTX71fqdBlsV3wg1dOqWbDMMRzBm1iAIn1NPZkqVerW/dV9HNP2c4HoFbBIKUOfUoxKBUJw==
X-Received: by 2002:a05:6000:180f:: with SMTP id m15mr7614479wrh.60.1622655540668;
        Wed, 02 Jun 2021 10:39:00 -0700 (PDT)
Received: from dell ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id l13sm611697wrv.57.2021.06.02.10.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 10:39:00 -0700 (PDT)
Date:   Wed, 2 Jun 2021 18:38:58 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, Hyun Kwon <hyun.kwon@xilinx.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michal Simek <michal.simek@xilinx.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND 18/26] drm/xlnx/zynqmp_dp: Fix incorrectly name function
 'zynqmp_dp_train()'
Message-ID: <20210602173858.GL2173308@dell>
References: <20210602143300.2330146-1-lee.jones@linaro.org>
 <20210602143300.2330146-19-lee.jones@linaro.org>
 <YLewgiMzhlR//gzQ@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YLewgiMzhlR//gzQ@pendragon.ideasonboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Jun 2021, Laurent Pinchart wrote:

> Hi Lee,
> 
> Thank you for the patch.
> 
> On Wed, Jun 02, 2021 at 03:32:52PM +0100, Lee Jones wrote:
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/gpu/drm/xlnx/zynqmp_dp.c:806: warning: expecting prototype for zynqmp_dp_link_train(). Prototype was for zynqmp_dp_train() instead
> > 
> > Cc: Hyun Kwon <hyun.kwon@xilinx.com>
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Michal Simek <michal.simek@xilinx.com>
> > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/gpu/drm/xlnx/zynqmp_dp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> > index 82430ca9b9133..a1055d5055eab 100644
> > --- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> > +++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> > @@ -797,7 +797,7 @@ static int zynqmp_dp_link_train_ce(struct zynqmp_dp *dp)
> >  }
> >  
> >  /**
> > - * zynqmp_dp_link_train - Train the link
> > + * zynqmp_dp_train - Train the link
> 
> The driver has other functions related to link training that start with
> the zynqmp_dp_link_train_* prefix. I'd prefer renaming this function to
> zynqmp_dp_link_train(). Bonus points if the same patch could rename
> zynqmp_dp_train_loop() to zynqmp_dp_link_train_loop() too :-)

Doesn't have much to do with this patch though? :)

Happy to help though.  Can I fix subsequently?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
