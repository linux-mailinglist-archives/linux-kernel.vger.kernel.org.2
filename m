Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8364B4537CA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 17:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbhKPQmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 11:42:13 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:48298 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234398AbhKPQmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 11:42:09 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AG9thsn031145;
        Tue, 16 Nov 2021 10:39:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=LlLWUwoVTY7e/cT3Hvc6VuaHfWQ2FKZj8rcPcydDakw=;
 b=mLlflyU5Wj9ZQnNcAtrMLmXEVfq8hUJUzxw7uYcSZKO/7mfEbHPy7AMbsyDJyYOQ8S2f
 AAkE7oFrc+y13Tbuo6NZnsRUd4kEh7EgaUCUI0d0Hnznby80vi6/i8RHLAYnX02VL7Py
 sNFG95GFJFMD4cCz6Rmgewkc+2NEidhdKHTrYTGkNKvyDfwAsYF/3ieym4ftXnUBrzpG
 p91u7osbzt3zo3nXrvMH/QFW1FjB5IAtUE+GOQmpVwOAq4MiMWFBkq/+bP++Yx0xsVfE
 AkKMK7zHLhurnA/P2Eq2635cXw09MH13zUz7oGMGKtVUAUYBbkSescAG8v8zsJoIxO8U kA== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3cbjn01y8t-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 16 Nov 2021 10:39:07 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 16 Nov
 2021 16:39:05 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 16 Nov 2021 16:39:05 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.41])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D272315A4;
        Tue, 16 Nov 2021 16:39:04 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2 3/4] ASoC: cs42l42: Simplify reporting of jack unplug
Date:   Tue, 16 Nov 2021 16:39:00 +0000
Message-ID: <20211116163901.45390-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211116163901.45390-1-rf@opensource.cirrus.com>
References: <20211116163901.45390-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: FkYlUtjzA0bRxeMbEVqeIUnf4bR2U7rl
X-Proofpoint-ORIG-GUID: FkYlUtjzA0bRxeMbEVqeIUnf4bR2U7rl
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reporting a jack unplug there's no need to make the reported
flags conditional on which flags were reported during the plug
event. It's perfectly safe to report all flags and buttons as
not-present and let the higher code filter for changes.

There's also no need to make two separate snd_soc_jack_report()
calls for presence flags and button flags. It can all be done in
one report.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 3674f73301dc..8efcee3e60d3 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -1657,18 +1657,8 @@ static irqreturn_t cs42l42_irq_thread(int irq, void *data)
 				cs42l42->plug_state = CS42L42_TS_UNPLUG;
 				cs42l42_cancel_hs_type_detect(cs42l42);
 
-				switch (cs42l42->hs_type) {
-				case CS42L42_PLUG_CTIA:
-				case CS42L42_PLUG_OMTP:
-					snd_soc_jack_report(cs42l42->jack, 0, SND_JACK_HEADSET);
-					break;
-				case CS42L42_PLUG_HEADPHONE:
-					snd_soc_jack_report(cs42l42->jack, 0, SND_JACK_HEADPHONE);
-					break;
-				default:
-					break;
-				}
 				snd_soc_jack_report(cs42l42->jack, 0,
+						    SND_JACK_HEADSET |
 						    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 						    SND_JACK_BTN_2 | SND_JACK_BTN_3);
 
-- 
2.11.0

