Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69958314B60
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 10:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhBIJVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 04:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbhBIJRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 04:17:10 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEB4C06178C;
        Tue,  9 Feb 2021 01:16:27 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id e11so12432419qtg.6;
        Tue, 09 Feb 2021 01:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UCCWDHu0sYSquKe4LwEXk0kUehGPBZCaQ+gPrhz2B70=;
        b=tnKURcRDMsX6KiDYyAtN3ScVm4Xp3sVDTWZQKtuJnUh3KGUrksRRRmet2qx+mEjT1Y
         Zgpj6m0XBE1jPTA/ISmoEhBqNEGLjcjfrYz9RYjjbdW1bOVkR8WJUvBwwXuH2XYBv1Ot
         cD4e4JVB5h00iD4b8COz3OM4fX1NmMfXTeFPG7F64PuyWj/VNJT579c9TP9OZ/sKetnY
         UL4jEkoesboHATyk8jB+ZuwLqHUgiBemu1v9dn8CLnNNA6GLG13X+YYI3Qmf480tNcTW
         e1CuEtTNIEXMrXK6Z911F09dY/V4GuXNrk8TlhuoseP0TL/3s0Jy+jXl4EcYNLKnK06X
         dHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UCCWDHu0sYSquKe4LwEXk0kUehGPBZCaQ+gPrhz2B70=;
        b=NSIWN7n0M1QImOZQsHbLt0TH7fSZp+G8uLqTEZlRkWvllrXNwIMroi774hBzX1iqo3
         CkUq0rh+5xDtIFv9VruPxzIHMDgRaBfOwQaBTAN2hYRL7wtnY/csdroQrQ2Z2bLheTOw
         NGnr4rsQg4z8w1ZvmAHEByISbJNddc4ALynAGYufRuNXhZa0AyiGN7N8jFBH52POv5qK
         d//h9B+YNFlMh1CdJt7bAn5QZsa042YCa0ydBwLjgQ8Qyg/RzwiYi0mVApG0vTExlkWO
         NDmDEAGoe31Z2DdCi9ZDccnHbQmNt4xLToARx1CUbqbl2LbKnAEI1xt/wRHxpbOtF9nu
         92CA==
X-Gm-Message-State: AOAM533ajX9Zrf/k1ubNM24ie6s0JntH5cNlbqvacqJdnsyX/Cs2+uv7
        i6sYhdJ5y/0Ul9Q/3aFt3XFrmlxJ7qyJwdNac4AxMt88
X-Google-Smtp-Source: ABdhPJxk7JApErbcYd9iIq2ywHmycgjkc6ZN9v2FM3gZNbGEGB6G4khg1FgLHMytyhFDNZEL3y9l+4+oq0VpDadZElI=
X-Received: by 2002:ac8:4e8b:: with SMTP id 11mr18524155qtp.292.1612862187116;
 Tue, 09 Feb 2021 01:16:27 -0800 (PST)
MIME-Version: 1.0
References: <1612693435-31418-1-git-send-email-shengjiu.wang@nxp.com>
 <1612693435-31418-3-git-send-email-shengjiu.wang@nxp.com> <20210208115112.GD8645@sirena.org.uk>
In-Reply-To: <20210208115112.GD8645@sirena.org.uk>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Tue, 9 Feb 2021 17:16:16 +0800
Message-ID: <CAA+D8AMRGRRk6FzdiqaHAP1=dPJngNgmdGmU59vrroXA9BMyXw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] ASoC: fsl_rpmsg: Add CPU DAI driver for audio base
 on rpmsg
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

On Mon, Feb 8, 2021 at 7:53 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Sun, Feb 07, 2021 at 06:23:50PM +0800, Shengjiu Wang wrote:
>
> > +static int fsl_rpmsg_hw_params(struct snd_pcm_substream *substream,
> > +                            struct snd_pcm_hw_params *params,
> > +                            struct snd_soc_dai *dai)
> > +{
>
> ...
>
> > +     ret = clk_prepare_enable(rpmsg->mclk);
> > +     if (ret)
> > +             dev_err(dai->dev, "failed to enable mclk: %d\n", ret);
> > +
> > +     return ret;
> > +}
> > +
> > +static int fsl_rpmsg_hw_free(struct snd_pcm_substream *substream,
> > +                          struct snd_soc_dai *dai)
> > +{
> > +     struct fsl_rpmsg *rpmsg = snd_soc_dai_get_drvdata(dai);
> > +
> > +     clk_disable_unprepare(rpmsg->mclk);
>
> hw_params() can be called multiple times and there's no need for it to
> be balanced with hw_free(), I'd move this to a different callback (DAPM
> should work well).

Which callback should I use? Is there an example?

best regards
wang shengjiu
