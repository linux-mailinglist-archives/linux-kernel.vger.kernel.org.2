Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 983823C7B12
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 03:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237317AbhGNBdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 21:33:38 -0400
Received: from mga09.intel.com ([134.134.136.24]:4154 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229843AbhGNBdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 21:33:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="210246815"
X-IronPort-AV: E=Sophos;i="5.84,237,1620716400"; 
   d="scan'208";a="210246815"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 18:30:44 -0700
X-IronPort-AV: E=Sophos;i="5.84,237,1620716400"; 
   d="scan'208";a="570947946"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 18:30:38 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, bard.liao@intel.com
Subject: [PATCH] soundwire: dmi-quirks: add ull suffix for SoundWire _ADR values
Date:   Wed, 14 Jul 2021 09:30:27 +0800
Message-Id: <20210714013027.17022-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Sparse throws the following type of warnings:

drivers/soundwire/dmi-quirks.c:25:17: error: constant
0x000010025D070100 is so big it is long

Let's add the 'ull' suffix to make this go away and find real issues.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Paul Olaru <paul.olaru@oss.nxp.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/dmi-quirks.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/soundwire/dmi-quirks.c b/drivers/soundwire/dmi-quirks.c
index 5db0a2443a1d..1ac16687e315 100644
--- a/drivers/soundwire/dmi-quirks.c
+++ b/drivers/soundwire/dmi-quirks.c
@@ -22,12 +22,12 @@ struct adr_remap {
  */
 static const struct adr_remap hp_spectre_360[] = {
 	{
-		0x000010025D070100,
-		0x000020025D071100
+		0x000010025D070100ull,
+		0x000020025D071100ull
 	},
 	{
-		0x000110025d070100,
-		0x000120025D130800
+		0x000110025d070100ull,
+		0x000120025D130800ull
 	},
 	{}
 };
@@ -39,18 +39,18 @@ static const struct adr_remap hp_spectre_360[] = {
 static const struct adr_remap dell_sku_0A3E[] = {
 	/* rt715 on link0 */
 	{
-		0x00020025d071100,
-		0x00021025d071500
+		0x00020025d071100ull,
+		0x00021025d071500ull
 	},
 	/* rt711 on link1 */
 	{
-		0x000120025d130800,
-		0x000120025d071100,
+		0x000120025d130800ull,
+		0x000120025d071100ull,
 	},
 	/* rt1308 on link2 */
 	{
-		0x000220025d071500,
-		0x000220025d130800
+		0x000220025d071500ull,
+		0x000220025d130800ull
 	},
 	{}
 };
-- 
2.17.1

