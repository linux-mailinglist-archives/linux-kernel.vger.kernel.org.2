Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB81441BFA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 14:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbhKAN4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 09:56:17 -0400
Received: from mx.socionext.com ([202.248.49.38]:59494 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231366AbhKAN4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 09:56:15 -0400
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 01 Nov 2021 22:53:41 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 6F1FF203F6D9;
        Mon,  1 Nov 2021 22:53:41 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Mon, 1 Nov 2021 22:53:41 +0900
Received: from yuzu2.css.socionext.com (yuzu2 [172.31.9.57])
        by iyokan2.css.socionext.com (Postfix) with ESMTP id 46B83B62AB;
        Mon,  1 Nov 2021 22:53:41 +0900 (JST)
Received: from [10.212.1.157] (unknown [10.212.1.157])
        by yuzu2.css.socionext.com (Postfix) with ESMTP id C209CB6291;
        Mon,  1 Nov 2021 22:53:40 +0900 (JST)
Message-ID: <3fd7f2a2-9883-af35-b5d1-c9d68875bb48@socionext.com>
Date:   Mon, 1 Nov 2021 22:53:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 09/13] arm: milbeaut: remove select of non-existing
 PINCTRL_MILBEAUT
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Takao Orito <orito.takao@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>
References: <20211028141938.3530-1-lukas.bulwahn@gmail.com>
 <20211028141938.3530-10-lukas.bulwahn@gmail.com>
 <CAK8P3a2J3Eufd_LL7qX=0bui_PwkN1WATqrrigia3f6Z8b1tpg@mail.gmail.com>
From:   Sugaya Taichi <sugaya.taichi@socionext.com>
In-Reply-To: <CAK8P3a2J3Eufd_LL7qX=0bui_PwkN1WATqrrigia3f6Z8b1tpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/10/28 23:55, Arnd Bergmann wrote:
> On Thu, Oct 28, 2021 at 4:19 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>>
>> The patch series "Add basic support for Socionext Milbeaut M10V SoC" (see
>> Link) introduced the config ARCH_MILBEAUT_M10V "Milbeaut SC2000/M10V
>> platform" in ./arch/arm/mach-milbeaut/ and intended to introduce timer,
>> clock, pinctrl and serial controller drivers.
>>
>> However, during patch submission in March 2019, the introduction of the
>> milbeaut pinctrl driver was dropped from v2 to v3 of the patch series.
>> Since then, there was no further patch series to add this pinctrl driver
>> later on.
>>
>> Hence, selecting PINCTRL_MILBEAUT in config is simply dangling and
>> referring to a non-existing config symbols.
>> Fortunately, ./scripts/checkkconfigsymbols.py warns:
>>
>> PINCTRL_MILBEAUT
>> Referencing files: arch/arm/mach-milbeaut/Kconfig
>>
>> Remove this select of the non-existing PINCTRL_MILBEAUT for now.
>>
>> Link: https://lore.kernel.org/linux-arm-kernel/1551243056-10521-1-git-send-email-sugaya.taichi@socionext.com/
>>
>> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> 
> I would take that as an indication that there is no interest in supporting this
> platform upstream any more, the version we merged probably never worked
> without the rest of the drivers.
> 
> I've added the original authors of the other drivers to Cc. Should we remove
> all of this?
> 
>          Arnd
> 

It is okay to drop PINCTRL_MILBEAUT. I will add it again when working at the pinctrl
driver. But don`t remove the milbeaut platform. Actually we haven't been doing
maintenance recently, but we have plans to add drivers in the future.

Thanks,
Taichi Sugaya
