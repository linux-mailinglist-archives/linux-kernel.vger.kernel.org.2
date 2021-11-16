Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA0045375D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 17:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhKPQaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 11:30:01 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:60774 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231378AbhKPQaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 11:30:00 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AG7FCkf005416;
        Tue, 16 Nov 2021 10:26:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=4FX2fuwgRXUP3OXTschhGuPxmM50MdJ1IjGtnvPd+K8=;
 b=fsBJ/HwyMPzqafDd/XQJfQyv9UlDeV0osDbFWPp6i9KU+3os3MvkEvOirxc2fLT3vaaL
 QESaeUu/eTx0SN00zrNVTpmc+Igs1ZLlDyNKbmJQ/F1BrCS7zLhyifZxDZ3ucvhMKTFe
 D0wqY7FyMk0+PvfVC/WA3YCbVq+MRiWixhOw/DZksPOBIKrYh5qvg1eLyVIasTNYUTeC
 dNj74DtRCFhPhH6ehkI5NF/op6A/D2hyzGNisIH1XdPLBBdFN6hOQt5KCbaFqgaf9ovN
 WD2SFXdraZSLWPCy90Fj8AzkdAp2pyuoOZguoYeYTde4GNTJ8JQ/iQ9X24UdDJscQq0p ow== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3cbdjgt3be-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 16 Nov 2021 10:26:58 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 16 Nov
 2021 16:26:56 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 16 Nov 2021 16:26:56 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.41])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B874A15A5;
        Tue, 16 Nov 2021 16:26:56 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 1/3] ASoC: dt-bindings: cs42l42: Correct description of ts-inv
Date:   Tue, 16 Nov 2021 16:26:47 +0000
Message-ID: <20211116162652.45225-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211116162652.45225-1-rf@opensource.cirrus.com>
References: <20211116162652.45225-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: clVfZdCURPULwxFBwgCpwL-PeILC0Rjz
X-Proofpoint-GUID: clVfZdCURPULwxFBwgCpwL-PeILC0Rjz
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

