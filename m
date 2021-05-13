Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBBC37F0B6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 02:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbhEMA7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 20:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbhEMA7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 20:59:35 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD0BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 17:58:26 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id n25so29193137edr.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 17:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SAkFgMmSDBXWFgXDmF2oLvN6riN4KtH7cvTnFetkyEQ=;
        b=s6kvF/PEuBEHlhVlNGKgmD9IlAE9BIkGL87m8ZrGkif5ql4HQSsG+dV3zHluDFJUMT
         5VLuGXyNfkif1KWHltToEaWlzAbECHERtijpqQdWOdrnT+7VapH5MMq3e8vtslEwAEko
         zqsdHmdNlCB3J0GO1uJpFegDSu4cGcemvT08gFP72tW8ptshuGLtaK67nbzko4cyD1zl
         uAM1kVeumpnvWvZ5HYoxv9mCYHlVHZDQ29GfSLk2uZUf02QbrER0W9uNXWaZ6Gh5mIj3
         4SITj5AWz+dECsgrvP1sUSTHY9yg9tzCZtfF3NlX0LJn/Eg0W3FCvSYod4Sm2X0ZvzDf
         aX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SAkFgMmSDBXWFgXDmF2oLvN6riN4KtH7cvTnFetkyEQ=;
        b=GJsx70FS3Wzm+JHMLa3n5P3UH34EVO0qebm4l8obYd9aJiT3bF88fAfzi72VijN70Z
         /jh1Oz5Wa2GjcKtTeBdarAMNIQUxLVOtC51b5k+V8AXzE6Cv9RSrfjhem4znRkHlGVVj
         I0yPRmnjgkiFiftyDZUO6P3yqGWZpKrvAu7haQAo/90MoS4qbe3Da3tdwttTpXaK+lNv
         08ZAM8qj+ukPTiGo+7Yl0sDTJXT28rGAazEs0oab55St31nNdePYBhaMzi/v690yp5mu
         SJRP5huWFjnwZvAaNJqZ7uw9pWb/UmEcsadnB/3k4RWVj3JRfTcnvLNuuvfbvgikQxpz
         ZI/A==
X-Gm-Message-State: AOAM531h5cYSbRx4luKeT4eYgLaNO7rt4Q8Z7Qllm77P77NeiziauMW+
        Z0v8L5m09oM+JsiyIHzdOGebK7fxcLSAqPk7QKI=
X-Google-Smtp-Source: ABdhPJz0pGvYY6oiZfoyOXeRbLauc3nsXbEBPV8qDGP+JGGnx0Z0jCpRgQ/8iYGeYBv7UBRVXBYv2HpOOSeNAqohyt8=
X-Received: by 2002:a05:6402:234b:: with SMTP id r11mr46747517eda.137.1620867505040;
 Wed, 12 May 2021 17:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <921e53f3-4b13-aab8-4a9e-e83ff15371e4@nec.com> <CALvZod6J8Nk2Vv8eMo020F-jfKHii3Lu1KxOOaut4U88AH3gfw@mail.gmail.com>
 <CAHbLzkppo+cc1B=K4A5nRyso0UxdaRVe-OqBo7PGPXA-nLSGAg@mail.gmail.com> <701b3c80-b6f0-dcb3-7f3d-da6b74dfc1db@nec.com>
In-Reply-To: <701b3c80-b6f0-dcb3-7f3d-da6b74dfc1db@nec.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 12 May 2021 17:58:13 -0700
Message-ID: <CAHbLzkrRP_KzpKfkTUCHR4hZHD+DtO7isBPqKtcpQbNhSrbNoA@mail.gmail.com>
Subject: Re: [REGRESSION v5.13-rc1] NULL dereference in do_shrink_slab()
To:     =?UTF-8?B?Tk9NVVJBIEpVTklDSEko6YeO5p2RIOa3s+S4gCk=?= 
        <junichi.nomura@nec.com>
Cc:     Shakeel Butt <shakeelb@google.com>, Tejun Heo <tj@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "ktkhai@virtuozzo.com" <ktkhai@virtuozzo.com>,
        "guro@fb.com" <guro@fb.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 5:10 PM NOMURA JUNICHI(=E9=87=8E=E6=9D=91=E3=80=80=
=E6=B7=B3=E4=B8=80)
<junichi.nomura@nec.com> wrote:
>
> On 2021/05/13 1:31, Yang Shi wrote:
> > On Wed, May 12, 2021 at 5:36 AM Shakeel Butt <shakeelb@google.com> wrot=
e:
> >>
> >> +Tejun Heo
> >>
> >> On Wed, May 12, 2021 at 3:48 AM NOMURA JUNICHI(=E9=87=8E=E6=9D=91=E3=
=80=80=E6=B7=B3=E4=B8=80)
> >> <junichi.nomura@nec.com> wrote:
> >>> With the commit 476b30a0949a, if a memcg-aware shrinker is registered=
 before
> >>> cgroup_init(), shrinker->nr_deferred is NULL.  However xchg_nr_deferr=
ed()
> >>> tries to use it as memcg is turned off via "cgroup_disable=3Dmemory".
> >>>
> >>> Any thoughts?
> >
> > Thanks for the report.
> >
> >>
> >> Is there a way to find the call chain of "memcg-aware shrinker is
> >> registered before cgroup_init()"?
> >
> > Other than adding some printk in prealloc_memcg_shrinker() then
> > checking out the output of dmesg I didn't think of a better way. Not
> > sure if we have something like early trace.
>
> This is the first registration of memcg-aware shrinker:
>
> [    1.933693] Call Trace:
> [    1.934694]  sget_fc+0x20d/0x2f0
> [    1.935693]  ? compare_single+0x10/0x10
> [    1.936693]  ? shmem_create+0x30/0x30
> [    1.937693]  vfs_get_super+0x3e/0x100
> [    1.938693]  get_tree_nodev+0x16/0x20
> [    1.939693]  shmem_get_tree+0x15/0x20
> [    1.940693]  vfs_get_tree+0x2a/0xc0
> [    1.941693]  fc_mount+0x12/0x40
> [    1.942693]  vfs_kern_mount.part.43+0x61/0xa0
> [    1.943693]  kern_mount+0x24/0x40
> [    1.944693]  shmem_init+0x5c/0xc8
> [    1.945693]  mnt_init+0x12f/0x24a
> [    1.946693]  ? __percpu_counter_init+0x8f/0xb0
> [    1.947693]  vfs_caches_init+0xce/0xda
> [    1.948693]  start_kernel+0x479/0x4e3
> [    1.949693]  x86_64_start_reservations+0x24/0x26
> [    1.950693]  x86_64_start_kernel+0x8a/0x8d
> [    1.951693]  secondary_startup_64_no_verify+0xc2/0xcb
>
> That is done after command line parsing but before cgroup_init.

Thanks for sharing the log. I was not aware that shmem is initialized
and mounted so early.

>
> >> Irrespective I think we can revert a3e72739b7a7e ("cgroup: fix too
> >> early usage of static_branch_disable()") as 6041186a3258 ("init:
> >> initialize jump labels before command line option parsing") has moved
> >> the initialization of jump labels before command line parsing.
> >
> > Seems make sense to me. If some memcg aware shrinker is registered
> > before cgroup_init(), the mem_cgroup_disabled() check in
> > prealloc_memcg_shrinker() would return false negative. And I don't
> > think any shrinker could be registered before parsing boot
> > commandline.
>
> Thank you.  Shakeel 's patch works for me:
>
>    [PATCH] cgroup: disable controllers at parse time
>    https://lore.kernel.org/linux-mm/20210512201946.2949351-1-shakeelb@goo=
gle.com/

Thanks for running the test.

>
> --
> Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.
