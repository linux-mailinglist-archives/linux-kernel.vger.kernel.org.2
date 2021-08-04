Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3D13E0620
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 18:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239614AbhHDQqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 12:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhHDQqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 12:46:35 -0400
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F89C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 09:46:22 -0700 (PDT)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1mBK28-007Ez4-PS
        for linux-kernel@vger.kernel.org; Wed, 04 Aug 2021 18:46:20 +0200
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on yawp
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.4
Received: from [2a02:578:460c:1:ae1f:6bff:fed1:9ca8]
        by yawp.biot.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1mBJzQ-007Euu-Vc; Wed, 04 Aug 2021 18:43:33 +0200
Subject: Re: [PATCH 4/5] ARM: Add basic support for EcoNet EN7523 SoC
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     DTML <devicetree@vger.kernel.org>,
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
From:   Bert Vermeulen <bert@biot.com>
Message-ID: <1e3070fe-b5da-0acc-f50b-b0986a1045cd@biot.com>
Date:   Wed, 4 Aug 2021 18:43:32 +0200
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3OuJ3pMSdEA4Rt3aWvvuX2+_Bg5x7-kZ1++fvvJvgGxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/21 4:48 PM, Arnd Bergmann wrote:
> On Fri, Jul 30, 2021 at 3:45 PM Bert Vermeulen <bert@biot.com> wrote:
>> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
>> index 173da685a52e..1bff0aa29c07 100644
>> --- a/arch/arm/Makefile
>> +++ b/arch/arm/Makefile
>> @@ -152,6 +152,7 @@ textofs-$(CONFIG_ARCH_MSM8X60) := 0x00208000
>>  textofs-$(CONFIG_ARCH_MSM8960) := 0x00208000
>>  textofs-$(CONFIG_ARCH_MESON) := 0x00208000
>>  textofs-$(CONFIG_ARCH_AXXIA) := 0x00308000
>> +textofs-$(CONFIG_ARCH_ECONET) := 0x00088000
> 
> Why is this needed?
> 
> Note also the comment directly above it exlaining
> # Text offset. This list is sorted numerically by address in order to
> # provide a means to avoid/resolve conflicts in multi-arch kernels.

I didn't make that patch, but it turns out it's needed to get PSCI working; 
detection hangs without it. That makes no sense to me, but I'll examine further.


-- 
Bert Vermeulen
bert@biot.com
