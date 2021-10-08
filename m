Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD003426A15
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 13:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242982AbhJHLtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 07:49:23 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:51239 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242880AbhJHLr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 07:47:58 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N7AEs-1mpUBR464C-017Tsv for <linux-kernel@vger.kernel.org>; Fri, 08 Oct
 2021 13:46:02 +0200
Received: by mail-wr1-f50.google.com with SMTP id t8so29118571wri.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 04:46:01 -0700 (PDT)
X-Gm-Message-State: AOAM5325/qBWdybYF81mMoVJQxIkXJHfvZWj1/b00DQdrDupZij9/Ynv
        sYBRDjleArPqQtMtHSQO76AFrGdykxeaZx5DTJ8=
X-Google-Smtp-Source: ABdhPJyHo72NGMxQuQyxjtT+5nQCpXx6NLGzNhCQiYTfEj1ygK3qKqvFSanv94vqY7Xo8TEpIVxc2neyx1BN+BCLKCI=
X-Received: by 2002:a05:6000:1561:: with SMTP id 1mr3318468wrz.369.1633693561692;
 Fri, 08 Oct 2021 04:46:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191211212025.1981822-1-arnd@arndb.de> <20191211212025.1981822-9-arnd@arndb.de>
 <29QBMJU8DE71E.2YZSH8IHT5HMH@mforney.org> <s5hpmsh9kdx.wl-tiwai@suse.de>
 <CAK8P3a0K3XtjiszC3XWgG0L8+AgO+xUGr_KEAnb9a5GmyecoUQ@mail.gmail.com>
 <s5hee8x9f92.wl-tiwai@suse.de> <CAK8P3a0pSZxqfk-bn+idrDYDwANSfiP9L6U1O5jLQvK+3vwyVQ@mail.gmail.com>
 <s5hy27497eo.wl-tiwai@suse.de> <20211007160634.GB7074@brightrain.aerifal.cx>
 <s5hr1cw95ar.wl-tiwai@suse.de> <20211007165158.GC7074@brightrain.aerifal.cx>
 <s5h5yu79aab.wl-tiwai@suse.de> <CAK8P3a0qxNLv3_RcR5COcRGPcTnYMcfbOjdWKiT2hKdcof9WUg@mail.gmail.com>
 <s5hv9277oux.wl-tiwai@suse.de>
In-Reply-To: <s5hv9277oux.wl-tiwai@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 8 Oct 2021 13:45:45 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2DUvQSkUaDzwiRjg9d3w7pXxrw8q_oSawJKY7kEw1qtg@mail.gmail.com>
Message-ID: <CAK8P3a2DUvQSkUaDzwiRjg9d3w7pXxrw8q_oSawJKY7kEw1qtg@mail.gmail.com>
Subject: Re: [musl] Re: [alsa-devel] [PATCH v7 8/9] ALSA: add new 32-bit
 layout for snd_pcm_mmap_status/control
To:     musl@lists.openwall.com
Cc:     Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@libc.org>,
        Michael Forney <mforney@mforney.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:+hFh6TMhzooG835U1FXgefHtJnVouZBVAOuU5np591EBrvwkVqB
 /Ja6iPzKmnOLDf1JNrA0yLTl5aUkhJsA19gwecRxwo3LDCTIC3112jhUO4n7yajGETc+wIK
 P4BalAzAcc6gAUNemrDeOsBAT2e+5nnt3Jo2J+Ykyc2FP+tJDI7GxbQCZRR9Pk/7dHLyA8t
 KJmxmnbOx4l4KqmgNRqrA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:r9wJz8rfA4s=:FS5F5UyAlXWqzHTC2rHBIh
 zFJMXOQqk5WXTvOW22svwUArEdTib/yrnP+ROgDCsP1j1T9gqnoeKF0qRU/zImMv1937oayTr
 5RSZgWwOpH0Lnr7r+TN9tiVkMsP7kLyZ8n3TeZj5Bf2zRAaUps2qS2m+kw02trybQ83wetl7X
 RGbcKsu64yOhJotfspnZOW+DPfsn6shH2phb5xjCe8god73QWvOTmPaa4pCNxlguQljLUTDUY
 9U1BaHyN059r4r32UHREPLygaN9+Drfe4rZqvqRkOdecdyfPXps6Nhq4EWNgKsr4m0VUGpfoA
 X1Dbc4T88gjs6U3OwXOeFJs6PvlCy4VxILsB1OQNbetZcDZ9qdHgfKxEwlHYms2c0mnTyPrOz
 2xVrPPcQjLfTchM0XCU5BdrblT5vBlTjAu8tINGzMqASG9hCWQMgxfm8QWRUE5M+ctrjXto0x
 vnLpNRpDsSJB1w89jY4ba94C8js1YlRawof/tdzo6UMNT3ixFMk9SBHt96QoeJahxQWSZEHtA
 OQfboLzQiwfjmdBBMgmITPmmZMMSOzi/mMaPM1GckHPdNcUqZBzqVTDQlg2bY1y9osutcd5Qn
 oozmSa435UmJsykZWcDVt8FYmAxpFRyHZMbRDGnHH7CkNS7kT+PdsJsr00RJwI7qG2yN7XODn
 QlzTujy7dyWhbZ3uJWlINK4eilSfGOjqlCnVUlaPBWvdpUeEx6BRJdawWGRS8MT7ZmaUrNshO
 MkM/WQdYA1UbNo+igC4dPachrWAimyufKMHj8g==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 8, 2021 at 1:11 PM Takashi Iwai <tiwai@suse.de> wrote:
> On Fri, 08 Oct 2021 11:24:39 +0200, Arnd Bergmann wrote:

> >
> > I've tried to understand this part of musl's convert_ioctl_struct(), but I just
> > can't figure out whether it does the conversion based the on the layout that
> > is currently used in the kernel, or based on the layout we should have been
> > using, and would use with the above fix. Rich, can you help me here?
>
> So, at this moment, I'm not sure whether we should correct the struct
> at all.  This will lead to yet more breakage, and basically the struct
> itself *works* -- the only bug is in 32bit compat handling in the
> kernel (again).

I'm still unsure if the musl fallback code is correct or not.

> The below is a revised kernel patch (again untested), just correcting
> the behavior of 32bit compat mode.  32bit apps on 32bit kernel work
> fine as is, as well as 64bit apps on 64bit kernel.

Right, this should cover all cases of the ioctl itself misbehaving.
In addition, we still need to disallow the mmap() interface on compat
kernels then. Strictly speaking, we could allow the snd_pcm_mmap_status
but not snd_pcm_mmap_control to be mapped, but I'm not sure if
that's better than disallowing both.

       Arnd
