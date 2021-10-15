Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E76F942F3A7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 15:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239808AbhJONjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 09:39:17 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:21524 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239957AbhJONih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:38:37 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19F4c2t0023483;
        Fri, 15 Oct 2021 08:36:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=mYpyM5k5iTck7jZ9mZU5Jk8Bn9rAW8lHbmdBtXkem3Q=;
 b=Q8kJMzQFzuvw7zTSERpZSIOW0JPw3Uebt5+kI4US2yJdk23ShLT+BVS9tp5+EyWmFcps
 bZ/jI55LoChlZILqdfRzj0i37mpzC+58V77pZ3rAPk/wWqWqiR/RPv9bNNZWUCb+UMWA
 JM4eOXehJlpB8yZvvTeDhraj6a8IGeLl/r+/uaYA5Q7ihNf4xL842wWD4UXOSL48yiSP
 kZ74TiZ0Qx6uktM7+8e3AW0nf1Jc/3uZuUfawz/n32rsajRXhJ9ZIfOPzKRtVUrIZPoq
 4NB25mUwLzjsqT2W8oR3caYTc5y7zTq6W6J5X+OkNHLj9Fu80DLISo+z+we3C+724dWp Ww== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3bq1gagp5v-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 15 Oct 2021 08:36:25 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 15 Oct
 2021 14:36:23 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Fri, 15 Oct 2021 14:36:23 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.254])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2924A11D2;
        Fri, 15 Oct 2021 13:36:23 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 05/16] ASoC: cs42l42: Defer probe if request_threaded_irq() returns EPROBE_DEFER
Date:   Fri, 15 Oct 2021 14:36:08 +0100
Message-ID: <20211015133619.4698-6-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211015133619.4698-1-rf@opensource.cirrus.com>
References: <20211015133619.4698-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: bY2ytakBw6GEzcEmjJcndbZNwlZlg0xf
X-Proofpoint-GUID: bY2ytakBw6GEzcEmjJcndbZNwlZlg0xf
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can run without an interrupt so if devm_request_threaded_irq()
failed, the probe() just carried on. But if this was EPROBE_DEFER the
driver would continue without an interrupt instead of deferring to wait
for the interrupt to become available.

Fixes: 2c394ca79604 ("ASoC: Add support for CS42L42 codec")
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index c4efdc8f5d24..0ecf2129ea45 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -2053,8 +2053,9 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client,
 			NULL, cs42l42_irq_thread,
 			IRQF_ONESHOT | IRQF_TRIGGER_LOW,
 			"cs42l42", cs42l42);
-
-	if (ret != 0)
+	if (ret == -EPROBE_DEFER)
+		goto err_disable;
+	else if (ret != 0)
 		dev_err(&i2c_client->dev,
 			"Failed to request IRQ: %d\n", ret);
 
-- 
2.11.0

