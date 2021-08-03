Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23ED53DF1F1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 17:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237189AbhHCP7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 11:59:45 -0400
Received: from mail.savoirfairelinux.com ([208.88.110.44]:40922 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237184AbhHCP7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 11:59:41 -0400
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Aug 2021 11:59:41 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.savoirfairelinux.com (Postfix) with ESMTP id 897E09C0C99;
        Tue,  3 Aug 2021 11:52:10 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
        by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id D5cXTajtjGVF; Tue,  3 Aug 2021 11:52:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.savoirfairelinux.com (Postfix) with ESMTP id 178419C1908;
        Tue,  3 Aug 2021 11:52:10 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
        by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ko32_KOWxwba; Tue,  3 Aug 2021 11:52:09 -0400 (EDT)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
        by mail.savoirfairelinux.com (Postfix) with ESMTP id CD2A59C0C99;
        Tue,  3 Aug 2021 11:52:09 -0400 (EDT)
Date:   Tue, 3 Aug 2021 11:52:09 -0400 (EDT)
From:   Jerome Oufella <jerome.oufella@savoirfairelinux.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     martinwguy <martinwguy@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        SoC Team <soc@kernel.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        Hubert Feurstein <hubert.feurstein@contec.at>,
        Lukasz Majewski <lukma@denx.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Message-ID: <817752520.64672.1628005929651.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <CAK8P3a2z_xxpz9hAYoBx5=bS81V=TkjEU6WHNhPi1UhQ3UScfw@mail.gmail.com>
References: <20210802141245.1146772-1-arnd@kernel.org> <CAL4-wQqCL1S-GYu7VKJeTT37wh=rR=SMUuwgKiXnnn_Y=uydOA@mail.gmail.com> <CAL4-wQpKLtSj0xfNUXXLhbtN1wC051jpRneAuLYOi1riZfiinw@mail.gmail.com> <CAK8P3a2z_xxpz9hAYoBx5=bS81V=TkjEU6WHNhPi1UhQ3UScfw@mail.gmail.com>
Subject: Re: [PATCH] ARM: ep93xx: remove MaverickCrunch support
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_4101 (ZimbraWebClient - GC92 (Linux)/8.8.15_GA_4059)
Thread-Topic: ep93xx: remove MaverickCrunch support
Thread-Index: AhRjygBp3+fyk/ZVaeE61BpHQHrtaA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 3, 2021, at 7:58 AM, Arnd Bergmann arnd@kernel.org wrote:

> On Tue, Aug 3, 2021 at 1:41 PM Martin Guy <martinwguy@gmail.com> wrote:
>>
>> I forward opinion from people currently producing and supporting EP93XX boards:
> 
> Thanks a lot for bringing them in. I definitely don't want to remove support for
> something that is actively being used, and we don't have to merge the patch
> if they currently rely on MaverickCrunch on older platforms.
> 
> It does sound however like Jerome's customers are using a normal (softfloat)
> Linus distro on EP93xx, rather than one using the original MaverickCrunch
> FPU instructions. There are no plans to discontinue EP93xx support, there
> is actually a good amount of recent work going into updating the platform.
> 
> Jerome, please let me know if I understood you correctly here. If your
> customers do rely on MaverickCrunch support in user space, I would
> leave that in the kernel for as long as ep93xx itself is supported, and instead
> require building support with the GNU assembler to avoid having to
> add support to the clang integrated assembler. If you don't know of anyone
> using MaverickCrunch, I would go ahead with my patch to remove kernel
> support.
> 
>      Arnd

Arnd,

You are correct on assuming usage of softfloat toolchains and not
using the MaverickCrunch unit. AFAIK, I am not aware of active users
of this FPU on recent setups.

 Jerome
