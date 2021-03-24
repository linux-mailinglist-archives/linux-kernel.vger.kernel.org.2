Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0413477D8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 13:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbhCXME3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 08:04:29 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:51587 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbhCXMEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 08:04:10 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N2BQM-1lnwsL42X8-013b7l for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021
 13:04:08 +0100
Received: by mail-ot1-f46.google.com with SMTP id 31-20020a9d00220000b02901b64b9b50b1so22718491ota.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 05:04:07 -0700 (PDT)
X-Gm-Message-State: AOAM532hBkIROpAiXYWcVVEoeStn+C58svttDwR38GfjzKm7N/wpxp1M
        bJ3M+JpQ3X/P0NsmCwP12yPUoCytjEaYxqiQCww=
X-Google-Smtp-Source: ABdhPJyDdesUOOrAC0VEmshXrCUXEPztpg4fvXYC9hCNPTHxWe6m+5zU7w6pd7k1BBV6Q5FO2jw2NccU7e+gY4w0cVg=
X-Received: by 2002:a05:6830:148c:: with SMTP id s12mr3021524otq.251.1616587446748;
 Wed, 24 Mar 2021 05:04:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210324072031.941791-1-xujia39@huawei.com>
In-Reply-To: <20210324072031.941791-1-xujia39@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 24 Mar 2021 13:03:50 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2cWFT7BiePJQjYO-_9QjCvWf1mQPE8NEZ4dXgira=iaA@mail.gmail.com>
Message-ID: <CAK8P3a2cWFT7BiePJQjYO-_9QjCvWf1mQPE8NEZ4dXgira=iaA@mail.gmail.com>
Subject: Re: [PATCH -next] applicom: fix some err codes returned by ac_ioctl
To:     Xu Jia <xujia39@huawei.com>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Rvu1YRnd4eTkHMVeR+gPVvAzPu6WaTfGf33oiKb+XwYULyJ2MaQ
 Tmj0DHKdpvOWPShdIQ2aIqinYVqa0SVP7mWUax+JIx7j5mX65WfPqrJ1fIQApK+wfdoUh83
 EWz6ihGdhiaAST43mNj+1PPOA65iHYtSA9rdVweODksELYRwSAla5B9stGZJwZqGTAcMoTO
 16nwIU/yQguUmwPtQ4Swg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:r2LfhWFg1pI=:cQDxQ5FJi3G4auyfmks3YG
 HSu67xwc2NBSG0mT4uA3VxtmzjkCrGpLSVFJAvjZl8tyQhu5IJDILqsluuc8KlyBltxEC1kJp
 FzjwiyzLkIqV+Bl4KC31bDGd/iSHtnT3EHpRbOcC5FIt9MfiLhkUjcAm5yJ07Op6hLrUR0g+6
 /p4N8bYG7XPp56Px82xc2i3WdKxHJMiu3Tu71u7gSAHqb+tvsn/6AsmyXHcrrB+9GJlN4q/mW
 SOk0xtc8RnhFXk2XZfjLMCUXkPgt+pMhBEpZkSr81G7qwx1ZhmfRK1wv1kfbLhMTd4EN6pgmI
 6f1PKFoLTEQCfu78TMI2z1ug1wkTb0AiSVq1eAwF3fQIWirzS7jRpBh859vacEBw9YVQ0EjOV
 eps82smUUP/9znzhUQsbtT/Rcfq/h08/K7mx4dr637eZD6GCXdh0NUKNd+ofo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 8:20 AM Xu Jia <xujia39@huawei.com> wrote:
>
> When cmd > 6 or copy_to_user() fail, The variable 'ret' would not be
> returned back. Fix the 'ret' set but not used.
>
> Signed-off-by: Xu Jia <xujia39@huawei.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

> diff --git a/drivers/char/applicom.c b/drivers/char/applicom.c
> index 14b2d8034c51..0ab765143354 100644
> --- a/drivers/char/applicom.c
> +++ b/drivers/char/applicom.c
> @@ -839,7 +839,7 @@ static long ac_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>         Dummy = readb(apbs[IndexCard].RamIO + VERS);
>         kfree(adgl);
>         mutex_unlock(&ac_mutex);
> -       return 0;
> +       return ret;
>

Apparently this has been broken since the driver was first merged in
linux-2.3.16. I could find no indication of anyone using the driver
and reporting any problems in the git history and it clearly still has
the style of drivers writting in the 1990s. On the other hand, this is
(was) used in some very long-lived systems and you can still
buy old applicom cards from artisan[1].

Is there any chance this driver is still used anywhere with modern
kernels? I suspect we could move it to staging to find out.

      Arnd

[1] https://www.artisantg.com/Mfgr/MolexWoodheadApplicom
