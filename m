Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A834539984F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 04:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhFCC6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 22:58:07 -0400
Received: from mail-qv1-f41.google.com ([209.85.219.41]:42861 "EHLO
        mail-qv1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhFCC6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 22:58:06 -0400
Received: by mail-qv1-f41.google.com with SMTP id u33so2501272qvf.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 19:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L3qETxpua5Szzx3IugrqwdN2RVBVS+htIlKHHGHgjcE=;
        b=lAu355Dg9iol96NUognh3Z9XUcRdsebrjJDTLIdA0MB3bNopNWwQxCdRUYRX5sAb/Y
         cGUf0l8eVRCedzkRA6AGkEjrkmrHlWSm7nvbhYMMLu9iMNPphZ5SZ/a+Bpa5bo1aiYEo
         dIE2o8o3V3yvHP9fvL9p26aKPWF1n1rF1uiUk/ohboF9EEsQGAsVDBlQW58TXUp3RdAv
         Fvk6VaayMCGK4kT7U63ylfbABmr93wlLZ8IEFKsunB8FgRlvW0igaOt4Ss15ZGYruu2R
         oc0Y44YuKWQTykQrCrMj0huXHvbxsxHM3HDo28txiTevaaW241YRYpyfEsHTd6HFCrO+
         puLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L3qETxpua5Szzx3IugrqwdN2RVBVS+htIlKHHGHgjcE=;
        b=RG1M99QwY7MpAxLKmXMJThSD9eJ6feuU8J2jZ8wZvjAYgkqFl66rXnoyWbXEh6BwJW
         MIn8oDKwLiKf+qf17AzcgQ4y7NzPlEvFD/P8vIOBstmtTQt87yKjZjjOc759Y11tFqAo
         Rz8IWRxguhOMNimM3UkZUz966zSYlwond16gDiADQvCuVFynjv8M5RVVIWUeCwAG+GZb
         FnfZK0a2xhVJhS9k8rwX5lgm67QTQ55+B+GwtDMc5zfiQzNZg6gwMS2vku8sFo0KF7pi
         PLxjJqAp2hV+52LX/KYxe+iI7Ohjq//jjy9Rq6AGeFQ/DjqYOIQgS+0ThnUx108xKqHv
         T6Wg==
X-Gm-Message-State: AOAM531jVjjLkpjju80bghCBgJBweGciE23gxIVGtViH3TgmZTBvP0ny
        /HSR9KkWa29KPtdEGYUYExUbCuoykhKmzugC98M=
X-Google-Smtp-Source: ABdhPJxezezpVM5btuESQMr8sQAiEXZQElm22pIaMrpGjdBnAbnRFJ9jW78E4wHzQhgfJltscBSnDG0cUu3iIS9EoZk=
X-Received: by 2002:a0c:dc92:: with SMTP id n18mr8866816qvk.8.1622688907466;
 Wed, 02 Jun 2021 19:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <1622616132-10391-1-git-send-email-shengjiu.wang@nxp.com> <CAOMZO5An-v0mLAvjofiWLc4ufJiE4EzG1b4NDwToPSvgODrHjQ@mail.gmail.com>
In-Reply-To: <CAOMZO5An-v0mLAvjofiWLc4ufJiE4EzG1b4NDwToPSvgODrHjQ@mail.gmail.com>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Thu, 3 Jun 2021 10:54:56 +0800
Message-ID: <CAA+D8AMYmy=NdQU+9gTwa_7j23kmxgU1Xj-pkzuHPCNX649iYQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: change dev_err to dev_dbg for defer probe
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 2, 2021 at 11:45 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Shengjiu,
>
> On Wed, Jun 2, 2021 at 3:59 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
> >
> > Don't need to print error message for defer probe
> ...
> >         if (!fsl_asoc_card_is_ac97(priv) && !codec_dev) {
> > -               dev_err(&pdev->dev, "failed to find codec device\n");
> > +               dev_dbg(&pdev->dev, "failed to find codec device\n");
>
> You may consider using dev_err_probe() here, which fits exactly this purpose.

ok, let me update it.

best regards
wang shengjiu
