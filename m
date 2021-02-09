Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA376314999
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 08:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhBIHiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 02:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhBIHii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 02:38:38 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE38C061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 23:37:58 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id m144so1337623qke.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 23:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TA2zCXQWyDOuZ3241o0zHrHJeg5zoATDvEC3rNF5Thg=;
        b=aFqx19CsiDQ4CXdqv8NtZ9EA2SKeMsd4xC4NZ/nzezK9+J6zvORRsH7FpjZ00Ik6/L
         6hsxiV08Y+k2xbFHdnzVNJDW7n5XdC5Vv4di0f6h18Xz1hRTODJSwxvh5MMKW14p9V/V
         E+3pzL41BHxu8upArS7dHxNDsjFJt3vk73nK1UcCUpVoCxNjGXigytpfnmQJ3Tf8aZ50
         k49zN3UzHVgw/WsyvCBXUL7RXB13r6O6jBmp10AjM5BpJQ4DmlXJ6RnarQKz4wip9By5
         Ax42LOGkX8LkSYwCx4yCZUOChSuFsobNto37UtbuEDaEZr4Z8zRgHutlxAognEYXNYiD
         UrDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TA2zCXQWyDOuZ3241o0zHrHJeg5zoATDvEC3rNF5Thg=;
        b=Tc6IGp/DqGLkueVzebuPeSeZYrwBpfYvrtZqtDd/rBNfATi0/H+WhwCT2LBPEUbZIA
         o9gb2s1Df3Z8EXbBSI+2iQNXulnXNSXQ0Agu0wEnusmW/yPYCVrljEPsx4CG36xUsYWw
         qHccVySya4Jfwsx8+rYDqHLU3g++CN391Vyz3tZ8fSCCFv0hiiEo5vXFELI1Y9LL7ENO
         ijYysU9tyU/abQbz3wt9jhPfKpoUp/vKFdB03XBrEoBQ3a6H+O/KkDNumkVv0iMQB5GB
         aNEU4WQchHGdnNYxkacr+0HCAuH7WH8aJ270RSbugamidA3NNeQ+WiEHWQI4EKQi8eBB
         YqZA==
X-Gm-Message-State: AOAM533Gx7uGh0uu+GU8Nbcp1uhPRCokTb/C+omgiofzQblefOjEOclD
        86bG6PzAiAsvtMGQl8zcCTkAlNwTdpHjsZT4vMw=
X-Google-Smtp-Source: ABdhPJxQFReVv8ndL4K9cxsOw8JEsTJl2WThnm+2bqROErPee3aBm7b19iLaQ3kifghsdVfNJILtYnI8++GJL2d7Ojo=
X-Received: by 2002:a37:a004:: with SMTP id j4mr6861902qke.450.1612856277739;
 Mon, 08 Feb 2021 23:37:57 -0800 (PST)
MIME-Version: 1.0
References: <1612771965-5776-1-git-send-email-shengjiu.wang@nxp.com> <b7f5442d-ad21-eb8a-7d90-7a8207320541@linux.intel.com>
In-Reply-To: <b7f5442d-ad21-eb8a-7d90-7a8207320541@linux.intel.com>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Tue, 9 Feb 2021 15:37:46 +0800
Message-ID: <CAA+D8AMkpQPXBcdwAy67dv=M+udQG4fdj7UJzt6s-pwBiUGTVw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: soc-pcm: change error message to debug message
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, perex@perex.cz,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 9, 2021 at 12:39 AM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
>
> On 2/8/21 2:12 AM, Shengjiu Wang wrote:
> > This log message should be a debug message, because it
> > doesn't return directly but continue next loop.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >   sound/soc/soc-pcm.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> > index 605acec48971..cd9e919d7b99 100644
> > --- a/sound/soc/soc-pcm.c
> > +++ b/sound/soc/soc-pcm.c
> > @@ -1344,8 +1344,8 @@ static int dpcm_add_paths(struct snd_soc_pcm_runtime *fe, int stream,
> >               /* is there a valid BE rtd for this widget */
> >               be = dpcm_get_be(card, widget, stream);
> >               if (!be) {
> > -                     dev_err(fe->dev, "ASoC: no BE found for %s\n",
> > -                                     widget->name);
> > +                     dev_dbg(fe->dev, "ASoC: no BE found for %s\n",
> > +                             widget->name);
>
> Do we really want to do this?
>
> This error message has historically been the means by which we detect
> that userspace didn't set the right mixers (e.g. on Intel Baytrail) or
> the topology was incorrect. And it's really an error in the sense that
> you will not get audio in or out.
>
> If you demote this to dev_dbg, we'll have to ask every single user who
> reports 'sound is broken' to enable dynamic debug traces. I really don't
> see the benefit, this is a clear case of 'fail big and fail early',
> partly concealing the problem doesn't make it go away but harder to
> diagnose.

Thanks for the explanation,  it seems I misunderstood this error message.

Best regards
Wang shengjiu
