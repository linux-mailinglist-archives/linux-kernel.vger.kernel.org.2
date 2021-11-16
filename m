Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55AC4452961
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 06:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243090AbhKPFJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 00:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238496AbhKPFJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 00:09:23 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8E5C2CE2F7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 18:08:34 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso891121pji.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 18:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PCNcz7gXnGfaX5DVsuzUbuuXMxo7d2wz8Wt49uOFvWk=;
        b=LXoWiPa+xcxnCc13uR6IPKQaQFGuuzEIIblfjmSEAgij5u4lFq+US9j0pKdXzh7AZ+
         mLcsXatUzA/EQVN3ayK8vxjBlPNr9Kssb559TA1fgsPPVNz5+LPG5CozIArfTPdr41vN
         6oShyAzhYqMaluQN7bbdszWDl2ktfpIr3WaBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PCNcz7gXnGfaX5DVsuzUbuuXMxo7d2wz8Wt49uOFvWk=;
        b=i6oU4jIsByyTYCBVQsY2j8Q+oxq9kMRcmxiOFLZFqB4ic9iABCf9HHNLOvFcqEbaJi
         16oqcCwz7x+E9F2kOIdBpfocn2BBGLpNR069qggudsy2aoKWa91Ej9SDarRJwPI3Ctk1
         wFYHTDxDcZKE77cQNin/9E+WN6MTN08rlaVhnmmAW6dh51AQnwoT2l29Ayaw2jnmcWj9
         2BQCgbqx3IfsQ1gxBLN0Av4iTYFHYO45gATbPKBxcwdIKLRcU9rGa7lZBV3AjOv1IUR4
         NJGlqpHpvYD54Lm9MNgr3ZhNCICmFaeZYZOgzl/Fsplp09Wj1Yr4kP7MAwmjqcdT+JIJ
         Nk4Q==
X-Gm-Message-State: AOAM532f7BzoxHFHHt2OdUJJJGIFo1wmxAhDphnCAxZXEVBtM+DjL2jp
        sfqXk0AGRZji/ek9iYRYEFnV8g==
X-Google-Smtp-Source: ABdhPJyCy/QiNDJlSXbhoIuD/WObr8cyR6V9q+6r4aOE7l2hOZgzLIn3JuB1j8kr56dvjjo69PnAxw==
X-Received: by 2002:a17:90b:4c8c:: with SMTP id my12mr69698947pjb.157.1637028514438;
        Mon, 15 Nov 2021 18:08:34 -0800 (PST)
Received: from localhost ([2620:15c:202:201:54aa:73ab:b480:41e2])
        by smtp.gmail.com with UTF8SMTPSA id t80sm12921817pgb.26.2021.11.15.18.08.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 18:08:34 -0800 (PST)
Date:   Mon, 15 Nov 2021 18:08:32 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        Peter Chen <peter.chen@kernel.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Bastien Nocera <hadess@hadess.net>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Roger Quadros <rogerq@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Al Cooper <alcooperx@gmail.com>
Subject: Re: [PATCH v16 1/7] usb: misc: Add onboard_usb_hub driver
Message-ID: <YZMSoPg10xoZ5LYK@google.com>
References: <20210813195228.2003500-1-mka@chromium.org>
 <20210813125146.v16.1.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <CAD=FV=U2OuZFrqzVfrbLOUM4nHXwr1uYAYZ9XYWMr-Q95gb_EA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=U2OuZFrqzVfrbLOUM4nHXwr1uYAYZ9XYWMr-Q95gb_EA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

thanks for the thorough review!

On Thu, Nov 11, 2021 at 03:31:31PM -0800, Doug Anderson wrote:
> Hi,
> 
> On Fri, Aug 13, 2021 at 12:52 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > +++ b/Documentation/ABI/testing/sysfs-bus-platform-onboard-usb-hub
> > @@ -0,0 +1,8 @@
> > +What:          /sys/bus/platform/devices/<dev>/always_powered_in_suspend
> > +Date:          March 2021
> > +KernelVersion: 5.13
> 
> I dunno how stuff like this is usually managed, but March 2021 and
> 5.13 is no longer correct.

will update, though it's not unlikely it will go stale again before this
series lands.

> > +ONBOARD USB HUB DRIVER
> > +M:     Matthias Kaehlcke <mka@chromium.org>
> > +L:     linux-usb@vger.kernel.org
> > +S:     Maintained
> > +F:     Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml
> 
> I'm confused. Where is this .yaml file? It doesn't look landed and it
> doesn't look to be in your series.

It's a leftover from the early days of the series, when the driver had
it's own binding, I'll remove it.

> I guess this should be updated to:
> 
> F: Documentation/devicetree/bindings/usb/realtek,rts5411.yaml

Not sure about that, the rts5411 binding could exist without this driver.

> Also: should this have:
> 
> F: Documentation/ABI/testing/sysfs-bus-platform-onboard-usb-hub

ack

> > +struct udev_node {
> > +       struct usb_device *udev;
> > +       struct list_head list;
> > +};
> 
> nit: 'udev' has a whole different connotation to me. Maybe just go
> with `usbdev_node` ?

Will change to 'usbdev_dev' node as suggested, I think it's ok to keep
'udev' for the pointer to the USB device itself, since that abbreviation
is used commonly in USB kernel land.

> > +static int __maybe_unused onboard_hub_suspend(struct device *dev)
> > +{
> > +       struct onboard_hub *hub = dev_get_drvdata(dev);
> > +       struct udev_node *node;
> > +       bool power_off;
> > +       int rc = 0;
> > +
> > +       if (hub->always_powered_in_suspend)
> > +               return 0;
> > +
> > +       power_off = true;
> > +
> > +       mutex_lock(&hub->lock);
> > +
> > +       list_for_each_entry(node, &hub->udev_list, list) {
> > +               if (!device_may_wakeup(node->udev->bus->controller))
> > +                       continue;
> > +
> > +               if (usb_wakeup_enabled_descendants(node->udev)) {
> > +                       power_off = false;
> > +                       break;
> > +               }
> > +       }
> > +
> > +       mutex_unlock(&hub->lock);
> > +
> > +       if (power_off)
> > +               rc = onboard_hub_power_off(hub);
> > +
> > +       return rc;
> 
> optional nit: get rid of "rc" and write the above as:
> 
> if (power_off)
>   return onboard_hub_power_off(hub);
> 
> return 0;

ok, I plan to revert the suggested logic though and bail out 'early' if there
is nothing to do.

> > +static int __maybe_unused onboard_hub_resume(struct device *dev)
> > +{
> > +       struct onboard_hub *hub = dev_get_drvdata(dev);
> > +       int rc = 0;
> > +
> > +       if (!hub->is_powered_on)
> > +               rc = onboard_hub_power_on(hub);
> > +
> > +       return rc;
> 
> optional nit: get rid of "rc" and write the above as:
> 
> if (!hub->is_powered_on)
>   return onboard_hub_power_on(hub);
> 
> return 0;

ok, same as above

> > +static void onboard_hub_remove_usbdev(struct onboard_hub *hub, struct usb_device *udev)
> > +{
> > +       struct udev_node *node;
> > +       char link_name[64];
> > +
> > +       snprintf(link_name, sizeof(link_name), "usb_dev.%s", dev_name(&udev->dev));
> > +       sysfs_remove_link(&hub->dev->kobj, link_name);
> 
> I would be at least moderately worried about the duplicate snprintf
> between here and the add function. Any way that could be a helper?

I'll add a helper

> > +static struct onboard_hub *_find_onboard_hub(struct device *dev)
> > +{
> > +       struct platform_device *pdev;
> > +       struct device_node *np;
> > +       phandle ph;
> > +
> > +       pdev = of_find_device_by_node(dev->of_node);
> > +       if (!pdev) {
> > +               if (of_property_read_u32(dev->of_node, "companion-hub", &ph)) {
> > +                       dev_err(dev, "failed to read 'companion-hub' property\n");
> > +                       return ERR_PTR(-EINVAL);
> > +               }
> > +
> > +               np = of_find_node_by_phandle(ph);
> > +               if (!np) {
> > +                       dev_err(dev, "failed to find device node for companion hub\n");
> > +                       return ERR_PTR(-EINVAL);
> > +               }
> 
> Aren't the above two calls equivalent to this?
> 
> npc = of_parse_phandle(dev->of_node, "companion-hub", 0)

Indeed, will use of_parse_phandle() instead

> > +
> > +               pdev = of_find_device_by_node(np);
> > +               of_node_put(np);
> > +
> > +               if (!pdev)
> > +                       return ERR_PTR(-EPROBE_DEFER);
> 
> Shouldn't you also defer if the dev_get_drvdata() returns NULL? What
> if you're racing the probe of the platform device?

Yeah, it seems that race could happen. IIUC we could use device_is_bound()
to check if probing completed, really_probe() calls driver_bound() only
after successfully probing the device.

> > +       }
> > +
> > +       put_device(&pdev->dev);
> > +
> > +       return dev_get_drvdata(&pdev->dev);
> 
> It feels like it would be safer to call dev_get_drvdata() before
> putting the device? ...and actually, are you sure you should even be
> putting the device? Maybe we should wait to put it until
> onboard_hub_usbdev_disconnect()

It shouldn't be necessary, when the platform device is destroyed it
unbinds the associated USB devices (see onboard_hub_remove()), hence
they don't keep using the drvdata. There was a related discussion in
the early days of this series: https://lkml.org/lkml/2020/9/21/2153

> > +static struct usb_device_driver onboard_hub_usbdev_driver = {
> > +
> > +       .name = "onboard-usb-hub",
> 
> Remove the extra blank line at the start of the structure?

ok

> > +void onboard_hub_create_pdevs(struct usb_device *parent_hub, struct list_head *pdev_list)
> > +{
> > +       int i;
> > +       phandle ph;
> > +       struct device_node *np, *npc;
> > +       struct platform_device *pdev;
> > +       struct pdev_list_entry *pdle;
> 
> Should the `INIT_LIST_HEAD(pdev_list);` go here? Is there any reason
> why we need to push this into the caller?

That would limit pdev_list to a single entry, which is not what we want. A
parent hub might have multiple compatible onboard hubs connected to it.

> > +       for (i = 1; i <= parent_hub->maxchild; i++) {
> > +               np = usb_of_get_device_node(parent_hub, i);
> > +               if (!np)
> > +                       continue;
> > +
> > +               if (!of_is_onboard_usb_hub(np))
> > +                       goto node_put;
> > +
> > +               if (of_property_read_u32(np, "companion-hub", &ph))
> > +                       goto node_put;
> > +
> > +               npc = of_find_node_by_phandle(ph);
> > +               if (!npc)
> > +                       goto node_put;
> 
> Aren't the above two calls equivalent to this?
> 
> npc = of_parse_phandle(np, "companion-hub", 0)

yes, will change to of_parse_phandle()

> I'm also curious why a companion-hub is a _required_ property.
> Couldn't you support USB 2.0 hubs better by just allowing
> companion-hub to be optional? I guess that could be a future
> improvement, but it also seems trivial to support from the start.

The evolution of this driver somewhat tied it to xHCI, however that
isn't strictly necessary. In a sense it is nice when 'companion-hub'
is mandatory, since things can get messy if it is forgotten when it
should be there.

The property should be mandatory in the bindings of the USB >= 3.0
hubs that are supported by this driver, but it could be optional
for USB 2.0 hubs. Instead of doing the enforcement in the driver
it could be limited to checking a DT against the bindings in .yaml.
It's also an option to make it mandatory in the driver through a
list of compatible strings / VIDs/PIDs.

> > +               pdev = of_find_device_by_node(npc);
> > +               of_node_put(npc);
> > +
> > +               if (pdev) {
> > +                       /* the companion hub already has a platform device, nothing to do here */
> > +                       put_device(&pdev->dev);
> > +                       goto node_put;
> > +               }
> > +
> > +               pdev = of_platform_device_create(np, NULL, &parent_hub->dev);
> > +               if (pdev) {
> > +                       pdle = kzalloc(sizeof(*pdle), GFP_KERNEL);
> 
> Maybe devm_kzalloc(&pdev->dev, GFP_KERNEL) ? Then you can get rid of
> the free in the destroy function?

it feels a bit sneaky to do it after creation instead of probe(), but I guess
it's fine.

> > +                       if (!pdle)
> > +                               goto node_put;
> 
> If your memory allocation fails here, don't you need to
> of_platform_device_destroy() ?

right, will call of_platform_device_destroy() in case of failure

> > +                       INIT_LIST_HEAD(&pdle->node);
> 
> I don't believe that the INIT_LIST_HEAD() does anything useful here.
> &pdle->node is not a list head--it's a list element. Adding it to the
> end of the existing list will fully initialize its ->next and ->prev
> pointers but won't look at what they were.

indeed, will remove

> > +                       pdle->pdev = pdev;
> > +                       list_add(&pdle->node, pdev_list);
> > +               } else {
> > +                       dev_err(&parent_hub->dev,
> > +                               "failed to create platform device for onboard hub '%s'\n",
> > +                               of_node_full_name(np));
> 
> Use "%pOF" instead of open-coding.

ack

> > +void onboard_hub_destroy_pdevs(struct list_head *pdev_list)
> > +{
> > +       struct pdev_list_entry *pdle, *tmp;
> > +
> > +       list_for_each_entry_safe(pdle, tmp, pdev_list, node) {
> > +               of_platform_device_destroy(&pdle->pdev->dev, NULL);
> > +               kfree(pdle);
> 
> It feels like you should be removing the node from the list too,
> right? Otherwise if you unbind / bind the USB driver you'll still have
> garbage in your list the 2nd time?

Could catch, it seems I limited testing to a single removal ...
