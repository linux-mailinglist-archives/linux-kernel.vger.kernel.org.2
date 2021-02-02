Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D66C30C3DF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 16:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbhBBPcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 10:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235305AbhBBPPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 10:15:36 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D21C061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 07:14:56 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id g15so2566414pjd.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 07:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fngB7/hPQVf+aFcv7HmWUQYiYriqGz3b2AXDUSidr2g=;
        b=UaoWvZITZz9UWKtzGelJeYUVlhiLy4rm7AFnvoB0J4RbkXlR/8eRLFp2tJ8LE3Ne4K
         tgAhTwqQ1qu7nWbIAXL19O2ND+VJmZmbjBRRkMb6l0zLWeJ3DzVXhvhJUolJ4zH2scgu
         cK6whrVklFT8rMOFDgTetgv43iQ8D4RcGVcqY2Vb+JPg0GrEgsQnpRhG+s+GqVaEOz0D
         GdF+kKJz9TdUDdpqPqHdk1xvw93X19Dw4d4hjtxaFZl5NI6GU10EoQIwRKn1SCI4U21C
         EgomlvRwBCDRWNmST05JJ0jbPsfX06/maBCtxgUoUHtC9YtDlB6aeC/y909gs0SNcpQ6
         eyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fngB7/hPQVf+aFcv7HmWUQYiYriqGz3b2AXDUSidr2g=;
        b=iW00p2NDWtm4p5DT/8/3opB0+P/eUUJD1Ftd87yWITsJhcNs2UN7zMXujMGbFJTVjV
         jgkCiA4Opc+8nNWdQY7n0pvKWM3kNt5C7oJQyrocwUEysYA5u/7wqnz8TrQrIInE3cNL
         KVAAf0twGbYpWN1BvVNz5pJet27w9Bzl76W7ce10SDtv+2Cs1DVOcKNFCtBTYJ2JTnMe
         mycRNnwt/sX+gP3T/9XHaqZvo4pXumPy43aqyVa8NUBZBTrhs7d2KezDGS9Z3RFn4oiq
         lvOBDhxACT2nCsTGIZm1f3EGvGy42MUkJmm6Qa82fTkyqKo64xuUMT156kKRZbr4lzOT
         1+dg==
X-Gm-Message-State: AOAM530s30zpUPB5wvIP88jD5NdLeGpxlLChOJO49TAeywDJmzCUwBMH
        ihGLEtNyqE92qeEfJFZKZEU2YbT0skb/TBELmJi+PLUb7WU=
X-Google-Smtp-Source: ABdhPJzCuHFzIXXQYnsmqE9Z/P/5LfemU6yNpau2mXFhGnzYKc7BHc9hByXdwuSwUjFG/j8c8rSqQKYFqIkNGIeP7N4=
X-Received: by 2002:a17:90b:4acc:: with SMTP id mh12mr4855806pjb.10.1612278895762;
 Tue, 02 Feb 2021 07:14:55 -0800 (PST)
MIME-Version: 1.0
References: <1612165363-98394-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1612165363-98394-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Wed, 3 Feb 2021 00:14:44 +0900
Message-ID: <CAC5umyjm3Xr2t6j3N2XHBa+7gjfYa0jOE+WL9_Sq9AWA=Cs5+w@mail.gmail.com>
Subject: Re: [PATCH] fault_inject: Replace DEFINE_SIMPLE_ATTRIBUTE with DEFINE_DEBUGFS_ATTRIBUTE
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2021=E5=B9=B42=E6=9C=881=E6=97=A5(=E6=9C=88) 16:43 Jiapeng Chong <jiapeng.c=
hong@linux.alibaba.com>:
>
> Fix the following coccicheck warning:
>
> ./lib/fault-inject.c:187:0-23: WARNING: fops_stacktrace_depth should be
> defined with DEFINE_DEBUGFS_ATTRIBUTE.
>
> ./lib/fault-inject.c:169:0-23: WARNING: fops_ul should be defined with
> DEFINE_DEBUGFS_ATTRIBUTE.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  lib/fault-inject.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/lib/fault-inject.c b/lib/fault-inject.c
> index ce12621..cb7ea22 100644
> --- a/lib/fault-inject.c
> +++ b/lib/fault-inject.c
> @@ -166,7 +166,7 @@ static int debugfs_ul_get(void *data, u64 *val)
>         return 0;
>  }
>
> -DEFINE_SIMPLE_ATTRIBUTE(fops_ul, debugfs_ul_get, debugfs_ul_set, "%llu\n=
");
> +DEFINE_DEBUGFS_ATTRIBUTE(fops_ul, debugfs_ul_get, debugfs_ul_set, "%llu\=
n");
>
>  static void debugfs_create_ul(const char *name, umode_t mode,
>                               struct dentry *parent, unsigned long *value=
)

Could you just remove this fops_ul stuff and use debugfs_create_ulong() ins=
tead?
