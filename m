Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47B832F156
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 18:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhCERfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 12:35:52 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:47670 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230266AbhCERff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 12:35:35 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 125HUg0g001824;
        Fri, 5 Mar 2021 11:34:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=nl/f7YsupROlT4gR/2BgaN1s/yaHZufWmFTh8kroQeM=;
 b=Hy9MJ+TP5iu8iqkvPhwgQ3d7CWwqxOB8gVLMdwN7xFr53bElHLLB1MD1qfwg/ce0DRss
 BWUqqw19LIemlqYybxZWgB3fGySCZRPGK3rrZt/XRLwd3fSoWLigyDxbNS3jmxj5MxHn
 nASMj4Fb6mvRMHLe9ZK4OuUu19BcokfZ0kJH7QLR8qZ9TooFxHa54NvJDDNjbSGNu/u3
 AdnbDEOmtr+/OdjuAlhQCAjzjIWQqv7Xvr27h3YRFiwfmAwyWp3IGW8rlhZmg/GH/1MZ
 tQjutR1RgYbegaURgr7bdeOJ8Kzr3sFaO67MNYSDVYsrHWMkTAnAZYeYfwNBL29yrPOY aA== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 36ykctraxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 05 Mar 2021 11:34:46 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 5 Mar 2021
 17:34:45 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Fri, 5 Mar 2021 17:34:45 +0000
Received: from mail1.cirrus.com (unknown [198.61.64.35])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B380111CB;
        Fri,  5 Mar 2021 17:34:44 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v2 00/15] Report jack and button detection + Capture Support
Date:   Fri, 5 Mar 2021 17:34:27 +0000
Message-ID: <20210305173442.195740-1-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 clxscore=1011
 malwarescore=0 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 impostorscore=0 mlxlogscore=971 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103050090
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Here is a patch series for reporting to user space jack and button events and
add the support for Capture. With some cleanups and fixes along the way.

Regards,

Lucas Tanure

Lucas Tanure (12):
  ASoC: cs42l42: Fix Bitclock polarity inversion
  ASoC: cs42l42: Fix channel width support
  ASoC: cs42l42: Fix mixer volume control
  ASoC: cs42l42: Don't enable/disable regulator at Bias Level
  ASoC: cs42l42: Always wait at least 3ms after reset
  ASoC: cs42l42: Remove power if the driver is being removed
  ASoC: cs42l42: Disable regulators if probe fails
  ASoC: cs42l42: Provide finer control on playback path
  ASoC: cs42l42: Set clock source for both ways of stream
  ASoC: cs42l42: Add Capture Support
  ASoC: cs42l42: Report jack and button detection
  ASoC: cs42l42: Use bclk from hw_params if set_sysclk was not called

Richard Fitzgerald (3):
  ASoC: cs42l42: Wait at least 150us after writing SCLK_PRESENT
  ASoC: cs42l42: Only start PLL if it is needed
  ASoC: cs42l42: Wait for PLL to lock before switching to it

 sound/soc/codecs/cs42l42.c | 437 +++++++++++++++++++++----------------
 sound/soc/codecs/cs42l42.h |  41 +++-
 2 files changed, 282 insertions(+), 196 deletions(-)

-- 
2.30.1

