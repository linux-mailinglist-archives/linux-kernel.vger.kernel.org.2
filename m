Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B873314755
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 05:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhBIEL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 23:11:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20328 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230180AbhBIDwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 22:52:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612842662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XJfaLwpKKSFNaNuAxEpZXdlKx5zcuy81fqvHbQ0EhGg=;
        b=emu8RFn15SgvuT8hlkDeogXe9JvB4zV4lNnApLWpMgH2JdMGf0J6FkP7zr9/zr6GSTiO34
        ZNBSOpzYkUenkopOvT+U7I4Qb/REzNP26WDjJhAa4wItvBve51qrXpNlKXw6Lp1CNn1eUk
        CbrHrsYcTjj7o+k3kNWDCtNTHaPffxk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-QXDgxg0lNImAnw4k1S3vWg-1; Mon, 08 Feb 2021 22:27:58 -0500
X-MC-Unique: QXDgxg0lNImAnw4k1S3vWg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9100192D785;
        Tue,  9 Feb 2021 03:27:56 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-26.bne.redhat.com [10.64.54.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2114219C66;
        Tue,  9 Feb 2021 03:27:52 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, pbonzini@redhat.com, maz@kernel.org,
        james.morse@arm.com, Jonathan.Cameron@huawei.com,
        mark.rutland@arm.com, will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v2 00/21] Support SDEI Virtualization
Date:   Tue,  9 Feb 2021 11:27:12 +0800
Message-Id: <20210209032733.99996-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series intends to virtualize Software Delegated Exception Interface
(SDEI), which is defined by DEN0054A. It allows the hypervisor to deliver
NMI-alike event to guest and it's needed by asynchronous page fault to
deliver page-not-present notification from hypervisor to guest. The code
and the required qemu changes can be found from:

   https://github.com/gwshan/linux    ("sdei")
   https://github.com/gwshan/qemu.git ("apf")

The SDEI event is identified by a 32-bits number. Bits[31:24] are used
to indicate the SDEI event properties while bits[23:0] are identifying
the unique number. The implementation takes bits[23:22] to indicate the
owner of the SDEI event. For example, those SDEI events owned by KVM
should have these two bits set to 0b01. Besides, the implementation
supports SDEI events owned by KVM only.

The design is pretty straightforward and the implementation is just
following the SDEI specification. There are several data structures
introduced. Some of the objects have to be migrated by VMM. So their
definitions are split up so that VMM can include their states for
migration.

   struct kvm_sdei_kvm
      Associated with VM and used to track the KVM exposed SDEI events
      and those registered by guest.
   struct kvm_sdei_vcpu
      Associated with vCPU and used to track SDEI event delivery. The
      preempted context is saved prior to the delivery and restored
      after that.
   struct kvm_sdei_event
      SDEI events exposed by KVM so that guest can register and enable.
   struct kvm_sdei_kvm_event
      SDEI events that have been registered by guest.
   struct kvm_sdei_vcpu_event
      SDEI events that have been queued to specific vCPU for delivery.

The series is organized as below:

   PATCH[01]    Introduces template for smccc_get_argx()
   PATCH[02]    Introduces the data structures and infrastructure
   PATCH[03-14] Supports various SDEI related hypercalls
   PATCH[15]    Supports SDEI event notification
   PATCH[16-17] Introduces ioctl command for migration
   PATCH[18-19] Supports SDEI event injection and cancellation
   PATCH[20]    Exports SDEI capability
   PATCH[21]    Adds self-test case for SDEI virtualization

Testing
=======

There are two additional patches in the following repository to create
procfs files allowing inject SDEI event and driver for the guest to
use the SDEI event. Besides, the additional qemu changes are needed
so that guest can detects the SDEI service through ACPI table.

    https://github.com/gwshan/linux    ("sdei")
    https://github.com/gwshan/qemu.git ("apf")

The SDEI event is received and handled in the guest after it's injected
through the procfs files on host.

Changelog
=========
v2:
   * Rebased to 5.11.rc6
   * Dropped changes related to SDEI client driver                (Gavin)
   * Removed support for passthrou SDEI events                    (Gavin)
   * Redesigned data structures                                   (Gavin)
   * Implementation is almost rewritten as the data structures
     are totally changed                                          (Gavin)
   * Added ioctl commands to support migration                    (Gavin)

Gavin Shan (21):
  KVM: arm64: Introduce template for inline functions
  KVM: arm64: Add SDEI virtualization infrastructure
  KVM: arm64: Support SDEI_VERSION hypercall
  KVM: arm64: Support SDEI_EVENT_REGISTER hypercall
  KVM: arm64: Support SDEI_EVENT_{ENABLE, DISABLE} hypercall
  KVM: arm64: Support SDEI_EVENT_CONTEXT hypercall
  KVM: arm64: Support SDEI_EVENT_UNREGISTER hypercall
  KVM: arm64: Support SDEI_EVENT_STATUS hypercall
  KVM: arm64: Support SDEI_EVENT_GET_INFO hypercall
  KVM: arm64: Support SDEI_EVENT_ROUTING_SET hypercall
  KVM: arm64: Support SDEI_PE_{MASK, UNMASK} hypercall
  KVM: arm64: Support SDEI_{PRIVATE, SHARED}_RESET hypercall
  KVM: arm64: Impment SDEI event delivery
  KVM: arm64: Support SDEI_EVENT_{COMPLETE, COMPLETE_AND_RESUME}
    hypercall
  KVM: arm64: Support SDEI event notifier
  KVM: arm64: Support SDEI ioctl commands on VM
  KVM: arm64: Support SDEI ioctl commands on vCPU
  KVM: arm64: Support SDEI event injection
  KVM: arm64: Support SDEI event cancellation
  KVM: arm64: Export SDEI capability
  KVM: selftests: Add SDEI test case

 arch/arm64/include/asm/kvm_emulate.h       |    1 +
 arch/arm64/include/asm/kvm_host.h          |    6 +
 arch/arm64/include/asm/kvm_sdei.h          |  136 ++
 arch/arm64/include/uapi/asm/kvm.h          |    1 +
 arch/arm64/include/uapi/asm/kvm_sdei.h     |   82 ++
 arch/arm64/kvm/Makefile                    |    2 +-
 arch/arm64/kvm/arm.c                       |   19 +
 arch/arm64/kvm/hyp/exception.c             |    7 +
 arch/arm64/kvm/hypercalls.c                |   18 +
 arch/arm64/kvm/inject_fault.c              |   27 +
 arch/arm64/kvm/sdei.c                      | 1519 ++++++++++++++++++++
 include/kvm/arm_hypercalls.h               |   34 +-
 include/uapi/linux/kvm.h                   |    4 +
 tools/testing/selftests/kvm/Makefile       |    1 +
 tools/testing/selftests/kvm/aarch64/sdei.c |  172 +++
 15 files changed, 2009 insertions(+), 20 deletions(-)
 create mode 100644 arch/arm64/include/asm/kvm_sdei.h
 create mode 100644 arch/arm64/include/uapi/asm/kvm_sdei.h
 create mode 100644 arch/arm64/kvm/sdei.c
 create mode 100644 tools/testing/selftests/kvm/aarch64/sdei.c

-- 
2.23.0

