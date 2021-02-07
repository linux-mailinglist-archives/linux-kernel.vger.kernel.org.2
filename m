Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DA331234A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 10:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhBGJvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 04:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhBGJv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 04:51:27 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F25C06174A;
        Sun,  7 Feb 2021 01:50:46 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id 2so5691329qvd.0;
        Sun, 07 Feb 2021 01:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dZ4pFx7u5BUDAgelezxkYQyF+xKN7GGALoSIhITUj+o=;
        b=pDgcBRamMSdoUB2BEpAst1f1B9nv0WmaS1Vvz3pxn90Bo2k1jjA+Rmy0x4aLBo07mY
         asda/mt0rtnitVvzATsvxfXHA32w6sTXiqJjs1JBXExweSz1LhjNLHlAe1y/uJwVoXPP
         wMZxM9NPideQw1Zn+3YhCfTxp2iE+jS49MhfAhBXlxoCTbo27Rn9tle+lHnmbjfbFvXp
         X0hAwsQSyOLaIiM0VA16unpVG4z8pP0NFOokUPDV4c6WWuDTv7Mspy8/5jiWRxPdTYZ2
         ot4n0YWlHpRfnib2YaYfQTZxNBV6VLrvkNQtRO3nOIMXZmsratGIKOhZWgirQuqokfd3
         5XYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dZ4pFx7u5BUDAgelezxkYQyF+xKN7GGALoSIhITUj+o=;
        b=DM4qRCoLpOPrYi/jp8FGcYGahkaI+sZnWvVqgGMZTF+xaPtVKBznilQgf0JBmeUA8w
         DedvQstdH7smZf4aX/gEIDOIraOZ/TqnnvY6gf3//Zap7Ws4gE2WEkmllLoCrHdB1lDK
         xfCjoKsTuDj0/QCttEFtAmdxmMXuUYPENauavDo192ltaO15Y4sMM/HDlMvLwikXwgh9
         Mz+Eh5MGGwj560LTQzGZKCy69Qq5yvDz8Q0MF9Q9fvyY867wcC6jwxzmPsXMudGcf+T2
         9kGnUHA+QhuP6jShd9MounSwJHu/oWUj4bg3e4f8txyqedeWOxmoGhwonsm9DlCFW2at
         YUmw==
X-Gm-Message-State: AOAM5339Ju3krDsKeGDHxfmXT/q7ibkROgDeQAPhFksYxRcr8P9et6Q8
        uCZke8KfJUQa0+7ffrUX3bm59llgYmpA/aPL1bI=
X-Google-Smtp-Source: ABdhPJy645FIrmGyg3s+S/f06QE4AJor1BtSgmIOXYOPdd5fhNxXhtiMyZ5sAnnbwtjUKTyx3gqZcZrxPegIJKozRmo=
X-Received: by 2002:a05:6214:76f:: with SMTP id f15mr11458355qvz.56.1612691446129;
 Sun, 07 Feb 2021 01:50:46 -0800 (PST)
MIME-Version: 1.0
References: <1612508250-10586-1-git-send-email-shengjiu.wang@nxp.com>
 <1612508250-10586-6-git-send-email-shengjiu.wang@nxp.com> <20210205145816.GD4720@sirena.org.uk>
In-Reply-To: <20210205145816.GD4720@sirena.org.uk>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Sun, 7 Feb 2021 17:50:35 +0800
Message-ID: <CAA+D8AMTyxcz2nXEDemuWRwtORSfRoBRZO03WyX+XpuiOD0XiA@mail.gmail.com>
Subject: Re: [PATCH 5/7] ASoC: imx-pcm-rpmsg: Add platform driver for audio
 base on rpmsg
To:     Mark Brown <broonie@kernel.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org,
        Timur Tabi <timur@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Xiubo Li <Xiubo.Lee@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 11:00 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Feb 05, 2021 at 02:57:28PM +0800, Shengjiu Wang wrote:
>
> > +     if (params_format(params) == SNDRV_PCM_FORMAT_S16_LE)
> > +             msg->s_msg.param.format   = RPMSG_S16_LE;
> > +     else if (params_format(params) == SNDRV_PCM_FORMAT_S24_LE)
>
> Again this should be a switch statement.
>
> > +     if (params_channels(params) == 1)
> > +             msg->s_msg.param.channels = RPMSG_CH_LEFT;
> > +     else
> > +             msg->s_msg.param.channels = RPMSG_CH_STEREO;
>
> Shouldn't this be reporting an error if the number of channels is more
> than 2?
>
> > +             /*
> > +              * if the data in the buffer is less than one period
> > +              * send message immediately.
> > +              * if there is more than one period data, delay one
> > +              * period (timer) to send the message.
> > +              */
> > +             if ((avail - writen_num * period_size) <= period_size) {
> > +                     imx_rpmsg_insert_workqueue(substream, msg, info);
> > +             } else if (rpmsg->force_lpa && !timer_pending(timer)) {
> > +                     int time_msec;
> > +
> > +                     time_msec = (int)(runtime->period_size * 1000 / runtime->rate);
> > +                     mod_timer(timer, jiffies + msecs_to_jiffies(time_msec));
> > +             }
>
> The comment here is at least confusing - why would we not send a full
> buffer immediately if we have one?  This sounds like it's the opposite
> way round to what we'd do if we were trying to cut down the number of
> messages.  It might help to say which buffer and where?
>
> > +     /**
> > +      * Every work in the work queue, first we check if there
>
> /** comments are only for kerneldoc.

Thanks Mark, I will update them.

Best regards
wang shengjiu
