Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD86941A31A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 00:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237988AbhI0Wex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 18:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237962AbhI0Wew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 18:34:52 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AFFC061765
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 15:33:13 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id y28so83611325lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 15:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J5B5aRrfRKxmEaCw/eYdgCvEsvYkoIwQ0WLhniYNwbI=;
        b=kYygzng7VhqaJXdTP6kzR7OPAzr15D5nDlu3AwMx396lbeNKRIYI1t7OdplEWJTOBM
         crw4TmSJXzGUQAhdSJkllt8wej/7iJUbFs6i9QWR/c60LzxciZUjf28l8lTKxjYoqeVs
         DoU0qpB+2RFpCyuEaqsR1aEw9ts8yaMh1jmCTnqhOGzqgn6sXcMoR6TNLTjhb6CDRnuy
         9bitaSBcArarBDG1HzPuexoRxS9Jzjm3Tj8KK4nva9LOhq2wlwQwWzAZQM9QZIJc+Mtz
         LueUcHpgYHGtjmFL0t2+os01rx9GvigUAZB1vTOaszMLtJvjPmj/X3GL42W41Yp2hiLR
         UB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J5B5aRrfRKxmEaCw/eYdgCvEsvYkoIwQ0WLhniYNwbI=;
        b=xzxzjcTFfQzijRS02d5j9omDQm6tt/Wn4/yZ2HTYNSLXDUMcQOW0s/NKWZMw+ihqVL
         Ib/qXMycxPWeQaYeLg4ORDgF1amjg5ypJt2nG8VnzSBaSDwgEhoWXyTiBkimAqZFOCVv
         CVHWTkyLXaJ7AhKgnSl/qfBZolFqrwgulhoPVt2v3js4D9ZC3r/KjfYOQcfkJiQKtCwN
         sSHhKnduZ3CFjOLdDgPEIkeHE8x2YsyzNXUSKloAJgZJfyLUa8eFliNSuPziPxlBV0vT
         JkJKb4FlpyRosbsgFA12NV5MMgK1umK+t75MHMuucPmqoioWErb87Y8EKVZxIZglnWYP
         3rdw==
X-Gm-Message-State: AOAM532r7vbzEo25lvA8ulTC7BZXgXnZTKyNmtNn0V/C/RABOu+mxDT9
        1s1oHU6pZd67Dj0uXp07if+uztIg546ZkNrnc+0l5w==
X-Google-Smtp-Source: ABdhPJznzEIvFTY3UXzATF0un+whaXvXmw3gl+DlOYKWnactBuyqALPfu5jWI1cyGk26hMDaFqSyAwpGIHNXJFl5U2I=
X-Received: by 2002:a2e:85c2:: with SMTP id h2mr2393248ljj.367.1632781991920;
 Mon, 27 Sep 2021 15:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210927094520.696665-1-arnd@kernel.org>
In-Reply-To: <20210927094520.696665-1-arnd@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 Sep 2021 00:32:36 +0200
Message-ID: <CAPDyKFqFwv7gV2dOEMK8A_Cwpfyh6tzzO8DC3n7Hak2-=o3GSw@mail.gmail.com>
Subject: Re: [PATCH] memstick: avoid out-of-range warning
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sept 2021 at 11:45, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> clang-14 complains about a sanity check that always passes when the
> page size is 64KB or larger:
>
> drivers/memstick/core/ms_block.c:1739:21: error: result of comparison of constant 65536 with expression of type 'unsigned short' is always false [-Werror,-Wtautological-constant-out-of-range-compare]
>         if (msb->page_size > PAGE_SIZE) {
>             ~~~~~~~~~~~~~~ ^ ~~~~~~~~~
>
> This is fine, it will still work on all architectures, so just shut
> up that warning with a cast.
>
> Fixes: 0ab30494bc4f ("memstick: add support for legacy memorysticks")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/core/ms_block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
> index acf36676e388..487e4cc2951e 100644
> --- a/drivers/memstick/core/ms_block.c
> +++ b/drivers/memstick/core/ms_block.c
> @@ -1736,7 +1736,7 @@ static int msb_init_card(struct memstick_dev *card)
>         msb->pages_in_block = boot_block->attr.block_size * 2;
>         msb->block_size = msb->page_size * msb->pages_in_block;
>
> -       if (msb->page_size > PAGE_SIZE) {
> +       if ((size_t)msb->page_size > PAGE_SIZE) {
>                 /* this isn't supported by linux at all, anyway*/
>                 dbg("device page %d size isn't supported", msb->page_size);
>                 return -EINVAL;
> --
> 2.29.2
>
