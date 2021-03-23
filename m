Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B5D3457F5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 07:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCWGqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 02:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhCWGpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 02:45:49 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA783C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 23:45:48 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id y2so11788246qtw.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 23:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d4wUVCs+q4yqVhvcyurU2/LdqdpYfVD9A/k7/oXDROI=;
        b=cGqwhxSZulTffOK8O4wCnjbODH+HguJNxGztEO4goZR0dr1GgItE4emWzegzDVH9IQ
         4PDgo7AGZuoYQ4x2qObk0co/OZmEmkYlGRDTsMXEhNzjy6rC9/0qStw4mtEaiIoZDj7B
         bzTu7b5QwZQ1KTrBPBZqMST7ijMlXa6smPXY1/tABjWp0R7afxgbu6q5Plm62OtivLMF
         fMcor9DUiozTlr8paLw276A+s1d4kBd+BjUBkLI5MEneKHs/iJQIq7nNJWEid6dN2Zw3
         Y/ZEKvUhrwrMgULQDQ40Tlz42yk2CXlNMxLgRtuZiJ6fAAc/2x3HdWcuYq8+iZk8tmo5
         KtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d4wUVCs+q4yqVhvcyurU2/LdqdpYfVD9A/k7/oXDROI=;
        b=UDwVaqd1PWQDEC5ZQCPWSN8FIxqYKYDOWKCkBUA+Oew8ssPSEK60v9lDXaXmrIdcYZ
         yoX+T/2keL3/fwKExQabpV7Ncb9pXyN9TD6tb54mJClFk+CUsrndOEYyIQ3FRSviD7jM
         cXKTYXv1lorOnwHa9cJupD8YJ1bwgL2ZSFG2BP7dRB2RnBA/JHa1WzNQwL/L5JYe8X49
         kbDr5Kv7rkrv6BiQVoHiRaZRJiy1w1FU/xwozejGCQFjj7XvOTIBHmb6jfZdHmLzhbpP
         8Uo9j6zl806lTTJy+lqnS0UxAV7ytzN/q7dFrcIiIzg4iye5cGCHxPWfzZzmaax0rrNi
         MXxw==
X-Gm-Message-State: AOAM532PEgnbKmidPzRE2etgAiPcxent3h2I0dHmxXYAtyQpl8J98c++
        X6xFm02pj12iTcId0B9LYIgU2bHPZmECOAF1YwVM5Q==
X-Google-Smtp-Source: ABdhPJwvSVlv2xxeFe+0Gdj6Lj806qdeO2wY5hZdbuOmrNQ0ck42rown0RW/9DjQGcazw3dj3kM3+D8egC/sN994ASE=
X-Received: by 2002:ac8:6696:: with SMTP id d22mr3206970qtp.67.1616481947806;
 Mon, 22 Mar 2021 23:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210323062303.19541-1-tl445047925@gmail.com>
In-Reply-To: <20210323062303.19541-1-tl445047925@gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 23 Mar 2021 07:45:36 +0100
Message-ID: <CACT4Y+atQZKKQqdUrk-JvQNXaZCBHz0S_tSkFuOA+nkTS4eoHg@mail.gmail.com>
Subject: Re: [PATCH] kernel: kcov: fix a typo in comment
To:     tl455047 <tl445047925@gmail.com>
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 7:24 AM tl455047 <tl445047925@gmail.com> wrote:
>
> Fixed a typo in comment.
>
> Signed-off-by: tl455047 <tl445047925@gmail.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

+Andrew, linux-mm as KCOV patches are generally merged into mm.

Thanks for the fix

> ---
>  kernel/kcov.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index 80bfe71bbe13..6f59842f2caf 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -527,7 +527,7 @@ static int kcov_get_mode(unsigned long arg)
>
>  /*
>   * Fault in a lazily-faulted vmalloc area before it can be used by
> - * __santizer_cov_trace_pc(), to avoid recursion issues if any code on the
> + * __sanitizer_cov_trace_pc(), to avoid recursion issues if any code on the
>   * vmalloc fault handling path is instrumented.
>   */
>  static void kcov_fault_in_area(struct kcov *kcov)
> --
> 2.25.1
>
