Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4AA443885
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 23:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhKBWi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 18:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhKBWi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 18:38:56 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBC2C061203
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 15:36:21 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r8so722694wra.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 15:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mlauy3vNd9KbBeQ/P3IhRFrTYk9NsjbV35NI/DoCFQQ=;
        b=LhJzMSC03GD6kwFoHkcv0WlZV8/LiMo3e6aUlmAyFmOZ03I0K/GJ7F40Hc1b+LDbys
         tYwF6MfkMGi4kGmcYAQrVZ0wm6bqC4JEDNJsKiWBlgYmK/SLRCAp/vSUag2Lgc2mUTbK
         FwoLgRPulKd9iQCBHERoM+IfA8GraokFzdvOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mlauy3vNd9KbBeQ/P3IhRFrTYk9NsjbV35NI/DoCFQQ=;
        b=PUE+zgxxPPlefhYm0MXBBFvJCCZNR1zfr8D6WhcbuhTrlln0Jb+2vLof5RW/bKIhuf
         xidLq5jYZw8Hk2cI9nCGlodcw47FmLwSxYRi7arnBSzQqQDry3mbuwIjwiuFiXdDB5Fp
         e5rIiXv1EUOtZlxuTaiyWEMk3GGZLakB+qW9csO4yD0vWB9HWLtXJi3gf7xKuvjf3wMQ
         mcpnImkfiVYE8/Wx9IKKitUbogDcLQYjKmxhK0fhWQ5m6AeQmyNZS5Ja0KS3aQDRglnS
         9DnDkl735OxwcxECqjVJhLEf8XX5wifCEN2cQ2Iej0BnorPjiEdMmruZJOIbCD8qxKoI
         Vh7A==
X-Gm-Message-State: AOAM531YmmalYSy5/cbuN1crOFv6Rw+t7QccAGOO+paLRX4hROd5mSIx
        B4YKHtnN5cOuLoGe2FacP5Hv6W1jjT3ayx+GCcJZQg==
X-Google-Smtp-Source: ABdhPJySLhbC5WzDuB67uzrOZ9QpcyPxMj+1yYafVt6ksGWZ/DZ7G9DR4tON+WdfbjWdcBceE+hKBMwT/h9K3GGxKII=
X-Received: by 2002:a5d:59ab:: with SMTP id p11mr5870456wrr.340.1635892579719;
 Tue, 02 Nov 2021 15:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211029200319.23475-1-jim2101024@gmail.com> <20211029200319.23475-8-jim2101024@gmail.com>
 <YYFgmxMCnKtTlaqL@robh.at.kernel.org>
In-Reply-To: <YYFgmxMCnKtTlaqL@robh.at.kernel.org>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Tue, 2 Nov 2021 18:36:08 -0400
Message-ID: <CA+-6iNwdLt96U26eW-GDJFD3XB9unKX-ucF3gZ754ux78yMRCw@mail.gmail.com>
Subject: Re: [PATCH v6 7/9] PCI: brcmstb: Add control of subdevice voltage regulators
To:     Rob Herring <robh@kernel.org>
Cc:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 2, 2021 at 12:00 PM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Oct 29, 2021 at 04:03:15PM -0400, Jim Quinlan wrote:
> > This Broadcom STB PCIe RC driver has one port and connects directly to one
> > device, be it a switch or an endpoint.  We want to be able to turn on/off
> > any regulators for that device.  Control of regulators is needed because of
> > the chicken-and-egg situation: although the regulator is "owned" by the
> > device and would be best handled by its driver, the device cannot be
> > discovered and probed unless its regulator is already turned on.
>
> I think this can be done in a much more simple way that avoids the
> prior patches using the pci_ops.add_bus() (and remove_bus()) hook.
> add_bus is called before the core scans a child bus. In the handler, you
> just need to get the bridge device, then the bridge DT node, and then
> get the regulators and enable.
Hi Rob,
In reply to my bindings commit you wanted to put the "xxx-supply"
property(s) under the
bridge node rather than under the pci-ep node.   This not only makes
sense but also removes
the burden of prematurely creating the struct device *ptr as the
bridge device has
already been created.

However, there is still an issue:  if  the pcie-link is not
successful, we want the bus enumeration
to stop and not read the vendor/dev id of the EP.  Our controller has
the disadvantage of causing
an abort when accessing config space when the link is not established.  Other
controllers kindly return 0xffffffff as the data.

Doing something like this gets around the issue:

static struct pci_bus *pci_alloc_child_bus(...)
{
        /* ... */
add_dev:
        /* ... */
        if (child->ops->add_bus) {
                ret = child->ops->add_bus(child);
+               if (ret == -ENOLINK)
+                       return NULL;
                if (WARN_ON(ret < 0))
                        dev_err(&child->dev, "failed to add bus: %d\n", ret);
        }

Is this acceptable?  Other suggestions?


>
> Given we're talking about standard properties in a standard (bridge)
> node, I think the implementation for .add_bus should be common
> (drivers/pci/of.c). It doesn't scale to be doing this in every host
> bridge driver.
Are you saying that the bridge DT node  should have a property such as
"get-and-turn-on-subdev-regulators;" which would invoke what I'm now
calling brcm_pcie_add_bus()?   The problem with this is that our host
bridge needs to be the agent freeing the regulators.  IIRC correctly, when
the regulators were freed by the EP device -- or now the bridge in this case
-- we got panics when doing unbinds.  I will go back and get the details
on this, but I'm wondering if our controller has arcane but necessary
requirements
outside of what a general mechanism could provide.

Thanks,
Jim

>
> Rob
