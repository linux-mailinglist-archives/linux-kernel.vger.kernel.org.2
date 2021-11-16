Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFFA453772
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 17:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbhKPQcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 11:32:15 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:45856 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231448AbhKPQcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 11:32:14 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AG4SSx1022254;
        Tue, 16 Nov 2021 10:29:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=hCa5aNmSupBd70sCNM3jwyNpevNiQT5zW8SgZNKS7Ac=;
 b=Ndmm5Ycz9QQ44Y5ueNNSycXvujsQ41s5NP0NY4qynHZVldZ9znRdVPpqq9ZHVAMZbP2i
 h9GZu0w68YUyEBT/4nvrdm5NkN0H8B67upTx28BnNKAR8r+Dafg22EDjHYOyAtks6y4y
 aKnL89W5Z7vBw+AO8xfjJOY2OW/JWMyJx/3KKXRxwY77H3FNE7eFvqh6NbG/pCvorNFi
 21ME7NHMYg9Xa7x7KrlUGlU1Lrlt1m6DNtKh0tkq4VcIfibp2rGAtCDXPwN7QkJQ3tXe
 TvDybrCwEo598BobzeEBH1kuIYZQCIb7WMb4kSFFWkP8R/32164ikb/jJD/SOPmZ/rDR tw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3cbdjgt3ej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 16 Nov 2021 10:29:13 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 16 Nov
 2021 16:29:11 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 16 Nov 2021 16:29:11 +0000
Received: from [10.0.2.15] (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.41])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1EB0411DB;
        Tue, 16 Nov 2021 16:29:11 +0000 (UTC)
Subject: Re: [PATCH 0/4] ASoC: cs42l42: Remove redundant code
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20211116162652.45225-1-rf@opensource.cirrus.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <3cd0991b-a396-e885-d324-808e5c5d76c3@opensource.cirrus.com>
Date:   Tue, 16 Nov 2021 16:29:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211116162652.45225-1-rf@opensource.cirrus.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: OTEESrYZwGo5on_RuiGEDqNY6OESvZI0
X-Proofpoint-GUID: OTEESrYZwGo5on_RuiGEDqNY6OESvZI0
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, ignore this chain. Some old patches have risen from the dead
and attached themselves to this.

Will re-send.

On 16/11/2021 16:26, Richard Fitzgerald wrote:
> - Remove field writes in regmap_update_bits() calls where the code
>    intends that the field value is not changed.
> 
> - Remove unnecessary complexity from reporting jack unplug event
> 
> - Remove a PLL config value member that was introduced in a bugfix
>    but made redundant by a later bugfix.
> 
> Richard Fitzgerald (4):
>    ASoC: cs42l42: Remove redundant writes to DETECT_MODE
>    ASoC: cs42l42: Remove redundant writes to RS_PLUG/RS_UNPLUG masks
>    ASoC: cs42l42: Simplify reporting of jack unplug
>    ASoC: cs42l42: Remove redundant pll_divout member
> 
>   sound/soc/codecs/cs42l42.c | 42 +++++++-----------------------------------
>   sound/soc/codecs/cs42l42.h |  1 -
>   2 files changed, 7 insertions(+), 36 deletions(-)
> 
