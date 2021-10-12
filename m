Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D7242AFB2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 00:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235796AbhJLWhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 18:37:37 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:55916
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232419AbhJLWhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 18:37:32 -0400
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2155B3F338
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 22:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634078128;
        bh=JdyWx+2ERSnViZDVbDwwgVFOd8VEAu/EAtgOsXvDSgc=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=dVNz4oPEGQ9XE4tvCDIoOBebJJxx4Kql1Y1RLm48oNLy3MIQSIAx5agcreYruGWL4
         G+G2E+ocVOPPKfcDom4ykJJ0z0ANEgKFz3k0UlxrXm0DPXPi6K5RGntmHkIpp11szW
         zOGxveFyIQwvMvtc2wXLbQAbaFyQWDLWNWfnqAkNfJmG043xozrYtfwAW44k6EWuh3
         5J+NhBuJ5991jots6gQiADoLNNtYzp5XDSaxqZbES5jU/H/QIbaBIUa4xEL3dNiaJP
         KRaBDC6P02eEZQDY1Qfs6VnFJWvhruQOQqKVcJf5+5lfQ4T9ZXdUDd3HUNT2Cu7ol9
         sYr3Due6HRhaQ==
Received: by mail-pg1-f200.google.com with SMTP id p19-20020a634f53000000b002877a03b293so277730pgl.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 15:35:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JdyWx+2ERSnViZDVbDwwgVFOd8VEAu/EAtgOsXvDSgc=;
        b=6X2V3UBE8hFhVBh8voQEe/ljw+UPovgySICbH6K9wcireNEbCBHfHq4vSkMOEDRcZ2
         lPKURO6M/UU7HHbiZDj4eiuuv5vASzjN0kaM+sTC7s1YmAR4lQytV2T+qWO1mIlq+waP
         23f40xjuDujMk3pByUfqGLbN5g1yvqSb03lL+OTHgYqoQuE/jUeQrdNnPgGIPVNkZ10V
         Sbanc4xeVY9SCEEnTeslFa+wWx5sE/keQEc7TI0o/kBtWu27fkUw01e7Gi+sNoVgKT3y
         JLTGEJu0hMJJ3r57oJRtuiw/fFYFb5BfqeXdmOEwaXUHPBAAH+a5W8MwIopQBixV5vWP
         3tsg==
X-Gm-Message-State: AOAM530qzKkTyyANe6eABC7pZsBCXTaxmF8H2nYvr1L6KsWpWBNZgpYu
        hzi67jgxIMw22gEXRlPVcBVEVFlkkldcRqheAj1OkdsutcdbNAP546qiUe9Z2Z1NeWDKLcsP3kJ
        GYGLtxOgBEu+D8tGUOSIn4hJp88YtF88tRvmvxJtfRp/b78sunrY9dOZy7Q==
X-Received: by 2002:a17:90a:e552:: with SMTP id ei18mr9106970pjb.239.1634078126702;
        Tue, 12 Oct 2021 15:35:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPZHBuI2h8GZ3aiVR/3gWtNcOG0SGFTakfr7kOOYkbT+7szM6417piCAlzL2Fpr33usykNkq3jlxg2CT02vms=
X-Received: by 2002:a17:90a:e552:: with SMTP id ei18mr9106945pjb.239.1634078126288;
 Tue, 12 Oct 2021 15:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <d4084296-9d36-64ec-8a79-77d82ac6d31c@canonical.com>
 <20210914104301.48270518.alex.williamson@redhat.com> <9e8d0e9e-1d94-35e8-be1f-cf66916c24b2@canonical.com>
 <20210915103235.097202d2.alex.williamson@redhat.com> <2fadf33d-8487-94c2-4460-2a20fdb2ea12@canonical.com>
 <20211005171326.3f25a43a.alex.williamson@redhat.com> <CAKAwkKtJQ1mE3=iaDA1B_Dkn1+ZbN0jTSWrQon0=SAszRv5xFw@mail.gmail.com>
 <20211012140516.6838248b.alex.williamson@redhat.com>
In-Reply-To: <20211012140516.6838248b.alex.williamson@redhat.com>
From:   Matthew Ruffell <matthew.ruffell@canonical.com>
Date:   Wed, 13 Oct 2021 11:35:14 +1300
Message-ID: <CAKAwkKsF3Kn1HLAg55cBVmPmo2y0QAf7g6Zc7q6ZsQZBXGW9bg@mail.gmail.com>
Subject: Re: [PROBLEM] Frequently get "irq 31: nobody cared" when passing
 through 2x GPUs that share same pci switch via vfio
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     linux-pci@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        kvm@vger.kernel.org, nathan.langford@xcelesunifiedtechnologies.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Wed, Oct 13, 2021 at 9:05 AM Alex Williamson
<alex.williamson@redhat.com> wrote:
> On Tue, 12 Oct 2021 17:58:07 +1300
> Matthew Ruffell <matthew.ruffell@canonical.com> wrote:
> > Nathan does have a small side effect to report:
> >
> > > The only thing close to an issue that I have is that I still get frequent
> > > "irq 112: nobody cared" and "Disabling IRQ #112" errors. They just no longer
> > > lockup the system. If I watch the reproducer time between VM resets, I've
> > > noticed that it takes longer for the VM to startup after one of these
> > > "nobody cared" errors, and thus it takes longer until I can reset the VM again.
> > > I believe slow guest behavior in this disabled IRQ scenario is expected though?
>
> The device might need to be operating in INTx mode, or at least had
> been at some point, to get the register filled.  It's essentially just
> a scratch register on the card that gets filled when the interrupt is
> configured.
>
> Each time we register a new handler for the irq the masking due to
> spurious interrupt will be removed, but if it's actually causing the VM
> boot to take longer that suggests to me that the guest driver is
> stalled, perhaps because it's expecting an interrupt that's now masked
> in the host.  This could also be caused by a device that gets
> incorrectly probed for PCI-2.3 compliant interrupt masking.  For
> probing we can really only test that we have the ability to set the
> DisINTx bit, we can only hope that the hardware folks also properly
> implemented the INTx status bit to indicate the device is signaling
> INTx.  We should really figure out which device this is so that we can
> focus on whether it's another shared interrupt issue or something
> specific to the device.

Nathan got back to me and the device is that same GPU audio controller pair from
before, so it might be another shared interrupt issue, since they both
share 112.

$ sudo lspci -vvv | grep "IRQ 112" -B 5 -A 10
88:00.1 Audio device: NVIDIA Corporation TU102 High Definition Audio
Controller (rev a1)
        Subsystem: eVga.com. Corp. TU102 High Definition Audio Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin B routed to IRQ 112
        NUMA node: 1
        Region 0: Memory at f7080000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [60] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [78] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s
unlimited, L1 <64us
                        ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+
FLReset- SlotPowerLimit 25.000W
-- 
89:00.1 Audio device: NVIDIA Corporation TU102 High Definition Audio
Controller (rev a1)
        Subsystem: eVga.com. Corp. TU102 High Definition Audio Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin B routed to IRQ 112
        NUMA node: 1
        Region 0: Memory at f5080000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [60] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [78] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s
unlimited, L1 <64us
                        ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+
FLReset- SlotPowerLimit 25.000W

> I'm also confused why this doesn't trigger the same panic/kexec as we
> were seeing with the other interrupt lines.  Are there some downstream
> patches or configs missing here that would promote these to more fatal
> errors?
>
There aren't any downstream patches, since the machine lockup happens with
regular mainline kernels too. Even without panic on oops set, the system will
grind to a halt and hang. The panic on oops sysctl was an attempt to get the
machine to reboot to the crashkernel and restart again, but it didn't work very
well since we get stuck copying the IR tables from DMAR.

But your patches seem to fix the hang, which is very promising.

Thanks,
Matthew
