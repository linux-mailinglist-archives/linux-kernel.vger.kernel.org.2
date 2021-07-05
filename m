Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267443BC193
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 18:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhGEQYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 12:24:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33055 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhGEQYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 12:24:38 -0400
Received: from mail-ed1-f72.google.com ([209.85.208.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1m0RM8-0004JF-79
        for linux-kernel@vger.kernel.org; Mon, 05 Jul 2021 16:22:00 +0000
Received: by mail-ed1-f72.google.com with SMTP id j15-20020a05640211cfb0290394f9de5750so9271488edw.16
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 09:22:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sD/y1xlMgbYq3fBjsf0pX1g5M044zHykQS8WXVhlrdI=;
        b=PX5nDmCynR2LWWmAz6YopAjRAC10tnmW3SP116TNL51kbGQGYvQXb8s8IiSzq2fcH4
         Qa+wtdBwVQTJ6azanXw/4ZXFlEtjBAni6rZKX7je7yCy5L1yWAOvDE9YPogNkrLC0U95
         XULCDEW0vgcWCCxvikdexWw3u3V5vB0Q6fM5pIdaydcnug+yRYeEK/vauQwnKiKlUd06
         ULzs84YRc7BNzLlS+V6VRZMDem6xK6T0RxK4HRstRpaYxh2my6HfnpYu4UrOz+oqF1c1
         gN1UiECgdfKzpY3Wqyxm87kUCxK4Lf6FFeMjgIkkD6IV5sSm0wl3mx7lNpliQ9ev3EcC
         u5lw==
X-Gm-Message-State: AOAM532f+ew1yRK84SgJLIz0LgvPxaPu+AnpKpl9/9295h52bMp3WQJ1
        oysq6SScIMPZKOlYxiycRkIntVY/q4G8he2lvZYnXXuSCW2YTxgnI/G/lH981TWQhqnjZtUKJmN
        AGSTBjh5/nZEQSXUtBp+ji9g/+jchmVdgvfTM5BPWBaO2OzuhRcUfKFh9/A==
X-Received: by 2002:a50:ed82:: with SMTP id h2mr17295935edr.165.1625502120017;
        Mon, 05 Jul 2021 09:22:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCJTJVm2cXmAPIEVtM0YZG4CWbGju7SyX7A+wp+GUMWL0lWArHCZ3pGx2eLKBQqDAJd5M6pJn5KLDGPSPGTWY=
X-Received: by 2002:a50:ed82:: with SMTP id h2mr17295906edr.165.1625502119732;
 Mon, 05 Jul 2021 09:21:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210514131750.52867-1-krzysztof.kozlowski@canonical.com>
 <2b427eca-fd6c-d099-337f-39cfbd85cb46@roeck-us.net> <a15e7f62-12a0-1ec7-5104-f01f9e3eccc7@canonical.com>
 <9d98ec40-757d-28c7-1669-a683b2cd3881@canonical.com> <b87bbb80-ed02-447d-f778-7997848731cd@roeck-us.net>
In-Reply-To: <b87bbb80-ed02-447d-f778-7997848731cd@roeck-us.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date:   Mon, 5 Jul 2021 18:21:48 +0200
Message-ID: <CA+Eumj4aZZPFFB-3PEeBVo6fXW_Fz97oswA3pZuu2aiysnp=nQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: ralink: of: fix build of rt2880_wdt watchdog module
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, John Crispin <john@phrozen.org>,
        Lee Jones <lee.jones@linaro.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jul 2021 at 18:08, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 7/5/21 8:15 AM, Krzysztof Kozlowski wrote:
> > On 14/05/2021 16:04, Krzysztof Kozlowski wrote:
> >> On 14/05/2021 09:48, Guenter Roeck wrote:
> >>> On 5/14/21 6:17 AM, Krzysztof Kozlowski wrote:
> >>>> When rt2880_wdt watchdog driver is built as a module, the
> >>>> rt_sysc_membase needs to be exported (it is being used via inlined
> >>>> rt_sysc_r32):
> >>>>
> >>>>     ERROR: modpost: "rt_sysc_membase" [drivers/watchdog/rt2880_wdt.ko] undefined!
> >>>>
> >>>> Reported-by: kernel test robot <lkp@intel.com>
> >>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> >>>
> >>> Acked-by: Guenter Roeck <linux@roeck-us.net>
> >>>
> >>> I don't see a recent change in the code. Has that problem been there
> >>> all along ?
> >>
> >> I think the problem was there always but 0-day builder did not hit it
> >> until recently:
> >> https://lore.kernel.org/lkml/202105082122.yrF7ploN-lkp@intel.com/
> >
> > Hi Guenter,
> >
> > It seems that patch was not applied. Anything to fix here?
> >
> I see commit fef532ea0cd8 ("MIPS: ralink: export rt_sysc_membase for
> rt2880_wdt.c"). Does that not solve the problem ?

Yes, that fixes it. It was sent later, though. :(

Anyway, thanks!

Best regards,
Krzysztof
