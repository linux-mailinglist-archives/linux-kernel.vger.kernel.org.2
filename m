Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F0244D5FB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 12:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbhKKLn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 06:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbhKKLn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 06:43:26 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DD8C061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 03:40:37 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so488764otj.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 03:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2kswfYXPfOrb43VA/X4OesUiF8o8DkuzTUOlQBSmXF0=;
        b=MJ8tyrwScTqC4dImWwscwqVagJong8JN5+ES17WP+6JD4uW3Kj2MmD8k/yzl5NR80V
         LwyJUTDbK9w4mP7kvVKKSPQJWRLQ1NqmZHb5RlcacNjOrqCA35EOR1GnVeFNmrF6miYe
         gjAykCMYYuib08d57EF4TaV22gtt5Vj3RZPK1dU3TelVbUW8QhycjAUOtZa7nASrgJ+q
         McrdqjAub8FV4wymL9qIOp1rT4bkxeMkK1YjWsAhDPntSzTJBP7+gKSYQiqPHDB2CBfA
         WLzyrmlRDf03vr9POBBa68mEyimTsKHwJmcNndnmhaBd2MwivOEXCoTZRIsTV9QvXAsd
         X3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2kswfYXPfOrb43VA/X4OesUiF8o8DkuzTUOlQBSmXF0=;
        b=Ep4uV+kF0hO+on5ZIBC20LcjFbg89XUIWvh7pVbO1q537vz5y5ARzOy8JTPTBu5AnR
         ipGbWrxYex/FTNppWWqflYAw0sV/zAG52GLC04A2UQQotsbvWgpFaj5nI4D6rK+g7dy8
         KORpZnXH7OK0dYZj4ufuXebE5QUPm3tJHWWJTn4GszSPa6SPbM0WQmFdcCeULH5T4tLl
         aCBy3kOyafAbMltBgqsZ0D1uMbVls6nQwIhJRzVSCgMwBg7RwqYz+uLQJISxjhrSack4
         d0ZGxE9/RkF2v9nyEJOglNMn5fuQeggubQpZHaXaWTeq55exzWGP2s2nH+SkS0I5pMb9
         0QHg==
X-Gm-Message-State: AOAM533MHsam+9T4ELtwek1RaUpaBh4syug+hHb1rlEuMQYsuZQDpQR8
        asdBF89iw6ThuHfJilKB+tAHgEzj+EsJezP/0DUohdBPMYQ=
X-Google-Smtp-Source: ABdhPJyMx+UsrRwT6aFImNsdpBCtCwztby1lv8wnfOfF2gmGQlu4WpDJxWXVZipTFzyKxKJmRdz27zzuXTKOOtPslDQ=
X-Received: by 2002:a9d:7617:: with SMTP id k23mr5208642otl.351.1636630836651;
 Thu, 11 Nov 2021 03:40:36 -0800 (PST)
MIME-Version: 1.0
References: <20211111084617.6746-1-ajaygargnsit@gmail.com> <6864f744-ca3e-f328-8793-2adb0146db03@bytedance.com>
In-Reply-To: <6864f744-ca3e-f328-8793-2adb0146db03@bytedance.com>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Thu, 11 Nov 2021 17:10:24 +0530
Message-ID: <CAHP4M8VNZY+NLzUAVHTWK6a6pggvv4a-q9nvYAqkkco6id3Tog@mail.gmail.com>
Subject: Re: [PATCH] mm: shmem: do not call PageHWPoison on a ERR-page
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     hughd@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> How about the following changes since the above if block
> already do the judgment?
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index f0eee4e221a7..0c84b6624026 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -4195,13 +4195,13 @@ struct page *shmem_read_mapping_page_gfp(struct
> address_space *mapping,
>          BUG_ON(!shmem_mapping(mapping));
>          error = shmem_getpage_gfp(inode, index, &page, SGP_CACHE,
>                                    gfp, NULL, NULL, NULL);
> -       if (error)
> +       if (error) {
>                  page = ERR_PTR(error);
> -       else
> +       } else {
>                  unlock_page(page);
> -
> -       if (PageHWPoison(page))
> -               page = ERR_PTR(-EIO);
> +               if (PageHWPoison(page))
> +                       page = ERR_PTR(-EIO);
> +       }
>
>          return page;


You have

* simply put braces (not required for 1-liner if/else blocks)
* contributed nothing to the issue the patch addresses.

I hope this is not a deliberate joke/spam.
