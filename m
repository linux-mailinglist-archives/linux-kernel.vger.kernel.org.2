Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6FA45DF54
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 18:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242135AbhKYRHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 12:07:43 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:60740 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S242087AbhKYRFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 12:05:42 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1APDwa56011922;
        Thu, 25 Nov 2021 11:02:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=fUfqRxiYoRbxdy1ZSEccjSxBRfTJK48M8Na1ieirrOI=;
 b=WuNTzhmVFPJLsxBdvwfPc7dNsg7RAGTBPmTnsEOoR5va3MbI9L+nxKLx0l8T3pprJCs1
 pZjfihzItOrhrHWIK9q0tCRxwxl8akq9bG3T8kRnmjpCiN2FWjpfmaN8UE30wm65KBcL
 Ztm+tIYR8tpsxzbe5QlwnybQ9SlWS1/FinleT2hl0yp63z73xNAy+2AN9FNyUWRxT1gt
 /35PQ/wiHSyz1JAVlPy16wcV8e4Nlu11wKhekUKKSoKZoMwO7g9vTTHveJWbMH15vNx1
 /ainImGUhbVq5q8N9+HKX+SAN/3CsNojQKfg/SL0lSLJfdhD9YPk9GVg8ZzLRFFrfrj3 gA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3chds7hykr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 25 Nov 2021 11:02:08 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 25 Nov
 2021 17:02:06 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 25 Nov 2021 17:02:06 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4F127477;
        Thu, 25 Nov 2021 17:02:05 +0000 (UTC)
Date:   Thu, 25 Nov 2021 17:02:05 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: cs35l41: Fix link problem
Message-ID: <20211125170205.GI18506@ediswmail.ad.cirrus.com>
References: <20211125143501.7720-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211125143501.7720-1-tanureal@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: Wanejz1T9KWz8nrSOxWt-KMBgAk10tNK
X-Proofpoint-ORIG-GUID: Wanejz1T9KWz8nrSOxWt-KMBgAk10tNK
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 02:35:01PM +0000, Lucas Tanure wrote:
> Can't link I2C and SPI to the same binary, better
> to move CS35L41 to 3 modules approach.
> And instead of exposing cs35l41_reg, volatile_reg,
> readable_reg and precious_reg arrays, move
> cs35l41_regmap_i2c/spi to new module and expose it.
> 
> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> ---

Thanks for picking this up looks good to me.

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
