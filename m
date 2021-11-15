Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1A544FDEF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 05:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237516AbhKOEfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 23:35:51 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:43722
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230319AbhKOEfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 23:35:43 -0500
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 38D643F177
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 04:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1636950764;
        bh=r4ZWGl3iCPA6hDwfXpoPdrYcadHNqNqEtZJMc3MEasI=;
        h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type;
        b=RtQ01VWK+RahGOS4kE38L8Mz+OYZ3KUaJrtV053u73JkwAiqC/+u3hB3JzOZIKHPv
         aMpW/TkcG3uMV0YMnXRKA6SiXNF5IbP7eO8bJhAmKC6AuTm7wDerxGIaZzlF8ZaQ6T
         +fYuyZ2vRIOeFRgvjCIsrW0qebO3XJTXBClJAPhujsPd3I5b5r48QHNKyLn8/1dchf
         fpvgMSmH9ziPz1iELzAXfMAuE7cORAl+uyJMbvnsEBHbQov0WBFvf1yd4Sn6JggQhf
         ivZuzVSSnz9elRkpewa/OmPbnoPNeM/38dDsxu7gyLWUi3gvLUQwZaloba115PZj0v
         jyiWOCFmNWE2g==
Received: by mail-pf1-f198.google.com with SMTP id 134-20020a62198c000000b0047bf0981003so9401919pfz.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 20:32:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=r4ZWGl3iCPA6hDwfXpoPdrYcadHNqNqEtZJMc3MEasI=;
        b=stoR/qPCU8aAEJVuaNL/TomlGYRBY57aqQ4ol3z6Z47sA6Jhnvtm3IItgtcUjCoYKR
         k4mGGbxHcUZx8dOUeI9nsUAtYwsCl9ErlFEP6x3n8YEFpLZuW1dRS1NBq2TdlW8UkiII
         c+98kZtww77ADmBLDmgACgC4+FGgF1bXseL5PaysbYsCwTgN1R1MI98fqxq1NqnWLyRT
         ovo5LegJHI05AoJQo1AKbxotjTiTyA+yZaMqjl6hobSwUCNr61OwYRBL+qwcUK29zSmh
         vJMvqqBQozMgRxRCuTeDHZxAcrdtN1IAgmvtFL1OctVFe073cnb6C36qghwOIJvWJbh2
         3pNg==
X-Gm-Message-State: AOAM531jy/J4l3dd+WOfzAKF2uaprMwdqg1OYqN6P4JXm8l+2i7vjOrv
        in6q6g9eZF63QNPQyMB3YL684CmmX7ZiDHJ7Yz/21nggmLg8ohuM70sWvKSJb2jdm1GU+0f582I
        j7G/ZiyaWFZ4KTiFD7tcWPlg7s+LOeAMkp4FvyubvKWuG9f/ic13BTU5x2g==
X-Received: by 2002:a65:6a4b:: with SMTP id o11mr22666650pgu.305.1636950762753;
        Sun, 14 Nov 2021 20:32:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzK3IH5Wl3v139keC34aAowOOjNz1B+4mSvW9CmmCutt4A9c/e138vdG3ipPqwlnRHQB8H048T5Duy6TNx+hJU=
X-Received: by 2002:a65:6a4b:: with SMTP id o11mr22666635pgu.305.1636950762477;
 Sun, 14 Nov 2021 20:32:42 -0800 (PST)
MIME-Version: 1.0
From:   Matthew Ruffell <matthew.ruffell@canonical.com>
Date:   Mon, 15 Nov 2021 17:32:31 +1300
Message-ID: <CAKAwkKvOmBFJwE7pQTAZd8b582sOdcnthe=FOEufxYhzQ00jWQ@mail.gmail.com>
Subject: [PROBLEM] crashkernel gets stuck at DMAR-IR: Copied IR table for
 dmar1 from previous kernel
To:     iommu@lists.linux-foundation.org
Cc:     lkml <linux-kernel@vger.kernel.org>,
        nathan.langford@xcelesunifiedtechnologies.com,
        Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear IOMMU Subsystem Maintainers,

I have been debugging an issue with Nathan Langford, CC here, for some months
now, along with Alex Williamson on the linux-pci mailing list, and I just wanted
to check that we aren't also running into an IOMMU bug when enabling IRQ
remapping in the crashkernel.

Nathan has a system with 8x 2080TI graphics cards, and we are passing through
multiple GPUs to a KVM VM via vfio-pci. When we pass through 2x GPUs that share
the same upstream PCI switch, and reboot the VM a handful of times, an IRQ storm
occurs, and locks up the host system.

System Information:
- SuperMicro X9DRG-O(T)F
- 8x Nvidia GeForce RTX 2080 Ti GPUs
- Ubuntu 20.04 LTS
- 5.14.0 mainline kernel
- libvirt 6.0.0-0ubuntu8.10
- qemu 4.2-3ubuntu6.16
- intel_iommu=on

In the logs we see:

irq 31: nobody cared (try booting with the "irqpoll" option)
Call Trace:
 <IRQ>
 dump_stack_lvl+0x4a/0x5f
 dump_stack+0x10/0x12
 __report_bad_irq+0x3a/0xaf
 note_interrupt.cold+0xb/0x60
 handle_irq_event_percpu+0x72/0x80
 handle_irq_event+0x3b/0x60
 handle_fasteoi_irq+0x9c/0x150
 __common_interrupt+0x4b/0xb0
 common_interrupt+0x4a/0xa0
 asm_common_interrupt+0x1e/0x40
RIP: 0010:__do_softirq+0x73/0x2ae
handlers:
[<00000000b16da31d>] vfio_intx_handler
Disabling IRQ #31

Extra details on LKML / linux-pci:
https://lkml.org/lkml/2021/9/13/85

Now, Nathan has "kernel.hardlockup_panic = 1" set, which causes the kernel to
panic, and reboot to the crashkernel, and this is where the IOMMU issues begin.

The crashkernel loads, and gets as far as:

DMAR: Host address width 46
DMAR: DRHD base: 0x000000fbffe000 flags: 0x0
DMAR: dmar0: reg_base_addr fbffe000 ver 1:0 cap d2078c106f0466 ecap f020de
DMAR: DRHD base: 0x000000cbffc000 flags: 0x1
DMAR: dmar1: reg_base_addr cbffc000 ver 1:0 cap d2078c106f0466 ecap f020de
DMAR: RMRR base: 0x0000005f21a000 end: 0x0000005f228fff
DMAR: ATSR flags: 0x0
DMAR: RHSA base: 0x000000fbffe000 proximity domain: 0x1
DMAR: RHSA base: 0x000000cbffc000 proximity domain: 0x0
DMAR-IR: IOAPIC id 3 under DRHD base  0xfbffe000 IOMMU 0
DMAR-IR: IOAPIC id 0 under DRHD base  0xcbffc000 IOMMU 1
DMAR-IR: IOAPIC id 2 under DRHD base  0xcbffc000 IOMMU 1
DMAR-IR: HPET id 0 under DRHD base 0xcbffc000
[    3.271530] DMAR-IR: Queued invalidation will be enabled to support
x2apic and Intr-remapping.
[    3.282572] DMAR-IR: Copied IR table for dmar0 from previous kernel
[   13.291319] DMAR-IR: Copied IR table for dmar1 from previous kernel

I added the timestamps for the last couple entries. There is a ten second hang
between copying the IR table from dmar0 and copying the IR table from dmar1.

After this, the kernel just hangs, and the system has to be hard rebooted.

Full dmesg:
https://paste.ubuntu.com/p/M7Bdyk9YV7/

We never see the next message that usually happens with plain old sysrq-trigger,
which is:

DMAR-IR: Enabled IRQ remapping in x2apic mode

Would an ongoing IRQ storm prevent IRQ remapping being enabled?

From my understanding, when we start the crashkernel, PCI devices are in an
undefined state, and could keep on sending DMA or IRQ requests to the
crashkernel, which could break things through data corruption or causing IRQs to
be blocked if we get too many spurious IRQs. This would then cause problems if
we try and re-initialise these PCI devices and they have IRQs blocked.

Which is why we copy the old IR tables from dmar regions, and unblock blocked
IRQs. But if an IRQ storm is ongoing, is there anything we can really do? Is it
a bug to just hang here, or is it an indication that the system administrator
needs to go and do a full hardware reset?

Please let us know if you need any additional debugging information, we can
build patched kernels if you need extra debug output.

Thanks,
Matthew
