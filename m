Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348694531BC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 13:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbhKPMHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 07:07:49 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:37387 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235812AbhKPMFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 07:05:33 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N5mOZ-1mb4M41vTP-017DT5 for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021
 13:02:35 +0100
Received: by mail-wr1-f41.google.com with SMTP id u1so37066956wru.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 04:02:35 -0800 (PST)
X-Gm-Message-State: AOAM533FZEIuoXYw0bv2fGqpRrVR43P5ceBymLubI8imTvxUhCOSYrUR
        EI4WGDVoQq/acdPnPH11hdvZDbyKTJtgWKvGs58=
X-Google-Smtp-Source: ABdhPJzWag8fIYyLGCqwx5LBhDnDdDlqSI8764jzovdDv6t7TKqPHJrW6IocUX5QEi5j4dIq1Jhb4Gv3wz5MQURPpzg=
X-Received: by 2002:adf:df89:: with SMTP id z9mr8581237wrl.336.1637064155133;
 Tue, 16 Nov 2021 04:02:35 -0800 (PST)
MIME-Version: 1.0
References: <20211116105424.12685-1-Meng.Li@windriver.com>
In-Reply-To: <20211116105424.12685-1-Meng.Li@windriver.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 16 Nov 2021 13:02:18 +0100
X-Gmail-Original-Message-ID: <CAK8P3a241g2vQrfiEf_YcQ0=t5fhN0R0CrzQE5DK7XQgAGxKYg@mail.gmail.com>
Message-ID: <CAK8P3a241g2vQrfiEf_YcQ0=t5fhN0R0CrzQE5DK7XQgAGxKYg@mail.gmail.com>
Subject: Re: [PATCH] mfd: altera-sysmgr: enable raw spinlock feature for
 preempt-rt kernel
To:     Meng Li <Meng.Li@windriver.com>
Cc:     thor.thayer@linux.intel.com, Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:6HS+KDNub3R/IVNlqHeeTvoUd2oU4+PsFcY/EC8aXa2dJsaktci
 p/5YjRre1hfvaAlNcyX0LOnvbp+sfPNSmCYzq6XxBGdjhgLB7mCi+qehez777KNoXVT1pLG
 /374YHw+9bJhczSY6rn4Bq/ulwypWrpOW0xhVBEGvZqDFK6qEunZ3Bz7nuD2VjA8Q2gPusd
 F8bEaPexSc/nhoGTF22rA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fbv1YMWv3us=:jo98R/uv+3Sqem5ykr2Kl5
 FtnWRerfmw8UGtAOEnmKZvXq29l/5C7sJvOPulJgcREiozT5pMPj1EvGuFjbB2Xyzh+ot+e6Q
 hCV8B+LiuVG2MRFgbhJ/+pjpc+/A//S8eorWKrfEQub5HAqKOm0zClu85NYeodL1BVE8IYKX3
 uxjd3ZNPFuBlM+chowmkIo5CpU00NuBN80trqntlAasY2US5Fh+VmNb8iUl9sqSzQ2bLAOpAd
 xpjefMTNrSCp0zfeswsuMdx+8nolGvUxtPdOWdMdO7N1heo8ISpX0ay5vIb0R5sOvw2UIQSRL
 MD5bPYUy3uHw1VQXPUhArDrWNsdzNrJ6Q6dxD5IBgCCMGOLucv8bmgZZISkeLE/Zy9ioODiHc
 qvRkRFLRgk6SHyRl59tzZ3BqY328WjSO2sev1x5CehI/nRIyR6UC8+ez8Y7RVxWuQTkx0wyu4
 JxFqGGPP1ZUYcpXh6l2R0n5njpSIwoMli8F/iDfiMNbmONafzN2nwMTqIxU7XtiLMXPce+FrM
 RVdFBAXP53xknAL5+tms+dgmht1CdiuUEqa8QbvFjgFsJheDgTNVTXnb7zkHJUappZ8b3V8fO
 OPk3OaYDUq/Q+STjHAKWVYAaPPHLQur50Wae89BWWxgWUNvFnDIL8qqQZU62T8x3+0yWC80Ij
 kt+gXlpBPZGeAZH1/aE+iwrNbT+E9kG59AaYNZKAZ8kL/D/8hDu8Mpar0titHgkov0Bs=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 11:54 AM Meng Li <Meng.Li@windriver.com> wrote:
> diff --git a/drivers/mfd/altera-sysmgr.c b/drivers/mfd/altera-sysmgr.c
> index 5d3715a28b28..27271cec5d53 100644
> --- a/drivers/mfd/altera-sysmgr.c
> +++ b/drivers/mfd/altera-sysmgr.c
> @@ -83,6 +83,9 @@ static struct regmap_config altr_sysmgr_regmap_cfg = {
>         .fast_io = true,
>         .use_single_read = true,
>         .use_single_write = true,
> +#ifdef CONFIG_PREEMPT_RT
> +       .use_raw_spinlock = true,
> +#endif

I think you should remove the #ifdef here: if PREEMPT_RT is disabled, the flag
has no effect because spinlock behaves the same way as raw_spinlock. If
anything else starts requiring the use of raw spinlocks, then we probably
want the flag to be set  here as well.

       Arnd
