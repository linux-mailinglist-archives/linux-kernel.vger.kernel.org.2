Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E563882C5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 00:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352762AbhERWfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 18:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhERWfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 18:35:47 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9129C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 15:34:28 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id y9so13285947ljn.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 15:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WobygajPzVoEc2U9FQECtgIdsA33j/D+iHmx41pd5Lc=;
        b=PmkDIKxBitC8lS+64wuoFGi01xbX7s76t7Hzq1/ayu9bj5iABIa501gdIGVj1uhMW7
         miiUsb9/SlE52h9p0na+UYIdx2/Ol6UHawRsokuDkuslU/NWJwNVk2swCk1MW15TnJWU
         3qjATmIX6SY9EzWJTQP/nRSQu85gtHSYsKZmUmLlsswT0ZLTBdxA88PjVlfV/cm5KwS/
         vPzfeYrLHm93bfAy/4ArJGWBG753cqE1IS2s+rIN3mLOM4TgcuckG05H4Bu66EAaR0s9
         yL5Rj1LNZN/yPZCipLEXpz2pG9P+fUKAOS9QLEaPLP4Y/a75f/q/7m8EVR0k34cp053X
         Bvdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WobygajPzVoEc2U9FQECtgIdsA33j/D+iHmx41pd5Lc=;
        b=ItgZzxIzr+bSFoMfQZf+AjxFkmPQqUIjOyiQn7FU9nTjopxrcghNZ0ZZeuUkAiSY4b
         84ECm2sgIZi+XMS7hw0gAHE4OVDx0iXJmVH2TkVoSJpqXzVRke7IUzlL/X1u1oI84Qp0
         Fq6YU8a9mPs9V+RXHFNFrEX1RFkUqUOu0TPuBjJ1Cy2TrLBr/SCC1jWbsrwZ2fEieeJd
         TfSh5sbnMZib8SfKHSjRwRZgBGILm0EsclXKhgUoE1kAz+WvTtJqEpU0RzCpof+MNyCH
         D9wuRn2lCyuck7Qc+5SLTskKKqIVnCZ5pbudRfVtR/EPZNmpmxXWaRrBTMSudAYMlnFV
         Xq3g==
X-Gm-Message-State: AOAM5303nYgdLqEqIh8jKmw3PrZX0zNk8DPzg6nmMkXEfHX6IjU4wYdZ
        exEG5Cde7hQUEb3bob9KjAAKrLKcAw64Zo0iWSP6ow==
X-Google-Smtp-Source: ABdhPJyWvvw0cztC/TBw1jd+d5d6/vdYzQuIxHr6JTJjhg7Q8wBF1k8edCtWlZ9qISvYPyeNQ+D+vm70rfG2Db5MSt0=
X-Received: by 2002:a05:651c:4c6:: with SMTP id e6mr5863338lji.326.1621377267357;
 Tue, 18 May 2021 15:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210518120633.GW12395@shell.armlinux.org.uk> <E1liyda-0005B4-Kk@rmk-PC.armlinux.org.uk>
 <CACRpkdbZObW2SXdTUkPrsezjjVU19emts420EN-uhkHWb+4vrA@mail.gmail.com>
 <sons6q6-2630-rr8s-18ns-221454n9472@syhkavp.arg> <8q526rs-853n-5q80-r9pn-87sso759r13@syhkavp.arg>
In-Reply-To: <8q526rs-853n-5q80-r9pn-87sso759r13@syhkavp.arg>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 19 May 2021 00:34:16 +0200
Message-ID: <CACRpkdYkzjAgRGosf5zx6MNzZ9QKa_nAN42iZT0jNPLwJE7Row@mail.gmail.com>
Subject: Re: [PATCH 3/4] ARM: change vmalloc_min to vmalloc_start
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Yanfei Xu <yanfei.xu@windriver.com>,
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

On Wed, May 19, 2021 at 12:32 AM Nicolas Pitre <nico@fluxnic.net> wrote:
> On Tue, 18 May 2021, Nicolas Pitre wrote:
> > On Wed, 19 May 2021, Linus Walleij wrote:
> > > please fold in a comment
> > > with some explanation of that (240 << 20) thing,
> >
> > That's an alternative (and deprecated) way to write MB(240).
>
> And it seems that MB() isn't globally defined either. Oh well.

I suppose a comment saying "set vmalloc to be 240 MB" is fair enough.

(And I do feel silly for not realizing that...)

Yours,
Linus Walleij
