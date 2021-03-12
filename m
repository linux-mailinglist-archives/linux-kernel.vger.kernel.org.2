Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC893396EF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbhCLSvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:51:03 -0500
Received: from www381.your-server.de ([78.46.137.84]:50988 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbhCLSuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:50:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=TdTtswT/PYcJEl/JzQ4ecMAuE2v89YlefBd6JtAA4+I=; b=KxVppLCrBWFGZEKJ5YFPr920pD
        05fVY7ucuEkqXCeKYR9rKIolOweN4OXJ0yPbxVdsOIAvC/zGrHzeLtKqUlWhwoX1SjzBHVi55aHfY
        lIRkePTw/HOQV3iy97ony7U7HJrYKu4gP+T7mFc771XTfL54S5q6tFmcX2sd6TpbZNDM8Zo5IA2I2
        45fmUdkxsHHmxOxeITCQ2dFH7PzuKkNYLTQ21+i+zk7mbBY9wm4yk7MchTWSlbsosDmattRckJV+2
        zn8L+qRSHPzwPk0pUt/fkCQHUACTdguvRQQ6FaTO5U0CI/7zdGHLhndkJXVTonsFxMTDTvtX2g2vB
        Pa6bkGmg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lKmrz-0001kK-OJ; Fri, 12 Mar 2021 19:50:43 +0100
Received: from [2001:a61:2aea:a901:9e5c:8eff:fe01:8578]
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lKmrz-000Phz-Hd; Fri, 12 Mar 2021 19:50:43 +0100
Subject: Re: [PATCH 02/23] ASoC: ad1836: remove useless return
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
 <20210312182246.5153-3-pierre-louis.bossart@linux.intel.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <477d649a-81bd-a858-a6be-0cabdb88163e@metafoo.de>
Date:   Fri, 12 Mar 2021 19:50:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210312182246.5153-3-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26106/Fri Mar 12 13:03:16 2021)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/21 7:22 PM, Pierre-Louis Bossart wrote:
> Cppcheck warning:
>
> sound/soc/codecs/ad1836.c:311:9: warning: Identical condition and return expression 'ret', return value is always 0 [identicalConditionAfterEarlyExit]
>   return ret;
>          ^
> sound/soc/codecs/ad1836.c:308:6: note: If condition 'ret' is true, the function will return/exit
>   if (ret)
>       ^
> sound/soc/codecs/ad1836.c:311:9: note: Returning identical expression 'ret'
>   return ret;
>          ^
>
> Likely copy/paste between adc and dac cases.
>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>   sound/soc/codecs/ad1836.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/sound/soc/codecs/ad1836.c b/sound/soc/codecs/ad1836.c
> index a46152560294..08a5651bed9f 100644
> --- a/sound/soc/codecs/ad1836.c
> +++ b/sound/soc/codecs/ad1836.c
> @@ -305,8 +305,6 @@ static int ad1836_probe(struct snd_soc_component *component)
>   		return ret;
>   
>   	ret = snd_soc_dapm_add_routes(dapm, ad183x_adc_routes, num_adcs);
> -	if (ret)
> -		return ret;
>   
>   	return ret;
>   }

We could even go one step further and do

return snd_soc_dapm_add_routes(dapm, ad183x_adc_routes, num_adcs);

But either is fine. Thanks for cleaning this up

