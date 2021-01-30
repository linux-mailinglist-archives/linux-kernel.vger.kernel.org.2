Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248D9309684
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 17:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbhA3QIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 11:08:44 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:36908 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231903AbhA3QDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 11:03:33 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10UFHhtL024362;
        Sat, 30 Jan 2021 09:25:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=wu2BmKAmJwuH5eUZiZFTsmcq0Qh2USc2IKxpS+55d3Q=;
 b=EiiRDOX530k6BHXWcBXOjmX5bHYfFf1Sdx4m2EGmgCVSQ37rLSlGujVAEaR/MnFjk9np
 i8EUVoQeTMsd/+pnwG0ZP1jYnaJT2V+QUwi8WglsaZaLxa3/A7dZh3NOwn87Rrvd2PE5
 dDzzRNBfbADP0GrkvkOJcpZC99WH2mBglu9p17ZqimT2OQkRdY0yVjlIEWPuw0LTksfb
 RCW7khwoZwFeDqEGR+zlNJqHAddQ560ne5dj8S39lAGB/VfI1hVP3YbynvH0QkKaE/Ii
 JSobgJYIcugxWdGHCZE3AtXuBip8KB0W9PhnIxdXVv8Vz4HGMeFfEs4pWq/GiBOAYxXl vA== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 36d4rtg63q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 30 Jan 2021 09:25:29 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Sat, 30 Jan
 2021 15:25:28 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Sat, 30 Jan 2021 15:25:28 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5D15245;
        Sat, 30 Jan 2021 15:25:28 +0000 (UTC)
Date:   Sat, 30 Jan 2021 15:25:28 +0000
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
Subject: Re: [PATCH v4 09/13] ASoC: arizona-jack: convert into a helper
 library for codec drivers
Message-ID: <20210130152528.GT106851@ediswmail.ad.cirrus.com>
References: <20210123121313.79530-1-hdegoede@redhat.com>
 <20210123121313.79530-10-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210123121313.79530-10-hdegoede@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=908 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101300085
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 23, 2021 at 01:13:09PM +0100, Hans de Goede wrote:
> Convert the arizona extcon driver into a helper library for direct use
> from the arizona codec-drivers, rather then being bound to a separate
> MFD cell.
> 
> Note the probe (and remove) sequence is split into 2 parts:
> 
> 1. The arizona_jack_codec_dev_probe() function inits a bunch of
> jack-detect specific variables in struct arizona_priv and tries to get
> a number of resources where getting them may fail with -EPROBE_DEFER.
> 
> 2. Then once the machine driver has create a snd_sock_jack through
> snd_soc_card_jack_new() it calls snd_soc_component_set_jack() on
> the codec component, which will call the new arizona_jack_set_jack(),
> which sets up jack-detection and requests the IRQs.
> 
> This split is necessary, because the IRQ handlers need access to the
> arizona->dapm pointer and the snd_sock_jack which are not available
> when the codec-driver's probe function runs.
> 
> Note this requires that machine-drivers for codecs which are converted
> to use the new helper functions from arizona-jack.c are modified to
> create a snd_soc_jack through snd_soc_card_jack_new() and register
> this jack with the codec through snd_soc_component_set_jack().
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
