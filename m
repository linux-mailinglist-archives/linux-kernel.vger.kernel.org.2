Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A407C45375F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 17:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbhKPQaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 11:30:02 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:6672 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231160AbhKPQaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 11:30:00 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AG7FCkd005416;
        Tue, 16 Nov 2021 10:26:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=ODxpdqxltOMoYVFmvaxZez5QOWprLDG9j92jnhb+qXc=;
 b=MEK3zZWVax6o8sttcNnwHIW+/pS3QB3GJeX4AbtA6bp6FBGe1ocesL9NVrBmaCdzdNH/
 bcqeOWWB30nA7UNmbAX/mOqe91g2/JGn71umRCxb3ZlwXMiYmqlhD5TZsws/KfgYpnvA
 UPav/XPA6HTxIFEbxn3o+iKEI4WoTXaYlIovBATMR7M4wAFryKP4pvh5dUBwJJkjBW2u
 yo7+xR5RmoNf3+KizX1UmGzBrXbHlpFNaZckLdnF783gQjtqBC9quuxqs9KkQfmOS5z/
 EmNPsWE6uF3iIgHZA4+otUSs2stR88O8aJS2uZYJ74iAOY+nn0gdTCxX9jGmm0A2LttO 0A== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3cbdjgt3be-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 16 Nov 2021 10:26:57 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 16 Nov
 2021 16:26:56 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 16 Nov 2021 16:26:56 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.41])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4360B11DB;
        Tue, 16 Nov 2021 16:26:55 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 0/4] ASoC: cs42l42: Remove redundant code
Date:   Tue, 16 Nov 2021 16:26:44 +0000
Message-ID: <20211116162652.45225-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 4YKL-Z3b2k61w_ouTLLQ7mYiZSB_zG0V
X-Proofpoint-GUID: 4YKL-Z3b2k61w_ouTLLQ7mYiZSB_zG0V
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Remove field writes in regmap_update_bits() calls where the code
  intends that the field value is not changed.

- Remove unnecessary complexity from reporting jack unplug event

- Remove a PLL config value member that was introduced in a bugfix
  but made redundant by a later bugfix.

Richard Fitzgerald (4):
  ASoC: cs42l42: Remove redundant writes to DETECT_MODE
  ASoC: cs42l42: Remove redundant writes to RS_PLUG/RS_UNPLUG masks
  ASoC: cs42l42: Simplify reporting of jack unplug
  ASoC: cs42l42: Remove redundant pll_divout member

 sound/soc/codecs/cs42l42.c | 42 +++++++-----------------------------------
 sound/soc/codecs/cs42l42.h |  1 -
 2 files changed, 7 insertions(+), 36 deletions(-)

-- 
2.11.0

