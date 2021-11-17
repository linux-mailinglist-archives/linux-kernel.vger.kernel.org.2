Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B290454E39
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 20:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240624AbhKQT7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 14:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbhKQT7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 14:59:22 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B98C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 11:56:17 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id w22so4877880ioa.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 11:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5VBfPESdcXTL80+DWpyXFkbq5atbMeJcpA3NDVqVEho=;
        b=X6KFt1hJmRksijS0mwdT5x5R5Cb4kdgmuOI69Q5aRlP/NMidCD9mNur25QLLju7p+1
         pUnRfFzKJkXdvMArbfV9m/Xw/xwRBpAk9betoF/jo7wwqhUGkvGBQ+KYG1ZXNJ4TZ0Yw
         kyzV3zPSieN/NrE6lVrQ4epovmEKfDuAtowsj8PTOykl8nIfQqKjNbF3h074mrzZAeVT
         e3M4RDoRtYs1LnC1QctSZCQIe5V4+udBfbKLFPnA6qc5adbm9r9zdQmHzGiP3aBxIK+3
         myvsCAz7qgWVp4mb/EbX+4ze2Rdvz74wnd8ziPhECnzVkuNNjGYJUe0KgB/kCJbbCI9K
         IynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5VBfPESdcXTL80+DWpyXFkbq5atbMeJcpA3NDVqVEho=;
        b=MKfVgtuPTDIupCvu+8neZtnrCBROy11pmqdu8609IkYDTwZ0DwD5slYQvc4nXDbjZo
         +ECEVHBEfBWUuVJF75Ywro+x7zYPlLNMO4A16eCVuU/27dNcT6zm9cd7hECl2+YaXmL7
         xHVWB/PjCA4vfxFpxPSSYlh6ej1hA2HGxYL1JZgT6pNX5DbmJoKQItDGB5T2MbCydV7+
         M/eYkjcZLrGN+jl9+idaPvK3q3T0fIGHEe4lPFixvdcb6zkXOcTkJPlcn1uGJzEdVgxL
         I8yiBOgRPKMyrO9OzTPKRy0MOra+I5FuH3XfRQl6Ib04EmliQZQ2tG3Iure5du5JNXDp
         cFkQ==
X-Gm-Message-State: AOAM533uodBoOavDel8Ua4wznqU0gSmVu9P5irCgW4eyl7P/kv81GZgw
        Xk5bXoFpC8MyvUwogKPLme82GXdRWJTfDw==
X-Google-Smtp-Source: ABdhPJy5ZbbuIX+vxu7l+x9G0lL52knByhCJwD3rbmlDMi+PygF6+8Dkj/nbTl0tF87B33FoT5E2KA==
X-Received: by 2002:a05:6638:238b:: with SMTP id q11mr15391858jat.43.1637178976751;
        Wed, 17 Nov 2021 11:56:16 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id d2sm577088ilg.77.2021.11.17.11.56.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 11:56:16 -0800 (PST)
Message-ID: <07e228eb-676a-bdb1-c2ec-a96f691f5a18@linaro.org>
Date:   Wed, 17 Nov 2021 13:56:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [greybus-dev] [PATCH] staging: greybus: Add missing rwsem around
 snd_ctl_remove() calls
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>, greybus-dev@lists.linaro.org
Cc:     Alex Elder <elder@kernel.org>, Johan Hovold <johan@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20211116072027.18466-1-tiwai@suse.de>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20211116072027.18466-1-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/21 1:20 AM, Takashi Iwai wrote:
> snd_ctl_remove() has to be called with card->controls_rwsem held (when
> called after the card instantiation).  This patch adds the missing
> rwsem calls around it.

I see the comment above snd_ctl_remove() that says you must hold
the write lock.  And given that, this seems correct to me.

I understand why you want to take the lock just once, rather
than each time snd_ctl_remove() is called.

However I believe the acquisition and release of the lock
belongs inside gbaudio_remove_controls(), not in its caller.

If you disagree, can you please explain why?

Otherwise, will you please submit version two, taking the
lock inside gbaudio_remove_controls()?

Thanks.

					-Alex

> Fixes: 510e340efe0c ("staging: greybus: audio: Add helper APIs for dynamic audio modules")
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   drivers/staging/greybus/audio_helper.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/greybus/audio_helper.c b/drivers/staging/greybus/audio_helper.c
> index 1ed4772d2771..843760675876 100644
> --- a/drivers/staging/greybus/audio_helper.c
> +++ b/drivers/staging/greybus/audio_helper.c
> @@ -192,7 +192,11 @@ int gbaudio_remove_component_controls(struct snd_soc_component *component,
>   				      unsigned int num_controls)
>   {
>   	struct snd_card *card = component->card->snd_card;
> +	int err;
>   
> -	return gbaudio_remove_controls(card, component->dev, controls,
> -				       num_controls, component->name_prefix);
> +	down_write(&card->controls_rwsem);
> +	err = gbaudio_remove_controls(card, component->dev, controls,
> +				      num_controls, component->name_prefix);
> +	up_write(&card->controls_rwsem);
> +	return err;
>   }
> 

