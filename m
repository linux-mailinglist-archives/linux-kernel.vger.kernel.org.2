Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C92C3E4604
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 15:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbhHINEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 09:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234285AbhHINEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 09:04:31 -0400
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDA9C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 06:04:11 -0700 (PDT)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1mD4wp-007xCE-IY
        for linux-kernel@vger.kernel.org; Mon, 09 Aug 2021 15:04:08 +0200
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on yawp
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.4
Received: from [2a02:578:460c:1:ae1f:6bff:fed1:9ca8]
        by yawp.biot.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1mD4t3-007x83-Go; Mon, 09 Aug 2021 15:00:13 +0200
Subject: Re: [PATCH 4/5] ARM: Add basic support for EcoNet EN7523 SoC
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        John Crispin <john@phrozen.org>,
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
 <1e3070fe-b5da-0acc-f50b-b0986a1045cd@biot.com>
 <CAMuHMdWni=2ggV7dQiy-nfF1nOmKferbZOCkLp0kDsvMNfwF2Q@mail.gmail.com>
From:   Bert Vermeulen <bert@biot.com>
Message-ID: <c9ec706f-4a55-a716-ed2e-5c04a6f6bffd@biot.com>
Date:   Mon, 9 Aug 2021 15:00:12 +0200
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWni=2ggV7dQiy-nfF1nOmKferbZOCkLp0kDsvMNfwF2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/21 2:46 PM, Geert Uytterhoeven wrote:
>> I didn't make that patch, but it turns out it's needed to get PSCI working;
>> detection hangs without it. That makes no sense to me, but I'll examine further.
> 
> Probably PSCI relies on the memory contents at the start of RAM not
> being overwritten?

It turns out to hang at the first SMC call, for PSCI_0_2_FN_PSCI_VERSION. I 
assume the receiver of that call, ATF, got dropped in that region by the 
vendor's U-Boot.

> Does it help if you remove the first 512 KiB from the /memory node
> (which should be declared in en7523-evb.dts instead of en7523.dtsi
> BTW)?
No it doesn't, was just trying to work out why not, in your 
fdt_check_mem_start().

Anyway that was Arnd's first suggestion, but I think his second suggestion 
(teach fdt_check_mem_start() about /memreserve/) is the cleaner approach to 
this. Opinions?


-- 
Bert Vermeulen
bert@biot.com
