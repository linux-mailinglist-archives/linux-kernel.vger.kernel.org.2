Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD25309655
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 16:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhA3Pnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 10:43:47 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:25996 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230045AbhA3Pld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 10:41:33 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10UFcP5g019246;
        Sat, 30 Jan 2021 09:40:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=/lnEmValmQ7Y9KsRET+FL5rf0WEEAzclRUoqWcNcwAs=;
 b=ML+vAnMghRRPyPTuzLQn8Agh7DkJmjsaUfqbdNVt0u1LmQPS3Qss7cslGxEfUpwJAbuI
 AIbxrW8vOc3cTDSu8/RHtpDRTWXio9/eW27JVMEarVzF1d8ec09kAB6f3SAtNTejkwOh
 zX/EvpE0M70pqLAardP9ofehrINY/oWtztbupLGYUbtOyrNNXrO0JtvAYlnPriN2kk5W
 Vym5Occd993B/dYpZH3y3rHJw2L/ZS9LIHUB4QHRomtY2huBJ4oLAwLKLFbdEUjKNlGY
 J9+x5f2o3gFFf19m9topJifSC/2tamH3JfUM9zgRmN1GRcDIpKxrjQuHinNq7JFJGYNq FQ== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 36d4rtg6c4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 30 Jan 2021 09:40:37 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Sat, 30 Jan
 2021 15:40:35 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Sat, 30 Jan 2021 15:40:35 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 95EEC11CC;
        Sat, 30 Jan 2021 15:40:35 +0000 (UTC)
Date:   Sat, 30 Jan 2021 15:40:35 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Hans de Goede <hdegoede@redhat.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v4 13/13] ASoC: Intel: bytcr_wm5102: Add jack detect
 support
Message-ID: <20210130154035.GX106851@ediswmail.ad.cirrus.com>
References: <20210123121313.79530-1-hdegoede@redhat.com>
 <20210123121720.79863-1-hdegoede@redhat.com>
 <20210123121720.79863-4-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210123121720.79863-4-hdegoede@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101300086
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 23, 2021 at 01:17:20PM +0100, Hans de Goede wrote:
> Add jack detect support by creating a jack and calling
> snd_soc_component_set_jack to register the created jack
> with the codec.
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> +static struct snd_soc_jack_pin byt_wm5102_pins[] = {
> +	{
> +		.pin	= "Headphone",
> +		.mask	= SND_JACK_HEADPHONE,
> +	},
> +	{
> +		.pin	= "Headset Mic",
> +		.mask	= SND_JACK_MICROPHONE,
> +	},
> +};
> +

This patch looks fine to me, but I did have one small question.
What is the thinking behind punting this to the machine driver?

I guess you can not register it if there is no jack present
on the board, or if you have multiple jacks name them
meaningfully. Although I sort of feel like those applied to
the old extcon approach that just internally registered all
the interfaces.

But to be clear not asking for any changes just more about trying
to refine my understanding of things.

Thanks,
Charles
