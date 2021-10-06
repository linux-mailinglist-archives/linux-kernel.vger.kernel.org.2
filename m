Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5711742412F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 17:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239230AbhJFPW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 11:22:59 -0400
Received: from smtprelay0054.hostedemail.com ([216.40.44.54]:44718 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238832AbhJFPW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 11:22:57 -0400
Received: from omf11.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id A7DD0837F253;
        Wed,  6 Oct 2021 15:21:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id 080E720A295;
        Wed,  6 Oct 2021 15:21:02 +0000 (UTC)
Message-ID: <4b81a10dca78e286a9f806464b97111b5a15a91e.camel@perches.com>
Subject: Re: [PATCH v1 2/4] ASoC: Intel: bytcr_rt5640: Use temporary
 variable for struct device
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Date:   Wed, 06 Oct 2021 08:21:01 -0700
In-Reply-To: <20211006150442.16503-2-andriy.shevchenko@linux.intel.com>
References: <20211006150442.16503-1-andriy.shevchenko@linux.intel.com>
         <20211006150442.16503-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.11
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 080E720A295
X-Stat-Signature: 8aekekj99zu1ctnfx1qokd454e7rys9e
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18qTXXPdHN1jxMBl/v3fsqtmjPbrTwJ6UI=
X-HE-Tag: 1633533662-251987
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-10-06 at 18:04 +0300, Andy Shevchenko wrote:
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

trivia:

Some will complain about a lack of commit message.

> diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
[]
> @@ -1536,7 +1536,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
>  		put_device(&adev->dev);
>  		byt_rt5640_dais[dai_index].codecs->name = byt_rt5640_codec_name;
>  	} else {
> -		dev_err(&pdev->dev, "Error cannot find '%s' dev\n", mach->id);
> +		dev_err(dev, "Error cannot find '%s' dev\n", mach->id);
>  		return -ENXIO;
>  	}

And code that does

	if (foo) {
		[code...]
	} else {
		log_msg();
		return -ERR;
	}

should generally have its test reversed and use an unindented block.

	if (!foo) {
		log_msg();
		return -ERR;
	}
	[code...];


