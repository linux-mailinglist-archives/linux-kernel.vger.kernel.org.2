Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4919F4583C8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 14:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237994AbhKUNVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 08:21:35 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:44015 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236405AbhKUNVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 08:21:33 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MidPj-1mCA0C0raB-00flBB for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021
 14:18:27 +0100
Received: by mail-oi1-f172.google.com with SMTP id s139so32028433oie.13
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 05:18:27 -0800 (PST)
X-Gm-Message-State: AOAM532vnnmjla0aRk4KBFhmcRg0IpT7mJBrGK3IGlJWTVV+qNBf2dYL
        r61oOJhLwy4rGtCZn8qI6sZ6p7ZrconcZrDiJpA=
X-Google-Smtp-Source: ABdhPJxF21qjfMuWZFlLNCPKu+y3IOySCFfDq2FMuj0sbiUW9pDP9pIX9bg/3xsZR9dHW5yxi7DZTCNAun2vqKxQ64w=
X-Received: by 2002:a54:4e93:: with SMTP id c19mr14332057oiy.11.1637500705949;
 Sun, 21 Nov 2021 05:18:25 -0800 (PST)
MIME-Version: 1.0
References: <20211119113644.1600-1-alx.manpages@gmail.com> <20211120130104.185699-1-alx.manpages@gmail.com>
 <20211120130104.185699-13-alx.manpages@gmail.com> <YZkOolX1SBsqXAsP@localhost.localdomain>
In-Reply-To: <YZkOolX1SBsqXAsP@localhost.localdomain>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 21 Nov 2021 14:18:09 +0100
X-Gmail-Original-Message-ID: <CAK8P3a23xv=FtTcpO=R-uDXJPor4sQ_MZr92oSXE4Ez6gpg03g@mail.gmail.com>
Message-ID: <CAK8P3a23xv=FtTcpO=R-uDXJPor4sQ_MZr92oSXE4Ez6gpg03g@mail.gmail.com>
Subject: Re: [PATCH v2 12/20] linux/must_be.h: Add must_be() to improve
 readability of BUILD_BUG_ON_ZERO()
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:gh7BF0JcyLgQryqW7955zRhBtB5HtggiKGxzFqQOCOARmWDLtgG
 qDjXbGG+J/DmRqvRSOt3IMVHTB9g6fwWAHd2pKCeh0q5yWIRuMTuFiIWu6SJFbZjJZyRZYf
 jUCX/LFmqzDAw+ViiZW2zuC5NLfRQjPezM/rPwG4dKsM/A55mIDXTPIzsthASvn8/aIykPg
 kzgb3VgGkngSBzH/ryCAw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gk2BvdF6smU=:nCaLv64gvaR8HWoKaeH9UQ
 KqIkj5uXcJZIVx7prc50Qc8fJz7RnJlXdol352/7KnLbE3jVU1mNF6378pbnjrx9gIAq4Vdr9
 P/HG3yVACJvgjyMJWL19aICBYJtbt+nj++KngUC2JoNyYKPIa2eAXmSHvSuwQwYKkOUQPfVAV
 OfM2/SHlJVvNEj9NvBogRs6sXykPecn36Nh+Z8VeZOW1eri1x+rFQq3PHRLxP7ppv/XQCUm5j
 ChIpQ81370ec+HTx5Sj5DYbuDk/uvR99zmTV9QF27+AYzDVRB8/hxXWxctqgWpKJhk2fYOvY/
 eiP+DONJhm2hfQCZN/Zlxdyy/bUClGh7BQijf2Rki53vWbINJmDhbrFDSwDSmgViJwaVT04I1
 m7tQcKgQwWSlXWgKre4R03R6KiKs3sKtblq9O/vefM1hxmjpxn3auM2cAduGO13uNKIY0+30l
 4uCpKKhK9DNWE67S/eCtQXfdePloegM97JkDAgTCbdaAA1e7lCQCEqwOjiPs727yZ4ntjo01c
 AJEvPi/AWkTwwWY5/YmEPXuQUD2QhKdhw5MY8f4J3RdGDLGesa0fazk17JNyXR9v/BTaG7mbM
 nds6yqXdPAIQ8LR3zw/Yk/dcxWWS8RRfxdHKV2XE8LbVJM+uJbwR20ThqjiLxymq2nkOfjjNL
 UBCOJj4fnOxpnxt9Y+xtekhSyzyF57wq/UjGX5SryjWl4jGu3ec3yqqrK3RntNDbRWD4=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2021 at 4:05 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> On Sat, Nov 20, 2021 at 02:00:55PM +0100, Alejandro Colomar wrote:
> > Historically, BUILD_BUG_ON_ZERO() has been hard to read.
> > __must_be_array() is based on BUILD_BUG_ON_ZERO(),
> > and unlike BUILD_BUG_ON_*(),
> > it has a pretty readable name.
>
> The best name is assert() which userspace uses and is standartised.

I would argue that this macro is best left out: we have BUILD_BUG_ON()
as the interface that everyone knows, having another macro that has the
same results only makes things more confusing, and I would ask anyone
using it to use an open-coded BUILD_BUG_ON instead.

      Arnd
