Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5AB3747EB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 20:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbhEESTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 14:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhEESTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 14:19:51 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2251CC061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 11:18:54 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id i81so3027999oif.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 11:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+IwZXLRXE7YG5YvYLQLnS3XtjuwltWw/8OV4sZc7FtQ=;
        b=cYMtDHKCglXEKCG8XFCDw0mo6ut3vuH0OSwu3mg8bbcS7aam9fkng1amjKuyWy10gd
         pkqctId/qGP2+eknKgPx5r2246N18DmMuTnicvkkmVtsBT1oL6PveOm2wAvFLXjhYPlA
         gSMZ4vYuD/VbxHvkEziYMpUWpKR8r79Q+Xdgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+IwZXLRXE7YG5YvYLQLnS3XtjuwltWw/8OV4sZc7FtQ=;
        b=QpWpTiq2QWKcXHpyNgbNnSx3FlQSUkSs5t6+BqOa1IP1mmgPDWzvUIgXv1F+1Wibqp
         lcZJSQ7SyBkXnGLAH2OepNi4Z+Zs+bHN/zEsEUFjeLTCQRfWLcCxXredgSmBszXVbgDb
         EP8BYMqSwktBTZSv18Tw5DrEFMDWTlBdyC2eVLlNRTcXjpUoNj/HwnYB1FzhAy/O/zHl
         QnKq3Z0bKjDe0N+7PB/dwIHA/qzvgPPlGShhKXkTa/6TKGOIsUVXa1ZNuBZmoE7kdRfB
         eghfTdEXUswTbEJrYa8oPOjvB1S0T5a1DEdcc97dbU9d7KjxSPTlp8uKQGCb5WoY6LL5
         7pDQ==
X-Gm-Message-State: AOAM532fkehRz6aEoffl3bFL4WlsD1pvwuuBHifL5fgYoJj0VW2F3aB3
        b1y9/Fo/6CGZqKoxvVXPcxECpNGOz8HaVA==
X-Google-Smtp-Source: ABdhPJx59lWLIwdaQbOsIqZtqFEd0MqyD6zOdMlzGaxEO50t5xgSs8OQVpz73NqBIu9AqpU5xXghrw==
X-Received: by 2002:aca:4887:: with SMTP id v129mr144781oia.137.1620238733271;
        Wed, 05 May 2021 11:18:53 -0700 (PDT)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com. [209.85.210.54])
        by smtp.gmail.com with ESMTPSA id o1sm48253otj.39.2021.05.05.11.18.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 11:18:53 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id f75-20020a9d03d10000b0290280def9ab76so2516814otf.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 11:18:52 -0700 (PDT)
X-Received: by 2002:a9d:425:: with SMTP id 34mr25334436otc.25.1620238732448;
 Wed, 05 May 2021 11:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210220013255.1083202-1-matthewgarrett@google.com> <20210220013255.1083202-7-matthewgarrett@google.com>
In-Reply-To: <20210220013255.1083202-7-matthewgarrett@google.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 5 May 2021 11:18:16 -0700
X-Gmail-Original-Message-ID: <CAE=gft76T7tgvd51e1Wzo6LN9afCLLkjGtN7xDbb6yq=CzbjHA@mail.gmail.com>
Message-ID: <CAE=gft76T7tgvd51e1Wzo6LN9afCLLkjGtN7xDbb6yq=CzbjHA@mail.gmail.com>
Subject: Re: [PATCH 6/9] pm: hibernate: Optionally store and verify a hash of
 the image
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org, linux-pm@vger.kernel.org,
        keyrings@vger.kernel.org, zohar@linux.ibm.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, rjw@rjwysocki.net,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 5:36 PM Matthew Garrett
<matthewgarrett@google.com> wrote:
>
> Calculate and store a cryptographically secure hash of the hibernation
> image if SF_VERIFY_IMAGE is set in the hibernation flags. This allows
> detection of a corrupt image, but has the disadvantage that it requires
> the blocks be read in in linear order.
>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> ---
>  kernel/power/power.h |   1 +
>  kernel/power/swap.c  | 131 +++++++++++++++++++++++++++++++++++--------
>  2 files changed, 110 insertions(+), 22 deletions(-)
>
> diff --git a/kernel/power/power.h b/kernel/power/power.h
> index 778bf431ec02..b8e00b9dcee8 100644
> --- a/kernel/power/power.h
> +++ b/kernel/power/power.h
> @@ -168,6 +168,7 @@ extern int swsusp_swap_in_use(void);
>  #define SF_PLATFORM_MODE       1
>  #define SF_NOCOMPRESS_MODE     2
>  #define SF_CRC32_MODE          4
> +#define SF_VERIFY_IMAGE         8
>
>  /* kernel/power/hibernate.c */
>  extern int swsusp_check(void);
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 72e33054a2e1..a13241a20567 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -31,6 +31,8 @@
>  #include <linux/kthread.h>
>  #include <linux/crc32.h>
>  #include <linux/ktime.h>
> +#include <crypto/hash.h>
> +#include <crypto/sha2.h>
>
>  #include "power.h"
>
> @@ -95,17 +97,20 @@ struct swap_map_page_list {
>  struct swap_map_handle {
>         struct swap_map_page *cur;
>         struct swap_map_page_list *maps;
> +       struct shash_desc *desc;
>         sector_t cur_swap;
>         sector_t first_sector;
>         unsigned int k;
>         unsigned long reqd_free_pages;
>         u32 crc32;
> +       u8 digest[SHA256_DIGEST_SIZE];
>  };
>
>  struct swsusp_header {
>         char reserved[PAGE_SIZE - 20 - sizeof(sector_t) - sizeof(int) -
> -                     sizeof(u32)];
> +                     sizeof(u32) - SHA256_DIGEST_SIZE];
>         u32     crc32;
> +       u8      digest[SHA256_DIGEST_SIZE];
>         sector_t image;
>         unsigned int flags;     /* Flags to pass to the "boot" kernel */
>         char    orig_sig[10];
> @@ -305,6 +310,9 @@ static blk_status_t hib_wait_io(struct hib_bio_batch *hb)
>          * We are relying on the behavior of blk_plug that a thread with
>          * a plug will flush the plug list before sleeping.
>          */
> +       if (!hb)
> +               return 0;
> +
>         wait_event(hb->wait, atomic_read(&hb->count) == 0);
>         return blk_status_to_errno(hb->error);
>  }
> @@ -327,6 +335,8 @@ static int mark_swapfiles(struct swap_map_handle *handle, unsigned int flags)
>                 swsusp_header->flags = flags;
>                 if (flags & SF_CRC32_MODE)
>                         swsusp_header->crc32 = handle->crc32;
> +               memcpy(swsusp_header->digest, handle->digest,
> +                      SHA256_DIGEST_SIZE);
>                 error = hib_submit_io(REQ_OP_WRITE, REQ_SYNC,
>                                       swsusp_resume_block, swsusp_header, NULL);
>         } else {
> @@ -417,6 +427,7 @@ static void release_swap_writer(struct swap_map_handle *handle)
>  static int get_swap_writer(struct swap_map_handle *handle)
>  {
>         int ret;
> +       struct crypto_shash *tfm;
>
>         ret = swsusp_swap_check();
>         if (ret) {
> @@ -437,7 +448,28 @@ static int get_swap_writer(struct swap_map_handle *handle)
>         handle->k = 0;
>         handle->reqd_free_pages = reqd_free_pages();
>         handle->first_sector = handle->cur_swap;
> +
> +       tfm = crypto_alloc_shash("sha256", 0, 0);
> +       if (IS_ERR(tfm)) {
> +               ret = -EINVAL;
> +               goto err_rel;
> +       }
> +       handle->desc = kmalloc(sizeof(struct shash_desc) +
> +                              crypto_shash_descsize(tfm), GFP_KERNEL);
> +       if (!handle->desc) {
> +               ret = -ENOMEM;
> +               goto err_rel;
> +       }
> +
> +       handle->desc->tfm = tfm;
> +
> +       ret = crypto_shash_init(handle->desc);
> +       if (ret != 0)
> +               goto err_free;
> +
>         return 0;
> +err_free:
> +       kfree(handle->desc);
>  err_rel:
>         release_swap_writer(handle);
>  err_close:
> @@ -446,7 +478,7 @@ static int get_swap_writer(struct swap_map_handle *handle)
>  }
>
>  static int swap_write_page(struct swap_map_handle *handle, void *buf,
> -               struct hib_bio_batch *hb)
> +                          struct hib_bio_batch *hb, bool hash)
>  {
>         int error = 0;
>         sector_t offset;
> @@ -454,6 +486,7 @@ static int swap_write_page(struct swap_map_handle *handle, void *buf,
>         if (!handle->cur)
>                 return -EINVAL;
>         offset = alloc_swapdev_block(root_swap);
> +       crypto_shash_update(handle->desc, buf, PAGE_SIZE);

Was this supposed to be conditionalized behind the new parameter, ie:
if (hash) crypto_shash_update()? If so, the same comment would apply
to the read as well.
