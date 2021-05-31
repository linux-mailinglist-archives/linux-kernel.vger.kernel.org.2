Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCBD83964D9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 18:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhEaQNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 12:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbhEaOiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 10:38:12 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F638C061B3E
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 06:52:51 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id k7so1769895pjf.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 06:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IF1aTpQct9sJ+gq1IJA/M4omf+v9Ka1E7+gOZVm10aM=;
        b=e+6fWrmznbU4d7VPIa7bEUQ88+n0IjOWNHrTpuBM/+1AK7iKt500h0t5mVJRSfjXQX
         Hchvbamg/rjKsbf5vaIy2z9A4odpvQ1+RyxpYvcYZK2sKTDBKN1To9KIJdPtHszWtAGC
         pUFuN8tSY0VWh53ZcD/DkOwjNS5fy4+x/PCP/B2O02NYHSV5g7edwJKMVgidF3zCedmI
         4TYTKUuJuFSY+KlhzNJHGbAXV6HcbkrlqMovDugqwot5g6DhvuHFbAkWLUxP8T650vfA
         gX26OGQXgVeB6XilX29VyHWIpNkIOVSlKpcT5wlNDncxDLptcC0yB+GniIFfmM5B1aeW
         xtIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IF1aTpQct9sJ+gq1IJA/M4omf+v9Ka1E7+gOZVm10aM=;
        b=nX0OI1Zk0Nn2O22FiCvj9pZJHcoI0gxgaJAcKtzX0qADCKd0fBcD7rsJ9rvNu4PlRM
         8cjdlqas3eGqhxHjD58GQRMfQTXKxUjBQW1rqP0yTSSoreh98SF2xXG7tM6igu3Y/01D
         CAO9ttZhHi5UivFdg19qQ8NjSkop/cYT3RxKmWiIvhv7TImG/ABGIt96SCi+CvZ0SqSh
         8FjlQhwmhk3JtLeRU9fkOMxWwXFG4AaXg4KszGv7ro9GOZp1d5h6ELzGkIpotjrl7j+v
         Rj7lK/L8Hv0iDTpUqgaewHReDRoTXQiCgH0xyp5QPt0X83EKZPZXqYIkPdXRYSfoVYFa
         Uuqw==
X-Gm-Message-State: AOAM533jWu6iR1XEq2au8kZHeLpWnW8X2sXdTOyQzxQQaz6DjxNg3kKY
        MXA48BbIlKt3TcQkOTxZPTBcTjcnwu2hYkfFm8Rz5w==
X-Google-Smtp-Source: ABdhPJzL5nrqH2nouf+M4B7+QBQmpfIZlVABN9xXH8wmvc/7J63WraTekrOucN8N6yiNpFtbhFQEnWakPlzhGGG4Cck=
X-Received: by 2002:a17:90a:43a6:: with SMTP id r35mr11166114pjg.222.1622469170762;
 Mon, 31 May 2021 06:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210531135622.3348252-1-yukuai3@huawei.com>
In-Reply-To: <20210531135622.3348252-1-yukuai3@huawei.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 31 May 2021 15:52:39 +0200
Message-ID: <CAG3jFyuSheggFGh-6+H7EypHbb7pO=XcsiAYtS5DxB2HdBwt=g@mail.gmail.com>
Subject: Re: [PATCH v2] drm: bridge: cdns-mhdp8546: Fix PM reference leak in
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added r-b tag and merged to drm-misc next.

https://cgit.freedesktop.org/drm/drm-misc/log/?h=drm-misc-next

Thanks for the submission, and sorry about making you jump through all
those hoops.

On Mon, 31 May 2021 at 15:47, Yu Kuai <yukuai3@huawei.com> wrote:
>
> pm_runtime_get_sync will increment pm usage counter even it failed.
> Forgetting to putting operation will result in reference leak here.
> Fix it by replacing it with pm_runtime_resume_and_get to keep usage
> counter balanced.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
> changes in V2:
>  - change error message.
>
>  drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> index 0cd8f40fb690..eab959a59214 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> @@ -2478,9 +2478,9 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
>         clk_prepare_enable(clk);
>
>         pm_runtime_enable(dev);
> -       ret = pm_runtime_get_sync(dev);
> +       ret = pm_runtime_resume_and_get(dev);
>         if (ret < 0) {
> -               dev_err(dev, "pm_runtime_get_sync failed\n");
> +               dev_err(dev, "pm_runtime_resume_and_get failed\n");
>                 pm_runtime_disable(dev);
>                 goto clk_disable;
>         }
> --
> 2.31.1
>
