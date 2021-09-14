Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC3A40BACF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 23:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbhINV5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 17:57:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232332AbhINV5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 17:57:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5AEF6121E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 21:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631656588;
        bh=Ll67rbRc4gUJ+9O6OdSRmSgY9jfPA8IAo6JjA+x1hKU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Udg92vXYImQdyjpQl+ASXx87nMDQoj2aOOHovGwilHCR+klPFzIhRcEeFsGQXmfUt
         xpdhwREuaTG2c15927DSgbzrValOG471FoHq6NaYXbkbT6TrP+lLXNMGCqtNEy7+xp
         NOIu4AGcWgrdEzEp2dRut4gVfP/nFzIIyWW+hPncI9AWEGZ1OgLt0oV8WIFnfpkCuz
         I0djqguPVpltb8MdQWCFYuXN5/RY+Kwn2OtgFLw1RNBB9V/n3Kyafkdh9mrRUVZjIb
         IP/R3j+anRGh1ql3vIqGSX/KwXD2NHEeTASgPPQc3ix2iY2FmlcOS37kWa8VXjPcdx
         mQ1DyoNaymn3Q==
Received: by mail-wr1-f43.google.com with SMTP id t18so642891wrb.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 14:56:28 -0700 (PDT)
X-Gm-Message-State: AOAM531yI15RgSZWEEdQYxaDysBi152H8khKVoJe3eUoiBgnsV70afIS
        YHLxOc3dRRH0OPlBAVSsopyRu9Bbn40q57EOZkQ=
X-Google-Smtp-Source: ABdhPJwsJiXicBpos94epT3BeGaurFR0M7Eaki/aPYqnwGuBJ4F62qUa2Keqa9OxSn+hcsUV7Is58Qm+qSntB7EzDHY=
X-Received: by 2002:a5d:528b:: with SMTP id c11mr1274072wrv.369.1631656587222;
 Tue, 14 Sep 2021 14:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210914210508.10627-1-harry.wentland@amd.com>
In-Reply-To: <20210914210508.10627-1-harry.wentland@amd.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 14 Sep 2021 23:56:11 +0200
X-Gmail-Original-Message-ID: <CAK8P3a243ruO-7H79yZ49_+5RVQk4V7kE_=Ffy7Gko-um_0VBA@mail.gmail.com>
Message-ID: <CAK8P3a243ruO-7H79yZ49_+5RVQk4V7kE_=Ffy7Gko-um_0VBA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Reduce stack size for dml21_ModeSupportAndSystemConfigurationFull
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 11:05 PM Harry Wentland <harry.wentland@amd.com> wrote:
>
> [Why & How]
> With Werror enabled in the kernel we were failing the clang build since
> dml21_ModeSupportAndSystemConfigurationFull's stack frame is 1064 when
> building with clang, and exceeding the default 1024 stack frame limit.
>
> The culprit seems to be the Pipe struct, so pull the relevant block
> out into its own sub-function.

I suspect it's not the Pipe struct but rather the way that you call another
function with a crazy number of arguments here. After your change,
this likely gets inlined and you avoid the problem, so the patch ends
up doing the right thing.

If you do more patches like this, I would suggest mentioning the new
stack usage of the calling function and the new noinline function, to
make sure that the combined number isn't actually worse than the old
number.

You can get these numbers by recompiling the file with the frame
size warning set to a low value, e.g. adding -Wframe-larger-than=100
to the command line.

Acked-by: Arnd Bergmann <arnd@arndb.de>
