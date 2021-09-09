Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAEF405BA1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 19:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239996AbhIIRBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 13:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239827AbhIIRBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 13:01:17 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC17C061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 10:00:08 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id a13so3201347iol.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 10:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2paSwQM8zCxokyQ6GIbHK5N8e/MvXNOEn1+qQELdMbY=;
        b=bUtpOWsfwWVZVVdqZQr4prAXWhLtnpDKnW1NVBf1elwFDXGPzH9pP5b1AYjXNpKW+u
         KwAITZt6iBOVQ0ZTlqf5VFH27xIBISY6VkY3/Cq77PbQYov7Ve53nGSNZ6ULxrHajpy6
         pPgp8UhXigGWsNhjl4CGV0pLgIinpslfZfcHqpgs6ZvgJCYkkIQxOBQRea3Sn9J6g2gq
         pKoHiQn/cS+lp88/p6m3H17RLTBJb6y71UklEzwU5YUQJw/1G4eCjpRmqJfz1kp7aewE
         SCC3wyxOtQxajE1y0Mkh1S9P/IO2dhn77Fa4rduKB3DBDg0DDp2OS99leBK9UCnD1fUM
         6t2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2paSwQM8zCxokyQ6GIbHK5N8e/MvXNOEn1+qQELdMbY=;
        b=HaNO7b6h7/eOqycWl2gl0N4R3ueOWY7poDP4uHo/5Vuan5a+0lksGPCiHrWr2vFaKV
         UuBiOATCgYOiVwKF1Hai8YdkPe+DsD8UG+D/pWVdeV1PFQ+M5DVFtj0mIYEE64GpMk6u
         h3zwXES/XJ0tBIfIeMVdyoUg+cqTQrcEjH+YeHvxlu5J9fw8pjAepDUahjxyk/9Z569w
         xQhPNRKraCa3UcrrF7gLxjOCT49CqrdGG3OU/gk6HNq/3ghME68rdXcZYcEyS5qDv9/l
         Eyq76W4fwAl9vvKvoGjcOHsa7APDDdep/RDehnziNQOwogQhZEmszBklYm5KUgmiD40S
         T19Q==
X-Gm-Message-State: AOAM53271+1bjMRVfZwsq8l+2XldFqS9oYkTliLStT5K6R4TVZ6DCIMZ
        s7LcXCEXOakjeJpw+PJtIVQsWvz1CnzPugjahUrvRw==
X-Google-Smtp-Source: ABdhPJyvnDOMYLUfuOx8UO8RZc5WDLY8KKpV4m0wWiT2yrmOl6CNyM1Zix/Yg4swBUAJ7F2lxGiM6RMiJY9BpXXVE2s=
X-Received: by 2002:a05:6602:38e:: with SMTP id f14mr3623809iov.62.1631206807352;
 Thu, 09 Sep 2021 10:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <1631172276-82914-1-git-send-email-xiyuyang19@fudan.edu.cn>
In-Reply-To: <1631172276-82914-1-git-send-email-xiyuyang19@fudan.edu.cn>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 9 Sep 2021 09:59:56 -0700
Message-ID: <CAGS_qxp2e3pgZ6nGW+5=qneeVw_Pd_ex9kX4jZqA9bweoHXxFA@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: fix reference count leak in kfree_at_end
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, yuanxzhang@fudan.edu.cn,
        Xin Tan <tanxin.ctf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 9, 2021 at 12:26 AM 'Xiyu Yang' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> The reference counting issue happens in the normal path of
> kfree_at_end(). When kunit_alloc_and_get_resource() is invoked, the
> function forgets to handle the returned resource object, whose refcount
> increased inside, causing a refcount leak.
>
> Fix this issue by calling kunit_alloc_resource() instead of
> kunit_alloc_and_get_resource().
>
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

Ah, thanks for finding and fixing this!
We really should have better documentation/otherwise make it clearer
that people shouldn't use the "_and_get" version.

I went and added some pr_info() calls to verify that these were being
leaked before and they're fixed now.

I copy-pasted this mistake into
https://lore.kernel.org/linux-kselftest/20210831171926.3832806-2-dlatypov@google.com/.
I'll send a v3 fix for that patch as well.

> ---
>  lib/kunit/executor_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
> index cdbe54b16501..c2dcfb1f6e97 100644
> --- a/lib/kunit/executor_test.c
> +++ b/lib/kunit/executor_test.c
> @@ -116,7 +116,7 @@ static void kfree_at_end(struct kunit *test, const void *to_free)
>         /* kfree() handles NULL already, but avoid allocating a no-op cleanup. */
>         if (IS_ERR_OR_NULL(to_free))
>                 return;
> -       kunit_alloc_and_get_resource(test, NULL, kfree_res_free, GFP_KERNEL,
> +       kunit_alloc_resource(test, NULL, kfree_res_free, GFP_KERNEL,
>                                      (void *)to_free);
>  }
>
> --
> 2.7.4
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/1631172276-82914-1-git-send-email-xiyuyang19%40fudan.edu.cn.
