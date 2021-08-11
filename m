Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16D13E9197
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhHKMhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:37:15 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:44956 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229994AbhHKMhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:37:04 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17B9h6Qh011884;
        Wed, 11 Aug 2021 07:36:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=ZOXDZCGvuM+znwar91xwifANfDlpyzTPesulw19NzrQ=;
 b=K+ZIk3wYVQll6258ckN08gslj9gA8qbYrwmKJRkW9F1OBlBW0R8/oxSlXrP0+Cz+RE1c
 J6Nt8Q5cFS4zHl4pQ24KecmCdaFfOpaOI0KbMAxq8xN4iuEvazVo9A1F8QMbODxJDY5u
 OfB1tDEWplBVgxn+YF7FrctuQ7gJP04YAaZ4TH8yn2nJ7zcPQAxuKA/xoNFV0vuwrHfC
 HnQ1o+f326K06LTxQhsQt1/EMoDitijkwk5EkSplZ3NnPf3pmMbJjeydn4tPHbCTromc
 aE0lIsJWyERtY9kBrw1YL59/iPivLPOXlxur0d+OoxyReTO8AFBr/tNu2xQHWLqVV2x8 wA== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3acc5ng6k4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 11 Aug 2021 07:36:29 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 11 Aug
 2021 13:21:25 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 11 Aug 2021 13:21:25 +0100
Received: from [10.0.2.15] (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.221])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 982BB2A9;
        Wed, 11 Aug 2021 12:21:25 +0000 (UTC)
Subject: Re: [PATCH 04/12] ASoC: cs42l42: Don't reconfigure the PLL while it
 is running
To:     Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
References: <20210810153759.24333-1-rf@opensource.cirrus.com>
 <20210810153759.24333-5-rf@opensource.cirrus.com>
 <20210810154959.GD4704@sirena.org.uk>
 <c194004a-2a22-5354-9042-3ce811236319@opensource.cirrus.com>
 <20210811115637.GA4167@sirena.org.uk>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <bae1afcb-d983-c17c-d932-3afac16df501@opensource.cirrus.com>
Date:   Wed, 11 Aug 2021 13:21:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210811115637.GA4167@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: eyeuLROsHdy1oEv1sjHIPd2rnFLwH3cI
X-Proofpoint-GUID: eyeuLROsHdy1oEv1sjHIPd2rnFLwH3cI
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxlogscore=979 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108110085
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/2021 12:56, Mark Brown wrote:
> On Tue, Aug 10, 2021 at 05:27:45PM +0100, Richard Fitzgerald wrote:
>> On 10/08/2021 16:49, Mark Brown wrote:
> 
>>> Shouldn't the PLL code be noticing problematic attempts to reconfigure
>>> the PLL while it's active rather than the individual callers?
> 
>> It's wrong for a hw_params() for one stream to try to configure the PLL
>> when the other stream has already called hw_params(), configured the PLL
>> and started it. E.g. if you started a PLAYBACK, configured and
>> started everything, then got another hw_params() for the CAPTURE.
> 
>> cs42l42_pll_config() could check whether it is already running and skip
>> configuration in that case, but that seems to me a rather opaque
>> implementation. In my opinion this doesn't really fall into the case of
>> ignoring-bad-stuff-to-be-helpful (like free() accepting a NULL).
> 
> This doesn't treat the situation as an error though, it just ignores it,
> and there's nothing to stop _pll_config() generating a warning if that
> makes sense.
> 

It isn't an error. hw_params() will be called for both substreams
(PLAYBACK and CAPTURE) and if one is already running we mustn't
reconfigure the things we already configured. The DAI is marked
symmetric so both substreams will always produce the same I2C BCLK.

As in:

hw_params() substream=PLAYBACK
     configure PLL
prepare() substream=PLAYBACK
     PLL is started
hw_params() substream=CAPTURE
     PLAYBACK substream already running so don't rewrite PLL registers

Some of the PLL configurations start with a "safe" configuration and
then switch over to the running configuration once the PLL is stable.
Calling pll_config() again would rewrite back to the startup config,
which would change the clock output.

It's ok if neither stream is started, since the PLL isn't started. This
is needed anyway because it is legal for hw_params() to be called
several times to change parameters without starting a stream.
