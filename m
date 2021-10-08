Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3064266B7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 11:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238157AbhJHJ05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 05:26:57 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:52347 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236195AbhJHJ0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 05:26:52 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MkpvV-1n3SMh1a4l-00mJa2 for <linux-kernel@vger.kernel.org>; Fri, 08 Oct
 2021 11:24:56 +0200
Received: by mail-wr1-f48.google.com with SMTP id e12so27713772wra.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 02:24:56 -0700 (PDT)
X-Gm-Message-State: AOAM531MiDNZnVajH0eeBI0aVYUFK8XpQE0NdHzVpJ0sBsagyYgQpVFZ
        OcAXndQTo+r10Ttcg05Zz1UcGSZbUR3P04xDq+0=
X-Google-Smtp-Source: ABdhPJxbI9FlI5wrrkveY0OcRvKfdHT6ALl6Zio9wUi7opJy24FK9gPvC5um/n8zfpgrtkT+TFtW3m/pBAMoS+zbbfg=
X-Received: by 2002:adf:a3da:: with SMTP id m26mr2544913wrb.336.1633685096034;
 Fri, 08 Oct 2021 02:24:56 -0700 (PDT)
MIME-Version: 1.0
References: <20191211212025.1981822-1-arnd@arndb.de> <20191211212025.1981822-9-arnd@arndb.de>
 <29QBMJU8DE71E.2YZSH8IHT5HMH@mforney.org> <s5hpmsh9kdx.wl-tiwai@suse.de>
 <CAK8P3a0K3XtjiszC3XWgG0L8+AgO+xUGr_KEAnb9a5GmyecoUQ@mail.gmail.com>
 <s5hee8x9f92.wl-tiwai@suse.de> <CAK8P3a0pSZxqfk-bn+idrDYDwANSfiP9L6U1O5jLQvK+3vwyVQ@mail.gmail.com>
 <s5hy27497eo.wl-tiwai@suse.de> <20211007160634.GB7074@brightrain.aerifal.cx>
 <s5hr1cw95ar.wl-tiwai@suse.de> <20211007165158.GC7074@brightrain.aerifal.cx> <s5h5yu79aab.wl-tiwai@suse.de>
In-Reply-To: <s5h5yu79aab.wl-tiwai@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 8 Oct 2021 11:24:39 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0qxNLv3_RcR5COcRGPcTnYMcfbOjdWKiT2hKdcof9WUg@mail.gmail.com>
Message-ID: <CAK8P3a0qxNLv3_RcR5COcRGPcTnYMcfbOjdWKiT2hKdcof9WUg@mail.gmail.com>
Subject: Re: [musl] Re: [alsa-devel] [PATCH v7 8/9] ALSA: add new 32-bit
 layout for snd_pcm_mmap_status/control
To:     musl@lists.openwall.com
Cc:     Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>,
        Michael Forney <mforney@mforney.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:eOMl8pt7sDbFm0Pnh35h/ccp/05TjO3awVBu73cxG9X5eM9h6Md
 ai8L0yEAhRg9+WzyiqpkWiaOxokNzoMuH3+HcBgStjeU1IigideUN5RkATd2SUEwdq/NhzR
 /4vMRdw1mfuhqv/Hs4YAGCbn2adUD4HzYkAkh7Z/mj5d0u+alGxIoDd3RJ67EfETy1/pfJq
 Qurwd4VVHgs3ofh1hURsA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:slsqNYVPYjg=:hwm8bU1bcqyIiR07bhWFzu
 txCYZ/GC/XMcHDzKHZeUpf7knw6FFYNe9UThqHXQPpPaqPovV0EWuz9NFFr3ZCo79ZnbvUm4b
 0GcuCQfFFyG1fB8bAAld1gztDn12g5Ow2qukfFutb5mvQKnf5gXNectKp2iu+9g6rfo8nXCMv
 hOqSm1HIX84JeOrvrL/1GzCc039U/07TbuAUTfcmQefS/PxsWMoPFCZcj6xFOiPYLvVH6L+uM
 PPK54/UN7DQRq5A1dZn/CLE1BcBik+5n9PiFamOC2HkhFsqgxyWBNsDx0MDSlYHBN3E8E0wz2
 o7RjIa6wiVaT7aspLnf5jf1kbixz+sePmLUuUIeDu7/dROhEigX4Yq51pLHM86tJMpQ1G0YHR
 a8ISrVHz+2yUe3fh786IVEEzgUlXAPFZiZpkehxDhvN/dxgvG36WOJvn6ENWYeL5yzNxrIt1x
 So70wRpEJk/iGId3FVzLLY5OCvfE+kijtt++Ie8134tpWxTFX8+UnyzNls4bRU8pLYNamgPPs
 kHoQttEjhJ04pA9P18l/OS0HXlniBTb0tO7sLnM3eUdq+5vqekU9NWbW0lAgKRplCDD3RPJM4
 L67wr9o4xhAURfiyo51ZGowCOE1jAyL3CCIPgA88y46XLGC42jUmZnZgTXPZjw+vGBg4u1pZJ
 eb8ZOOkrlcJbbZdSSB8HEJaaSmLHQ6mkI2UFBdk90k6OosdH/8NlvjAlAEhI6aHHgy5zlhUId
 GkCt6iGEUCPEKX8NKxuFBH9ES0Rko1QMRlwCHg4yU0ek7v8i2jCiHxv4Tz5euzGBifVm9CY1E
 +DxXXVBXDcJ3eYaIazlR4pUW3yii8Z8TTb5WyTXdmAyG65q1xNPDPKhPxjB4zdcrSHmaiEfW/
 FLkSjQXa/WBpQN1BgtVw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 8, 2021 at 10:43 AM Takashi Iwai <tiwai@suse.de> wrote:
> On Thu, 07 Oct 2021 18:51:58 +0200, Rich Felker wrote:
> > On Thu, Oct 07, 2021 at 06:18:52PM +0200, Takashi Iwai wrote:
>
> @@ -557,11 +558,15 @@ struct __snd_pcm_sync_ptr {
>  #if defined(__BYTE_ORDER) ? __BYTE_ORDER == __BIG_ENDIAN : defined(__BIG_ENDIAN)
>  typedef char __pad_before_uframe[sizeof(__u64) - sizeof(snd_pcm_uframes_t)];
>  typedef char __pad_after_uframe[0];
> +typedef char __pad_before_u32[4];
> +typedef char __pad_after_u32[0];
>  #endif
>
>  #if defined(__BYTE_ORDER) ? __BYTE_ORDER == __LITTLE_ENDIAN : defined(__LITTLE_ENDIAN)
>  typedef char __pad_before_uframe[0];
>  typedef char __pad_after_uframe[sizeof(__u64) - sizeof(snd_pcm_uframes_t)];
> +typedef char __pad_before_u32[0];
> +typedef char __pad_after_u32[4];
>  #endif

I think these should remain unchanged, the complex expression was intentionally
done so the structures are laid out the same way on 64-bit
architectures, so that
the kernel can use the __SND_STRUCT_TIME64 path internally on both 32-bit
and 64-bit architectures.

> @@ -2970,8 +2981,17 @@ static int snd_pcm_sync_ptr(struct snd_pcm_substream *substream,
>         memset(&sync_ptr, 0, sizeof(sync_ptr));
>         if (get_user(sync_ptr.flags, (unsigned __user *)&(_sync_ptr->flags)))
>                 return -EFAULT;
> -       if (copy_from_user(&sync_ptr.c.control, &(_sync_ptr->c.control), sizeof(struct snd_pcm_mmap_control)))
> -               return -EFAULT;
> +       if (buggy_control) {
> +               if (copy_from_user(&sync_ptr.c.control_api_2_0_15,
> +                                  &(_sync_ptr->c.control_api_2_0_15),
> +                                  sizeof(sync_ptr.c.control_api_2_0_15)))
> +                       return -EFAULT;
> +       } else {
> +               if (copy_from_user(&sync_ptr.c.control,
> +                                  &(_sync_ptr->c.control),
> +                                  sizeof(sync_ptr.c.control)))
> +                       return -EFAULT;
> +       }

The problem I see with this is that it might break musl's ability to
emulate the new
interface on top of the old (time32) one for linux-4.x and older
kernels, as the conversion
function is no longer stateless but has to know the negotiated
interface version.

It's probably fine as long as we can be sure that the 2.0.16+ API
version only gets
negotiated if both the kernel and user sides support it, and musl only emulates
the 2.0.15 API version from the current kernels.

I've tried to understand this part of musl's convert_ioctl_struct(), but I just
can't figure out whether it does the conversion based the on the layout that
is currently used in the kernel, or based on the layout we should have been
using, and would use with the above fix. Rich, can you help me here?

       Arnd
