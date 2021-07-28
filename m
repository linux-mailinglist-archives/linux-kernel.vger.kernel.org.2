Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0BF3D8F63
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 15:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbhG1NqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 09:46:25 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:37748 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236499AbhG1Nov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 09:44:51 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 16S674iS029982;
        Wed, 28 Jul 2021 08:44:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=T3Lak+MgaABxZsDNmNNjgsuPrPESBXKLZ47st7mo+og=;
 b=YNFtcu6FhzddMEvws7+8WQGoZrWf3ohVUxlSI1+ttYYHun+E9ttcdlBhGM0PRJOthsDD
 Sv5Ol3fOqbf+NNNEYmNIZyb2vdyrf7SEHwvglWxYVVwvQjy/L6jWigliwG0N7uht8No5
 IkT2CAcJUeXJ+3K4xmuMZU/Z6aUkNUrZdjJ4YlXt4g1lHZT97DWNkco+vDayLiB7/+AK
 OJLZBhYm7JmIR1OmsxntnFLbR3dDCzXpnm845fBnz/NXMfsgspGOxS1RN2Kbs/YHMx60
 i+n50Wi+RvHf64M0dzYhDbWtnN2mbzcRy5M42BYjuuUmOZr25wNK/Fw6bu9NPn959LWK sw== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3a31m2res4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 28 Jul 2021 08:44:30 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 28 Jul
 2021 14:44:28 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Wed, 28 Jul 2021 14:44:28 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.32])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5A57D2BA;
        Wed, 28 Jul 2021 13:44:28 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 00/27] ALSA: hda/cirrus: Split generic cirrus HDA codecs and CS8490 bridge into separate modules.
Date:   Wed, 28 Jul 2021 14:43:41 +0100
Message-ID: <20210728134408.369396-1-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: VjCWOvvNz6j3N-EYeLZCDGK0VZx1RVOO
X-Proofpoint-ORIG-GUID: VjCWOvvNz6j3N-EYeLZCDGK0VZx1RVOO
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 impostorscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 clxscore=1015 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2107280077
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches splits generic cirrus HDA codecs and CS8490 bridge
into separate modules, adds support for multiple companion codecs connected to
CS8409, and also adds support for new DELL HW platform.

CS8409 part is not really a HDA codec, it is a HDA bridge where companion codecs
(up to 16) can be attached. With growing number of supported configurations and 
platforms, patch_cirrus is getting less and less transparent and maintainable.
So, the logical step is to separate generic Cirrus HDA codecs support 
and Cirrus HDA bridge support.

Lots of improvements to existing functionality, code clean-up and refactoring,
remove duplicated/redundant code, improve I2C functions etc.

Add support for new DELL HW platform with 2 CS42L42 codecs for front and rear jacks.

Lucas Tanure (12):
  ALSA: hda/cirrus: Move CS8409 HDA bridge to separate module
  ALSA: hda/cs8409: Move arrays of configuration to a new file
  ALSA: hda/cs8409: Disable unsolicited response for the first boot
  ALSA: hda/cs8409: Prevent I2C access during suspend time
  ALSA: hda/cs8409: Generalize volume controls
  ALSA: hda/cs8409: Dont disable I2C clock between consecutive accesses
  ALSA: hda/cs8409: Avoid setting the same I2C address for every access
  ALSA: hda/cs8409: Avoid re-setting the same page as the last access
  ALSA: hda/cs8409: Support i2c bulk read/write functions
  ALSA: hda/cs8409: Separate CS8409, CS42L42 and project functions
  ALSA: hda/cs8409: Move codec properties to its own struct
  ALSA: hda/cs8409: Add support for dolphin

Stefan Binding (15):
  ALSA: hda/cs8409: Use enums for register names and coefficients
  ALSA: hda/cs8409: Mask all CS42L42 interrupts on initialization
  ALSA: hda/cs8409: Reduce HS pops/clicks for Cyborg
  ALSA: hda/cs8409: Disable unnecessary Ring Sense for
    Cyborg/Warlock/Bullseye
  ALSA: hda/cs8409: Disable unsolicited responses during suspend
  ALSA: hda/cs8409: Mask CS42L42 wake events
  ALSA: hda/cs8409: Simplify CS42L42 jack detect.
  ALSA: hda/cs8409: Support multiple sub_codecs for Suspend/Resume/Unsol
    events
  ALSA: hda/cs8409: Add Support to disable jack type detection for
    CS42L42
  ALSA: hda/cs8409: Enable Full Scale Volume for Line Out Codec on
    Dolphin
  ALSA: hda/cs8409: Set fixed sample rate of 48kHz for CS42L42
  ALSA: hda/cs8409: Use timeout rather than retries for I2C transaction
    waits
  ALSA: hda/cs8409: Remove unnecessary delays
  ALSA: hda/cs8409: Follow correct CS42L42 power down sequence for
    suspend
  ALSA: hda/cs8409: Unmute/Mute codec when stream starts/stops

 sound/pci/hda/Kconfig               |   10 +
 sound/pci/hda/Makefile              |    2 +
 sound/pci/hda/patch_cirrus.c        | 1074 -----------------------
 sound/pci/hda/patch_cs8409-tables.c |  560 ++++++++++++
 sound/pci/hda/patch_cs8409.c        | 1245 +++++++++++++++++++++++++++
 sound/pci/hda/patch_cs8409.h        |  369 ++++++++
 6 files changed, 2186 insertions(+), 1074 deletions(-)
 create mode 100644 sound/pci/hda/patch_cs8409-tables.c
 create mode 100644 sound/pci/hda/patch_cs8409.c
 create mode 100644 sound/pci/hda/patch_cs8409.h

-- 
2.25.1

