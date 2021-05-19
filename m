Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605B53899C7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 01:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhESX0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 19:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhESX0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 19:26:51 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8D8C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 16:25:30 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id r5so21582807lfr.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 16:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JOC+TuBth9w4PDR0X1gC/Y5yacNS7n2tu/wA6Y4LAyE=;
        b=gEJaptQMvmmzyyPVo9np874c6Ut3HKzbso8Hd7ebIJmZmIPcLy8il2FLXdJOeU4xjH
         RJL5H3b1cAQOiR1HkLt+6Vl2DWZIZG8Od6ZcRF9q7bfjeY88GjkAGes4dFwkUzKGj2/E
         DRDxGMtkjOpFNiqJ8EAbVoO4KmquuSYn/dtar5BI+dDmLvLLbjvYecKUFm+LHxCQooIu
         iSFFeE5V6cr4A1kPyfhFXNvVrZbVM/gOsuEwsJzS0Ta8/1Tn7Q4MvqQLudHwMRFrrA+8
         stg37UiiC0IdrSc0cFItCaPBor1JsOph4J7aPql4jWl+vS4eDDMXEVbGsnQMbSg/0fMa
         nyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JOC+TuBth9w4PDR0X1gC/Y5yacNS7n2tu/wA6Y4LAyE=;
        b=JAkFGiLJ0/YSozF+GH/WW81iF9L18ip8DjK0DiacW2GFX3vW98DjUem/jaUQZcRzpz
         grmdWSI8ihgeH+wq0ikhIQ9LiNw8n+f11B5SridT+dIHBbKkjfcPbUvBXShtGemoQ4IT
         RrjINFGNexb1SXtOPAnHwaAkb3tN9kdbQL6VitPiGghBQqyXOwamqxepqZ7EakWpN4Bx
         tJ/jKBb4fbseUd7ldqZjaCHpO5EGhibyhNXN7nIKceEdlybyJ4fY01yh/7+GBOQMs2I5
         8kDDaySSuiQZLO5th0RrFNODMUfIrhkhI5fBmTGREX84mZEB2tw614pimPFMY79yquAd
         4J+g==
X-Gm-Message-State: AOAM532Zal+axt3b/lE8WHAJO/CKd3qAsuLC1L4EyJdC1+NOyN2CieFO
        VuhuzMvAdnCInxbmJzA2UVmyikK5gWQjU2CMHVK5Zg==
X-Google-Smtp-Source: ABdhPJxSZzSl8GbCOMFZa4erajxVeOrLHp6RcOrW9VCVWDmrJXWFQFqch3CUpInV60lDeRyOE95Q6iR1SG77zCBtpgI=
X-Received: by 2002:a19:ef10:: with SMTP id n16mr1020477lfh.649.1621466728564;
 Wed, 19 May 2021 16:25:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210510114107.43006-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210510114107.43006-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 May 2021 01:25:17 +0200
Message-ID: <CACRpkdb30HKOobtP++PqWc7UwM8qV4JC=UPAmUjUgFN_JANa+g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ARM: Drop ARCH_NR_GPIOS definition
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 1:40 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The conditional by the generic header is the same,
> hence drop unnecessary duplication.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I think this should go into Russell's patch tracker for convenience,
if you're not familiar with it I can sign it off and put it in there,
just tell me.

Yours,
Linus Walleij
