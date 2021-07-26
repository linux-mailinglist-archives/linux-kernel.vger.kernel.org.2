Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1CE3D6638
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 20:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbhGZRVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 13:21:52 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:13741 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229658AbhGZRVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 13:21:50 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 16Q9XBFC001064;
        Mon, 26 Jul 2021 13:02:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=KFhMj4zInmP23rRrrQYzay5UeaPGV8+kCYH0f0Qe5bY=;
 b=edbAeJQMx+jQiZnOAOAy47jEZ21vkJAlQu9p4pZZrR0GWrcPFQJsxngxoyu8i2HCkMuK
 suKjsRV7wX8Igv2LA4HPhD75MiSVYd0W3NoEBeINGOqxuhmtyJt+3Qa78Aay4noomWz4
 c25qRu7LLzJHrNPv6LIUEk5oOsE/57gfeTX0V54hpKC33QSy6USgayaVjv+MhSpCFHCc
 YuBLwyEyHVGx7HzLoMrMc104Q9j+SyEIUt2Moeued/Ih9DW45oJnkEOfQx/c0gVM489h
 FtpsUFEQYb+GzdmYBjl0cfFwYBF52kDuFnmELdRxNQv5c7wvvPQ5tKdpeoXczCTmjH2a RQ== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3a1th2rgpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 26 Jul 2021 13:02:01 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 26 Jul
 2021 18:46:58 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Mon, 26 Jul 2021 18:46:58 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.32])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id CEE7A45D;
        Mon, 26 Jul 2021 17:46:57 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 00/27] ALSA: hda/cirrus: Split generic cirrus HDA codecs and CS8490 bridge into separate modules.
Date:   Mon, 26 Jul 2021 18:46:13 +0100
Message-ID: <20210726174640.6390-1-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 9QikoGclDdf5ouUEFOR8S_37rzz_57LQ
X-Proofpoint-GUID: 9QikoGclDdf5ouUEFOR8S_37rzz_57LQ
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 clxscore=1015
 suspectscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107260105
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

 sound/pci/hda/Kconfig               |   11 +
 sound/pci/hda/Makefile              |    2 +
 sound/pci/hda/patch_cirrus.c        | 1074 -----------------------
 sound/pci/hda/patch_cs8409-tables.c |  560 ++++++++++++
 sound/pci/hda/patch_cs8409.c        | 1234 +++++++++++++++++++++++++++
 sound/pci/hda/patch_cs8409.h        |  369 ++++++++
 6 files changed, 2176 insertions(+), 1074 deletions(-)
 create mode 100644 sound/pci/hda/patch_cs8409-tables.c
 create mode 100644 sound/pci/hda/patch_cs8409.c
 create mode 100644 sound/pci/hda/patch_cs8409.h

-- 
2.25.1

