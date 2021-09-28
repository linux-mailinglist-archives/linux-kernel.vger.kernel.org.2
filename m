Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C5241AFA7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 15:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240856AbhI1NJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 09:09:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:53110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235776AbhI1NJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 09:09:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B5AE61159;
        Tue, 28 Sep 2021 13:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632834485;
        bh=l1vXN3bF7aIrN3+a2VGUKA/7C7ejKAmlAZJzvn4GgoE=;
        h=From:To:Cc:Subject:Date:From;
        b=fAGnST2wnnEl+VzgWbVZ2ZTMlwOnDHq7aeRsjmIg37EihcAjhfQ6VF3rjy+ChkrfF
         i9hfk7DArG7CRaLxCfD6nnuAP0DDr24A6I0Gbtu030+FHaaWnvQS4r9SfSSSxDr5GW
         V2oO65QRUkI+My/uIg56WssMcWZsum+eZEBn+GAy3ngjRFGdTtjyATbR77rT14genJ
         1MSQlv87HwVOvrZl9USDnyKByCNxcBlPpExeOimJxg25Q/IYT/mo6eb5IjR/6QpTWw
         b6oNs+mPtBj2HxotLuAvUkdZZ0lfhyhxgEyLapXvZwySjlDtywliqgrv39c1dSTpqr
         PkGiJ/gc/zT9A==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] NIOS2: fixes for v5.15
Date:   Tue, 28 Sep 2021 08:08:03 -0500
Message-Id: <20210928130803.249346-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these 2 fixes for NIOS2 for v5.15.

Thanks,

Dinh

The following changes since commit e4e737bb5c170df6135a127739a9e6148ee3da82:

  Linux 5.15-rc2 (2021-09-19 17:28:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/nios2_fixes_for_v5.15_part1

for you to fetch changes up to 9523b33cc31cf8ce703f8facee9fd16cba36d5ad:

  NIOS2: setup.c: drop unused variable 'dram_start' (2021-09-27 08:34:54 -0500)

----------------------------------------------------------------
NIOS2 fixes for v5.15
- Fix build warning for unmet dependency for EARLY_PRINTK
- Remove unused dram_start() function

----------------------------------------------------------------
Randy Dunlap (2):
      NIOS2: fix kconfig unmet dependency warning for SERIAL_CORE_CONSOLE
      NIOS2: setup.c: drop unused variable 'dram_start'

 arch/nios2/Kconfig.debug  | 3 ++-
 arch/nios2/kernel/setup.c | 2 --
 2 files changed, 2 insertions(+), 3 deletions(-)
