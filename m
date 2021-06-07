Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7CA39DDC5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 15:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhFGNiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 09:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbhFGNiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 09:38:50 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19679C061766
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 06:36:43 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id s107so25006377ybi.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 06:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+6FcM8ZV21XjYhgtSkFirusWqSNWC7OG9HFOlE5+6ss=;
        b=G3TTFrNtDQsfKGjbSzlCuN189t0mFMM/EmBQTTEGjH24z3DNXz7rHohzCbl9Jg1WTc
         8jdDq5meBcAfT4v8dJCWLRQGY40qUTMZ9tTosPt6afCfsWw5UhuqTDOfnCO8WJd0TR0Y
         Nmin/bVd1RcOssIws78gQbUixLRKQBK5C0BtJAu16Z4JsPJzzN1WkKhBYDW0vCjq+2dW
         npKssWWEVK2j2lkWlmJiNBwaCu2IwjlBmPQgI/1rHpHKGY3+neDRk/cnfoc3bmezD+lf
         IBEBFQ8zQbDLKqL/NFR2uRjRKnV8o0Jzxanm2ogQkk7e9ar5Uujhbjtsu3AjJrdvLCl0
         9Ncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+6FcM8ZV21XjYhgtSkFirusWqSNWC7OG9HFOlE5+6ss=;
        b=IC14N9PhWEtwi2V7kQXNmwwgKFKxEHAE+u6s0Dt6jiTuNxWeVgxgt18mxrBPkGLTEE
         /1vlgu8lczooRtpB/PveNwQMGjA1AXZ/Fv73RHOxao1azXvylmsktkQkVIOtmCq8Lx+O
         h7IYhwvT9PvzLgXCLkAQLPngjbe01vnyyAxhRtNTz+TnUyMcYL5oiVH0nRYGARx5cbNX
         D/lErBZ1DdHGKt6nxn9JjBOXJY4YTylRkmSmjWpaeF0HLrFR4pV3aw9sGdFC8jn4TtzL
         wkb88rxizSC56ekvzk4vlGqIZydqH8zLlqluWQtUBUF7RxLIG+mYj6d+7JRGm/rFfxfg
         Oftw==
X-Gm-Message-State: AOAM532K4OudTXOLd/Ip4+Z/OfJvbPNnDkQWwED35WpQMjIn1r+kTq4I
        2x2b59aYkb+6KUUt7NV8txdyX+qMdNGUPl+qVsNGbg==
X-Google-Smtp-Source: ABdhPJxdHRseCyNG7D3UoptNNuXKOpoDUfb7dVUGr083kvn6AcERhtQcUNCJiaSiuvBR/fZrEnqKhFsbsOY8Ih7KtFw=
X-Received: by 2002:a25:1804:: with SMTP id 4mr24220428yby.157.1623073002172;
 Mon, 07 Jun 2021 06:36:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210604185013.86662-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210604185013.86662-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 7 Jun 2021 15:36:31 +0200
Message-ID: <CAMpxmJXwe8eRwimUhvuDF-Z7pyiHmeKk2e6ArVVgc9Sp7g+=hQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio-dwapb: Drop unused headers and sort the rest
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 4, 2021 at 8:49 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Drop unused headers and drop the rest.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Applied, thanks!

Bart
