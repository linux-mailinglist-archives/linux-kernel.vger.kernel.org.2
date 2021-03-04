Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7273A32D9F2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 20:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbhCDTDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 14:03:52 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:32014 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236269AbhCDTDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 14:03:42 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 124J2BKA016395;
        Thu, 4 Mar 2021 13:02:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=xaE1ZQV+p4NRdUL+jyUJ1sE0d64IgkitXnTTh93GjmE=;
 b=TayC2WEzVJUIM8rLT70CT67TEH8CzdAWMGsFiRuOs05bIzPWg8f6B8u31NQYmJ7zpG9T
 Tnbqe8VS+huMu3/4TE9h3vpfKWqHnjlYdQjZwGGe8ogIcB8XhOQ4AT0wzIB5OVzKlJId
 70NhPAvTsqypIvyIs9GGOtN9FHUZw/8jAxoqZGiWqopYJW12KSyrpy+w2fuqSh8PBZ0w
 mvwyxih9k36NTePFMC2zxmFdp3PpkD+8LAA3tvMuxZjWF0JQKljKsimHYSw7qC+dMFji
 1y/qW6A4skwwkEqLl6nfzbeZFbPDmZgeEJlK3MM6NjXujnRfjo2GJG/gV5VCzKd8PKRx Ug== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 36ymc6y4vx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 04 Mar 2021 13:02:44 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 4 Mar 2021
 19:02:42 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Thu, 4 Mar 2021 19:02:42 +0000
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.45])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C469011D0;
        Thu,  4 Mar 2021 19:02:41 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/4] ALSA: hda/cirrus: Add support for CS8409 HDA bridge and CS42L42 companion codec
Date:   Thu, 4 Mar 2021 19:02:37 +0000
Message-ID: <20210304190241.5363-1-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 clxscore=1015 suspectscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=604 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103040090
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dell's laptops Inspiron 3500, Inspiron 3501, Inspiron 3505 are using
Cirrus Logic CS8409 HDA bridge with CS42L42 companion codec.

The CS8409 is a multichannel HD audio routing controller.
CS8409 includes support for four channels of digital
microphone data and two bidirectional ASPs for up to 32
channels of TDM data or 4 channels of I2S data. The CS8409 is
intended to be used with a remote companion codec that implements
high performance analog functions in close physical
proximity to the end-equipment audio port or speaker driver.

The CS42L42 is a low-power audio codec with integrated MIPI
SoundWire interface or I2C/I2S/TDM interfaces designed
for portable applications. It provides a high-dynamic range,
stereo DAC for audio playback and a mono high-dynamic-range
ADC for audio capture

Changes since version 1:

ALSA: hda/cirrus: Increase AUTO_CFG_MAX_INS from 8 to 18
* No change

ALSA: hda/cirrus: Add support for CS8409 HDA bridge and CS42L42
companion codec.
* Removed redundant fields in fixup table
* Handle gpio via spec->gpio_dir, spec->gpio_data and spec->gpio_mask
* Moved cs8409_cs42l42_init() from patch 2, to handle resume correctly

ALSA: hda/cirrus: Add jack detect interrupt support from CS42L42
companion codec.
* Run scripts/checkpatch.pl, fixed new warnings

ALSA: hda/cirrus: Add Headphone and Headset MIC Volume Control
* Moved control values to cache to avoid i2c read at each time.

Stefan Binding (1):
  ALSA: hda/cirrus: Add Headphone and Headset MIC Volume Control

Vitaly Rodionov (3):
  ALSA: hda/cirrus: Increase AUTO_CFG_MAX_INS from 8 to 18
  ALSA: hda/cirrus: Add support for CS8409 HDA bridge and CS42L42
    companion codec.
  ALSA: hda/cirrus: Add jack detect interrupt support from CS42L42
    companion codec.

 sound/pci/hda/hda_auto_parser.h |    2 +-
 sound/pci/hda/hda_local.h       |    2 +-
 sound/pci/hda/patch_cirrus.c    | 1068 +++++++++++++++++++++++++++++++
 3 files changed, 1070 insertions(+), 2 deletions(-)

-- 
2.25.1

