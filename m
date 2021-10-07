Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31A0425760
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 18:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241636AbhJGQId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 12:08:33 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:41948 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbhJGQIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 12:08:32 -0400
Date:   Thu, 7 Oct 2021 12:06:36 -0400
From:   Rich Felker <dalias@libc.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Michael Forney <mforney@mforney.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>, musl@lists.openwall.com
Subject: Re: [musl] Re: [alsa-devel] [PATCH v7 8/9] ALSA: add new 32-bit
 layout for snd_pcm_mmap_status/control
Message-ID: <20211007160634.GB7074@brightrain.aerifal.cx>
References: <20191211212025.1981822-1-arnd@arndb.de>
 <20191211212025.1981822-9-arnd@arndb.de>
 <29QBMJU8DE71E.2YZSH8IHT5HMH@mforney.org>
 <s5hpmsh9kdx.wl-tiwai@suse.de>
 <CAK8P3a0K3XtjiszC3XWgG0L8+AgO+xUGr_KEAnb9a5GmyecoUQ@mail.gmail.com>
 <s5hee8x9f92.wl-tiwai@suse.de>
 <CAK8P3a0pSZxqfk-bn+idrDYDwANSfiP9L6U1O5jLQvK+3vwyVQ@mail.gmail.com>
 <s5hy27497eo.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hy27497eo.wl-tiwai@suse.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 05:33:19PM +0200, Takashi Iwai wrote:
> On Thu, 07 Oct 2021 15:11:00 +0200,
> Arnd Bergmann wrote:
> > 
> >  On Thu, Oct 7, 2021 at 2:43 PM Takashi Iwai <tiwai@suse.de> wrote:
> > > On Thu, 07 Oct 2021 13:48:44 +0200, Arnd Bergmann wrote:
> > > > On Thu, Oct 7, 2021 at 12:53 PM Takashi Iwai <tiwai@suse.de> wrote:
> > > > > On Wed, 06 Oct 2021 19:49:17 +0200, Michael Forney wrote:
> > > >
> > > > As far as I can tell, the broken interface will always result in
> > > > user space seeing a zero value for "avail_min". Can you
> > > > make a prediction what that would mean for actual
> > > > applications? Will they have no audio output, run into
> > > > a crash, or be able to use recover and appear to work normally
> > > > here?
> > >
> > > No, fortunately it's only about control->avail_min, and fiddling this
> > > value can't break severely (otherwise it'd be a security problem ;)
> > >
> > > In the buggy condition, it's always zero, and the kernel treated as if
> > > 1, i.e. wake up as soon as data is available, which is OK-ish for most
> > > applications.   Apps usually don't care about the wake-up condition so
> > > much.  There are subtle difference and may influence on the stability
> > > of stream processing, but the stability usually depends more strongly
> > > on the hardware and software configurations.
> > >
> > > That being said, the impact by this bug (from the application behavior
> > > POV) is likely quite small, but the contamination is large; as you
> > > pointed out, it's much larger than I thought.
> > 
> > Ok, got it.
> > 
> > > The definition in uapi/sound/asound.h is a bit cryptic, but IIUC,
> > > __snd_pcm_mmap_control64 is used for 64bit archs, right?  If so, the
> > > problem rather hits more widely on 64bit archs silently.  Then, the
> > > influence by this bug must be almost negligible, as we've had no bug
> > > report about the behavior change.
> > 
> > While __snd_pcm_mmap_control64 is only used on 32-bit
> > architectures when 64-bit time_t is used. At the moment, this
> > means all users of musl-1.2.x libc, but not glibc.
> > 
> > On 64-bit architectures, __snd_pcm_mmap_control and
> > __snd_pcm_mmap_control64 are meant to be identical,
> > and this is actually true regardless of the bug, since
> > __pad_before_uframe and __pad_after_uframe both
> > end up as zero-length arrays here.
> > 
> > > We may just fix it in kernel and for new library with hoping that no
> > > one sees the actual problem.  Or, we may provide a complete new set of
> > > mmap offsets and ioctl to cover both broken and fixed interfaces...
> > > The decision depends on how perfectly we'd like to address the bug.
> > > As of now, I'm inclined to go for the former, but I'm open for more
> > > opinions.
> > 
> > Adding the musl list to Cc for additional testers, anyone interested
> > please see [1] for the original report.
> > 
> > It would be good to hear from musl users that are already using
> > audio support with 32-bit applications on 64-bit kernels, which
> > is the case that has the problem today. Have you noticed any
> > problems with audio support here? If not, we can probably
> > "fix" the kernel here and make the existing binaries behave
> > the same way on 32-bit kernels. If there are applications that
> > don't work in that environment today, I think we need to instead
> > change the kernel to accept the currently broken format on
> > both 32-bit and 64-bit kernels, possibly introducing yet another
> > format that works as originally intended but requires a newly
> > built kernel.
> 
> Thanks!
> 
> And now, looking more deeply, I feel more desperate.
> 
> This bug makes the expected padding gone on little-endian.
> On LE 32bit, the buggy definition is:
> 
> 	char __pad1[0];
> 	u32 appl_ptr;
> 	char __pad2[0]; // this should have been [4]
> 	char __pad3[0];
> 	u32 avail_min;
> 	char __pad4[4];
> 	
> When an application issues SYNC_PTR64 ioctl to submit appl_ptr and
> avail_min updates, 64bit kernel (in compat mode) reads directly as:
> 
> 	u64 appl_ptr;
> 	u64 avail_min;
> 
> Hence a bogus appl_ptr would be passed if avail_min != 0.
> And usually application sets non-zero avail_min.
> That is, the bug must hit more severely if the new API were really
> used.  It wouldn't crash, but some weird streaming behavior can
> happen like noise, jumping or underruns.
> 
> (Reading back avail_min=0 to user-space is rather harmless.  Ditto for
>  the case of BE, then at least there is no appl_ptr corruption.)
> 
> This made me wonder which way to go:
> it's certainly possible to fix the new kernel to treat both buggy and
> sane formats (disabling compat mmap and re-define ioctls, having the
> code for old APIs).  The problem is, however, in the case where the
> application needs to run on the older kernel that expects the buggy
> format.  Then apps would still have to send in the old buggy format --
> or maybe better in the older 32bit format that won't hit the bug
> above.  It makes situation more complicated.

Can't an ioctl number just be redefined so that, on old kernels with
the buggy one, newly built applications get told that mmap is not
available and use the unaffected non-mmap fallback?

> Do we know how widely the __USE_TIME_BITS64 is deployed nowadays?

Anyone using musl on 32-bit archs who's not >=2 years behind current.

Rich
