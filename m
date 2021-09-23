Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1EBD416489
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 19:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242538AbhIWRlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 13:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242402AbhIWRlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 13:41:04 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA6FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 10:39:32 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id c7so24988874qka.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 10:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8tzYzW9ssEz6BTq7KxGd6zNB6scfISySpG7l9Pl80cU=;
        b=H75LXkHaUwwAm4BSpDy5AnWV+XSOZDev7FrpykS/giXYt858AYzZMFCD3sSFA3XTgW
         IoLkAdCptqfhxxVmm307Jxfj+YONQVCV+SOmKeBbR3iazzdB24BHc+osZoc9XDQ4RDeo
         mylQXDgC/2mJ87MbzTLjI7+q/0K5PYy3/ZDV1QKj8XXv348jKubbFl747ZT7fBY9TiRV
         SL4OHhMJMuNNSxmUqv793WSjNyf52APfmx6XEc4KaLP8ebD08k+kn1EUy4Q3GphQL2AA
         E4dyYL7+zcabtSFOErnxOrGsLuxAtEN5FZHjIEChPTuLB9yG7/oYm0nmQmBvzQ19lBu6
         1ZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8tzYzW9ssEz6BTq7KxGd6zNB6scfISySpG7l9Pl80cU=;
        b=efyD266aIh8gAeHZLV7vleuAWq64ZlXMY5ELIPuH0Pg3zfIptr2cF0f7iVaSSbBImh
         O7uI6G2DfeI/tAAClAQr09TOs01+vzhgHuRqJsahAxWrvPoMhoskLxi/OiZFrxl5fCsg
         O7iU8VXs9XfyACSt7Lgkl3IEo+yM8tW3lQATsEOt1+4H+D/p3KCPOUold7SQHLWhDyMj
         ZhoREbfVdQ/bwVvzD/GVNq3gpuF0itUexIIPzrN+gId15USthxtRLeFaJOUXdsFaRh0j
         hmAat18YXAsQOODnDvYesau3Szz6L3GIWAMlZTjolHDJ4lAxuKH6sp3h6DqCGF1dcfH3
         qILg==
X-Gm-Message-State: AOAM5315qZAEudFRrl9GPfVhCXQj4blH1Krs4wKurlA6m/cZtf+qDf1d
        7m5A4lJ78JdjNBoie/eJQE+2Gdhf7ScLQs5uMBuU/A==
X-Google-Smtp-Source: ABdhPJxMiGRNL56xDmo++U1oL8Ec3RGjkClfKTvyu24aijyR99utYnUTBPMTCoyY+GtGCMls81F+wxB5dZSTid4QofI=
X-Received: by 2002:a37:a90d:: with SMTP id s13mr6209571qke.115.1632418771499;
 Thu, 23 Sep 2021 10:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210922182541.1372400-1-elver@google.com>
In-Reply-To: <20210922182541.1372400-1-elver@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 24 Sep 2021 01:39:19 +0800
Message-ID: <CABVgOSmKTAQpMzFp6vd+t=ojTPXOT+heME210cq2NA0sMML==w@mail.gmail.com>
Subject: Re: [PATCH] kfence: test: use kunit_skip() to skip tests
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 2:26 AM Marco Elver <elver@google.com> wrote:
>
> Use the new kunit_skip() to skip tests if requirements were not met. It
> makes it easier to see in KUnit's summary if there were skipped tests.
>
> Signed-off-by: Marco Elver <elver@google.com>
> ---

Thanks: I'm glad these features are proving useful. I've tested these
under qemu, and it works pretty well.

Certainly from the KUnit point of view, this is:
Reviewed-by: David Gow <davidgow@google.com>

(A couple of unrelated complaints about the kfence tests are that
TRACEPOINTS isn't selected by default, and that the manual
registering/unregistering of the tracepoints does break some of the
kunit tooling when several tests are built-in. That's something that
exists independently of this patch, though, and possibly requires some
KUnit changes to be fixed cleanly (kfence isn't the only thing to do
this). So not something to hold up this patch.)

Cheers,
-- David

>  mm/kfence/kfence_test.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
> index f1690cf54199..695030c1fff8 100644
> --- a/mm/kfence/kfence_test.c
> +++ b/mm/kfence/kfence_test.c
> @@ -32,6 +32,11 @@
>  #define arch_kfence_test_address(addr) (addr)
>  #endif
>
> +#define KFENCE_TEST_REQUIRES(test, cond) do {                  \
> +       if (!(cond))                                            \
> +               kunit_skip((test), "Test requires: " #cond);    \
> +} while (0)
> +
>  /* Report as observed from console. */
>  static struct {
>         spinlock_t lock;
> @@ -555,8 +560,7 @@ static void test_init_on_free(struct kunit *test)
>         };
>         int i;
>
> -       if (!IS_ENABLED(CONFIG_INIT_ON_FREE_DEFAULT_ON))
> -               return;
> +       KFENCE_TEST_REQUIRES(test, IS_ENABLED(CONFIG_INIT_ON_FREE_DEFAULT_ON));
>         /* Assume it hasn't been disabled on command line. */
>
>         setup_test_cache(test, size, 0, NULL);
> @@ -603,10 +607,8 @@ static void test_gfpzero(struct kunit *test)
>         char *buf1, *buf2;
>         int i;
>
> -       if (CONFIG_KFENCE_SAMPLE_INTERVAL > 100) {
> -               kunit_warn(test, "skipping ... would take too long\n");
> -               return;
> -       }
> +       /* Skip if we think it'd take too long. */
> +       KFENCE_TEST_REQUIRES(test, CONFIG_KFENCE_SAMPLE_INTERVAL <= 100);
>
>         setup_test_cache(test, size, 0, NULL);
>         buf1 = test_alloc(test, size, GFP_KERNEL, ALLOCATE_ANY);
> --
> 2.33.0.464.g1972c5931b-goog
>
