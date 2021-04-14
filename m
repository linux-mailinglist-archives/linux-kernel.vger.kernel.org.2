Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940F535FD76
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 23:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhDNV4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 17:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhDNV4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 17:56:06 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FA5C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 14:55:42 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 12so35580167lfq.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 14:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B4PaWns9RJ50yLEbIsVE4NO8Jz9HTGhoiTqPXXKZY0o=;
        b=s1wyX63Xge5OaK2bvQYCPwYwTo8RW1Ss67gsTC4iCTzZoahL7laxohuv/MPLIUzFoj
         ROAq7rAsGUJOA652YpszDiLcIHiw/bsF8Kf104koIMVxrs7IjfC2ZMLFvWqo/K2PjrBv
         h1TVj+FK5oxtvzbQ7S1AJgKqzqCudfvIdDXy1QN+hrDEZlChwUSuxEj2IEbP0x7z+qv6
         OeqQUR+rWppCmnEJ551i0JpWrikmiqQ7ruYF4Ze1kETfUI/jXkJl805i5UQrnF4YiPjq
         Ij8EDur12AMreoEbspDDbQikoLxbNDoqI3ehMI1TtNuIBWQm6HZCP3W0DV0IHf6fdmKW
         GK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B4PaWns9RJ50yLEbIsVE4NO8Jz9HTGhoiTqPXXKZY0o=;
        b=NS2vGUsp3JrZmUoTfex/LBdp4pUxtHMHJhhsMLiHYUpk09jdaZ9hwiesv67CPjxOVy
         jMlFamuUu7lCFAfXV6/aZi7t/PkM/X0eMRuyu6KJHYAXZnDlAYWdkGUIyO7BR/uRQS0t
         sJXEJT5UD8+ugIugnoBDZV/WUE1fsd1+ekSSWOZjngVwJsK8d//2OtDWkXyp7QNc9WWl
         SiE+huUeeQoQfwhOJ7tvi/zY/JSVzOHrWpGtyNetq0LqRGorTwGcpE7AnwRhRX7HnUNC
         Y4uiTiNZ9WuUP85hbGoVGHe7VdTVDfBf3Y8MTcKVITF8VqUwKFGS2iXpL3VynEw1XgD/
         R8AQ==
X-Gm-Message-State: AOAM532Q9XH2W2xkPNVyw7J59dozivYReOUafJTPvui5gEJ1yxQzBOOH
        yqezLnOj+6pfnWFG+IZXEJLNd8AxFx406a6EfQCQqA==
X-Google-Smtp-Source: ABdhPJybnuynIs4AvePyaUNGDLqr+r0Yz2Iy4PQXStulsEF5z88FI42uo8XdSJXWQ5Lzbs9b7+w3vLEui4bGWt/MeGM=
X-Received: by 2002:a19:a410:: with SMTP id q16mr197991lfc.73.1618437340809;
 Wed, 14 Apr 2021 14:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210414184604.23473-1-ojeda@kernel.org> <20210414184604.23473-12-ojeda@kernel.org>
In-Reply-To: <20210414184604.23473-12-ojeda@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 14 Apr 2021 14:55:29 -0700
Message-ID: <CAKwvOdniKs+cNKS9qHgq3xR6cmJ7xdiVpAzxaQEN372HY6xc7w@mail.gmail.com>
Subject: Re: [PATCH 11/13] MAINTAINERS: Rust
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 11:50 AM <ojeda@kernel.org> wrote:
>
> From: Miguel Ojeda <ojeda@kernel.org>
>
> Miguel, Alex and Wedson will be maintaining the Rust support.
>
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
> Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  MAINTAINERS | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9e876927c60d..de32aaa5cabd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15547,6 +15547,20 @@ L:     linux-rdma@vger.kernel.org
>  S:     Maintained
>  F:     drivers/infiniband/ulp/rtrs/
>
> +RUST
> +M:     Miguel Ojeda <ojeda@kernel.org>
> +M:     Alex Gaynor <alex.gaynor@gmail.com>
> +M:     Wedson Almeida Filho <wedsonaf@google.com>
> +L:     rust-for-linux@vger.kernel.org
> +S:     Maintained

Assuming this will at least be part of Wedson's core responsibilities,
shouldn't this be "Supported."  Per Maintainers:
   87   S: *Status*, one of the following:
   88      Supported: Someone is actually paid to look after this.
   89      Maintained:  Someone actually looks after it.

Either way,
Acked-by: Nick Desaulniers <ndesaulniers@google.com>

> +W:     https://github.com/Rust-for-Linux/linux
> +B:     https://github.com/Rust-for-Linux/linux/issues
> +T:     git https://github.com/Rust-for-Linux/linux.git rust-next
> +F:     rust/
> +F:     samples/rust/
> +F:     Documentation/rust/
> +K:     \b(?i:rust)\b
> +
>  RXRPC SOCKETS (AF_RXRPC)
>  M:     David Howells <dhowells@redhat.com>
>  L:     linux-afs@lists.infradead.org
> --
> 2.17.1
>


-- 
Thanks,
~Nick Desaulniers
