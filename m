Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18048353447
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 16:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236647AbhDCONz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 10:13:55 -0400
Received: from inva020.nxp.com ([92.121.34.13]:40944 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236380AbhDCONq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 10:13:46 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0ED881A0BBE;
        Sat,  3 Apr 2021 16:13:40 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A3ABA1A0FBB;
        Sat,  3 Apr 2021 16:13:36 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2A601402D9;
        Sat,  3 Apr 2021 16:13:32 +0200 (CEST)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH] ASoC: ak5558: Fix s/show/slow/ typo
Date:   Sat,  3 Apr 2021 21:59:25 +0800
Message-Id: <1617458365-23393-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/show/slow/

Fixes: 920884777480 ("ASoC: ak5558: Add support for AK5558 ADC driver")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/codecs/ak5558.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ak5558.c b/sound/soc/codecs/ak5558.c
index 3ac62a281807..8e4dca753f0b 100644
--- a/sound/soc/codecs/ak5558.c
+++ b/sound/soc/codecs/ak5558.c
@@ -75,8 +75,8 @@ static const struct soc_enum ak5552_mono_enum[] = {
 };
 
 static const char * const digfil_texts[] = {
-	"Sharp Roll-Off", "Show Roll-Off",
-	"Short Delay Sharp Roll-Off", "Short Delay Show Roll-Off",
+	"Sharp Roll-Off", "Slow Roll-Off",
+	"Short Delay Sharp Roll-Off", "Short Delay Slow Roll-Off",
 };
 
 static const struct soc_enum ak5558_adcset_enum[] = {
-- 
2.27.0

