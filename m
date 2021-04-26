Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3FE36B0EB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 11:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbhDZJpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 05:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbhDZJpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 05:45:23 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27717C061756
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 02:44:41 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a12so13600079uak.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 02:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wdc4NGpyhSPI0l8P0rAkrFsxEyB9PvJbldlNpyk6qiw=;
        b=Kl5/ZzkJ9EV2ugj/FBuCtAzsCK5u4BnciggCrSmn2qLVdL2oqJI9IwMYUo1b5kg20q
         4Io75xTCjVechg87eHqaJhvHG5OCXDKz/HXK1tjdQifqLVvdqs7HRWksnM8QPyMQDfOR
         Ew6YQLqhhC85vvhhfIU4qsm2LWg4OX66KhmIfUkH5bmdnLWD1dZ5f5/Ru9XLKIZFT3Ty
         W7dSqpkR6DQFfQYhCfHTf4d151c9gE25JH6t22vV+vsvwXggW//4IjaDX4hclxtlCKTt
         RPxwheSetgvl78CPkQ/51GHkU7x7zyscULwvJN86MJIdbGk3BIF/hgO91vOoMWBo4NIW
         4ZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wdc4NGpyhSPI0l8P0rAkrFsxEyB9PvJbldlNpyk6qiw=;
        b=OxjrS5sbS0xf4q38rXrTcS7YP601y2vb5+/KhgLXf7GOERRJahjuWSvwdO12TmAdmG
         Dyl4KQKS2BuH/XX8mMSiGq2kS8Xm4JcjBQnQyySSuD+QrnIqnNcYkr4StoylKfA9jog0
         DHwufUdBS3OUBrxa1zJBxa8USrZOQEUj6Ju4kZphvdRT1iWWg/8W9vs30YkElqayIPKE
         yvqZ8nEepcGOBWLdGvI+jptjT0zMFhrtPSgA59uJFRdFxkF8pEIVz/L7lyOLFhEFdzbr
         HRR5pAq1n/JqriJkRxfrXFcVdIAVITti0uHUbV5Vf0mUZm18pQCGJjHoxWOP6KhjQpxN
         AK0A==
X-Gm-Message-State: AOAM531250flJxuIsgJiYQKjufZ144qZOBvOvb+toATZU25XHc+5UOHl
        Ho9y6pQYCEDdSA4mrN09qjTboVHAio9QPvL7yQbkBQ==
X-Google-Smtp-Source: ABdhPJxXSAA0ghiUOYW0SZ5vU/6S9+Kwa5/yEDnRiDEqeGQMWO1ZaO1iCxx+cGxz6cjwDs2ixcN1ykwBs+8ZvjhHPx8=
X-Received: by 2002:a9f:37c8:: with SMTP id q66mr11124562uaq.129.1619430279926;
 Mon, 26 Apr 2021 02:44:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210425060207.2591-1-avri.altman@wdc.com>
In-Reply-To: <20210425060207.2591-1-avri.altman@wdc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 26 Apr 2021 11:44:03 +0200
Message-ID: <CAPDyKFpZhk-kDpuA1m-E4RXHMXbG72S=OW07XrLzP0-9Q_Gu9g@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Do not flush cache when it is disabled
To:     Avri Altman <avri.altman@wdc.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Apr 2021 at 08:02, Avri Altman <avri.altman@wdc.com> wrote:
>
> v4 -> v5
>  - patche "Update ext_csd.cache_ctrl if it was written" accepted
>  - Add one more patch: "Add cache_enabled bus ops"
>  - Add Acked-by tag
>  - another rebase
>
> v3 -> v4
>  - Attend Adrian's comments
>  - Add Acked-by tag
>
> v2 -> v3:
>  - rebase onto recent cache changes
>
> v1 -> v2:
>  - Attend Adrian's comments
>
> Cache is a temporary storage space in an eMMC device. Volatile by
> nature, the cache should in typical case reduce the access time compared
> to an access to the main nonvolatile storage.
>
> Avri Altman (2):
>   mmc: Add cache_enabled bus ops
>   mmc: block: Issue flush only if allowed
>
>  drivers/mmc/core/block.c   | 9 +++++++++
>  drivers/mmc/core/core.h    | 7 +++++++
>  drivers/mmc/core/mmc.c     | 7 +++++++
>  drivers/mmc/core/mmc_ops.c | 4 +---
>  4 files changed, 24 insertions(+), 3 deletions(-)
>

Normally, I would appreciate this split of the patches, but since
these are material for stable kernels I decided to squash the patches.

I also took the opportunity of updating the commit message a bit and
did a minor cleanup in the code. Please have a look at my next branch
and yell at me if there is something you don't like.

So, applied for next and by adding a stable tag, thanks!

Kind regards
Uffe
