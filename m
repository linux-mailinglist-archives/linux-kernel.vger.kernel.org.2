Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23FAD32BE98
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385909AbhCCRc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:32:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:51212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242249AbhCCNwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:52:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 869FD64EC3;
        Wed,  3 Mar 2021 13:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614779419;
        bh=LQhZ5BU+nRYQULx0ZKG9Ay1y3ooSannOJVQLDg7rhDA=;
        h=From:To:Cc:Subject:Date:From;
        b=JKWAVe0RmqwyokpDoK7CoAnB8oUaSQMWGe5badQh37eHZVXqKfgYvOLsy+Ei7cWPK
         UNVASJfQxu3zS9yR+uoIhuRPUUVnMGq4F2FX8UOt78ioVkglSZgXcDwKA6IV/848tP
         6SjSIcfXibW8ZiNpyTkRSxXXz5qNhkpuq+ntBQp3Q+24TMrrj1HT4Fu1hKXmnVvP+x
         qvgyw3vIda6KjxFP+hnsGRmzGEpxhnEU/kUClBHDW0N1NNRTAcbGs16tt72p5Vjdmd
         NXnJzJSouStJQyLPtDCfxLmrPu/pJNZp3QjgZI/yzw0FyE+v9JonN+qXPMAwPpIVN8
         y6bJAbNCKD3mA==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Max Uvarov <muvarov@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 0/2] Fix arm64 CONFIG_CMDLINE handling and remove CMDLINE_EXTEND
Date:   Wed,  3 Mar 2021 13:49:25 +0000
Message-Id: <20210303134927.18975-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

This is version two of the series I previously posted here:

	https://lore.kernel.org/r/20210225125921.13147-1-will@kernel.org

The main change since v1 is that, rather than "fix" the FDT code to
follow the documented behaviour for CMDLINE_EXTEND, I've opted to remove
the thing entirely for arm64 while a less ambiguous and generic
replacement is developed, probably based on either [1] or [2].

I've left the first-patch as-is so that it's easier to incorporate
whatever ends up replacing CMDLINE_EXTEND in future.

Cheers,

Will

[1] https://patchwork.ozlabs.org/project/linuxppc-dev/cover/cover.1554195798.git.christophe.leroy@c-s.fr/
[2] https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20190319232448.45964-2-danielwa@cisco.com/

--->8

Cc: Max Uvarov <muvarov@gmail.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Tyler Hicks <tyhicks@linux.microsoft.com>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: <kernel-team@android.com>
Cc: <linux-arm-kernel@lists.infradead.org>
Cc: <devicetree@vger.kernel.org>

Will Deacon (2):
  arm64: cpufeatures: Fix handling of CONFIG_CMDLINE for idreg overrides
  arm64: Drop support for CMDLINE_EXTEND

 arch/arm64/Kconfig                 |  6 -----
 arch/arm64/kernel/idreg-override.c | 43 ++++++++++++++++--------------
 2 files changed, 23 insertions(+), 26 deletions(-)

-- 
2.30.1.766.gb4fecdf3b7-goog

