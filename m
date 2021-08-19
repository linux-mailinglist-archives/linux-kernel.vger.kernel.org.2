Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61FA43F1194
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 05:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236054AbhHSD35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 23:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbhHSD3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 23:29:55 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E6CC061764;
        Wed, 18 Aug 2021 20:29:20 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id v26so3229815vsa.0;
        Wed, 18 Aug 2021 20:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2A4u/99IgT0Yx2tTs0z+0ZQGP7kTvQXLzPf8CzviILI=;
        b=vK+IrsMQylamx6Bd59OdFTrJrKYULqvrIduP9t2uHztpUsCNmmawsDdiGdEN2Z1hT3
         qqabWR676RSa6qZMhXwucCxxwXNUNmql5/9hjhqf7u/slwJR2v0PHhQY2+dVJak/9lcB
         JAM1gv8yMLkvpU7ItIWG/WCuJHvR5TJkn4JCZapJEKEk7vnQBBWmv2ytUMxzqG2VsTX0
         rSsGeEcIx2owA+zhW4fBdZL0Bmgf18GJJNXC2AfQjZLEzskOkVSWAwbu9CwAnxwUUoVZ
         5JJKihmCYz4sE2OoxdkZM4/2kF4V87yYVr1SgQrgjqCYBPkndLYLlelyJJ0yC9SUBPqb
         fRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2A4u/99IgT0Yx2tTs0z+0ZQGP7kTvQXLzPf8CzviILI=;
        b=jkyVrX42nlUXX/vGA2Y54cQTfjYLDRiP3LTlhFqXMfUMrnoLXpH2hKgr88A7nh2il6
         MF9+FyN4hte7A/ZnhIyLMlGrNmFerMDEpKFc2gjQY5d+Uh2XtpKuzX3ikbchoh19lMZm
         EQis1kwt1wr3OYC7wBB8ZKLiFL8gpG6TymamPcXGmcn3JzoZzzJxw+RQyymFBSdulCZH
         2staJ89ckvDSAnZLvc6+R6tHToCHk5CCzwFAfJCeRMwLe1FyLJf6xtGsnb5uOH3JRevC
         fJzpLriCorEhX3lYkd9O4ZW8TFRQ00RYuzu+PRCxJ/OlZkvtpgGLxLpUVztqcWeipf/U
         ouPA==
X-Gm-Message-State: AOAM533Wc93DfrtKgf57qP4XFEk7uso/dk7BORM2X+CQSuvfYNgCtQjx
        f2zb+kfRB8jJcgNWg2JSi+kreuelG6X2/7Y6HIw=
X-Google-Smtp-Source: ABdhPJy9Bw1konRfPpdIMerFeF6JwuxZrNgtMJE/3MN338CoJqhmGlJZCNPyPfd7N+ayyKVKq44Ti6b3O8yAeg49xRk=
X-Received: by 2002:a05:6102:3ed6:: with SMTP id n22mr10620226vsv.24.1629343759062;
 Wed, 18 Aug 2021 20:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210819031407.17044-1-henrybear327@gmail.com>
In-Reply-To: <20210819031407.17044-1-henrybear327@gmail.com>
From:   Henry Tseng <henrybear327@gmail.com>
Date:   Thu, 19 Aug 2021 05:29:08 +0200
Message-ID: <CAA5xa-=upo3b0p0ARPBxzFTDEzH8dELoPO5qMQ1aYq=4mWKg3A@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: Update details of The Linux Kernel
 Module Programming Guide
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     jmseyas@dit.upm.es, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a side note, I tried to put Juan-Mariano de Goyeneche
<jmseyas@dit.upm.es> in cc, as indicated on the kernel-docs file. But
the email account is not reachable.

On Thu, Aug 19, 2021 at 5:16 AM Chun-Hung Tseng <henrybear327@gmail.com> wrote:
>
> Recently, the content and examples of the book "The Linux Kernel Module
> Programming Guide" are being actively maintained and added on Github[1].
> Currently, the book is being regularly built into webpage and pdf
> file using Github static page[2].
>
> [1]: https://github.com/sysprog21/lkmpg
> [2]: https://sysprog21.github.io/lkmpg/
>
> Signed-off-by: Chun-Hung Tseng <henrybear327@gmail.com>
> ---
>  Documentation/process/kernel-docs.rst | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
> index 22d9ace5df2a..631a3dc04e3e 100644
> --- a/Documentation/process/kernel-docs.rst
> +++ b/Documentation/process/kernel-docs.rst
> @@ -126,15 +126,17 @@ On-line docs
>          describes how to write user-mode utilities for communicating with
>          Card Services.
>
> -    * Title: **Linux Kernel Module Programming Guide**
> +    * Title: **The Linux Kernel Module Programming Guide**
>
> -      :Author: Ori Pomerantz.
> -      :URL: https://tldp.org/LDP/lkmpg/2.6/html/index.html
> -      :Date: 2001
> +      :Author: Peter Jay Salzman, Michael Burian, Ori Pomerantz, Bob Mottram,
> +      Jim Huang.
> +      :URL: https://sysprog21.github.io/lkmpg/
> +      :Date: 2021
>        :Keywords: modules, GPL book, /proc, ioctls, system calls,
>          interrupt handlers .
> -      :Description: Very nice 92 pages GPL book on the topic of modules
> -        programming. Lots of examples.
> +      :Description: A very nice 93 pages GPL book on the topic of modules
> +        programming. Lots of examples. Currently the new version is being
> +        actively maintained at https://github.com/sysprog21/lkmpg.
>
>      * Title: **Global spinlock list and usage**
>
> --
> 2.25.1
>


-- 
Best wishes,
Henry
