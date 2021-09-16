Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB9C40D761
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 12:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236403AbhIPKaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 06:30:15 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:45526 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233913AbhIPKaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 06:30:14 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18G8MpJn022854;
        Thu, 16 Sep 2021 05:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=C9A0iT3x1O9FcRBYE0k54iM+JulnJCyWxdI2m6U4loQ=;
 b=lcA7VzGV5JMrDRn4qYA6PHVCJDJpcC1E7uF1aBAy0ti1zbH0O28Wg9xnUXkTect+Kujy
 aNq9ZNKgXqi6d9jN6AV44rnjvdsg8lSZLEXn52k1svqUOuh3xIqYnkPoHAo6d7dFslPV
 Nxo9Ffn/MEBOd/xfXKVJemRdafLwL7dMe9U/vTLps8aR5m5AA3vUYG1nzVlgi/KIeKIp
 7dw/i3Mvm7rFkFyoDPvxYtcVsQLJJI3/b8rUAJy7KZQY1iykes5Tgqw0Gvhxm0M049FQ
 D/I2GpKmBT9jlh3qQOSiGuFL2eW02g8wwmk8Zzj6JU5vGqQdrRSiSEU7NipS6nbabeGM 1g== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3b42c3g3vy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 16 Sep 2021 05:28:06 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 16 Sep
 2021 11:28:04 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Thu, 16 Sep 2021 11:28:04 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.230])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4BB3EB15;
        Thu, 16 Sep 2021 10:28:04 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/1] ASoC: cs42l42: Implement Manual Type detection as fallback
Date:   Thu, 16 Sep 2021 11:27:49 +0100
Message-ID: <20210916102750.9212-1-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 9dcbysC11U7uOwQSL2L90KysPekjKq3m
X-Proofpoint-ORIG-GUID: 9dcbysC11U7uOwQSL2L90KysPekjKq3m
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some headsets CS42L42 autodetect mode is not working correctly. 
They will be detected as unknown types or as headphones. According 
to the CS42L42 datasheet, if the headset autodetect failed,
then the driver should switch to manual mode and perform a manual steps sequence.
These steps were missing in the current driver code. This patch will add manual
mode fallback steps in case autodetect failed. The default behavior is not affected,
manual mode runs only when autodetect failed.

Tested for regression with autodetect with all known headsets - no regression.
Tested with all headsets customers reported as false detected:
Gumdrop DropTech B1 - detected as headset OK
HUAWEI AM115 - detected as headset OK
UGREEN EP103 - detected as headset OK
HONOR AM116 - detected as headset OK


Stefan Binding (1):
  ASoC: cs42l42: Implement Manual Type detection as fallback

 sound/soc/codecs/cs42l42.c | 104 ++++++++++++++++++++++++++++++++-----
 sound/soc/codecs/cs42l42.h |  54 +++++++++++++++++++
 2 files changed, 146 insertions(+), 12 deletions(-)

-- 
2.25.1

