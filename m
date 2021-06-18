Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A58D3ACC9D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 15:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbhFRNsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 09:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhFRNsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 09:48:04 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67696C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 06:45:54 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id f30so16851587lfj.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 06:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XfNYJ+Xn+C5TMgqTnynW/kGMKelbYeX7G34ZtzwiY5Q=;
        b=aBPIlY3B3I9t/Bb6QizL4BO5Uq5daVIAP8ONYx5ejAWYGtn30nVkpE0OuIVcL86v01
         OEBuLWueTYTM9LFN9UIgL9wNhfbb8ogyeyCqo8cecTttf4aS2yJ3+52ZIidumG6M8Ro4
         93D97EcFwSVRDWL3NPu2KsxpdOerwF9y082vpSCcTehIxCOMzDP3stZ5VMKT4LP4eT4w
         73VGEC+UfPT8whVbC4r4se+RdL+lhSgRu2z7uf5GtLcRfZkRlsIq10lauq8+jOQOUYYT
         dROJmsjNGNRPd0+BwK4JywdLER7UxRZscAl3t90tB7VJoMqLKO3B2Sn60BTbbXA8d6fh
         FDjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XfNYJ+Xn+C5TMgqTnynW/kGMKelbYeX7G34ZtzwiY5Q=;
        b=UVQVwdHEWg92tAzxR/JnzMkCQTcJcsdx6alj3gV5cwo0CueLoXJOkR/HTeQZUl2P6/
         n0IG/JmSsufEyMZpzEQG5nKwrPpqQKr8SASVuimoibfXIwq09oOZH4aXM7dXMOeWE6cG
         cluZ4tjpOtyauMvtHBA/J03PsyD9jt+a94XzjAL/hN2SZXT2UMjqLWTp043KkRndPFRt
         n5KzZ34HhuplkOd0P90RQHeWqS17j6vIqhvq1mDFSYvH87zsCOUPJk1nqXntZYGBNtUB
         vDBxR7xVBQDC8gcU3ZLw8e0gXJWD4j8QtVuXudypqMVkbDTl2sXtkX5nVeAiDkiJtSHY
         QnZw==
X-Gm-Message-State: AOAM531WpE7OvxSAsdPQ2eAPNOTqOzjvRh6Zi24nHmf8lArWcMXu58c9
        xHPh4/S5VbuEdwgWvHreKj+PKjeyymlLNI5TUB0=
X-Google-Smtp-Source: ABdhPJzKUBlUCXaM4pDSgkd4knQq1miSg0a6/u1XLmU7lhiJg2ED3RTISV+7tMeKeWIckVS/fKdebCodLrTRUdeZKXg=
X-Received: by 2002:ac2:4d25:: with SMTP id h5mr3212910lfk.583.1624023952748;
 Fri, 18 Jun 2021 06:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <1624019913-3380-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1624019913-3380-1-git-send-email-shengjiu.wang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 18 Jun 2021 10:45:41 -0300
Message-ID: <CAOMZO5Ao9FipZQQ4oVK=1SFJ=24EPoUfybHMFE7dSpUAR3pLAA@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: fsl_xcvr: disable all interrupts when suspend happens
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

On Fri, Jun 18, 2021 at 9:57 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> There is an unhandled interrupt after suspend, which cause endless
> interrupt when system resume, so system may hang.
>
> Disable all interrupts in runtime suspend callback to avoid above
> issue.
>
> Fixes: 28564486866f ("ASoC: fsl_xcvr: Add XCVR ASoC CPU DAI driver")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
> changes in v2:
> - Add Fixes tag
> - Add comments for the change

Reviewed-by: Fabio Estevam <festevam@gmail.com>
