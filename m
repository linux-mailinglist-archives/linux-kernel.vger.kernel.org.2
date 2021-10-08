Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F52426F6F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 19:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbhJHRWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 13:22:08 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:43190 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbhJHRWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 13:22:07 -0400
Date:   Fri, 8 Oct 2021 13:20:10 -0400
From:   Rich Felker <dalias@libc.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     musl@lists.openwall.com, Michael Forney <mforney@mforney.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>
Subject: Re: [musl] Re: [alsa-devel] [PATCH v7 8/9] ALSA: add new 32-bit
 layout for snd_pcm_mmap_status/control
Message-ID: <20211008172010.GG7074@brightrain.aerifal.cx>
References: <s5hee8x9f92.wl-tiwai@suse.de>
 <CAK8P3a0pSZxqfk-bn+idrDYDwANSfiP9L6U1O5jLQvK+3vwyVQ@mail.gmail.com>
 <s5hy27497eo.wl-tiwai@suse.de>
 <20211007160634.GB7074@brightrain.aerifal.cx>
 <s5hr1cw95ar.wl-tiwai@suse.de>
 <20211007165158.GC7074@brightrain.aerifal.cx>
 <s5h5yu79aab.wl-tiwai@suse.de>
 <CAK8P3a0qxNLv3_RcR5COcRGPcTnYMcfbOjdWKiT2hKdcof9WUg@mail.gmail.com>
 <20211008120609.GE7074@brightrain.aerifal.cx>
 <CAK8P3a2=X5tPppmcV4x9=pyodiPfoq=tA5jVKuMwA1nKJe=_bA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2=X5tPppmcV4x9=pyodiPfoq=tA5jVKuMwA1nKJe=_bA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 02:37:12PM +0200, Arnd Bergmann wrote:
> On Fri, Oct 8, 2021 at 2:06 PM Rich Felker <dalias@libc.org> wrote:
> > On Fri, Oct 08, 2021 at 11:24:39AM +0200, Arnd Bergmann wrote:
> > >
> > > I've tried to understand this part of musl's convert_ioctl_struct(), but I just
> > > can't figure out whether it does the conversion based the on the layout that
> > > is currently used in the kernel, or based on the layout we should have been
> > > using, and would use with the above fix. Rich, can you help me here?
> >
> > If the attempted 64-bit ioctl is missing (ENOTTY), it does the
> > conversion to the legacy 32-bit one and retries with that, then
> > converts the results back to the 64-bit form.
> 
> I understand that it tries to do that.
> 
> The part that I'm not sure about is which of the two possible
> 64-bit forms it's using -- the broken one we have defined in the
> kernel headers, or the one we were trying to define but failed.

It's attempting to convert the intended format, not the one that the
uapi headers defined. That is, it's taking padded-to-64-bit values at
offsets 0 and 8 in __snd_pcm_mmap_control64, putting them at offsets 0
and 4 in the 32-bit struct, and padding them back to 64-bit in the
result.

Since applications would have been compiled with the buggy
(unintended) version of the uapi headers, this will not match the
application's layout of the struct. I haven't worked through what all
the consequences of that are, but I think some fix is needed here in
musl regardless of what happens on the kernel side.

Rich
