Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956F442B9E0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 10:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238821AbhJMIJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 04:09:08 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:24802 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238743AbhJMIIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 04:08:09 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19D5M4xr003946;
        Wed, 13 Oct 2021 03:05:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=xN3HwVR8Olq4c8b80ksL+6F0RWwTIzqvH/ci+40/9ys=;
 b=qVlRbrN4ezddF/g1zdnAe2813XEyb02o8yc47aiOwvXm9fuSFUpldFxOrgnIRvho7mmX
 AsXyMzlcCBdK/2MQJNT+7QUeigFXV+Y8XIv8v8NfHJi5PhUNYhcwsJOh88jDF1CP4bDV
 OWzTtal8VNJfIumLEFXQ9+KPQpF/fuYtm5WUnqLYtj4rGo2CckH3VP1r4jsxVORqHXYQ
 bY1cGQRCVpZFV7RfbUSB6AwOKBoYANX58WK7fUt2oBjjVjHRYEXvfDgUay46Lm0tvtaD
 LquR9/UunkXphtLHJglDF2f8Z53b9PtXweXJXETrVU3HVSMDrfPPYwhyz++qxyY5B1vh EQ== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3bnkc08hm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 Oct 2021 03:05:46 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 13 Oct
 2021 09:05:45 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Wed, 13 Oct 2021 09:05:45 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E483EB15;
        Wed, 13 Oct 2021 08:05:44 +0000 (UTC)
Date:   Wed, 13 Oct 2021 08:05:44 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ASoC: wm8960: Fix clock configuration on slave mode
Message-ID: <20211013080544.GB28292@ediswmail.ad.cirrus.com>
References: <1634102224-3922-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1634102224-3922-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: NbTush4FL2ZubP2MgG4FZxPUgVnVB4Bx
X-Proofpoint-ORIG-GUID: NbTush4FL2ZubP2MgG4FZxPUgVnVB4Bx
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 01:17:04PM +0800, Shengjiu Wang wrote:
> There is a noise issue for 8kHz sample rate on slave mode.
> Compared with master mode, the difference is the DACDIV
> setting, after correcting the DACDIV, the noise is gone.
> 
> There is no noise issue for 48kHz sample rate, because
> the default value of DACDIV is correct for 48kHz.
> 
> So wm8960_configure_clocking() should be functional for
> ADC and DAC function even if it is slave mode.
> 
> In order to be compatible for old use case, just add
> condition for checking that sysclk is zero with
> slave mode.
> 
> Fixes: 0e50b51aa22f ("ASoC: wm8960: Let wm8960 driver configure its bit clock and frame clock")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
