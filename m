Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C353F3A7B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 13:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbhHULyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 07:54:16 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:44947 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhHULyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 07:54:16 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N0X4e-1nDWWZ2xSm-00wRFX for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021
 13:53:35 +0200
Received: by mail-wm1-f44.google.com with SMTP id u15so7459851wmj.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 04:53:35 -0700 (PDT)
X-Gm-Message-State: AOAM533czMGnjLSaJEyr88Hl5ZSC7GkPXWHp1/MbHRABKJFFShJCTKr+
        MgdPuqm5Q5AiPMs0X2O6R5yZlIthi3JBGEWnzbY=
X-Google-Smtp-Source: ABdhPJzkPFvTgoFEnuWrfQLwjVJMwwBFAZBEBWusf8XtwuC2vnl38PUtumRo7xWPJjgVJRkAd1pRvkTzmWjlfRm9UmI=
X-Received: by 2002:a05:600c:1991:: with SMTP id t17mr8110849wmq.120.1629546815353;
 Sat, 21 Aug 2021 04:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210821094528.294579-1-pbrobinson@gmail.com>
In-Reply-To: <20210821094528.294579-1-pbrobinson@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 21 Aug 2021 13:53:19 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2Gdx6JQa3_GeSVAqUVXFAa-TOLb8SU2-K33Wg880Q0GA@mail.gmail.com>
Message-ID: <CAK8P3a2Gdx6JQa3_GeSVAqUVXFAa-TOLb8SU2-K33Wg880Q0GA@mail.gmail.com>
Subject: Re: [PATCH] reset: simple: remove ZTE details in Kconfig help
To:     Peter Robinson <pbrobinson@gmail.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:gOwSpGjPUz5Hnjuli9KhR4dvxX9+bVSTQAT487OZ3sAXWQn2cMz
 OFGDLY7fhhElClODGcVY6Zxcx+NWmYo7JBp655hN5Qf+AfE9FjKeCPAHHT+TN6RCCnMs5Nq
 ufGKgQV2qcQFeTGMyi8W45RDZPk41YBDv96UDdpCsUycQkqU28jxGANSdEJqc8UvLEyfEop
 6jeqjhAqlEh9U71jVuxsA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cn2ExzlhEJc=:kHC+S3ae1LVY6JMHNlGi8m
 v74mYT+VjF3VI/k/xdWRho5L+j13MjxIC8JbwjwHVxe8hKyG7f1w+AFPYdF+PHkOrpQJToqem
 Q457NpDsQVmL3xnmXl6c9Xo2mHw4Q0w4E1L1j0s+aT+AprXglsY1zdCMjYN/b+ZNq/aeOotU9
 icOiddL3OIugQSyjnT8j18vHLr04EjLEqe7QqTczDLF5BgDV7FlRJrXrVgczQkOVyTm/Iv2en
 t7UdojDnNqVpHP+pNCbE922mcDkU7i5UvfPhGDZyyptFYEh1RvYXsTxKSImGMIo43Qe4WAVsw
 KjuZe9ZV4freZTgw1E/FGcpiMgej+QqAcMo8eCzhq7rmaYt01XE/Y/8inqDC1oy/s74qe2mhP
 A8KGuxUGdqe17do0R8/BA8Mch/8WYs8PjF9JNxtOg8wAnIjsMOvcMIIQlVQ+9jNGRLlOloSaU
 c8rw6vQrH9mp4qGwOUYF8meUY5whb7L+Xz7CeTCA8Uka3oxIzLIdyhvPtJBz3VmPjCyVkxrUy
 CfnKZ5iiw3UxtqVD9ewP7OirwteJvPI8tiolnyWS/ZAoPyPpgK6IGQifIcemjfIDExMMYMpsp
 E1yROVjrtxyzmHWFIoRxk2Jd9/KWRPe8a4nvpisSoPEKpvJqPiqd1lxmM7SPE6IYWpExyztRP
 FC5EkchGw3cbhvi3uOAff0+D3BMaGicB/fQ4yDfTFVp3Sarv21FdNQrXWcjVI+2tzAIgWTgGS
 Cy4WlvHP5ZXx8Otz3kfndm7Y1lfsA1OecSbsz6y5Jx1WHuIhzNd7KnSbh8ssk1Pthfr9f2N4d
 dIWwJgkWjUd492b+BGEyV+WUWVhOVe7A7NIwFogczt6QzfM4KFI8Wjuh5Qn+OzXDG4wAtgm
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 21, 2021 at 11:46 AM Peter Robinson <pbrobinson@gmail.com> wrote:
>
> The ZTE platform support in the simple reset driver has been
> removed but the comment in the help wasn't removed so clean
> this up too.
>
> Fixes: 89d4f98ae90d ("ARM: remove zte zx platform")
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> ---

Acked-by: Arnd Bergmann <arnd@arndb.de>
