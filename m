Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49BB6312424
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 12:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbhBGLzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 06:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhBGLxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 06:53:30 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275E2C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 03:52:50 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id b8so6326592plh.12
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 03:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uNyJEfDz16WKIACFVHlMnAoxrAyz+sqlq3JnbRbPx/Y=;
        b=lV7gCRCZwo14NUzIu76/d7CVDdGnIBPl4ogjAPYb1pVjLRI7b7ZBM+DTVLNGITXSET
         VSkrFsBo7Z6obBcl4OH412UOwKOLMEfhsV8iUzrFsH32eMUzFiSKpYShy6ANKCV8GsWP
         1kR0B5VpZ/s4+8akjhP1PWrCGeWRKLSdPGJLlZ20r5ypS5CPUkiJvDMSc5k3ww6qm13l
         7Po9B7ZGdCyGULWhJuh/gFW9qhknvNNQFViUcXjsSfLB8tbxSWBo1bYDqCi/jiOfx1xF
         xPrO8duDjVU1tkGpg1/y4bhXeiuX7HB15E/P6/jlYK48+uOt74gA+idJTMW6PIKFRiHf
         kVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uNyJEfDz16WKIACFVHlMnAoxrAyz+sqlq3JnbRbPx/Y=;
        b=S8aW0z22DdKkxdxzurCzvIVr/jUiDaU1B2QzBqopObrk/yj0kwVd3+PEmcHScQ03G5
         VEqk4l5AVaoJx4xXh1ieWaqNIgkndV2Hgdwr8pyXxEnHC6t6ql2kKu75LIcWG8BQH1OH
         XJ2hTo9URTfKmZ9RyYeA5UC0LHZfpiM67r+5W7rmoH2X/bq3cmb3E9lSXVfyYIrP01qV
         xUudqhqXCCFvtIG09N7eQ8JqkiFfgeMnK+C4b8s8H1+S81bZPt/fIlJLVQZ4FumVXHSy
         fcdd5xbo9wKxnleIY+LZoRFA5PC8b5jN/hNsOWhH+OpwkdY2Vstej6byD5isrF2xWVj7
         0iBg==
X-Gm-Message-State: AOAM530Al1hlxrgZ3RnFX8oyTCuB3ErHbkbpywZvPEL7pCqzXoE6/tMK
        Eo1/uMpy2IUo0YTqcddYQuF877O/JOHWknxKXe0=
X-Google-Smtp-Source: ABdhPJw+8t83MNSnQ7A5j1CF5ag78qNYMGki+wuXmzG0NbPFGAWrNlQqPObwCk0Sf83HzEsSToJOUxscRey8rVUcTsY=
X-Received: by 2002:a17:90a:644a:: with SMTP id y10mr12832198pjm.129.1612698769566;
 Sun, 07 Feb 2021 03:52:49 -0800 (PST)
MIME-Version: 1.0
References: <20210207043200.2386-1-dong.menglong@zte.com.cn>
In-Reply-To: <20210207043200.2386-1-dong.menglong@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 7 Feb 2021 13:52:33 +0200
Message-ID: <CAHp75VeecgGMtJr5jfx=1D+RNOHgYx34ZMrY+GMpCAayjJ7Lmg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] net: socket: use BIT() for MSG_*
To:     menglong8.dong@gmail.com
Cc:     Jens Axboe <axboe@kernel.dk>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        dong.menglong@zte.com.cn, Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 7, 2021 at 6:32 AM <menglong8.dong@gmail.com> wrote:
>
> From: Menglong Dong <dong.menglong@zte.com.cn>
>
> The bit mask for MSG_* seems a little confused here. Replace it
> with BIT() to make it clear to understand.

Now it's confusing which version maintainer should take (you forgot,
it seems twice, to bump the patch version and mention the changes in
the changelog).

> Changes since v1:
> - use BIT() instead of BIT_MASK()

Moreover, this should go...

>
> Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
> ---

...after this line.

Please, send now a v3 properly.

-- 
With Best Regards,
Andy Shevchenko
