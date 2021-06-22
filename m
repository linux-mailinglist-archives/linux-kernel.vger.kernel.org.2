Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22343AFABA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 03:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhFVBzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 21:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhFVBzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 21:55:40 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9E2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 18:53:23 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id m15so2604546qvc.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 18:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1QTuaNj1iCRevxIVn07f/kyH2pwUNv2dSDLfnl7sJyA=;
        b=oJNrVUa2XPX5TJqSmRrTkm0n3hiPddmWMVfa017B9LAUrPBpxAncFYkrkGZSDEXRBh
         AuBhSk3qcrWUlGNDCJjmssf0Vk2JApDxtoHkB8G5ja/M6VeMZY+8N/ION8pueo4oDD8o
         rmTqTefG1n90ow3ol+EgjrvPq7onL/saU9cSB/67IW4CvtGGZslQVe83NKXOUyVoAArx
         qvfF42EXyE1DH2ZONycGLVvneo844q60/iV+zKH6trXGym0Fj+myF39tCVrVHtk5aBCg
         O+F7XqYFobhmmUUI7+t1OQcOIgxsRytAJWE4aLtt42PXe8tEqlbq+o5xzwE0pQXi6Q6u
         g/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1QTuaNj1iCRevxIVn07f/kyH2pwUNv2dSDLfnl7sJyA=;
        b=KovSxQ2Ni3yq3jQ00jFQIBAfRVow2sup9eWCUYIMkpxFEx7M/XDEqfvkXiB8YIaMWx
         DiG/s1ciCZ6SNppbJMINUm+7/rchHOE80oRB7Uomon3wMWxcYXRLJ8vcBjrB3Ux7CROo
         NCwlk4QG0Ugx28r+kSUHEZw9x8TaG1v/3UsqXX5z3jmK08tCDo6ENg2TCibNCH9Usxf/
         oh7LPpvoDwbNg57aFtnByLOdI32jdh2RrDyYzyipP6MeN6Hbr12aIxzaEmAMJ9p+1YFA
         mqff5Urqq+zR5bPWjwrb5+SvKeg1j7850vzmthyvXi+uJWxpnL4NBcMn04CWrUbH/KNK
         1VfA==
X-Gm-Message-State: AOAM533eChNjU0wKUdyAiQa2wIJVRgHM/A3ZAPJLUjqip9l2dr3z5VJ7
        23KThnj75dFqJRgG9/WqGxkUih0MILrJrZrZbE8=
X-Google-Smtp-Source: ABdhPJyK+ME4U390q9Mvxhn4yyQjnyEwb5J4Pk64Y4liLe7WtySvGp22/bO45BpXK3lsvidSxjOvxgDpVOZE5wPUYJE=
X-Received: by 2002:ad4:4bc9:: with SMTP id l9mr9578935qvw.36.1624326801992;
 Mon, 21 Jun 2021 18:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <1624324395-7260-1-git-send-email-shengjiu.wang@nxp.com> <CAOMZO5Bh6J8=E=P1btDdgkYm9bvBN1ituRHLLOtW1cFsheQBdg@mail.gmail.com>
In-Reply-To: <CAOMZO5Bh6J8=E=P1btDdgkYm9bvBN1ituRHLLOtW1cFsheQBdg@mail.gmail.com>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Tue, 22 Jun 2021 09:53:11 +0800
Message-ID: <CAA+D8AN4Nch5FMjCDN8vs2+Nqs88k8jvMEBZwQuUdG+9pt1yZA@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] ASoC: fsl-asoc-card: change dev_err to
 dev_err_probe for defer probe
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 9:45 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Shengjiu,
>
> On Mon, Jun 21, 2021 at 10:31 PM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
> >
> > Don't need to print error message for defer probe
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> > changes in v2:
> > - use dev_err_probe instead of dev_dbg
> >
> >  sound/soc/fsl/fsl-asoc-card.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
> > index 121e08c2af2a..24c890d76da0 100644
> > --- a/sound/soc/fsl/fsl-asoc-card.c
> > +++ b/sound/soc/fsl/fsl-asoc-card.c
> > @@ -708,8 +708,8 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
> >         of_node_put(framemaster);
> >
> >         if (!fsl_asoc_card_is_ac97(priv) && !codec_dev) {
> > -               dev_err(&pdev->dev, "failed to find codec device\n");
> >                 ret = -EPROBE_DEFER;
> > +               dev_err_probe(&pdev->dev, ret, "failed to find codec device\n");
>
> I know I suggested dev_err_probe() before, but looking at this again, I realized
> that the error message will never be printed.
>
> Maybe the error message could just be deleted?

so I think we can use the v1 one,  use dev_dbg instead.

best regards
wang shengjiu
