Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E61A39A9B2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 20:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhFCSF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 14:05:27 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:42518 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhFCSF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:05:26 -0400
Received: by mail-wm1-f46.google.com with SMTP id o2-20020a05600c4fc2b029019a0a8f959dso4216854wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 11:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iGiwzAqsyZVjuWog2CKsBWz7P5Is31TchRL5oaKcvSc=;
        b=NRjOTti9YvPUq9yeF65sVUkWtlJ/hXgFgGtFjrov2e3mcCdEs2pmp4XG2GTgXzhS0I
         Ozyc5euVTFtoU7zSlKHoWYA6dhsLHxAUaimYmUxt2HIMiosoIy+jhu5YhwBpJkv6gbiX
         E7i44OG+V2UUzljqr4osrF+h9p+DUI8MW3lus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iGiwzAqsyZVjuWog2CKsBWz7P5Is31TchRL5oaKcvSc=;
        b=gatbB2uUQbKZPZjLNSl+Vdiu0W4uoVoZu0+4vf49VARbnMvarXhlak5/IeK8WQG7PK
         q44CsvXG+obizUiJ9RFs/0qi+1+TOYqcbZT11UlEr5flWu6ed0JsqWEheYHQf1fYX6GY
         PJLhsj1qF8yYPQ0xXwy+CamODPCoYjqnGnlOqoPlkwj6KFsanLncN/iAPL2iUwn6e2cR
         Hypv8DquAKuQ4Z2NjmPIuajf78mE0gWQIWMGdQWY+b+1Bag+V0/DpKc73nmRAgZ791Db
         cEnZm3Ejfeb1cvlE9iVG2L8rxNfScuRAXJEf3kZlFCgygZ79CV+VskuGl5YZy19SvL3y
         O/eA==
X-Gm-Message-State: AOAM532B3QxxDmnrT3AIqFtgdKbYLj/1sEPKRtDwCXHLyTTft9lynzeF
        Jl5k5iZll8KJXgPM7RiVE4YDBpO60Yb2EQh9IqPCAw==
X-Google-Smtp-Source: ABdhPJzg+UYBIV0v5Q6wCC+S44IFOhCyh2XPYVyTESOIfc2mGW9FACqvqMWcVDsN/SVQl1RguShM7Z2tsw1kAr7SWaE=
X-Received: by 2002:a7b:c847:: with SMTP id c7mr305986wml.168.1622743360109;
 Thu, 03 Jun 2021 11:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210506153153.30454-1-pali@kernel.org> <20210603151605.GA18917@lpieralisi>
In-Reply-To: <20210603151605.GA18917@lpieralisi>
From:   Simon Glass <sjg@chromium.org>
Date:   Thu, 3 Jun 2021 12:02:28 -0600
Message-ID: <CAPnjgZ38G2Xzz1pTp3kCdaTZrDe+hKoBbqsGLKHyLfjUM7wH7g@mail.gmail.com>
Subject: Re: [PATCH 00/42] PCI: aardvark: Various driver fixes
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        lak <linux-arm-kernel@lists.infradead.org>,
        lk <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 3 Jun 2021 at 09:17, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Thu, May 06, 2021 at 05:31:11PM +0200, Pali Roh=C3=A1r wrote:
> > This patch series fixes various issues in pci-aardvark.c driver
> > (PCIe controller on Marvell Armada 3700 SoC) used on Espressobin
> > and Turris Mox.
> >
> > First patch fixes kernel panic (or TF-A panic depending on used
> > firmware) during execution of PIO transfer and I would suggest to
> > include this fix into v5.13 release to prevent future kernel panics.
> >
> > Other patches then fixes PIO issues, PCIe link training, initialization
> > of PCIe controller, accessing PCIe Root Bridge/Port registers, handling
> > of interrupts (including ERR and PME), setup of Multi-MSI interrupts,
> > adding support for masking MSI interrupts, adding support for more than
> > 32 MSI interrupts with MSI-X support, and adding support for AER.
> >
> > Note that there are still some unresolved issues with PCIe on A3720.
> > I asked Marvell for PCIe documentation or explanations but I have not
> > received anything (yet).
> >
> > Patch "Fix checking for PIO status" is taken from the Marvell github fo=
rk
> > and adapted for inclusion into mainline kernel:
> > https://github.com/MarvellEmbeddedProcessors/linux-marvell/commit/84444=
d22023c
> >
> > Whole patch series is available also in my git branch pci-aardvark:
> > https://git.kernel.org/pub/scm/linux/kernel/git/pali/linux.git/log/?h=
=3Dpci-aardvark
> >
> > If you have Espressobin, Turris Mox or other A3720 board with PCIe
> > please test this patch series with your favourite PCIe card if
> > everything is working fine.
> >
> > Evan Wang (1):
> >   PCI: aardvark: Fix checking for PIO status
> >
> > Pali Roh=C3=A1r (39):
> >   PCI: aardvark: Fix kernel panic during PIO transfer
> >   PCI: aardvark: Fix checking for PIO Non-posted Request
> >   PCI: aardvark: Increase polling delay to 1.5s while waiting for PIO
> >     response
> >   PCI: pci-bridge-emul: Add PCIe Root Capabilities Register
> >   PCI: aardvark: Fix reporting CRS Software Visibility on emulated
> >     bridge
> >   PCI: aardvark: Fix link training
> >   PCI: Add PCI_EXP_DEVCTL_PAYLOAD_* macros
> >   PCI: aardvark: Fix PCIe Max Payload Size setting
> >   PCI: aardvark: Implement workaround for the readback value of VEND_ID
> >   PCI: aardvark: Do not touch status bits of masked interrupts in
> >     interrupt handler
> >   PCI: aardvark: Check for virq mapping when processing INTx IRQ
> >   PCI: aardvark: Remove irq_mask_ack callback for INTx interrupts
> >   PCI: aardvark: Don't mask irq when mapping
> >   PCI: aardvark: Change name of INTx irq_chip to advk-INT
> >   PCI: aardvark: Remove unneeded goto
> >   PCI: aardvark: Fix support for MSI interrupts
> >   PCI: aardvark: Correctly clear and unmask all MSI interrupts
> >   PCI: aardvark: Fix setting MSI address
> >   PCI: aardvark: Add support for more than 32 MSI interrupts
> >   PCI: aardvark: Add support for masking MSI interrupts
> >   PCI: aardvark: Enable MSI-X support
> >   PCI: aardvark: Fix support for ERR interrupt on emulated bridge
> >   PCI: aardvark: Fix support for PME on emulated bridge
> >   PCI: aardvark: Fix support for PME requester on emulated bridge
> >   PCI: aardvark: Fix support for bus mastering and PCI_COMMAND on
> >     emulated bridge
> >   PCI: aardvark: Disable bus mastering and mask all interrupts when
> >     unbinding driver
> >   PCI: aardvark: Free config space for emulated root bridge when
> >     unbinding driver to fix memory leak
> >   PCI: aardvark: Reset PCIe card and disable PHY when unbinding driver
> >   PCI: aardvark: Rewrite irq code to chained irq handler
> >   PCI: aardvark: Use separate INTA interrupt for emulated root bridge
> >   PCI: pci-bridge-emul: Add description for class_revision field
> >   PCI: pci-bridge-emul: Add definitions for missing capabilities
> >     registers
> >   PCI: aardvark: Add support for DEVCAP2, DEVCTL2, LNKCAP2 and LNKCTL2
> >     registers on emulated bridge
> >   PCI: aardvark: Add support for PCI_BRIDGE_CTL_BUS_RESET on emulated
> >     bridge
> >   PCI: aardvark: Replace custom PCIE_CORE_ERR_CAPCTL_* macros by
> >     linux/pci_regs.h macros
> >   PCI: aardvark: Replace custom PCIE_CORE_INT_* macros by linux
> >     PCI_INTERRUPT_* values
> >   PCI: aardvark: Cleanup some register macros
> >   PCI: aardvark: Add comments for OB_WIN_ENABLE and ADDR_WIN_DISABLE
> >   PCI: aardvark: Add support for Advanced Error Reporting registers on
> >     emulated bridge
> >
> > Russell King (2):
> >   PCI: pci-bridge-emul: re-arrange register tests
> >   PCI: pci-bridge-emul: add support for PCIe extended capabilities
> >
> >  drivers/pci/controller/pci-aardvark.c | 980 +++++++++++++++++++-------
> >  drivers/pci/pci-bridge-emul.c         | 149 ++--
> >  drivers/pci/pci-bridge-emul.h         |  17 +-
> >  include/uapi/linux/pci_regs.h         |   6 +
> >  4 files changed, 850 insertions(+), 302 deletions(-)
>
> May I ask you please to split this series in smaller sets so that
> it is easier to merge ?
>
> Let's start with the more urgent fixes that don't involve rework (or
> you have not received change requests for since they are simple).

Is this due to the difficulty / time for reviewing them?

I feel it is a bit tough to ask someone to split a series, when it is
already nicely split into patches. Reordering to put the important
things first seems reasonable. Otherwise perhaps people can just
review what they can?

Regards,
Simon
