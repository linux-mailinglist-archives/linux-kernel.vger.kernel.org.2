Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A26395885
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 11:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhEaJ7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 05:59:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:57556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231211AbhEaJ7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 05:59:30 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41410610E7;
        Mon, 31 May 2021 09:57:50 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1lneg8-004Z7v-5g; Mon, 31 May 2021 10:57:48 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Bhupesh SHARMA <bhupesh.sharma@linaro.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Dave Young <dyoung@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Moritz Fischer <mdf@kernel.org>, kernel-team@android.com
Subject: [PATCH v2 0/5] arm64: Make kexec_file_load honor iomem reservations
Date:   Mon, 31 May 2021 10:57:15 +0100
Message-Id: <20210531095720.77469-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org, mark.rutland@arm.com, james.morse@arm.com, lorenzo.pieralisi@arm.com, guohanjun@huawei.com, sudeep.holla@arm.com, ebiederm@xmission.com, bhupesh.sharma@linaro.org, takahiro.akashi@linaro.org, dyoung@redhat.com, akpm@linux-foundation.org, mdf@kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a complete departure from the approach I initially sent
almost a month ago[0]. Instead of trying to teach EFI, ACPI and other
subsystem to use memblock, I've decided to stick with the iomem
resource tree and use that exclusively for arm64.

This means that my current approach is (despite what I initially
replied to both Dave and Catalin) to provide an arm64-specific
implementation of arch_kexec_locate_mem_hole() which walks the
resource tree and excludes ranges of RAM that have been registered for
any odd purpose. This is exactly what the userspace implementation
does, and I don't really see a good reason to diverge from it.

Again, this allows my Synquacer board to reliably use kexec_file_load
with as little as 256M, something that would always fail before as it
would overwrite most of the reserved tables.

Although this series still targets 5.14, the initial patch is a
-stable candidate, and disables non-kdump uses of kexec_file_load. I
have limited it to 5.10, as earlier kernels will require a different,
probably more invasive approach.

Catalin, Ard: although this series has changed a bit compared to v1,
I've kept your AB/RB tags. Should anything seem odd, please let me
know and I'll drop them.

Thanks,

	M.

* From v1 [1]:
  - Move the overlap exclusion into find_next_iomem_res()
  - Handle child resource not overlapping with parent
  - Provide walk_system_ram_excluding_child_res() as a top level
    walker
  - Simplify arch-specific code
  - Add initial patch disabling non-crash kernels

[0] https://lore.kernel.org/r/20210429133533.1750721-1-maz@kernel.org
[1] https://lore.kernel.org/r/20210526190531.62751-1-maz@kernel.org

Marc Zyngier (5):
  arm64: kexec_file: Forbid non-crash kernels
  kexec_file: Make locate_mem_hole_callback global
  kernel/resource: Allow find_next_iomem_res() to exclude overlapping
    child resources
  kernel/resource: Introduce walk_system_ram_excluding_child_res()
  arm64: kexec_image: Restore full kexec functionnality

 arch/arm64/kernel/kexec_image.c | 39 ++++++++++++++++
 include/linux/ioport.h          |  3 ++
 include/linux/kexec.h           |  1 +
 kernel/kexec_file.c             |  6 +--
 kernel/resource.c               | 82 +++++++++++++++++++++++++++++----
 5 files changed, 119 insertions(+), 12 deletions(-)

-- 
2.30.2

