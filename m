Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D4D3943F2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 16:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235732AbhE1ORy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 10:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234663AbhE1ORv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 10:17:51 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F6BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 07:16:15 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id p184so5686219yba.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 07:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=564lIXJmUSRyPqFJlY/VG6GLWxzT7sFnElx9pZNWZ0Y=;
        b=kZjxD/XLUKAJRsFR10qsGWga9yCHiM4caQusEIzywLJTQitKx8CFvgxazYA1OLoNpg
         oIaYOM6TTkwQM6Cy2d/QLqr3U/4ITdRqLUFLcwI+TlHNcHAjcpL2fZIz4bOlZt8Qie8n
         BkzfIVvkdvRrQBA4/0NqtpreoZPyhu7tiIOtnIggj7SqB7GH2WixMVX6HRTN3Q+1ETpD
         c7aTzgqqXJpPtE1p1ip11rFy8ea7iVe8oMKEB3Ev6jY2FMtlM3D4zjoZREUXsfLRBtzE
         bt8dRM12FUnBrJcJ4IhH+/pLMd5nMHUB60072JduXiOcOh61hrzOIj47vXamyCw+OmNL
         g3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=564lIXJmUSRyPqFJlY/VG6GLWxzT7sFnElx9pZNWZ0Y=;
        b=kV8e7SwQgvMX3rEBQ9BYaKR1ac8Fj00q52r/Yfqz8dWMpohyJ8i3qFjWN9x5wcv2uf
         /h+TxRr6q+xjXosMojnWxmnI36aUv1BGEW6IiNa6i4bJ+teB2+eHpSGukwPsH0UncgF6
         P+TuKrvzh+Ue/xf0fc2hhWYLKenXj2FfFHf8DooqCb6szbe7POfeprXMJB4obThDij+V
         LhGtc7KfXI3zMH99gjNhlHZYBMKrvoVVff7e67vF3KgjdIlMmEks0UdkTaiPaxZWhLDt
         ntiTxbvv42TwnpcjdEHl+YNTx27MYPfSsHXwAWJ43KZyMHYw4ZwfZ7RkXcvmEPQW5Jd3
         r7cA==
X-Gm-Message-State: AOAM531qG5UKUx1n7ud8CfBofgkntHQIEX05N4bORL97O6v/8A8DN8aF
        WLe0tXmdJRAkG8Zwgdbe0sPXFIEHBaaLBVCHXAqszQ==
X-Google-Smtp-Source: ABdhPJyRxTidvS3VVFRjXDKd6um96n906eUKfbj5uB0G7ztaJaiaUTpOwq09iDR67FWrBoMTISAeLrycHfkgDWcqyZY=
X-Received: by 2002:a25:8804:: with SMTP id c4mr12800276ybl.469.1622211374439;
 Fri, 28 May 2021 07:16:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210525183518.63149-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210525183518.63149-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 28 May 2021 16:16:03 +0200
Message-ID: <CAMpxmJWgNFFvUnanQXgffcp_+JXb2OGFH=vjK7H9nB+qOGfxFA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] gpiolib: Split fastpath array to two
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 8:35 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Split fastpath array to two, i.e. for mask and for bits.
> At the same time declare them as bitmaps.
>
> This makes code better to read and gives a clue about use of
> bitmap API.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Applied, thanks!

Bart
