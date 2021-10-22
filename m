Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE82943705D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 05:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbhJVDHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 23:07:18 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:49876
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231144AbhJVDHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 23:07:15 -0400
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 33E1C3FFEE
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 03:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634871898;
        bh=czP4Ea2xbNw6ZO8jbHXfBJMEwAvUTKs/9udO2IJpk58=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=q9TSZG80DKOGmJLLszOiMTPcHaGPUigKvzifjD/YY8aSoFNNjbXB1ViOlk1df3Qc2
         HYQRO31+KOLuFsAO0CphnpvyqZKNiKmHsdGeX6U78DyPzujKt82MbC87EBWdq2LVfn
         aCejHEKA288Eb134liSN2j1uZ/cioPC5yCPbI7MBWtcsvEwC7iDr4/Zwm1RXeIlGlJ
         MyjpXsh6x8J/wcbKMwiiAAKL1VGHsTCH+x7iR4WV6h7pCFMzPmuJVnWTEt3E1/0gSl
         ptaGGxkzTPy9IIL1SN5hwAbAo4XKQaIuwwE8RAlLv5ZGhK97/t7Etd89ruwcP9WXhE
         lF8XfVFRteONw==
Received: by mail-ot1-f69.google.com with SMTP id w9-20020a056830078900b0054e753940beso1268128ots.15
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 20:04:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=czP4Ea2xbNw6ZO8jbHXfBJMEwAvUTKs/9udO2IJpk58=;
        b=hFvdRx0cR72TwyDLM3NmTbziAeFy5prvM1M4eWfb9nm8r+GHwJM9PYa0Juwh6t3Mcr
         wWdlYYJMHYwawZ6gwB+tnZj46yERk+7seOIyOiizSTOOQMaJ8Z7JjtzldXvQNuxDXp/2
         LrntTqQMoynkOFHTv8DCrd9qt/g9+KWB/bHNYGwOMYzJ0dsbJrtzv0i9+Fg+Rfkc9jJ1
         NX82cbHhdJz+1l8wM+z+ZHFZN4qKnRSTBNdtcI23vFDZjvSCVCMXtvwFHTJ2iawnCY+I
         7nSOYxCKoVsnSWlFgDIgsdFpoQzMf/ilYswzVb5rdnyC0hhK6tWZo5lgoMaAfVVsPDYX
         86hQ==
X-Gm-Message-State: AOAM5302NbpF47alH3BELDFZ1zJmcUCFQgSFNnVrpH/nGNvMvH2vDbIr
        zjSV071P+NMgsWDg7E9/gpMJEwg1uFsX6WwiCDHJynpC4+AYcNP//NjebJKericWNFdi3/StwhN
        8W4zaqIyJ+MvwQwCwI5W96kPXKTKxkLkDSajAyvlJjfYTsMKrY7ko5mB3Nw==
X-Received: by 2002:a9d:7b49:: with SMTP id f9mr7872673oto.11.1634871897079;
        Thu, 21 Oct 2021 20:04:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxrGgk5WJvr6Krib82/6R5NLnLs2soauLJ1bJ9ZM09LF2vJUdZI1z78f9FH+iGor3wn7boMKQMksA61S53sZA=
X-Received: by 2002:a9d:7b49:: with SMTP id f9mr7872656oto.11.1634871896762;
 Thu, 21 Oct 2021 20:04:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210812153944.813949-1-kai.heng.feng@canonical.com>
 <CAAd53p7sPoH-MD9VMh1u+mf_E7Mc2xVfkHbhN4PCdxQM+v274g@mail.gmail.com> <6289c754-3580-4102-8ff2-666c3cad8da2@intel.com>
In-Reply-To: <6289c754-3580-4102-8ff2-666c3cad8da2@intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 22 Oct 2021 11:04:44 +0800
Message-ID: <CAAd53p5ZUDjjaWPHE4p1vg=3LzcCovngdS8VO0uFuVanEtAAYg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Check PCIe upstream port for PME support
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 3:13 AM Rafael J. Wysocki
<rafael.j.wysocki@intel.com> wrote:
>
> On 10/21/2021 8:56 AM, Kai-Heng Feng wrote:
> > On Thu, Aug 12, 2021 at 11:39 PM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> >> Some platforms cannot detect ethernet hotplug once its upstream port is
> >> runtime suspended because PME isn't granted by BIOS _OSC. The issue can
> >> be workarounded by "pcie_ports=native".
> >>
> >> The vendor confirmed that the PME in _OSC is disabled intentionally for
> >> system stability issues on the other OS, so we should also honor the PME
> >> setting here.
> >>
> >> So before marking PME support status for the device, check
> >> PCI_EXP_RTCTL_PMEIE bit to ensure PME interrupt is either enabled by
> >> firmware or OS.
> >>
> >> Cc: Lukas Wunner <lukas@wunner.de>
> >> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> >> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=213873
> >> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > A gentle ping...
>
> Any chance to CC this to linux-pm too?

Will remember this next time.

>
> So you basically want to check whether or not the PME interrupts are
> configured on the port?

Yes, that's the idea here.

Kai-Heng

>
>
> >> ---
> >> v2:
> >>   - Instead of prevent root port from runtime suspending, skip
> >>     initializing PME status for the downstream device.
> >>
> >>   drivers/pci/pci.c | 28 +++++++++++++++++++++++++++-
> >>   1 file changed, 27 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >> index aacf575c15cf..4344dc302edd 100644
> >> --- a/drivers/pci/pci.c
> >> +++ b/drivers/pci/pci.c
> >> @@ -2294,6 +2294,32 @@ void pci_pme_wakeup_bus(struct pci_bus *bus)
> >>                  pci_walk_bus(bus, pci_pme_wakeup, (void *)true);
> >>   }
> >>
> >> +#ifdef CONFIG_PCIE_PME
> >> +static bool pci_pcie_port_pme_enabled(struct pci_dev *dev)
> >> +{
> >> +       struct pci_dev *bridge = pci_upstream_bridge(dev);
> >> +       u16 val;
> >> +       int ret;
> >> +
> >> +       if (!bridge)
> >> +               return true;
> >> +
> >> +       if (pci_pcie_type(bridge) != PCI_EXP_TYPE_ROOT_PORT &&
> >> +           pci_pcie_type(bridge) != PCI_EXP_TYPE_RC_EC)
> >> +               return true;
> >> +
> >> +       ret = pcie_capability_read_word(bridge, PCI_EXP_RTCTL, &val);
> >> +       if (ret)
> >> +               return false;
> >> +
> >> +       return val & PCI_EXP_RTCTL_PMEIE;
> >> +}
> >> +#else
> >> +static bool pci_pcie_port_pme_enabled(struct pci_dev *dev)
> >> +{
> >> +       return true;
> >> +}
> >> +#endif
> >>
> >>   /**
> >>    * pci_pme_capable - check the capability of PCI device to generate PME#
> >> @@ -3095,7 +3121,7 @@ void pci_pm_init(struct pci_dev *dev)
> >>          }
> >>
> >>          pmc &= PCI_PM_CAP_PME_MASK;
> >> -       if (pmc) {
> >> +       if (pmc && pci_pcie_port_pme_enabled(dev)) {
> >>                  pci_info(dev, "PME# supported from%s%s%s%s%s\n",
> >>                           (pmc & PCI_PM_CAP_PME_D0) ? " D0" : "",
> >>                           (pmc & PCI_PM_CAP_PME_D1) ? " D1" : "",
> >> --
> >> 2.32.0
> >>
>
