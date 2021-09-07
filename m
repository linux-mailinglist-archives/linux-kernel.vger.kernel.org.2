Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54349402251
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 04:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhIGCoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 22:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhIGCon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 22:44:43 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB1FC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 19:43:37 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id ew6so4981905qvb.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 19:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q8EAvjumu/OJAeJcXbA7H2hzcYUuPTK9t0l5alooUiY=;
        b=Pmo+uYbbkBqdBVNpqse5shcoez2d/H1Qcdv6h/Vy8RLiSqPrt8ejRjpujP6T4rMWVF
         nEHi0dy/D8Lh6jma63/OfIqutDyThbpRrGfGBDeYn2EziRF76UZ0vJwEtdvXsFaIedOU
         5/7HSqX1DusB+O1PybFEHlRET0OpfZqdnUjZRSXKbOaHTl71kmakb0Db4Xk3Ag/uotCK
         EsieL1LsCU4XtvjH/axVR/XfGyr68lBQ+SyJR0Ibp3l+odmIUi4leYeW5V6R0+nTTRhm
         tuP220jYFGk/ksKx0KA8KsvNZbO3lLUNu5bLE4wcIQ2HNA3NlXQhG4f1SRYueNRTagEh
         IE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q8EAvjumu/OJAeJcXbA7H2hzcYUuPTK9t0l5alooUiY=;
        b=JscD0tL2NIu9t6UI81DjvV5bZDj6BXEopdfZrAJcOvOvd1Cbn+ZrgJ5Ow/IJh/H2Oe
         zoGWFbAiKVlcILk47KilghxcvnqzUiaIlWpQ0woQmrBElfWJ4hFB/RXD8Wwj/2mdiXSW
         3GPUeUYVZb9rsHUcCV/0Xg7+5/pgfzkQASdglKCFFc5Src1EC5zZKfmB9z+8MvCsamWT
         E5mvlMP6pYn06+eJ/XwaO+ZEvTgRVrKmfsRf7tUENgwOgolwe8WHt3cXWXtYvI+5wuI2
         QmDSTXIG3hurRZWEYhg7TvCzhGiNJTy/9I3qzag8N2ZzHjn3VthmuTQ0HFT41KZU13Kb
         /Sww==
X-Gm-Message-State: AOAM530O1gyrq8Jr8+ICxwMiULV9am11k5cAwZlAAWhCTEz4betRRGma
        +yV81WCpaoPC4dbw3dKHS5wRyZ0fN8k0IIyBfs5bJrAbRyA=
X-Google-Smtp-Source: ABdhPJyjPbrX3ue83Z7GFZ6Rrf6Te85hNnUz2Ud9JAzgWqPZ2jaz9QxhFZQk5FOxkPsinhqn+KuRgte7q2aYk1iO95g=
X-Received: by 2002:a05:6214:11e5:: with SMTP id e5mr1131874qvu.55.1630982616853;
 Mon, 06 Sep 2021 19:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <1630665006-31437-1-git-send-email-shengjiu.wang@nxp.com> <20210906114701.GC4309@sirena.org.uk>
In-Reply-To: <20210906114701.GC4309@sirena.org.uk>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Tue, 7 Sep 2021 10:43:26 +0800
Message-ID: <CAA+D8APjyq74FECmH6ZzyVKHOz6MEV0bt+D4-Xkfc-6C5n9hZg@mail.gmail.com>
Subject: Re: [PATCH for-5.15 0/5] ASoC: fsl: register platform component
 before registering cpu dai
To:     Mark Brown <broonie@kernel.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>, alsa-devel@alsa-project.org,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark

On Mon, Sep 6, 2021 at 7:48 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Sep 03, 2021 at 06:30:01PM +0800, Shengjiu Wang wrote:
>
> > There is no defer probe when adding platform component to
> > snd_soc_pcm_runtime(rtd), the code is in snd_soc_add_pcm_runtime()
>
> ...
>
> > So if the platform component is not ready at that time, then the
> > sound card still registered successfully, but platform component
> > is empty, the sound card can't be used.
>
> This sounds like a bug which should be fixed there?

It is hard.

In cpu dai driver we always register two components, one is for
cpu dai, another is for platform, so for sound card platform and
cpu share the same node.

        /* Find PLATFORM from registered PLATFORMs */
        for_each_link_platforms(dai_link, i, platform) {
                for_each_component(component) {
                        if (!snd_soc_is_matching_component(platform, component))
                                continue;

                        snd_soc_rtd_add_component(rtd, component);
                }
        }

Above code in snd_soc_add_pcm_runtime() checks components
for the platform,  because there are two components for the node,
the first one is the component of cpu dai, which is added by
registering dai, it is already added in the beginning,  so it is
duplicated,  but the second one (which is for platform) is not ready,
then issue happens.

It is hard to add conditions here for defer probe.  And maybe
some drivers need the same components for cpu and platform.
Do you have any suggestions?

(The easy way is to fix in each drivers:))

Best Regards
Wang Shengjiu
