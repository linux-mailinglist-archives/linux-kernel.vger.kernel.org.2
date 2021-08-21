Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759EA3F3883
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 06:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhHUEU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 00:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhHUEUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 00:20:51 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BC5C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 21:20:12 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 61-20020a9d0d430000b02903eabfc221a9so19283318oti.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 21:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Icf1MBd4snHe5QRmv1SFshi7/JHm/cRBUefwcbOfgnU=;
        b=MdLBl7WYmiKNTHgFJYx6rxhxH/svxsgIPbE1mu2MFbjALknU+NxtwC2UrJBPRRBOGL
         YjlmbcSmNCZ4C7er9X25h2NTeDyY8kYevaOu6iUTKFKzOyhwFR4Cd0dvr2ZBqRuAM3Ou
         2k4zkwHmspSNdQt8/L9kqNJyBMulZZDaekK2xqMjodAJm9Bshpxjos1sqSytHC+edzPU
         yw65WacR7gFsDl0sleJfWFckEskriPTfqBOBxCiJriiGj8DxTvDo9gg2XJ++mdpzilGk
         b+7Jrf+fYiaVqLH9q1/jYVyQfkdTdRFldOJ2e7BUTr8Mb8273Edf3y7TV5plNGXiykgm
         V6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=Icf1MBd4snHe5QRmv1SFshi7/JHm/cRBUefwcbOfgnU=;
        b=CI4/3CKzP25fNXpGuUf5V15EqaLRA+hEKo3+qs9Att2tlWWaGOrq+uYSnJ5SoTSthf
         czk4k6pNFEjiroW9MYANZ1CW87Vy5/6sLcPMxqh11pP6P/zcgWCaJuJoH5jJNf1+XtL6
         4DQRLOTb1R2uuNtAJAazRhlh2xNwoJEqtPOgHJHrBWEEan58BV8c+KC/ebRtQ0gfcRJL
         Qu4KqcN/OOcE8zglLOUFsZdRk60FZmkv3Sv8BOb4mx8kMe3yNg2emEVfnEkIrZnRohJ5
         LubiIzJKFeedBP5SfvluZ5prr1/V+9G7GehyUoosfUoT2Rd31+qsnrMzhMGX/gx/QoYb
         U3lQ==
X-Gm-Message-State: AOAM532kQ+2N84SRDEHsAnPS29v+set3u2WureannkxrfOw5XOyDePPD
        /YwwMQpWP3uV5qqEU+bicvGX0vCrBzk=
X-Google-Smtp-Source: ABdhPJylDMhHP44cUKC+v1UFlZqI0uw7dmPGk6ZsF0J6QthLVgsQ5XWgz7OiEVTgOE8en1BABmF1/Q==
X-Received: by 2002:a05:6808:1494:: with SMTP id e20mr5077571oiw.122.1629519612041;
        Fri, 20 Aug 2021 21:20:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n4sm1785825ooe.10.2021.08.20.21.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 21:20:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 20 Aug 2021 21:20:10 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH 2/2] clocksource/drivers/fttmr010: Be stricter on IRQs
Message-ID: <20210821042010.GA1759866@roeck-us.net>
References: <20210724224424.2085404-1-linus.walleij@linaro.org>
 <20210724224424.2085404-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210724224424.2085404-2-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jul 25, 2021 at 12:44:24AM +0200, Linus Walleij wrote:
> Make sure we check that the right interrupt occurred before
> calling the event handler for timer 1. Report spurious IRQs
> as IRQ_NONE.
> 
> Cc: Cédric Le Goater <clg@kaod.org>
> Cc: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

This patch results in boot stalls with several qemu aspeed emulations
(quanta-q71l-bmc, palmetto-bmc, witherspoon-bmc, ast2500-evb,
romulus-bmc, g220a-bmc). Reverting this patch together with
"clocksource/drivers/fttmr010: Clear also overflow bit on AST2600"
fixes the problem. Bisect log is attached.

Guenter

---
# bad: [86ed57fd8c93fdfaabb4f58e78455180fa7d8a84] Add linux-next specific files for 20210820
# good: [7c60610d476766e128cc4284bb6349732cbd6606] Linux 5.14-rc6
git bisect start 'HEAD' 'v5.14-rc6'
# good: [2b14a6beaaddc78bd4c7aeb0d94ef4d1ba708b7b] Merge remote-tracking branch 'crypto/master'
git bisect good 2b14a6beaaddc78bd4c7aeb0d94ef4d1ba708b7b
# good: [ecbc858174455ac847fb308ececc33ad408d2b3c] Merge remote-tracking branch 'tip/auto-latest'
git bisect good ecbc858174455ac847fb308ececc33ad408d2b3c
# bad: [7a307d6053886b8c05f897b4386365d0f556c2e9] Merge remote-tracking branch 'staging/staging-next'
git bisect bad 7a307d6053886b8c05f897b4386365d0f556c2e9
# bad: [b97ca8377c80f00f51767c249310ee37db949df4] Merge remote-tracking branch 'tty/tty-next'
git bisect bad b97ca8377c80f00f51767c249310ee37db949df4
# bad: [e83fe57c15b3a06707266e28590ee805920be987] Merge remote-tracking branch 'kvm/next'
git bisect bad e83fe57c15b3a06707266e28590ee805920be987
# good: [213605c149ff869a7206db53eefbee14fd22a78d] kcsan: selftest: Cleanup and add missing __init
git bisect good 213605c149ff869a7206db53eefbee14fd22a78d
# good: [049e1cd8365ea416016e21eb2c7d9ca553fc1dc7] KVM: x86: don't disable APICv memslot when inhibited
git bisect good 049e1cd8365ea416016e21eb2c7d9ca553fc1dc7
# bad: [c01ef7a90edfa8be6dc8aaa9e0bfdfe0eb7ea083] Merge remote-tracking branch 'irqchip/irq/irqchip-next'
git bisect bad c01ef7a90edfa8be6dc8aaa9e0bfdfe0eb7ea083
# good: [4513fb87e1402ad815912ec7f027eb17149f44ee] Merge branch irq/misc-5.15 into irq/irqchip-next
git bisect good 4513fb87e1402ad815912ec7f027eb17149f44ee
# bad: [dcc5fdc6b0f491a612ca372ad18d098103103bdb] Merge remote-tracking branch 'edac/edac-for-next'
git bisect bad dcc5fdc6b0f491a612ca372ad18d098103103bdb
# bad: [8903227aa72ce8c013e47b027be8e153e114bf19] clocksource/drivers/fttmr010: Be stricter on IRQs
git bisect bad 8903227aa72ce8c013e47b027be8e153e114bf19
# good: [be83c3b6e7b8ff22f72827a613bf6f3aa5afadbb] clocksource/drivers/sh_cmt: Fix wrong setting if don't request IRQ for clock source channel
git bisect good be83c3b6e7b8ff22f72827a613bf6f3aa5afadbb
# good: [ce9570657d45d6387a68d7f419fe70d085200a2f] clocksource/drivers/mediatek: Optimize systimer irq clear flow on shutdown
git bisect good ce9570657d45d6387a68d7f419fe70d085200a2f
# good: [3a95de59730eb9ac8dd6a367018f5653a873ecaa] clocksource/drivers/fttmr010: Pass around less pointers
git bisect good 3a95de59730eb9ac8dd6a367018f5653a873ecaa
# first bad commit: [8903227aa72ce8c013e47b027be8e153e114bf19] clocksource/drivers/fttmr010: Be stricter on IRQs

