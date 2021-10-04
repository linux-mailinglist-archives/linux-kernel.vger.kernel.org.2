Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B16420A2B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 13:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbhJDLkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 07:40:25 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38164 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232193AbhJDLkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 07:40:24 -0400
X-UUID: 1a16d0b360ca4f439959f8290e5fee06-20211004
X-UUID: 1a16d0b360ca4f439959f8290e5fee06-20211004
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chien-yu.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 676627194; Mon, 04 Oct 2021 19:38:23 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 4 Oct 2021 19:38:22 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 4 Oct
 2021 19:38:22 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 4 Oct 2021 19:38:22 +0800
Message-ID: <a6336289dcf0009f2fc900c74f480b3c5fc0e8be.camel@mediatek.com>
Subject: Re: [PATCH] ASoc: fix ASoC driver to support ops to register
 get_time_info
From:   Chien-Yu Lin <Chien-Yu.Lin@mediatek.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <yichin.huang@mediatek.com>,
        <hungjung.hsu@mediatek.com>, <allen-hw.hsu@mediatek.com>
Date:   Mon, 4 Oct 2021 19:38:22 +0800
In-Reply-To: <20210820130210.3321-1-chien-yu.lin@mediatek.com>
References: <20210820130210.3321-1-chien-yu.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Sir,

Sorry for bothering you.

Does it have any status updated, please?

Thank you.

Best Regards,
Chien-Yu.Lin

On Fri, 2021-08-20 at 21:02 +0800, Chien-Yu Lin wrote:
> From: "chien-yu.lin" <chien-yu.lin@mediatek.com>
> 
> Because ASoC soc_new_pcm() function didn't register
> .get_time_info() ops and cause snd_pcm_update_hw_ptr0() can not find
> substream->ops->get_time_info, it will not be called due to ASoC
> driver which register in HW device driver.
> 
> Add .get_time_info() ops in ASoC soc_new_pcm() and
> register by snd_pcm_set_ops() function.
> If HW device driver want to implment timestamp by itself,
> ASoC should register .get_time_info function.
> 
> Signed-off-by: chien-yu.lin <chien-yu.lin@mediatek.com>
> ---
>  include/sound/soc-component.h |  4 ++++
>  sound/soc/soc-component.c     | 21 +++++++++++++++++++++
>  sound/soc/soc-pcm.c           |  2 ++
>  3 files changed, 27 insertions(+)
> 
> diff --git a/include/sound/soc-component.h b/include/sound/soc-
> component.h
> index 8c4d6830597f..52b5228b7a8d 100644
> --- a/include/sound/soc-component.h
> +++ b/include/sound/soc-component.h
> @@ -484,6 +484,10 @@ int snd_soc_pcm_component_sync_stop(struct
> snd_pcm_substream *substream);
>  int snd_soc_pcm_component_copy_user(struct snd_pcm_substream
> *substream,
>  				    int channel, unsigned long pos,
>  				    void __user *buf, unsigned long
> bytes);
> +int snd_soc_pcm_component_get_time_info(struct snd_pcm_substream
> *substream,
> +					struct timespec64 *system_ts,
> struct timespec64 *audio_ts,
> +					struct
> snd_pcm_audio_tstamp_config *audio_tstamp_config,
> +					struct
> snd_pcm_audio_tstamp_report *audio_tstamp_report);
>  struct page *snd_soc_pcm_component_page(struct snd_pcm_substream
> *substream,
>  					unsigned long offset);
>  int snd_soc_pcm_component_mmap(struct snd_pcm_substream *substream,
> diff --git a/sound/soc/soc-component.c b/sound/soc/soc-component.c
> index 3a5e84e16a87..56caec7ec00b 100644
> --- a/sound/soc/soc-component.c
> +++ b/sound/soc/soc-component.c
> @@ -1000,6 +1000,27 @@ int snd_soc_pcm_component_copy_user(struct
> snd_pcm_substream *substream,
>  	return -EINVAL;
>  }
>  
> +int snd_soc_pcm_component_get_time_info(struct snd_pcm_substream
> *substream,
> +					struct timespec64 *system_ts,
> struct timespec64 *audio_ts,
> +					struct
> snd_pcm_audio_tstamp_config *audio_tstamp_config,
> +					struct
> snd_pcm_audio_tstamp_report *audio_tstamp_report)
> +{
> +	struct snd_soc_pcm_runtime *rtd =
> asoc_substream_to_rtd(substream);
> +	struct snd_soc_component *component;
> +	int i;
> +
> +	/* FIXME. it returns 1st get_time_info now */
> +	for_each_rtd_components(rtd, i, component) {
> +		if (component->driver->get_time_info)
> +			return soc_component_ret(component,
> +				component->driver-
> >get_time_info(component,
> +				substream, system_ts, audio_ts,
> +				audio_tstamp_config,
> audio_tstamp_report));
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  struct page *snd_soc_pcm_component_page(struct snd_pcm_substream
> *substream,
>  					unsigned long offset)
>  {
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index d1c570ca21ea..cff7025027a6 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -2786,6 +2786,8 @@ int soc_new_pcm(struct snd_soc_pcm_runtime
> *rtd, int num)
>  			rtd->ops.mmap		=
> snd_soc_pcm_component_mmap;
>  		if (drv->ack)
>  			rtd->ops.ack            =
> snd_soc_pcm_component_ack;
> +		if (drv->get_time_info)
> +			rtd->ops.get_time_info	=
> snd_soc_pcm_component_get_time_info;
>  	}
>  
>  	if (playback)

