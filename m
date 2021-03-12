Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C439C339107
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhCLPSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbhCLPSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:18:13 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B323C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:18:12 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id v15so5020104wrx.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=leC2X22bIXYvyYORNNtIO2HJvzBD3GajS0ITQJHF+zY=;
        b=wO4VWlopNcXvLMHwptFGjkgljtbl60J9/gxUV+HlYPrZIupnaDeNy2YvPMYFDILyIQ
         j8RgVqHvsXU861Im78uhe/Rre2Py1krC2YyC5nUCz/2WtR1HB83+QDPpQhb2cIRZ75oJ
         sWVqq6M+t4Sbw8uOnu8IsPqOYzpHRAOg/zp+fSXM+VgPr6rQTBABUeLXYoewDjtH4TPU
         eOs9YP4auDU5P5ukpgsncUoNY5sqGJo99jB5uOWuUuFiiyzFuk7BvGVVHo92YZ26GgA5
         nNWVaMO/WZBUeeR2hIRjlNsrCObYErm3n4/v9IfHhYB+w31vdRGUrqrHvU7WkLdvLpYh
         CS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=leC2X22bIXYvyYORNNtIO2HJvzBD3GajS0ITQJHF+zY=;
        b=XJIYkiE+aY7+IHBOcZSmSrPHsCKh9fTmVdHYMZEnDCgmLdWA3wEVKfF+ev9kPcTukl
         uGXG7le03mecF2IzQ1SjxMVlBUCAxVSjGU6WenHalktD8hlVB8hhSdSwep5Bw7O9zH+O
         /eWEgXqFP/2wgYwD8lIa2Ss99uDP8BQWyarjPwPHUH34BP+gg3kDonHp1F57iPCED3m7
         S5XFPOH60nDab7hWhMzXCm9R5RnlpnC202YtAPH7xhCzGqvsxAWJodqMJWzoNbz6vnqH
         VrDGnmaXf1CQ1fl2KMNsOUYUzQ5fYKhhEgfPUtuJh6ZbcPe+rfpU1Ttq7os/y452hVvG
         wVwA==
X-Gm-Message-State: AOAM531cNOlrscGs7wV59T9OqSDpztivdDzPklJYywWU+vvEAvUO5S1e
        /rDAKMnVf1GujS0Nfth9+vmP4Q==
X-Google-Smtp-Source: ABdhPJxNcPDdfwbr38+iqUrdfR5ppoiRhbwNm7g/cyUHSZMNM6kzY3pY6Dy+RcrdNd5YncvS9zBFJA==
X-Received: by 2002:adf:9bcf:: with SMTP id e15mr14087256wrc.276.1615562291271;
        Fri, 12 Mar 2021 07:18:11 -0800 (PST)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id i17sm8142788wrp.77.2021.03.12.07.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 07:18:10 -0800 (PST)
Date:   Fri, 12 Mar 2021 15:18:09 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     linux-kernel@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 08/10] of: of_net: Demote non-conforming kernel-doc header
Message-ID: <20210312151809.GW701493@dell>
References: <20210312110758.2220959-1-lee.jones@linaro.org>
 <20210312110758.2220959-9-lee.jones@linaro.org>
 <YEt1GlakFcST27F0@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YEt1GlakFcST27F0@lunn.ch>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2021, Andrew Lunn wrote:

> On Fri, Mar 12, 2021 at 11:07:56AM +0000, Lee Jones wrote:
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/of/of_net.c:104: warning: Function parameter or member 'np' not described in 'of_get_mac_address'
> >  drivers/of/of_net.c:104: warning: expecting prototype for mac(). Prototype was for of_get_mac_address() instead
> > 
> > Cc: Andrew Lunn <andrew@lunn.ch>
> > Cc: Heiner Kallweit <hkallweit1@gmail.com>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Frank Rowand <frowand.list@gmail.com>
> > Cc: netdev@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/of/of_net.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/of/of_net.c b/drivers/of/of_net.c
> > index 6e411821583e4..9b41a343e88ab 100644
> > --- a/drivers/of/of_net.c
> > +++ b/drivers/of/of_net.c
> > @@ -78,7 +78,7 @@ static const void *of_get_mac_addr_nvmem(struct device_node *np)
> >  	return mac;
> >  }
> >  
> > -/**
> > +/*
> >   * Search the device tree for the best MAC address to use.  'mac-address' is
> >   * checked first, because that is supposed to contain to "most recent" MAC
> >   * address. If that isn't set, then 'local-mac-address' is checked next,
> 
> Hi Lee
> 
> of_get_mac_address() is a pretty important API function. So it would
> be better to add the missing header to make this valid kdoc.

Pretty important, yes.  Referenced/documented, no. :)

  `git grep kernel-doc:: | grep drivers/of`

> /**
>  * of_get_mac_address - Get MAC address from device tree
>  * @np: Pointer to the device_node of the interface
>  *
> 
>  Andrew

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
