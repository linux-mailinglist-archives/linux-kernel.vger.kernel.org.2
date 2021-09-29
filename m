Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4BD41C858
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 17:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345234AbhI2P3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 11:29:12 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:61726 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345157AbhI2P3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 11:29:11 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18T5AOjm028432;
        Wed, 29 Sep 2021 10:27:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 references : in-reply-to : subject : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=lufwfwvERELgO9NEGU6Lgf7W4wEUPOq32o36cIe4gcY=;
 b=UmMVhMfK+s+JPZQeYlgZAta/LvCs66h/oQDiYP/LmEDlEDWwhw+1Byw2Klmiy5vlfWRJ
 Q1drE8P+KZzS+mu8s994jCztAZ+7tjW1m98uW36i1rVYOUfP9KZVAkfLmemr0qwa8cZv
 DSroPcJ6QGuhOXa/2Ft64IaTRsCYDeLKCaSF1KvH8kh2RgURVqOVWebqODNGd7X7ETuQ
 nJ8HfVbSeMWot4EzFLpdFHQbIBWIk/RR4m0am905PY1Es+gUxxQtPan7V6n49aPnaAjw
 N3H52kx0JjmfokUBTaBTE3qWHFde3SsOFklGtOZK2r14FoE0/nuTJX0+TuuqCvOrVDz7 rw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3bc62dhg40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 29 Sep 2021 10:27:22 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 29 Sep
 2021 16:27:20 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 29 Sep 2021 16:27:20 +0100
Received: from LONN13613Z2 (unknown [198.90.238.180])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id BA7C3B13;
        Wed, 29 Sep 2021 15:27:19 +0000 (UTC)
From:   Simon Trimmer <simont@opensource.cirrus.com>
To:     'Mark Brown' <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        'kernel test robot' <lkp@intel.com>
References: <20210929145040.793252-1-simont@opensource.cirrus.com> <20210929145222.GR4199@sirena.org.uk>
In-Reply-To: <20210929145222.GR4199@sirena.org.uk>
Subject: RE: [PATCH] ASoC: wm_adsp: Fix compilation when debugfs is disabled
Date:   Wed, 29 Sep 2021 16:27:19 +0100
Message-ID: <003301d7b546$7e33c860$7a9b5920$@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGXccUOEHhpH88acPEvIClxpmzepAEhxdJIrDKTD1A=
Content-Language: en-us
X-Proofpoint-GUID: 8gEi_8JgVpX4abUr5fYqsVxHug7M5HkR
X-Proofpoint-ORIG-GUID: 8gEi_8JgVpX4abUr5fYqsVxHug7M5HkR
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wednesday, September 29, 2021 3:52 PM, Mark Brown wrote:
> The more common pattern is to declare a static inline stub function
> instead of the prototype if debugfs is disabled.

Hi Mark,
Yes there is one for the cs_dsp_init_debugfs function though the compilation
failure the bot
detected is with the parameter dereferencing the disappearing
snd_soc_component member.

I could make a utility inline for use in this function that would do the
dereference or return NULL
based on the state of the config option if you think that would be neater?
(For the expense of a
new function it would separate the call of the stub from the conditional
access of the member
based on IS_ENABLED)

Thanks,
Simon

