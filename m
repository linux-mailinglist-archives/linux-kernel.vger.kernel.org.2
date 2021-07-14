Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD1D3C8422
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 13:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239271AbhGNL7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 07:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbhGNL7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 07:59:23 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFC0C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 04:56:32 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id o72-20020a9d224e0000b02904bb9756274cso2166548ota.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 04:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9kEHUnMl2y/OZhBEqOnjX/XYWWhDHxeGf8k78fKCVaE=;
        b=VkTKir8ElhxCJmMr1jc0FLJFJvgk9e1q2aS5Z1qN8srHoJ8hrpKeZaqR2Ghy9z+NRf
         e3Q6ID0Q9yRNIpZdusUT0MprNK3M/ysIhjDgfp15sx37bjHOop6mRLu2K0M3zO+tPs8b
         0sRdqWzkARz8P7qfJcXpuZBYiXEv+7k8Rgmp3ubaAMIEtBB9CM4KK+aE2N32qI/5EmAJ
         l3Fn+kxzcwZPpmYGcdVQZiIl5fAs/jY+GECh/+Ydwni7QVBQ62Zayq2Pn3jjdHPTztYa
         qRQs8hPsyS/6tkw+D1n3Z9iDZHYwTkfKsegVjW7eIcobmQ5OamazNBLdSQ0335RxxbBj
         AM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9kEHUnMl2y/OZhBEqOnjX/XYWWhDHxeGf8k78fKCVaE=;
        b=BVlbNdQlwmYuSe+mEz8UUzPRcmxEl0ZG11hxh3OaT0/J9HZwhjcyoBCxm11dKokPqs
         XmKiBHLwVVvThNd1izK1aKjIK5I+ZGQfdBo86uw3nGErvBmkdo55OYs3tjHWdgGFoSuG
         YQ1H/qGlMCxu3S48KSUUjUSvRrsn4u4dQZMLvxzWpLD0TvVNoATYoW64wcRm42oN1AVe
         joJd8wJSTAzD7pX0GARuXdv/QKMC10fAoiQVzgSjteTfPPI6dfUkPbKLA7zpjRgfYEwj
         /OvNBh3bCt1+zmY52YXEbIuv6Rh6Lro4dbLNVt+3fW0GgsQ7hgZ8IzVFDeHWVKGdvcNG
         0vuw==
X-Gm-Message-State: AOAM530kP28Snx0ILOqutrRnr/DZ6kWNRh/6mxhRSsyarrJm/5P2osJn
        6NDhi0bdnrP5TQKyy2xa0EKZueNP3sBTEeoTCQZ6oQ==
X-Google-Smtp-Source: ABdhPJw7qhGI1OZWtnqDR5Iy6XFYur9FsMF6RC46M6UjN7JmUckEHDXIDorH3DGBdL9pOjsTZfZF+fiibNyeCP16ZUw=
X-Received: by 2002:a05:6830:905:: with SMTP id v5mr7884304ott.17.1626263791564;
 Wed, 14 Jul 2021 04:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210714113140.2949995-1-o451686892@gmail.com>
In-Reply-To: <20210714113140.2949995-1-o451686892@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 14 Jul 2021 13:56:20 +0200
Message-ID: <CANpmjNMe+wyuFLJ0nOk-4Sr57GgBf6VuHa3hmsVUZYJ1gjuC5A@mail.gmail.com>
Subject: Re: [PATCH] kfence: defer kfence_test_init to ensure that kunit
 debugfs is created
To:     Weizhao Ouyang <o451686892@gmail.com>
Cc:     glider@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jul 2021 at 13:31, Weizhao Ouyang <o451686892@gmail.com> wrote:
> kfence_test_init and kunit_init both use the same level late_initcall,
> which means if kfence_test_init linked ahead of kunit_init,
> kfence_test_init will get a NULL debugfs_rootdir as parent dentry,
> then kfence_test_init and kfence_debugfs_init both create a debugfs
> node named "kfence" under debugfs_mount->mnt_root, and it will throw
> out "debugfs: Directory 'kfence' with parent '/' already present!" with
> EEXIST. So kfence_test_init should be deferred.
>
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>

Tested-by: Marco Elver <elver@google.com>

Thank you.

> ---
>  mm/kfence/kfence_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
> index 7f24b9bcb2ec..942cbc16ad26 100644
> --- a/mm/kfence/kfence_test.c
> +++ b/mm/kfence/kfence_test.c
> @@ -852,7 +852,7 @@ static void kfence_test_exit(void)
>         tracepoint_synchronize_unregister();
>  }
>
> -late_initcall(kfence_test_init);
> +late_initcall_sync(kfence_test_init);
>  module_exit(kfence_test_exit);
>
>  MODULE_LICENSE("GPL v2");
> --
> 2.30.2
