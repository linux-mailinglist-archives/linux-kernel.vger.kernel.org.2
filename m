Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9263770B1
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 10:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhEHIfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 04:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhEHIfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 04:35:43 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561F5C061574
        for <linux-kernel@vger.kernel.org>; Sat,  8 May 2021 01:34:41 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id m13so10985070oiw.13
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 01:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GQvUcd2bMYxPOFUAKWZ4rFYcQi8hK52tVHiFNiIyW3s=;
        b=gOZkzac6I3DxDnRQOJXp6kDumY6Yhgzxm3Bww54hhnmoV9gUUzHmjuXvz++OATTkVz
         AqnSSwc+hgmyyb3zNCK54n+erRP1V6aq4Aa2ux5laJytg+c2FmqzJhD5tCbUMuIdwMdC
         cYHsuk4jVVcmFLgR2QGH/ndFyCQhbm9eVto7EleKm2uQSkahzh2+3tNSM59wBaNXII3+
         ZNyvsEvGavRIRr13DcaQEJc2yhEi13gH6L7p6WOopgs2uokF3Sxfc5fwlCLwBJFloEK7
         f23MA94ce08JpX+HWDVxH4M+cR1jHKmT8ezx66o3rBu/hYiUXtd/Y32Ni+8z3GA9sYEu
         darQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GQvUcd2bMYxPOFUAKWZ4rFYcQi8hK52tVHiFNiIyW3s=;
        b=FFdHReFX5ua61VmOaJnGk7ymQeN6RrEh7eFA2pXLdYcY0LViNtN/wMLZHBoeGIUs1S
         wr//qN9+H41VdbfBpcRpvN0NMq1szZYemEux1PxlmA4vTHa4EONFzT/tCClw8cSAReSb
         5o7i6zkPvsI77pcIH2ZoSPJ4HpqjiRCEswxQAY6XFwAC4PwQpEH0WRi/n57el8ABs9gF
         ll3UdwlP5i18KyVuk8mUczXiIG+Nlk4aCMK3XcyRfbh1nYE81aETpyPwIXl09xDegUmZ
         for+jRefoqun6KaHFM77IcG70n1gbCWsh1ARd5l1/E3qj9oYrSLxXlMyimeBTL1rZEZm
         QyVg==
X-Gm-Message-State: AOAM532Rt00cjKr1n+jN+2RQjI02sMqW7VxBwnBXGD7+xu0XDeoBZ4DQ
        7N3/XLv9fTaHUevV46NB8IccEva3ejtfQDYYR1Fwe+W3HNzqyw==
X-Google-Smtp-Source: ABdhPJyzx7sVk7pTkBe4kwvxUe7mb8i6reNtakTTTTjxA4qgvqc9B/8soObASzRbQOG8X7SZ+WJUlmAtJ9eeCxjOIbU=
X-Received: by 2002:aca:1b12:: with SMTP id b18mr17594519oib.130.1620462880661;
 Sat, 08 May 2021 01:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210426134346.6126-1-lyl2019@mail.ustc.edu.cn>
In-Reply-To: <20210426134346.6126-1-lyl2019@mail.ustc.edu.cn>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Sat, 8 May 2021 11:34:14 +0300
Message-ID: <CAFCwf11LKxvM+ixvmjsB9xHbmukKeFCouT-eNLRGEEFSGnzXQQ@mail.gmail.com>
Subject: Re: [PATCH] habanalabs/gaudi: Fix a potential use after free in gaudi_memset_device_memory
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Cc:     Oded Gabbay <ogabbay@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Ofir Bitton <obitton@habana.ai>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 4:44 PM Lv Yunlong <lyl2019@mail.ustc.edu.cn> wrote:
>
> Our code analyzer reported a uaf.
>
> In gaudi_memset_device_memory, cb is get via hl_cb_kernel_create()
> with 2 refcount.
> If hl_cs_allocate_job() failed, the execution runs into release_cb
> branch. One ref of cb is dropped by hl_cb_put(cb) and could be freed
> if other thread also drops one ref. Then cb is used by cb->id later,
> which is a potential uaf.
>
> My patch add a variable 'id' to accept the value of cb->id before the
> hl_cb_put(cb) is called, to avoid the potential uaf.
>
> Fixes: 423815bf02e25 ("habanalabs/gaudi: remove PCI access to SM block")
> Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> ---
>  drivers/misc/habanalabs/gaudi/gaudi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
> index 9152242778f5..ecdedd87f8cc 100644
> --- a/drivers/misc/habanalabs/gaudi/gaudi.c
> +++ b/drivers/misc/habanalabs/gaudi/gaudi.c
> @@ -5546,6 +5546,7 @@ static int gaudi_memset_device_memory(struct hl_device *hdev, u64 addr,
>         struct hl_cs_job *job;
>         u32 cb_size, ctl, err_cause;
>         struct hl_cb *cb;
> +       u64 id;
>         int rc;
>
>         cb = hl_cb_kernel_create(hdev, PAGE_SIZE, false);
> @@ -5612,8 +5613,9 @@ static int gaudi_memset_device_memory(struct hl_device *hdev, u64 addr,
>         }
>
>  release_cb:
> +       id = cb->id;
>         hl_cb_put(cb);
> -       hl_cb_destroy(hdev, &hdev->kernel_cb_mgr, cb->id << PAGE_SHIFT);
> +       hl_cb_destroy(hdev, &hdev->kernel_cb_mgr, id << PAGE_SHIFT);
>
>         return rc;
>  }
> --
> 2.25.1
>
>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>

Thanks for catching this.
Applied to -fixes.
Oded
