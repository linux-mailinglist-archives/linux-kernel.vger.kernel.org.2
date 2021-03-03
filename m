Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB26F32C13D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1838353AbhCCTAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 14:00:20 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:14454 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1579339AbhCCSbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 13:31:05 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 123IMZ54023873;
        Wed, 3 Mar 2021 12:30:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=qdFJpxie6ydQ1E4+uyPei8YTx0pOxzzOUZCoLJBVIvw=;
 b=OUz9B56GhQdK4F27kPD2Gcw4TXkuEDuwwAg486jm+e6sz0lKSfW+PTFtjpgqUKmlSncx
 JvjXdtH+nXPOmJD6oGU6f9Db9XUB0PY+EgRfTUpmgcsF5TLQUWf96othdsFhFC38NSyt
 Iw2Judv5pxDDaDuCnxdvhLaGCJMrFgQ7LGM4q67FAr0CBw8sKWhbVm1x6+0tXGl+qdXF
 cx4wJd5JiG2HtZnm1J7GpRixn+jQzOw1ez+vnS8mUT5JyHRbXgaPHLzwyUIxfT12INdr
 R9IEIy9ZtjnwAWAJ/mzwcSdWn8mJXT0ouuKPSEJ7UG7sI0dZu80xi2BNJOyc93Qay82X wg== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 36ykctnc8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 03 Mar 2021 12:30:01 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 3 Mar 2021
 18:29:59 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Wed, 3 Mar 2021 18:29:59 +0000
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.45])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4F83411D0;
        Wed,  3 Mar 2021 18:29:59 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] ALSA: hda/cirrus: Add support for CS8409 HDA bridge and CS42L42 companion codec.
Date:   Wed, 3 Mar 2021 18:29:55 +0000
Message-ID: <20210303182959.5322-1-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 clxscore=1011
 malwarescore=0 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 impostorscore=0 mlxlogscore=462 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103030129
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

