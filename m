Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E6D31BD39
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 16:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhBOPmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 10:42:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34137 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230414AbhBOPaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 10:30:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613402916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qpNbCXa3LLeVYQ9DuTQANorJRafKek6tnQAqzgjmksA=;
        b=Hgs46Wqj16o5TICQ9IvqoQfPhidIwedAuwr3Lp9TpZl0hggSb1ukkhiDScSquW5d4Yhq/k
        FignDv6mzVfclRYydycHn7g1dAXv1fVG6t3QB0121/7/8jZdGosvbonDqRj2pbWgxNcC8q
        TCRI29N7KpmMFBhMJvyRbwpviKwCgrA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-gcWgVZBwNAGuxbLJOtGEhw-1; Mon, 15 Feb 2021 10:28:34 -0500
X-MC-Unique: gcWgVZBwNAGuxbLJOtGEhw-1
Received: by mail-qt1-f197.google.com with SMTP id k90so5463488qte.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 07:28:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=qpNbCXa3LLeVYQ9DuTQANorJRafKek6tnQAqzgjmksA=;
        b=Ng0x2Bevc53kGO1qMNKo+ei+AD7SouHNmDsWxbIaQ2oO91MwhFTWO5RExwB9sna/J3
         iBDuSCrJ0OWU2sWGfomSVqZqZC6vTiDkhsM6ZLKsDSqAUYzXSGG48Pj9jhJpyBJXdjpM
         kI19nres5JmTCS9ykULnyH4MykfMOVAz6xf9UsuVBSVQcL93tcTajHvn3opSwLDeqLlX
         lFYT/dXauDdfOUl6GDs4ob4sgizD9tTKn+Rh5SgPRcUfnEEHShz6vp+aM6+13s6pP864
         aB8zKVmK1+4Eltf7kGAZaatXDE7vR6fe2Nmdip7UipURquEnqGiCnDmgwzpSYUKMVNqE
         0O6w==
X-Gm-Message-State: AOAM5332BDtMLBbN96sD0YlHem7Nr8S8HD/emd4qaRSL8yh7d+T0+0wt
        Hc2mCCQDpJrjjH6JNqecRXBG48yobw4MIpP6BV0WsHET+XX9RmVC/l0AAz+2e4DfpDAyPrzivM9
        4TEY791JUx6nqnpwpPDzGgFEhvE/ysvG5Rz+bEHxd7VUYJl3ahUG4sIxnvLV62SEFqj5k6y4=
X-Received: by 2002:a37:6c02:: with SMTP id h2mr15747188qkc.488.1613402913819;
        Mon, 15 Feb 2021 07:28:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwPcqZGpt313S3UgA1ecM3+khrHLAae1n33Uut2tgZvJzHWeC4MDAcz0FTvSwcv/hNdjM+c0Q==
X-Received: by 2002:a37:6c02:: with SMTP id h2mr15747155qkc.488.1613402913508;
        Mon, 15 Feb 2021 07:28:33 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id r190sm12495588qka.54.2021.02.15.07.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Feb 2021 07:28:33 -0800 (PST)
Subject: Re: [PATCH] ASoC: Intel: Skylake: Fix missing check in
 skl_pcm_trigger
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20210215151356.15252-1-dinghao.liu@zju.edu.cn>
From:   Tom Rix <trix@redhat.com>
Message-ID: <e53684a9-afda-8c06-1b54-7327e95b0b01@redhat.com>
Date:   Mon, 15 Feb 2021 07:28:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210215151356.15252-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/15/21 7:13 AM, Dinghao Liu wrote:
> When cmd == SNDRV_PCM_TRIGGER_STOP, we should also check
> the return value of skl_decoupled_trigger() just like what
> we have done in case SNDRV_PCM_TRIGGER_PAUSE_RELEASE.
>
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  sound/soc/intel/skylake/skl-pcm.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
> index b1ca64d2f7ea..a5b1f333a500 100644
> --- a/sound/soc/intel/skylake/skl-pcm.c
> +++ b/sound/soc/intel/skylake/skl-pcm.c
> @@ -516,6 +516,9 @@ static int skl_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
>  			return ret;

Is there any additional error handling to be done for the

skl_stop_pipe that just happened ?

Tom

>  
>  		ret = skl_decoupled_trigger(substream, cmd);
> +		if (ret < 0)
> +			return ret;
> +
>  		if ((cmd == SNDRV_PCM_TRIGGER_SUSPEND) && !w->ignore_suspend) {
>  			/* save the dpib and lpib positions */
>  			stream->dpib = readl(bus->remap_addr +

