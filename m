Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E63232A7AC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576892AbhCBQ1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 11:27:39 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:34896 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1448096AbhCBNzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 08:55:20 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 122DGtvB027209;
        Tue, 2 Mar 2021 07:19:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=t2lwxX1hbQrJ3MKSvW2tSY+53xgKeDE6McOV5fU3ESU=;
 b=NGIJpzeAIxgLR2Cj+tOOqX9SOBQXThs4BVB6YvQjvva8vWnC2tooORQ9B7YXS1JBA3JP
 rwiloKHRhYzmmw7LEPpwt+4qbX5GJadPhTdYKaasqbo+w4p9F/mGoOrV2AvDWVnIUC1m
 VO2BVJKfX3aZe/mq+7XptR0ymXFEcL1VqoaNJigw95iAcU2BlFdiJJp3TVR16ekhAjHI
 kZ5nWRIdinEUIc0fqt+o1LvOXWrzjIkW3+fCBwQYVzLtE93cDd9Y4dMUdFnx0dm+9t62
 BBvNz3zSbYTIL0874dL7uqjLBUB+y3XWOSN/jrDkp4oFzzlxQ+OJSRV/huhI9bUGJqBc bQ== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 36ykctkc7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 02 Mar 2021 07:19:12 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 2 Mar 2021
 13:19:10 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Tue, 2 Mar 2021 13:19:10 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 824B011CB;
        Tue,  2 Mar 2021 13:19:04 +0000 (UTC)
Date:   Tue, 2 Mar 2021 13:19:04 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kstewart@linuxfoundation.org>,
        <allison@lohutok.net>, <tglx@linutronix.de>, <info@metux.net>,
        <ckeepax@opensource.wolfsonmicro.com>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: wm8960: Remove bitclk relax condition
Message-ID: <20210302131904.GC106851@ediswmail.ad.cirrus.com>
References: <1614683891-29255-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1614683891-29255-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 clxscore=1011
 malwarescore=0 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 impostorscore=0 mlxlogscore=934 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103020109
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 07:18:11PM +0800, Shengjiu Wang wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> Using a higher bitclk then expected doesn't always work.
> Here is an example:
> 
> aplay -Dhw:0,0 -d 5 -r 48000 -f S24_LE -c 2 audio48k24b2c.wav
> 
> In this case, the required bitclk is 48000 * 24 * 2 = 2304000
> but the closest bitclk that can be derived is 3072000. Since
> the clock is faster than expected, it will start to send bytes
> from the next channel so the sound will be corrupted.
> 
> Fixes: 82bab88910ee ("ASoC: codec: wm8960: Relax bit clock computation when using PLL")
> Fixes: 3c01b9ee2ab9 ("ASoC: codec: wm8960: Relax bit clock computation")
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---

I think this is probably going to need a much more involved fix.
The problem is that there are systems that depend on this
behaviour, so you can't just flat out revert it. And to be fair
the I2S specification says that bit clock can run at a higher
rate than required for the data, so the behaviour is correct as
well.

Probably the best solution here is to add additional contraints
from the machine driver on which rates/bit depths/channels are
supported.

Thanks,
Charles
