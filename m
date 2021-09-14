Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C47A40AD0F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 14:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbhINMLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 08:11:21 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:40687 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbhINMLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 08:11:20 -0400
Received: by mail-wm1-f48.google.com with SMTP id b21-20020a1c8015000000b003049690d882so1861282wmd.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 05:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JC+0egzoxCxJUo8E1fbA/DfFivG3yL6BUgvb6VoV5CU=;
        b=3QERxThl2pIri5xi0Q/kqcc1kavZ3s3Kps3/1RSdkZOSdWgkqu/K6tJZ5x9Pzl2rc6
         yFX8pwMxsFNSg+3hXbeuBQOjjcqW7hbuyGHJZENAPv7irSsX3iAziTXrqYqGdY3HLsmH
         1JoCfLXwt8P5FUfwBYjan+kJrbRcfsS6m/pL5HG83fs6i5QHoQ3Xmg8Rk+j9/6pj691r
         yuqF9B6XdWRj9Fq4BtL9RiE77YjPTGSFv9cxMB9JAh6/ooQ2yO1ziOuLa45HDgoJIAH+
         fw3UgGeLRyIFWFmmw8nZgrTRpDxfMXt5QFcw/TPcqTPZTyU+qX3QX/ppltazahVasBMR
         dlDg==
X-Gm-Message-State: AOAM530BKvhs11W1pbkTm13rJXSGkshaOJQE7wu23V+VqW/uJ6DFyzhI
        E1nrujFJe2foB8/zekhxKfk=
X-Google-Smtp-Source: ABdhPJyXiOMLsQcId48736yD0d9P0Do+Tu3NqR6NebXOOXjYSNDBRPjQRirT5BlPGhLSChrAEirPWA==
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr1806704wmb.112.1631621402557;
        Tue, 14 Sep 2021 05:10:02 -0700 (PDT)
Received: from [192.168.3.211] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.googlemail.com with ESMTPSA id m29sm10925063wrb.89.2021.09.14.05.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 05:10:01 -0700 (PDT)
Subject: Re: [RFC PATCH V4 6/6] riscv: soc: Add Allwinner SoC kconfig option
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        =?UTF-8?Q?Christoph_M=c3=bcllner?= <christoph.muellner@vrull.eu>,
        philipp.tomsich@vrull.eu, Christoph Hellwig <hch@lst.de>,
        liush <liush@allwinnertech.com>, wefu@redhat.com,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        taiten.peng@canonical.com, aniket.ponkshe@canonical.com,
        heinrich.schuchardt@canonical.com, gordan.markus@canonical.com,
        Guo Ren <guoren@linux.alibaba.com>,
        Chen-Yu Tsai <wens@csie.org>
References: <20210911092139.79607-1-guoren@kernel.org>
 <20210911092139.79607-7-guoren@kernel.org>
 <20210913084520.kkbsupogkzv226x3@gilmour>
 <CAJF2gTT_8VLTt0B=LxXAPWVpHaBaVxy+V0rGCjr7JZyRiO7LfQ@mail.gmail.com>
 <d2ac3da8-f4d5-52c1-da7f-f8260a0bb604@infradead.org>
 <CAJF2gTTVj2J6_rCXAG81PB3vJZO2TTwpD03vAE2q+K=9zh_TzQ@mail.gmail.com>
 <CAK8P3a1TY+XT1vF=wAh0XA5BXU5Z6Ab1d4DekXbVsN9aj3aL5w@mail.gmail.com>
 <CAJKOXPdH0C0CJe_oxZ2rG1UeE5G9w2mh2Thh8LynpNHQk2g1qA@mail.gmail.com>
 <20210914101327.47baun6mop3mc56j@gilmour>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <c9b18cf8-d432-8636-52f5-a40a342135fe@kernel.org>
Date:   Tue, 14 Sep 2021 14:09:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914101327.47baun6mop3mc56j@gilmour>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2021 12:13, Maxime Ripard wrote:
> On Tue, Sep 14, 2021 at 12:07:08PM +0200, Krzysztof Kozlowski wrote:
>> On Tue, 14 Sept 2021 at 11:31, Arnd Bergmann <arnd@arndb.de> wrote:
>>> Some subsystem maintainers want drivers to be selected by the SoC
>>> option, this is why you need the 'select SIFIVE_PLIC', but usually
>>> the drivers are selectable with a 'depends on ARCH_SUNXI ||
>>> COMPILE_TEST' and enabled in the defconfig.
>>
>> I would say selecting drivers is even more useful for distros and
>> other downstream users. Especially in the ARM world where we have so
>> many different SoCs - how could a distro person know which driver is
>> necessary, important or useful? Having all main SoC drivers enabled
>> when ARCH_SUNXI=y, helps distro a lot.
> 
> Imply, maybe, but select is far too painful for everyone else.

If we talk about UART driver, then sure - imply makes sense. But if we
talk about core SoC components necessary for boot (e.g. timers, clocks,
pinctrl), then select is appropriate. There is no point to enable
ARCH_XXX without these core components.


Best regards,
Krzysztof
