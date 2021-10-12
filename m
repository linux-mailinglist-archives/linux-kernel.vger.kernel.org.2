Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6317429DEB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 08:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbhJLGrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 02:47:07 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:33249 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbhJLGrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 02:47:06 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MUl4z-1m9Xxe2Pjd-00Qllq for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021
 08:45:03 +0200
Received: by mail-wr1-f51.google.com with SMTP id t2so63555496wrb.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 23:45:03 -0700 (PDT)
X-Gm-Message-State: AOAM531Cb/9E3fhzhCixy/5Un8abUKzXP9aCUWrWiyCxRcaFwV94X0ZD
        4tJnSKRAHGYtRGPSMFG4+v/oWnB/OFQIr/fTDnA=
X-Google-Smtp-Source: ABdhPJzEFF0kPlcbF0dcTZt3ZNn8pJe7A+570FbG9OOrKfF5fSytRJvzkR3UnAao+Zh6VQHzEo53sTBMXIegotrf6B4=
X-Received: by 2002:a1c:4b08:: with SMTP id y8mr3794343wma.98.1634021103233;
 Mon, 11 Oct 2021 23:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <20211011151443.12040-1-vegard.nossum@oracle.com>
 <CAK8P3a2+dU53PMJZvkDDGUyv=EiHuc03njGf6SXTxw9A4ByeHw@mail.gmail.com>
 <47e60186-2408-19cf-3231-92bd9c30483a@oracle.com> <CAK8P3a2nai8xGQPPMH89rO83252trdRFM67s-mmivAXeDE0zfA@mail.gmail.com>
 <8b209292-5b94-5a14-dee0-2c152ac02a5d@oracle.com>
In-Reply-To: <8b209292-5b94-5a14-dee0-2c152ac02a5d@oracle.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 12 Oct 2021 08:44:47 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1X38CHrCFDxsZq=TYJw9Q_uP7MrM8fG1_D4X3-F2yL2Q@mail.gmail.com>
Message-ID: <CAK8P3a1X38CHrCFDxsZq=TYJw9Q_uP7MrM8fG1_D4X3-F2yL2Q@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: select CRC32
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Oded Gabbay <ogabbay@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:jNQj1nbFqjZz3lNzMzSopjYTByBXwZCLWZ40GRzam+cf/XheUAA
 5PMUbEshbetLFczkaFjqXEbSxeqdHlqRqr9PwD7tyDgzVVNBtFo8sZEyiInJbCW4MyK6Ezf
 NgIt7J87tS1veX6wJPc2+D9hy9hxXDdSPBbYZEaUJebz9pdAbtCqPJdep2VWF0cc8kBYvMy
 x6x5aceyIdS+mn1qAxKEA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YfOtBl3AF6c=:Q0Na3EFP0oF0NXE0DpJbui
 LWejlAg+96mc4TFZsAVDZ2iDxiFVnq5Yt8xq8g8qFBMFBjfb8fkGntX7IKZtYU+F/k4i6Jnns
 JGks7vFJ1FO69ReT5fXS9Lwa+/RYOkIpwk/Dzd0p43QphQtQy6T+ycZkjpdpjDEAvbp/eppnd
 ReK4aLz65Ohkw3ePpR0Td6LNuJo2jFr/+nDzspmKxM/7fkJw1ABtuC2SsYQZ9V+nBTbl27UED
 vL3V57x1xngzSjUsiJzJYQX9JEXhFCADFHw0pWEEHtobM5wn9fxEpHpeYeja5Fx9jGdRID3P7
 Db9QpsQJTBqeIA7SJER8Ad/5oZTvILOspfx+iugM0LWYy5r0xN0CrpYoF9qdSVB3LZXoY+L4M
 bqv4QKn6EUh+zlF93ETBZEJwl+bOqpK8SoeEDe6OoYArnSAoIpjHEMwgF2L/zYwdweruvV+6U
 9sfkDraBL9bMnXp8iOzbd3Rn99Fzyzb6jacBrdhU2RujGowc9gw1HW2a5CGNVknPIo7vbt2p3
 2K9JoeV3sq5h3/7etJlybAwjQSfLJ+X0pRUiFlbU60O3LwgLKuN8juhvqLMdX1Qz8iG80wJVF
 s8XZqsmHwV7pVmqIv2v00IXXRwjAo8wsYPJZgcbYHopIivtKE3hdB5jcv9/Y5+6JwCGI6UyOf
 d+eaJqRKRY8jMl64EBETYyLfJ5FlpNCm9VJiB0cr6ZenKqWay2YGceHNie1WHHfkJUZjrLTMg
 tMBan5xD07hL7UlidOTNup7RfYg83vn3pjIgDQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 7:54 AM Vegard Nossum <vegard.nossum@oracle.com> wrote:
> On 10/11/21 9:37 PM, Arnd Bergmann wrote:
> > On Mon, Oct 11, 2021 at 6:29 PM Vegard Nossum <vegard.nossum@oracle.com> wrote:
>
> Otherwise it's mostly CRC32 and a couple of odd ones like this that I've
> seen so far:
>
> ERROR: modpost: "dell_privacy_has_mic_mute"
> [drivers/platform/x86/dell/dell-laptop.ko] undefined!

I have a patch for this one that I should send out.

>   CC      drivers/scsi/aic7xxx/aic79xx_reg_print.o
> gcc: error: drivers/scsi/aic7xxx/aic79xx_reg_print.c: No such file or
> directory
> gcc: fatal error: no input files
> compilation terminated.
> make[3]: *** [scripts/Makefile.build:271:
> drivers/scsi/aic7xxx/aic79xx_reg_print.o] Error 1

I never saw this one, as I only build with CONFIG_COMPILE_TEST=y
and CONFIG_PREVENT_FIRMWARE_BUILD=y. I think it's generally
a good idea to force these two options, to avoid known problems
and long compile times, but the aic7xxx error might be something
worth fixing regardless.

          Arnd
