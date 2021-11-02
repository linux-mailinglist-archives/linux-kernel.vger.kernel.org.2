Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C18442497
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 01:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbhKBAYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 20:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhKBAYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 20:24:53 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AEEC061764
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 17:22:19 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id p35-20020a635b23000000b002cc3b82cc32so2741408pgb.14
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 17:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0q1tLc0oeztZBZsXvvPTzof7ayB7Bik3/teaxGikVwA=;
        b=M9RyMn9NtpqtxZRq6dzqh0AmQGmFRmQFCx0PnDS2BS3EfbwgzHnzMPoUT2VW2baznj
         s/4fI0vdhHNI76oo0fmgPbIBhoai9JINiRpWpJUOG2dlyqm6CqqJR5kWP5ZUv+dsnVIV
         V6vOssewxpAsmnUIyrtJ1cuEd+jTbQVSJf+572afB4Bhyl/o6D41fSZK1n/iV2T7a/f7
         YlsTaWYn0UvkbjeKDIifzJna5+4mnIo+8UdBYC6+VQyTnS+Y0lkbYcoXGQVMjW4r7Cqj
         OV+FXdbxhJC+XuK8NFkZPJ+UG5ZcHG5ePMrx+yZEseXk7KjEywWzFJvgXxvVq5zrPO2P
         Wp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0q1tLc0oeztZBZsXvvPTzof7ayB7Bik3/teaxGikVwA=;
        b=O9pyrs5fZZMYPr/JNDJvPwApRo2qwZ/9+C8JXTGN+zMEpQPttTEi7m22HlrEdmd10s
         VIHaIJyGe5Zv9iHZN1A3Zd8+foRHh26XlbHcfOENL+rO3G5jZsrUfXQKlSAvbx/2esyD
         XDYdJ2KkZtt8Ib+6lpod54AGV6LSv/0G2t6vkMRmqFGtADnm0Wj73Z2hG5MExN3FJkhe
         MJr7DuANt+3qAxOzon/LtKVJecb0bgAgzdIw/pYWwqpNOX7It3A6qHC1FuiuwjxTbIE1
         TZkyN7JKqxMUWHJKIQZ/okIkcYrg52DB7M+zOxrLZYFaa1L3HDB0Q9Jo3Rrsls352yLJ
         RrvA==
X-Gm-Message-State: AOAM5330sLSbaeXGINefpYVvGKFS7UnKtCBH7sunbhkpKu1XrJ5cYQiT
        quARmkEz8xYBvdkXJdX8fk9vUUpdDSWF
X-Google-Smtp-Source: ABdhPJxNMFUzGq4vVDxdHLg1Zowo37UyC15esk5w81Yj2K1hViKi29lRAuknRKEVUhuJwiI85y6JmFLNHLAH
X-Received: from rananta-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a17:902:6bc8:b0:13f:8a54:1188 with SMTP id
 m8-20020a1709026bc800b0013f8a541188mr27979352plt.49.1635812539339; Mon, 01
 Nov 2021 17:22:19 -0700 (PDT)
Date:   Tue,  2 Nov 2021 00:21:55 +0000
Message-Id: <20211102002203.1046069-1-rananta@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [RFC PATCH 0/8] KVM: arm64: Add support for hypercall services selection
From:   Raghavendra Rao Ananta <rananta@google.com>
To:     Marc Zyngier <maz@kernel.org>, Andrew Jones <drjones@redhat.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Raghavendra Rao Anata <rananta@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Continuing the discussion from [1], the series tries to add support
for the user-space to elect the hypercall services that it wishes
to expose to the guest, rather than the guest discovering them
unconditionally. The idea employed by the series was taken from
[1] as suggested by Marc Z.

In a broad sense, the idea is similar to the current implementation
of PSCI interface- create a 'psuedo-firmware register' to handle the
firmware revisions. The series extends this idea to all the other
hypercalls such as TRNG (True Random Number Generator), PV_TIME
(Paravirtualized Time), and PTP (Precision Time protocol).

For better categorization and future scaling, firmware registers
are introduced based on the SMCCC service call owner (standard secure
service, standard hypervisor service, and vendor specific hypervisor
service). Each of these registers exposes the features employed in
the form of a bitmap and are enveloped into a generic interface (for
future expansion).

Upon VM creation, all the features supported by each owner type are
enabled. User-space/VMM can learn about the services currently enabled
via GET_ONE_REG and can manipulate them via SET_ONE_REG interfaces.
These 'writes' directly effect the bitmap, which is further checked
when the guest tries to issue the hypercall and a decision is taken
weather or not the hypercall is accessable to the guest. The interface
works well across live-migrations where the VMM can simply save/restore
these firmware registers using the existing IOCTL interfaces.

Upon VM start (at least one vCPU runs), the registers become read-only
and cannot be manupulated by the VMM. This is just to avoid providing
conflicting views of the services to the guests.

One of the problems that the series need to address is the enablement
of the features carried by a firmware register, whose existance is
not known to the VMM yet. A couple of ideas were discussed to handle this:

    1) Upon the first SET_ONE_REG, clear all the firmware registers
    implicitly. It's the responsibility of the VMM to make sure that it
    configures all the registers that's known to it.

    2) Contrary to #1, which implicitly clears all the registers, introduce
    a new capability to handle this explicitly. That is, the after learning
    about the services supported by the host, the VMM writes to the
    capability to explictly clear the registers.

The series currently employs #1 just for the sake of completion, but is
open for further discussion.

The patches are based off of kvmarm-next 5.15-rc4, with the selftest
patches from [2] applied.

Patch-1 factors out the non-PSCI related interface from psci.c to
hypercalls.c, as the series would extend the list in the upcoming
patches.

Patch-2 sets up a base environment to handle the 'writes' of firmware
register- clear all the registers upon first 'write' and block 'writes'
to the registers upon VM start.

Patch-3 introduces the firmware register, KVM_REG_ARM_STD, which holds
the standard secure services (such as TRNG).

Patch-4 introduces the firmware register, KVM_REG_ARM_STD_HYP, which holds
the standard hypervisor services (such as PV_TIME).

Patch-5 introduces the firmware register, KVM_REG_ARM_VENDOR_HYP, which holds
the vendor specific hypercall services.

Patch-6 imports the firmware registers' UAPI definitions into tools/ for
further use in selftests.

Patch-7 imports the SMCCC definitions from linux/arm-smccc.h into tools/
for further use in selftests.

Patch-8 adds the selftest to test the guest (using 'hvc') and VMM
interfaces (SET/GET_ONE_REG).

[1]: https://lore.kernel.org/kvmarm/874kbcpmlq.wl-maz@kernel.org/T/
[2]: https://lore.kernel.org/kvmarm/YUzgdbYk8BeCnHyW@google.com/

Raghavendra Rao Ananta (8):
  KVM: arm64: Factor out firmware register handling from psci.c
  KVM: arm64: Setup base for hypercall firmware registers
  KVM: arm64: Add standard secure service calls firmware register
  KVM: arm64: Add standard hypervisor service calls firmware register
  KVM: arm64: Add vendor hypervisor service calls firmware register
  tools: Import the firmware registers
  tools: Import ARM SMCCC definitions
  selftests: KVM: aarch64: Introduce hypercall ABI test

 .../virt/kvm/arm/{psci.rst => hypercalls.rst} |  59 ++-
 Documentation/virt/kvm/arm/index.rst          |   2 +-
 arch/arm64/include/asm/kvm_host.h             |  12 +
 arch/arm64/include/uapi/asm/kvm.h             |  18 +
 arch/arm64/kvm/arm.c                          |  17 +
 arch/arm64/kvm/guest.c                        |   2 +-
 arch/arm64/kvm/hypercalls.c                   | 339 ++++++++++++++++-
 arch/arm64/kvm/psci.c                         | 167 +--------
 arch/arm64/kvm/pvtime.c                       |   3 +
 arch/arm64/kvm/trng.c                         |   9 +-
 include/kvm/arm_hypercalls.h                  |  18 +
 include/kvm/arm_psci.h                        |   8 +-
 tools/arch/arm64/include/uapi/asm/kvm.h       |  18 +
 tools/include/linux/arm-smccc.h               | 188 ++++++++++
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/aarch64/hypercalls.c        | 340 ++++++++++++++++++
 17 files changed, 1018 insertions(+), 184 deletions(-)
 rename Documentation/virt/kvm/arm/{psci.rst => hypercalls.rst} (57%)
 create mode 100644 tools/include/linux/arm-smccc.h
 create mode 100644 tools/testing/selftests/kvm/aarch64/hypercalls.c

-- 
2.33.1.1089.g2158813163f-goog

