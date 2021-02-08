Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9632313DC5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbhBHSlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:41:05 -0500
Received: from mga01.intel.com ([192.55.52.88]:3798 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233513AbhBHQkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 11:40:06 -0500
IronPort-SDR: izjxfgTMlw+655kGNgrNFkcfaybfAxKsMRFLuEzsp573+IGN+kUjMRDMtZOFnP2U2c8grHutse
 7r8olv6hXP4g==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="200801435"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="200801435"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 08:38:19 -0800
IronPort-SDR: D9EfWtRan1jmZTToggEjetd8rEb9BJbuSSQbU/lDQJ+yj0JutuBTxdWy9cAsIPXsTQYxtwHYEs
 l+fwKAUPhuYw==
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="377835358"
Received: from rahaness-mobl.amr.corp.intel.com (HELO [10.212.141.76]) ([10.212.141.76])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 08:38:17 -0800
Subject: Re: [PATCH] ASoC: soc-pcm: change error message to debug message
To:     Shengjiu Wang <shengjiu.wang@nxp.com>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <1612771965-5776-1-git-send-email-shengjiu.wang@nxp.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <b7f5442d-ad21-eb8a-7d90-7a8207320541@linux.intel.com>
Date:   Mon, 8 Feb 2021 09:06:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1612771965-5776-1-git-send-email-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/8/21 2:12 AM, Shengjiu Wang wrote:
> This log message should be a debug message, because it
> doesn't return directly but continue next loop.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>   sound/soc/soc-pcm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 605acec48971..cd9e919d7b99 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -1344,8 +1344,8 @@ static int dpcm_add_paths(struct snd_soc_pcm_runtime *fe, int stream,
>   		/* is there a valid BE rtd for this widget */
>   		be = dpcm_get_be(card, widget, stream);
>   		if (!be) {
> -			dev_err(fe->dev, "ASoC: no BE found for %s\n",
> -					widget->name);
> +			dev_dbg(fe->dev, "ASoC: no BE found for %s\n",
> +				widget->name);

Do we really want to do this?

This error message has historically been the means by which we detect 
that userspace didn't set the right mixers (e.g. on Intel Baytrail) or 
the topology was incorrect. And it's really an error in the sense that 
you will not get audio in or out.

If you demote this to dev_dbg, we'll have to ask every single user who 
reports 'sound is broken' to enable dynamic debug traces. I really don't 
see the benefit, this is a clear case of 'fail big and fail early', 
partly concealing the problem doesn't make it go away but harder to 
diagnose.
