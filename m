Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7665A3D3D28
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 18:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhGWP1b convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Jul 2021 11:27:31 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:53359 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhGWP13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 11:27:29 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MoOIi-1lICcr2AyO-00ordX; Fri, 23 Jul 2021 18:08:01 +0200
Received: by mail-wr1-f52.google.com with SMTP id y8so2879720wrt.10;
        Fri, 23 Jul 2021 09:08:01 -0700 (PDT)
X-Gm-Message-State: AOAM532D8jNeAJy/V/FS6mD+5WNVnzKZEQEnaUIoQA61K7MtaPt1YQzq
        qWFw13tQluHNlfEcUOydqbdMrtrsFpGS1AD5WLc=
X-Google-Smtp-Source: ABdhPJyDxcXYnbAWrd2+tMOLBTnAk6SpSqUS9fFD2eD49803zJQO9lGqAZ6d+2hujv8A2p3zN3ZF3qWAEFLk3e/6uRU=
X-Received: by 2002:a5d:438c:: with SMTP id i12mr6150931wrq.99.1627056481160;
 Fri, 23 Jul 2021 09:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210723135239.388325-1-clement.leger@bootlin.com> <20210723135239.388325-3-clement.leger@bootlin.com>
In-Reply-To: <20210723135239.388325-3-clement.leger@bootlin.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 23 Jul 2021 18:07:44 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1stoM2zRpkEBOLSFRxPy6Tabn6NgO-1sVRL4uq3wudaQ@mail.gmail.com>
Message-ID: <CAK8P3a1stoM2zRpkEBOLSFRxPy6Tabn6NgO-1sVRL4uq3wudaQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] syscon: add support for "syscon-smc" compatible
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:G4O7xmamhDeBcU8ID4FkPa6qMK8+Gojv3vqIqCROeiIpZkYuPIg
 8WUIW34yCzmlF+J01pTWy1JNTQeoNXIGyWuSAaXhYDi3lM+bRzKaddEYyAruZLKu8Dja7Lg
 /j/bo9ZIBgOUVD5Hu2UC0/+cU8Ncqli8n/AfJFgMapZte2hVm+EEfvSU0KafSkIBx6SiTne
 7n9uLwYQGHOD8+XTY0peQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DmIKFgwXff4=:TyZ0G0egf72z2xW2cgGThG
 BAOCKmJxhdjVhpuzevs8FK/GUNusCPgqJNlPEo7fW2wpVrNZimlBqdgkz0z6Kzf3mtysBdpAX
 IbaAcZVrJypdsF3Nh+y52rCEJ3lOvB8aCUV/y6YBg6AF+SVLwYM7SO73/i2BHh6YReGApe9mZ
 I/9BEBtPZUKT195odlp54fulN8j6FIW6Z4qwqLLc+8JKRIpJIcmUrmgfiubBeVpYe6y7PGSlL
 rlSRZpkUSTwF57ZrF5OD0NgKJYMhTmGPTuRhjsPglhzjV+ibRPlv10jg1iTDRxcxW3S5HNr+W
 /R6BU+0TkkcE3jhfB5fVry/WxJUxx4DIhPX3Iyg9g0L0JimHca4AfbdR62BWpP2T7MnWfbHVD
 IrD3tLEl3XvjdObmIRe0sUlGZFsCFMwVvCUATvJeJ4Kbd+G3OL6A7IcmBLA9PUcqDMXTIEJ/V
 cx9z2L0x6gDX4RhAo7/vfX9OHxTBnGmggS8vSNSxf2oacqYED2/spoVu7i2yaL9DDXxJt675I
 PPavjucABCz9SE9mGEZdROh8//UUEurJOiJrCIbn8xDs3yGiUvGRIIMMLlD9Y6j4jGyQw65IZ
 NqZFk2OtGq3jzs8PvZB52LWzWLJ1JlFYC/yccnNeiHPB21SyjMh8UQsKKN5FEGd2zCoSnRFM4
 rvmQm6y5s188yRWSCceKT252DUQeMhtlL+ZNYoqDGNNCCSeYINu7ukPoQxfZFA7o8crSnVUH1
 hWw5K2fTaytQE8lTwhrk7e7tDX4rq4Y0Ij/iZu2w5tIc+nWWE4VKuS/njMGiRwcc3LQV7HBbs
 LMD2xIDqn31IZjE/UE/Vxtjs5uHE+6xkNS2U1jMnhPZYA9D+nwb68IrAgkYaVS7jIv8Hzj5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 3:52 PM Clément Léger <clement.leger@bootlin.com> wrote:
>
> System controllers can be placed under secure monitor control when running
> under them. In order to keep existing code which accesses such system
> controllers using a syscon, add support for "syscon-smc" compatible.
>
> When enable, the syscon will handle this new compatible and look for an
> "arm,smc-id" property to execute the appropriate SMC. A SMC regmap is then
> created to forward register access to the secure monitor.
>
> Signed-off-by: Clément Léger <clement.leger@bootlin.com>

I don't see anything wrong with the implementation, but this worries
me conceptually, because of the ways this might get abused:

- this creates one more way to keep device drivers hidden away
  behind firmware when they should be in the kernel. You can already
  do that with separate SMC calls, but adding an indirection makes it
  sneakier. If the 'registers' in here are purely

- This may be seen as an easy way out for firmware writers that just
   expose a bare register-level interface when the correct solution would
   be to create a high-level interface.

There is also a problem with locking: In the case that both firmware and
kernel have to access registers within a syscon area, you may need to
have a semaphore to protect an atomic sequence of accesses, but since
the interface only provides a single register load/store, there is no way for
a kernel driver to serialize against a firmware-internal driver.

        Arnd
