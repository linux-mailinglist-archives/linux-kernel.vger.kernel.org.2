Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C109332D1F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 18:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhCIRUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 12:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbhCIRUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 12:20:16 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F93C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 09:20:16 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so5566833pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 09:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wiCMuEXc4Jxy1A0Iee9Q+lJfroVuqKy0Zz9moUVqcMY=;
        b=SoF1Qe1rjZJYmhqkrQLF1+i+UBJNyib4lNJYtbB1fYA80rRpZ3yCJ4eEtXK8GRFt84
         zFK0lI5Cjd8HOLyjCJSIKd41glMBEIjcVcWS46lQUYY3hcoRxqthxsXxoMhoKRQgQ030
         k0Z5wtZbea8uAgasRe9X+H8G5VbmwUUt/5cKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wiCMuEXc4Jxy1A0Iee9Q+lJfroVuqKy0Zz9moUVqcMY=;
        b=Xf4mUVeq0jKJNMReR5X0ScQZTWsNpZaONIkSGiz8R3DDPtOSA1VyycqPo5g4dWYX/V
         qcACQr8CSAh9aUFof/6hVQw9s6HwWJvnjWH+a/XYdlV13yJJTXbxFi+YSXAh/bp/AEbs
         npyzxvWJL/h2jL/CYBgdtVEKdjlUa47NQW5BR4oDdYluQ63G5HxsPiStlT7jXoVbRQKY
         T3FPS6qJDemc225ffsYTUiM4nrm5INcQAzcxBUA/yk5h7DINPIVjjVtV4OWTX4r0OrbP
         KP6trhUWjOn52mRhqAy44c5VrtWGPyIO7eBbEmOiC8LNFnUdsvx0JX7vGJQRcE7B8M+b
         MycA==
X-Gm-Message-State: AOAM530OKuJm2PDHYRAbquhezbhI9ztG25RQIODVLqn3T6q4zG/7farU
        U/cLILyIhd8i89WC9gqqHnSWrg==
X-Google-Smtp-Source: ABdhPJzJ8OJ/ZAI78DQ2qpohpiWkEKZmPUDijaI4AYJjCbHuNfVUEPgqfR5/rtEEGtrV1wkXE5YXLA==
X-Received: by 2002:a17:90b:4c0a:: with SMTP id na10mr5911634pjb.227.1615310415763;
        Tue, 09 Mar 2021 09:20:15 -0800 (PST)
Received: from localhost ([2620:15c:202:1:8596:1e26:eb88:66f6])
        by smtp.gmail.com with UTF8SMTPSA id 35sm13162838pgr.14.2021.03.09.09.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 09:20:15 -0800 (PST)
Date:   Tue, 9 Mar 2021 09:20:12 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Frank Rowand <frowand.list@gmail.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Peter Chen <peter.chen@nxp.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        linux-usb@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v6 3/5] of/platform: Add stubs for
 of_platform_device_create/destroy()
Message-ID: <YEeuTBsU145OTSCk@google.com>
References: <20210305193853.2040456-1-mka@chromium.org>
 <20210305113832.v6.3.I08fd2e1c775af04f663730e9fb4d00e6bbb38541@changeid>
 <20210308223251.GA3067045@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210308223251.GA3067045@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 03:32:51PM -0700, Rob Herring wrote:
> On Fri, Mar 05, 2021 at 11:38:51AM -0800, Matthias Kaehlcke wrote:
> > Code for platform_device_create() and of_platform_device_create() is
> 
> You mean of_platform_device_create and of_platform_device_destroy?
> 
> Does of_platform_populate not work in your usecase?

of_platform_populate() would create a platform device for every node
under the USB controller or hub. While this could be restricted with
the 'matches' parameter it would still create two platform devices for
a hub controller that provides separate USB 2 and USB 3 hubs.

When of_platform_device_create() is used the onboard hub driver can
help to decide for which node the platform device should be created.

> > only generated if CONFIG_OF_ADDRESS=y. Add stubs to avoid unresolved
> > symbols when CONFIG_OF_ADDRESS is not set.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > 
> > Changes in v6:
> > - patch added to the series
> > 
> >  include/linux/of_platform.h | 22 ++++++++++++++++++----
> >  1 file changed, 18 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
> > index 84a966623e78..d15b6cd5e1c3 100644
> > --- a/include/linux/of_platform.h
> > +++ b/include/linux/of_platform.h
> > @@ -61,16 +61,18 @@ static inline struct platform_device *of_find_device_by_node(struct device_node
> >  }
> >  #endif
> >  
> > +extern int of_platform_bus_probe(struct device_node *root,
> > +				 const struct of_device_id *matches,
> > +				 struct device *parent);
> > +
> > +#ifdef CONFIG_OF_ADDRESS
> >  /* Platform devices and busses creation */
> >  extern struct platform_device *of_platform_device_create(struct device_node *np,
> >  						   const char *bus_id,
> >  						   struct device *parent);
> >  
> >  extern int of_platform_device_destroy(struct device *dev, void *data);
> > -extern int of_platform_bus_probe(struct device_node *root,
> > -				 const struct of_device_id *matches,
> > -				 struct device *parent);
> > -#ifdef CONFIG_OF_ADDRESS
> > +
> >  extern int of_platform_populate(struct device_node *root,
> >  				const struct of_device_id *matches,
> >  				const struct of_dev_auxdata *lookup,
> > @@ -84,6 +86,18 @@ extern int devm_of_platform_populate(struct device *dev);
> >  
> >  extern void devm_of_platform_depopulate(struct device *dev);
> >  #else
> > +/* Platform devices and busses creation */
> > +static inline struct platform_device *of_platform_device_create(struct device_node *np,
> > +								const char *bus_id,
> > +								struct device *parent)
> > +{
> > +	return NULL;
> > +}
> > +static inline int of_platform_device_destroy(struct device *dev, void *data)
> > +{
> > +	return -ENODEV;
> > +}
> > +
> >  static inline int of_platform_populate(struct device_node *root,
> >  					const struct of_device_id *matches,
> >  					const struct of_dev_auxdata *lookup,
> > -- 
> > 2.30.1.766.gb4fecdf3b7-goog
> > 
