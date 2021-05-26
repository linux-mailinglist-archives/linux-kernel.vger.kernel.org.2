Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24251392083
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 21:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbhEZTHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 15:07:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232198AbhEZTHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 15:07:16 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF234613B5;
        Wed, 26 May 2021 19:05:44 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1llyqc-003o26-QX; Wed, 26 May 2021 20:05:42 +0100
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
        Moritz Fischer <mdf@kernel.org>, kernel-team@android.com
Subject: [PATCH 0/4] arm64: Make kexec_file_load honor iomem reservations
Date:   Wed, 26 May 2021 20:05:27 +0100
Message-Id: <20210526190531.62751-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org, mark.rutland@arm.com, james.morse@arm.com, lorenzo.pieralisi@arm.com, guohanjun@huawei.com, sudeep.holla@arm.com, ebiederm@xmission.com, bhupesh.sharma@linaro.org, takahiro.akashi@linaro.org, dyoung@redhat.com, mdf@kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a complete departure from the approach I initially sent
almost a month ago[1]. Instead of trying to teach EFI, ACPI and other
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

Obviously, this is now at least 5.14 material. Given how broken
kexec_file_load is for non-crash kernels on arm64 at the moment,
should we at least disable it in 5.13 and all previous stable kernels?

Thanks,

	M.

[1] https://lore.kernel.org/r/20210429133533.1750721-1-maz@kernel.org

Marc Zyngier (4):
  kexec_file: Make locate_mem_hole_callback global
  kernel/resource: Populate child pointer in find_next_iomem_res()
  kernel/resource: Add walk_excluding_child_res() helper
  arm64: kexec_image: Implement arch_kexec_locate_mem_hole()

 arch/arm64/kernel/kexec_image.c | 45 ++++++++++++++++++
 include/linux/ioport.h          |  4 ++
 include/linux/kexec.h           |  1 +
 kernel/kexec_file.c             |  6 +--
 kernel/resource.c               | 81 +++++++++++++++++++++++++++++++++
 5 files changed, 134 insertions(+), 3 deletions(-)

-- 
2.30.2

