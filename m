Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C5C426A64
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 14:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240550AbhJHMIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 08:08:06 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:42996 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbhJHMIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 08:08:05 -0400
Date:   Fri, 8 Oct 2021 08:06:09 -0400
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
Message-ID: <20211008120609.GE7074@brightrain.aerifal.cx>
References: <s5hpmsh9kdx.wl-tiwai@suse.de>
 <CAK8P3a0K3XtjiszC3XWgG0L8+AgO+xUGr_KEAnb9a5GmyecoUQ@mail.gmail.com>
 <s5hee8x9f92.wl-tiwai@suse.de>
 <CAK8P3a0pSZxqfk-bn+idrDYDwANSfiP9L6U1O5jLQvK+3vwyVQ@mail.gmail.com>
 <s5hy27497eo.wl-tiwai@suse.de>
 <20211007160634.GB7074@brightrain.aerifal.cx>
 <s5hr1cw95ar.wl-tiwai@suse.de>
 <20211007165158.GC7074@brightrain.aerifal.cx>
 <s5h5yu79aab.wl-tiwai@suse.de>
 <CAK8P3a0qxNLv3_RcR5COcRGPcTnYMcfbOjdWKiT2hKdcof9WUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0qxNLv3_RcR5COcRGPcTnYMcfbOjdWKiT2hKdcof9WUg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 11:24:39AM +0200, Arnd Bergmann wrote:
> On Fri, Oct 8, 2021 at 10:43 AM Takashi Iwai <tiwai@suse.de> wrote:
> > On Thu, 07 Oct 2021 18:51:58 +0200, Rich Felker wrote:
> > > On Thu, Oct 07, 2021 at 06:18:52PM +0200, Takashi Iwai wrote:
> >
> > @@ -557,11 +558,15 @@ struct __snd_pcm_sync_ptr {
> >  #if defined(__BYTE_ORDER) ? __BYTE_ORDER == __BIG_ENDIAN : defined(__BIG_ENDIAN)
> >  typedef char __pad_before_uframe[sizeof(__u64) - sizeof(snd_pcm_uframes_t)];
> >  typedef char __pad_after_uframe[0];
> > +typedef char __pad_before_u32[4];
> > +typedef char __pad_after_u32[0];
> >  #endif
> >
> >  #if defined(__BYTE_ORDER) ? __BYTE_ORDER == __LITTLE_ENDIAN : defined(__LITTLE_ENDIAN)
> >  typedef char __pad_before_uframe[0];
> >  typedef char __pad_after_uframe[sizeof(__u64) - sizeof(snd_pcm_uframes_t)];
> > +typedef char __pad_before_u32[0];
> > +typedef char __pad_after_u32[4];
> >  #endif
> 
> I think these should remain unchanged, the complex expression was intentionally
> done so the structures are laid out the same way on 64-bit
> architectures, so that
> the kernel can use the __SND_STRUCT_TIME64 path internally on both 32-bit
> and 64-bit architectures.
> 
> > @@ -2970,8 +2981,17 @@ static int snd_pcm_sync_ptr(struct snd_pcm_substream *substream,
> >         memset(&sync_ptr, 0, sizeof(sync_ptr));
> >         if (get_user(sync_ptr.flags, (unsigned __user *)&(_sync_ptr->flags)))
> >                 return -EFAULT;
> > -       if (copy_from_user(&sync_ptr.c.control, &(_sync_ptr->c.control), sizeof(struct snd_pcm_mmap_control)))
> > -               return -EFAULT;
> > +       if (buggy_control) {
> > +               if (copy_from_user(&sync_ptr.c.control_api_2_0_15,
> > +                                  &(_sync_ptr->c.control_api_2_0_15),
> > +                                  sizeof(sync_ptr.c.control_api_2_0_15)))
> > +                       return -EFAULT;
> > +       } else {
> > +               if (copy_from_user(&sync_ptr.c.control,
> > +                                  &(_sync_ptr->c.control),
> > +                                  sizeof(sync_ptr.c.control)))
> > +                       return -EFAULT;
> > +       }
> 
> The problem I see with this is that it might break musl's ability to
> emulate the new
> interface on top of the old (time32) one for linux-4.x and older
> kernels, as the conversion
> function is no longer stateless but has to know the negotiated
> interface version.
> 
> It's probably fine as long as we can be sure that the 2.0.16+ API
> version only gets
> negotiated if both the kernel and user sides support it, and musl only emulates
> the 2.0.15 API version from the current kernels.
> 
> I've tried to understand this part of musl's convert_ioctl_struct(), but I just
> can't figure out whether it does the conversion based the on the layout that
> is currently used in the kernel, or based on the layout we should have been
> using, and would use with the above fix. Rich, can you help me here?

If the attempted 64-bit ioctl is missing (ENOTTY), it does the
conversion to the legacy 32-bit one and retries with that, then
converts the results back to the 64-bit form.

Not only do I fail to see how the proposed fix is workable with this
framework; I also don't see how the proposed fix would let new
applications (compiled without the buggy type) run on old kernels. I'm
pretty sure there really should be a new ioctl number for this...

Rich
