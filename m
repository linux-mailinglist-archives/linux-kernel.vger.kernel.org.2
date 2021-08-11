Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1748D3E93CA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 16:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbhHKOlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 10:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbhHKOlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 10:41:37 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43481C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 07:41:14 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id kl2so1230619qvb.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 07:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=woz6rh43vQuyI5ixWRzgN4oCrQUNRAIALrBLaN/K7qo=;
        b=E1ueDDxsTSx2qzVSyxsOzrux23LFqyPTmzNUp59VgAkT5ipHwksITT5ySPwBN3j5jI
         Ky8NehEabNtPsqMTK3UmCumvjNVMWPQf8JXDOvVTV9v7VUeDF4c2UwkC/MPtAhddyuZF
         NMQDhdBHWJR0+eRzEyhkNCGxvsbPMV0/yD36s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=woz6rh43vQuyI5ixWRzgN4oCrQUNRAIALrBLaN/K7qo=;
        b=gvecADs31gCI5WUTn7xE3ybvSUgSGtlcU2WzIn9RJozWaC/Fn1D74cuLZplEpqFMwG
         r03k+OI0Jh49l/nR7PG7h6Cv64bZgS5SjaKIGuNCZ8fEFQ8iqloAIsGoJGYeq2Doyug+
         MWAlQjGMYkJJZ9fzwfs8N45X+i6HbbnOMitFQ5/r/AppxqfJc3uXy3Qzoeoyxcb/bNs7
         LNFchgCm9VwL1rXZlen08YDnzZQu4UjCVx4Dj8pv/MpGQTjoFXGr5QF1jR8BeHZnZO3B
         6LkrGG3ez2+kX6dxhxWN535wMQ8BW97qP41qxPN/kJ0bVLdpMlFRKrybMnfuUpuU5KuU
         AadQ==
X-Gm-Message-State: AOAM530Xe+3ooAbYVBk5alR/532tDaHq1Ucdy1PQ1i9RxOXo0kxvx3sX
        32mPuOBkhYg3REMcWdPq0nEqHAkt7FhSeg==
X-Google-Smtp-Source: ABdhPJxQI6t8FA7XyVQOdgz2Tm5Xa06tDl8K2lX/NM3J2yZOEIV6PJre1cR5fsBgmKDPb180LrMttw==
X-Received: by 2002:a05:6214:20e4:: with SMTP id 4mr21158954qvk.18.1628692873008;
        Wed, 11 Aug 2021 07:41:13 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id t64sm12685233qkd.71.2021.08.11.07.41.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 07:41:11 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id w17so5050528ybl.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 07:41:11 -0700 (PDT)
X-Received: by 2002:a25:ba44:: with SMTP id z4mr44332481ybj.476.1628692871281;
 Wed, 11 Aug 2021 07:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210810165850.1.I4a1d9aa5d99e05aeee15c2768db600158d76cab8@changeid>
 <CAE-0n50K+gAa0U9-kswTCdt+UAkxhuJ8BMg-D4sQayP1xqWTyQ@mail.gmail.com>
In-Reply-To: <CAE-0n50K+gAa0U9-kswTCdt+UAkxhuJ8BMg-D4sQayP1xqWTyQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 11 Aug 2021 07:40:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VdjTYvLmKfGONCZhpbyrzM_tG7uXkm5==-X6-uO1gTVw@mail.gmail.com>
Message-ID: <CAD=FV=VdjTYvLmKfGONCZhpbyrzM_tG7uXkm5==-X6-uO1gTVw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: rt5682: Properly turn off regulators if wrong
 device ID
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Bard Liao <bardliao@realtek.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 10, 2021 at 9:24 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> > @@ -156,6 +163,10 @@ static int rt5682_i2c_probe(struct i2c_client *i2c,
> >                 dev_err(&i2c->dev, "Failed to request supplies: %d\n", ret);
> >                 return ret;
> >         }
>
> Nit: Add newline here.

How strongly do you feel about it? I purposely left the newline off to
try to tie the devm_add_action_or_reset() more closely to the
devm_regulator_bulk_get(). I wanted to make it more obvious that the
two of them were "together" and shouldn't be split up. That being
said, it's no skin off my teeth to add a newline if everyone likes it
better. ;-)

> > +       ret = devm_add_action_or_reset(&i2c->dev, rt5682_i2c_disable_regulators,
> > +                                      rt5682);
> > +       if (ret)
> > +               return ret;
