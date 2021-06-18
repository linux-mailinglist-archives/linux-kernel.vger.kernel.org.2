Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC713AC9B7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 13:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbhFRLXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 07:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbhFRLXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 07:23:00 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE48C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 04:20:51 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id j2so16104398lfg.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 04:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hnZIrqamucMgtoQRhalXW35f06vviRSLKNiJcGvVIRY=;
        b=PR0QsGfN3ZzRnmtP2GvpRBUfh1fS2bB3MVYoqYFIfQ5y3OtmE1H4Bi5MkHfwqNstN+
         sIdovZvPvvNyNOOE84n6c+/whP9ME8CgCVKNDFDjbmCLV/SJ/Osrr5Dk9vUiGGGnRgDT
         Ulj6kyWju4RyjfaUCvhazK66qs0HhwQiFm/0qOB73JXbK8ooV/OSn1wJ3huEN347SYDR
         g7efyEFPYMBD3p1dbqv+kUsjK5w+L+Ckz33klkhIfqGxyD2HDtU2rRw3BvWSw+bnjNdW
         UQMvQqLSCSV/OqCc61vs4BlSEazhXwNbCMfH6PNCYuVL6dI6ovqzpBzkfjzQve886+lL
         VksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hnZIrqamucMgtoQRhalXW35f06vviRSLKNiJcGvVIRY=;
        b=Ik5cGo2fePRA+SDi6bd3l4GVvwKIIgl4jWqrboUVBGbh3EmVOpkj8f43nYe2ZdM0aX
         d6ne8w/6Y/DN+HfIiUL9ulM8yy9rDzR2f4chEsOjbVCig81xJnk1jTMSwzgjYxqpi9AD
         hYguH8+44PDpndFfvshHYXzirFsza703xqBPLfZi3Ws1Kivk0NSt6OlSFNz8Siy8XZau
         xcYL1DnFXGZ+kAE99twpefDEBVgBlPi0vQZVOFdTqf9bRezD7wgrwbZkXB3B+hPJOuU6
         3e5TO2HGIaBstXkf6hhA5xxHDkmbgyT9wYvHkonFEzlpdJBVFLsdI7Cfex3P2zezDeyt
         94hw==
X-Gm-Message-State: AOAM531nkyC8tre38yJ8f6kkNkBx5c2Yseg+ppC6xIEiRgl15svz3tgk
        sx/JMk7DRr9BbUuStl1eVQ+dQT0GfZSxfcKjICU=
X-Google-Smtp-Source: ABdhPJyIeUNC0wnC3kJcXj8pUsII7RDjnztdAY6DS/4xUuhjoSVZ1NjwJYq3BaF++8TyxD1naFh8F7l7is0XL2Dbiq8=
X-Received: by 2002:a05:6512:15a4:: with SMTP id bp36mr2830068lfb.539.1624015249338;
 Fri, 18 Jun 2021 04:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <1624009876-3076-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1624009876-3076-1-git-send-email-shengjiu.wang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 18 Jun 2021 08:20:38 -0300
Message-ID: <CAOMZO5DYLZmz6f0yjrOpaL4B_wicq0ofrYpW6QqzNPEc0j407Q@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_xcvr: disable all interrupts when suspend happens
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
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

On Fri, Jun 18, 2021 at 7:10 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> There is an unhandled interrupt after suspend, which cause endless
> interrupt when system resume, so system may hang.
>
> Disable all interrupts in runtime suspend callback to avoid above
> issue.

Fixe tag?

> +       ret = regmap_update_bits(xcvr->regmap, FSL_XCVR_EXT_IER0,
> +                                FSL_XCVR_IRQ_EARC_ALL, 0);
> +       if (ret < 0)
> +               dev_err(dev, "Failed to clear IER0: %d\n", ret);
> +

The operations in _suspend() are usually balanced with the ones in _resume().

Shouldn't you enable the interrupts in resume() then?

I see that the interrupts are currently enabled inside fsl_xcvr_prepare().
