Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A2441C730
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 16:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344655AbhI2Ote (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 10:49:34 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:42918 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1344650AbhI2Otd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 10:49:33 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18T9qXi0002957;
        Wed, 29 Sep 2021 09:47:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 references : in-reply-to : subject : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=CxUQIokPqP+S4DsPpXxO1OV616fdP6M9szOHlDqKOtc=;
 b=WGL0i6AJ3+YTYsWUAHpV57/hw5HGy1lw5S0FDeDHA3Cd2OJoo9e37SQLz6PtSSSK4fiG
 OY+pimiUxxNBScwOtTMi8kF7wAXwDP6DJirm2u0VdzZekAlkZPQMvEodVGetgryL9FE4
 r1+zoPb6uh+p9OVOqjlkQGZl3uudhPHJTr5CtqRIYeoW2910XWXXUeI96w/Ao59vysuw
 YmhPxpgx59gKAgf/v9yTa/5nxY5069Kc5I4yfTKsRBAscBFJGumFIuhenmmN+qMvjYxH
 LeXK2/dyTZoEXocWTpk4QAMzKXE1R0LI3A47nfVKbaDeDpeYnB+OzsawldU01WBWKZJM cQ== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3bc6be1fk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 29 Sep 2021 09:47:04 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 29 Sep
 2021 15:47:02 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 29 Sep 2021 15:47:02 +0100
Received: from LONN13613Z2 (unknown [198.90.238.180])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 63036B13;
        Wed, 29 Sep 2021 14:47:01 +0000 (UTC)
From:   Simon Trimmer <simont@opensource.cirrus.com>
To:     'Guo Zhengkui' <guozhengkui@vivo.com>,
        'Liam Girdwood' <lgirdwood@gmail.com>,
        'Mark Brown' <broonie@kernel.org>,
        'Jaroslav Kysela' <perex@perex.cz>,
        'Takashi Iwai' <tiwai@suse.com>,
        'Charles Keepax' <ckeepax@opensource.cirrus.com>,
        'Richard Fitzgerald' <rf@opensource.cirrus.com>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
CC:     <kernel@vivo.com>
References: <20210929123217.5240-1-guozhengkui@vivo.com>
In-Reply-To: <20210929123217.5240-1-guozhengkui@vivo.com>
Subject: RE: [PATCH] ASoC: wm_adsp: remove a repeated including
Date:   Wed, 29 Sep 2021 15:47:01 +0100
Message-ID: <001001d7b540$dd169ca0$9743d5e0$@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKSXDI3vuTgErK6XFa2Eat9tY11+apFyTPg
Content-Language: en-us
X-Proofpoint-ORIG-GUID: d4-kMTQG5hXM4qsnekmm7yNhRwHJqimO
X-Proofpoint-GUID: d4-kMTQG5hXM4qsnekmm7yNhRwHJqimO
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, September 29, 2021 1:32 PM, Guo Zhengkui wrote:
> Remove a repeated "#include <linux/firmware.h>" in line 32.
> 
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
> ---

Acked-by: Simon Trimmer <simont@opensource.cirrus.com>

Thanks,
Simon

