Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5D937FBAF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 18:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235008AbhEMQl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 12:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbhEMQls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 12:41:48 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209C4C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 09:40:37 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id p12so34515423ljg.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 09:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=azDgqj+LbcMdvuqykq4iAl7Ecigj+ynVE20t5RB/vxU=;
        b=LNgm/ctiArNpYCh1WAuvYiz1PXKRiQy7qhcrStasvZ0iG8iKhmHxNVSooL7geayBDA
         t1vgP7AMOhAUhb0VfcsrBS9P19JT9VnQzZa+/IdG5kZ9kTxDhp14g8XeH9Hd/yFERgY/
         01HtnsApPyKYTSVQdMSC4IyeV2ti+GK8a87TnOdrYJHGXUcl7D6E6ZQTuq5NG20B4KLK
         JdB+udJpw7J/Mdo2BAXBQ7vliI2+DeKFQyj7XB8HFLae8Cx5u+S1//2mkh2Z7WWUjttW
         3lFyYQFOd8qsXEMMOJxuLkM12/gtBGvuIc5xXOEvuGPNMzrNRzGIS9VONuiyx/jY0tQs
         o3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=azDgqj+LbcMdvuqykq4iAl7Ecigj+ynVE20t5RB/vxU=;
        b=uX3qbEqvhayCxCgzFktH59ErU1USOUv0/sPJtzAEGdJJctoE0sZyhoTgcQ2PY36q+R
         gQJ9FnAHxXYO1aomi2AzNk9oqcx9UI0KzLZJCLhRhPHAq9t+x+ZOXhWKCLkE6/qGyGvA
         NP5QNSYF6aMWPjAlIg+tpYaQnHoKV8eSBM7mvjuN4zPYQXppNCeeTMxoVsmiK/CxAjem
         0A+AoLjE5uEa7N1OF2aOYuhOjOdHEAjLKBmD6MaMHVBgu9s2dgMv30bt9aynCBxnQ/Vv
         mtNr8O28FfT7rg4j0ox1Ksl7LpLrUQ1QRzVePvVN7Bjcos2j76Wvq2G6EBTz0sdWvnC2
         kSeg==
X-Gm-Message-State: AOAM531DQd9m43u90W9PckxlL0kTtRglTBFDzxx2sMNYJanAkCAKdSAF
        ayJcZu4GpnRrnY3QhUyR5IZVweEt4jS5yBAIs7vHZA==
X-Google-Smtp-Source: ABdhPJxeFktewHco04NTNFO26pPH5BJ6HCx23Cy+MF4/41wWOTmyIB83mzWFYZAx1GqIjK1iqJPKsn1vgb0FAYJYp5o=
X-Received: by 2002:a2e:9787:: with SMTP id y7mr33881283lji.65.1620924035333;
 Thu, 13 May 2021 09:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210512213457.1310774-1-rajatja@google.com> <20210512213457.1310774-2-rajatja@google.com>
 <YJ0wgdUaOyaJpaXi@kroah.com>
In-Reply-To: <YJ0wgdUaOyaJpaXi@kroah.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Thu, 13 May 2021 09:39:58 -0700
Message-ID: <CACK8Z6EH7jmw9ODqvhxV7EHQjPsj9z++6OT3NAmhem4v68w7yA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] PCI: Add sysfs "removable" attribute
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        David Laight <David.Laight@aculab.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, May 13, 2021 at 6:58 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, May 12, 2021 at 02:34:57PM -0700, Rajat Jain wrote:
> > A PCI device is "external_facing" if it's a Root Port with the ACPI
> > "ExternalFacingPort" property or if it has the DT "external-facing"
> > property.  We consider everything downstream from such a device to
> > be removable by user.
> >
> > We're mainly concerned with consumer platforms with user accessible
> > thunderbolt ports that are vulnerable to DMA attacks, and we expect those
> > ports to be identified as "ExternalFacingPort". Devices in traditional
> > hotplug slots can technically be removed, but the expectation is that
> > unless the port is marked with "ExternalFacingPort", such devices are less
> > accessible to user / may not be removed by end user, and thus not exposed
> > as "removable" to userspace.
> >
> > Set pci_dev_type.supports_removable so the device core exposes the
> > "removable" file in sysfs, and tell the device core about removable
> > devices.
> >
> > This can be used by userspace to implment any policies it wants to,
> > tailored specifically for user removable devices. Eg usage:
> > https://chromium-review.googlesource.com/c/chromiumos/platform2/+/2591812
> > https://chromium-review.googlesource.com/c/chromiumos/platform2/+/2795038
> > (code uses such an attribute to remove external PCI devicces or disable
> > features on them as needed by the policy desired)
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
> > v3: - commit log updated
> >     - Rename set_pci_dev_removable() -> pci_set_removable()
> >     - Call it after applying early PCI quirks.
> > v2: Add documentation
> >
> >  Documentation/ABI/testing/sysfs-devices-removable |  3 ++-
> >  drivers/pci/pci-sysfs.c                           |  1 +
> >  drivers/pci/probe.c                               | 12 ++++++++++++
> >  3 files changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-devices-removable b/Documentation/ABI/testing/sysfs-devices-removable
> > index 9dabcad7cdcd..ec0b243f5db4 100644
> > --- a/Documentation/ABI/testing/sysfs-devices-removable
> > +++ b/Documentation/ABI/testing/sysfs-devices-removable
> > @@ -14,4 +14,5 @@ Description:
> >
> >               Currently this is only supported by USB (which infers the
> >               information from a combination of hub descriptor bits and
> > -             platform-specific data such as ACPI).
> > +             platform-specific data such as ACPI) and PCI (which gets this
> > +             from ACPI / device tree).
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index beb8d1f4fafe..38b3259ba333 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -1541,4 +1541,5 @@ static const struct attribute_group *pci_dev_attr_groups[] = {
> >
> >  const struct device_type pci_dev_type = {
> >       .groups = pci_dev_attr_groups,
> > +     .supports_removable = true,
> >  };
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 3a62d09b8869..3515afeeaba8 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -1575,6 +1575,16 @@ static void set_pcie_untrusted(struct pci_dev *dev)
> >               dev->untrusted = true;
> >  }
> >
> > +static void pci_set_removable(struct pci_dev *dev)
> > +{
> > +     struct pci_dev *parent = pci_upstream_bridge(dev);
> > +     if (parent &&
> > +         (parent->external_facing || dev_is_removable(&parent->dev)))
> > +             dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
> > +     else
> > +             dev_set_removable(&dev->dev, DEVICE_FIXED);
> > +}
>
> Always run checkpatch.pl so you don't get grumpy maintainers telling you
> to run checkpatch.pl :(

Yes, I did (it gave me 0 errors and 0 warnings). Please let me know if
I need to fix something and I'll be happy to fix that.

>
> And why does external_facing come into play here?  I know you say it
> above, but you should also put it here into the code for when we need to
> look at it in a few months and wonder what in the world this is doing.

Ack, will do.

>
> Also, are you SURE this is correct and will handle the hotpluggable PCI
> devices in things like drawers and the like?

Yes, me and Bjorn discussed this in the v2 of this patch
(https://patchwork.kernel.org/project/linux-usb/patch/20210424021631.1972022-2-rajatja@google.com/),
and yes, this can take care of the hot-pluggable trays if the firmware
marks the slots external-facing.

>
> What is the goal here in exposing this information to userspace, who is
> going to use it and what is it going to be used for?

The goal here is to implement policies regarding usage of external PCI
devices, in userspace. ChromeOS is using it for things like:
- Remove external PCI devices when a user logs out.
- Don't allow new external PCI devices while the screen is locked.
- collect metrics about usage of external PCI devices (how many users
actually use it etc).
- disable certain features (that are deemed to be dangerous) for
external PCI network cards.
- etc.

Thanks,

Rajat

>
>
> > +
> >  /**
> >   * pci_ext_cfg_is_aliased - Is ext config space just an alias of std config?
> >   * @dev: PCI device
> > @@ -1822,6 +1832,8 @@ int pci_setup_device(struct pci_dev *dev)
> >       /* Early fixups, before probing the BARs */
> >       pci_fixup_device(pci_fixup_early, dev);
> >
> > +     pci_set_removable(dev);
> > +
> >       pci_info(dev, "[%04x:%04x] type %02x class %#08x\n",
> >                dev->vendor, dev->device, dev->hdr_type, dev->class);
> >
> > --
> > 2.31.1.607.g51e8a6a459-goog
> >
