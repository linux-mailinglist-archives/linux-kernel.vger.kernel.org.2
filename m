Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3D83EBF4E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 03:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbhHNBR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 21:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236141AbhHNBRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 21:17:55 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA413C0617AD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 18:17:27 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id y7so18268772ljp.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 18:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y5gPul7eijlOt8GM4HLCxObdd/V4u2qacMdjonsEqZ0=;
        b=tgcGAsU2GoR85//UtKVxI/9WfKebiunMzpWmqEY05kDZCGgdmO2+r7/fONX6wDxE7k
         4u5AidzGRRhww0AmSAlwvIvgPBeKH9Zld3SF3zxzGsdkhCmAf0Y7A9FHPyv9sDZ1X9+a
         A84KVQ9K8M0WnVKfuW5zkj88UblBELlVWWzzO3cN56OK4DHQrPOKUr5AzTZyKo0YseFF
         VJETA+asdK95vnpVVIbcCNadT3mxz6f/HqVtHGiX/713oB62TxhsTaXGs905sVHhr7zU
         o/21RxGxC7bzy22JU1AgS4fHfyNDA/RAod0B5+ldUOOj0U3d4PHheMxvp6iwP1tD5Jjs
         ZpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y5gPul7eijlOt8GM4HLCxObdd/V4u2qacMdjonsEqZ0=;
        b=WMZTmzCTwpDZhxz6+pKXH4rblkdcc9xaJWQJw1GSq9oa8+tOMqYxwx0fPaSa7zl7Qj
         IJLcGnz5wyYIjITpAlaED5dG77oPEOuxOLUY/lL/jChSUFG/atw2hRMKhSjSprWB6iJW
         LflNXTMgwZDQmoOULnxHdJCrTwGjzHjH4qNTi2gXx9wr4EoDp45BtEr/+w1GZ7SV/Eog
         fv3yIOMSvpiL/aKLSAhubZwDjEl3AVGLiLPlT/5ZKXCneP/fHEIi0jBtTu/XUvCRkGnT
         8r2AgX2kyufc0Ky7ZJ/e7ygGkvrebJfce7NVpd6bgQOXUKI73oQfqVNj57HS6fe7FV0m
         KrKw==
X-Gm-Message-State: AOAM532vfmUgYiABJGBVjpR1mCHEsf7jSbf/a9S7eoUL/BbzL1duWNil
        OO6ijslEq30JGaJy61NJb1RBbRl8ucbMNUCq2jaxFw==
X-Google-Smtp-Source: ABdhPJyF/J366NM95VqqZS9hAU9iXM6whgFfkFn2eFklnzfQd9bzw800+b6wk9fIaLZ+3i6dK2q4RKG6KO/TZoFQQpw=
X-Received: by 2002:a2e:9e04:: with SMTP id e4mr3628772ljk.431.1628903845596;
 Fri, 13 Aug 2021 18:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <a09f381462b1ce9c506a22713b998e21b459f7e9.1628899295.git.brookxu@tencent.com>
In-Reply-To: <a09f381462b1ce9c506a22713b998e21b459f7e9.1628899295.git.brookxu@tencent.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Fri, 13 Aug 2021 18:16:49 -0700
Message-ID: <CAHVum0f7dWrLNuZXPFPit4UQvGkJYZxmneeSm+DHV0ot5k1tBw@mail.gmail.com>
Subject: Re: [PATCH v2] misc_cgroup: use a counter to count the number of failures
To:     brookxu <brookxu.cn@gmail.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021 at 5:15 PM brookxu <brookxu.cn@gmail.com> wrote:
>
> From: Chunguang Xu <brookxu@tencent.com>
>
> For a container, we only print an error log when the resource
> charge fails. There may be some problems here:
>
> 1. If a large number of containers are created and deleted,
>    there will be a lot of error logs.
> 2. According to an error log, we cannot better understand
>    the actual pressure of resources.
>
> Therefore, perhaps we should use a failcnt counter to count
> the number of failures, so that we can easily understand the
> actual pressure of resources and avoid too many error log..
>
> v2: rename failcnt to nr_fails.
>
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> ---
>  include/linux/misc_cgroup.h |  4 ++--
>  kernel/cgroup/misc.c        | 37 ++++++++++++++++++++++++++++++-------
>  2 files changed, 32 insertions(+), 9 deletions(-)
>

Acked-by: Vipin Sharma <vipinsh@google.com>
