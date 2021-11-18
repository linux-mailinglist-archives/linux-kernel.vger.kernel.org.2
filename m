Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4E74554E6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 07:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243459AbhKRGyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 01:54:20 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:33901 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243445AbhKRGyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 01:54:03 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MEmMt-1muQcl3yMF-00GHfq for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021
 07:50:56 +0100
Received: by mail-wm1-f50.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so3963915wmz.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 22:50:56 -0800 (PST)
X-Gm-Message-State: AOAM5328HtxdJHaDywPeanQWhpSp/Yl1dcL9Ee0O2f5Q6/4Fzom7JUk0
        082tGphvM9xARR/meb0hqjKRqT+drqWtKoQjdh4=
X-Google-Smtp-Source: ABdhPJyHvxob/UuoSUzAd4c5/hOqO7PUFiJTJfkYO0PtcEpImuf2l7+kFCPvNXXbbQ5QdTISxt9uzKaFtJ1GvZoteGU=
X-Received: by 2002:a7b:c050:: with SMTP id u16mr7168120wmc.82.1637218256583;
 Wed, 17 Nov 2021 22:50:56 -0800 (PST)
MIME-Version: 1.0
References: <20211118062146.11850-1-rdunlap@infradead.org>
In-Reply-To: <20211118062146.11850-1-rdunlap@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 18 Nov 2021 07:50:40 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1s_toN_J=M8gxcVrtEazZ+Mu9UYbKMVkG3MzDLSCEOfQ@mail.gmail.com>
Message-ID: <CAK8P3a1s_toN_J=M8gxcVrtEazZ+Mu9UYbKMVkG3MzDLSCEOfQ@mail.gmail.com>
Subject: Re: [PATCH] sound/oss/dmasound: fix build when some drivers are =m
 and others are =y
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:5bTfNGnK/TtEzYaLjRVl62MUNa/blno+9rLOd0hzd+U7IrIIw31
 N2Wfvd45V3R7zUTMa6+jxw04pLP2WTBqGFoBbQnH4IncZ6ZMjURpo/WX/p5I6RTR8vjw2zU
 tnbHyO3UTmyOTiCb6/HZeC9rBxaNw/S2MqZSG/wJFKsK4Boa0YGWS5ycZYs3kqc7FJBMaMU
 6tOLcl8aZHEdBShdMh9mQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hQpx1jRJvRg=:DEaK/E+CDAZIuP7Rqmyap2
 ORPKQLSQWj5jDV0vSkuVfjJqBUVqLcmVGkZtx2BxdAz9nca2qkoJ4RD0aNNbpIeYJQg67+m2l
 L5Omtfw3q5gTG+bmzX0ZFpl32frVrXSfIPF66Sp5E2zW0NFxMwg5T4lWgfSSOOdzkMMGBacPN
 VIhXVz9GMT1k+Kt5b193dimYjfFqlZTmD6eO92JntdRhb4LDRm3Cm63stOyzgGSf7JUJ85sZ0
 yZD2JDnXgA/jvOXMP73MPBE9kJl8qQxU76YL38HSAYk/Cvkc8SvIY+U285NasBPC1I9wJy3a2
 o5RpbJGSCjJTEZqBD4y6QGiD+ydXnGZyVTRaYYXT40QCrc+Ucc1opnFhPa+jZKnXw9ktNuqPK
 VGv5FvRF4zT2VLgdKEGQT/tiBTUZDZYbEqHAH8yQXCZYPna4MpnCL6dgLCgVtxFAIU5b3dtnN
 +v4X/VPaSwGY3XS3fEUmaKF86Hals8fIlF1gWfbw5fA+zmlzZz27BuzJ6xiEYOAKiMNWVrtDY
 TPOzEgOw1+8d+AXWQNqV7TjXplctGa07rY+oM2/G8F/GiOaJ5TGk7ykRlHKzH+hLsclRtF6oG
 fe8KqZ6BLl10/UQVUfjTR9oRw8Z7ICi380GVvvLaVvNfivlaacbctErXst6doa1j8loXoM3Ay
 EdJUCwhXE8IC00gsjhrd54oFUS89/CkYgZYBOqUUvQeYx6hj5xyM1lxfv2SbGCGuwMYw=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 7:21 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> When CONFIG_DMASOUND_ATARI=y and CONFIG_DMASOUND_Q40=m,
> dmasound_atari.o is built first (listed first in the Makefile),
> so dmasound_core.o is built as builtin, not for use by loadable
> modules. Then dmasound_q40.o is built and linked with the
> already-built dmasound_core.o, but the latter does not support
> use by loadable modules. This causes the missing symbol to be
> undefined.
>
> Fixes this build error:
> ERROR: modpost: "dmasound_deinit" [sound/oss/dmasound/dmasound_q40.ko] undefined!

I suspect your patch now breaks the case where multiple drivers are
built-in, because that puts the same global symbols into vmlinux more
than once.

> -EXPORT_SYMBOL(dmasound);
> -EXPORT_SYMBOL(dmasound_init);
> -#ifdef MODULE
> -EXPORT_SYMBOL(dmasound_deinit);
> -#endif

From a very brief look, I would think that removing this #ifdef and
unconditionally defining dmasound_deinit is the correct solution
here, to solve the case of the core driver being built-in but called
from a loadable module, the Makefile logic is otherwise correct.

         Arnd
