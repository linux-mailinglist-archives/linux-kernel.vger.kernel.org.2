Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF443DCAEE
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 11:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbhHAJl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 05:41:29 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:53899 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbhHAJl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 05:41:28 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mdevh-1mjjts3OXx-00Zg63; Sun, 01 Aug 2021 11:41:09 +0200
Received: by mail-wm1-f49.google.com with SMTP id k38-20020a05600c1ca6b029025af5e0f38bso781025wms.5;
        Sun, 01 Aug 2021 02:41:09 -0700 (PDT)
X-Gm-Message-State: AOAM530cOIg0ovY9NuNCAVbtQxtcJgJFaHicCSsNMSSmouCmowE4/Iq+
        hRPfKbqnbEauQxqfXMxAFHDuTf95Iz3zSwvqZZw=
X-Google-Smtp-Source: ABdhPJy9Co8LhMruzZGyj4f3XArmEpslC++FxInWAY5kS6dN4F5T0Wp45K/4NLUe+uVYPfHG9aIG+H5EtkfDpdNsprE=
X-Received: by 2002:a7b:ce10:: with SMTP id m16mr11249018wmc.75.1627810869409;
 Sun, 01 Aug 2021 02:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210730134552.853350-1-bert@biot.com> <20210730134552.853350-4-bert@biot.com>
 <CACRpkdYvMtE8b-Xiy6=Aiz20jvY0M0Bz9XmcEQDHhqeS+LErEA@mail.gmail.com>
 <87y29n26po.wl-maz@kernel.org> <0fe113c6-4160-fd3c-488d-53d40b6043ee@biot.com>
In-Reply-To: <0fe113c6-4160-fd3c-488d-53d40b6043ee@biot.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 1 Aug 2021 11:40:53 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3HrzAYtCnLuThO=9LuwyF8KduNjx-ZrJkXG=Y-i6RNbw@mail.gmail.com>
Message-ID: <CAK8P3a3HrzAYtCnLuThO=9LuwyF8KduNjx-ZrJkXG=Y-i6RNbw@mail.gmail.com>
Subject: Re: [PATCH 3/5] ARM: dts: Add basic support for EcoNet EN7523
To:     Bert Vermeulen <bert@biot.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        John Crispin <john@phrozen.org>, Felix Fietkau <nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:w7dMDGbUB+xUuMwmTOi5thsE8Zee45eomh+gK0wWZuTHZgfswjG
 o+hK1LRg5RuJsImSiBtnbQz4TEIWCEyYGxDuCXju9nsQFVth4/z5tpTA/x3Q0T98tNVnm9+
 nqMELSK4MgBKqZKnoMX/WNbBgmph/8iy59JjWRh/H4HV/fEXtxUhkSL024jSie/1Qj2WTaL
 nZz54n3qlDyytZ8HpfRDg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0ddko8OaYjY=:GeYrJRzww7NeC/aDlVYWPY
 64wCs9GdivEgBMMwGD4oEi4x6jBUPCAEaiU1Eut5RDq2//YfE/8JHHNi/mPRKYQSqD2QcD6v4
 rwxT89aHdEnOHPicb/cFmKSbWJou6F5Txn7SAEFJbG/KLPiWQb1KxN/3IDbNuLAu4MgCxAYat
 n9CTg3Uv7h1tlo1t2mliQ6F7jr3/xjHKtkhuBDSPuj8eRaYLNraHvlUpaD6U7MzUtM9/PMlwz
 1T4dcWsGxApumlwq6PRLpWj7FKKFonVnwa2iHERGiJyFQ8XQrugQz8mteV2EUvfvw6b4i38EQ
 tY6QtY+9I4SY5uQZyC/D0tymLFba0wCXSyoQF4gHp259+HZBBGcY+T69exvYbsfxqXwpv86Ce
 q1ta5pAH4P9AryXtaDHTMYkRQhrSqUVpR/25zqpK17Mnab6OAhkUJ/GU1fZzvS2ckeU2NMvf+
 Y1Aav1Gzp3M8N2Rp40NVjsaul2nnDtaTlueAeUBs82mszTIXxUHdFBfehZpDOfUiw75pchmyQ
 rbZthAqFVQjVYvFVbz3HVTBxNxcwwcM0Mo4pwiowonboer0ejbma540JvyPGKqmJFYSjIpBLJ
 KMRr6nBUlhxgmNSWFsi8kOjF3EFalMo+XhgsHqWTKDXuhz0nmxnjyU3QpaZaAJuzfiVm2Au+y
 qoc8+Fe6mCxg93KY8gPEaIMr2k37N9kJyZYNtoDc5HVCmF59DhBq7Y1kxpze5uOW1wWhEhwKG
 /yzw0dLlhwNcPgn8gD6y2/Xs2xwgHkD1vTv/xLBO+6rc6mEKMx/Mpcvn7H9Q8/AhhmP7qhQih
 qqyancnQL/ab87ZlQZXGu7blkSM80MTZRZe5JqvQqFptf6UJ/miZfF5pvArbTlC1XMiG9Bzq9
 +qHUHWb3cr83HZhvwL4L44oSL6mBPIQNm+/og3Jh1n3DJmZ37WXQOPXgfb73D4y12Yq2HlNse
 mruF5q2uKXaIzcEi7BpWz4pd+OnLe+ikA/sRWA+tpNztXK01Fm2xj
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 1, 2021 at 11:07 AM Bert Vermeulen <bert@biot.com> wrote:
> On 7/30/21 4:53 PM, Marc Zyngier wrote: On Fri, 30 Jul 2021 15:31:36 +0100,
> > Probably because that's not what it actually is. My bet is on A53 with
> > a crippled firmware.
>
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 5.14.0-rc3-00042-g3af70c6f8e95-dirty
> (bert@sumner) (arm-linux-gnueabi-gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0,
> GNU ld (GNU Binutils for Ubuntu) 2.34) #392 SMP Sun Aug 1 10:28:13 CEST 2021
> [    0.000000] CPU: ARMv7 Processor [410fd034] revision 4 (ARMv7), cr=10c5383d
> [    0.000000] CPU: div instructions available: patching division code
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache

Good guess! CPUID 410fd034 is a Cortex-53 (d03) indeed. I wish we
would just print
cleartext names for the CPUs that the kernel already knows about here, I think
the fact that we just print 'ARMv7 processor' (which is wrong) and
spell out the revision
but not implementer/part/variant numbers is rather silly.

Is there a way in the boot loader to boot up a 64-bit kernel?

       Arnd
