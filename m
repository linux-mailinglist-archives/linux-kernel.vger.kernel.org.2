Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E59332206B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 20:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbhBVTpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 14:45:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:55068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233277AbhBVTnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 14:43:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0767864E5B;
        Mon, 22 Feb 2021 19:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614022941;
        bh=6ZRXacZwBMTVavJ32wJarmiD2obBpZ5uNUZXITH4fqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uLwCgJ+ntkkya8r77vm4W3u0cr6CaygbZb4Ul/vCX657VyHj94QoR7AJakjf0TXLQ
         12ckfewl+fj3CO+BOvNFrQJrqZp7GcwfLp6xgwQhKVBqG2CNjQODr7qdwoVy1sb9Zy
         N69DjvXzv/u374VUXPc7uHzEvV1lLDZR3l785ISFzulotECQEaaObNX79i7nnxCF5t
         sWCH8HyB0U0B9GeT9XESbYC+U747NWGQNTWmzLcrmiubL0mRrlO+T5l2o1VF+YQk9V
         Q4LC0ZXdiidf2KeL3sS2f8qmS2ul5y0y2GeH+e3E+KGxOlXeZpnathlpp7jK8Ul0Ra
         W+WXx21wkQ6EQ==
Received: by pali.im (Postfix)
        id 4CB4310B4; Mon, 22 Feb 2021 20:42:18 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Andre Heider <a.heider@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        =?UTF-8?q?G=C3=A9rald=20Kerma?= <gerald@gk2.net>,
        Konstantin Porotchkin <kostap@marvell.com>
Subject: [PATCH mvebu v3 08/10] cpufreq: armada-37xx: Fix determining base CPU frequency
Date:   Mon, 22 Feb 2021 20:41:56 +0100
Message-Id: <20210222194158.12342-9-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210222194158.12342-1-pali@kernel.org>
References: <20210114124032.12765-1-pali@kernel.org>
 <20210222194158.12342-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When current CPU load is not L0 then loading armada-37xx-cpufreq.ko driver
fails with following error:

    # modprobe armada-37xx-cpufreq
    [  502.702097] Unsupported CPU frequency 250 MHz

This issue was partially fixed by commit 8db82563451f ("cpufreq:
armada-37xx: fix frequency calculation for opp"), but only for calculating
CPU frequency for opp.

Fix this also for determination of base CPU frequency.

Signed-off-by: Pali Rohár <pali@kernel.org>
Tested-by: Tomasz Maciej Nowak <tmn505@gmail.com>
Tested-by: Anders Trier Olesen <anders.trier.olesen@gmail.com>
Tested-by: Philip Soares <philips@netisense.com>
Fixes: 92ce45fb875d ("cpufreq: Add DVFS support for Armada 37xx")
Cc: stable@vger.kernel.org # 8db82563451f ("cpufreq: armada-37xx: fix frequency calculation for opp")
---
 drivers/cpufreq/armada-37xx-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
index 1ab2113daef5..e4782f562e7a 100644
--- a/drivers/cpufreq/armada-37xx-cpufreq.c
+++ b/drivers/cpufreq/armada-37xx-cpufreq.c
@@ -469,7 +469,7 @@ static int __init armada37xx_cpufreq_driver_init(void)
 		return -EINVAL;
 	}
 
-	dvfs = armada_37xx_cpu_freq_info_get(cur_frequency);
+	dvfs = armada_37xx_cpu_freq_info_get(base_frequency);
 	if (!dvfs) {
 		clk_put(clk);
 		return -EINVAL;
-- 
2.20.1

