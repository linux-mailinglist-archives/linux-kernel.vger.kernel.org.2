Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F474398F23
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbhFBPqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbhFBPqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:46:07 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1874CC06138F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 08:44:02 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id f30so4134844lfj.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 08:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OBblrHGCs55cViW00rNijqacDYoorI2gMf91bLN8H6A=;
        b=VstgI3Ch9IUJL9QEJ7w2wz1Y5FqrOIB5LeLRPYhI+Y+BW3jN0++iSF7+3gaFX0A/sD
         RKgw8wEnssMKzm8dlJHQYhh2CRYsTi1G3Mid27IGhB34PujdNlv2V5DXn0LJPRiaVfYh
         Zk93v5k0AldhWQ6prr+RBo9gkfik8nlv7GFHFPfjnrAMuH74yHNILeeDTwhmkq4DKVba
         +ZtthrbaGwljl5F0ZDVVw6qLajvIPWu38YgA35tvnX6sCE2+LE6Njxw6N28L7t6OqYx/
         ruHTrgpVUz9kgqtx6Pw2ExDIOOyhOGBfMnpM7g/3adZgEoPgVWR3Pewt51pfjCiHn3qT
         oY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OBblrHGCs55cViW00rNijqacDYoorI2gMf91bLN8H6A=;
        b=FvTMhXUVEo5WftqzhrozsAOQ6OexrSbudA71Wi8ymy+8xWUERjJErjqGS92qyR1amt
         4enfbMzk9CZu+/VdhwAGSeIfPLb4zlsbUidDjxNUIKx4Bwhqi8M5zTuhUSc3OE11zLO7
         epZgn3dNJMiPyV9R4vtBbaRmn+FmVE/1ncOJs8gIU7dDQbXhe8cUxBbx0rwj8ylSpQfg
         5JHDAg+jad5IDsd0cWkv0Ti9iO7lVq35KTRkgutNiYNO7FxGWaft7eAA2QdKKglPY/xX
         txujmBmxHJ6W37bsImuYBcXbul5RBCh0SaOeNrZAIPS3cscZ7Hbm0WvVTYG/eZGxmsex
         079w==
X-Gm-Message-State: AOAM531dM578YvK4ndtSxZ5fdMGOepldWVZRC+zJdMrWLj/dtjt0eZEF
        w79wP48gIFnmSywA8+nzANvC03Vda8VCZr74HNU=
X-Google-Smtp-Source: ABdhPJzdK7pAHWYASLkeaOmnuhJjmfN6soue4SZRfA3dMZz+X3wo1Jhzd9myvH2AuzGDmUg82lgYxpIsOTh6tU5E6hg=
X-Received: by 2002:ac2:51a9:: with SMTP id f9mr5025625lfk.223.1622648641044;
 Wed, 02 Jun 2021 08:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <1622616132-10391-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1622616132-10391-1-git-send-email-shengjiu.wang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 2 Jun 2021 12:43:49 -0300
Message-ID: <CAOMZO5An-v0mLAvjofiWLc4ufJiE4EzG1b4NDwToPSvgODrHjQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: change dev_err to dev_dbg for defer probe
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shengjiu,

On Wed, Jun 2, 2021 at 3:59 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> Don't need to print error message for defer probe
...
>         if (!fsl_asoc_card_is_ac97(priv) && !codec_dev) {
> -               dev_err(&pdev->dev, "failed to find codec device\n");
> +               dev_dbg(&pdev->dev, "failed to find codec device\n");

You may consider using dev_err_probe() here, which fits exactly this purpose.
