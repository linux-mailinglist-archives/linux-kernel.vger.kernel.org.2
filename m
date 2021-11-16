Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711D44531CB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 13:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236023AbhKPMK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 07:10:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:48442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236232AbhKPMIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 07:08:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11CF361A7D;
        Tue, 16 Nov 2021 12:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637064350;
        bh=BYhL4okiZLw5w3k/7r78kRy4W08MKuNGrkynR9V31m0=;
        h=From:To:Cc:Subject:Date:From;
        b=aOh1e63IYuuyJt3oc/lC89yb5yu7/8f0/OL4lap7+0HXaYRfeBTBoQFO6/CeHvxt6
         RDsjeqp8FKHW/WVoC27otB9F7u8l4lgoDQ/n63NJ6chWw7rNAi2XJCECZgzGXG2lpJ
         UqhPewKRlW8PUdz/lykBkshpMfPMmFTTNBACYKPFEWO8KmXvgTRKGhnNqu7peoERUd
         R0UPcEe3R8HZazaJk+lvmHzW2Vh/fYn0xSmcC8uG+K2zmv+HPNE3OfO5M3B28b6YOQ
         t+57KgGsmlFvo+0mEOsbovsQKUqChRFmZrITWTwpKMljlGMkZU0KRhiefKOUDRyWE8
         LK8Uz8R3/49ZA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mmxDe-00A9CC-Em; Tue, 16 Nov 2021 12:05:46 +0000
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 0/2] Ensure that HiKey 970 won't hang during boot time
Date:   Tue, 16 Nov 2021 12:05:42 +0000
Message-Id: <cover.1637064075.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During HiKey 970 boot, hundreds of clock lines are disabled, causing the device to
hang.

There are actually two issues here:

1. The clk core doesn't wait enough time for the device drivers to be probed
    before agressively disabling "unused" clocks. This was noticed at the
    drivers built as modules;
2. Several HiKey 970 gates are essencial for the device to work, but they're
    not marked as such.

The first patch fixes the clk core issue, while second one marks the mandatory
clocks as such.

Mauro Carvalho Chehab (2):
  clk: wait for extra time before disabling unused clocks
  clk: clk-hi3670: mark some clocks as CLK_IS_CRITICAL

 drivers/clk/clk.c                  | 51 +++++++++++++++++++-----------
 drivers/clk/hisilicon/clk-hi3670.c | 24 +++++++-------
 2 files changed, 44 insertions(+), 31 deletions(-)

-- 
2.33.1


