Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167E63BA757
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 07:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhGCFWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jul 2021 01:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhGCFWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jul 2021 01:22:39 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0A1C061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 22:20:05 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id a15so22069960lfr.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 22:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KkfFTkzroMO8Y2mqblgJTM4E3vzwDhk0iOI4E+0+OLc=;
        b=IbgKjuAUouHslaagWFyCZqxDjb97ZR8kFEGVsb1bHBBCGtieQxou5HnOJZku7amyPh
         1NOiHSsfWhVdoWvC3lxP2nxpHbNV3xPKUrpPYdH3lF/qxB9RSvo7IprypXYET+ET1voC
         HDH9KD4zv3pg6Fm7Tpke4Ugz87TYGfmELTjnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KkfFTkzroMO8Y2mqblgJTM4E3vzwDhk0iOI4E+0+OLc=;
        b=OhfEUH2V4YXOdBGhujy7kmq2h1JwswBIUKJ3m7KVYaqeP5NRIdeup9v9EaT1oAkqgz
         zjDCR+Po2cv+K8iacZmOQ4M+hGW+5YxZle6HgG4aZ6y8ObWRaAXHArXayq8WQk7BRYoc
         aiBL37E1r3DR5o1117wkywxtIrt2Pa6i1i2ZkmCdLmvKXN+5g3xjYF5m1vVLCjHhjNNQ
         2vrseWih4H3Bv0teTDfW/N5/LbRVmMM4/zpW4/chVzU/3JJ7d+/W0PPtDkKU2ueIehSP
         xFPw2ILZ6So37AM0b+8Kcyq9wCFHnKD5WHWNbF/guLb00h2ey5VsCchHNOP0G+NdRlrI
         2guQ==
X-Gm-Message-State: AOAM530nbnBd9r11ljOw8Ky2+OtZFbVgLL67hYysmtHh/0WtRpregAa3
        ANlzPZqrwtFa8dr8CipuZfNcvf7ohVK86tuU7P0=
X-Google-Smtp-Source: ABdhPJyp5vVwu5qJeLAIVuWurJzdV8AaOUAVbzEUajNR8vhPTC69pMdhQGD6kX9hiqBuzVe3TV440Q==
X-Received: by 2002:a05:6512:128d:: with SMTP id u13mr2311075lfs.471.1625289603514;
        Fri, 02 Jul 2021 22:20:03 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id n9sm455561lfl.69.2021.07.02.22.20.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 22:20:03 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id e3so7949231ljo.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 22:20:02 -0700 (PDT)
X-Received: by 2002:a2e:2201:: with SMTP id i1mr2239632lji.61.1625289602554;
 Fri, 02 Jul 2021 22:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <s5hbl7li0fe.wl-tiwai@suse.de> <CAHk-=wiTwX5mzzEcw3jk3QdW600Hntt=Ehgoyz8K-VU8zbEmBg@mail.gmail.com>
 <CAHk-=whhDWDsVz12mhKtnS6DG-GzVWxBk2XjoOp=gwNJ7T0bTw@mail.gmail.com>
In-Reply-To: <CAHk-=whhDWDsVz12mhKtnS6DG-GzVWxBk2XjoOp=gwNJ7T0bTw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Jul 2021 22:19:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wisOVeVpH42f6i5qW1gxtYxbRJQXvpt=mdVx+8p=w-yMg@mail.gmail.com>
Message-ID: <CAHk-=wisOVeVpH42f6i5qW1gxtYxbRJQXvpt=mdVx+8p=w-yMg@mail.gmail.com>
Subject: Re: [GIT PULL] sound updates for 5.14-rc1
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 2, 2021 at 9:37 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But I thought I'd report this as a likely candidate.

Confirmed. The watchdog hang bisects right down to commit 9ce650a75a3b
("ALSA: usb-audio: Reduce latency at playback start").

And reverting it on top of my tree also fixes the hang, so it's not
some bisection fluke.

I have no idea what is actually wrong with that commit, but it most
definitely is the problem, and I have reverted it in my tree so that I
can continue merging stuff tomorrow.

                 Linus
