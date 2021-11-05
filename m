Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B55445DE8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 03:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbhKEC12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 22:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbhKEC11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 22:27:27 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB54EC061203
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 19:24:48 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id u60so3380934ybi.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 19:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qhQ00mQkgKps/BbiSdbnroOgBqYJ/1hR8QXi9VVQFSw=;
        b=NFA2QJ6aZI8sYbtJecTC0hkvKzoBbuFW94j+Xg/jUMf5Hd4wXm6DojN+SdCwW6E1Cx
         yZ1Nf6msME+LnM4zNtKMw8BtMa0QITYIuPxk6k6qGpqVFjuPCZ4SleYY3ujEqxIs9FFr
         /+lwXnmTVr72sSc2il0M53Phc0ide/ZzftuiYkBDHPRd/OKUpQZjbD6ezOeDci3vOJjA
         UzNL7+E5iAfUwYk6HYyh4T5h9b6KImHXVk2ize18YOAkmF3+sFkVSbe0OLo1TFB299nj
         nAIm2azHfRhukh+/vB2bfgHgeny+LnCBLW7dT5m2SBLjlqrQhZP8lubKusamwFCX5N/R
         Akqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qhQ00mQkgKps/BbiSdbnroOgBqYJ/1hR8QXi9VVQFSw=;
        b=tnY7+/OK3j3CEXuRTC8VHFt/hDvyAwAje8jzI8uGejXDYu4sYCUDU+0hVD3Qw8I91r
         USlcECN0EJ3eY9y9UP2ZSjds0x/Vyi30rW9dkABE2va51oewSEQTc2OB6kEamTTWh8wl
         mT6a06oBMtRWZb9ZSZpPNtsRUTTd6DoL8PwpNFoGF8ZKu0fXf28/vxBWhhnpLGURmg3i
         RJ5bp4SwMtNxTT/PfNZwIQ58BtuyMqMctFbghYKaj+evJaIpUidd5jIZccRk91JOFGUD
         s2rgCQRC1YJgiwpUadZV/Cn4yCknwBRF4TbjnOs0JpONK/2z4e5IDQA3V9Bav6XoDes4
         7slA==
X-Gm-Message-State: AOAM531kvX39PL9f8a+CUmhFnfynpMrQEueYIPUkigT+zz6WTlqNijzE
        +tFKSgTDOA05eY7PcXlFwn5TuJ1ywMlrEJivD5Z9Mw==
X-Google-Smtp-Source: ABdhPJzF/eDQ1Ip0lTuv8CEdpv7jUAKIPRBImfFTnXzlYc7oDNsCucZdgzKgPF4gDVIN/yJF9Kkcz6o4Tf/nWER2AW8=
X-Received: by 2002:a25:50d2:: with SMTP id e201mr56274417ybb.296.1636079087456;
 Thu, 04 Nov 2021 19:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211105014953.972946-1-dima@arista.com> <20211105014953.972946-3-dima@arista.com>
In-Reply-To: <20211105014953.972946-3-dima@arista.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 4 Nov 2021 19:24:34 -0700
Message-ID: <CANn89iKMMxA5evhVO2EjV512fQdZ1Y5_nBZTe1Che1p=NbDvbQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] tcp/md5: Don't leak ahash in OOM
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Francesco Ruggeri <fruggeri@arista.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Leonard Crestez <cdleonard@gmail.com>,
        linux-crypto@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 4, 2021 at 6:50 PM Dmitry Safonov <dima@arista.com> wrote:
>
> In quite unlikely scenario when __tcp_alloc_md5sig_pool() succeeded in
> crypto_alloc_ahash(), but later failed to allocate per-cpu request or
> scratch area ahash will be leaked.
> In theory it can happen multiple times in OOM condition for every
> setsockopt(TCP_MD5SIG{,_EXT}).

Then store it in a global, like the other parts ?

This makes the patch smaller, and hopefully the allocations will
eventually succeed,
one at a time.

Bug fixes should target net tree, with a Fixes: tag, not buried in
apatch series targeting net-next (which is closed btw)

Thanks.

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b461ae573afc82a2c37321b13c2d76f61cd13b53..e2353e35693935fb5abd7da4531c98b86fd35e1c
100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4260,13 +4260,14 @@ static bool tcp_md5sig_pool_populated = false;

 static void __tcp_alloc_md5sig_pool(void)
 {
-       struct crypto_ahash *hash;
+       static struct crypto_ahash *hash;
        int cpu;

-       hash = crypto_alloc_ahash("md5", 0, CRYPTO_ALG_ASYNC);
-       if (IS_ERR(hash))
-               return;
-
+       if (IS_ERR_OR_NULL(hash)) {
+               hash = crypto_alloc_ahash("md5", 0, CRYPTO_ALG_ASYNC);
+               if (IS_ERR(hash))
+                       return;
+       }
        for_each_possible_cpu(cpu) {
                void *scratch = per_cpu(tcp_md5sig_pool, cpu).scratch;
                struct ahash_request *req;
