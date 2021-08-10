Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5443E7C78
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 17:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243322AbhHJPjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 11:39:06 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:35196 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243169AbhHJPik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:38:40 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17A75fJN008310;
        Tue, 10 Aug 2021 10:38:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=D9Z+B+6Uu9IJFjEF/0fUoIcheo5kTw9lcFbulYgfeS4=;
 b=Qb/uD1otAloGEiu/ytm6kNF1GVc23JbcFH3AQxk79LF81KkFHATKuI8HVLjOVpLIfp0X
 v5nSSZHdVyD/2mJKcrXPQ1Q9DBADLHmIn78fTZnsXetW+jKIDWtCClxD7wX+Ey/P+pue
 6momBOWuYPwJxJkaBB3HqMJGEjWc7kapQprhYnD0WKyQYOyDSbZPrhjl8HASqJqUOFpO
 k/j0lUSYdWkZJAhAh7S004Nt31dwNMsL8rnShvAKnIKdN37dJboOqLoCDv6xU8OlGrp4
 bbdZLRbkmH2A+dSD61HP2I3EeScqU2F1XrbDBQFR74BCpM/OZ1LUrhNF1jsMgwlL2cjX gw== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3abmrkgkf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 10 Aug 2021 10:38:04 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 10 Aug
 2021 16:38:02 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Tue, 10 Aug 2021 16:38:02 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.221])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DE39A2A9;
        Tue, 10 Aug 2021 15:38:01 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 00/12] ASoC: cs42l42: Series of bugfixes and improvements
Date:   Tue, 10 Aug 2021 16:37:47 +0100
Message-ID: <20210810153759.24333-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 7G79ot0PRhJVHNdHnY4DEPtdj217-NYX
X-Proofpoint-ORIG-GUID: 7G79ot0PRhJVHNdHnY4DEPtdj217-NYX
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 mlxlogscore=349 mlxscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108100099
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various bugfixes and improvements to the cs42l42 codec driver.

Clocking bugfixes:
  - Remove any use of MCLK > 12.288 MHz because it isn't possible to switch
    between the low and high frequency ranges on-the-fly

  - Prevent the PLL configuration being written while the PLL is running
  - Correctly set the MCLK for the sample rate converters

ASP bugfixes:
  - Ensure the TX (capture) ASP is properly configured when recording
    mono audio.

Other bugfixes:
  - Prevent NULL pointer deref if there is an interrupt before soc
    component probe

Code cleanup:
  - Remove the unused runtime suspend/resume functions.
  - Remove some code made redundant by an earlier patch

Improvement:
  - Add ALSA control for HP path attenuation. Previously this was
    always set to -6dB with no way for the user to configure it.

  - Add ALSA control to disable the soft volume ramp at the start of
    audio.

Richard Fitzgerald (12):
  ASoC: cs42l42: Use PLL for SCLK > 12.188MHz
  ASoC: cs42l42: Don't claim to support 192k
  ASoC: cs42l42: Always configure both ASP TX channels
  ASoC: cs42l42: Don't reconfigure the PLL while it is running
  ASoC: cs42l42: Set correct SRC MCLK
  ASoC: cs42l42: Mark OSC_SWITCH_STATUS register volatile
  ASoC: cs42l42: Allow time for HP/ADC to power-up after enable
  ASoC: cs42l42: Prevent NULL pointer deref in interrupt handler
  ASoC: cs42l42: Remove runtime_suspend/runtime_resume callbacks
  ASoC: cs42l42: Remove redundant pll_divout member
  ASoC: cs42l42: Add HP Volume Scale control
  ASoC: cs42l42: Add control for audio slow-start switch

 sound/soc/codecs/cs42l42.c | 281 ++++++++++++++++++++++++---------------------
 sound/soc/codecs/cs42l42.h |   9 +-
 2 files changed, 156 insertions(+), 134 deletions(-)

-- 
2.11.0

