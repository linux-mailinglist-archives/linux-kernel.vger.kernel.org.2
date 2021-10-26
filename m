Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0A743B2C0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 14:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbhJZM75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 08:59:57 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:10678 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232718AbhJZM7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 08:59:55 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19Q8ssha024219;
        Tue, 26 Oct 2021 07:57:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=xUQK4rx84DDhMKa29vtKDzqYEvWyNPAtmVXrRmpJ0v8=;
 b=pVEv880FtofQKBb7Bqibuo+X6YIahUjMX6rfijnZOk6uhaOTqtWjMok2uxVJf05qY64A
 r9mQDK/M9XfrorIwwyp8HvKmMFrxvi8sGtMZGa+oRWgkN+ioj2Fhyd9HybOmYJlkYXIR
 YcSVPil+CB/mTClXcz24IfficlrTCKPss4p99T8Ksq8NVOvmJADKnryoTff8mR6bfHjx
 PLXOc9XniayHc4/soGGlZ24RqXyxcaDbiG4lxaHYf5Q3TQGuYqJTRqEI5OaZSjq+lfx8
 P2L+x2F93dgr9E36REBfA8zE3qpiw+lTCLmthzzpi7gGD+TxtdEQ9a6ulisTj3a80DrJ zA== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3bx4fx0rf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 26 Oct 2021 07:57:26 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 26 Oct
 2021 13:57:25 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Tue, 26 Oct 2021 13:57:25 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.32])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 665CE11DA;
        Tue, 26 Oct 2021 12:57:24 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 0/2] ASoC: cs42l42: Fixes to power-down
Date:   Tue, 26 Oct 2021 13:57:20 +0100
Message-ID: <20211026125722.10220-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: JcWvijM98kzowk_a4mDt8MYTb7Jb1p50
X-Proofpoint-ORIG-GUID: JcWvijM98kzowk_a4mDt8MYTb7Jb1p50
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver probe and remove were inconsistent in what they did to power-down
and neither did all steps. In addition to that, neither function
prevented the interrupt handler from running during and after power-down.

Richard Fitzgerald (2):
  ASoC: cs42l42: Reset and power-down on remove() and failed probe()
  ASoC: cs42l42: free_irq() before powering-down on probe() fail

 sound/soc/codecs/cs42l42.c | 43 +++++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

-- 
2.11.0

