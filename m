Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5682E394278
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 14:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236560AbhE1MYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 08:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbhE1MYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 08:24:32 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09791C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 05:22:58 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id w33so5028457lfu.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 05:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s5GJu063Gw5ZbFrtD3YsVKTbBF15tEOnNiGylTuWMmw=;
        b=hiFcuBg+jA7/zqZxsAY8bv+zDTwqxW10vRmnkNm7MWP3K+pA4kPUVm9A+1kxts4GZy
         KTR+hzo44By4YtgzME54Mz0tOr1lr/eNnWonLzY3sRJ7vKJgVJ4x6LsYN9oI48UaymeW
         r09y6UEXvZZwAvYi3UvYBIpfv5/zpnvE3HyQ5ImozU1oDn3aSI8pXIZqYQtnf0KQxKIY
         /1OepQz9LbjnLzT2MA+BnRUjYV2ay+MUtCxbzq4SKL35MVQOBrWDZ7vOUX1GRO00t/Cx
         e+GNC84mPmDjDsKOxhkqq7XsGidJkqJr9y2towtQLkMksyFR9ZjZG0qrckfPTbgEY5Wb
         qiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s5GJu063Gw5ZbFrtD3YsVKTbBF15tEOnNiGylTuWMmw=;
        b=VDxA82A1KcIyr0l3DhneqmmvXiiM7RGAic9hhDy5QApaUH2/QVI1uh48cLHPlR2RVW
         tz3bOfkhG2m1D3YFlETb3Hakk8oxt+t7nMswu/e3r12kgh8c3sqayE9aj4vGEP0GnJWg
         Dji+EaYrSYmeH5uHIhjm/EkTvulDeu49q5a1LhlX896RQyW1BsHJdUZrmDz4SSc6pLWb
         nO8ZlDqgIjvRzM1M0Ab2sAHGUEEf5iuyESw9Ogr96QtkOy7LqxSEMLbb/xhpeG6Z/5N0
         8444eEicR3FE3TUlK+YKBgJHA4nTM1loo3Ro1DOcZdGeuPqOu194tAVDlC+JrGp/wZm6
         hctg==
X-Gm-Message-State: AOAM530m82IvDZWuknwaRmMYjmkSN6vJsqj/cxVa19OHlxCGrceRAMo+
        MPOkE0x1QuzbzBh/0ZqFj/ReJPLfJYSEoQZCBAcBBQ==
X-Google-Smtp-Source: ABdhPJwr4HGMRaigMytFUC7yINpbDEU0FYhukRaY+t8k5aTb95ijDVaPyFBzWrwqlX0GqNMmY0QT7/i9fyxzncN34zQ=
X-Received: by 2002:a05:6512:1185:: with SMTP id g5mr5752902lfr.586.1622204576386;
 Fri, 28 May 2021 05:22:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210518120633.GW12395@shell.armlinux.org.uk> <E1lmZT1-0005Te-4i@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1lmZT1-0005Te-4i@rmk-PC.armlinux.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 May 2021 14:22:45 +0200
Message-ID: <CACRpkda305YyYRn468UZ6fy3CrLuha5jOndnX_yPCxO037PEMw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] ARM: change vmalloc_start to vmalloc_size
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     Yanfei Xu <yanfei.xu@windriver.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hailong liu <carver4lio@163.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 12:11 PM Russell King (Oracle)
<rmk+kernel@armlinux.org.uk> wrote:

> Rather than storing the start of vmalloc space, store the size, and
> move the calculation into adjust_lowmem_limit(). We now have one single
> place where this calculation takes place.
>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
