Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1506345B90
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 11:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhCWKBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 06:01:03 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:48876 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229728AbhCWKAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 06:00:41 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12N9u49j032622;
        Tue, 23 Mar 2021 04:59:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=b6qErrcCVJKETaqJbCUYndAXMiSTFSJSDc+Bcs5NrEs=;
 b=QPV/0s5bNtqQBnZzoOzh6EffApUw7mrEzZgc1XOouRyHLwJOxxSs+odJ5gu+iCV0Si60
 O2hyrCkpv5ocH3nTijbP4c1GRktNWIQN98Zb0Qgr2KkYIXLII1Ibwy8eXymoYED6BWyt
 pRznAmc1DJQlKGKga5kQpX5HO3iSPMoz/S34iYktEQOdiwyKzDp8c92KzYKk3hrYzHLY
 xLI9yux3cA4cPE6oJW3g97890AbjC3MTrdOC5Rv0Vn6DYhKBugsYCH+7EpfT0u1uVVug
 AYdG8WvTqJ8aZFSaZa2k2v04yHNjmUoL0IzR4mJL+D360hwp/KiZa1/BB99RUkLdqr+a CQ== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 37def3bcqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Mar 2021 04:59:31 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 23 Mar
 2021 09:59:29 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Tue, 23 Mar 2021 09:59:29 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C634711CB;
        Tue, 23 Mar 2021 09:59:29 +0000 (UTC)
Date:   Tue, 23 Mar 2021 09:59:29 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>,
        <peter.ujfalusi@ti.com>, <gustavoars@kernel.org>,
        <pierre-louis.bossart@linux.intel.com>, <daniel.baluta@nxp.com>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: wm8960: Fix wrong bclk and lrclk with pll enabled
 for some chips
Message-ID: <20210323095929.GS106851@ediswmail.ad.cirrus.com>
References: <1616150926-22892-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1616150926-22892-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 suspectscore=0
 mlxscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=952
 bulkscore=0 phishscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103230072
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 06:48:46PM +0800, Shengjiu Wang wrote:
> The input MCLK is 12.288MHz, the desired output sysclk is 11.2896MHz
> and sample rate is 44100Hz, with the configuration pllprescale=2,
> postscale=sysclkdiv=1, some chip may have wrong bclk
> and lrclk output with pll enabled in master mode, but with the
> configuration pllprescale=1, postscale=2, the output clock is correct.
> 
> >From Datasheet, the PLL performs best when f2 is between
> 90MHz and 100MHz when the desired sysclk output is 11.2896MHz
> or 12.288MHz, so sysclkdiv = 2 (f2/8) is the best choice.
> 
> So search available sysclk_divs from 2 to 1 other than from 1 to 2.
> 
> Fixes: 84fdc00d519f ("ASoC: codec: wm9860: Refactor PLL out freq search")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
