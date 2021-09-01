Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D1D3FD2A5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 07:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241917AbhIAFG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 01:06:28 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:39903 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241867AbhIAFG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 01:06:27 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id AC95A5C01AA;
        Wed,  1 Sep 2021 01:05:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 01 Sep 2021 01:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=KqsQEX6suVXyYh+VNhO6CzM7Bz
        wd4OktkIgoqscdHoc=; b=SlczwzETkVAOAs+ffobh3dIxoLHYT6DcDsiN55fuqH
        SYP/BikM4sfWXkjYdgTO90WCVT1qw3YTPGmLpPqaCRY7dOL/QlT1KwfRmf+UYWXF
        dX0v4yZeGhAHEvsR8vdZ0MT1uvMJ+oIwq5knovERznwhothyP2I3HJB5FTawxgEr
        1tlqx0nzZrrQOph8CTTyumg0682S9v0kjsDymqeCHN1r+3vH33sHwM+L3VLiKUYR
        XG3bSF8PIIciTXF3A+FNErgoM3a6nRfgJmoWGFxy2JC+2RR1rNQwr8CaGj2GVIl0
        gMFcE/6/oSxHfJN3c4BTAn19yJUMgD4TPI/jBhSoMwgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=KqsQEX6suVXyYh+VN
        hO6CzM7Bzwd4OktkIgoqscdHoc=; b=MWhyTEvs+n1Zqqeg5cEzQ7QnHkLpGbQJH
        /OjkFwmhzHkAn63ZcUIY+e5HlzjeQWHcHYS3S/aTxehHbTf8xAjxeptflEv1/LCw
        Gt7KOuceP03yGD1tzTDENvVKAiN20j24L1L83Zkyxp+x7aRA/cLIyQge7gvJBPru
        TOV00gJJE9vcLy413WO6bj9IkgmpS3ZnmSpCHFWUly68i1ijf3DR4KsdEDtDQC+g
        DhIDtmDOiYGk82L38PmUk2lrfMD9RLTSq3ymurT/QzH4NOr72xDLslazMCNPhaHO
        9CyiFY0/JFijWIAMubhjaEr7Bix83pk3+aa+kluXAUN1+98j252rQ==
X-ME-Sender: <xms:GAovYRRJ4kSYdFuWYt2YqJLRQgeDe10wUTIxAey9Slkozam1PZuZqQ>
    <xme:GAovYawxZ6B9S8WIyO_jxu777AkFoFFPHuq-eV05gtYHnVecmIFwdJKaDH1jW7O_q
    jbkIIZZ6T43bF_lwQ>
X-ME-Received: <xmr:GAovYW0Ggey_nO20dD2WSa1NGgzBIiN5KsFLBGSOhXMeoluEBHkBSsNRt2qwZLk3Bg21Jns7jweTdd4xXPxxuLXFvDkPaRI6fplcRsTpqW7n9k-9orQFsC3AKA8vQq1cYUViYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvvddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeeiteekhfehuddugfeltddufeejjeefgeevheekueffhffhjeekheeiffdt
    vedtveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:GAovYZAWFVaRWrDyWAXrS2yl1W_oRosWUh0sgiSsICnXQ1z4zh_pcA>
    <xmx:GAovYai_Q4IttboECtD0C2lpWDbWqsn8uOKdFPhzJ73tsp0odG3V0Q>
    <xmx:GAovYdom0DTOH10okaCu_pgSkw1Vg8ncGuNAs1uY5fMFrLyFlVooWQ>
    <xmx:GgovYTVk4g9YCrWMq3FvCpQpZ_gpVPVVyv6-IB4E8ffcUPfOvd8xjQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Sep 2021 01:05:28 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 0/8] clk: sunxi-ng: Lifetime fixes and module support
Date:   Wed,  1 Sep 2021 00:05:18 -0500
Message-Id: <20210901050526.45673-1-samuel@sholland.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series makes the CCU drivers a bit better behaved, by allowing them
to be cleanly loaded/unloaded and bound/unbound without leaking memory
or crashing.

- Patches 1 fixes some object lifetime and reference counting issues
  with the drivers.
- Patch 2 disarms a sysfs footgun.
- Patch 3 takes advantage of the structure added in patch 1 to improve
  performance a bit by splitting up the lock.
- Patches 4-8 allow the drivers and CCU core to be built as modules.
  As part of this, patch 7 converts most of the early OF providers to
  platform drivers.

Samuel Holland (8):
  clk: sunxi-ng: Unregister clocks/resets when unbinding
  clk: sunxi-ng: Prevent unbinding CCUs via sysfs
  clk: sunxi-ng: Use a separate lock for each CCU instance
  clk: sunxi-ng: Rename files to match Kconfig and drivers
  clk: sunxi-ng: Export symbols used by CCU drivers
  clk: sunxi-ng: Allow drivers to be built as modules
  clk: sunxi-ng: Convert early providers to platform drivers
  clk: sunxi-ng: Allow the CCU core to be built as a module

 drivers/clk/Makefile                          |   2 +-
 drivers/clk/sunxi-ng/Kconfig                  |  39 +++----
 drivers/clk/sunxi-ng/Makefile                 |  75 ++++++-------
 drivers/clk/sunxi-ng/ccu_common.c             | 101 +++++++++++++++---
 drivers/clk/sunxi-ng/ccu_common.h             |   6 +-
 drivers/clk/sunxi-ng/ccu_div.c                |   1 +
 drivers/clk/sunxi-ng/ccu_gate.c               |   1 +
 drivers/clk/sunxi-ng/ccu_mp.c                 |   2 +
 drivers/clk/sunxi-ng/ccu_mult.c               |   1 +
 drivers/clk/sunxi-ng/ccu_mux.c                |   2 +
 drivers/clk/sunxi-ng/ccu_nk.c                 |   1 +
 drivers/clk/sunxi-ng/ccu_nkm.c                |   1 +
 drivers/clk/sunxi-ng/ccu_nkmp.c               |   1 +
 drivers/clk/sunxi-ng/ccu_nm.c                 |   1 +
 drivers/clk/sunxi-ng/ccu_phase.c              |   1 +
 drivers/clk/sunxi-ng/ccu_reset.c              |   1 +
 .../{ccu-sun4i-a10.c => sun4i-a10-ccu.c}      |  59 ++++++----
 .../{ccu-sun4i-a10.h => sun4i-a10-ccu.h}      |   0
 .../{ccu-sun50i-a100.c => sun50i-a100-ccu.c}  |   8 +-
 .../{ccu-sun50i-a100.h => sun50i-a100-ccu.h}  |   0
 ...cu-sun50i-a100-r.c => sun50i-a100-r-ccu.c} |   8 +-
 ...cu-sun50i-a100-r.h => sun50i-a100-r-ccu.h} |   0
 .../{ccu-sun50i-a64.c => sun50i-a64-ccu.c}    |  11 +-
 .../{ccu-sun50i-a64.h => sun50i-a64-ccu.h}    |   0
 .../{ccu-sun50i-h6.c => sun50i-h6-ccu.c}      |  11 +-
 .../{ccu-sun50i-h6.h => sun50i-h6-ccu.h}      |   0
 .../{ccu-sun50i-h6-r.c => sun50i-h6-r-ccu.c}  |  57 ++++++----
 .../{ccu-sun50i-h6-r.h => sun50i-h6-r-ccu.h}  |   0
 .../{ccu-sun50i-h616.c => sun50i-h616-ccu.c}  |  36 ++++---
 .../{ccu-sun50i-h616.h => sun50i-h616-ccu.h}  |   0
 .../clk/sunxi-ng/{ccu-sun5i.c => sun5i-ccu.c} |   4 +-
 .../clk/sunxi-ng/{ccu-sun5i.h => sun5i-ccu.h} |   0
 .../{ccu-sun6i-a31.c => sun6i-a31-ccu.c}      |  41 +++++--
 .../{ccu-sun6i-a31.h => sun6i-a31-ccu.h}      |   0
 ...cu-sun8i-a23-a33.h => sun8i-a23-a33-ccu.h} |   0
 .../{ccu-sun8i-a23.c => sun8i-a23-ccu.c}      |  36 +++++--
 .../{ccu-sun8i-a33.c => sun8i-a33-ccu.c}      |  41 +++++--
 .../{ccu-sun8i-a83t.c => sun8i-a83t-ccu.c}    |  11 +-
 .../{ccu-sun8i-a83t.h => sun8i-a83t-ccu.h}    |   0
 .../{ccu-sun8i-de2.c => sun8i-de2-ccu.c}      |  12 ++-
 .../{ccu-sun8i-de2.h => sun8i-de2-ccu.h}      |   0
 .../{ccu-sun8i-h3.c => sun8i-h3-ccu.c}        |  63 +++++++----
 .../{ccu-sun8i-h3.h => sun8i-h3-ccu.h}        |   0
 .../sunxi-ng/{ccu-sun8i-r.c => sun8i-r-ccu.c} |  66 +++++++-----
 .../sunxi-ng/{ccu-sun8i-r.h => sun8i-r-ccu.h} |   0
 .../{ccu-sun8i-r40.c => sun8i-r40-ccu.c}      |  10 +-
 .../{ccu-sun8i-r40.h => sun8i-r40-ccu.h}      |   0
 .../{ccu-sun8i-v3s.c => sun8i-v3s-ccu.c}      |  58 ++++++----
 .../{ccu-sun8i-v3s.h => sun8i-v3s-ccu.h}      |   0
 .../{ccu-sun9i-a80.c => sun9i-a80-ccu.c}      |  11 +-
 .../{ccu-sun9i-a80.h => sun9i-a80-ccu.h}      |   0
 ...{ccu-sun9i-a80-de.c => sun9i-a80-de-ccu.c} |  12 ++-
 ...{ccu-sun9i-a80-de.h => sun9i-a80-de-ccu.h} |   0
 ...cu-sun9i-a80-usb.c => sun9i-a80-usb-ccu.c} |  11 +-
 ...cu-sun9i-a80-usb.h => sun9i-a80-usb-ccu.h} |   0
 ...cu-suniv-f1c100s.c => suniv-f1c100s-ccu.c} |  39 +++++--
 ...cu-suniv-f1c100s.h => suniv-f1c100s-ccu.h} |   0
 drivers/mmc/host/Kconfig                      |   1 +
 include/linux/clk/sunxi-ng.h                  |  15 ---
 59 files changed, 551 insertions(+), 306 deletions(-)
 rename drivers/clk/sunxi-ng/{ccu-sun4i-a10.c => sun4i-a10-ccu.c} (98%)
 rename drivers/clk/sunxi-ng/{ccu-sun4i-a10.h => sun4i-a10-ccu.h} (100%)
 rename drivers/clk/sunxi-ng/{ccu-sun50i-a100.c => sun50i-a100-ccu.c} (99%)
 rename drivers/clk/sunxi-ng/{ccu-sun50i-a100.h => sun50i-a100-ccu.h} (100%)
 rename drivers/clk/sunxi-ng/{ccu-sun50i-a100-r.c => sun50i-a100-r-ccu.c} (97%)
 rename drivers/clk/sunxi-ng/{ccu-sun50i-a100-r.h => sun50i-a100-r-ccu.h} (100%)
 rename drivers/clk/sunxi-ng/{ccu-sun50i-a64.c => sun50i-a64-ccu.c} (99%)
 rename drivers/clk/sunxi-ng/{ccu-sun50i-a64.h => sun50i-a64-ccu.h} (100%)
 rename drivers/clk/sunxi-ng/{ccu-sun50i-h6.c => sun50i-h6-ccu.c} (99%)
 rename drivers/clk/sunxi-ng/{ccu-sun50i-h6.h => sun50i-h6-ccu.h} (100%)
 rename drivers/clk/sunxi-ng/{ccu-sun50i-h6-r.c => sun50i-h6-r-ccu.c} (87%)
 rename drivers/clk/sunxi-ng/{ccu-sun50i-h6-r.h => sun50i-h6-r-ccu.h} (100%)
 rename drivers/clk/sunxi-ng/{ccu-sun50i-h616.c => sun50i-h616-ccu.c} (98%)
 rename drivers/clk/sunxi-ng/{ccu-sun50i-h616.h => sun50i-h616-ccu.h} (100%)
 rename drivers/clk/sunxi-ng/{ccu-sun5i.c => sun5i-ccu.c} (99%)
 rename drivers/clk/sunxi-ng/{ccu-sun5i.h => sun5i-ccu.h} (100%)
 rename drivers/clk/sunxi-ng/{ccu-sun6i-a31.c => sun6i-a31-ccu.c} (98%)
 rename drivers/clk/sunxi-ng/{ccu-sun6i-a31.h => sun6i-a31-ccu.h} (100%)
 rename drivers/clk/sunxi-ng/{ccu-sun8i-a23-a33.h => sun8i-a23-a33-ccu.h} (100%)
 rename drivers/clk/sunxi-ng/{ccu-sun8i-a23.c => sun8i-a23-ccu.c} (97%)
 rename drivers/clk/sunxi-ng/{ccu-sun8i-a33.c => sun8i-a33-ccu.c} (97%)
 rename drivers/clk/sunxi-ng/{ccu-sun8i-a83t.c => sun8i-a83t-ccu.c} (99%)
 rename drivers/clk/sunxi-ng/{ccu-sun8i-a83t.h => sun8i-a83t-ccu.h} (100%)
 rename drivers/clk/sunxi-ng/{ccu-sun8i-de2.c => sun8i-de2-ccu.c} (98%)
 rename drivers/clk/sunxi-ng/{ccu-sun8i-de2.h => sun8i-de2-ccu.h} (100%)
 rename drivers/clk/sunxi-ng/{ccu-sun8i-h3.c => sun8i-h3-ccu.c} (97%)
 rename drivers/clk/sunxi-ng/{ccu-sun8i-h3.h => sun8i-h3-ccu.h} (100%)
 rename drivers/clk/sunxi-ng/{ccu-sun8i-r.c => sun8i-r-ccu.c} (87%)
 rename drivers/clk/sunxi-ng/{ccu-sun8i-r.h => sun8i-r-ccu.h} (100%)
 rename drivers/clk/sunxi-ng/{ccu-sun8i-r40.c => sun8i-r40-ccu.c} (99%)
 rename drivers/clk/sunxi-ng/{ccu-sun8i-r40.h => sun8i-r40-ccu.h} (100%)
 rename drivers/clk/sunxi-ng/{ccu-sun8i-v3s.c => sun8i-v3s-ccu.c} (96%)
 rename drivers/clk/sunxi-ng/{ccu-sun8i-v3s.h => sun8i-v3s-ccu.h} (100%)
 rename drivers/clk/sunxi-ng/{ccu-sun9i-a80.c => sun9i-a80-ccu.c} (99%)
 rename drivers/clk/sunxi-ng/{ccu-sun9i-a80.h => sun9i-a80-ccu.h} (100%)
 rename drivers/clk/sunxi-ng/{ccu-sun9i-a80-de.c => sun9i-a80-de-ccu.c} (97%)
 rename drivers/clk/sunxi-ng/{ccu-sun9i-a80-de.h => sun9i-a80-de-ccu.h} (100%)
 rename drivers/clk/sunxi-ng/{ccu-sun9i-a80-usb.c => sun9i-a80-usb-ccu.c} (95%)
 rename drivers/clk/sunxi-ng/{ccu-sun9i-a80-usb.h => sun9i-a80-usb-ccu.h} (100%)
 rename drivers/clk/sunxi-ng/{ccu-suniv-f1c100s.c => suniv-f1c100s-ccu.c} (96%)
 rename drivers/clk/sunxi-ng/{ccu-suniv-f1c100s.h => suniv-f1c100s-ccu.h} (100%)

-- 
2.31.1

