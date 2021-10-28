Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E93143E31F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 16:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhJ1OLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 10:11:44 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:61550 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229887AbhJ1OLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 10:11:42 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19S847jo014865;
        Thu, 28 Oct 2021 09:09:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=4FX2fuwgRXUP3OXTschhGuPxmM50MdJ1IjGtnvPd+K8=;
 b=HCRdeLx0joiEgWt11vmYKkWrW5jbY/934JKZnnyOUlxRk3M2TO2YhEF+8vp0V4V3n5YB
 zFIt69YTS/iG0Ovcjl9XAuPSXUXJEBTbEkz3zEAiy6eW3qCFyKrHd8LAIim5p1pgrwbh
 vAYqcxiVf8Ia+5l5hDiFhgD69bhqlpFHDoGEybwaqZ5s87eQF1BUd3K5PklxNZtpcsn0
 QVYF1rw8Y4PxFtPIoJo5G6/RGt+RRFDk30ddnxbuFSj48uxRXYjGjd2XYwId0g7Ifq1g
 BRQJSZ1UuAjy/1C/UmcI3g8Z4l0dSeiSjxtaBSnMvdOnEXfxtATfyvxI7mNdpMTHhRbg Mg== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3by8p01bp1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 28 Oct 2021 09:09:09 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 28 Oct
 2021 15:09:07 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Thu, 28 Oct 2021 15:09:07 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.32])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2A7A311DC;
        Thu, 28 Oct 2021 14:09:07 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 1/3] ASoC: dt-bindings: cs42l42: Correct description of ts-inv
Date:   Thu, 28 Oct 2021 15:09:00 +0100
Message-ID: <20211028140902.11786-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211028140902.11786-1-rf@opensource.cirrus.com>
References: <20211028140902.11786-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: NxXuASVleh6ICgOHS2HgSM__x5eyEYpC
X-Proofpoint-ORIG-GUID: NxXuASVleh6ICgOHS2HgSM__x5eyEYpC
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This swaps the descriptions of the 0 and 1 values to match
what the driver actually does with this property.

The background here is somewhat confusing. The codec has two
invert bits for the tip sense. The DT property should have been
for the TIP_SENSE_INV bit, which is the one that controls the
detect block. Due to some misunderstanding of the hardware the
driver actually implemented setting of the TS_INV bit, which is
only for swapping the sense of the interrupt bits. The description
was taken from the datasheet and refers to TIP_SENSE_INV but
unfortunately TS_INV has a different purpose and the net effect
of changing it is the reverse of what was intended (this is not
clearly described in the datasheet). So the ts-inv settings have
always done the exact opposite of what the description said.

Given the age of the driver, it's too late now to swap the meanings
of the values, so the description is changed to match the behaviour.
They have been annotated with the terminology used in the datasheet
to avoid the confusion of which one corresponds to what the datasheet
calls "inverted tip sense".

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: da16c5579353 ("ASoC: cs42l42: Add devicetree bindings for CS42L42")
---
 Documentation/devicetree/bindings/sound/cs42l42.txt | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/cs42l42.txt b/Documentation/devicetree/bindings/sound/cs42l42.txt
index 5d416fdaf023..3b7705623980 100644
--- a/Documentation/devicetree/bindings/sound/cs42l42.txt
+++ b/Documentation/devicetree/bindings/sound/cs42l42.txt
@@ -19,13 +19,14 @@ Optional properties:
   (See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
   for further information relating to interrupt properties)
 
-  - cirrus,ts-inv : Boolean property. For jacks that invert the tip sense
-  polarity. Normal jacks will short tip sense pin to HS1 when headphones are
-  plugged in and leave tip sense floating when not plugged in. Inverting jacks
-  short tip sense when unplugged and float when plugged in.
+  - cirrus,ts-inv : Boolean property. Sets the behaviour of the jack plug
+  detect switch.
 
-  0 = (Default) Non-inverted
-  1 = Inverted
+  0 = (Default) Shorted to tip when unplugged, open when plugged.
+      This is "inverted tip sense (ITS)" in the datasheet.
+
+  1 = Open when unplugged, shorted to tip when plugged.
+      This is "normal tip sense (TS)" in the datasheet.
 
   - cirrus,ts-dbnc-rise : Debounce the rising edge of TIP_SENSE_PLUG. With no
   debounce, the tip sense pin might be noisy on a plug event.
-- 
2.11.0

