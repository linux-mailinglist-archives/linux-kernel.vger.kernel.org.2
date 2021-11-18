Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9407845572B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 09:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244737AbhKRInO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 03:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244705AbhKRInE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 03:43:04 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D839C061570
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 00:40:05 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id be32so12641160oib.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 00:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NZ5d2Mg97hCmt2Auy3YSJwXJWgHFgaajhKOEaXBwnhg=;
        b=CibBKtO6qxuKTBTJ0psPoXn9amPcjTOpSGsm9vUUpAg8kHeq+Dmf7Zh1G3f2iLXGIo
         yHwmQzIYjGadq07oNk0RVUB3BfkBp2w2fuJGxEbQ7JGBiQ5A4dlTwquUKZWgvqlzGQdp
         hJsoGgnEjBrUQvCB7c4g/mHIqgT/WsTz6cSReQoKxm9M7cAeIAflut7WjJNWEr2/GPZe
         npHxNRBqmJBYVTGtoqTAS/xKuWg0U3ZBL34B3caoTHEqix9ocmXME+k4SfncdccsY8CE
         dpvHxU8Pu/SnP397X/30Ws8jCSFFj4HVmQg2+pEcjEyWiRuVftk3z9XL/o5eZ/r8Bw0y
         O8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NZ5d2Mg97hCmt2Auy3YSJwXJWgHFgaajhKOEaXBwnhg=;
        b=Dki4rE1hty9Y3zztjovwe7JLWtO5VudLerPPQFnBI+iBWhzW4XYSbL1OKcweXJkkZL
         ldWtFmzR+Vsxl1YUhmG3FOembKuSt37eVWhjt2OnICONU6uo6A8Cmlj7jDLOS3xTrlWc
         XLaKLQmQbvCdOdvWdK3Cme+SasfNp1QmX99uJtpq64Qjp9oeQTy9al5IdyawhPQOXpNW
         g0fT1lxUKoQv+SvOawfTsSbB7kNRu/g1jvjjDVamFVpaQq8kt5vWo5cPUe2LA8ufebPh
         SY6m/Tu1fpnIk3F4VEbasyIBnV2bjQ9GZDjbK9YjgVoFBb/xjVd/0E7RPFxKrh5YF9Da
         iy5Q==
X-Gm-Message-State: AOAM532mUejzs8NVbAnRiFOkR5TbyMFLMkQe9Z9ZEeSrmfkPneelD7pT
        +Fp8w6OKA49/xkikJQypQu2WQipYFlqQB9k7H+8=
X-Google-Smtp-Source: ABdhPJxVg8pZ9U2lJaHKgd16zEGWSw2zFeEUTc1fmN5tAS2Msi4uRoVOvNoWLXa28uD9pKte8FCZ9Q==
X-Received: by 2002:a05:6808:2187:: with SMTP id be7mr6203100oib.97.1637224803916;
        Thu, 18 Nov 2021 00:40:03 -0800 (PST)
Received: from fedora.. (99-13-229-45.lightspeed.snjsca.sbcglobal.net. [99.13.229.45])
        by smtp.gmail.com with ESMTPSA id p14sm422100oov.0.2021.11.18.00.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 00:40:03 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH v5 0/5] Add SBI v0.2 support for KVM
Date:   Thu, 18 Nov 2021 00:39:07 -0800
Message-Id: <20211118083912.981995-1-atishp@rivosinc.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Supervisor Binary Interface(SBI) specification[1] now defines a
base extension that provides extendability to add future extensions
while maintaining backward compatibility with previous versions.
The new version is defined as 0.2 and older version is marked as 0.1.

This series adds following features to RISC-V Linux KVM.
1. Adds support for SBI v0.2 in KVM
2. SBI Hart state management extension (HSM) in KVM
3. Ordered booting of guest vcpus in guest Linux

This series is based on base KVM series which is already part of the kvm-next[2]. 

Guest kernel needs to also support SBI v0.2 and HSM extension in Kernel
to boot multiple vcpus. Linux kernel supports both starting v5.7.
In absense of that, guest can only boot 1 vcpu.

Changes from v4->v5:
1. Added reviewed-by tags.
2. Removed the redundant kvm_cpu_context pointer sanity check.

Changes from v3->v4:
1. Fixed the commit text title.
2. Removed a redundant memory barrier from patch 4.
3. Replaced preempt_enable/disable with get_cpu/put_cpu.
4. Renamed the exixting implementation as v01 instead of legacy.

Changes from v2->v3:
1. Rebased on the latest merged kvm series.
2. Dropped the reset extension patch because reset extension is not merged in kernel. 
However, my tree[3] still contains it in case anybody wants to test it.

Changes from v1->v2:
1. Sent the patch 1 separately as it can merged independently.
2. Added Reset extension functionality.

Tested on Qemu and Rocket core FPGA.

[1] https://github.com/riscv/riscv-sbi-doc/blob/master/riscv-sbi.adoc
[3] https://github.com/atishp04/linux/tree/kvm_sbi_v05_reset
[4] https://github.com/atishp04/linux/tree/kvm_sbi_v05

Atish Patra (5):
RISC-V: KVM: Mark the existing SBI implementation as v01
RISC-V: KVM: Reorganize SBI code by moving SBI v0.1 to its own file
RISC-V: KVM: Add SBI v0.2 base extension
RISC-V: KVM: Add v0.1 replacement SBI extensions defined in v02
RISC-V: KVM: Add SBI HSM extension in KVM

arch/riscv/include/asm/kvm_vcpu_sbi.h |  33 ++++
arch/riscv/include/asm/sbi.h          |   9 ++
arch/riscv/kvm/Makefile               |   4 +
arch/riscv/kvm/vcpu.c                 |  23 +++
arch/riscv/kvm/vcpu_sbi.c             | 211 ++++++++++++--------------
arch/riscv/kvm/vcpu_sbi_base.c        |  70 +++++++++
arch/riscv/kvm/vcpu_sbi_hsm.c         | 105 +++++++++++++
arch/riscv/kvm/vcpu_sbi_replace.c     | 133 ++++++++++++++++
arch/riscv/kvm/vcpu_sbi_v01.c         | 126 +++++++++++++++
9 files changed, 599 insertions(+), 115 deletions(-)
create mode 100644 arch/riscv/include/asm/kvm_vcpu_sbi.h
create mode 100644 arch/riscv/kvm/vcpu_sbi_base.c
create mode 100644 arch/riscv/kvm/vcpu_sbi_hsm.c
create mode 100644 arch/riscv/kvm/vcpu_sbi_replace.c
create mode 100644 arch/riscv/kvm/vcpu_sbi_v01.c

--
2.33.1

