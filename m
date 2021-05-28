Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A241D393A5F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 02:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbhE1AnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 20:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235121AbhE1AnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 20:43:15 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D83C061760
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 17:41:37 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 131so3159523ljj.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 17:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ral1/cr5tv0Oi6I2LPNfpBXJdYcfSjlB+JCdbq1/BvM=;
        b=yWDoJYcnTkqPm338XA0ly9EDskdwONFyzNUmi63eeGqTBpE09p5kfC4IBE17TT7Mie
         sJIcMUB+zwnSl/S0g84u6m5Mfv7j4pGXRWlcLLFnl4CILFIzMNZCoNLM7ToOaWgRk5gr
         jEegtlYnrF4fsO4ZzLzIOFEEGQ1U+2JlR2xwdJylNWG4wHjlJDNMVPZCBWhSCE+rV+q0
         MEvcsLwUWD2a5f0lhZeyG91E1XJAtdgfCCrz6mZM4Y90J9lviKu/z+M5ld8Wj7PWlQOH
         38RClyGdftFRKwraOru1q8Q6iEm/3vOlH5mLIaT7Apl3gzG1iSa/1dW/HXLzZWv85KfT
         pHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ral1/cr5tv0Oi6I2LPNfpBXJdYcfSjlB+JCdbq1/BvM=;
        b=oy+cVL6CUflh/sYbZkEIsd+Jah3gB12j2r8mRRAI9JIYEQLe5FSdL8z7A9hwp6KC3+
         g3ipgBoUtW1u0fJ+bGVfZngL2aY8yhw1b/tcaqeJ9ieBsSiMum/nSQ/816Hsh9X0NXMn
         4IZTCtp/+vkx/rtl04m+EOS6Wp+2g1Xd97nkxRQO1NrF+gr5WT6Z2mHL2T2rcNW/N3Ls
         QRPDF5fBsiZ2jVPgS7z7XdzzjxzP231iBmNrRCm5WLvmNiAFBYpFucmrNmw1a4X8mUDm
         PJ96sC8nXxKsZAHPgRYBNHX0W2OmLrbDc8rZaNO8TcqwRlb4BqqdDto2Uw3+md5M8h2f
         frag==
X-Gm-Message-State: AOAM532+D4pfldhGdFBVoWPp1rkoUru7/hEObLzvnLV7yyrUvmI+NFhE
        aVPFUqgcajWAmkUk2W4dTf5AmV/I/21UnfxrZ+YEan9xgKE=
X-Google-Smtp-Source: ABdhPJyyUna/R7wkRXzZvYboqcK5WjDInXT8ALb2Ce7Kmy5x9ZSbXIZKM9P9N8ohFRMpMqTZqRXLFrTf9IJaXBjVWaY=
X-Received: by 2002:a2e:889a:: with SMTP id k26mr4475795lji.438.1622162495862;
 Thu, 27 May 2021 17:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210525183518.63149-1-andriy.shevchenko@linux.intel.com> <20210525183518.63149-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210525183518.63149-2-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 May 2021 02:41:24 +0200
Message-ID: <CACRpkdbZ+ndoDe_aPAUSiMX_CS-LsO7K-oLGEmQ_9Dy0NTeyDA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] gpiolib: Switch to bitmap_alloc()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 8:35 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Switch to bitmap_alloc() to show clearly what we are allocating.
> Besides that it returns pointer of bitmap type instead of opaque void *.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
