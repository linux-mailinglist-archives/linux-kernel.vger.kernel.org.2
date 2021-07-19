Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B288B3CCC39
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 04:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbhGSCZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 22:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbhGSCZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 22:25:43 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35149C061762
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 19:22:44 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y4so15098572pfi.9
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 19:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=vBKXyvVxdCKu3OqvyqumajmYvsEUys0czY+E4eDZup4=;
        b=j6x7161Qw3k5DqjiWIfNYy2Pej3jSENkrNqMx1espZ54hH9Jfz/622pZg7shSXaMT7
         OJ9Ezo/A00F3Ik0dniPx5rj59aGdtCBpRcaSoLSWZnTD05cZ54stkrWPJgdg83DNdQvj
         G2MBHhq1clNLhl2/H1dEzvNj68XjmR8yY44QkZdnNCDLxtre1m2FjUB8lqxD0oqKtAoX
         8Mbz1cfDW/UCwXpf8SthUzKIGRKVYjXNs7A9IjmxYt/LxM2/Y9+1W9YcWwB9mYaQwlQY
         5Oy1UMG2ge53B4wCau45oepnYaDr5dL3PBPLPDC1lmqS+d+5A9ccoS0vxxEXcftVdIT9
         fyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vBKXyvVxdCKu3OqvyqumajmYvsEUys0czY+E4eDZup4=;
        b=VQl/swtLwTq/G0M5ANlrnKQLvIqd8AQjwzD//75jxGZxwsNgaPoWdZt1AAqDY///2X
         RXILeM69kUgkK9IRBrT48o8DVULF+7UMp3u6NM+0BGhVK8TK3m56cZArjVSoLmEOmOSN
         rW4ACUQHCETKg7K1Z+iUTxyfnQg13f1+WxvtMRvXPOQ2IUUW80lmS5em3kjG20S/FhnF
         btLNMhFboHDa3w8C6ki58bnyAItFmc06zp2ARQw1Iz299NdACzW10lhbiL+p1JvmYYzg
         CpBGc88jYGE8iqzqLGgG+M0YS+Bhn8B4u7ePqdNvuha0dVpkEosqrarUGfbH02FgBTGi
         YdWg==
X-Gm-Message-State: AOAM5303qfG7JGPDSfuhri6pCUOT0fplErL3SbzKNPsYTRgxB9fqcHHm
        5sSKeq4TlZjLz10s7W7ytbSZshka/OM=
X-Google-Smtp-Source: ABdhPJzcYKL/xyFFp2W4/EVyqouIpcvkOiDD8SALBl18eeQiQ6JqQJ2+HaX44T7HejoyIa6RSpP/8w==
X-Received: by 2002:a65:5343:: with SMTP id w3mr23150557pgr.51.1626661363320;
        Sun, 18 Jul 2021 19:22:43 -0700 (PDT)
Received: from [10.29.0.130] ([45.135.186.118])
        by smtp.gmail.com with ESMTPSA id f17sm17711971pjj.21.2021.07.18.19.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jul 2021 19:22:42 -0700 (PDT)
Subject: Re: [BUG] ALSA: sb16: possible ABBA deadlock in snd_sb_csp_stop() and
 snd_sb_csp_load()
To:     Takashi Iwai <tiwai@suse.de>
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        "linux-kernel@vger.kernel.org >> linux-kernel" 
        <linux-kernel@vger.kernel.org>
References: <7b0fcdaf-cd4f-4728-2eae-48c151a92e10@gmail.com>
 <s5ho8b3x3wu.wl-tiwai@suse.de>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <a160198b-19c6-5f50-329a-3f54fd464168@gmail.com>
Date:   Mon, 19 Jul 2021 10:22:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <s5ho8b3x3wu.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/7/15 18:33, Takashi Iwai wrote:
> On Thu, 15 Jul 2021 12:20:36 +0200,
> Jia-Ju Bai wrote:
>> Hello,
>>
>> I find there is a possible ABBA deadlock in the SB16 driver in Linux 5.10:
>>
>> In snd_sb_csp_stop():
>> 876:     spin_lock_irqsave(&p->chip->mixer_lock, flags);
>> 882:     spin_lock(&p->chip->reg_lock);
>>
>> In snd_sb_csp_load():
>> 614:     spin_lock_irqsave(&p->chip->reg_lock, flags);
>> 653:     spin_lock(&p->chip->mixer_lock);
>>
>> When snd_sb_csp_stop() and snd_sb_csp_load() are concurrently
>> executed, the deadlock can occur.
>>
>> I check the code and find a possible case of such concurrent execution:
>>
>> #CPU1:
>> snd_sb16_playback_close
>>    snd_sb16_csp_playback_close (csp->ops.csp_stop(csp))
>>      snd_sb_csp_stop
>>
>> #CPU2:
>> snd_sb_csp_ioctl
>>    snd_sb_csp_riff_load
>>      snd_sb_csp_load_user
>>        snd_sb_csp_load
>>
>> I am not quite sure whether this possible deadlock is real and how to
>> fix it if it is real.
>> Any feedback would be appreciated, thanks
> The impact must be quite low, as both functions run in different
> state (running or stopped), so those are basically exclusive.
> And, above all, there is no VM supporting this chip, hence it's only
> for the real hardware and it's about very old ISA boards that maybe
> only less than handful people in the world can run now.
>
> About the fix: just split the locks in snb_sb_csp_stop() (also
> snd_sb_csp_start()) like below should suffice.

Thanks for the feedback and explanation :)
The patch looks good to me.

>
> --- a/sound/isa/sb/sb16_csp.c
> +++ b/sound/isa/sb/sb16_csp.c
> @@ -816,6 +816,7 @@ static int snd_sb_csp_start(struct snd_sb_csp * p, int sample_width, int channel
>   	mixR = snd_sbmixer_read(p->chip, SB_DSP4_PCM_DEV + 1);
>   	snd_sbmixer_write(p->chip, SB_DSP4_PCM_DEV, mixL & 0x7);
>   	snd_sbmixer_write(p->chip, SB_DSP4_PCM_DEV + 1, mixR & 0x7);
> +	spin_unlock_irqrestore(&p->chip->mixer_lock, flags);
>   
>   	spin_lock(&p->chip->reg_lock);
>   	set_mode_register(p->chip, 0xc0);	/* c0 = STOP */
> @@ -855,6 +856,7 @@ static int snd_sb_csp_start(struct snd_sb_csp * p, int sample_width, int channel
>   	spin_unlock(&p->chip->reg_lock);
>   
>   	/* restore PCM volume */
> +	spin_lock_irqsave(&p->chip->mixer_lock, flags);
>   	snd_sbmixer_write(p->chip, SB_DSP4_PCM_DEV, mixL);
>   	snd_sbmixer_write(p->chip, SB_DSP4_PCM_DEV + 1, mixR);
>   	spin_unlock_irqrestore(&p->chip->mixer_lock, flags);
> @@ -880,6 +882,7 @@ static int snd_sb_csp_stop(struct snd_sb_csp * p)
>   	mixR = snd_sbmixer_read(p->chip, SB_DSP4_PCM_DEV + 1);
>   	snd_sbmixer_write(p->chip, SB_DSP4_PCM_DEV, mixL & 0x7);
>   	snd_sbmixer_write(p->chip, SB_DSP4_PCM_DEV + 1, mixR & 0x7);
> +	spin_unlock_irqrestore(&p->chip->mixer_lock, flags);
>   
>   	spin_lock(&p->chip->reg_lock);
>   	if (p->running & SNDRV_SB_CSP_ST_QSOUND) {
> @@ -894,6 +897,7 @@ static int snd_sb_csp_stop(struct snd_sb_csp * p)
>   	spin_unlock(&p->chip->reg_lock);
>   
>   	/* restore PCM volume */
> +	spin_lock_irqsave(&p->chip->mixer_lock, flags);
>   	snd_sbmixer_write(p->chip, SB_DSP4_PCM_DEV, mixL);
>   	snd_sbmixer_write(p->chip, SB_DSP4_PCM_DEV + 1, mixR);
>   	spin_unlock_irqrestore(&p->chip->mixer_lock, flags);

