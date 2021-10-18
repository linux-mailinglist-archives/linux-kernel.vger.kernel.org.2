Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82CC4322D0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 17:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbhJRP3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 11:29:06 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:44447 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbhJRP3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:29:05 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MfqCF-1nDTAw4BEf-00gG7o for <linux-kernel@vger.kernel.org>; Mon, 18 Oct
 2021 17:26:52 +0200
Received: by mail-wr1-f45.google.com with SMTP id u18so42281976wrg.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 08:26:51 -0700 (PDT)
X-Gm-Message-State: AOAM532OiYXwlD6r8/gShDnnueXHQTmVoMkhTjfuaTCxMyMuMrczRdUT
        lO3GuJiepPnEw+GlHkGRbS3zLyXZgjKykSiCMOw=
X-Google-Smtp-Source: ABdhPJwZTryrYp+pNKyx1vAYwOjs14JDwumKgWlVCbFtT0ihV++n2REC55gSAlRYQLZatyLWyLhfYAzetvIOnch0TxY=
X-Received: by 2002:adf:f481:: with SMTP id l1mr35106062wro.411.1634570811678;
 Mon, 18 Oct 2021 08:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <20211007160634.GB7074@brightrain.aerifal.cx> <s5hr1cw95ar.wl-tiwai@suse.de>
 <20211007165158.GC7074@brightrain.aerifal.cx> <s5h5yu79aab.wl-tiwai@suse.de>
 <CAK8P3a0qxNLv3_RcR5COcRGPcTnYMcfbOjdWKiT2hKdcof9WUg@mail.gmail.com>
 <s5hv9277oux.wl-tiwai@suse.de> <20211008120736.GF7074@brightrain.aerifal.cx>
 <s5hsfx95n99.wl-tiwai@suse.de> <20211018144259.GK7074@brightrain.aerifal.cx>
 <s5hlf2q4byc.wl-tiwai@suse.de> <20211018150824.GL7074@brightrain.aerifal.cx>
In-Reply-To: <20211018150824.GL7074@brightrain.aerifal.cx>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 18 Oct 2021 17:26:35 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1RAk5WRtMjqV6QZ1eHtFu_sxhSBJn0Uv-MhRA5WGiJqQ@mail.gmail.com>
Message-ID: <CAK8P3a1RAk5WRtMjqV6QZ1eHtFu_sxhSBJn0Uv-MhRA5WGiJqQ@mail.gmail.com>
Subject: Re: [musl] Re: [alsa-devel] [PATCH v7 8/9] ALSA: add new 32-bit
 layout for snd_pcm_mmap_status/control
To:     musl@lists.openwall.com
Cc:     Takashi Iwai <tiwai@suse.de>, Arnd Bergmann <arnd@arndb.de>,
        Michael Forney <mforney@mforney.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:NIL2YjsP3bdB/RQqfsu2hkAEoHNXuApH+20hM8VYvOWG2xnHOlW
 GgA1Fxg+Mz2zpQYus1ZNpUM4ec5e7Z4gsbepT2CFgh6oQXAPZgIoPIeqdXxJQs1zX7LXRhT
 ZKtruHVqbRiUtdqmEZbyty4ZpWS/ZGrDS7p66GCc9ne9QRbcg19NcY2P+cqNxn9rPLz38X3
 rFB9DfGWC8VRqT2i14DWQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qF6Kws3pvXk=:4kd0ccTxV/CI/logzlPj49
 4yMIfSeTTgH7aynWHdqhPwf46uo2G5yNNLpw2e2MMP2DV5Q9ZDL5d+atnR6H2y1YPRQVaH8lr
 2ZnV9vQRuYu497o3neJAMpPf5a3u0Sbgw+FFcIQFOLxZ4sRT5/rLcLbaaAiMsCv3zBO8rZo6A
 AY+DkDOBqtk3ztJoeCVZtok+Hodx1L4mqckRFvjOebfWfjkUeA1jQhsn45ZmEFrCXmJNnbfig
 BqVlnq0xXqwhz9APYcZjKtJMbfNCeGB/H6N2WxHJhKj3uBDYGZxzQ3YGK3ZSdGcVmlh6l1iRI
 BxLLbLOOA+Ze2vk9GVwSi+K7Yru8WWTprSFSionURTo7bR+yOKURr/XqRrKwXsdqBs9s2C+HU
 O6hv8wmXL0+X+1WIUwhYKXdwLHFrCxaM5J8QlVk30xdazSdYqDnYChu5RTO2XS4xm4VXuW1ZL
 ULqTa7LrLvQoSlhBPDtwdz9uCtY1w0O1FA3Urv81K895OLD+CcbA6jBR64fS96+h7fHVeARM0
 sgtFsdkWq2ZteCJrhTuYyaURin1RfM5URpmH9WDaAbGVDbLqbmTvGSYMmJCeUzbNFOz30JbBl
 s7wI+g1YTcPjDp/9WHWrSLmRN3YUqlxNkqKYAHSH6/o8eaNWE7kX1Hoe0V5rdzfUiPNmkEf9C
 LOsfx5e8J++G03lwql7J/0Ek2zTpjrEx2oH23jUfaaLTObkqX94dwiLkKS+G/tqwJIU48MqJH
 s+b6Frhu564vJ/KSbjuFkG5I4iQVLyI01KOCPw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 5:08 PM Rich Felker <dalias@libc.org> wrote:
> On Mon, Oct 18, 2021 at 04:58:03PM +0200, Takashi Iwai wrote:
> > On Mon, 18 Oct 2021 16:43:00 +0200, Rich Felker wrote:
>
> No, I don't think so. The musl translator is to translate between the
> time64 ioctl structures and the old time32 ones for the sake of
> executing on an old kernel. Up til now, it has been broken comparably
> to how 32-bit binaries running in compat mode on a 64-bit kernel were
> broken: the code in musl translated the time64 structure to (and back
> from) the time32 one assuming the intended padding. But the
> application was using the actual kernel uapi struct where the padding
> was (and still is) illogical. Thus, nothing was built with the wrong
> ABI; it's only the musl-internal translation logic that was wrong (and
> only pre-time64 kernels are affected).
>
> The attached patch should fix it, I think.
>
> + int adj = BYTE_ORDER==BIG_ENDIAN ? 4 : 0;
> + if (dir==W) {
> +     memcpy(old+68, new+72+adj, 4);
> +     memcpy(old+72, new+72+4+2*adj, 4);

I think that should be "new+72+4+3*adj": the "2*adj" would
be what the code does already for the originally intended
format.

        Arnd
