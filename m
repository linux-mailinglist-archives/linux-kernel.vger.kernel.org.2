Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C59F445BFD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 23:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbhKDWI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 18:08:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44868 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231849AbhKDWIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 18:08:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636063545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ioLGo78Q2H5OCVLHqS6Gc52ME4lW3G+b/fKIEsBxo2U=;
        b=A7EFybuY9o7DNTZhWEc9vsoSrTt7Qp8VTx42700eiltnp/yKdN+Y9z0sMYotNg/WHX9n0R
        pJxsCeMNasHXZ+9oLxWZcBXLBeFR1wMX/uOn0E3ffrBmhZ6H+QB/R5L4vuinE+v2G8Hnhp
        l+356tt6xhksCLsl1EWhWB9VNyFPBiE=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-dCwQd3KgM2ymZlKIGRk6eA-1; Thu, 04 Nov 2021 18:05:44 -0400
X-MC-Unique: dCwQd3KgM2ymZlKIGRk6eA-1
Received: by mail-ot1-f69.google.com with SMTP id u20-20020a056830231400b00553d30b1854so3715599ote.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 15:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=ioLGo78Q2H5OCVLHqS6Gc52ME4lW3G+b/fKIEsBxo2U=;
        b=fnb1m2t1oOzIclAWxnQAflOYj5DL+GjM92Aqkm6do0fEPZO7/fowUhb2iUMJyNhdXM
         EKlZ1elC9yKEAQi5bBe3pJit+NaqLXa0mo8hNg+0+s3agsT1eSQvlpRRxgjTzcMVAzjl
         S1bkl+XEuu5P3Ez7ZTpteI0pNv4cIJRC4b7XnHf9Dsp8JeCv4TprJ8H3kMq4xwjII+iO
         AFLfXUCptYKvKU+7/3GB5O1gX8mhWufGoGK6vYRHi4mepVA8fML7KoAJYHeF5GOiiosb
         Cf1kX2EnRoRayHNUglyfiu3PqCIvIRXsDSM+Ly6ZzMKuXgwfWvmNkVA5RUywTNrJOLj5
         dU8Q==
X-Gm-Message-State: AOAM531JNZJv+vyS2QHCRXvlODCilJyPFYcbZJiupMACrNc3nxerDp8K
        LGr//jiJ+IdO/m+q2U9JiliEMYr1AQPaA+SxdACVu0mn8MQC8IxmFYoqDGSROjin5tq6BpLrxAZ
        wF7fduLFDVEf0uPuXkx6b72Mg
X-Received: by 2002:a9d:5a9b:: with SMTP id w27mr4665587oth.337.1636063543928;
        Thu, 04 Nov 2021 15:05:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6ni+u9UTnb+zRRJcR39oUjj2OfNF70f3wnC/+24jb1PhSuPs3ioqBdmn7Zbjze9F56ntg5g==
X-Received: by 2002:a9d:5a9b:: with SMTP id w27mr4665556oth.337.1636063543650;
        Thu, 04 Nov 2021 15:05:43 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id g94sm1655894otg.10.2021.11.04.15.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 15:05:43 -0700 (PDT)
Date:   Thu, 4 Nov 2021 16:05:41 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Matthew Ruffell <matthew.ruffell@canonical.com>
Cc:     linux-pci@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        kvm@vger.kernel.org, nathan.langford@xcelesunifiedtechnologies.com
Subject: Re: [PROBLEM] Frequently get "irq 31: nobody cared" when passing
 through 2x GPUs that share same pci switch via vfio
Message-ID: <20211104160541.4aedc593.alex.williamson@redhat.com>
In-Reply-To: <CAKAwkKsoKELnR=--06sRZL3S6_rQVi5J_Kcv6iRQ6w2tY71WCQ@mail.gmail.com>
References: <d4084296-9d36-64ec-8a79-77d82ac6d31c@canonical.com>
        <20210914104301.48270518.alex.williamson@redhat.com>
        <9e8d0e9e-1d94-35e8-be1f-cf66916c24b2@canonical.com>
        <20210915103235.097202d2.alex.williamson@redhat.com>
        <2fadf33d-8487-94c2-4460-2a20fdb2ea12@canonical.com>
        <20211005171326.3f25a43a.alex.williamson@redhat.com>
        <CAKAwkKtJQ1mE3=iaDA1B_Dkn1+ZbN0jTSWrQon0=SAszRv5xFw@mail.gmail.com>
        <20211012140516.6838248b.alex.williamson@redhat.com>
        <CAKAwkKsF3Kn1HLAg55cBVmPmo2y0QAf7g6Zc7q6ZsQZBXGW9bg@mail.gmail.com>
        <CAKAwkKsoKELnR=--06sRZL3S6_rQVi5J_Kcv6iRQ6w2tY71WCQ@mail.gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Nov 2021 17:35:04 +1300
Matthew Ruffell <matthew.ruffell@canonical.com> wrote:

> Hi Alex,
> 
> Nathan has been running a workload on the 5.14 kernel + the test patch, and has
> ran into some interesting softlockups and hardlockups.
> 
> The first, happened on a secondary server running a Windows VM, with 7 (of 10)
> 1080TI GPUs passed through.
> 
> Full dmesg:
> https://paste.ubuntu.com/p/Wx5hCBBXKb/
> 
> There isn't any "irq x: nobody cared" messages, and the crashkernel gets stuck
> in the usual copying IR tables from dmar, which suggests an ongoing interrupt
> storm.
> 
> Nathan disabled "kernel.hardlockup_panic = 1" sysctl, and managed to reproduce
> the issue again, suggesting that we get stuck in kernel space for too long
> without the ability for interrupts to be serviced.
> 
> It starts with the NIC hitting a tx queue timeout, and then does a NMI to unwind
> the stack of each CPU, although the stacks don't appear to indicate where things
> are stuck. The server then remains softlocked, and keeps unwinding stacks every
> 26 seconds or so, until it eventually hardlockups.

Google finds numerous complaints about transmit queue time outs on igb
devices, bad NICs, bad cabling, bad drivers(?).  I also see some
hearsay related specifically to supermicro compatibility.  I'd also
suspect that a dual 1GbE NIC is sub-par for anything involving 7+ GPUs.
Time for an upgrade?

It's not clear to me how this would be related to the GPU assignment
perhaps other than the elevated workload on the host.

> The next interesting thing to report is when Nathan started the same Windows VM
> on the primary host we have been debugging on, with the 8x 2080TI GPUs. Nathan
> experienced a stuck VM, with the host responding just fine. When Nathan reset
> the VM, he got 4x "irq xx: nobody cared" messages on IRQs 25, 27, 29 and 31,
> which at the time corresponded to the PEX 8747 upstream PCI switches.
> 
> Interestingly, Nathan also observed 2x GPU Audio devices sharing the same IRQ
> line as the upstream PCI switch, although Nathan mentioned this only occured
> very briefly, and the GPU audio devices were re-assigned different IRQs shortly
> afterward.

IME, the legacy interrupt support on NVIDIA GPU audio devices is
marginal for assignment.  We don't claim to support assignment of the
audio function, even for Quadro cards on RHEL due to this.  I can't
remember the details off the top of my head, but even with the hacky
safeguards added in the test patch, we still rely on hardware to both
honor the INTx disable bit in the command register and accurately report
if the device is asserting INTx is the status register.  It seems like
one of these was a bit dicey in this controller.

Now that I think about it more, I recall that the issue was
predominantly with Linux guests, where the snd_intel_hda driver
includes:

/* quirks for Nvidia */
#define AZX_DCAPS_PRESET_NVIDIA \
        (AZX_DCAPS_NO_MSI | AZX_DCAPS_CORBRP_SELF_CLEAR |\
         AZX_DCAPS_SNOOP_TYPE(NVIDIA))

And the device table includes:

        { PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID),
          .class = PCI_CLASS_MULTIMEDIA_HD_AUDIO << 8,
          .class_mask = 0xffffff,
          .driver_data = AZX_DRIVER_NVIDIA | AZX_DCAPS_PRESET_NVIDIA },

That NO_MSI quirk forces the sound driver to use legacy interrupts for
all NVIDIA HD audio devices.  I think this made audio function
assignment to Linux guests essentially unusable without using the
snd_hda_intel.enable_msi=1 driver option to re-enable MSI.  Windows
uses MSI for these devices, so it works better by default, but when
we're resetting the VM we're still transitioning through this mode
where I don't have a good opinion that the hardware behaves in a
manageable way.

My PCIe switch configuration with NVIDIA GPUs only has Tesla cards, so
I don't have a way to reproduce this specific shared INTx issue, but it
may be time to revisit examining the register behavior while running in
INTx mode.  Thanks,

Alex

