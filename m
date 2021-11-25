Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D4B45D85C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 11:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354483AbhKYKqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 05:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352022AbhKYKoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 05:44:04 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1830EC061746
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 02:40:53 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id v7so10674096ybq.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 02:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xa1vZazox6ICgKLpFIvg6K1JUC/KEtKPUA08cmaogzs=;
        b=L36hQ4y5VJsbScrIBBG+WJ8b9mItC1MabGVvD7Hq8NLo3lExxon0sapneQA6D9FRb0
         gk8wk2D+TNQIgYNY6lCAaitOEE1jvS0kD6/VmRm6wU3fB4RG8ttCeEjqzUKAgVz/cnnL
         UudUlOvxjC6U51KWZbtVZeTu9hG8lKHwakVzl4RjisfZs1hpl4J4FZTdYmTg1VOSs20q
         XaVrpEtiXRMcVknmAppC/E/3noqRW1obHfzHz8cE+WnPId6sLHTWSp34Y2ZvxbsZiRRk
         XX7hQdbM431wElGWKJv54RoNllBuPluhoGI0jnEeujYtLkzHDv4iVqpfNpfZhMpPnyXc
         Ccwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xa1vZazox6ICgKLpFIvg6K1JUC/KEtKPUA08cmaogzs=;
        b=ZsdTq1/g7W55YrPRh+zmG0NlaFO3oAe768qoDtAV44sNMvLHMh7cpFztPETxEnVAxj
         YNHnmEgAfA0xIoov+8cCeAOMl/SISgIFUja1WdSDO0HdbRwrplpadFLPoiOHRKYt4ndA
         KnyAKYfDQa+upxEK3ou0jBV2+TTknnQhbRagzv+UZsCcauK0tUMgXCoQ5H6dGl7Zg7xm
         mqQNUUw2Uzf1EQnj74MB2Llwidc93nO20pmt0ED8hb5C8ueRrjl5eY5LiW98xy3pVWMC
         +mdJqVKA7ovxBKqmjIC/MwfLtkwF4V0qcZP327DHGDzGLs3uOShbryBzdqYmAlRqwVVg
         3RtA==
X-Gm-Message-State: AOAM530YPuekSf9TwkNBDchiqvtJMX8a+OZ94fyCctxXYo3UvDzYyY3r
        7aVrdXSlvL74dkRqhvyPVZANat7/wz19fAabVmXzWw==
X-Google-Smtp-Source: ABdhPJzhuxUwCLB7988KOPawNrwByY8pulkA5xPXvlbDYjRLBwkua/kCFbfwQXye+MghxY6YVJaxtrLROtoPY+PwKpM=
X-Received: by 2002:a25:b0a8:: with SMTP id f40mr5033138ybj.125.1637836852216;
 Thu, 25 Nov 2021 02:40:52 -0800 (PST)
MIME-Version: 1.0
References: <20211125083808.82560-1-geert@linux-m68k.org>
In-Reply-To: <20211125083808.82560-1-geert@linux-m68k.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 25 Nov 2021 18:40:11 +0800
Message-ID: <CAMZfGtWUYR0d2QyDA9Y7KZ9dUH4Yj1L6LjfsQ_8qaYyg7s4-aQ@mail.gmail.com>
Subject: Re: [PATCH -next] nubus: Rename pde_data var to fix conflict with
 external function
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Finn Thain <fthain@linux-m68k.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-m68k@lists.linux-m68k.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 4:38 PM Geert Uytterhoeven <geert@linux-m68k.org> w=
rote:
>
> In file included from drivers/nubus/proc.c:24:
> drivers/nubus/proc.c: In function =E2=80=98nubus_proc_rsrc_show=E2=80=99:
> ./include/linux/proc_fs.h:123:21: error: called object =E2=80=98pde_data=
=E2=80=99 is not a function or function pointer
>   123 | #define PDE_DATA(i) pde_data(i)
>       |                     ^~~~~~~~
> drivers/nubus/proc.c:112:13: note: in expansion of macro =E2=80=98PDE_DAT=
A=E2=80=99
>   112 |  pde_data =3D PDE_DATA(inode);
>       |             ^~~~~~~~
> drivers/nubus/proc.c:110:30: note: declared here
>   110 |  struct nubus_proc_pde_data *pde_data;
>       |                              ^~~~~~~~
>
> Fix this by renaming the local variable to "pde".  Do this everywhere
> for consistency.
>
> Reported-by: noreply@ellerman.id.au
> Fixes: e7e935db128e724f ("fs: proc: store PDE()->data into inode->i_priva=
te")

Since the commit ID is not stable, Fixes tag is unnecessary.

> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Not fixed by commit 5de6353a96bec91d ("proc: remove PDE_DATA()
> completely"), which just removes the macro indirection.
> ---

My bad. I didn't realize this situation. Thanks for fixing this.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
