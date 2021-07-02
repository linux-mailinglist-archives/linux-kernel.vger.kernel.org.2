Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96DBF3BA3B2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 19:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhGBRkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 13:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhGBRkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 13:40:39 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E865C061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 10:38:06 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bu19so19422986lfb.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 10:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WpdDBxDMBs/WCCCImI7VyqZUSL1kP05tbh9WXy7wNK0=;
        b=PpN2fsja1OJcME+2CirfdTO3iN2F/OVfNiWaWcbQOA/BpqctwIEedC7XYlHF6Bbglt
         lS8T9rburjedu9IwMv6RiWbYNPL407MvWVlQCo5xFxNNyf1kt+n9mXxCYqdmkysIY2YN
         nhs6MyyL/2y2ThZSjH7PQMgUEGonR/J03oQezLUUThRE0DUuS1C5jvHs3vUMUigCXpz/
         gpbuy+Op0xs9RXpTUEPUY23WQK2FcfoWMGxSfrr0n4axG9KobqfGw3MJGlbg47qgQAgx
         Ixj1PZbhf4nANquUIk6Qch9NXwuoLWCizxiDlT1W3v4hFIxJ8VgGqazToF2w2GPfZQY2
         kJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WpdDBxDMBs/WCCCImI7VyqZUSL1kP05tbh9WXy7wNK0=;
        b=m2DBWlLjKDmSS5XLApcAlNZlTHNGPzAvYFzEEolFRxM7I9wMnjsCQVhoZTVuip/Trv
         3b6ND5usTkUAwlCQcMdqzYPPr9ynM/2VS6WpStIOEQN032jMyYGx+Xhb+SaZlDk2wCUY
         zaTOmkKIVFBlk5749r4kqdxq8blG3nL1a8L/GrnjEeTbHfSqxmI77BOFEk0S85Xr5Ni2
         Yd17VWL60PGGsyC5kj6lbC3drnd0rc4VYBLZxgzHYsUoSah5nvkoW1We9GHpVpFcJcOD
         Hs9h4jOMYYH5/00JlNtlWhIsIOqrWoQztae4roaQ/3kdxp5GfaIW7ZNjDv5TPLDRhKXg
         HaLA==
X-Gm-Message-State: AOAM533LIxS4BhdjeICwIJMpirOGq+WgiqYffbgDS+KH18D9+11q2K8D
        26WAG+q9UVEsZdhe6Kk+PU8OcE2eZZUpzxZwjIFQVA==
X-Google-Smtp-Source: ABdhPJzPzADyvvllP+dD3SLnwT8KiA7SBjf2of4t2qoqIGexZGVQSqb/cnyeql4hfCh8M+8AvR7ZWbv8clVdr6OB2pA=
X-Received: by 2002:a05:6512:ad2:: with SMTP id n18mr531247lfu.543.1625247484188;
 Fri, 02 Jul 2021 10:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210701235505.1792711-1-ndesaulniers@google.com> <bea79143-b2b8-b7a4-0456-4a593f03907f@redhat.com>
In-Reply-To: <bea79143-b2b8-b7a4-0456-4a593f03907f@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 2 Jul 2021 10:37:53 -0700
Message-ID: <CAKwvOdn7QgF2OS_uvV+-mg-7ZeaL316TXhZYziVBbJctyWZGXw@mail.gmail.com>
Subject: Re: [PATCH] arm64: drop CROSS_COMPILE for LLVM=1 LLVM_IAS=1
To:     Tom Stellard <tstellar@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 1, 2021 at 6:05 PM Tom Stellard <tstellar@redhat.com> wrote:
>
> On 7/1/21 4:55 PM, 'Nick Desaulniers' via Clang Built Linux wrote:
> > We get constant feedback that the command line invocation of make is too
> > long. CROSS_COMPILE is helpful when a toolchain has a prefix of the
> > target triple, or is an absolute path outside of $PATH, but it's mostly
> > redundant for a given ARCH.
> >
> > If CROSS_COMPILE is not set, simply set --target=aarch64-linux for
> > CLANG_FLAGS, KBUILD_CFLAGS, and KBUILD_AFLAGS.
>
> Are there plans to do this for other architectures?

Yep, just starting small to collect feedback on the idea before
blasting maintainers with more patches. The goal is to handle this in
a per arch/ manner, rather than the top level Makefile.
-- 
Thanks,
~Nick Desaulniers
