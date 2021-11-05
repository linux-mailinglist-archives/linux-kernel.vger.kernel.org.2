Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F48F446A12
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 21:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbhKEUub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 16:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbhKEUu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 16:50:29 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818F2C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 13:47:49 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id x27so21136730lfu.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 13:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OzIUMIfi4RPXj+onsD2EV5D7RTPP5SubsnRhKU4PVU0=;
        b=STcanu/5UsqXYQCqH+MMlwnQs3HYtefRvaVpdBadT4nknJx7xsOWcuWJFSNqH8EGcc
         TdVh2U9BG0Ll8NqyhIpXa0bN5nKoC87pay5tODOXNsMRNr0+IAHXgi/TUmPGeXabbWhP
         3+W8acnoow1uISKEeiZY5onD9DQjC9h+hXYXVghf1fjciY0IGQOfm6jMRGtZoVz1yu6Y
         L66uVvPlhxO7g8ZOu5c/gQpvqJqjFxaOKvKl8fq51HYnF6uUxqtiYwl48HXw4GxD2nb3
         IHjr6/nVPUUamL9GA8ojWKkwzsmX8F5+tQaSQbZsmisDmmu8wUMRL82zKCy74IC2jYCj
         oeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OzIUMIfi4RPXj+onsD2EV5D7RTPP5SubsnRhKU4PVU0=;
        b=hszJCJ8Q4NDs2tmQ4kppRHwS2qCtHBml7tYEien44wlXHhsyIA39FngP8nEbnKZcns
         6XsqsaCQ9q1ZvTDiVlzhK7Dfoy1eEXiFyJbA6z7nFv48Ytr0bnGniP2bzCdjnnn7RosH
         eikPPSOeFomeI0NVTb/a3IMsp5Glp4Dgl5HJw2+4okgCDAyIbP1WlWbdb1YYKhLx5cYO
         sAPF0Ua3dA4rHFRXoOWo+wmYVBQ22PLFNRzuHa/ZV57oXEWmCULAcnK3+QCCaqiAxa+/
         Oc8f85Cbaz7s5RpV6r1VufnI5igP2Qitz5pSgGqcUTfssZGf2kbd8lgWC1q+HmadMgN3
         otuA==
X-Gm-Message-State: AOAM531dYoCfMrq9Zz1SIjbtKrnGOMY/QNzZCj793g2M6IKmgILGEa8F
        7HF2vkarUJTjUuxJ1p86PmTopHfJx1LgKzso+Pufig==
X-Google-Smtp-Source: ABdhPJx6deQDCMojiHegS2mr4kysTeQUwWlnsyXo3BZVwZZ0CbYgJnSE8SDB61e07DBsybj27PrjCyFSpnlV/xbuQeU=
X-Received: by 2002:a05:6512:228a:: with SMTP id f10mr56001997lfu.489.1636145267629;
 Fri, 05 Nov 2021 13:47:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211105164511.3360473-1-anders.roxell@linaro.org>
In-Reply-To: <20211105164511.3360473-1-anders.roxell@linaro.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 5 Nov 2021 13:47:35 -0700
Message-ID: <CAKwvOdmj07NhhrLUqavJGHBgsBRrg6BvCFCzKbzt4wQJUv+M9A@mail.gmail.com>
Subject: Re: [PATCH] selftests: net: tls: remove unused variable and code
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     davem@davemloft.net, kuba@kernel.org, shuah@kernel.org,
        nathan@kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 5, 2021 at 9:45 AM Anders Roxell <anders.roxell@linaro.org> wrote:
>
> When building selftests/net with clang, the compiler warn about the
> function abs() see below:
>
> tls.c:657:15: warning: variable 'len_compared' set but not used [-Wunused-but-set-variable]
>         unsigned int len_compared = 0;
>                      ^
>
> Rework to remove the unused variable and the for-loop where the variable
> 'len_compared' was assinged.
>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Thanks for the patch. Hard to say what the original intent was here.

Fixes: 7f657d5bf507 ("selftests: tls: add selftests for TLS sockets")
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  tools/testing/selftests/net/tls.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
> index d3047e251fe9..e61fc4c32ba2 100644
> --- a/tools/testing/selftests/net/tls.c
> +++ b/tools/testing/selftests/net/tls.c
> @@ -654,7 +654,6 @@ TEST_F(tls, recvmsg_single_max)
>  TEST_F(tls, recvmsg_multiple)
>  {
>         unsigned int msg_iovlen = 1024;
> -       unsigned int len_compared = 0;
>         struct iovec vec[1024];
>         char *iov_base[1024];
>         unsigned int iov_len = 16;
> @@ -675,8 +674,6 @@ TEST_F(tls, recvmsg_multiple)
>         hdr.msg_iovlen = msg_iovlen;
>         hdr.msg_iov = vec;
>         EXPECT_NE(recvmsg(self->cfd, &hdr, 0), -1);
> -       for (i = 0; i < msg_iovlen; i++)
> -               len_compared += iov_len;
>
>         for (i = 0; i < msg_iovlen; i++)
>                 free(iov_base[i]);
> --
> 2.33.0
>


-- 
Thanks,
~Nick Desaulniers
