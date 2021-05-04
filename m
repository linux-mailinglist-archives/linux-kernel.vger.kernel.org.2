Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2B5372F06
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 19:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhEDRji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 13:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbhEDRjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 13:39:36 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9168C061574;
        Tue,  4 May 2021 10:38:40 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id h20so5517264plr.4;
        Tue, 04 May 2021 10:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QNJjtmC4LH5MOQsZZ3xwG3qSWV/2SFBxdelepW+B2oE=;
        b=KVCR2mhX0hUBSkvTx3AIm1nZy8nRqR6rLL84lwBaflyD4cXrZvhtUgkxyR4XtI+E7/
         aHuvt5xuViLVSTkrlpm4YK+1EF4MDg5R8K/5topC6D4TdWvwq+Ef5jOmER4/cCMM9HOK
         K3XJYRkmcRkw1aUPPathStR96uJPTw6P2jAXAdUaUKL11Lmmq7VZ+j8wabVlwC01UGKT
         gxu+6C6BrRct/sRsVtCEMIb8IpvBJh1n2kg/2ia9Ry1wERqEEB8iinf+krUbhKyxHPDP
         cXUYBRMGNJDEwaC09FWSkd7m6vnsWb039u+PRuBT/rrfa+fEnPOXZ9ggdh6ynTVoquPS
         HmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QNJjtmC4LH5MOQsZZ3xwG3qSWV/2SFBxdelepW+B2oE=;
        b=h+lG6OvumFmTCrY4N3Baz/UFI2io2ldf0dqzpquwtL5tNUJ1+41U1kGKcmYeXFrDjx
         M7O1hUa2iiWja/lkL6qy76Rz78Ai9/S8/szmmWmJNxLp5rXDaiKFoLItJWLfp6HDb+5r
         TOTUce6vJ1TMNFT0sWcm2F3RD8qlPpTXw5DAI0CqCAJBwODO/Otmxr+SX+DGugVKUN1x
         9WapB0dscIW3gMWP8ZozJW2zayjSFr2Nd/nNpseFyKmghv2ydvBmNxLTgbgZGnwJoESn
         tVn/Ke+bV2bwWUqE5Y3UeNv7PIMsqouOSM4C9pSaYkUIRUCIqVVU5O+GPmwMgDo9ecrC
         xgeA==
X-Gm-Message-State: AOAM532tvMNeaLQWz5YtWfMmeVJmzhydqL0QgIbSy8Fo84x6ydwqNmzk
        WDIXrCPCsKJG6QFJ8KMaRmUhyqvE8u/v+YzVGTo=
X-Google-Smtp-Source: ABdhPJyaOX+KjJa4Pqz12rdaM2L2DPdW9GWfIz8bKhcpSgZfT+YnTJs73X6SY2wxED2Tzzx+/q2O+5t6QPMEJUl33sI=
X-Received: by 2002:a17:902:ecc6:b029:ee:af8f:899e with SMTP id
 a6-20020a170902ecc6b02900eeaf8f899emr21240595plh.21.1620149920262; Tue, 04
 May 2021 10:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210504170030.58447-1-wsa+renesas@sang-engineering.com> <20210504170030.58447-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20210504170030.58447-2-wsa+renesas@sang-engineering.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 4 May 2021 20:38:24 +0300
Message-ID: <CAHp75Vc8OGDB0=ta_GLg3Bjv5NK32dMuuaPTX-ETXRDHtRpxnA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] platform/x86: samsung-laptop: set debugfs blobs to
 read only
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 4, 2021 at 8:18 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Those blobs can only be read. So, don't confuse users with 'writable'
> flags.

Not sure if this should be the second patch in the series (sounds like
a potential fix).
Either way
Reviewed-by: Andy Shevchenko <andy.shevchneko@gmail.com>

> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> Change since v1: use octal numbers
>
>  drivers/platform/x86/samsung-laptop.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/x86/samsung-laptop.c b/drivers/platform/x86/samsung-laptop.c
> index 763d97cbbe53..9aa0de8b7581 100644
> --- a/drivers/platform/x86/samsung-laptop.c
> +++ b/drivers/platform/x86/samsung-laptop.c
> @@ -1296,12 +1296,12 @@ static void samsung_debugfs_init(struct samsung_laptop *samsung)
>         debugfs_create_u32("d1", 0644, root, &samsung->debug.data.d1);
>         debugfs_create_u16("d2", 0644, root, &samsung->debug.data.d2);
>         debugfs_create_u8("d3", 0644, root, &samsung->debug.data.d3);
> -       debugfs_create_blob("data", 0644, root, &samsung->debug.data_wrapper);
> -       debugfs_create_blob("f0000_segment", 0600, root,
> +       debugfs_create_blob("data", 0444, root, &samsung->debug.data_wrapper);
> +       debugfs_create_blob("f0000_segment", 0400, root,
>                             &samsung->debug.f0000_wrapper);
>         debugfs_create_file("call", S_IFREG | 0444, root, samsung,
>                             &samsung_laptop_call_fops);
> -       debugfs_create_blob("sdiag", 0644, root, &samsung->debug.sdiag_wrapper);
> +       debugfs_create_blob("sdiag", 0444, root, &samsung->debug.sdiag_wrapper);
>  }
>
>  static void samsung_sabi_exit(struct samsung_laptop *samsung)
> --
> 2.30.0
>


-- 
With Best Regards,
Andy Shevchenko
