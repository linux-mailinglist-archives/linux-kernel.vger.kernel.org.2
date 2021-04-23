Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23727369BAE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 22:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbhDWU55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 16:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244007AbhDWU5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 16:57:45 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C019EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 13:57:07 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id s15so58873911edd.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 13:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4y3okfY6wUCp7pKHj4NWsPNZVXlR/XE5MPjlzqfTZc8=;
        b=KufaQpmXgjyF9A7JgNYbtXQ+AA8Kqj4Sxh1WeOo4dGNBl+WC56fCxV5D+JBFSoR4w6
         cL60TUxEaEkKShSjBY9fPxfjCicLsQBU3DE/uu0jQlVqItF9rda+/2ipU2EXzkKydKs4
         C16A3/1svk2g4mLxp0ywlBqzXvFId3qlP/Rrlb6x8G+eVewfkV6ImVKusMu5tfMFSFWZ
         Uob1YzBRNZ0ydfiRe/I0RZ2/AyVF4FBuyXHhUvUycbYC+uMGmNl9vrfLZGez4gJY1f+C
         2vyRqbRgGjILrxEP/iJdYWHbdavnkBeW9xl/xsS493/4hHHHKbVhGAVeyeyb3Y9ttRon
         9KXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4y3okfY6wUCp7pKHj4NWsPNZVXlR/XE5MPjlzqfTZc8=;
        b=N07PUTSXTPlNnRe4wKkpQ5elr8c794fabgEfWC8ZVsYMwrk6BJ3tYb/RqHtV5cStKf
         GJFJCxTEL+/awJJ6HxjXa7DLZuW3A0bMQz4r4J46sy9OM27TwNHoFJ4iCqpTxNeqpicd
         Es+1yhfzEq9LiIUId8hSIQLMvRjZiwJbPTE+KC1DAmYaphDS/qqYqurrS691yat8LgMl
         0gf18FvDgVYyH0xfuK37FoLD0SJA76iqvFlMjdmWP3BryJE3s5+cwB8lJOwzb3HjcPe3
         2B4n5uT0pPp8w4vuG9sESKdrLzQ4HJP0XGW36o/sg3gdqmncvinJ3/zleQzRN4N8y/WI
         X2Cg==
X-Gm-Message-State: AOAM530lUWeY08sO6tqdQI9/8DrTAVT024wNo32XgjmiUAZJOASBHVXf
        jqaXVYlGPo0wallYtglr3GJKzzXSDh9qHPvnHbDPNQ==
X-Google-Smtp-Source: ABdhPJy9GohzDL7jfWfq/OkrOLwhHg2VHjQagcgJNVbGFbTxU0+QO3aSl9S/3bs2FJ2SC/HGXiam5Q2D9iv8WW+H/DM=
X-Received: by 2002:aa7:cd7b:: with SMTP id ca27mr6808638edb.354.1619211426436;
 Fri, 23 Apr 2021 13:57:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org> <20210421130105.1226686-113-gregkh@linuxfoundation.org>
In-Reply-To: <20210421130105.1226686-113-gregkh@linuxfoundation.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 23 Apr 2021 13:57:00 -0700
Message-ID: <CAPcyv4jkEn0JoT7Ha36-janNC3UfV4OLGzYFc=Fxe5Gh9u_wCQ@mail.gmail.com>
Subject: Re: [PATCH 112/190] Revert "libnvdimm/namespace: Fix a potential NULL
 pointer dereference"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kangjie Lu <kjlu@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 6:08 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This reverts commit 55c1fc0af29a6c1b92f217b7eb7581a882e0c07c.
>
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
>
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
>
> Cc: Kangjie Lu <kjlu@umn.edu>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Upon re-review this change still looks correct, no need for a revert.

> ---
>  drivers/nvdimm/namespace_devs.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
> index 2403b71b601e..04f7cb7a23b7 100644
> --- a/drivers/nvdimm/namespace_devs.c
> +++ b/drivers/nvdimm/namespace_devs.c
> @@ -2297,12 +2297,9 @@ static struct device *create_namespace_blk(struct nd_region *nd_region,
>         if (!nsblk->uuid)
>                 goto blk_err;
>         memcpy(name, nd_label->name, NSLABEL_NAME_LEN);
> -       if (name[0]) {
> +       if (name[0])
>                 nsblk->alt_name = kmemdup(name, NSLABEL_NAME_LEN,
>                                 GFP_KERNEL);
> -               if (!nsblk->alt_name)
> -                       goto blk_err;
> -       }
>         res = nsblk_add_resource(nd_region, ndd, nsblk,
>                         __le64_to_cpu(nd_label->dpa));
>         if (!res)
> --
> 2.31.1
>
