Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8D041D294
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 06:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348030AbhI3FBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 01:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbhI3FBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 01:01:18 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC005C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 21:59:36 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id me3-20020a17090b17c300b0019f44d2e401so1734730pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 21:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VTM9z+DcTeYF3hZgKWEu9ebVrBPYT2J8Mz8sj8erXZk=;
        b=PCpbwU/Blt/pbMA6NT2nm2SIqNzMnAtcLzxhxbtj3rTw2MHvXasv4KZ/zpwWPlZn7y
         xPWsxFGYK8u70vbz7XcbGiHpsKtrQjK346ig5ArayijRkOVR0ZSgmSdFgnxE9i5Sf9pW
         0deGfEYYnNhaWRDtv3KVBZBS8spTYrA43Nq9+AxcJVFP4EVbUPaWHgG3/ccF/i1QocQh
         Qw4w3IvzGqNsfXW9sLxObs8iR9rV/NKytwQ8uw+30BCP3sXi3JaL/1APxK4M9G1CofGl
         mDPEFjR6CHHEV+e1F5uOIa2vub/p77kBLKF9waZAxea7kzN/oqO6LWY664QZ4RAJnbzu
         9G/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VTM9z+DcTeYF3hZgKWEu9ebVrBPYT2J8Mz8sj8erXZk=;
        b=wKKZx436VdCC956m09Y78fEdAbweN9nG/BjEiOkzWpXWWdobSCvQoJq2X0Gh2x4mzp
         gbc2SebLY1wNPNvUJ/M+U2Q6NN5dDv5IofTjyvre8lY4ui6EZUHBZmsrAvAV0wcNzoCL
         A5qm9KKrLxeXVQlubqUvmTRvFl8JuAr88x9ZtdLiJDdlAMEmcaE1na1EqVFocAs6y6DY
         H6okfIWw414GZYrZ0CVJ9+Z65VJ5dPVSiaWXPvoZBVEoCMmKfa9ap2fYOAQk2QwlZH2X
         nZMxcnkdnwyr/X4e40PZTpIYkiS0eyh04V9UDXGkBjML0dm48pZl9EHcy2/MKZ+M73A0
         U82w==
X-Gm-Message-State: AOAM530jp7xyh4ye6Gc5pPOscoxXXihHL841JSt6Op4uActY4k/GuOGU
        3EbFcqkOMM5lPw6jDU5qSRO+nOgbw40Vuh82VJ9Hz2i/USM=
X-Google-Smtp-Source: ABdhPJyybPbFqs+kvSA+EffRawV4Hj+ykPs983Fz8BFHzbiq+5hEn89iPiOxS6iB4aUV2nFWiaggHuioY3Gye2yZA4U=
X-Received: by 2002:a17:902:bd8d:b0:13a:8c8:a2b2 with SMTP id
 q13-20020a170902bd8d00b0013a08c8a2b2mr2377812pls.89.1632977976213; Wed, 29
 Sep 2021 21:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930014229.GA447956@rowland.harvard.edu> <CAPcyv4iiEC3B2i81evZpLP+XHa8dLkfgWmrY7HocORwP8FMPZQ@mail.gmail.com>
 <f9b7cf97-0a14-1c80-12ab-23213ec2f4f2@linux.intel.com>
In-Reply-To: <f9b7cf97-0a14-1c80-12ab-23213ec2f4f2@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 29 Sep 2021 21:59:25 -0700
Message-ID: <CAPcyv4gDgQYf0ct_Xy32gQBcWhs6d2uL+wUq4pfzszDHcUHbwQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] driver core: Move the "authorized" attribute from
 USB/Thunderbolt to core
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jason Wang <jasowang@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 7:39 PM Kuppuswamy, Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
>
> On 9/29/21 6:55 PM, Dan Williams wrote:
> >> Also, you ignored the usb_[de]authorize_interface() functions and
> >> their friends.
> > Ugh, yes.
>
> I did not change it because I am not sure about the interface vs device
> dependency.
>

This is was the rationale for has_probe_authorization flag. USB
performs authorization of child devices based on the authorization
state of the parent interface.

> I think following change should work.
>
> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> index f57b5a7a90ca..84969732d09c 100644
> --- a/drivers/usb/core/driver.c
> +++ b/drivers/usb/core/driver.c
> @@ -334,7 +334,7 @@ static int usb_probe_interface(struct device *dev)
>         if (udev->dev.authorized == false) {
>                 dev_err(&intf->dev, "Device is not authorized for usage\n");
>                 return error;
> -       } else if (intf->authorized == 0) {
> +       } else if (intf->dev.authorized == 0) {

== false.

>                 dev_err(&intf->dev, "Interface %d is not authorized for usage\n",
>                                 intf->altsetting->desc.bInterfaceNumber);
>                 return error;
> @@ -546,7 +546,7 @@ int usb_driver_claim_interface(struct usb_driver *driver,
>                 return -EBUSY;
>
>         /* reject claim if interface is not authorized */
> -       if (!iface->authorized)
> +       if (!iface->dev.authorized)

I'd do == false to keep it consistent with other conversions.

>                 return -ENODEV;
>
>         dev->driver = &driver->drvwrap.driver;
> diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
> index 47548ce1cfb1..ab3c8d1e4db9 100644
> --- a/drivers/usb/core/message.c
> +++ b/drivers/usb/core/message.c
> @@ -1791,9 +1791,9 @@ void usb_deauthorize_interface(struct usb_interface *intf)
>
>         device_lock(dev->parent);
>
> -       if (intf->authorized) {
> +       if (intf->dev.authorized) {
>                 device_lock(dev);
> -               intf->authorized = 0;
> +               intf->dev.authorized = 0;

= false;

>                 device_unlock(dev);
>
>                 usb_forced_unbind_intf(intf);
> @@ -1811,9 +1811,9 @@ void usb_authorize_interface(struct usb_interface *intf)
>   {
>         struct device *dev = &intf->dev;
>
> -       if (!intf->authorized) {
> +       if (!intf->dev.authorized) {
>                 device_lock(dev);
> -               intf->authorized = 1; /* authorize interface */
> +               intf->dev.authorized = 1; /* authorize interface */

= true

...not sure that comment is worth preserving.
