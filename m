Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D7E4568A5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 04:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbhKSDgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 22:36:42 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:36161 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231964AbhKSDgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 22:36:41 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 1A4733201D40;
        Thu, 18 Nov 2021 22:33:40 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 18 Nov 2021 22:33:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=HcpAtjbCxVLVCdO/fc3cclnSG7
        r71145LdITVbNqVN4=; b=XJ/5jzxMb+5m/x3+/N579fLniSfJVFnjh5RB5VCDiA
        ezNVhvwkhdtRhsN70GbPeL5XkcCG1VipNH3XdSEoGBMuxBKWWyJO4Dbsqkoh1u9g
        RNDcxGkyotOOxkbfAUor7SG5ZsbrqAERLQ/QUgGE3AFA8iSqkpziLJYMNwsHgnLV
        zVg/izO70cGpAs2C8MPQKbVNjwz5JawkRIAeqC2x3j0eIbXDkJER2EPtLtvaXV5j
        6vKe+C5M2ufbpL4q1AB5dPMqo1QZQ4TuY3yihOEIs93grvHp9fH3ax+aBR98FcXz
        Ci0Ntrw5dzf0AR6NYKjc6KEn+EoLw29vyxbQqNWCIvVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=HcpAtjbCxVLVCdO/f
        c3cclnSG7r71145LdITVbNqVN4=; b=iP/p3CIEAxWYOKlKy0UE67a92zQoPBlD6
        svB+aCDreR+SrwlMeqRQwNXXGdRrk+8Yhxi8j4bsiKeZ/oA4E/S4ROFVi01MyGow
        uRFLJmUEtJ24ytNvO25TL9GWgA9tKiLzlsKXlmzu9Mf2pOJnWm5NX3iVhtZ9HE+J
        tAlAxHlf6R1HqNayIsrek5igAHgPDV02ik7rQRWBXP6/FpnTQVUa8SM+Bd2oRQvo
        TArrlDB6SstSy4XircznJ62BENz2PJFNbhXzeKEGdbUCMrYPWMc4Fw9Ggoou3grE
        zhgBLPHBa+9+/PmnPYECp0+JPNhiJG8Kj94hfdqm1uJvNLth7vltA==
X-ME-Sender: <xms:ExuXYWZjJCPvO1z9VshvKGeJ6YVo8gLMPe18zZVGhXw41KKjpGdluA>
    <xme:ExuXYZYSygXUlTdXUiCS9RrMWzS34YiH6peo0MJc_8q79yHQyflO8nDveWzwJwO0L
    V25TFtW_eOkCJhdlA>
X-ME-Received: <xmr:ExuXYQ8GZTEGj66LHqfIICvW2xiS0v-uHAAWqcHYsv1tIXBkQFe3bGnB6WvsiMRo8EnB8YknvMWew4DcXRcJFZbe3PSxtcEZZSxfAeS3Yyds7JBlDAr5zru7erEjzfuLwpA1BQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeejgdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrfgrth
    htvghrnhepieetkefhheduudfgledtudefjeejfeegveehkeeufffhhfejkeehiefftdev
    tdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    grmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:ExuXYYp6LKihcyz9rn8leYYQcWEAOb3p5D88RDi2qu80c4mV90iwuQ>
    <xmx:ExuXYRrtg3CnnmFt_7KhP75l-5CV7xQJS9VtT1CjSkc-MkhByEyLCw>
    <xmx:ExuXYWTsDxByYqIGOmNCxDvLzHtU3t1_H5oxW2eiMTbBEd-nGm_tZQ>
    <xmx:ExuXYVeQLevht3aQPJgEyd8v61mBoNM74iudvgwKFoZTvWz-R-S-nA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Nov 2021 22:33:38 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 0/4] clk: sunxi-ng: Module support
Date:   Thu, 18 Nov 2021 21:33:33 -0600
Message-Id: <20211119033338.25486-1-samuel@sholland.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series allows the CCU core and drivers to be loaded/unloaded as
modules. As part of this, patch 3 converts most of the early OF clock
providers to platform drivers.

Changes in v3:
 - Also export helper functions.

Changes in v2:
 - Export symbols to the SUNXI_CCU namespace.

Changes in v1:
 - Patches 1-3 of 8 were merged.
 - Name modules using Makefile logic, not by renaming the source files.
   (Drop patch 4 of 8.)

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
 drivers/clk/sunxi-ng/ccu_common.c        |  6 ++
 drivers/clk/sunxi-ng/ccu_div.c           |  1 +
 drivers/clk/sunxi-ng/ccu_frac.c          |  6 ++
 drivers/clk/sunxi-ng/ccu_gate.c          |  4 +
 drivers/clk/sunxi-ng/ccu_mp.c            |  2 +
 drivers/clk/sunxi-ng/ccu_mult.c          |  1 +
 drivers/clk/sunxi-ng/ccu_mux.c           |  6 ++
 drivers/clk/sunxi-ng/ccu_nk.c            |  1 +
 drivers/clk/sunxi-ng/ccu_nkm.c           |  1 +
 drivers/clk/sunxi-ng/ccu_nkmp.c          |  1 +
 drivers/clk/sunxi-ng/ccu_nm.c            |  1 +
 drivers/clk/sunxi-ng/ccu_phase.c         |  1 +
 drivers/clk/sunxi-ng/ccu_reset.c         |  1 +
 drivers/clk/sunxi-ng/ccu_sdm.c           |  6 ++
 drivers/mmc/host/Kconfig                 |  1 +
 include/linux/clk/sunxi-ng.h             | 15 ----
 39 files changed, 490 insertions(+), 251 deletions(-)

-- 
2.32.0

