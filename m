Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6D033B01D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhCOKkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhCOKjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:39:33 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23351C061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 03:39:32 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 420AA1F45CDA
Subject: Re: [PATCH 04/23] ASoC: cros_ec_codec: remove null pointer
 dereference warning
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, linux-kernel@vger.kernel.org,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benson Leung <bleung@chromium.org>
References: <20210312182246.5153-1-pierre-louis.bossart@linux.intel.com>
 <20210312182246.5153-5-pierre-louis.bossart@linux.intel.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <dd3fd255-4397-80d6-2114-3b37b5be5c08@collabora.com>
Date:   Mon, 15 Mar 2021 11:39:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210312182246.5153-5-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre-Louis,

Thank you for you patch.

On 12/3/21 19:22, Pierre-Louis Bossart wrote:
> Cppcheck complains of a possible issue:
> 
> sound/soc/codecs/cros_ec_codec.c:98:10: warning: Possible null pointer
> dereference: in [nullPointer]
>   memcpy(in, msg->data, insize);
>          ^
> sound/soc/codecs/cros_ec_codec.c:162:34: note: Calling function
> 'send_ec_host_command', 5th argument 'NULL' value is 0
>        (uint8_t *)&p, sizeof(p), NULL, 0);
>                                  ^
> sound/soc/codecs/cros_ec_codec.c:98:10: note: Null pointer dereference
>   memcpy(in, msg->data, insize);
>          ^
> 
> In practice the access to the pointer is protected by another
> argument, but this is likely to fool other static analysis tools. Add
> a test to avoid doing the memcpy if the pointer is NULL or the size is
> zero.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Looks good to me, so

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>


> ---
>  sound/soc/codecs/cros_ec_codec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
> index c4772f82485a..a201d652aca2 100644
> --- a/sound/soc/codecs/cros_ec_codec.c
> +++ b/sound/soc/codecs/cros_ec_codec.c
> @@ -94,7 +94,7 @@ static int send_ec_host_command(struct cros_ec_device *ec_dev, uint32_t cmd,
>  	if (ret < 0)
>  		goto error;
>  
> -	if (insize)
> +	if (in && insize)
>  		memcpy(in, msg->data, insize);
>  
>  	ret = 0;
> 
