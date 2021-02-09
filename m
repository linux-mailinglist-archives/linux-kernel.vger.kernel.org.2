Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C204D3147DD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 06:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhBIFF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 00:05:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56372 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229464AbhBIFFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 00:05:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612847061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=PjiUZcrJfN+sq4yoRdSMRBBgRyo/8yfRoNyXIW5S0fA=;
        b=CcysLwzhwD3e2RtDFtRcuauwGYUuYQQTBURAtEqPYIMuf0t6QliAyXlnkN4eOeWvYHWyTz
        5OzrjYBaAFZVXIYSgTYOFjz8xBNHjTe8speIMsau09GMAVw3yvRjz1ScdkbaYr/isb158S
        1VDz0RLymwjP7IadTQFxEQSxU2+AiIA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-ZF1XFtCRM4yk2fZBeJEbCw-1; Tue, 09 Feb 2021 00:04:18 -0500
X-MC-Unique: ZF1XFtCRM4yk2fZBeJEbCw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 447E9107ACE3;
        Tue,  9 Feb 2021 05:04:16 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-26.bne.redhat.com [10.64.54.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DEF365D9C0;
        Tue,  9 Feb 2021 05:04:11 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, pbonzini@redhat.com, maz@kernel.org,
        james.morse@arm.com, Jonathan.Cameron@huawei.com,
        mark.rutland@arm.com, will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v2 00/17] Support Asynchronous Page Fault
Date:   Tue,  9 Feb 2021 13:03:46 +0800
Message-Id: <20210209050403.103143-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two stages of page fault. The guest kernel is responsible for
handling stage-1 page fault, while the host kernel is to take care of the
stage-2 page fault. When the guest is trapped to host because of stage-2
page fault, the guest is suspended until the requested memory (page) is
populated. Sometimes, the cost to populate the requested page isn't cheap
and can take hundreds of milliseconds in extreme cases. Similarly, the
guest has to wait until the requested memory is ready in the scenario of
post-copy live migration.

This series introduces the feature (Asynchronous Page Fault) to improve
situation, so that the guest needn't have to wait in the scenarios. With
it, the overall performance is improved on the guest. This series depends
on the feature "SDEI virtualization" and QEMU changes. All code changes
can be found from github:

 https://github.com/gwshan/linux ("sdei") # SDEI virtualization
 https://github.com/gwshan/linux ("apf")  # This series + "sdei"
 https://github.com/gwshan/qemu  ("apf")  # QEMU code changes

About the design, the details can be found from last patch. Generally,
it's driven by two notifications: page-not-present and page-ready. They
are delivered from the host to guest via SDEI event and PPI separately.
In the mean while, each notification is always associated with a token,
used to identify the notification. The token is passed by the shared
memory between host/guest. Besides, the SMCCC and ioctl interface are
mitigated by VMM and guest to configure, enable, disable, even migrate
the functionality.

When the guest is trapped to host because of stage-2 page fault, a
page-not-present notification is raised by the host, and sent to the
guest through dedicated SDEI event (0x40400001) if the requested page
can't be populated immediately. In the mean while, a (background) worker
is also started to populate the requested page. On receiving the SDEI
event, the guest marks the current running process with special flag
(TIF_ASYNC_PF) and associates it with a pre-allocated waitqueue. At
same time, a (reschedule) IPI is sent to current CPU. After the SDEI
event is acknowledged by the guest, the (reschedule) IPI is delivered
and it causes context switch from that process tagged with TIF_ASYNC_PF
to another process.

Later on, a page-ready notification is sent to guest after the requested
page is populated by the (background) worker. On receiving the interrupt,
the guest uses the associated token to locate the process, which was
previously suspended because of page-not-present. The flag (TIF_ASYNC_PF)
is cleared for the suspended process and it's waken up.

The series is organized as below:

   PATCH[01-04] makes the GFN hash table management generic so that it
                can be shared by x86/arm64.
   PATCH[05-06] support KVM hypervisor SMCCC services from Will Deacon.
   PATCH[07-08] preparatory work to support asynchronous page fault.
   PATCH[09-10] support asynchronous page fault.
   PATCH[11-13] support ioctl and SMCCC interfaces for the functionality.
   PATHC[14-16] supoort asynchronous page fault for guest
   PATCH[17]    adds document to explain the design and internals

Testing
=======

The tests are taken using program "testsuite mem", which is written by
myself. The program basically does two things: (a) Starts a thread to
allocate the specified percentage of available memory, write random
values to them by the specified times, and then release them; (b) Thread
is started to do calculation if needed.

In the mean while, the guest is always assigned with only one vCPU and
4096MB memory in all test cases. The memory cgroup where qemu process
is associated could have different memory limitation settings.

[1] Allocate/free memory without calculation thread

    Index      -APF                  +APF                    Output
    ---------------------------------------------------------------------
      1        39477ms               38367ms                 +0.28% 
      2        51272ms               49760ms                 +0.29%

    The consumed time is decreased a bit and it should be benefited from
    the (background) workers, which runs in parallel.

[2] Allocate/free memory with calculation thread

    Index      -APF                  +APF                    Output
    ---------------------------------------------------------------------
      1         81442ms  7155198892  171335ms 22391255613    -110% +213% 
      2        122002ms 11438214429  191126ms 24984499197    -57%  +119%

    The increased calculation amount is almost 2 times of the increased
    time.

[3] 5 Times of allocate/free memory with calculation thread and post-copy
    live migration

     Index      -APF                  +APF                    Output
    ---------------------------------------------------------------------
      1         240635ms 19722999876  658955ms 89242030748    +174% +352%


    Results retrieved from "info migrate":

     Param                  -APF               +APF             Output
    --------------------------------------------------------------------
    store-global-state:     on                 on
    only-migratable:        off                off
    send-configuration:     on                 on
    send-section-footer:    on                 on
    decompress-error-check: on                 on
    clear-bitmap-shift:     18                 18
    Migration status:       completed          completed
    total time:             9576 ms            10461 ms          +9.2%
    downtime:               78 ms              44 ms             -43.5%
    setup:                  62 ms              47ms              -24.1%
    transferred ram:        889007 kbytes      1206436 kbytes    +35.7%
    throughput:             765.53 mbps        949.08 mbps       +24%
    remaining ram:          0 kbytes           0 kbytes
    total ram:              4325952 kbytes     4325952 kbytes
    duplicate:              861559 pages       823954 pages
    skipped:                0 pages            0 pages
    normal:                 219929 pages       299214 pages
    normal bytes:           879716 kbytes      1196856 kbytes
    dirty sync count:       2                  2
    page size:              4 kbytes           4 kbytes
    multifd bytes:          0 kbytes           0 kbytes
    pages-per-second:       33684              72400             +115%
    postcopy request count: 121                75                -38%

    The asynchronous page fault is beneficial to throughput and speed in
    the scenario of post-copy live migration.

Chnagelog
=========
v2:
   * Rebase to v5.11.rc6                                          (Gavin)
   * Split the patches                                            (James)
   * Allocate "struct kvm_arch_async_control" dymaicall and use
     it to check if the feature has been enabled. The kernel
     option (CONFIG_KVM_ASYNC_PF) isn't used.                     (James)
   * Add document to explain the design                           (James)
   * Make GFN hash table management generic                       (James)
   * Add ioctl commands to support migration                      (Gavin)

Gavin Shan (15):
  KVM: async_pf: Move struct kvm_async_pf around
  KVM: async_pf: Add helper function to check completion queue
  KVM: async_pf: Make GFN slot management generic
  KVM: x86: Use generic async PF slot management
  KVM: arm64: Export kvm_handle_user_mem_abort()
  KVM: arm64: Add paravirtualization header files
  KVM: arm64: Support page-not-present notification
  KVM: arm64: Support page-ready notification
  KVM: arm64: Support async PF hypercalls
  KVM: arm64: Support async PF ioctl commands
  KVM: arm64: Export async PF capability
  arm64: Detect async PF para-virtualization feature
  arm64: Reschedule process on aync PF
  arm64: Enable async PF
  KVM: arm64: Add async PF document

Will Deacon (2):
  arm64: Probe for the presence of KVM hypervisor services during boot
  KVM: arm64: Advertise KVM UID to guests via SMCCC

 Documentation/virt/kvm/arm/apf.rst     | 143 +++++++
 Documentation/virt/kvm/arm/index.rst   |   1 +
 arch/arm64/Kconfig                     |  11 +
 arch/arm64/include/asm/esr.h           |   6 +
 arch/arm64/include/asm/hypervisor.h    |  11 +
 arch/arm64/include/asm/kvm_emulate.h   |  27 +-
 arch/arm64/include/asm/kvm_host.h      |  85 ++++
 arch/arm64/include/asm/kvm_para.h      |  37 ++
 arch/arm64/include/asm/processor.h     |   1 +
 arch/arm64/include/asm/thread_info.h   |   4 +-
 arch/arm64/include/uapi/asm/Kbuild     |   2 -
 arch/arm64/include/uapi/asm/kvm.h      |  19 +
 arch/arm64/include/uapi/asm/kvm_para.h |  23 ++
 arch/arm64/include/uapi/asm/kvm_sdei.h |   1 +
 arch/arm64/kernel/Makefile             |   1 +
 arch/arm64/kernel/kvm.c                | 452 +++++++++++++++++++++
 arch/arm64/kernel/setup.c              |  32 ++
 arch/arm64/kernel/signal.c             |  17 +
 arch/arm64/kvm/Kconfig                 |   2 +
 arch/arm64/kvm/Makefile                |   1 +
 arch/arm64/kvm/arm.c                   |  37 +-
 arch/arm64/kvm/async_pf.c              | 535 +++++++++++++++++++++++++
 arch/arm64/kvm/hypercalls.c            |  33 +-
 arch/arm64/kvm/mmu.c                   |  75 +++-
 arch/arm64/kvm/sdei.c                  |   5 +
 arch/x86/include/asm/kvm_host.h        |   1 -
 arch/x86/kvm/Kconfig                   |   1 +
 arch/x86/kvm/mmu/mmu.c                 |   2 +-
 arch/x86/kvm/x86.c                     |  88 +---
 include/linux/arm-smccc.h              |  40 ++
 include/linux/kvm_host.h               |  73 +++-
 include/uapi/linux/kvm.h               |   3 +
 virt/kvm/Kconfig                       |   3 +
 virt/kvm/async_pf.c                    |  91 ++++-
 virt/kvm/kvm_main.c                    |   4 +-
 35 files changed, 1706 insertions(+), 161 deletions(-)
 create mode 100644 Documentation/virt/kvm/arm/apf.rst
 create mode 100644 arch/arm64/include/asm/kvm_para.h
 create mode 100644 arch/arm64/include/uapi/asm/kvm_para.h
 create mode 100644 arch/arm64/kernel/kvm.c
 create mode 100644 arch/arm64/kvm/async_pf.c

-- 
2.23.0

