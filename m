Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB478440FEE
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 18:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhJaRxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 13:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhJaRxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 13:53:50 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3DAC061714
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 10:51:19 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id s136so15130627pgs.4
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 10:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f8mR+D/eH/dZNNjPVwCwixw0JTq5UBSJUqcsN3WCTdc=;
        b=MvRLH8wCuHLDGU5wWh67k3cqC1Fdd3cZizRDNMF6VwG3BIGVykQrXQ5XqN/SFH4gF0
         aMNjx/sd3ls8H4qnD1YxCP5l5GJAAEpAG/Esp4V6LKux9NYOWi96TwUZ/pFb3TcmZBWP
         zVBzvEL+MVUnbMk9GV0AJMQQu68lxnATIX9jNgOg6W2MrQQWyRvUFoiusZtaNgUAPfI1
         AxT4pyI0WF/pD617rNm69wlS3SI/GAt5yD+1ZKqpLA3r9I/GOI56o8ePSp4PP7gIIGX3
         ZjKHBLE0TTaieZDjpKAQiXOrBhNCxqkLUX94RtN1Jp6OGXuvi8GYPomwsciSqBwOSwmF
         zWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f8mR+D/eH/dZNNjPVwCwixw0JTq5UBSJUqcsN3WCTdc=;
        b=hfMo/t82SfSOWmmSbMVxEk2mqggt4zMFcU0VGsiKbcQez7KO0PsrQKBW1cVP3a5MsF
         O45JZXuBQU6uVUuM+Kd5lXzFo02KWVQvZJwYntMXBbbY2tHpknMYYnyW1nxqGBWN+Iph
         YS69MEU1KYOLPK9/OvDuKgME/KhWNHULx/lWicNnW0bYknNjO0hQx9jdPDATmtqQBsSz
         o8SvGknIpuecBzgENTZi8eScZpVlMoon0xMuI4iglD7jjiBVJLsJOdhYfuiIuJ6pAc1Z
         qOkWRuYZEjqh70tcI484UjaKZBAyw+hE2B5n7vdOkX3ate7cYqrQ8lSMaYeOtbKL3gv0
         UBeQ==
X-Gm-Message-State: AOAM531xjHHLSylIg4UnEzg85AgtAdxCC4mpETIiJz1H2YgaaKHqFNAc
        3n9kejodQbV4K2Fm8nlo5a1rxAbGRJWbowRMviyrkg==
X-Google-Smtp-Source: ABdhPJwgKG5Mr66Ui8RTcSTuDFaX+/IepWZB1EHkIZ09RxQEUmJyKltynz0/5/JNtOiXpRzef+xr6SruizxyjaU9z7s=
X-Received: by 2002:a63:6bc2:: with SMTP id g185mr17997770pgc.356.1635702678641;
 Sun, 31 Oct 2021 10:51:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211015235219.2191207-1-mcgrof@kernel.org> <20211015235219.2191207-5-mcgrof@kernel.org>
In-Reply-To: <20211015235219.2191207-5-mcgrof@kernel.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 31 Oct 2021 10:51:08 -0700
Message-ID: <CAPcyv4g98Dk4HFvgzEeCfCNjF-vjfpEhjGjsPDazGPg-BqMr8A@mail.gmail.com>
Subject: Re: [PATCH 04/13] nvdimm/btt: use goto error labels on btt_blk_init()
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Geoff Levand <geoff@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Jim Paris <jim@jtan.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>, senozhatsky@chromium.org,
        Richard Weinberger <richard@nod.at>, miquel.raynal@bootlin.com,
        vigneshr@ti.com, Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-mtd@lists.infradead.org,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-nvme@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 4:53 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> This will make it easier to share common error paths.
>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  drivers/nvdimm/btt.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
> index 29cc7325e890..23ee8c005db5 100644
> --- a/drivers/nvdimm/btt.c
> +++ b/drivers/nvdimm/btt.c
> @@ -1520,10 +1520,11 @@ static int btt_blk_init(struct btt *btt)
>  {
>         struct nd_btt *nd_btt = btt->nd_btt;
>         struct nd_namespace_common *ndns = nd_btt->ndns;
> +       int rc = -ENOMEM;
>
>         btt->btt_disk = blk_alloc_disk(NUMA_NO_NODE);
>         if (!btt->btt_disk)
> -               return -ENOMEM;
> +               goto out;

I tend to not use a goto when there is nothing to unwind.

The rest looks good to me. After dropping "goto out;" you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
