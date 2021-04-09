Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31AF35929C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 05:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbhDIDJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 23:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbhDIDJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 23:09:35 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11327C061762
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 20:09:22 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id x189so5036265ybg.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 20:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/M21Bb7EyIl+WCrdhSVxYqoq6s45ILC0K1RB1Zcz7wM=;
        b=jkqtEUOVOZxaQt7kdNkYOXI7MEFdaBx/urZfJk1w68gkozx1A1u/ZJwhWyAsX5vxSS
         Cf65vHhc+dxim4Lf4wh0jVjC2gUZzVeKl1U+VU05/gu7NUksi/pMTOj1Hfu5RyYMO+fH
         /e49b0z2HqFGk70DkUgR6NtJSj7boG46EmwYd/nst92hUXtzdnbo8qINlMlX+2w+Tun6
         fobYDgJ6sFEL8NRgNsDvdCPoWpvkkENkRyAzDAcilZkdhxmxA6/R5riWb2XMoPZWfnX7
         JgK/hjVc/Tp0OAaiJqu0iwsKiYr6qgSeXpYVH7roAu06xBCZhCsr4csrXOV92DQmEu8u
         HcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/M21Bb7EyIl+WCrdhSVxYqoq6s45ILC0K1RB1Zcz7wM=;
        b=oDIWd+jRz1aAqBE5ZsUtkzXhvS6fZVgWzRHiWIEt7IXdH7Rau1CtzXsNewvQ1qZw9z
         Hmrs72dC9OpqfFd7Tx/z6WdTj+/DqlOsNwEEgCtPARqZunWECFqWG1KihJPbZw7gAt3c
         qLpOR2PJSpeH6qmKNKoyYbVSB492B2euxHexdwekHG3mtU3lZ0caBtjMRdjJWglc9Mbg
         NIfp012OReipGFs8lQWKtxiuHcyXJyRL9nbvXSTRjb5LI5AaaNKf8fsFTqRzSaCWelNF
         XCN92ABNl0wzDyjqxW2lCOHzzQOEfSkNNrVobha9p3rcIMiH1p4Wycb8BVD38xK5bvWA
         QGyg==
X-Gm-Message-State: AOAM530TkWpAEWV9NB48chOGkC4qyJoNpdvXtrLa9wTs44nYVgyB7v5/
        1XZDeggflcbLQ8z6ku50+r1Kkp3+SckrWFxU7aM=
X-Google-Smtp-Source: ABdhPJwPNnNWGkP/XX51qPloO3CUKzIc0VGZFqLrRrJEy6c/bjiXHc//I/gh7c5rnsnTlnc56jktdatvVHMSHBYqdXk=
X-Received: by 2002:a25:3cc6:: with SMTP id j189mr14629313yba.247.1617937761066;
 Thu, 08 Apr 2021 20:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210408125429.199592-1-zhaoxuehui1@huawei.com> <CAKwvOd=4ebTNPMOD5K_tUDOY6jx-VT29kUNv=d8ZLxG+1bv6=w@mail.gmail.com>
In-Reply-To: <CAKwvOd=4ebTNPMOD5K_tUDOY6jx-VT29kUNv=d8ZLxG+1bv6=w@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 9 Apr 2021 05:09:10 +0200
Message-ID: <CANiq72k-X2WPfi7B2sNYMUqAEPjZq5yp4R+j5V6gxMx+AiOq_w@mail.gmail.com>
Subject: Re: [PATCH -next] lib: zstd: Make symbol 'HUF_compressWeights_wksp' static
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Zhao Xuehui <zhaoxuehui1@huawei.com>,
        Nick Terrell <terrelln@fb.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, yangjihong1@huawei.com,
        zhangjinhao2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 9, 2021 at 2:20 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> Quite a few other functions are declared in a header, but I don't see
> any existing callers in tree.  I wonder if the maintainer could
> consider cleaning these up so that we don't retain them in binaries
> without dead code elimination enabled, or if there's a need to keep
> this code in line with an external upstream codebase?

Yeah, the equivalent cleanup was done upstream by Nick in 2018 [1],
but there has been no major update to lib/zstd since 2017.

Thus a cleanup would actually make it closer to upstream, which is the
best case scenario :)

    Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

[1] https://github.com/facebook/zstd/commit/f2d6db45cd28457fa08467416e8535985f062859

Cheers,
Miguel
