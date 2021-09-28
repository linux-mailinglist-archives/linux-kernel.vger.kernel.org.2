Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4AA41A9EE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 09:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239390AbhI1HlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 03:41:14 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:48411 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239254AbhI1HlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 03:41:08 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id DF2973201C6E;
        Tue, 28 Sep 2021 03:39:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 28 Sep 2021 03:39:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=rQofqKCwgwQyVPNRlD1YlEE278
        8xpwMoIdiKnvJlJBg=; b=aPW8RiIi4daLt5eIcAy7ORw3D+HEbp/FNTWfKK44+B
        ncrc00ToEOueMJMkQB5qf7B11kg2iKXGF/wclibNrY5jRAwE//CE9SeP6w7WAnfi
        2R7X4RxuTP29cRaMFlrftbZNDQ7TJLZjHnb3WRPlAbJMTtTeMOmp8MFo32rZRlvf
        ax2zHmGe4gm1/GdghW63ll3zvR/jVNlWYU/oKKvJ031CRmbKD+QPsUGq9mGmTn9D
        XyFVPJyg8z1debz8bRxJNw8FqY8wYPm6EJeHDJY6NEOeSWb3Xe36mxcJL4Rry58S
        w0Fui9OPTpVpVYcY7i6xcNM3Fw5bDuviExRjFz0FOTKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=rQofqKCwgwQyVPNRl
        D1YlEE2788xpwMoIdiKnvJlJBg=; b=u4OcKhboc3iRzJUGuJYnWPUDWND9opTS7
        8NjhOQLq2PVCKurIgfIfhYiJkiwwApmrxGmV0KXMatfE8du2hd9svfa3xsx57Cyw
        +1XfeJSuMhOY13EzwNlu5oEDEnWbYxHexCOdFJdZHU+JK/POVcIuYm/ObpwrKeZI
        QUBepj2RADW5pTb3VmglBk1ZEF6v8aAlIIlvnDv32cIMS6fw48TKuCJZ6cgnvfGt
        MvjJlN9vKvFmPLbTME22wK+l31y5CqIxC1+uHx16qgwyUcXPBtJRxiKvarPh0LYs
        +o0OVbcJdlssYNXTAhdGvrwUMc9pKrqMf9JZjgeWI2vWEkI5Jo+NA==
X-ME-Sender: <xms:q8ZSYXaFURkRd7i7ni3c6trB0SYkXWOcbSxPokN7f_I3DupH0i8GfQ>
    <xme:q8ZSYWbzW6on0Y7GQtHdPelmPZdTPacVg0IcQB2HginHbZkWbJko1arcoYIWY62_I
    s_h6JnNyflWeBeJJQ>
X-ME-Received: <xmr:q8ZSYZ-ePPMBtS4asLNpnFsy_kRuZE1RkA664TF8W85xLSm5VOgr6GrIbR9e6yP2gjl8lefwcoSaxz7W_1PhS6maChL5kc-E5W9WD-zg3SHXUdW6cn99Q6WSYTLEqXmxsDngMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudejledguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepieetkefhheduudfgledtudefjeejfeegveehkeeufffhhfejkeehieff
    tdevtdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:q8ZSYdrPyWjVf8fvcMYcV49ha2kRibHJkI1EZZqTGir3jHMRu2FyDA>
    <xmx:q8ZSYSog59Nq8GgVghLzFVKtfoub_OvpfbGsdwb08cIEc1wYJI5lRg>
    <xmx:q8ZSYTQK7XPm7jjzxEQ85SXMiWMJ4lOtAcmq6y-MDMBaxCZB2F7PnA>
    <xmx:rMZSYedsXPPwSAuGmcDYdiv0pgV2Bilr8lmG-mba_eaarbilGampEQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Sep 2021 03:39:23 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 0/4] clk: sunxi-ng: Module support
Date:   Tue, 28 Sep 2021 02:39:18 -0500
Message-Id: <20210928073922.34264-1-samuel@sholland.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series allows the CCU core and drivers to be loaded/unloaded as
modules. As part of this, patch 3 converts most of the early OF clock
providers to platform drivers.

Changes from v1:
  - Patches 1-3 of 8 were merged.
  - Name modules using Makefile logic, not by renaming the source files.
    (Drop patch 4 of 8).
  - Export symbols to the SUNXI_CCU namespace.

Samuel Holland (4):
  clk: sunxi-ng: Export symbols used by CCU drivers
  clk: sunxi-ng: Allow drivers to be built as modules
  clk: sunxi-ng: Convert early providers to platform drivers
  clk: sunxi-ng: Allow the CCU core to be built as a module

 drivers/clk/Makefile                     |  2 +-
 drivers/clk/sunxi-ng/Kconfig             | 39 +++++-----
 drivers/clk/sunxi-ng/Makefile            | 97 +++++++++++++++---------
 drivers/clk/sunxi-ng/ccu-sun4i-a10.c     | 58 ++++++++------
 drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c |  4 +-
 drivers/clk/sunxi-ng/ccu-sun50i-a100.c   |  4 +-
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c    |  7 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c   | 56 +++++++++-----
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c     |  7 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h616.c   | 33 +++++---
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c     | 40 +++++++---
 drivers/clk/sunxi-ng/ccu-sun8i-a23.c     | 35 ++++++---
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c     | 40 +++++++---
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c    |  7 +-
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c     |  9 ++-
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c      | 62 ++++++++++-----
 drivers/clk/sunxi-ng/ccu-sun8i-r.c       | 65 +++++++++-------
 drivers/clk/sunxi-ng/ccu-sun8i-r40.c     |  6 +-
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c     | 57 ++++++++------
 drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c  |  7 +-
 drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c |  7 +-
 drivers/clk/sunxi-ng/ccu-sun9i-a80.c     |  7 +-
 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c | 38 +++++++---
 drivers/clk/sunxi-ng/ccu_common.c        |  5 ++
 drivers/clk/sunxi-ng/ccu_div.c           |  1 +
 drivers/clk/sunxi-ng/ccu_gate.c          |  1 +
 drivers/clk/sunxi-ng/ccu_mp.c            |  2 +
 drivers/clk/sunxi-ng/ccu_mult.c          |  1 +
 drivers/clk/sunxi-ng/ccu_mux.c           |  2 +
 drivers/clk/sunxi-ng/ccu_nk.c            |  1 +
 drivers/clk/sunxi-ng/ccu_nkm.c           |  1 +
 drivers/clk/sunxi-ng/ccu_nkmp.c          |  1 +
 drivers/clk/sunxi-ng/ccu_nm.c            |  1 +
 drivers/clk/sunxi-ng/ccu_phase.c         |  1 +
 drivers/clk/sunxi-ng/ccu_reset.c         |  1 +
 drivers/mmc/host/Kconfig                 |  1 +
 include/linux/clk/sunxi-ng.h             | 15 ----
 37 files changed, 470 insertions(+), 251 deletions(-)

-- 
2.31.1

