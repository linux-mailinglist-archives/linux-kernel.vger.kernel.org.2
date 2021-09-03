Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287043FFBBC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 10:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348242AbhICISg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 04:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348231AbhICIS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 04:18:28 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57398C061575;
        Fri,  3 Sep 2021 01:17:29 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id k24so4830737pgh.8;
        Fri, 03 Sep 2021 01:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zAeC81KUlAnRYRLFkJk3KLXL9sj5AZ7x5m11QJb5mho=;
        b=n9PpkIC0IKaP59gxBQpmGUOJHg8z3DFqkYNEvh9rkNki2UuDdyKlYBjdrN7QlNYGjG
         X+yifB0u26HelBa5jnANffOS4IXQmI5yrd0AEYgYTFOnVah+k/ekKsHPdtswzqFyu7od
         4imWsIA36JvhNj+PB0hOTMZXJeZz3r5aHdoVWqWY3ct/lVPolYmaZRQa6lzQI0fXmB81
         RWan4tguzbbnv1uQ4Wcv/sCIKRMC7kvsR0T7/vV8LGivLHXrCmYjlbAxTu5tBGJKDsCp
         M2eHfXbdWlMVCEhQF3La5hNJ8uPvLrASOCofl8wdEnX48s+Wqos7q8kUAE2lw4vUazmK
         6bCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zAeC81KUlAnRYRLFkJk3KLXL9sj5AZ7x5m11QJb5mho=;
        b=n3aktb99bFExvSih2HCIHZgAk9x50ylqjGazruRQs+84ZA3qkVsMsm3JANNIjhU3f2
         OprNZGBmYhWp2bjo1cmn9wK7XBGExHluubR+83vFp420c9bFAIFfHuOyaRsdRT8/qKph
         BPbqajPxmLpAIX81bydmNoKI4whRptqun4hG3eCTfaWq/5VU4Nj6VmzWjfp9V/wrKhDz
         o4D9uaii7wL44QSBvxfkQKq0alIgWiCMyZ3VggosRQT/Ka1UBDtTBG5x1XpDybztd+6P
         8gkfV9Q1gIZDBSnuOjuxCWh81WUm8lriE56cxQIXKG8rFuy9jRBBm4Xo/AQ1or1Od2JT
         32Kw==
X-Gm-Message-State: AOAM53187piRzMFJWezvPugAsEQknWgPFIsLskFeQUqOpo0MHsBTaEKl
        au3QmjXmRUmcj6TwN+Ajq1fPxDs1isntmV5gIxfvjjRHbe4XuA==
X-Google-Smtp-Source: ABdhPJzvwTggkNf9YhTyZ3ARwr277fUCscEsy54Q9WJxOIhW0MYZUQq9mzsnRCZIiHeVo8SGR5ZdC9hzT1FtVwpHyiA=
X-Received: by 2002:a65:5a81:: with SMTP id c1mr2578227pgt.74.1630657048948;
 Fri, 03 Sep 2021 01:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1630632805.git.atafalla@dnyon.com>
In-Reply-To: <cover.1630632805.git.atafalla@dnyon.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 3 Sep 2021 11:16:52 +0300
Message-ID: <CAHp75VdOw7fS055q9eccm9dP9nuAK8rcLXf4vuzA=-UnbqoUfQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Add reset-gpios handling for max98927
To:     Alejandro <atafalla@dnyon.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 3, 2021 at 4:51 AM Alejandro <atafalla@dnyon.com> wrote:
>
> The max98927 codec on some devices (i.e. Xiaomi Mi A2 Lite phone) require

requires

> hardware-resetting the codec by driving a reset-gpio. This series add

adds

> support for it through an optional reset-gpios property.

Where is the  changelog?

>
> Alejandro Tafalla (2):
>   ASoC: max98927: Handle reset gpio when probing i2c
>   dt-bindings: sound: max98927: Add reset-gpios optional property
>
>  .../devicetree/bindings/sound/max9892x.txt         |  3 +++
>  sound/soc/codecs/max98927.c                        | 14 ++++++++++++++
>  2 files changed, 17 insertions(+)
>
> --
> 2.33.0
>


-- 
With Best Regards,
Andy Shevchenko
