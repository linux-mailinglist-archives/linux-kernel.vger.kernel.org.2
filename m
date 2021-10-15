Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67CB542F3B8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 15:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239830AbhJONjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 09:39:40 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:5686 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239995AbhJONij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:38:39 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19F4c2sw023483;
        Fri, 15 Oct 2021 08:36:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=ISoBXTDGWYFFg3rMehWnfYSADfXB3Oa0F78uIjumd/w=;
 b=KT7xzPxAe4Jsi04ao8+PJgzRJS3knFSyr1wtwUNNucppUPj7q7U1udrK10r8ExciX551
 xmXhnvc+QPl3b6eIrvg3P6r1mK2dEFU57t7u71oZVw3R2Mg+MtF/1eYBa2VrGDWsi6kO
 uGuiCPSOocp6le4qCm76iuFyEuCKpR5va2GxqbenKH4NkjZaZgmN5onImnjWcRdTiE9R
 Boux6psqC1fHfWW9iTJN5ycQAZcUd0wHUGPwLhrwwAfZozzZlGqmq51rxq705Cu4DnAf
 kHUm1kHMk/USuppYVztNjX4Jmf/RVOXIV7PDA/PzGBz8ghgAyiqjNXtw/TGkcXRkXCPl 0A== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3bq1gagp5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 15 Oct 2021 08:36:24 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 15 Oct
 2021 14:36:21 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Fri, 15 Oct 2021 14:36:21 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.254])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 31815B2F;
        Fri, 15 Oct 2021 13:36:21 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 00/16] ASoC: cs42l42: Collection of bugfixes
Date:   Fri, 15 Oct 2021 14:36:03 +0100
Message-ID: <20211015133619.4698-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: NoIEhR9KQwTbt94aPT7dbqSXP3tlq3IR
X-Proofpoint-GUID: NoIEhR9KQwTbt94aPT7dbqSXP3tlq3IR
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set contains various bugfixes for the cs42l42 codec
driver.

Patches marked "Fixes" will apply cleanly to the patch that first
introduced the bug.

Patches NOT marked "Fixes" will not apply cleanly to the point
the bug was first introduced and/or the bug is not having
sufficient impact to risk churning older code versions.

Richard Fitzgerald (16):
  ASoC: cs42l42: Don't reconfigure the PLL while it is running
  ASoC: cs42l42: Always configure both ASP TX channels
  ASoC: cs42l42: Correct some register default values
  ASoC: cs42l42: Don't set defaults for volatile registers
  ASoC: cs42l42: Defer probe if request_threaded_irq() returns
    EPROBE_DEFER
  ASoC: cs42l42: Reset GPIO is mandatory
  ASoC: cs42l42: Correct power-up sequence to match datasheet
  ASoC: cs42l42: Reset and power-down on driver remove()
  ASoC: cs42l42: Prevent NULL pointer deref in interrupt handler
  ASoC: cs42l42: Don't claim to support 192k
  ASoC: cs42l42: Use PLL for SCLK > 12.288MHz
  ASoC: cs42l42: Allow time for HP/ADC to power-up after enable
  ASoC: cs42l42: Set correct SRC MCLK
  ASoC: cs42l42: Mark OSC_SWITCH_STATUS register volatile
  ASoC: cs42l42: Fix WARN in remove() if running without an interrupt
  ASoC: cs42l42: Always enable TS_PLUG and TS_UNPLUG interrupts

 sound/soc/codecs/cs42l42.c | 282 +++++++++++++++++++++++++--------------------
 sound/soc/codecs/cs42l42.h |   9 +-
 2 files changed, 160 insertions(+), 131 deletions(-)

-- 
2.11.0

