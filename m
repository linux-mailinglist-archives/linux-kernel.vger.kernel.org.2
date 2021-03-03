Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D22732C245
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580486AbhCCTfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 14:35:25 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:10104 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350975AbhCCTXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 14:23:14 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 123IrMkJ001579;
        Wed, 3 Mar 2021 12:53:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=qdFJpxie6ydQ1E4+uyPei8YTx0pOxzzOUZCoLJBVIvw=;
 b=innMdD6phvaq5Frmn9E49Ddas4stjFfjHt26opP/Gnth4zlETxdNlcSdsVHR6yEJvsIB
 kZkHTep3u4FwCd+QzW4hJzwgKgI497PwNjng8m4IeXVCJkDletXLnilywu/YToj5yvZ+
 QmOwVs9aJo7MsjkWNDkRtgLp89KHWnsQV16w8HMXyy0g0zhfvU9Wuj9SHQBjivQlZuOv
 9iekBHQPd1SpHD8ptYuR2N95Knt6STxI2W/y1P8wliRdCn86v642FQuUReHcL7OnKI+3
 /dg9fxciRie6gBRgZBjwAdwvT422CqReZY+SE6MHFL9oMoweO5BHRJ5ix/DMV349lEDd YA== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 36ykctnd7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 03 Mar 2021 12:53:51 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 3 Mar 2021
 18:53:50 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Wed, 3 Mar 2021 18:53:50 +0000
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.45])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id EFDD911D0;
        Wed,  3 Mar 2021 18:53:49 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] ALSA: hda/cirrus: Add support for CS8409 HDA bridge and CS42L42 companion codec.
Date:   Wed, 3 Mar 2021 18:53:45 +0000
Message-ID: <20210303185349.6227-1-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 impostorscore=0 mlxlogscore=467 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103030131
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
 sound/pci/hda/patch_cirrus.c    | 1033 +++++++++++++++++++++++++++++++
 3 files changed, 1035 insertions(+), 2 deletions(-)

-- 
2.25.1

