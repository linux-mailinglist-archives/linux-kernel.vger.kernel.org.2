Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E69433D4E8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 14:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbhCPNd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 09:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbhCPNdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 09:33:33 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3840C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 06:33:32 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 130so35128741qkh.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 06:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yxhYiPJJfH15vXoqGY5Nr6454DNFIyQXelAI1Oeta38=;
        b=R+7ONg+RgbaadocUNVLV29LfFtUgU08qGOry13BkXZuUFBFdApt7Q1+HoPq95QNmmK
         2o3ieaXtCTwUuwJLbltLXooTvq9MOIcqDu2j31htqM9p/0qKnYJJG2FbX2hlB2DMQhHS
         wN/YFTNa2+/mIo9Ss9mOnnaK9uViykX44CgthMB7gKsSAtW2dYhUXV+zXJwEYdLvyjjG
         hhlZhAuWKnxeE3sC76kOrqtI+zQq8bHLJepTQ4Bp+Mt8ZOcv2K5z2/1zuQJPcf2gB9vA
         VIhQgygxCx7LeyWGzQTGlkeVXK8pHZxUrbGtLyGgYe+iOyb8BBHkxWWZH5E6i1l09S9V
         q7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yxhYiPJJfH15vXoqGY5Nr6454DNFIyQXelAI1Oeta38=;
        b=VXICRFfSm62v92i0WcFWO7lbF/GHX9iJCR3Pa+COlQ7rto4WPGxjeYf4DTUMbvu4ff
         uW0cFIZUCQVL2IgKj0/E387zcXZlp/DJ4GPPaRTANA6rUb1TvthqaRSQ+TAZbxNo232h
         A+SvZ5vyaML8oFiIQd0NHXQkScVWtIA9zn6jsNeJDmtju3vFf7brPxeNyNe4cEYDwYSQ
         H/ep6mbGELo+ToaMoYraEgm8DbI/QjoakUgMxeM1dVFN4dbOdtRoi5zwI/PQ6aZ+21/N
         s38LtLQO36UtNiw+YN8Nwr/a8ntm4f1VNDeAT6qGrQHzLLBlRrnnH8cIvM9DXa7ebvrC
         OHZQ==
X-Gm-Message-State: AOAM531vY+SZzLT5Cfu5nTRvd0Pb1abGvnLqQ6dBmiZYi8vzBzcVuTfY
        tQanOaSr5SupLS+jLwZIAla4RxhD61s47hvuAQc=
X-Google-Smtp-Source: ABdhPJykBK34HSDNuEExOj5PswzE1G8jMi/5K/0nsn1rodmf2p5QQgA9T0JNsjrPtdfQjvlMyoaxymcMxTUmvmisoS0=
X-Received: by 2002:a05:620a:718:: with SMTP id 24mr30441878qkc.121.1615901611988;
 Tue, 16 Mar 2021 06:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <1615886826-30844-1-git-send-email-shengjiu.wang@nxp.com> <20210316125839.GA4309@sirena.org.uk>
In-Reply-To: <20210316125839.GA4309@sirena.org.uk>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Tue, 16 Mar 2021 21:33:21 +0800
Message-ID: <CAA+D8APfpXvMby-rKKodcOZaJHHsE4sAtSYV9JW867MLZTvj5w@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: remove reset code from dai_probe
To:     Mark Brown <broonie@kernel.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>, alsa-devel@alsa-project.org,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 9:01 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Mar 16, 2021 at 05:27:06PM +0800, Shengjiu Wang wrote:
> > From: Viorel Suman <viorel.suman@nxp.com>
> >
> > SAI software reset is done in runtime resume,
> > there is no need to do it in fsl_sai_dai_probe.
>
> People can disable runtime PM in their configurations - do you not still
> need a reset on probe in case there's no runtime PM?  It'd probably make
> sense to factor the rest code out itno a function though.

Right, didn't consider the case of disable runtime PM.
Will move the reset code to a function.

Best regards
wang shengjiu
