Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F2D3EC625
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 02:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbhHOAOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 20:14:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24148 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229453AbhHOAOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 20:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628986459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ON9gqncx4nehuNy6tPp5MBsfNC9453HZt7MLRH53j4o=;
        b=YKDOOuWWuyDfff7J76+4EiJ8jsKl+LLSUtAQe0ufGYlITVWd/cpGjRDVzADZZ5Sl7xfu/9
        7vgAWStP7R+Au49LkDboDNWFZ5amJtHiLT1ILr+kI1m7G168tQ6/mhtdBMAYCnLWItu+3j
        x2q2XTTSsXUwuRvQIGnDj8fM/fHQu5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-sBQpS1PXPKaVEltwFlICYw-1; Sat, 14 Aug 2021 20:14:17 -0400
X-MC-Unique: sBQpS1PXPKaVEltwFlICYw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 897C7802936;
        Sun, 15 Aug 2021 00:14:15 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-103.bne.redhat.com [10.64.54.103])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 999F11036D2E;
        Sun, 15 Aug 2021 00:14:11 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, james.morse@arm.com,
        mark.rutland@arm.com, Jonathan.Cameron@huawei.com, will@kernel.org,
        maz@kernel.org, pbonzini@redhat.com
Subject: [PATCH v4 00/21] Support SDEI Virtualization
Date:   Sun, 15 Aug 2021 08:13:31 +0800
Message-Id: <20210815001352.81927-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series intends to virtualize Software Delegated Exception Interface
(SDEI), which is defined by DEN0054A. It allows the hypervisor to deliver
NMI-alike event to guest and it's needed by asynchronous page fault to
deliver page-not-present notification from hypervisor to guest. The code
and the required qemu changes can be found from:

   https://developer.arm.com/documentation/den0054/latest
   https://github.com/gwshan/linux    ("kvm/arm64_sdei")
   https://github.com/gwshan/qemu     ("kvm/arm64_sdei")

The SDEI event is identified by a 32-bits number. Bits[31:24] are used
to indicate the SDEI event properties while bits[23:0] are identifying
the unique number. The implementation takes bits[23:22] to indicate the
owner of the SDEI event. For example, those SDEI events owned by KVM
should have these two bits set to 0b01. Besides, the implementation
supports SDEI events owned by KVM only.

The design is pretty straightforward and the implementation is just
following the SDEI specification, to support the defined SMCCC intefaces,
except the IRQ binding stuff. There are several data structures introduced.
Some of the objects have to be migrated by VMM. So their definitions are
split up for VMM to include the corresponding states for migration.

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

There are additional patches in the following repositories to create
procfs entries, allowing inject SDEI event and test driver in the guest
to handle the SDEI event. Besides, the additional QEMU changes are needed
so that guest can detect the SDEI service through ACPI table.

    https://github.com/gwshan/linux    ("kvm/arm64_sdei")
    https://github.com/gwshan/qemu     ("kvm/arm64_sdei")

The SDEI event is received and handled in the guest after it's injected
through the procfs entries from host side.

    host# /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64       \
          -accel kvm -machine virt,gic-version=host                     \
          -cpu host -smp 8,sockets=2,cores=4,threads=1 -m 1024M         \
            :                                                           \
          -kernel /home/gavin/sandbox/linux.guest/arch/arm64/boot/Image \
          -initrd /home/gavin/sandbox/images/rootfs.cpio.xz             \
          -append 'earlycon=pl011,mmio,0x9000000'
    host# echo > /proc/kvm/kvm-10842/vcpu-0
    guest# =========== SDEI Event (CPU#0) ===========
           num=0x40400000, arg=0xdabfdabf
           SP: 0xffff800011613e90  PC: 0x0  pState: 0x0
           Regs:
           000000000002ac4 ffff00001ff947a0 0000000000002ac2 ffff00001ff976c0
           0000000000000000 0000000000000000 0000000000000000 0000000000000000
           0000000000000000 0000000000000000 0000000000000000 0000000000000000
           0000000000000000 0000000000000000 0000000000000000 0000000000000000
           0000000000000000 0000000000000000 0000000000000000 ffff80001121a000
           ffff8000116199e0 ffff800011619ad8 ffff80001122d8b8 ffff800011619afc
           0000000000000000 0000000000000000 ffff800011622140 ffff800011150108
           00000000582c0018 ffff800011613e90 ffff800010bd0248
           Query context:
           x[00]: 0000000000002ac4   errno: 0
           x[01]: ffff00001ff947a0   errno: 0
             :
           x[18]: ffff800010bd01d8   errno: 0
           x[19]: fffffffffffffffe   errno: -22
           x[20]: fffffffffffffffe   errno: -22
             :
           x[30]: fffffffffffffffe   errno: -22
     host# echo > /proc/kvm/kvm-10842/vcpu-7
     guest# =========== SDEI Event (CPU#7) ===========
           num=0x40400000, arg=0xdabfdabf
           SP: 0xffff800011b73f20  PC: 0x0  pState: 0x0
           Regs:
           00000000000010d0 ffff00003fde07a0 00000000000010ce 7fffffff1999999a
           0000000000000000 0000000000000000 0000000000000000 0000000000000000
           0000000000000000 0000000000000000 0000000000000000 0000000000000000
           0000000000000000 0000000000000000 0000000000000000 0000000000000000
           0000000000000000 0000000000000000 0000000000000000 ffff80001121a000
           ffff8000116199e0 ffff800011619ad8 ffff80001122d8b8 ffff800011619afc
           0000000000000000 0000000000000000 ffff000020032ac0 0000000000000000
           0000000000000000 ffff800011b73f20 ffff800010bd0248
           Query context:
           x[00]: 00000000000010d0   errno: 0
           x[01]: ffff00003fde07a0   errno: 0
            :
           x[18]: ffff800010bd01d8   errno: 0
           x[19]: fffffffffffffffe   errno: -22
            :
           x[30]: fffffffffffffffe   errno: -22

Changelog
=========
v4:
   * Rebased to v5.14.rc5                                         (Gavin) 
v3:
   * Rebased to v5.13.rc1                                         (Gavin)
   * Use linux data types in kvm_sdei.h                           (Gavin)
v2:
   * Rebased to v5.11.rc6                                         (Gavin)
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
 arch/arm64/include/asm/kvm_host.h          |    8 +
 arch/arm64/include/asm/kvm_sdei.h          |  136 ++
 arch/arm64/include/uapi/asm/kvm.h          |    1 +
 arch/arm64/include/uapi/asm/kvm_sdei.h     |   86 ++
 arch/arm64/kvm/Makefile                    |    2 +-
 arch/arm64/kvm/arm.c                       |   19 +
 arch/arm64/kvm/hyp/exception.c             |    7 +
 arch/arm64/kvm/hypercalls.c                |   18 +
 arch/arm64/kvm/inject_fault.c              |   27 +
 arch/arm64/kvm/sdei.c                      | 1519 ++++++++++++++++++++
 include/kvm/arm_hypercalls.h               |   34 +-
 include/uapi/linux/kvm.h                   |    4 +
 tools/testing/selftests/kvm/Makefile       |    1 +
 tools/testing/selftests/kvm/aarch64/sdei.c |  171 +++
 15 files changed, 2014 insertions(+), 20 deletions(-)
 create mode 100644 arch/arm64/include/asm/kvm_sdei.h
 create mode 100644 arch/arm64/include/uapi/asm/kvm_sdei.h
 create mode 100644 arch/arm64/kvm/sdei.c
 create mode 100644 tools/testing/selftests/kvm/aarch64/sdei.c

-- 
2.23.0

