Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61CB3EF3DA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 22:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbhHQUTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 16:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237001AbhHQURK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 16:17:10 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1355C0617AE
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 13:14:48 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id r9so34260285lfn.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 13:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h6RsJUhKpxPfJy/vKi+nK+rh2IQwDL/mjuuC3wOftzQ=;
        b=SrFvuF80cMzUMX8MpwMTW/YKW/M/N0fRxZSKfBApUBRK3mfLg+xS1wKW4AP9qOm9w1
         4HDy/uG2/zKDqujChe0VQ+QYJyF2tmHo9OYmo5JYxX+YC2zpCz8Oam4wkDXSjoqAE8UU
         vSOcKa1mdSUhL7J9FUt0/70FAIwkPKKRu6bZdR4JQNFCGSI8WHumH3C2VN54omX3V7Sz
         JrR3o4lbI+uVVgHYbqiDos1jQs5/PHOeHNSEaqtYPVyKwBV1Cydj2kqM4+uib8XL7sHa
         f2JdfMlkSp9oRXsPSuV2x+sFAYbieN+7tTG4pdstN0eOzpPQHJKzJk1DuL6xcEIGSsH7
         luKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h6RsJUhKpxPfJy/vKi+nK+rh2IQwDL/mjuuC3wOftzQ=;
        b=gvcplVaLyRAB+awOwN43gXOot+cOwGb7VgBIxnlji0243WyWi7OJf5fePZhivBNX9S
         Zl1/wUCVaQS0N6C+lxPu0CR0V23WYvHvLNo+Xuir0ALYKIZlTe6oOQ8ApQ0MeMJ0UmYt
         nvH7O6godo8wj6TkWuqp9M1DYYKUP1hKqM6BnZx77RnOnjnYQ3J3TChoPyJ/fkKC8GMP
         f8jxq51jlN9d3w9zbxyVwuafppbbUZ4fF7tQlQXzb4T0VDXXGCutw1ogNcE7lzX8xYQQ
         r5wBkIRcFj/fDC8T5NLxUQxqY+Hirwt8dKcMptDCLjoQ/QxYAc/zbNnGNSGI6uIc9ySw
         22Sw==
X-Gm-Message-State: AOAM531gI73ZL/MzjPxV3Vxv6qf5CUTx2XzM1mx+g3lbA1r61UrEXZze
        /BGoFKHo5TQoSHqk2UumDUCwHcyCzeNk3cXtiWqAOQ==
X-Google-Smtp-Source: ABdhPJzI2/LAXqFbf0+ZN+CXOdTsRZqakqH927p1aSOCBGQqotSbLnC5jLzf3rsA++IFCg9q3/ffVekCyzkk3mrzcaM=
X-Received: by 2002:ac2:5d4a:: with SMTP id w10mr3659449lfd.529.1629231287282;
 Tue, 17 Aug 2021 13:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210817200412.799bd992@canb.auug.org.au>
In-Reply-To: <20210817200412.799bd992@canb.auug.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 17 Aug 2021 22:14:35 +0200
Message-ID: <CACRpkdYNnrk35yA5u8wxMyOquxSovr9xTeYjDd61K=38Vyby4g@mail.gmail.com>
Subject: Re: linux-next: manual merge of the pinctrl tree with the irqchip tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Marc Zyngier <maz@kernel.org>, Jianqun Xu <jay.xu@rock-chips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 12:04 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Today's linux-next merge of the pinctrl tree got a conflict in:
>
>   drivers/pinctrl/pinctrl-rockchip.c
>
> between commit:
>
>   a9cb09b7be84 ("pinctrl: Bulk conversion to generic_handle_domain_irq()")
>
> from the irqchip tree and commit:
>
>   9ce9a02039de ("pinctrl/rockchip: drop the gpio related codes")
>
> from the pinctrl tree.
>
> I fixed it up (the latter removed the code changed by the former, so I
> did that) and can carry the fix as necessary.

I have created an immutable branch for these changes:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=ib-rockchip

If it helps irqchip they can pull this in (and fix things on top if
need be).

Yours,
Linus Walleij
