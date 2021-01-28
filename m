Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B14A306BFA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 05:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhA1ELB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 23:11:01 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54173 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhA1EKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 23:10:33 -0500
Received: from mail-lj1-f199.google.com ([209.85.208.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1l4ycw-0002lt-AE
        for linux-kernel@vger.kernel.org; Thu, 28 Jan 2021 04:09:50 +0000
Received: by mail-lj1-f199.google.com with SMTP id 2so2354155ljr.17
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 20:09:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7fl7bm6buw7fD0rpOxqw4tFNpwhOF3QlYfdvY0hGN/E=;
        b=VYN6Bfctz/AnQ4+fB8qJvfaAfbZB7BuJwET002HbjlNiJr7TH2pmyVJ/n3YCeu6zxT
         Qv6BU0//PAZIqByyXIIwWNykBUHfz0EsAgcKIQG1Zruqli23Cur1N+TUteT37SsTQy+h
         W5E7QChGghwgBBRv90Kr6Ebgnvu4RVozS/7KX0STcXP+rUOEEXFz6dmKFD9RPK76TpYf
         O2yVTypPLOnS3OyPLtyQJzHP2johVI3HnXs7Q9J2mWWMagC0qgdJsHI7jMJwG2Z+mKVB
         AHFmmNnjzIYF1YvZ9W2n9+g7TN5LJNq8z7eF2Hr/GQydo/5hGYG2JfiB3rH1KtNyalIe
         PKJA==
X-Gm-Message-State: AOAM530hqAMnyEBplkbXHFl66OVyBHLX4SFNhMmNgM9r5zsG6KRTOYAU
        0tjqPxrCjKyAQYyVess3I1Yoihh4QLhJxUsA3OLoqdSp0gObt4kBhlfLFMNUMxgUBEavGSjedHg
        UZ6xm138PhffKmdso3XsA2HGXz60JlkFpZDcfS8kKNvUpXbw0QA5jJ+L/cw==
X-Received: by 2002:a2e:7a05:: with SMTP id v5mr7107376ljc.402.1611806989371;
        Wed, 27 Jan 2021 20:09:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzUZ61PxNciB0RDZ4gO3Vtagr/TV9bDy/Ex9ys0/59vTDw6Y6nGIPGqgglSPQLGt2i2uXLbz1zcOkH5OoCjSQU=
X-Received: by 2002:a2e:7a05:: with SMTP id v5mr7107359ljc.402.1611806989056;
 Wed, 27 Jan 2021 20:09:49 -0800 (PST)
MIME-Version: 1.0
References: <20210127173101.446940-1-kai.heng.feng@canonical.com> <20210127205053.GA3049358@bjorn-Precision-5520>
In-Reply-To: <20210127205053.GA3049358@bjorn-Precision-5520>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 28 Jan 2021 12:09:37 +0800
Message-ID: <CAAd53p7FfRCgfC5dGL3HyP+rbVtR2VCfMPYBBvJ=-DFCWFeVPA@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI/AER: Disable AER interrupt during suspend
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Russell Currey <ruscur@russell.cc>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        "open list:PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC" 
        <linuxppc-dev@lists.ozlabs.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 4:51 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Jan 28, 2021 at 01:31:00AM +0800, Kai-Heng Feng wrote:
> > Commit 50310600ebda ("iommu/vt-d: Enable PCI ACS for platform opt in
> > hint") enables ACS, and some platforms lose its NVMe after resume from
> > firmware:
> > [   50.947816] pcieport 0000:00:1b.0: DPC: containment event, status:0x1f01 source:0x0000
> > [   50.947817] pcieport 0000:00:1b.0: DPC: unmasked uncorrectable error detected
> > [   50.947829] pcieport 0000:00:1b.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Receiver ID)
> > [   50.947830] pcieport 0000:00:1b.0:   device [8086:06ac] error status/mask=00200000/00010000
> > [   50.947831] pcieport 0000:00:1b.0:    [21] ACSViol                (First)
> > [   50.947841] pcieport 0000:00:1b.0: AER: broadcast error_detected message
> > [   50.947843] nvme nvme0: frozen state error detected, reset controller
> >
> > It happens right after ACS gets enabled during resume.
> >
> > To prevent that from happening, disable AER interrupt and enable it on
> > system suspend and resume, respectively.
>
> Lots of questions here.  Maybe this is what we'll end up doing, but I
> am curious about why the error is reported in the first place.
>
> Is this a consequence of the link going down and back up?

Could be. From the observations, it only happens when firmware suspend
(S3) is used.
Maybe it happens when it's gets powered up, but I don't have equipment
to debug at hardware level.

If we use non-firmware suspend method, enabling ACS after resume won't
trip AER and DPC.

>
> Is it consequence of the device doing a DMA when it shouldn't?

If it's doing DMA while suspending, the same error should also happen
after NVMe is suspended and before PCIe port suspending.
Furthermore, if non-firmware suspend method is used, there's so such
issue, so less likely to be any DMA operation.

>
> Are we doing something in the wrong order during suspend?  Or maybe
> resume, since I assume the error is reported during resume?

Yes the error is reported during resume. The suspend/resume order
seems fine as non-firmware suspend doesn't have this issue.

>
> If we *do* take the error, why doesn't DPC recovery work?

It works for the root port, but not for the NVMe drive:
[   50.947816] pcieport 0000:00:1b.0: DPC: containment event,
status:0x1f01 source:0x0000
[   50.947817] pcieport 0000:00:1b.0: DPC: unmasked uncorrectable error detected
[   50.947829] pcieport 0000:00:1b.0: PCIe Bus Error:
severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Receiver
ID)
[   50.947830] pcieport 0000:00:1b.0:   device [8086:06ac] error
status/mask=00200000/00010000
[   50.947831] pcieport 0000:00:1b.0:    [21] ACSViol                (First)
[   50.947841] pcieport 0000:00:1b.0: AER: broadcast error_detected message
[   50.947843] nvme nvme0: frozen state error detected, reset controller
[   50.948400] ACPI: EC: event unblocked
[   50.948432] xhci_hcd 0000:00:14.0: PME# disabled
[   50.948444] xhci_hcd 0000:00:14.0: enabling bus mastering
[   50.949056] pcieport 0000:00:1b.0: PME# disabled
[   50.949068] pcieport 0000:00:1c.0: PME# disabled
[   50.949416] e1000e 0000:00:1f.6: PME# disabled
[   50.949463] e1000e 0000:00:1f.6: enabling bus mastering
[   50.951606] sd 0:0:0:0: [sda] Starting disk
[   50.951610] nvme 0000:01:00.0: can't change power state from D3hot
to D0 (config space inaccessible)
[   50.951730] nvme nvme0: Removing after probe failure status: -19
[   50.952360] nvme nvme0: failed to set APST feature (-19)
[   50.971136] snd_hda_intel 0000:00:1f.3: PME# disabled
[   51.089330] pcieport 0000:00:1b.0: AER: broadcast resume message
[   51.089345] pcieport 0000:00:1b.0: AER: device recovery successful

But I think why recovery doesn't work for NVMe is for another discussion...

Kai-Heng

>
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=209149
> > Fixes: 50310600ebda ("iommu/vt-d: Enable PCI ACS for platform opt in hint")
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/pci/pcie/aer.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index 77b0f2c45bc0..0e9a85530ae6 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -1365,6 +1365,22 @@ static int aer_probe(struct pcie_device *dev)
> >       return 0;
> >  }
> >
> > +static int aer_suspend(struct pcie_device *dev)
> > +{
> > +     struct aer_rpc *rpc = get_service_data(dev);
> > +
> > +     aer_disable_rootport(rpc);
> > +     return 0;
> > +}
> > +
> > +static int aer_resume(struct pcie_device *dev)
> > +{
> > +     struct aer_rpc *rpc = get_service_data(dev);
> > +
> > +     aer_enable_rootport(rpc);
> > +     return 0;
> > +}
> > +
> >  /**
> >   * aer_root_reset - reset Root Port hierarchy, RCEC, or RCiEP
> >   * @dev: pointer to Root Port, RCEC, or RCiEP
> > @@ -1437,6 +1453,8 @@ static struct pcie_port_service_driver aerdriver = {
> >       .service        = PCIE_PORT_SERVICE_AER,
> >
> >       .probe          = aer_probe,
> > +     .suspend        = aer_suspend,
> > +     .resume         = aer_resume,
> >       .remove         = aer_remove,
> >  };
> >
> > --
> > 2.29.2
> >
