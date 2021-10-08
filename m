Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B83426A84
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 14:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240980AbhJHMPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 08:15:31 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:57597 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240457AbhJHMP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 08:15:29 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MA7b8-1mSkCd1O7W-00BbkH for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021
 14:13:33 +0200
Received: by mail-wr1-f51.google.com with SMTP id k7so29043609wrd.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 05:13:33 -0700 (PDT)
X-Gm-Message-State: AOAM530O2RGMey1ZbHJd5Z3H7frpNvPg016Ps2U3Srp2UOs3CJiwWtnD
        ThR10rAYhgnc/iLDsjUTTtZAz5EqeiPyPAFdzBw=
X-Google-Smtp-Source: ABdhPJx1A2D3uT0vzkwBBgcqCmigtym207jBkyjcfjbAUCVSC7jvNZMRoRn37wH1p1cCJbv0expgQMHr7/L53iVVxso=
X-Received: by 2002:adf:a3da:: with SMTP id m26mr3519436wrb.336.1633695212568;
 Fri, 08 Oct 2021 05:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <20191211212025.1981822-1-arnd@arndb.de> <20191211212025.1981822-9-arnd@arndb.de>
 <29QBMJU8DE71E.2YZSH8IHT5HMH@mforney.org> <s5hpmsh9kdx.wl-tiwai@suse.de>
 <CAK8P3a0K3XtjiszC3XWgG0L8+AgO+xUGr_KEAnb9a5GmyecoUQ@mail.gmail.com>
 <s5hee8x9f92.wl-tiwai@suse.de> <CAK8P3a0pSZxqfk-bn+idrDYDwANSfiP9L6U1O5jLQvK+3vwyVQ@mail.gmail.com>
 <s5hy27497eo.wl-tiwai@suse.de> <20211007160634.GB7074@brightrain.aerifal.cx>
 <s5hr1cw95ar.wl-tiwai@suse.de> <20211007165158.GC7074@brightrain.aerifal.cx>
 <s5h5yu79aab.wl-tiwai@suse.de> <CAK8P3a0qxNLv3_RcR5COcRGPcTnYMcfbOjdWKiT2hKdcof9WUg@mail.gmail.com>
 <s5hv9277oux.wl-tiwai@suse.de> <CAK8P3a2DUvQSkUaDzwiRjg9d3w7pXxrw8q_oSawJKY7kEw1qtg@mail.gmail.com>
 <s5ho87z7mxg.wl-tiwai@suse.de>
In-Reply-To: <s5ho87z7mxg.wl-tiwai@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 8 Oct 2021 14:13:16 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0kg0NQoxC7_cUJfFZkoheAE2A_fQLTGKqgz0wq3L0rvw@mail.gmail.com>
Message-ID: <CAK8P3a0kg0NQoxC7_cUJfFZkoheAE2A_fQLTGKqgz0wq3L0rvw@mail.gmail.com>
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
X-Provags-ID: V03:K1:hwyJ6E22069yP3B4NLtvn2lZc27/4kzl2uzEjPsHsTqtvGOmHCx
 C2vK3QD3oEDlk9GF0vmrvK7bKX8pY8GzmoCuINS6KwQwP9KE9PHr8OvHaOmxiBvI8L75wuX
 xcvZJBuMbR2ClqhNxf596Ri1gjbkw1qzYkZBQxprSwBB13XRgxcxD6hKb0ZQJWrEJsa0cHv
 e6Spty48eKlPJ6ZomZu8Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:i2JsnFMQv78=:niKsq1gVME5ufzfeTocewG
 3oA/TOm6vJZ59kgrRCgjOQFtuW0kOJ/PDYH3NF6dO9nrpSJbd08ieVpEPdZ7TSBqIwldxNjQZ
 NCyg06b+utIYDe7UR3ajrbSWn0cBUz7ZuhxCokoQF4prn3swSJ92Aw6AOgsSElPg40a6D062w
 u4dxYel7HMpcvdGMC2Bu3JKCxr059+l4mVBdM5pLTN3GYcAMFALZ46tosHn0GGAwhFpTvMjjc
 DLkrTiSTGOrG1Flx/1wOudf/6Cex6pIHrKJr6EmM5PLpxjDgS7a/O7eIc9H2mYVBpCzgXLtMb
 cyhrYRAGCk2TTjPD7aa05afGrqOd0M54vHgQcbfOKph3mxwSlmUZCbjhHVXHQKCTLHcaiGTvs
 Zf7d7F75m5eHQuRJHLQCtKQVlZQBL8Brthrv14ITuZlMqs/GUdgvNuV6cW/QVJD5pvtfL2rDw
 IXTtHSQ+AvIKXb7uP7zKPjYHK4XMMecGK/zKmn7+/4jUiZAotMbjZmC2yvj+1ccdtUybZzeVV
 XVhDlp6Z/1jH9ROct7sNTujkDAeDSAu509nm7OF1aM609gH1Ag6jDq8YLkcLbOmN6So5oGKwj
 FIwpZVBYE/9TnoIkcYuM915Q1VRIj8o02Jy/osnXWpopdLWb5ALbfYSueasj0tun878xOVA/s
 d3tLn1QvbCg6cxBSEQk6FYxGJFAmBtnZ3F0rIyt0f7ksbNcuPmg+SaaVm/uMwPRgrTvJAAaBm
 k5aDzCwWipcfVYQY0GoyH5xXXYgnOi0yocneK8a2nf+Galure/2zpNCBe/C/1guHmwgHv7z/h
 dRLjEBf4CD8aW9UnF39FjoJY50vPxXto0Dx/OaQZDPyhWluGwtvXlGE2Pgn44CulWU2/N1deh
 q94+VuTMb1elCi+tICSA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 8, 2021 at 1:53 PM Takashi Iwai <tiwai@suse.de> wrote:
> On Fri, 08 Oct 2021 13:45:45 +0200, Arnd Bergmann wrote:
> > On Fri, Oct 8, 2021 at 1:11 PM Takashi Iwai <tiwai@suse.de> wrote:
> > > On Fri, 08 Oct 2021 11:24:39 +0200, Arnd Bergmann wrote:
> > > The below is a revised kernel patch (again untested), just correcting
> > > the behavior of 32bit compat mode.  32bit apps on 32bit kernel work
> > > fine as is, as well as 64bit apps on 64bit kernel.
> >
> > Right, this should cover all cases of the ioctl itself misbehaving.
> > In addition, we still need to disallow the mmap() interface on compat
> > kernels then. Strictly speaking, we could allow the snd_pcm_mmap_status
> > but not snd_pcm_mmap_control to be mapped, but I'm not sure if
> > that's better than disallowing both.
>
> IIRC, the compat mmap is already disallowed even for the
> SNDRV_PCM_MMAP_OFFSET_CONTROL_NEW (in pcm_control_mmap_allowed()), so
> no need to change around that.

Ah, right. I think it was meant to become allowed as part of commit
80fe7430c708 ("ALSA: add new 32-bit layout for snd_pcm_mmap_status/control"),
which did allow the snd_pcm_mmap_status to be mmap()ed, but it appears
to be the rare case where two mistakes cancel out and we don't have to
change the mmap code.

         Arnd
