Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A4D3C60BF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 18:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbhGLQrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 12:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbhGLQrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 12:47:01 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9350BC0613E5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 09:44:12 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d2so26582790wrn.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 09:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qv3Vo5xsbAOEJgLGiYQjQnACJg9fyGkdPANxzyRJ0u0=;
        b=YxBBHmI3ihh3rUAZ/HpfxdYI/ND6OwEcRE87eHmz6vpJk0+eabbOKTLzjPAHhaPmZk
         w32aSCR6KLnikoJXR6BtzDh90JoGuS28RKqIIjENeZZmUYEJbwP8Mrqu2BnPsUkY6leN
         mlEGsZM2OSF1zTCti5cuAFklbPzZbbkIXnuCMAn4Inb/Yki03iwTSTwuisyOIqeAKTE7
         QKASs/Hu4FEREVrYg4reYBvWwaJFvJVrj4KE8PiPEYUzXxveOwK7dY2fS5PtuTd6sNzp
         aA44ScWsNdRd6mTHuz1xxlWdPTrQHl8oxnscIvCCbhC8KmermcAzaNyALgsZ3A/HUTSi
         cg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qv3Vo5xsbAOEJgLGiYQjQnACJg9fyGkdPANxzyRJ0u0=;
        b=p0jQiDrrrnostcKYxMlYvgcD/99MvZ8hnvXT+f5likZ4uP9jvoHqkY0tjM5jV+yXcF
         ys2W4WFpz6KZctgkXuDSYLIfic8uLST615BaFT6y9xuklvOCdgA+loj3YG5geZ/hszNw
         8o2TjBsKrx74xKS9QckEil7NXlysdhdItNSm2Zaw19wGPg/t6OkBlgULJJXY7zygTmCa
         ge3Mnd2TEPYzC55rrpeyl1Nc45HIZx2GfT/s3tmlg5mNSrP2KFSkNBBSW+EMam/rXH6M
         +OPAVn62rO5f23wRaoOzuetdWn4eFkBiMqBbGFxKGbzgiedhIi7Xznd/Cl3JKCzN+VLs
         J5jw==
X-Gm-Message-State: AOAM531O6b9y3XWHKFHewdxETCYopASvnEzSo6H4w05YTTKGBKdo1Zfb
        NwXpKYBjyvuf6WkouVr7In8PfQ==
X-Google-Smtp-Source: ABdhPJwK3VzhGWa3A0Cjl11xE5bb+9d9dgWz6yHyUkbAZ6XWnHp3BGzBwKSF+UhXsDpR3C0/w/Rt9g==
X-Received: by 2002:a5d:530c:: with SMTP id e12mr28211287wrv.130.1626108251006;
        Mon, 12 Jul 2021 09:44:11 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:30c:6a5f:a6ae:eba0])
        by smtp.gmail.com with ESMTPSA id f2sm14920362wrq.69.2021.07.12.09.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 09:44:09 -0700 (PDT)
Date:   Mon, 12 Jul 2021 18:44:04 +0200
From:   Marco Elver <elver@google.com>
To:     Woody Lin <woodylin@google.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/kasan: move kasan.fault to mm/kasan/report.c
Message-ID: <YOxxVKvJxVfQxLv7@elver.google.com>
References: <20210712151618.1549371-1-woodylin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712151618.1549371-1-woodylin@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 11:16PM +0800, 'Woody Lin' via kasan-dev wrote:
> Move the boot parameter 'kasan.fault' from hw_tags.c to report.c, so it
> can support all KASAN modes - generic, and both tag-based.
> 
> Signed-off-by: Woody Lin <woodylin@google.com>
> ---
>  Documentation/dev-tools/kasan.rst |  2 ++
>  mm/kasan/hw_tags.c                | 43 -------------------------------
>  mm/kasan/report.c                 | 29 ++++++++++++++++++---
>  3 files changed, 28 insertions(+), 46 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index 83ec4a556c19..ab8e27d45632 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -203,6 +203,8 @@ boot parameters that allow disabling KASAN or controlling its features.
>    report or also panic the kernel (default: ``report``). The panic happens even
>    if ``kasan_multi_shot`` is enabled.
>  
> +  Note: The boot parameter 'kasan.fault' is supported by all KASAN modes.

This documentation change seems hacked on. Could we change it like this:

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index 83ec4a556c19..21dc03bc10a4 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -181,9 +181,16 @@ By default, KASAN prints a bug report only for the first invalid memory access.
 With ``kasan_multi_shot``, KASAN prints a report on every invalid access. This
 effectively disables ``panic_on_warn`` for KASAN reports.
 
+Alternatively, independent of ``panic_on_warn`` the ``kasan.fault=`` boot
+parameter can be used to control panic and reporting behaviour:
+
+- ``kasan.fault=report`` or ``=panic`` controls whether to only print a KASAN
+  report or also panic the kernel (default: ``report``). The panic happens even
+  if ``kasan_multi_shot`` is enabled.
+
 Hardware tag-based KASAN mode (see the section about various modes below) is
 intended for use in production as a security mitigation. Therefore, it supports
-boot parameters that allow disabling KASAN or controlling its features.
+additional boot parameters that allow disabling KASAN or controlling features:
 
 - ``kasan=off`` or ``=on`` controls whether KASAN is enabled (default: ``on``).
 
@@ -199,10 +206,6 @@ boot parameters that allow disabling KASAN or controlling its features.
 - ``kasan.stacktrace=off`` or ``=on`` disables or enables alloc and free stack
   traces collection (default: ``on``).
 
-- ``kasan.fault=report`` or ``=panic`` controls whether to only print a KASAN
-  report or also panic the kernel (default: ``report``). The panic happens even
-  if ``kasan_multi_shot`` is enabled.
-
 Implementation details
 ----------------------
 

[...]
> -/* Whether to panic or print a report and disable tag checking on fault. */
> -bool kasan_flag_panic __ro_after_init;

There's also an extern declaration in kasan.h, which should be removed.

Thanks,
-- Marco
