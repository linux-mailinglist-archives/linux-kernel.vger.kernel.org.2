Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11437383980
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 18:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbhEQQSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 12:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346057AbhEQQO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 12:14:58 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3079FC035437
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 07:48:17 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id v11-20020a17090a6b0bb029015cba7c6bdeso3864345pjj.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 07:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kdeSQM6n6ehpxt42Ss8k8UZyemLNVXlBn2/V/96APY4=;
        b=WVotFD6KFq7FKYZUVMZr4WZBVObM0/yy+5GOpB78HbjC+HRel8qTTi23kLZAFV5YpL
         8Le7N3FuVQ++shWQdW8GQFDeZy85GynYsH5DUnnyBHc4mk9j1A4sWUafeEY26uFvrHKE
         ZI6U7h4WaKiXvtCQws6l8+G1QBHV3UUBdgKj2kADT/H6BiLEOM3fXeBb/z7Yl5PUUC36
         RNHtkC3sU8VBTLkx1mfiYpMKMcV9t+tvhILPiqJi68boLB6IoHTJ+GkkYTuj4rcA8aRQ
         XWSPY0qYpBoWeVZyM4aI+EB/uyfIArlZogL1IgyzD42ocD6yc/vN5x+Eimyr0cDn9bBT
         yDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kdeSQM6n6ehpxt42Ss8k8UZyemLNVXlBn2/V/96APY4=;
        b=i4poTlXO4auoTDBiqYyOovWv+KhQofZLl6mrRBlxfVaejc1+KAweLLd2vesbLEThhN
         zhq7evlzVYRSmttYBpviqnep7pZP+8C4xyQ1hF3kzLMofXKhfEgtCnPxeVwMyQ96BfNC
         AHgqh0AYJH/Dt4okfC88KzlsR587PMFH1MLD/M8XXbSPn//sa6QmQaZZBPm62AFMmksi
         HeF/KcnFy+zYB4MT7aRZm5V/3CQ8YQ03C+LPosVaeyYJ1O1dtlUrS56XP/a7bKjMvuVJ
         ptdVMpaBmrl1ls5hM7NQNGl5bO1KjUBXGveLnz67N8yLtrjblj8W8i5/vj4HMau5OLJ6
         E71w==
X-Gm-Message-State: AOAM530jm2opeWPn3UZy46BWo7RmDCd6BRllkG1aQCwbfl1FcokpekXH
        9rg3Ap14L2VhjECzKxMheQE=
X-Google-Smtp-Source: ABdhPJy/hLq9Wg9UD+0N/OJ47bWBmXA9uT4lXWcLYM/B9K+IiAWbeYfHp7+Q4tvdTBQoTSXOfK14Yg==
X-Received: by 2002:a17:90a:a2b:: with SMTP id o40mr302170pjo.214.1621262896743;
        Mon, 17 May 2021 07:48:16 -0700 (PDT)
Received: from hyeyoo ([183.99.11.150])
        by smtp.gmail.com with ESMTPSA id h1sm10449494pfh.72.2021.05.17.07.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 07:48:16 -0700 (PDT)
Date:   Mon, 17 May 2021 23:48:11 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] sound: line6: Fix race condition in line6_probe
Message-ID: <20210517144811.GA54892@hyeyoo>
References: <20210517132725.GA50495@hyeyoo>
 <s5hk0nxo4qr.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hk0nxo4qr.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 03:43:24PM +0200, Takashi Iwai wrote:
> The actually needed initialization is
> line6_init_mid() call, and this can be fixed by moving to the
> appropriate place instead of inside each private_init callback.

Oh, I missed it! there was another caller of line6_init_midi.
your fix seems promising to me. it's putting line6_init_midi
to the right place.

by the way looking at code, I think this driver needs some
refactoring... it doesn't handle exceptions well.

Thanks,

Hyeonggon
> ---
> diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
> index a030dd65eb28..9602929b7de9 100644
> --- a/sound/usb/line6/driver.c
> +++ b/sound/usb/line6/driver.c
> @@ -699,6 +699,10 @@ static int line6_init_cap_control(struct usb_line6 *line6)
>  		line6->buffer_message = kmalloc(LINE6_MIDI_MESSAGE_MAXLEN, GFP_KERNEL);
>  		if (!line6->buffer_message)
>  			return -ENOMEM;
> +
> +		ret = line6_init_midi(line6);
> +		if (ret < 0)
> +			return ret;
>  	} else {
>  		ret = line6_hwdep_init(line6);
>  		if (ret < 0)
> diff --git a/sound/usb/line6/pod.c b/sound/usb/line6/pod.c
> index cd44cb5f1310..16e644330c4d 100644
> --- a/sound/usb/line6/pod.c
> +++ b/sound/usb/line6/pod.c
> @@ -376,11 +376,6 @@ static int pod_init(struct usb_line6 *line6,
>  	if (err < 0)
>  		return err;
>  
> -	/* initialize MIDI subsystem: */
> -	err = line6_init_midi(line6);
> -	if (err < 0)
> -		return err;
> -
>  	/* initialize PCM subsystem: */
>  	err = line6_init_pcm(line6, &pod_pcm_properties);
>  	if (err < 0)
> diff --git a/sound/usb/line6/variax.c b/sound/usb/line6/variax.c
> index ed158f04de80..1376fc405c7f 100644
> --- a/sound/usb/line6/variax.c
> +++ b/sound/usb/line6/variax.c
> @@ -172,11 +172,6 @@ static int variax_init(struct usb_line6 *line6,
>  	if (variax->buffer_activate == NULL)
>  		return -ENOMEM;
>  
> -	/* initialize MIDI subsystem: */
> -	err = line6_init_midi(&variax->line6);
> -	if (err < 0)
> -		return err;
> -
>  	/* initiate startup procedure: */
>  	schedule_delayed_work(&line6->startup_work,
>  			      msecs_to_jiffies(VARIAX_STARTUP_DELAY1));
