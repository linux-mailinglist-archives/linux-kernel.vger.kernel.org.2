Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D36400324
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 18:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349559AbhICQVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 12:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349473AbhICQVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 12:21:47 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA00C061575;
        Fri,  3 Sep 2021 09:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:Subject:From:References:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yVI1rjL5vV/OruuyOIPK5N7j58pINxHw/fSO+qqgp3c=; b=dpe2n5XAUNjnjSryQQTPYGPiTv
        FDwzV89/Tld9LUaC4j5GmI9f+LLZEjxUJHRJ/W/pEMa8xNqQGLM3mQz2AL+dFEQC9xGAJSCubN179
        NXyDyv9fmc3L/MdsLMb1PjeaAVp2RjHlznn3RToT6dD40J04qr9jKzdqGXci/HQ7AjNw=;
Received: from p4ff13206.dip0.t-ipconnect.de ([79.241.50.6] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mMBvU-0005Rj-Ol; Fri, 03 Sep 2021 18:20:24 +0200
To:     Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     Bert Vermeulen <bert@biot.com>, DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        John Crispin <john@phrozen.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Mike Rapoport <rppt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
References: <20210730134552.853350-1-bert@biot.com>
 <20210730134552.853350-5-bert@biot.com>
 <CAK8P3a3OuJ3pMSdEA4Rt3aWvvuX2+_Bg5x7-kZ1++fvvJvgGxA@mail.gmail.com>
 <CAMj1kXFK+HoouMMBbHxEgm-zQqKa6QMS6keeZmhpXTc4FCy8fQ@mail.gmail.com>
From:   Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH 4/5] ARM: Add basic support for EcoNet EN7523 SoC
Message-ID: <7d3e2c5b-931c-1f82-77a3-fc51268f1986@nbd.name>
Date:   Fri, 3 Sep 2021 18:20:23 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXFK+HoouMMBbHxEgm-zQqKa6QMS6keeZmhpXTc4FCy8fQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021-08-01 18:44, Ard Biesheuvel wrote:
> On Fri, 30 Jul 2021 at 16:48, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> Why is this needed?
>>
>> Note also the comment directly above it exlaining
>> # Text offset. This list is sorted numerically by address in order to
>> # provide a means to avoid/resolve conflicts in multi-arch kernels.
>>
> 
> Yes, please drop this - it is a horrible hack and it's already quite
> disappointing that we are stuck with it for the foreseeable future.
> 
> So I assume the purpose of this is to protect the first 128k of DRAM
> to be protected from being overwritten by the decompressor?
> 
> It would be best to move this reserved region elsewhere, but I can
> understand that this is no longer an option. So the alternatives are
> - omit this window from the /memory node, and rely on Geert's recent
> decompressor changes which make it discover the usable memory from the
> DT, or
> - better would be to use a /memreserve/ here (which you may already
> have?), and teach the newly added decompressor code to take those into
> account when choosing the target window for decompressing the kernel.
I looked into this issue myself and found that this approach has a
significant drawback: 2 MiB of RAM is permanently wasted for something
that only needs to be preserved during boot time.

If the first 256 or 512 KiB of RAM are reserved in the decompressor, it
means that the first 2 MiB need to be reserved, because that's the
granularity for the kernel page mapping when the MMU is turned on.

If we reserve it, we also need to need to take it out of the physical
RAM address range, so there's no way to reclaim it later.

On the other hand, with the simple textofs solution, I believe it gets
freed in a late initcall, making it usable.

So what's the right approach to deal with this?

- Felix
