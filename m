Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED45531EA60
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 14:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbhBRNSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 08:18:54 -0500
Received: from mail.manjaro.org ([176.9.38.148]:54992 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232068AbhBRLmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 06:42:00 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 34AB93E600A0;
        Thu, 18 Feb 2021 12:20:26 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id O9EmeLmQl_Hb; Thu, 18 Feb 2021 12:20:23 +0100 (CET)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     Icenowy Zheng <icenowy@aosc.io>, Maxime Ripard <maxime@cerno.tech>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH v2 0/1] clk: sunxi-ng: v3s: use sigma-delta modulation for audio-pll
Date:   Thu, 18 Feb 2021 12:20:00 +0100
Message-Id: <20210218112001.479018-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch extends the v3s audio-pll declaration to use sdm for supporting
24.576MHz and 22.5792MHz clock rates, required by the i2s peripheral driver.

This is v2 of the patch. The previous version used a flexible postdivider only.
However, that setup was unable to provide the 22.5792MHz clock rate.

Cheers,
Tobias

Changelog:
 v2:
  - use sdm instead of postdivider for audio-pll
  - change patch subject to reflect use of sdm

Tobias Schramm (1):
  clk: sunxi-ng: v3s: use sigma-delta modulation for audio-pll

 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c | 33 ++++++++++++++++++----------
 1 file changed, 22 insertions(+), 11 deletions(-)

-- 
2.30.1

