Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDC940982E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344503AbhIMQCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:02:52 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:8352 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1343744AbhIMQCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:02:46 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18DAEA6M014550;
        Mon, 13 Sep 2021 11:01:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=kxwr+fQrkMMf3nLnZDBqxMSorZNZnlyvVvt6IleDk5M=;
 b=LlJM/JLIdInDxTP5XBtCbco5xiMepz7PSSmlx0XbGMtAFjg9lVYOY5r5ged4uEkrgJDz
 VNwjujb2t1qz5YsYLjFxDfp6nefkosY1+Mbc7nq0vUFSP0VuLpJX+IfZV5wxoFBzsXwR
 BYDT218rWB67MmyPwIATEgzk0gVwCHX/Bt1vRcehXQ3hDZVJuBcR/PC4FkRn/uJHoezQ
 sEs2x3Gj7Bb7DZ0M0C4kPVU+FotiT9OfZPI0ENnCHj/ZrmJu77oBnDqkJIMwV/5RZrQv
 feYJYpu9cVTq0pXmFTLCw/WOFu3EQoMQ3sRvdiy2okNJMA5nZ4YVkScTl4OM5UUmF9Yf XA== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3b1n5drxkd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 13 Sep 2021 11:01:19 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 13 Sep
 2021 17:01:17 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Mon, 13 Sep 2021 17:01:17 +0100
Received: from simont-vb.lan?044ad.cirrus.com (unknown [198.90.238.152])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3D0482A9;
        Mon, 13 Sep 2021 16:01:17 +0000 (UTC)
From:   Simon Trimmer <simont@opensource.cirrus.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Simon Trimmer <simont@opensource.cirrus.com>
Subject: [PATCH 00/16] add driver to support firmware loading on Cirrus Logic DSPs
Date:   Mon, 13 Sep 2021 17:00:41 +0100
Message-ID: <20210913160057.103842-1-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: cFiMMI10d2CKHvOl6ZcBIY-_fScsUAlG
X-Proofpoint-ORIG-GUID: cFiMMI10d2CKHvOl6ZcBIY-_fScsUAlG
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches gradually separates the ASoC specific wm_adsp
code from that required to manage firmware in Cirrus Logic DSPs.

The series starts with renaming, progresses to splitting the
functionality before finally moving the independent functionality into
drivers/firmware so that it can be used by both the existing ASoC
wm_adsp and new non-audio parts.

Charles Keepax (3):
  ASoC: wm_adsp: Move check for control existence
  ASoC: wm_adsp: Switch to using wm_coeff_read_ctrl for compressed
    buffers
  ASoC: wm_adsp: Move sys_config_size to wm_adsp

Simon Trimmer (13):
  ASoC: wm_adsp: Remove use of snd_ctl_elem_type_t
  ASoC: wm_adsp: Cancel ongoing work when removing controls
  ASoC: wm_adsp: Rename generic DSP support
  ASoC: wm_adsp: Introduce cs_dsp logging macros
  ASoC: wm_adsp: Separate some ASoC and generic functions
  ASoC: wm_adsp: Split DSP power operations into helper functions
  ASoC: wm_adsp: Separate generic cs_dsp_coeff_ctl handling
  ASoC: wm_adsp: Move check of dsp->running to better place
  ASoC: wm_adsp: Pass firmware names as parameters when starting DSP
    core
  ASoC: wm_adsp: move firmware loading to client
  ASoC: wm_adsp: Split out struct cs_dsp from struct wm_adsp
  ASoC: wm_adsp: Separate wm_adsp specifics in cs_dsp_client_ops
  firmware: cs_dsp: add driver to support firmware loading on Cirrus
    Logic DSPs

 MAINTAINERS                                   |   11 +
 drivers/firmware/Kconfig                      |    1 +
 drivers/firmware/Makefile                     |    1 +
 drivers/firmware/cirrus/Kconfig               |    5 +
 drivers/firmware/cirrus/Makefile              |    3 +
 drivers/firmware/cirrus/cs_dsp.c              | 3109 ++++++++++++++++
 include/linux/firmware/cirrus/cs_dsp.h        |  242 ++
 .../linux/firmware/cirrus}/wmfw.h             |    8 +-
 sound/soc/codecs/Kconfig                      |    1 +
 sound/soc/codecs/cs47l15.c                    |   22 +-
 sound/soc/codecs/cs47l24.c                    |   20 +-
 sound/soc/codecs/cs47l35.c                    |   24 +-
 sound/soc/codecs/cs47l85.c                    |   32 +-
 sound/soc/codecs/cs47l90.c                    |   34 +-
 sound/soc/codecs/cs47l92.c                    |   20 +-
 sound/soc/codecs/madera.c                     |   18 +-
 sound/soc/codecs/wm2200.c                     |   30 +-
 sound/soc/codecs/wm5102.c                     |   16 +-
 sound/soc/codecs/wm5110.c                     |   24 +-
 sound/soc/codecs/wm_adsp.c                    | 3188 ++---------------
 sound/soc/codecs/wm_adsp.h                    |  105 +-
 21 files changed, 3794 insertions(+), 3120 deletions(-)
 create mode 100644 drivers/firmware/cirrus/Kconfig
 create mode 100644 drivers/firmware/cirrus/Makefile
 create mode 100644 drivers/firmware/cirrus/cs_dsp.c
 create mode 100644 include/linux/firmware/cirrus/cs_dsp.h
 rename {sound/soc/codecs => include/linux/firmware/cirrus}/wmfw.h (91%)

-- 
2.33.0

