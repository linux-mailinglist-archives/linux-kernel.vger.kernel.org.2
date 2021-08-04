Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA92D3E029B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 16:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238514AbhHDOC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 10:02:58 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:32925 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238513AbhHDOC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 10:02:56 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MUobv-1mc3hz3pNR-00Qjlp for <linux-kernel@vger.kernel.org>; Wed, 04 Aug
 2021 16:02:42 +0200
Received: by mail-wr1-f50.google.com with SMTP id j2so2373692wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 07:02:42 -0700 (PDT)
X-Gm-Message-State: AOAM533RPX2UUZDm5hhpiQUN41ZfPrSVQ847jTT2lzgU7+xpsz37tSJ9
        bfnabwdY8nmS8P9LXnwHfZkIKQZ90iXlZK1powU=
X-Google-Smtp-Source: ABdhPJyUUeOCz/Sk2BVN80rO0xJi/O5dl+Q4BFErr7/7beTnL2rPo8aHa2QbQNXmTdgzOQJLehXZ+Akx9LGpcakr4fU=
X-Received: by 2002:adf:e107:: with SMTP id t7mr29024487wrz.165.1628085762592;
 Wed, 04 Aug 2021 07:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210804084631.12934-1-nicolas.ferre@microchip.com>
In-Reply-To: <20210804084631.12934-1-nicolas.ferre@microchip.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 4 Aug 2021 16:02:26 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1Ru-qawBWtbmfJm-jiPpJTRJ9zSufXHNCZvxt1RCMFBA@mail.gmail.com>
Message-ID: <CAK8P3a1Ru-qawBWtbmfJm-jiPpJTRJ9zSufXHNCZvxt1RCMFBA@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: at91: defconfig for 5.15
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm-soc <arm@kernel.org>, SoC Team <soc@kernel.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:r5uRhOH4QsnrqJESjIY9xklV6nZlyluEalkedZQWu0V2v2o7LFC
 YZKwmqpbEkbpQBdvrX0U6mrXhujTzZIxWt7f/wA5TJAXaZ9VEuzSB/gtW1UCzSs+QzkBFk/
 oXGO8k/E6EYK2cG2VL+/vfplLiTILYq29aZRJsIk66Q0mqPoh68jZRbHTDdy3mBJUqqhUG4
 oGQDbEUZb3VtOvmmgC0BQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FHFoPCt/Uf8=:QlLc1JOJi+WExEMeuX8hZW
 OqLTkt/gz2NpNXgTAuQcWimCV71OR6dfr9TY/JTeFkjeZydLbBTHv6l2VB9sU/V3coGh5AwOv
 FLbWwlKAVTHjRoCblMqrE62WQLwOLDYL0MB2TV+p+Sy6mCgNtnxebnToVTlQmBbHgNeTJT+V1
 S5MR6lWn0IOWo6iSFka3+yET7MjKsF1dxmXlzGZpZOEw7JdFX4TEILxyakoqBSotjUmkCazzo
 +7PIp2L9E5O9ytU19ktbZfrSVQ4LyVLem9sahHjayXWg14CijdYP0BjXiua9M7XrJWerVjCTJ
 jL+l97REhTgrEdgE/26PfQ1b29/LKDQ4g0yJnFJRGQu/kefEmTqmJdf+92vzbZ5b5oTHzwnSz
 lofohPItu0aHY2LcnE5pbwJu7zz8o/4ffN5bwA4SIq/s4t+Lb4TUNN6aByNC78GRotpOBhX+I
 IE1KTCzjLZL/3a5IK4a6npAIBXKCkG22CveHyxFVhmRoEu7Bwz4spkWR9zLVMjMzfG2CXOBt6
 RSqVbgh6JCOFDrcrKo+5dxwBL3TU6Kbx5PUVc2jAu1Q2Dh1T00UDajJxm8l5ENQesA/rInH3Q
 LpChWL0hicamhMPtF4DgJTjYxZes9g/sjL/ybODIwOj3EfTiBDxuxKiH4zM3xO/4Vt8VJ4TB1
 ahezN/5CCF4TDLMiQv+lt9N8caSvjBaoHKydB250n7xHFyfnh1QEfy7OHWTEhSoPVbb1w7n6L
 6vQAs74QS9ERjZYhIKh79BdE9htZc+AtI7jYwSxj+o60VjopgFkioU6eaufP/6vcIc+sLeiGk
 IlzjW6eW3RX6aWg4+h9uwwgc8DGwKXZm1BY+KxmwG/VjBmM+DSyRR3THzYKSpgG2QbfDs1lDW
 tn438/MFlyQdxchH7MhiG0z8l+4j2Sg2FXtFEfVhLvqlOE3E8KQqKbyeKOh0IW2bhGi9PTSef
 DS99qwD91nxafU3sZbPElOBYPkwgdRECdjme64hOBHsZcevLdLQy1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 4, 2021 at 10:46 AM <nicolas.ferre@microchip.com> wrote:
> AT91 defconfig for 5.15:
>
> - add defconfig entries for new SoC: SAMA7G5
>   - dedicated sama7_defconfig to match the needed peripherals and
>     dependencies

I feel this needs  better description in the changelog: Why do you need another
defconfig file in addition to the existing sama5_defconfig? Are they so
different that a single config is not a good fit for both?

      Arnd
