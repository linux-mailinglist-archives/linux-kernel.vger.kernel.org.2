Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170D045A73B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 17:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238728AbhKWQN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 11:13:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:32572 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236174AbhKWQN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 11:13:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637683849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=FbxeuNxQjB5QvjUW3b2rknZ2oE0ll1NcLAESvVNT8zU=;
        b=APYS+mT8lRSzyl//+hCQg1IPO8mJJneVElYnYQMxlanBy7NvfJ1/555uhzOPZC9oePlG1w
        T2qGp9gNRxNGKldcbywp6bB5weL5x2TroEHSM/x1bAMb+CHgfsTgYwoKqtmjc6B1wA6q4i
        t8ZAeNTQPQ38xR1P1EVUM/JD42yfewc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-177-gCOwqdwfMr-Sai7Omlkv_g-1; Tue, 23 Nov 2021 11:10:45 -0500
X-MC-Unique: gCOwqdwfMr-Sai7Omlkv_g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52A98801B26;
        Tue, 23 Nov 2021 16:10:44 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC76260843;
        Tue, 23 Nov 2021 16:10:39 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Woodhouse <dwmw@amazon.co.uk>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        iommu@lists.linux-foundation.org (open list:AMD IOMMU (AMD-VI)),
        Will Deacon <will@kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH 0/5] iommu/amd: fixes for suspend/resume
Date:   Tue, 23 Nov 2021 18:10:33 +0200
Message-Id: <20211123161038.48009-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As I sadly found out, a s3 cycle makes the AMD's iommu stop sending interru=
pts=0D
until the system is rebooted.=0D
=0D
I only noticed it now because otherwise the IOMMU works, and these interrup=
ts=0D
are only used for errors and for GA log which I tend not to use by=0D
making my VMs do mwait/pause/etc in guest (cpu-pm=3Don).=0D
=0D
There are two issues here that prevent interrupts from being generated afte=
r=0D
s3 cycle:=0D
=0D
1. GA log base address was not restored after resume, and was all zeroed=0D
after resume (by BIOS or such).=0D
=0D
In theory if BIOS writes some junk to it, that can even cause a memory corr=
uption.=0D
Patch 2 fixes that.=0D
=0D
2. INTX (aka x2apic mode) settings were not restored after resume.=0D
That mode is used regardless if the host uses/supports x2apic, but rather w=
hen=0D
the IOMMU supports it, and mine does.=0D
Patches 3-4 fix that.=0D
=0D
Note that there is still one slight (userspace) bug remaining:=0D
During suspend all but the boot CPU are offlined and then after resume=0D
are onlined again.=0D
=0D
The offlining moves all non-affinity managed interrupts to CPU0, and=0D
later when all other CPUs are onlined, there is nothing in the kernel=0D
to spread back the interrupts over the cores.=0D
=0D
The userspace 'irqbalance' daemon does fix this but it seems to ignore=0D
the IOMMU interrupts in INTX mode since they are not attached to any=0D
PCI device, and thus they remain on CPU0 after a s3 cycle,=0D
which is suboptimal when the system has multiple IOMMUs=0D
(mine has 4 of them).=0D
=0D
Setting the IRQ affinity manually via /proc/irq/ does work.=0D
=0D
This was tested on my 3970X with both INTX and regular MSI mode (later was =
enabled=0D
by patching out INTX detection), by running a guest with AVIC enabled and w=
ith=0D
a PCI assigned device (network card), and observing interrupts from=0D
IOMMU while guest is mostly idle.=0D
=0D
This was also tested on my AMD laptop with 4650U (which has the same issue)=
=0D
(I tested only INTX mode)=0D
=0D
Patch 1 is a small refactoring to remove an unused struct field.=0D
=0D
Best regards,=0D
   Maxim Levitsky=0D
=0D
Maxim Levitsky (5):=0D
  iommu/amd: restore GA log/tail pointer on host resume=0D
  iommu/amd: x2apic mode: re-enable after resume=0D
  iommu/amd: x2apic mode: setup the INTX registers on mask/unmask=0D
  iommu/amd: x2apic mode: mask/unmask interrupts on suspend/resume=0D
  iommu/amd: remove useless irq affinity notifier=0D
=0D
 drivers/iommu/amd/amd_iommu_types.h |   2 -=0D
 drivers/iommu/amd/init.c            | 107 +++++++++++++++-------------=0D
 2 files changed, 58 insertions(+), 51 deletions(-)=0D
=0D
-- =0D
2.26.3=0D
=0D

