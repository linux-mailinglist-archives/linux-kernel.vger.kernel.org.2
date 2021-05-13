Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8763237FD0E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 20:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbhEMSEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 14:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbhEMSD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 14:03:58 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4937EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 11:02:48 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id p20so10812609ljj.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 11:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=56NjamrAE+SESlRs7n+3/6SibkxYNW5jYQDRioxIXdM=;
        b=PykBJ80x3ffjzx8by0vUMPhkdt54Ctv033pIyTEI7zNLHkXl3swOovn9FTlTUrOqNx
         r1q9xu28nRhGh2ECeeriTQkxWXEnjtxBpSQtXei9uWmsFibjFwjYa26au6nQqC9q8eeH
         kC5HHmgLBRcs0sNCrdjiSuao07FnmatGmXjHKX4nT3WUQ3mQA2u6pR1gYxXYqk6g8nlN
         dajsyE0Pl/P5fGa9ePsspzrM0omH9ZEi00lsynWta8JLNj8C+SKTCvRPSOecByQamSio
         YcTAKJAKgjmlX2f+EmWUJCp5ts4lpj8tyPkfAC9oUVBE/UrUE7yYHOlw8mEeTuad2vNz
         vdTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=56NjamrAE+SESlRs7n+3/6SibkxYNW5jYQDRioxIXdM=;
        b=c6yFu17+usf1u18S/tJ3LodnaEElqsWRyRYsr3f4xjU4QK42Ies1PRl/ESFiuOjJz6
         QHg0Szm20qJ9wssVdpr5fjqAfpNv59cXa8jn4dOZ8IARL1CQJQK1PP6QomYAawTQ5mLr
         rJrcJRDmOU+6/lbk9yQDhGGyi/r7T2sD1uQ76F4UmcagYysjARUuBVi+g7eB1cXh9yEz
         e8Qu5pVQbbaqvGote82fJKQ4pFw0RNtCIloEK9liICtjixgoY2xU9fz2Nglauur87Fqv
         DQ5C9q76IBgf+StXNTJDULLR6G5bLdRryYuy4i8DB0WDx6ozjPb89T9wxYZ2g1zdlVZt
         JpNQ==
X-Gm-Message-State: AOAM532OfaNIutI6sSQdKUhZnsIxJkxtrqjgb0IOQaDKqkwZiXFcNuld
        GcPD7rE28lisQ+cTSSfQAtTCZ8IwjiJYcGoOI6NnkQ==
X-Google-Smtp-Source: ABdhPJy9pLVraVOLT9BAMg/gTCUoW5jgAwX61eJiu62pUApj1EmU9yh9Z8O6+e/CneWlPt2gAEWG0SnrKSCmw1aBeJk=
X-Received: by 2002:a2e:9b8c:: with SMTP id z12mr35396540lji.267.1620928966420;
 Thu, 13 May 2021 11:02:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210512213457.1310774-1-rajatja@google.com> <20210512213457.1310774-2-rajatja@google.com>
In-Reply-To: <20210512213457.1310774-2-rajatja@google.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Thu, 13 May 2021 11:02:10 -0700
Message-ID: <CACK8Z6EPjcRwDB=r6RnsJRjHN4oJXTD0_8zbtUCA+awofY7=5Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] PCI: Add sysfs "removable" attribute
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rajat Jain <rajatja@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        David Laight <David.Laight@aculab.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Rajat Jain <rajatxjain@gmail.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Wed, May 12, 2021 at 2:35 PM Rajat Jain <rajatja@google.com> wrote:
>
> A PCI device is "external_facing" if it's a Root Port with the ACPI
> "ExternalFacingPort" property or if it has the DT "external-facing"
> property.  We consider everything downstream from such a device to
> be removable by user.
>
> We're mainly concerned with consumer platforms with user accessible
> thunderbolt ports that are vulnerable to DMA attacks, and we expect those
> ports to be identified as "ExternalFacingPort". Devices in traditional
> hotplug slots can technically be removed, but the expectation is that
> unless the port is marked with "ExternalFacingPort", such devices are less
> accessible to user / may not be removed by end user, and thus not exposed
> as "removable" to userspace.
>
> Set pci_dev_type.supports_removable so the device core exposes the
> "removable" file in sysfs, and tell the device core about removable
> devices.
>
> This can be used by userspace to implment any policies it wants to,
> tailored specifically for user removable devices. Eg usage:
> https://chromium-review.googlesource.com/c/chromiumos/platform2/+/2591812
> https://chromium-review.googlesource.com/c/chromiumos/platform2/+/2795038
> (code uses such an attribute to remove external PCI devicces or disable
> features on them as needed by the policy desired)
>
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
> v3: - commit log updated
>     - Rename set_pci_dev_removable() -> pci_set_removable()
>     - Call it after applying early PCI quirks.
> v2: Add documentation
>
>  Documentation/ABI/testing/sysfs-devices-removable |  3 ++-
>  drivers/pci/pci-sysfs.c                           |  1 +
>  drivers/pci/probe.c                               | 12 ++++++++++++
>  3 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-devices-removable b/Documentation/ABI/testing/sysfs-devices-removable
> index 9dabcad7cdcd..ec0b243f5db4 100644
> --- a/Documentation/ABI/testing/sysfs-devices-removable
> +++ b/Documentation/ABI/testing/sysfs-devices-removable
> @@ -14,4 +14,5 @@ Description:
>
>                 Currently this is only supported by USB (which infers the
>                 information from a combination of hub descriptor bits and
> -               platform-specific data such as ACPI).
> +               platform-specific data such as ACPI) and PCI (which gets this
> +               from ACPI / device tree).
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index beb8d1f4fafe..38b3259ba333 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1541,4 +1541,5 @@ static const struct attribute_group *pci_dev_attr_groups[] = {
>
>  const struct device_type pci_dev_type = {
>         .groups = pci_dev_attr_groups,
> +       .supports_removable = true,
>  };
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 3a62d09b8869..3515afeeaba8 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1575,6 +1575,16 @@ static void set_pcie_untrusted(struct pci_dev *dev)
>                 dev->untrusted = true;
>  }
>
> +static void pci_set_removable(struct pci_dev *dev)
> +{
> +       struct pci_dev *parent = pci_upstream_bridge(dev);
> +       if (parent &&
> +           (parent->external_facing || dev_is_removable(&parent->dev)))
> +               dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
> +       else
> +               dev_set_removable(&dev->dev, DEVICE_FIXED);
> +}

Copying comments from Krzysztof from another thread:

[Krzysztof] We were also wondering if we should only set DEVICE_REMOVABLE for
devices known to be behind an external-facing port, and let everything
else be set to "unknown" (or whatever the default would be).

[Rajat]: I think I'm fine with this proposal if Bjorn & PCI community
also sees this as a better idea. Essentially the question here is,
would it be better for the non-removable PCI devices to be shown as
"fixed" or "unknown"?

Thanks,

Rajat

> +
>  /**
>   * pci_ext_cfg_is_aliased - Is ext config space just an alias of std config?
>   * @dev: PCI device
> @@ -1822,6 +1832,8 @@ int pci_setup_device(struct pci_dev *dev)
>         /* Early fixups, before probing the BARs */
>         pci_fixup_device(pci_fixup_early, dev);
>
> +       pci_set_removable(dev);
> +
>         pci_info(dev, "[%04x:%04x] type %02x class %#08x\n",
>                  dev->vendor, dev->device, dev->hdr_type, dev->class);
>
> --
> 2.31.1.607.g51e8a6a459-goog
>
