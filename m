Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0950A34A0A8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 05:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhCZEi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 00:38:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230304AbhCZEih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 00:38:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F37661A42
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 04:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616733516;
        bh=uakzJgslqMTRUR4ZuQ0ajYK6JKqrawmOg9EDLLj6Hn4=;
        h=From:Date:Subject:To:From;
        b=FgWk9p8HZzum1R881d868RdocD6VtcQ4jhJsVLjpTQhyKL9BwhMi1Xu/lmCSlMW+k
         osY+LqNLEf3PPNoRK8JfAXR+VFGVX8ePUxmoRarCe5utDob0OPHqCMGAKySMvKF75p
         lk4D1VkWaHqDMejsimqBqJFiUCuXt+Py4U2Yzeoc+QtPT6JIRUa35Wsc+S0sUtUiGy
         TajU99e9+qukruoaaqiKWyeZN8h2yFsd6NcjPSJbSFRqTwP0CntaxoFpJynGkv0i/s
         9bE96O74R5E9CHzo/UmP8jlijucHoVCT+M1cMygEGNsUhqAH4lPq7It3aouH2qz6W+
         USw0F/xCn2Zdg==
Received: by mail-ej1-f41.google.com with SMTP id u9so6447787ejj.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 21:38:36 -0700 (PDT)
X-Gm-Message-State: AOAM5325cBFMOi0v+ZNu68JYV0DlReU2+jugf0Q5Nw5Vq7KqJu6KeiOS
        EGCdwooCRkCgNf3U8rOfNBLuaeyxSGKaPfmP68zvHg==
X-Google-Smtp-Source: ABdhPJwrq9vL7MDIknae1FtSjIxsX7tXBeWqhfyBOFoJu+dGld0VB31n6SdyJjzLfhRygyYsSreIlEvS3NlBd5+YniM=
X-Received: by 2002:a17:906:7e12:: with SMTP id e18mr13718403ejr.316.1616733514967;
 Thu, 25 Mar 2021 21:38:34 -0700 (PDT)
MIME-Version: 1.0
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 25 Mar 2021 21:38:24 -0700
X-Gmail-Original-Message-ID: <CALCETrURmk4ZijJVUtJwouj=_0NPiUvUFr9XMvdniRRFqeU+fg@mail.gmail.com>
Message-ID: <CALCETrURmk4ZijJVUtJwouj=_0NPiUvUFr9XMvdniRRFqeU+fg@mail.gmail.com>
Subject: Why does glibc use AVX-512?
To:     libc-alpha <libc-alpha@sourceware.org>,
        "H. J. Lu" <hjl.tools@gmail.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Rich Felker <dalias@libc.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all-

glibc appears to use AVX512F for memcpy by default.  (Unless
Prefer_ERMS is default-on, but I genuinely can't tell if this is the
case.  I did some searching.)  The commit adding it refers to a 2016
email saying that it's 30% on KNL.  Unfortunately, AVX-512 is now
available in normal hardware, and the overhead from switching between
normal and AVX-512 code appears to vary from bad to genuinely
horrible.  And, once anything has used the high parts of YMM and/or
ZMM, those states tend to get stuck with XINUSE=1.

I'm wondering whether glibc should stop using AVX-512 by default.

Meanwhile, some of you may have noticed a little ABI break we have.
On AVX-512 hardware, the size of a signal frame is unreasonably large,
and this is causing problems even for existing software that doesn't
use AVX-512.  Do any of you have any clever ideas for how to fix it?
We have some kernel patches around to try to fail more cleanly, but we
still fail.

I think we should seriously consider solutions in which, for new
tasks, XCR0 has new giant features (e.g. AMX) and possibly even
AVX-512 cleared, and programs need to explicitly request enablement.
This would allow programs to opt into not saving/restoring across
signals or to save/restore in buffers supplied when the feature is
enabled.  This has all kinds of pros and cons, and I'm not sure it's a
great idea.  But, in the absence of some change to the ABI, the
default outcome is that, on AMX-enabled kernels on AMX-enabled
hardware, the signal frame will be more than 8kB, and this will affect
*every* signal regardless of whether AMX is in use.

--Andy
