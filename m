Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3683C13C3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 15:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhGHNGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 09:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbhGHNGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 09:06:49 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05955C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 06:04:07 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id h5so3511300vsg.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 06:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KEHvtk/qDbB4blO1SCEyQUaWYrL3oXULeK/saz6CTeE=;
        b=AoVRYb45kt0ltweZhxP5zSUmqreVyxGzhf0gfCOx5WHPtiPAeuuN2aeLc5WfwYke3G
         KCG5DghU1Hp3un1DSxPPc+BCmXKhndrA5ZfJU+LP+oSptOxPEOqzFdZEpKAhS+Wc81sz
         vKJgu6XBA/mWwzrEYesOipfqr+E3OpPg3DTWDEr9LbVpljtpI2bUyI5avGDqMoPMofb+
         QEzR9gpXS9XIpuiKfojrj1xM9LWCT1S83yT0/gNiJYt+yO5P1DSSBXH367plz4y/FLs8
         cLluvRJ8zgdIoDHf1H7lmrd1E4I+i6q42vNx/XbZ5CZ0JubHDui5MtOOPaaSxi9JZI3f
         Z9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KEHvtk/qDbB4blO1SCEyQUaWYrL3oXULeK/saz6CTeE=;
        b=MgIXVoTG2VPDiTmT/zY7992jR6Pp7Q+djfOi94kU9eE+p0CmVoZrCvNQlF6WXyB2JY
         kJIMTKk2iAm85+hpgmGZIebVOYzInyP8qjWJFKor3ueZCSMHFBwlsoqDFZ3rHQam9KWW
         93BJM5XLK18MErTRSXPXQ2X7J95+lmL6DZ9ShF8xqGwHmTvuGnOmxqmstUtSQqnz8RW0
         0W25cau19+ssiFqZ77CeMeARHC4674EzsSypGSFiACTZ7HZb5WXigsJh8tHPChR5EGb9
         C4yI/EUb1h87Pf/yzJ4bksy4SMuZ1mvLmfxIvjaz4cVVg4djsLLv+tX4RIJmkIYxw150
         nxvw==
X-Gm-Message-State: AOAM530GRib2Nx7AUAqQgFv+X+L2RMidKF1UwrNqBAv+SyH0a1eKLYzI
        IoZrFwSocagqR/C29+J7/A1cZEEt1Bdh8Sh3iCOZcA==
X-Google-Smtp-Source: ABdhPJxXd15HTOj1S79pKDlOlKLm6vFjRSvtykjfTPrGVEJUaYx/vzhhBQjyJBbp+A/154EsGOxphqSdkkg0KisQ/yE=
X-Received: by 2002:a67:ee54:: with SMTP id g20mr27739180vsp.55.1625749446193;
 Thu, 08 Jul 2021 06:04:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210623101731.87885-1-andriy.shevchenko@linux.intel.com>
 <CAPDyKFoM-gkFPoFePbHS62r-HUpk6ipA5J-qPbQ8NWL9Mm_N2Q@mail.gmail.com> <CAHp75VfdDXwboZWZgRdFNXLpONy8UgDryeZWd6UD2RaCXo=uOw@mail.gmail.com>
In-Reply-To: <CAHp75VfdDXwboZWZgRdFNXLpONy8UgDryeZWd6UD2RaCXo=uOw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 8 Jul 2021 15:03:30 +0200
Message-ID: <CAPDyKFqmswO9a-Sv6Wk5x4XA0P-idT1zZwRvjVbK7oS=J2cesg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mmc: mmc_spi: Simplify busy loop in mmc_spi_skip()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jul 2021 at 14:50, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> On Thu, Jul 8, 2021 at 3:33 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On Wed, 23 Jun 2021 at 12:17, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
>
> ...
>
> > This certainly is an improvement.
> >
> > Although, what do you think of moving to readx_poll_timeout(), that
> > should allow even a better cleanup, don't you think?
>
> I believe you meant rather read_poll_timeout(). Either way I don't see
> the benefit of using that macro when you have to customize its body a
> lot. Besides that the macro doesn't use cond_sched() or even
> schedule() and I'm not sure it will be an equivalent change.
>
> That said, I prefer going this patch as is for the time being. We may
> adjust it later on.

Okay, no strong opinion from my side. Queued for v5.15 on my devel
branch, thanks!

Kind regards
Uffe
