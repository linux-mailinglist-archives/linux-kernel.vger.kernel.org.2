Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B4540B555
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 18:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhINQyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 12:54:14 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:55718 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230391AbhINQyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 12:54:07 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18E503l9016778;
        Tue, 14 Sep 2021 11:52:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=YkZHQj9k0tUUUprq2cdPeMN2UHIX44J1qBnShOtUP7U=;
 b=PpnMEdelvK7sUDdYt5wile+mmYipFsaYoHRLB0C95BMFNfgLmT3AlVPRnEv2kXsb5TTp
 Xl2VOqCzM1QYeYfbmiRFnhv8C2N2lOFqfuDKVK7SB70PnKgYlZ14FDVow9wHj8heMz5L
 9bOghnxirizbkOYsdtZEpsMIKuSdbAtQC+EBmmGb2z0EatB1pRlExbRsfsxUKTwbh28Z
 POzEdnWdM5YKirKUt+tGmKGx36VVzf/DwSB0V+5CKLORkBBMAPsVUktrUYDQCorU21VD
 P99qKHEEiu4vntmWiblgtCn5R1uPD0CDzw26LJ5iKXc7SoTLLlgLrHr1CZzuumvwQJ1y Gg== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3b2gkx8xd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 14 Sep 2021 11:52:35 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 14 Sep
 2021 17:52:33 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Tue, 14 Sep 2021 17:52:33 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.230])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D29BEB10;
        Tue, 14 Sep 2021 16:52:32 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] ASoC: cs42l42: Implement Manual Type detection as fallback
Date:   Tue, 14 Sep 2021 17:52:18 +0100
Message-ID: <20210914165220.752498-1-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 6YQcSsU3m-I6qvH5D-DuccFwtgawvVPB
X-Proofpoint-GUID: 6YQcSsU3m-I6qvH5D-DuccFwtgawvVPB
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

Also, fixes some errors reported by checkpatch.pl script.

Stefan Binding (1):
  ASoC: cs42l42: Implement Manual Type detection as fallback

Vitaly Rodionov (1):
  ASoC: cs42l42: Minor fix all errors reported by checkpatch.pl script

 sound/soc/codecs/cs42l42.c | 114 +++++++++++++++++++++++++++++++------
 sound/soc/codecs/cs42l42.h |  54 ++++++++++++++++++
 2 files changed, 151 insertions(+), 17 deletions(-)

-- 
2.25.1

