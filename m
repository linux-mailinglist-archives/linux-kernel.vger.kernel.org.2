Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFAC345004
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 20:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbhCVTiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 15:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbhCVThh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 15:37:37 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7197C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 12:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=tfnBSEYclohJjaV1MdPg0Tk1/ERGZoKsXMbl+7RXvpg=; b=bs8xMQpYmu2xpPxkDu2lPFpji5
        Bq1fBd2MhLdoQH8SKMj9I9qMpF8Zb5kpBpaxnz8r12zktUm9IKQPbbXP98XmACh8EeoGHW3NT4qow
        YyVh9ZiUhf4NPgqO1c23c7sePwWOgPMXpbWJxcIW8dm6+qdRUiCsLVhDFJnpludSgwa+aYAA5/u7Z
        JNrt04x0UXzJRpRlLdNygMNALsAwTfGDaKqzQj4Gu9P2o3JyVlGkOuCKqHAU1NmlpLYD7Tcz7rYZl
        EoO3sSH5/6ALv6oyBYeiYGO+mukXXLXKHRqRVn1yA6Za3HpQ7XFQ3qafWZITdbjrWfxT4GZRsAh2Q
        UzkYjBDw==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOQMo-00CRRu-0W; Mon, 22 Mar 2021 19:37:34 +0000
Subject: Re: [PATCH] ASoC: Intel: Fix a typo
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20210322065238.151920-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <226fbfc2-bb32-4ffc-fd61-5eabfd675bd8@infradead.org>
Date:   Mon, 22 Mar 2021 12:37:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210322065238.151920-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/21 11:52 PM, Bhaskar Chowdhury wrote:
> 
> s/struture/structure/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

The 3 patches with the same Subject: should all be merged into
one patch IMO.


> ---
>  sound/soc/intel/atom/sst-mfld-dsp.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/atom/sst-mfld-dsp.h b/sound/soc/intel/atom/sst-mfld-dsp.h
> index 102b0e7eafb0..8d9e29b16e57 100644
> --- a/sound/soc/intel/atom/sst-mfld-dsp.h
> +++ b/sound/soc/intel/atom/sst-mfld-dsp.h
> @@ -256,7 +256,7 @@ struct snd_sst_tstamp {
>  	u32 channel_peak[8];
>  } __packed;
> 
> -/* Stream type params struture for Alloc stream */
> +/* Stream type params structure for Alloc stream */
>  struct snd_sst_str_type {
>  	u8 codec_type;		/* Codec type */
>  	u8 str_type;		/* 1 = voice 2 = music */
> --


-- 
~Randy

