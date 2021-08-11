Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29A43E946E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 17:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbhHKPUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 11:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbhHKPUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 11:20:09 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1998C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 08:19:45 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id az7so2736388qkb.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 08:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PTbZTB0OggPkXAxfHZ6VcjTpKi0pARGB5K9rQpw80Ro=;
        b=FqBrCE1C6bKWw4lmcwBR4rx6mFcqiMBN7iKQCz4ZMcW0+Yvah7IpY8WsGQ8xGinZFb
         v8MSypdJ4RlYSnsHekMoKjfsdntcqaPm9g7AJNSucqgB/kAspGIodBNXaCAJ5W21tPUf
         0J+ruriImy6cMSCdkp1m+UYWZw/8XJgK+b1UE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PTbZTB0OggPkXAxfHZ6VcjTpKi0pARGB5K9rQpw80Ro=;
        b=pVEPK8wN31B+4mnf/PqnOLSUeD8CR1fVf0G1qa+4DMXHeLLEOSMtkTMyGqhBrcduMs
         b+T0/bVENK5kZrYDONf+Y6L7vtmBSn88nRN3/oY71H9x5SQ5FanIG9AiuayzLdYO5AgG
         72NKrJF2yHgLrRbajKCkeKqNoHeYLKe2MTztDUD2DuBsSQdc0BfjP/ZyMVKtMZ8i/EMY
         Jvw8n1eFEntgUY+4yMOYmVR1vg+91qC2XDO+0RWf8L1qLIMBw44ZohO/sR0E2eadGDdT
         wzJHSQPB6I2OIhAcO9WpPYa54VAOBdncoivZGl5Mm/z7sAuduoy68rZwf3GBU+3+P4hr
         JH3w==
X-Gm-Message-State: AOAM5335eRZ7efMkFpTC99lQfZNGqbs6A4NuMSKKa+EjobKWZuFvtGSx
        UjBWQPh7lrGFceW/BQoMxApEmiYdrAsPmw==
X-Google-Smtp-Source: ABdhPJzNWubb3Z+hzVwaSW5jWXsqjVRG7fkfTCDxAvtlJNgrn2xJEOLwUh566R/MazAkWSN+ljcuJQ==
X-Received: by 2002:a05:620a:138b:: with SMTP id k11mr21974824qki.486.1628695184687;
        Wed, 11 Aug 2021 08:19:44 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id q6sm3041299qtr.91.2021.08.11.08.19.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 08:19:44 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id n15so4580351ybm.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 08:19:43 -0700 (PDT)
X-Received: by 2002:a25:ba44:: with SMTP id z4mr44554834ybj.476.1628695183483;
 Wed, 11 Aug 2021 08:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210810165850.1.I4a1d9aa5d99e05aeee15c2768db600158d76cab8@changeid>
 <CAE-0n50K+gAa0U9-kswTCdt+UAkxhuJ8BMg-D4sQayP1xqWTyQ@mail.gmail.com>
 <CAD=FV=VdjTYvLmKfGONCZhpbyrzM_tG7uXkm5==-X6-uO1gTVw@mail.gmail.com> <20210811150340.GG4167@sirena.org.uk>
In-Reply-To: <20210811150340.GG4167@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 11 Aug 2021 08:19:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W0rS0-EZQn3i1GxgYy2A4OhnMNk=W0WUSrFOssjnUOYw@mail.gmail.com>
Message-ID: <CAD=FV=W0rS0-EZQn3i1GxgYy2A4OhnMNk=W0WUSrFOssjnUOYw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: rt5682: Properly turn off regulators if wrong
 device ID
To:     Mark Brown <broonie@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
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

On Wed, Aug 11, 2021 at 8:04 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Aug 11, 2021 at 07:40:59AM -0700, Doug Anderson wrote:
> > On Tue, Aug 10, 2021 at 9:24 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> > > Nit: Add newline here.
>
> > How strongly do you feel about it? I purposely left the newline off to
> > try to tie the devm_add_action_or_reset() more closely to the
> > devm_regulator_bulk_get(). I wanted to make it more obvious that the
> > two of them were "together" and shouldn't be split up. That being
> > said, it's no skin off my teeth to add a newline if everyone likes it
> > better. ;-)
>
> TBH the newline looks off before I've got as far as reading the code.

Fair 'nuff. v2 is posted with the blank line.

https://lore.kernel.org/r/20210811081751.v2.1.I4a1d9aa5d99e05aeee15c2768db600158d76cab8@changeid/

-Doug
