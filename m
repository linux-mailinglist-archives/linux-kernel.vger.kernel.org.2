Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2D331239A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 11:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhBGKjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 05:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhBGKig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 05:38:36 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A0BC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 02:37:55 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id t63so11651086qkc.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 02:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ap599Dj3UpmjlEExN+HPHzrzAs5oC97knPOjfcxhqlY=;
        b=noTNyG5dIpQ78mlmDpVRKXocG/8cU9E2dPSLHCT5u/6AM93GxMkWseSTmtZluCtC1u
         yE5ODBsUkFhPI+cAMajSBteIYEvsPPYS2ZOtmyoTeKzwGhR7jp9fcNyFARH6i5nGTgpM
         dXIUcSDU2sqxPlveeuN7AeubyOYqy1+xDMckILo7G5EztOQHSa2bumrX7mmH8ejtOICW
         XS95baFArQRo5qKEytXkao+wg+G9gdoie0IJ0DfySUx7NitTkJDB6K8qIQmqJgQy9EoB
         obvTdTIw4DgJAEPX0FRe4xg6xXY8KwR5bXv2W6RpikxELGJHmk5gHyO3qR8Ly8FQACVJ
         ns7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ap599Dj3UpmjlEExN+HPHzrzAs5oC97knPOjfcxhqlY=;
        b=WJKsVep4Ut9u5GV5MU7DVj0ICmr3eTG8FBUMGt4bpSx3Vh8jkKzyK+9UybGukzSVop
         J4MHNXRSoroX6oa0X2lBkqGz1VSlpL2DJ+xZqzAYfFO3EgX4HyTXdGxRc48tRFI7zk5O
         VsTe9rH6nl2Gpa1hSTkrVVzHFx2TqeLP70DhxR+pugRFEcMqq8/68YGty+FUqCD6VqJd
         BmDgdB+7hnhUhe7k3Tw0xdCLz79JaYIuSdEAkW0mMPp0M3uHil0mtUaHnps+ubAjxcLR
         YKdagZ51tjA8LgSCAZVEgiq4JP1oP1hb8k+XbJH1wVrFv8/39jRv1KU+agRGEbVSD4RM
         G0lw==
X-Gm-Message-State: AOAM532puJJAqu2zeOXdtlQkDMQCtIYjyhCQ2TL548xr8Ul0DhTPp4Q/
        lXBGYFf6r46856uP2Kb7QK8QSunfIp/kHYBhwP0=
X-Google-Smtp-Source: ABdhPJwOiqCntMvtBeLH6QTT4MVjMi7lbWFN3oPd96+54QjdFnCmwrjWuqmBTwR2S2IpLCGHI53PWyxqwimbdTER1/I=
X-Received: by 2002:a37:a955:: with SMTP id s82mr12230755qke.121.1612694274969;
 Sun, 07 Feb 2021 02:37:54 -0800 (PST)
MIME-Version: 1.0
References: <20210206225849.51071-1-rikard.falkeborn@gmail.com>
In-Reply-To: <20210206225849.51071-1-rikard.falkeborn@gmail.com>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Sun, 7 Feb 2021 18:37:44 +0800
Message-ID: <CAA+D8AP4gfZ2FzTH2LOB7H0SRCYR0TBrAKLZPgpTUYq=bp0M9Q@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl: constify static snd_soc_dai_ops structs
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 7, 2021 at 6:58 AM Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:
>
> The only usage of these is to assign their address to the 'ops' field in
> the snd_soc_dai_driver struct, which is a pointer to const. Make them
> const to allow the compiler to put them in read-only memory.
>
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>
