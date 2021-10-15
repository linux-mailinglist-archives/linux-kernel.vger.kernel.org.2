Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8338142F3AF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 15:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240078AbhJONjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 09:39:24 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:61208 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239988AbhJONii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:38:38 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19FCfErP009690;
        Fri, 15 Oct 2021 08:36:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=Lqn+dMnPf/Auw1mZimgpK3xzRBk2TMw3cJpKbswty5w=;
 b=O/qRXigP1YoegWsNfmLajCpD79sIJ3lQ6TpVQJlH27O+BCPxRrkFci/SWCdZTHGt+9H3
 ZQHh+wUIw4Fj56FqzRP0ECCKV1xCGLtyuxE3/VmYvxWeoU0JUSRK7N76iCY0O2MezvVY
 QMFqq03yfPeivEwk8LLHmeQggCQUlVGk0gIX6NMQ1b5mKUaOsuE4MN2cVj8fuA6TZcrx
 q85wN+jShz+elVnxasT4VsGOHAHYYvpMBl9IT7Aqy0u2kvZ7Ddz1N9Z5EwHyBv1sPL1U
 ycnlTV3QANPzWcKnPMWkO8sOhS1EKttmAfI8UVev9Gwvwsyygf4gK1SyDYwDsDbA7ZAD Pw== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3bq1gagp5w-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 15 Oct 2021 08:36:27 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 15 Oct
 2021 14:36:26 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Fri, 15 Oct 2021 14:36:26 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.254])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2EBB1B2F;
        Fri, 15 Oct 2021 13:36:26 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 16/16] ASoC: cs42l42: Always enable TS_PLUG and TS_UNPLUG interrupts
Date:   Fri, 15 Oct 2021 14:36:19 +0100
Message-ID: <20211015133619.4698-17-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211015133619.4698-1-rf@opensource.cirrus.com>
References: <20211015133619.4698-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 62cBwAWc3VX-bRCcDHrjfmn43wsI0vSR
X-Proofpoint-GUID: 62cBwAWc3VX-bRCcDHrjfmn43wsI0vSR
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The headset type detection must run to set the analogue switches
correctly for the attached headset type. Without this only headsets
with wiring matching the chip default will have a functioning mic.

commit c26a5289e865 ("ASoC: cs42l42: Add support for set_jack calls")
moved the interrupt unmasking to the component set_jack() callback.
But it's not mandatory for a machine driver to register a struct
snd_soc_jack handler. Without a registered handler the type detection
would not have run and so the mic would not work on some types of
headset.

This patch restores the unmasking of TS_PLUG and TS_UNPLUG interrupts
during probe.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 8f0c58097d64..d30bb9ad4191 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -524,12 +524,6 @@ static int cs42l42_set_jack(struct snd_soc_component *component, struct snd_soc_
 
 	cs42l42->jack = jk;
 
-	regmap_update_bits(cs42l42->regmap, CS42L42_TSRS_PLUG_INT_MASK,
-			   CS42L42_RS_PLUG_MASK | CS42L42_RS_UNPLUG_MASK |
-			   CS42L42_TS_PLUG_MASK | CS42L42_TS_UNPLUG_MASK,
-			   (1 << CS42L42_RS_PLUG_SHIFT) | (1 << CS42L42_RS_UNPLUG_SHIFT) |
-			   (0 << CS42L42_TS_PLUG_SHIFT) | (0 << CS42L42_TS_UNPLUG_SHIFT));
-
 	return 0;
 }
 
@@ -1798,8 +1792,8 @@ static void cs42l42_set_interrupt_masks(struct cs42l42_private *cs42l42)
 			CS42L42_TS_UNPLUG_MASK,
 			(1 << CS42L42_RS_PLUG_SHIFT) |
 			(1 << CS42L42_RS_UNPLUG_SHIFT) |
-			(1 << CS42L42_TS_PLUG_SHIFT) |
-			(1 << CS42L42_TS_UNPLUG_SHIFT));
+			(0 << CS42L42_TS_PLUG_SHIFT) |
+			(0 << CS42L42_TS_UNPLUG_SHIFT));
 }
 
 static void cs42l42_setup_hs_type_detect(struct cs42l42_private *cs42l42)
-- 
2.11.0

