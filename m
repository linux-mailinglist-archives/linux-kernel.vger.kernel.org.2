Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506614253C0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 15:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240542AbhJGNNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 09:13:17 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:43479 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241197AbhJGNNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 09:13:13 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M5g68-1mRJVP3bhq-0079iO for <linux-kernel@vger.kernel.org>; Thu, 07 Oct
 2021 15:11:17 +0200
Received: by mail-wr1-f41.google.com with SMTP id o20so18934608wro.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 06:11:17 -0700 (PDT)
X-Gm-Message-State: AOAM530CsFEbf3dBUvX3mesjF8+gSIYhiAkJFymF+wePbeya01RfBOeY
        YtIOrRglQxESakFNRvv7Om7OZHnJcxiJttyIJ3g=
X-Google-Smtp-Source: ABdhPJz+35NXT/p5TszOUNgOpymxZVTmTArKWJKi2r6OibnWqxiqzjsuLR4U9FbC9D/iKpGK8f1e5LZYTuC8A3v+RKY=
X-Received: by 2002:adf:a3da:: with SMTP id m26mr5182095wrb.336.1633612277427;
 Thu, 07 Oct 2021 06:11:17 -0700 (PDT)
MIME-Version: 1.0
References: <20191211212025.1981822-1-arnd@arndb.de> <20191211212025.1981822-9-arnd@arndb.de>
 <29QBMJU8DE71E.2YZSH8IHT5HMH@mforney.org> <s5hpmsh9kdx.wl-tiwai@suse.de>
 <CAK8P3a0K3XtjiszC3XWgG0L8+AgO+xUGr_KEAnb9a5GmyecoUQ@mail.gmail.com> <s5hee8x9f92.wl-tiwai@suse.de>
In-Reply-To: <s5hee8x9f92.wl-tiwai@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 7 Oct 2021 15:11:00 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0pSZxqfk-bn+idrDYDwANSfiP9L6U1O5jLQvK+3vwyVQ@mail.gmail.com>
Message-ID: <CAK8P3a0pSZxqfk-bn+idrDYDwANSfiP9L6U1O5jLQvK+3vwyVQ@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v7 8/9] ALSA: add new 32-bit layout for snd_pcm_mmap_status/control
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
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:uhREYKSNSgqa2/xpVY1IwqE1Goyd+RdRTYzlEEKjxRWatA3GJo/
 3zJKMgmZtC4209dA34I6IHmXzoErneuk3OmEdeFL3yXX7b1wBKOhVBYIAfXl40e7tSkR6cu
 8V8hyLiZNA55sBraUAU9Zko6hbcKY9C9IMgp3cAFrDIHUi5m4R+GWqPsIALvV2Bl/mE5of5
 k1+/KEtBW1Y9XHNrBW8Pg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vUy240gKoDI=:O6bcfC6JlN4WOxNu9Au+pU
 ae8UdGC+qNWjE7F3xVlJLJTSrNQdnsQSF4xCXnkQuRNav30G+7bxrm4LLyVTV6AU0KRA92oXe
 4homSRmOyHWJQLvb9FU26EnwXbfRpXebs25LcBU7nqFErhyTb8DaMU8Is1m2jINJmnJJXFGM8
 7ubdQarsSkERWhxsmm2zjdyR48Fq6IKfQzl6u/4m3kLuuMTO8boR3iFBhotrHLoy9GZ2DCZR1
 pfEb/YN3TL/ES70x6XYXmYawDdUd2WpIRF1+u9VzzTMKsSGz/V2zpvbb+B4aGayChS2M+ZyQo
 GWshlcr/FUZ5u8G0trdqPQGMjBKJyQwrrlN7/B5BsOtbv8tD7G+LeRh7tYxLKniRpYtFLEzHM
 +WhxOc0msMWymAAc63LW7kJ9hNXL1g9VUJl8l0T5TLQrKKdeQPZUr4C4hxD0AKekhlEK1YyH+
 o0B7k18X3kKAWj8PnPDaK6FiyBRgD52Q/fk+bRJ+eeoI/pQ+rtYsgeKNoHRjeFM6j4g4QUDYW
 PmUM/MfliyuxrSLjS1ZMKmRLw2oHBsrWZHpB7EdxsRIKctprLv0KmedDoWrEbfF7BPAKB6WAF
 1h6ug1T2A9qQfA2RW94bf6d2Imo+zYG+wiehMfRIe7VY7b49mq2GY01CI2xDqBV2MqUl7RhL0
 49tge+mUJXKogWQ4qHHhfYYDEa7NLRZQj72ObiYuBCaGJkxwyiwU27d3X4i24qhbkh/jFRY63
 E8pAN9Lb1eGzk6uMQ3ss47nHrCgMMuS9RM69eAAij98Bj2ro7FzJ+6J3mwlgOoHQYE4PQBPII
 trSPE1AiuNNQVWCVGuK83NDMOiuwUNiCDPHJjT8b/JB+9TskcRkUxwR4i7WaqYGSQzlHdiofo
 s/VRSvSi3vfF8WU+uj7w==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 On Thu, Oct 7, 2021 at 2:43 PM Takashi Iwai <tiwai@suse.de> wrote:
> On Thu, 07 Oct 2021 13:48:44 +0200, Arnd Bergmann wrote:
> > On Thu, Oct 7, 2021 at 12:53 PM Takashi Iwai <tiwai@suse.de> wrote:
> > > On Wed, 06 Oct 2021 19:49:17 +0200, Michael Forney wrote:
> >
> > As far as I can tell, the broken interface will always result in
> > user space seeing a zero value for "avail_min". Can you
> > make a prediction what that would mean for actual
> > applications? Will they have no audio output, run into
> > a crash, or be able to use recover and appear to work normally
> > here?
>
> No, fortunately it's only about control->avail_min, and fiddling this
> value can't break severely (otherwise it'd be a security problem ;)
>
> In the buggy condition, it's always zero, and the kernel treated as if
> 1, i.e. wake up as soon as data is available, which is OK-ish for most
> applications.   Apps usually don't care about the wake-up condition so
> much.  There are subtle difference and may influence on the stability
> of stream processing, but the stability usually depends more strongly
> on the hardware and software configurations.
>
> That being said, the impact by this bug (from the application behavior
> POV) is likely quite small, but the contamination is large; as you
> pointed out, it's much larger than I thought.

Ok, got it.

> The definition in uapi/sound/asound.h is a bit cryptic, but IIUC,
> __snd_pcm_mmap_control64 is used for 64bit archs, right?  If so, the
> problem rather hits more widely on 64bit archs silently.  Then, the
> influence by this bug must be almost negligible, as we've had no bug
> report about the behavior change.

While __snd_pcm_mmap_control64 is only used on 32-bit
architectures when 64-bit time_t is used. At the moment, this
means all users of musl-1.2.x libc, but not glibc.

On 64-bit architectures, __snd_pcm_mmap_control and
__snd_pcm_mmap_control64 are meant to be identical,
and this is actually true regardless of the bug, since
__pad_before_uframe and __pad_after_uframe both
end up as zero-length arrays here.

> We may just fix it in kernel and for new library with hoping that no
> one sees the actual problem.  Or, we may provide a complete new set of
> mmap offsets and ioctl to cover both broken and fixed interfaces...
> The decision depends on how perfectly we'd like to address the bug.
> As of now, I'm inclined to go for the former, but I'm open for more
> opinions.

Adding the musl list to Cc for additional testers, anyone interested
please see [1] for the original report.

It would be good to hear from musl users that are already using
audio support with 32-bit applications on 64-bit kernels, which
is the case that has the problem today. Have you noticed any
problems with audio support here? If not, we can probably
"fix" the kernel here and make the existing binaries behave
the same way on 32-bit kernels. If there are applications that
don't work in that environment today, I think we need to instead
change the kernel to accept the currently broken format on
both 32-bit and 64-bit kernels, possibly introducing yet another
format that works as originally intended but requires a newly
built kernel.

      Arnd

[1] https://lore.kernel.org/all/29QBMJU8DE71E.2YZSH8IHT5HMH@mforney.org/
