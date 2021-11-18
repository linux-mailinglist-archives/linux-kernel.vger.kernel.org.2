Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBBE4561D4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 18:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbhKRRzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 12:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbhKRRza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 12:55:30 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B035DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 09:52:30 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id y7so5971272plp.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 09:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TtnoYGtAxGPW+9L6edJ2N+GbKnq2mOeeAWUKCB6RQko=;
        b=PYEEEbkZpq54OWNcaYpvnCzoYdE+vHgsvc8G3jHkXs3dGt+LDkIRK1mFxA+qVUUnOK
         8k8l2iZfTu00sNd2Mb9Y/efZU3RA7OYSwmBgmBukA3SQ2SkvuzaD/rli/JlDPxtBqVV2
         6LFZqSjXprrigWpxA7vUTzrHPzhr8y1Lld5bU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TtnoYGtAxGPW+9L6edJ2N+GbKnq2mOeeAWUKCB6RQko=;
        b=QMKCXwwHzdDJTL/JsWmm/mRhqjhRzOiJegHLXbBPnGW+ONdm/Z1h1ZwROxc/tNz0IJ
         p2vLblR8hCcENi+Cqy2sUSrl2okK8TPBynKsCQTadhjr84pvLVMBII2/mDuYoYiJn8pP
         glT6PQKbSlUzYTuYPQG0vMkHTjc4Qz26VPIw0SJ12NJJPITX0o5QweudmSF0rIRDQA8C
         ZT76hL0ah1+56qhFT6vAN39s8B644SxNueOoPuFQeoAiE0yFVefq9l5ydaD4J3baPSso
         sTh5N+qbsuF6LrftJjimO0ra6ZndLxOuqTzbajDtWzvDG0UiiiCv4ZDa9gPDwIs698QG
         sU0Q==
X-Gm-Message-State: AOAM531OWsh3unbUSQ8yKmRrQkrh5s2rp0ihY+4hWOaM7jvnCaSrckA1
        cN78YPB+xHGG/WXaWty+P12sVg==
X-Google-Smtp-Source: ABdhPJxEksdhN49ug4fA0rYwLkMrniqIXGi6GQjKTL9BIpYpmQbTQ+4El8cL1u7uZGrRNFpWRr1Dfg==
X-Received: by 2002:a17:902:c78a:b0:142:1b7a:930 with SMTP id w10-20020a170902c78a00b001421b7a0930mr68883923pla.8.1637257950264;
        Thu, 18 Nov 2021 09:52:30 -0800 (PST)
Received: from localhost ([2620:15c:202:201:8ceb:c68a:21af:bebe])
        by smtp.gmail.com with UTF8SMTPSA id f21sm280683pfc.85.2021.11.18.09.52.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Nov 2021 09:52:29 -0800 (PST)
Date:   Thu, 18 Nov 2021 09:52:28 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Chen <peter.chen@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, Roger Quadros <rogerq@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v17 1/7] usb: misc: Add onboard_usb_hub driver
Message-ID: <YZaS3NpfUqqg4L+v@google.com>
References: <20211116200739.924401-1-mka@chromium.org>
 <20211116120642.v17.1.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <CAD=FV=VnRQzvgjVzTNgx5kaC6VDvFGvTx2njtdTo27LW1zxWJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=VnRQzvgjVzTNgx5kaC6VDvFGvTx2njtdTo27LW1zxWJA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 04:11:34PM -0800, Doug Anderson wrote:
> Hi,
> 
> On Tue, Nov 16, 2021 at 12:07 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > --- a/drivers/usb/misc/Kconfig
> > +++ b/drivers/usb/misc/Kconfig
> > @@ -284,3 +284,20 @@ config BRCM_USB_PINMAP
> >           This option enables support for remapping some USB external
> >           signals, which are typically on dedicated pins on the chip,
> >           to any gpio.
> > +
> > +config USB_ONBOARD_HUB
> > +       tristate "Onboard USB hub support"
> 
> Aren't you back to shenanigans now that you're being called straight
> from the USB core? What if you're a module and the USB core is
> builtin? It can't call you, right? ...or what if you're builtin but
> the USB core is a module (yeah, I know that sounds insane but I don't
> think anything technically prevents it)?

Indeed, a dependency involving USB host mode is needed, as previously
with xhci_plat.

> Can you just add a dependency here such that if the USB core is a
> module that you're a module and if the USB core is builtin that you're
> builtin?

I couldn't find a way to specify that in the config options of the driver
itself. I fear the dependency has to be specified in CONFIG_USB, like it
was done previously with USB_XHCI_PLATFORM:

https://patchwork.kernel.org/project/linux-usb/patch/20210813125146.v16.6.I7a3a7d9d2126c34079b1cab87aa0b2ec3030f9b7@changeid/

Hope that isn't controversial.

> > +void onboard_hub_create_pdevs(struct usb_device *parent_hub, struct list_head *pdev_list)
> > +{
> > +       int i;
> > +       struct device_node *np, *npc;
> > +       struct platform_device *pdev;
> > +       struct pdev_list_entry *pdle;
> > +
> > +       INIT_LIST_HEAD(pdev_list);
> > +
> > +       for (i = 1; i <= parent_hub->maxchild; i++) {
> > +               np = usb_of_get_device_node(parent_hub, i);
> > +               if (!np)
> > +                       continue;
> > +
> > +               if (!of_is_onboard_usb_hub(np))
> > +                       goto node_put;
> > +
> > +               npc = of_parse_phandle(np, "companion-hub", 0);
> > +               if (!npc)
> > +                       goto create_pdev;
> > +
> > +               pdev = of_find_device_by_node(npc);
> > +               of_node_put(npc);
> > +
> > +               if (pdev) {
> > +                       /* the companion hub already has a platform device, nothing to do here */
> > +                       put_device(&pdev->dev);
> > +                       goto node_put;
> > +               }
> > +
> > +create_pdev:
> 
> I don't really like this "goto". I'd rather just use an "if" test for
> the few lines even if the indentation gets to be a bit much.

Ok, I'll remove the "goto" in the next version.
