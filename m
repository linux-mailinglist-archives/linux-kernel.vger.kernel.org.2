Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3AB3E4405
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 12:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbhHIKlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 06:41:16 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:40104
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234361AbhHIKlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 06:41:14 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id E341D40647
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 10:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628505653;
        bh=r9RM24ljMv98gkqxr0nIQ/rmCAgjdRkXjS+KF3A1mpU=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=e6Cuzriafo6juEgOkjTthDbJUTyjrvRmW3qrMeFSGAwUWlW49xX047PVNRCdfc2X2
         5i5WnSBQpQMp4u9rRSl3Kc4gajS3DA6sl+r8PlI7DLVKzPAUg0ap4FtdzqCJO0oXuH
         3H5O1j4X+8Erlsr1fyekd62qXdQfl+RXpC3l4klpeMf5tyIVWaP3oaAIKIzSbsWdrI
         zMQq1e3hmtdlGXdYU1G/c8wnC8DHkf+PbHlAH7h5qy+Gxhzs/9X9Pe/3czTimeB0e8
         tz9Yt9vdOvi/wtxYiFMZrjXK4v8KxSMH7QASd1iYoGzZH5L6qnLBKcAlveFiScp0XZ
         Df4QNiLZkLwrA==
Received: by mail-ed1-f69.google.com with SMTP id k14-20020a05640212ceb02903bc50d32c17so8741088edx.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 03:40:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r9RM24ljMv98gkqxr0nIQ/rmCAgjdRkXjS+KF3A1mpU=;
        b=Lprgv6i8R7Vdjv4HrPkpXiPiEQ8EEOYIPBGMwR7RJulwTCg5VKEQkZpuRAuIOCw07o
         ahDo4ZiCoKxyheojhJ4xJZBTrFWrlLyKU4grakjuLfPFsAE2RDGSNuEM50X5CZkpi/8d
         q5u9WLCx1T9QtJj8ouXJpGQq2sJqQhWuPpeCtDbRi+p+9sR6nqHKnQ2y5zAl9+e7STUs
         mZu1tkmYEpz4r0yV457riBwYIjGJvTzk3FmpjRKfncalzDmILG5A0hllmigM9snQ6nz7
         JVYyOwU2lcHFbx/ls+5o+p5oq1tFi66tV6OTx9ky51k4GgBOOZFKmqowIFDr+9DDOi5K
         pBTQ==
X-Gm-Message-State: AOAM531ED8udJ5V7AXOHgeypRlcRDRpJ43BomU3liWLv9MtWD5mnb9+R
        nCGxScHW8LzTxyfVmEaeDoX+Ulz667YSexpgJ9KXXAXxe3Ao17x73IG+6gRkK0zz+9B8ldEq1ow
        zjvGIKmX9wYoadrlFx5/8vviaXpd05h9DCeImt1DL4O3ORF6ykmo7vZG2lw==
X-Received: by 2002:aa7:d14b:: with SMTP id r11mr2310369edo.259.1628505653584;
        Mon, 09 Aug 2021 03:40:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnHbkmIOUTUWSswJfTs1SmIaBAV7fRdedHHxSG62cUIY/HN1GemhnpOzdqp2OTaTvc85JTwWtsK2Woht3zZKs=
X-Received: by 2002:aa7:d14b:: with SMTP id r11mr2310336edo.259.1628505653314;
 Mon, 09 Aug 2021 03:40:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210713075726.1232938-1-kai.heng.feng@canonical.com>
 <20210809042414.107430-1-kai.heng.feng@canonical.com> <20210809094731.GA16595@wunner.de>
In-Reply-To: <20210809094731.GA16595@wunner.de>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 9 Aug 2021 18:40:41 +0800
Message-ID: <CAAd53p7cR3EzUjEU04cDhJDY5F=5k+eRHMVNKQ=jEfbZvUQq3Q@mail.gmail.com>
Subject: Re: [PATCH] PCI/portdrv: Disallow runtime suspend when waekup is
 required but PME service isn't supported
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Keith Busch <kbusch@kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 9, 2021 at 5:47 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> [cc += Mika]
>
> On Mon, Aug 09, 2021 at 12:24:12PM +0800, Kai-Heng Feng wrote:
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=213873
>
> The last comment on this bugzilla says "BIOS will fix this."
> and the status is RESOLVED WILL_NOT_FIX.
>
> Why is the patch still necessary?

Well, let me update the bug report.

>
>
> > Some platforms cannot detect ethernet hotplug once its upstream port is
> > runtime suspended because PME isn't enabled in _OSC.
>
> If PME is not handled natively, why does the NIC runtime suspend?
> Shouldn't this be fixed in the NIC driver by keeping the device
> runtime active if PME cannot be used?

That means we need to fix every user of pci_dev_run_wake(), or fix the
issue in pci_dev_run_wake() helper itself.
However, I am afraid that implementing the fix in pci_dev_run_wake()
may break the while loop check:
bool pci_dev_run_wake(struct pci_dev *dev)
{
 ...
        while (bus->parent) {
                struct pci_dev *bridge = bus->self;

                if (device_can_wakeup(&bridge->dev))
                        return true;

                bus = bus->parent;
...
}

So I took the current approach.

>
>
> > Disallow port runtime suspend when any child device requires wakeup, so
> > pci_pme_list_scan() can still read the PME status from the devices
> > behind the port.
>
> pci_pme_list_scan() is for broken devices which fail to signal PME.
> Is this NIC really among them or does PME fail merely because it's not
> granted to OSPM?

The latter, PME IRQ isn't enabled because it's not granted by BIOS _OSC.

>
>
> > --- a/drivers/pci/pcie/portdrv_pci.c
> > +++ b/drivers/pci/pcie/portdrv_pci.c
> > @@ -59,14 +59,30 @@ static int pcie_port_runtime_suspend(struct device *dev)
> >       return pcie_port_device_runtime_suspend(dev);
> >  }
> >
> > +static int pcie_port_wakeup_check(struct device *dev, void *data)
> > +{
> > +     struct pci_dev *pdev = to_pci_dev(dev);
> > +
> > +     if (!pdev)
> > +             return 0;
> > +
> > +     return pdev->wakeup_prepared;
> > +}
> > +
> >  static int pcie_port_runtime_idle(struct device *dev)
> >  {
> > +     struct pci_dev *pdev = to_pci_dev(dev);
> > +
> > +     if (!pcie_port_find_device(pdev, PCIE_PORT_SERVICE_PME) &&
> > +         device_for_each_child(dev, NULL, pcie_port_wakeup_check))
> > +             return -EBUSY;
> > +
> >       /*
> >        * Assume the PCI core has set bridge_d3 whenever it thinks the port
> >        * should be good to go to D3.  Everything else, including moving
> >        * the port to D3, is handled by the PCI core.
> >        */
> > -     return to_pci_dev(dev)->bridge_d3 ? 0 : -EBUSY;
> > +     return pdev->bridge_d3 ? 0 : -EBUSY;
>
> If an additional check is necessary for this issue, it should be
> integrated into pci_dev_check_d3cold() instead of pcie_port_runtime_idle().

I think PME IRQ and D3cold are different things here.
The root port of the affected NIC doesn't support D3cold because
there's no power resource.

Kai-Heng

>
> Thanks,
>
> Lukas
