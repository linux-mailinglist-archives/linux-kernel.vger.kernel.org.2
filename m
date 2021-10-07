Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA6D425243
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 13:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241112AbhJGLvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 07:51:00 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:44435 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbhJGLu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 07:50:59 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N17gw-1mvukh11OU-012Ztg for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021
 13:49:01 +0200
Received: by mail-wr1-f44.google.com with SMTP id e12so18217612wra.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 04:49:01 -0700 (PDT)
X-Gm-Message-State: AOAM531zS13Pb2yvztLJcqq0X4nlIWveZO/5zgJ58yorqpeYNtQmevbA
        WugNO0DGeF0+ixcbfMUhrCwk+RM0RadyRCCL1J0=
X-Google-Smtp-Source: ABdhPJwBqe32vcpMnUIo0FX0+1s94CEa3VaWPex61C+7oJ6HCqGwk1cCqJIBbEf/G+UjX5v7CY40bq/ji3zFDNEaLaM=
X-Received: by 2002:a1c:2358:: with SMTP id j85mr15888675wmj.1.1633607340709;
 Thu, 07 Oct 2021 04:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <20191211212025.1981822-1-arnd@arndb.de> <20191211212025.1981822-9-arnd@arndb.de>
 <29QBMJU8DE71E.2YZSH8IHT5HMH@mforney.org> <s5hpmsh9kdx.wl-tiwai@suse.de>
In-Reply-To: <s5hpmsh9kdx.wl-tiwai@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 7 Oct 2021 13:48:44 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0K3XtjiszC3XWgG0L8+AgO+xUGr_KEAnb9a5GmyecoUQ@mail.gmail.com>
Message-ID: <CAK8P3a0K3XtjiszC3XWgG0L8+AgO+xUGr_KEAnb9a5GmyecoUQ@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v7 8/9] ALSA: add new 32-bit layout for snd_pcm_mmap_status/control
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Michael Forney <mforney@mforney.org>,
        Arnd Bergmann <arnd@arndb.de>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:8MDCtwMRNx+9CH2pBL2nD+57DWuRhB410hDVp2fiXnIbcJ08YP8
 qP/humq/+1H+dxMMjKQrbv92zdJl9sFyUAWoyvYMSC2Ibzc/yu+YzplzghP7DA2nfttYlip
 DMv9kP83cw8uU4zqT5dPmKgO/8zpg+e1lLOReeP9VDeGSEe347M4NSfKUxTOa//x5E9H8C+
 f9m+WqpvZX+/328Jx9NDQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bcQ0A5LTM7M=:7u1AzP0ocrxvT6TO+Rt8uV
 8M0CEEyNvP3BiAThtMTI3hedIjiTnRWEi5MLOnN9HxrCkP+Cad+4kK8dJjUAlUMWr1X7kHZks
 bKhkouu7aMJXYbQB04Yvhuu1zWejrUidGsDGAPzQF8fF9+y8CinvQZbDBBj+QlOu+Gg/2CeXT
 G2viZZvXCwuXCKdGu94WOBzvjTqNNsa4xaJNZWfAMWsCqX4NLS7bBaY7xvALg5XXg4NWryBVp
 lUORLA4D3kc+kIS+A360TTGwbW92ARYUsbdvHOO4ytiiwjSpw1NT0qibzeXukCc9ZkFf0NitQ
 0Z4CfRN0G8WVRzwg+GtN9eDloqzSc3EeaxOKgTwDBeMQsRQOU2YBp/V0u1YYb2dnoSgWCyncE
 lecKqmXCgdHNQi0+5kN/HX+2+OXmTfPusAxB4CSwx/UagCe40d85tWzMXn275hesoTbD4tlKQ
 fehQq84EZk6PKsKFknbYJ5b4G9mTwt0d/w5cyRsMLsWPRjmYTKw9quD97D6akFLP2Ssdk5d4t
 3DFrumC3E/WEbfpthKhsCGx5eu37NaXzpASs5Bv3jBCejKBnQOkXuWT4T5zTNothqxoiLAXQE
 kkac5yVFdGYWdzQpIicG8kOcpqZvJhLK1oF12Y/QKrk3fiEgM5TK9mQp2LoOus9Ky4DrwIJ3B
 22ycM8AulViSU6bnFoUst5a4c9msEhK6g9Z3dojGI4FjvseoUqRxsLk8me5Xp7LXRJS3HrWc4
 HMRB5OHURdfh17qvgvAKpFNxR8pvALPgEy07PZydXKzBcojhZl/sKUcpSJTtQWhleoLuXPRLy
 FkXdTRfImp5mfLaPTIPYN1bEkpEgVsB5zCGzH/RDu+rtMrFFEkxAEXhdK9R/rPQHKRUGP3wED
 FL99qEQSwvfONG5Jz9Qg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 7, 2021 at 12:53 PM Takashi Iwai <tiwai@suse.de> wrote:
> On Wed, 06 Oct 2021 19:49:17 +0200, Michael Forney wrote:
> >
> > Arnd Bergmann <arnd@arndb.de> wrote:
> > > +#if defined(__BYTE_ORDER) ? __BYTE_ORDER == __BIG_ENDIAN : defined(__BIG_ENDIAN)
> > > +typedef char __pad_before_uframe[sizeof(__u64) - sizeof(snd_pcm_uframes_t)];
> > > +typedef char __pad_after_uframe[0];
> > > +#endif
> > > +
> > > +#if defined(__BYTE_ORDER) ? __BYTE_ORDER == __LITTLE_ENDIAN : defined(__LITTLE_ENDIAN)
> > > +typedef char __pad_before_uframe[0];
> > > +typedef char __pad_after_uframe[sizeof(__u64) - sizeof(snd_pcm_uframes_t)];
> > > +#endif
> > > +
> > > +struct __snd_pcm_mmap_status64 {
> > > +   __s32 state;                    /* RO: state - SNDRV_PCM_STATE_XXXX */
> > > +   __u32 pad1;                     /* Needed for 64 bit alignment */
> > > +   __pad_before_uframe __pad1;
> > > +   snd_pcm_uframes_t hw_ptr;       /* RO: hw ptr (0...boundary-1) */
> > > +   __pad_after_uframe __pad2;
> > > +   struct __snd_timespec64 tstamp; /* Timestamp */
> > > +   __s32 suspended_state;          /* RO: suspended stream state */
> > > +   __u32 pad3;                     /* Needed for 64 bit alignment */
> > > +   struct __snd_timespec64 audio_tstamp; /* sample counter or wall clock */
> > > +};
> > > +
> > > +struct __snd_pcm_mmap_control64 {
> > > +   __pad_before_uframe __pad1;
> > > +   snd_pcm_uframes_t appl_ptr;      /* RW: appl ptr (0...boundary-1) */
> > > +   __pad_before_uframe __pad2;
> >
> > I was looking through this header and happened to notice that this
> > padding is wrong. I believe it should be __pad_after_uframe here.
> >
> > I'm not sure of the implications of this typo, but I suspect it
> > breaks something on 32-bit systems with 64-bit time (regardless of
> > the endianness, since it changes the offset of avail_min).

Thanks a lot for the report! Yes, this is definitely broken in some ways.

> Right, that's the expected breakage.  It seems that the 64bit time on
> 32bit arch is still rare, so we haven't heard a regression by that, so
> far...

It might actually be worse: on a native 32-bit kernel, both user space
and kernel see the same broken definition with a 64-bit time_t, which
would end up actually making it work as expected. However, in
compat mode, the layout seen on the 32-bit user space is now
different from what the 64-bit kernel has, which would in turn not
work, in both the SNDRV_PCM_IOCTL_SYNC_PTR ioctl and in
the mmap() interface.

Fixing the layout to look like the way we had intended would make
newly compiled applications work in compat mode, but would break
applications built against the old header on new kernels and also
newly built applications on old kernels.

I still hope I missed something and it's not quite that bad, but I
fear the best we can do in this case make the broken interface
the normative one and fixing compat mode to write
mmap_control64->avail_min in the wrong location for
SNDRV_PCM_IOCTL_SYNC_PTR, as well as disabling
the mmap() interface again for compat tasks.

As far as I can tell, the broken interface will always result in
user space seeing a zero value for "avail_min". Can you
make a prediction what that would mean for actual
applications? Will they have no audio output, run into
a crash, or be able to use recover and appear to work normally
here?

       Arnd
