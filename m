Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B9F3FDEF0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 17:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343816AbhIAPq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 11:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343744AbhIAPqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 11:46:25 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4236C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 08:45:28 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id h1so5714215ljl.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 08:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jP3w+o4BmVBswSwGOVrsR8bQFNFZNakg47HbNemsop0=;
        b=zq/9d2PRRWQevSO+07VGZOA9l+Zxx19S+Bk/67A5lUgmWY1/AT9aFOleMRhw1N4yZk
         9nmjGMf3janlGnMq7tGEF6AWVtZN49crvoSjTfkEZpWO8tB/KXGkkUM71pTWmBpOVt6r
         TayEK6fC3lgO27251q/M4RYIdhzCdIXYWiUpotZ1/0f2YcYpSIPsCtzVJOjfOw6ZPSrb
         tWqMtFoW/u626YrqpzzTdknZvX2qTdbZarQQDNB4+UfdnNzteJ5S0FcnrIqHhsId2NMB
         56VLTMwn1N/EIi6LJFzJKTYszhQ3eqQf+mGbSEoF+xg4nW3K6tkZLGxjTlJzhItInx0y
         xgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jP3w+o4BmVBswSwGOVrsR8bQFNFZNakg47HbNemsop0=;
        b=HJSPM5JyfYWbVrEu6D6xAN2mhD7GlbflOPHXBSo12SLBRLghCQYXI9ySqwd26ZqhFW
         Wyc2MN4Gf7IdesRVSm7sqHvqFGYs+hh1NMZFPkOebFSQfwj5K3F7kGEyTzkBBhjoPWFn
         PbkDxs/UHcgnamf8cKoqu7guEGOXsp5VHRBxdzl6YmZDDh7N4xGkb7xokvfHnm30qmME
         9YOe+w7AkmnHQCt5mX8Zlz38bPTWSfABT/7k6t9UKFcB32JwBlKvgp2vvAgsZ5hxEXzk
         vpP2BjTIe7TssX1stfmxibrJfkptQ1IR008/moy2ypRoCI830QVSUpoPd3Z6J0+RsJe8
         4/YQ==
X-Gm-Message-State: AOAM530LCCtrMNgwCDkrJaoQTpG+/nUYwAlwLeqBeoP2j0heBmPqM5LO
        lBpZ5+qi025wBkm9FVj6WtGNOI+fYYD+9nWgr6AmbA==
X-Google-Smtp-Source: ABdhPJyr5EgLia8bbuFUrDzDBajqq+Y0rL5bvgFaEGb+5WU1/MUhW0tUS2GWcBhO8qs45xpXDLEmUTLqayUpKPHLkq0=
X-Received: by 2002:a05:651c:83:: with SMTP id 3mr239098ljq.341.1630511127156;
 Wed, 01 Sep 2021 08:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210831224510.703253-1-saravanak@google.com>
In-Reply-To: <20210831224510.703253-1-saravanak@google.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 1 Sep 2021 17:44:51 +0200
Message-ID: <CAPDyKFpQqKx2UDo4kc3eAxPfp47gOGbjtnm0fg1q+bshpb-vew@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: fw_devlink: Don't create device links for
 devices not on a bus
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Sept 2021 at 00:45, Saravana Kannan <saravanak@google.com> wrote:
>
> Devices that are not on a bus will never have a driver bound to it. So,
> fw_devlink should not create device links for it as it can cause probe
> issues[1] or sync_state() call back issues[2].
>
> [1] - https://lore.kernel.org/lkml/CAGETcx_xJCqOWtwZ9Ee2+0sPGNLM5=F=djtbdYENkAYZa0ynqQ@mail.gmail.com/
> [2] - https://lore.kernel.org/lkml/CAPDyKFo9Bxremkb1dDrr4OcXSpE0keVze94Cm=zrkOVxHHxBmQ@mail.gmail.com/

Unfortunately, this doesn't fix my problem in [2].

When the "soctest" device is initialized, via of_platform_populate(),
it will be attached to the platform bus, hence the check for the bus
pointer that you suggest to add below, doesn't have an impact on my
use case. I still get the below in the log:

"platform soctest: Linked as a sync state only consumer to pm_domain_test"

Kind regards
Uffe

> Fixes: f9aa460672c9 ("driver core: Refactor fw_devlink feature")
> Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/base/core.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index f6360490a4a3..304a06314656 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1719,8 +1719,24 @@ static int fw_devlink_create_devlink(struct device *con,
>         struct device *sup_dev;
>         int ret = 0;
>
> +       /*
> +        * If a consumer device is not on a bus (i.e. a driver will never bind
> +        * to it), it doesn't make sense for fw_devlink to create device links
> +        * for it.
> +        */
> +       if (con->bus == NULL)
> +               return -EINVAL;
> +
>         sup_dev = get_dev_from_fwnode(sup_handle);
>         if (sup_dev) {
> +               /*
> +                * If a supplier device is not on a bus (i.e. a driver will
> +                * never bind to it), it doesn't make sense for fw_devlink to
> +                * create device links for it.
> +                */
> +               if (sup_dev->bus == NULL)
> +                       return -EINVAL;
> +
>                 /*
>                  * If it's one of those drivers that don't actually bind to
>                  * their device using driver core, then don't wait on this
> --
> 2.33.0.259.gc128427fd7-goog
>
