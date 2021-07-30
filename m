Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDDCD3DBBE2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 17:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239517AbhG3PQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 11:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239248AbhG3PQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 11:16:04 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A5BC06175F;
        Fri, 30 Jul 2021 08:16:00 -0700 (PDT)
Received: from [2a04:4540:1401:7a00:2d8:61ff:fef0:a7c3]
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1m9UEe-0004G8-VZ; Fri, 30 Jul 2021 17:15:41 +0200
Subject: Re: [PATCH 4/5] ARM: Add basic support for EcoNet EN7523 SoC
To:     Arnd Bergmann <arnd@arndb.de>, Bert Vermeulen <bert@biot.com>
Cc:     DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Mike Rapoport <rppt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Felix Fietkau <nbd@nbd.name>
References: <20210730134552.853350-1-bert@biot.com>
 <20210730134552.853350-5-bert@biot.com>
 <CAK8P3a3OuJ3pMSdEA4Rt3aWvvuX2+_Bg5x7-kZ1++fvvJvgGxA@mail.gmail.com>
From:   John Crispin <john@phrozen.org>
Message-ID: <d5498cc1-f700-998f-4e98-918081f2ac66@phrozen.org>
Date:   Fri, 30 Jul 2021 17:15:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3OuJ3pMSdEA4Rt3aWvvuX2+_Bg5x7-kZ1++fvvJvgGxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30.07.21 16:48, Arnd Bergmann wrote:
> Given how closely related this probably is to MT7623/MT7622, should this
> perhaps just be part of arch/arm/mach-mediatek? According to
> https://wikidevi.wi-cat.ru/MediaTek#xPON, the older (mips based) MT752x
> chips are apparently just rebranded to EN752x after the business unit
> was spun off, but I guess they are still in the same family.

Hi,

ECNT (what was once known as trendchip) is now a subsidary of MTK (and 
not a BU if I am understanding it correctly).

the EN7523 is rather similar to the MT7622 for some parts, other parts 
(spi, flash, wdt, gpio, .. drivers all needed to be rewritten and will 
be part of the next series).

the older MIPS silicon shares almost no IP with the current ARM silicon.

not really my call to decide which folder this should live in. it seemed 
natural to just give it its own folder, as ECNT is not a BU of MTK.

we can change that however if required.

     John

