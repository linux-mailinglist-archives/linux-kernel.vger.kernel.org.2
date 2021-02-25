Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C67325018
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 14:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbhBYNAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 08:00:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:53788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhBYNAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 08:00:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A01764EFA;
        Thu, 25 Feb 2021 12:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614257972;
        bh=sVUg7LiguqcAc8O/ICFWYVfi3WzvdjvcCH+R66oxjlk=;
        h=From:To:Cc:Subject:Date:From;
        b=lC9MrLm/fRZoB0WLRNBw/KxUmlpZgIY8aDrybkAQuCAHogZHj5NKB4MZ4fkRPZEN8
         kZfN8GEMe0l80eC1zj+/kDnKvIZaDIdOukn0640F1YTbeusEFccn1IU67uiF4BK9mY
         7qwv04zcrXkLFhgx8fZ7HpFSD68c7URzRttq29JNf+aK17lNWyiwhrrMq2s7zaz246
         sQxuTNqXDM6gYAObki0QGn4Gj+h25t6t6+6vt4kPwcWQCxaVb5JaTJ++2zTR3+6pn5
         WxAeoXlCzLbN8vmcldJaRSUL9SR3dgl5LqAq4GSzWYITJko9ijyRTui/XB/FOZepoz
         ZrcSaMf4VWqXA==
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
Subject: [PATCH 0/2] Fix CMDLINE_EXTEND handling for FDT "bootargs"
Date:   Thu, 25 Feb 2021 12:59:19 +0000
Message-Id: <20210225125921.13147-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

We recently [1] enabled support for CMDLINE_EXTEND on arm64, however
when I started looking at replacing Android's out-of-tree implementation [2]
with the upstream version, I noticed that the two behave significantly
differently: Android follows the Kconfig help text of appending the
bootloader arguments to the kernel command line, whereas upstream appends
the kernel command line to the bootloader arguments. That is, except for
the EFI stub, which follows the documented behaviour.

I think the documented behaviour is more useful, so this patch series
reworks the FDT code to follow that and updates the very recently merged
arm64 idreg early command-line parsing as well.

I'd like to take the first patch as a fix via the arm64 tree.

Cheers,

Will

[1] https://lore.kernel.org/r/160650434702.20875.12520970127987518808.b4-ty@arm.com
[2] https://android-review.googlesource.com/c/kernel/common/+/841045

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
  of/fdt: Append bootloader arguments when CMDLINE_EXTEND=y

 arch/arm64/kernel/idreg-override.c | 44 +++++++++++---------
 drivers/of/fdt.c                   | 64 ++++++++++++++++++------------
 2 files changed, 64 insertions(+), 44 deletions(-)

-- 
2.30.1.766.gb4fecdf3b7-goog

