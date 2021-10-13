Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330FE42B327
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 05:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237220AbhJMDMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 23:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237084AbhJMDMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 23:12:47 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3872C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 20:10:44 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id z15so886858qvj.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 20:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hF50jopThZcpb/r5CrV+DzJwIbUB5o6C3T/+nzD13DY=;
        b=JOc3Vzh7ZX1SboeRVjFtkEYohl4iZaI9Du8OEaD7eLsyeDWkakksUsYD2pY3gDE8rF
         vgoZQQDPYbe+acZsBZWgUDgX38DIQipV20UhBW+rvR8JWBocjTKY/WE4DI18jnLNH44D
         W4/ocbVJ//IM6nQ2H6MoRG0e/meXVS+FXfbKfgO22rTwVpbs+PbyUIuR8GoKU78T+m1H
         X9FjNCaevr/+tKl4oqJagKL2fwqJE1XHv6fI3gAKL84rEBazL8fcxS492aST5ksqY6mf
         m+y5tXGRL1EpdusgQbcWqaZN4cZ8QgHZaL02Lf1JaJ5+T0oQe7srpeW753zy4Se1/n/6
         jgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hF50jopThZcpb/r5CrV+DzJwIbUB5o6C3T/+nzD13DY=;
        b=AtI0ogj35bX/j7+gWMTJ+as/9N6hBmUU3NnzNIjFJUm83EWbFo0zzBWafdnRWfHrUS
         uRsHuX4LuvuBPDGYoS/wbiXYX1vHljqidZNwkMdN/jeLzgVj5bsK1Sdw4cVHF478yVwD
         TxIAhElRGV3MXPiq6PWLfpPBbX/AYe7Fu3chWUiKjKRdepSm5DQtVODMs37g2qOxO52d
         yWRp8bwrb7NRmrCu8sBYSAyH3XiTL9W2BvGZwOdLFEOp1o02thInLN0SkjDxHGXIf8Ys
         zDHWNX1ll0cmWjQ/8sl3ZFLMHgHVZxNwgnKb80k8FJDmY0ql24Lsv/bu+JWVVwF/d5pH
         JrcQ==
X-Gm-Message-State: AOAM532XZcEy6MAVFG3GlbjpgugVJCwm2eTx381iSY9JyH2841yR+9l+
        pNE4CEsKM0g/X3aXKC+AknzgK4u3cvzoS/q5fTY=
X-Google-Smtp-Source: ABdhPJyUCoEYf9vU1HZOfFPQGxlq27mKUv9xPE9tH/LsYkxkMJWAFI9sABP04eFMUavpXjRLqglJC0Gvu461dJnbPlE=
X-Received: by 2002:a05:6214:154d:: with SMTP id t13mr29391720qvw.40.1634094643983;
 Tue, 12 Oct 2021 20:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <1634036070-2671-1-git-send-email-shengjiu.wang@nxp.com> <YWVwk1kqyF+gzEC0@sirena.org.uk>
In-Reply-To: <YWVwk1kqyF+gzEC0@sirena.org.uk>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Wed, 13 Oct 2021 11:10:33 +0800
Message-ID: <CAA+D8ANNMURSAvCtmfoM6ReMQAQ+vgX5syYOy9C+C=-BXgw01Q@mail.gmail.com>
Subject: Re: [RESEND PATCH] ASoC: wm8960: Fix clock configuration on slave mode
To:     Mark Brown <broonie@kernel.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>, alsa-devel@alsa-project.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        patches@opensource.cirrus.com, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 7:26 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Oct 12, 2021 at 06:54:30PM +0800, Shengjiu Wang wrote:
> > There is a noise issue for 8kHz sample rate on slave mode.
> > Compared with master mode, the difference is the DACDIV
> > setting, after correcting the DACDIV, the noise is gone.
>
> Charles suggested some updates to the patch to improve the error
> reporting here which you don't seem to have addressed.

Sorry, it seems his mail is missing from gmail. I find
it in my outlook now.  Let me check his comments.

Best regards
Wang Shengjiu
