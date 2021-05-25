Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3460F38FD8C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbhEYJP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:15:28 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:23334 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232321AbhEYJP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:15:27 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14P9DIRL018137;
        Tue, 25 May 2021 04:13:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=x7SuZlu5pk3eR3kU8t+NDqj1QwECtA7y6bYhkywUnqM=;
 b=prtdyFD8ojHMtC71palUKJpk2HOlDjYQw4DzZ9ec3uB4tz/EaU8veaTMBfV7C2Goiq+O
 SZP7syQQdgBJ4r5SCOn2wfm9eXl5u6sCoIe6zuYdFfLW9Uw4B8BTOqEv7mwzhZx0m4Sq
 u3xpmd8Yru2iw1Y2T0oDCQu5MfdolHS7tUfSLEsfF4JlOowJylGqNLXUYEsGkL2HsP2t
 hjatAAQaDHAk8JOcxG7/kCAH0zXY5Nm6dlbZz0LQOmfbGjjIRYPm4BrSsJewt6kWflaw
 a4yvW30CqvCuwb1k5fGfaBw1dGit5AsHVQEulEhxq6rQ6t5kgiH+hn7xmWxO0IkJKCR2 9w== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 38r28v1kpn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 25 May 2021 04:13:18 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 25 May
 2021 10:13:17 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 25 May 2021 10:13:17 +0100
Received: from [10.0.2.15] (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 282B911D6;
        Tue, 25 May 2021 09:13:16 +0000 (UTC)
Subject: Re: [PATCH 2/4] ASoC: cs42l42: Add support for 2304000 Bit clock
To:     Lucas Tanure <tanureal@opensource.cirrus.com>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
References: <20210525090822.64577-1-tanureal@opensource.cirrus.com>
 <20210525090822.64577-2-tanureal@opensource.cirrus.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <3e4a6a5d-de2a-d98d-482d-fd124a24e2e0@opensource.cirrus.com>
Date:   Tue, 25 May 2021 10:13:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210525090822.64577-2-tanureal@opensource.cirrus.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 2CtUoPRFqPwQM5V1Bi_Kjn9yTce1g8H9
X-Proofpoint-GUID: 2CtUoPRFqPwQM5V1Bi_Kjn9yTce1g8H9
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105250062
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/2021 10:08, Lucas Tanure wrote:
> Add support for 24bits, 2 channels, 48k Sample rate bit clock
> 
> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> ---
>   sound/soc/codecs/cs42l42.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
> index 94788a55fa3b..07223b5fb2d6 100644
> --- a/sound/soc/codecs/cs42l42.c
> +++ b/sound/soc/codecs/cs42l42.c
> @@ -598,6 +598,7 @@ struct cs42l42_pll_params {
>    */
>   static const struct cs42l42_pll_params pll_ratio_table[] = {
>   	{ 1536000, 0, 1, 0x00, 0x7D, 0x000000, 0x03, 0x10, 12000000, 125, 2},
> +	{ 2304000, 0, 1, 0x00, 0x55, 0xC00000, 0x02, 0x10, 12288000,  85, 2},
>   	{ 2822400, 0, 1, 0x00, 0x40, 0x000000, 0x03, 0x10, 11289600, 128, 1},
>   	{ 3000000, 0, 1, 0x00, 0x40, 0x000000, 0x03, 0x10, 12000000, 128, 1},
>   	{ 3072000, 0, 1, 0x00, 0x3E, 0x800000, 0x03, 0x10, 12000000, 125, 1},
> 

Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>

