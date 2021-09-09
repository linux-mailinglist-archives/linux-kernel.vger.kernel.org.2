Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4DF44048B9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 12:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbhIIKyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 06:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbhIIKyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 06:54:24 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BBCC061575
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 03:53:15 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id n27so2003387oij.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 03:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fU5ufvRRjTtfwnNvK13MR5zMOLz3I8fk1OzlUMqINLQ=;
        b=svEsGSMujFvTtR4UMtARJNXuZvz+U/550aXRIc+7UMzXzxYASPNNCNz75C6NHgXQGg
         dVJIPTelpAL58scaurL0kBQOQTMznlEy8QRnyHQfYxdvgW794LiM1IeQsfZLCEJ22GDQ
         qeYJDSw9yib0rswsAY4EiMIpR09/rniDzcmwUBU47L1cdLS7q206vZncbq5ddz/unqpR
         JjT6q7GZ3YxYt0F0WB2frZxiJ2+sILr+1ax6Ri2HSHO4/nyZOnqbiOVisCjJQDDu6QAo
         hcv1jpLE7VOWgiP2TLIVuvoIKnrgb/YQjoBfw63Ub7F4cpzR210zw6O/4AgWl9NTv+i7
         YCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fU5ufvRRjTtfwnNvK13MR5zMOLz3I8fk1OzlUMqINLQ=;
        b=c3c2LU4qn6C3EsI3Moeav3RxnMf01jh7y4t60nK5iWeLxwt+SL/WeiEyBknjGZKYYi
         paShmYt038N2nDCfh/AIE8ikOf8l26e3KDfULJ95Onm99+gKW/Pv7oYjm1qtlzM5N62X
         tRRgqlFC/mEIPoZYRV8z84YMAnLFaSLTWCTSuqXoXUumDvx22NXqxqs9wTEPQIcDW0RP
         XbJJypLE38z6VkKg585ms9q2q7fZHc5eRxCrUvWnez7z08CHl80f0WC+AkcfZs/PYbyQ
         u8xPrXdPwr2fi85xd6VJ+Y5om1Vy3Hc+tiLOjgALzHVcrnx4cpLVZYliaRLzDHHMRhrX
         vvLQ==
X-Gm-Message-State: AOAM531qTS3BYtyTDdPm1p5BgR70Ke22lyMYb6O/kX/57c5LaGHN41kl
        qxScVsEgkh/nL+yrUUkOJ+nbilFL0wjJ/0215H3l0Q==
X-Google-Smtp-Source: ABdhPJypirAM1jjdo9XWTXuE1r/IYJFmD049z7WphsmfidtaQM2qvedJJrF7FPI9vKRmcHUWVT9heQSyJAVB96uljac=
X-Received: by 2002:a05:6808:21a5:: with SMTP id be37mr1443831oib.172.1631184794726;
 Thu, 09 Sep 2021 03:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210906142615.GA1917503@roeck-us.net> <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <YTbOs13waorzamZ6@Ryzen-9-3900X.localdomain> <CAK8P3a3_Tdc-XVPXrJ69j3S9048uzmVJGrNcvi0T6yr6OrHkPw@mail.gmail.com>
 <YTkjJPCdR1VGaaVm@archlinux-ax161> <75a10e8b-9f11-64c4-460b-9f3ac09965e2@roeck-us.net>
 <YTkyIAevt7XOd+8j@elver.google.com> <YTmidYBdchAv/vpS@infradead.org>
In-Reply-To: <YTmidYBdchAv/vpS@infradead.org>
From:   Marco Elver <elver@google.com>
Date:   Thu, 9 Sep 2021 12:53:03 +0200
Message-ID: <CANpmjNNCVu8uyn=8=5_8rLeKM5t3h7-KzVg1aCJASxF8u_6tEQ@mail.gmail.com>
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev@googlegroups.com,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Sept 2021 at 07:59, Christoph Hellwig <hch@infradead.org> wrote:
> On Wed, Sep 08, 2021 at 11:58:56PM +0200, Marco Elver wrote:
> > It'd be good to avoid. It has helped uncover build issues with KASAN in
> > the past. Or at least make it dependent on the problematic architecture=
.
> > For example if arm is a problem, something like this:
>
> I'm also seeing quite a few stack size warnings with KASAN on x86_64
> without COMPILT_TEST using gcc 10.2.1 from Debian.  In fact there are a
> few warnings without KASAN, but with KASAN there are a lot more.
> I'll try to find some time to dig into them.

Right, this reminded me that we actually at least double the real
stack size for KASAN builds, because it inherently requires more stack
space. I think we need Wframe-larger-than to match that, otherwise
we'll just keep having this problem:

https://lkml.kernel.org/r/20210909104925.809674-1-elver@google.com

> While we're at it, with -Werror something like this is really futile:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_object.c: In function =E2=80=98amdgpu_b=
o_support_uswc=E2=80=99:
> drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:493:2: warning: #warning
> Please enable CONFIG_MTRR and CONFIG_X86_PAT for better performance thank=
s to write-combining [-Wcpp
>   493 | #warning Please enable CONFIG_MTRR and CONFIG_X86_PAT for better =
performance \
>       |  ^~~~~~~
