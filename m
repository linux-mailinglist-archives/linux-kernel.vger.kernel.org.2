Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471D639173B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 14:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbhEZMUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 08:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233903AbhEZMUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 08:20:11 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EBCC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 05:18:39 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id f1so635845uaj.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 05:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M7Ji5vrSL6OkPbDnQhTWamwkleFmK1zmWlIY7z40fE4=;
        b=Q0Vb/gacOEFW+Ac0t18wwljAd+DIniN8JX03xtm2pd2k4BCPKcZWFRRpEqFkiGHwvr
         BbonaMYr7MQDI9hbZxt8aJMmM5oGIfn2abZiAwuWydXZ8qCeGTHlMzy/jAO7XpSM0kt9
         d/QVbfUty2Qjhar/SkSYmP4v7aPFrL6OjEU4Hkrh70fCUa37yqUTr1Xe5DDFeaQtNWx9
         32YxRF8uFiN9E25aCMsMvtqnV5QgVNFnVbozwyf1SzDrMm1oxNxCETrusgS47oTdpyuG
         9vqaB/UT/mhcsuCzfuoPZkcGodn8w496OAx60grTKRWxXKhD71/09ukTcAhyYVSSk8JJ
         Y7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M7Ji5vrSL6OkPbDnQhTWamwkleFmK1zmWlIY7z40fE4=;
        b=a9C54gzSg6wJdfQql3GdD97vsznC+X3BXp0S7BteJQBc3ydy2HIpei5ZgY76eDk6x7
         tYsq/cpMpz1jtAVeH71+yuMLNacu92c4j/AvJ2d7uwPQpOZEoxwhtzuaTeTiZn3sXIvH
         8vzd7GgkNdDRCEKMwvizY4jRv7fKEjBsUrbHyhJJeEVTPBQOPkny9wwluQaKpMpDXNEL
         hXnlv4DdN2pzao2+zxcADODbafseQ08mTf43uObNFQvN4KnSShJZjn6lL6K1dJYYDAhl
         nRUBvNGfg33vEI+FStXNYB+wQmQVAHAMlgrsBqKyFLkUaLfeQEG3ROsA7syWqERxzRdM
         WtPQ==
X-Gm-Message-State: AOAM531aE68QtsG7dSy6B0+NQ29rUCO8CduvobMYVEqBIzOrGbm0+yGN
        +m2sOmV8Omg7As7yOoo5ei8xQFr/JVt2HwM3+33BFA==
X-Google-Smtp-Source: ABdhPJyGM9+FQkx+xm3SeaOXUXMYN3IdiymAbP51Y/mCSBGBf/VPfy+HqghEheyo9SZeYdXHRBtne5NfZXal+CHiVQY=
X-Received: by 2002:a1f:9505:: with SMTP id x5mr26912741vkd.6.1622031518172;
 Wed, 26 May 2021 05:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210320045720.11872-1-chgokhl@gmail.com> <CAPDyKFqXtKPngfnQZXXaF=rvqw0=nWzDc7P++QxNHPwGHHSxUA@mail.gmail.com>
 <CAMjpFAW0D12vxNSYLcwSWxf-zB+toT5cmiQ8mtUUE+nzWMJZ3g@mail.gmail.com> <CAPDyKFqqRY3rj9zzzDvPTCO68abfQ+G-siAJVgdPuESUwko28A@mail.gmail.com>
In-Reply-To: <CAPDyKFqqRY3rj9zzzDvPTCO68abfQ+G-siAJVgdPuESUwko28A@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 26 May 2021 14:18:01 +0200
Message-ID: <CAPDyKFqBJu7yg62+cOp0TBFf7T1BCy60i_HonOoVXo8QEa3jaQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Mark mmc_host device with pm_runtime_no_callbacks
To:     chgokhl@163.com
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kehuanlin@fishsemi.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2021 at 15:00, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 23 Mar 2021 at 11:49, hieagle <chgokhl@gmail.com> wrote:
> >
> > We encounter a resume issue in our device sometimes. The mmc device's
> > parent list is
> > mmc0:0001->mmc_host mmc0->fa630000.mmc->soc in our soc. We found in the blow
> > case with mmc0->power.disable_depth=0 the mmc_runtime_resume will be skipped,
> > which cause subsequent mmc command fail.
> >
> > mmc_get_card(mmc0:0001)->pm_runtime_get_sync->rpm_resume(mmc0:0001)->rpm_resume(mmc0)
> > The rpm_resume(mmc0) return -ENOSYS due to no callback and
> > mmc0->power.runtime_status
> > keep RPM_SUSPENDED. This lead to rpm_resume(mmc0:0001) return -EBUSY and skip
> > rpm_callback which call mmc_runtime_resume, the mmc is still in
> > suspended and the
> > subsequent mmc command fail.
> >
> > [  198.856157] Call trace:
> > [  198.858917] [<ffffff800808bd9c>] dump_backtrace+0x0/0x1cc
> > [  198.864966] [<ffffff800808bf7c>] show_stack+0x14/0x1c
> > [  198.870627] [<ffffff8008400e88>] dump_stack+0xa8/0xe0
> > [  198.876288] [<ffffff800854d38c>] rpm_resume+0x850/0x938
> > [  198.882141] [<ffffff800854cd8c>] rpm_resume+0x250/0x938
> > [  198.887994] [<ffffff800854d4c4>] __pm_runtime_resume+0x50/0x74
> > [  198.894530] [<ffffff80087b9e64>] mmc_get_card+0x3c/0xb8
> > [  198.900388] [<ffffff80087cd2e0>] mmc_blk_issue_rq+0x2b0/0x4d8
> > [  198.906824] [<ffffff80087cd5e4>] mmc_queue_thread+0xdc/0x198
> > [  198.913165] [<ffffff80080d4b2c>] kthread+0xec/0x100
> > [  198.918632] [<ffffff8008083890>] ret_from_fork+0x10/0x40
> > [  198.924582] mmc0  callback           (null)
> > [  198.935837] mmcblk mmc0:0001: __pm_runtime_resume ret -16
> >
> > Mark mmc_host device with pm_runtime_no_callbacks will solve the issue.
> > Thanks.
> > Huanlin Ke

So I have looked a bit closer to this, finally. Apologies for the delay.

If I am not mistaken, rpm_resume() should *not* be called recursively
for a device's parent, unless the parent's ->power.disable_depth has
been decremented to zero. No matter if we have called
pm_runtime_no_callbacks() for the child device or not.

In the scenario you describe, the parent device corresponds to the mmc
class device (initialized in mmc_alloc_host()). Since the mmc core
never calls pm_runtime_enable() for it, its - >power.disable_depth
should always remain greater than 0.

Although, I admit, the code in runtime.c isn't that easy to browse, so
I may be wrong. That said, I fail to see how -ENOSYS can be returned
rpm_resume() in the path you describe.

Would it be possible for you to provide more logs to show this?

Or could it be that you have a patch locally that calls
pm_runtime_enable() for the mmc class device, somewhere? That would
also explains things? :-)

[...]

> > >
> > > On Sat, 20 Mar 2021 at 05:57, kehuanlin <chgokhl@gmail.com> wrote:
> > > >
> > > > The rpm_resume() will call parent's resume callback recursively.
> > > > Since mmc_host has no its own pm_runtime callbacks, the mmc devices
> > > > may fail to resume (-ENOSYS in rpm_callback) sometimes. Mark mmc_host
> > > > device with pm_runtime_no_callbacks can fix the issue.
> > >
> > > Can you please elaborate more on this? What do you mean by "sometimes"?
> > >
> > > More precisely, how do you trigger the rpm_callback() for mmc class
> > > device to return -ENOSYS?
> > >
> > > Don't get me wrong, the patch is fine, but I want to understand if it
> > > actually solves a problem for you - or that it's better considered as
> > > an optimization?
> > >
> > > Kind regards
> > > Uffe
> > >
> > > >
> > > > Signed-off-by: kehuanlin <chgokhl@gmail.com>
> > > > ---
> > > >  drivers/mmc/core/host.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> > > > index 9b89a91b6b47..177bebd9a6c4 100644
> > > > --- a/drivers/mmc/core/host.c
> > > > +++ b/drivers/mmc/core/host.c
> > > > @@ -15,6 +15,7 @@
> > > >  #include <linux/of.h>
> > > >  #include <linux/of_gpio.h>
> > > >  #include <linux/pagemap.h>
> > > > +#include <linux/pm_runtime.h>
> > > >  #include <linux/pm_wakeup.h>
> > > >  #include <linux/export.h>
> > > >  #include <linux/leds.h>
> > > > @@ -480,6 +481,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
> > > >         host->class_dev.class = &mmc_host_class;
> > > >         device_initialize(&host->class_dev);
> > > >         device_enable_async_suspend(&host->class_dev);
> > > > +       pm_runtime_no_callbacks(&host->class_dev);
> > > >
> > > >         if (mmc_gpio_alloc(host)) {
> > > >                 put_device(&host->class_dev);
> > > > --
> > > > 2.30.0
> > > >

Kind regards
Uffe
