Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4EE330345
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 18:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbhCGRWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 12:22:34 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:55106 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232683AbhCGRWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 12:22:22 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 127HHE0O004818;
        Sun, 7 Mar 2021 11:21:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=0aiXOOSfs2+Dss6qwMhy0OdxOoHU59kxrpWFaQIHoUY=;
 b=RkgTxl9/9jBylzhl0ZDZKM2h6J/mgy4lri1k7iO0WEswzlqXsvsdalp8LO41f7ZdJNSi
 jQpV92xJ5WMBydr70K1ucEYkD4sJRAI7cuqibVX1ljfq1p4zbyR/gm9J1ZM3Q9ee8yFi
 5/F+wUOJ9txiGOsqtDKKR/fp31Wds+eVVRGgxoRAbPA63R7hJtvxPp8VDl9jkvL1EBvg
 ZUchxHC0y6J3rfuForsvpfl4TZRlNftTfePsiClL6YoWIzbjQHml4+ViundqL9UZhxrU
 yWx7e/OZ89qqFz4IqvPH9K8oRVcJpBZvvKDVhzQQ91hjTbr5ydkbtZtrt7UfM5uQCe6C qw== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 37471vs4ec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 07 Mar 2021 11:21:26 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sun, 7 Mar 2021
 17:21:25 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Sun, 7 Mar 2021 17:21:25 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 26EFD11D6;
        Sun,  7 Mar 2021 17:21:25 +0000 (UTC)
Date:   Sun, 7 Mar 2021 17:21:25 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>,
        <peter.ujfalusi@ti.com>, <gustavoars@kernel.org>,
        <pierre-louis.bossart@linux.intel.com>, <daniel.baluta@nxp.com>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ASoC: wm8960: Remove bitclk relax condition in
 wm8960_configure_sysclk
Message-ID: <20210307172125.GF106851@ediswmail.ad.cirrus.com>
References: <1614740862-30196-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1614740862-30196-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 adultscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103070095
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 11:07:42AM +0800, Shengjiu Wang wrote:
> The call sequence in wm8960_configure_clocking is
> 
>    ret = wm8960_configure_sysclk();
>    if (ret >= 0)
>         goto configure_clock;
> 
>    ....
> 
>    ret = wm8960_configure_pll();
> 
> configure_clock:
>    ...
> 
> wm8960_configure_sysclk is called before wm8960_configure_pll, as
> there is bitclk relax on both functions, so wm8960_configure_sysclk
> always return success, then wm8960_configure_pll() never be called.
> 
> With this case:
> aplay -Dhw:0,0 -d 5 -r 48000 -f S24_LE -c 2 audio48k24b2c.wav
> the required bitclk is 48000 * 24 * 2 = 2304000, bitclk got from
> wm8960_configure_sysclk is 3072000, but if go to wm8960_configure_pll.
> it can get correct bitclk 2304000.
> 
> So bitclk relax condition should be removed in wm8960_configure_sysclk,
> then wm8960_configure_pll can be called, and there is also bitclk relax
> function in wm8960_configure_pll.
> 
> Fixes: 3c01b9ee2ab9 ("ASoC: codec: wm8960: Relax bit clock computation")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
