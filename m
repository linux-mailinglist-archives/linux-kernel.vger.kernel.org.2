Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8223923CA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 02:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbhE0AcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 20:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbhE0AcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 20:32:06 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C9DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 17:30:33 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id h16so3654484edr.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 17:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nqOWBc5Vkt6mpmIWMkw8cPEAfhoVE6+CoM7HYKuIu8s=;
        b=EvwEfGyy11UbI7Zt9geDpmBcBvjnn1gjkUIy0CJzh2zn7cGGE+dvpdGmHwR97ANyi2
         GytSNhMhOtQ4atdLvHTnqclw5oC+auYRQHQUtLdLdJSQjxKN1wAc2OEwZD5E3nN9Zx8A
         wO3Rgz397hcVDNye2OHNRSqN6HHQv/Ba3oOQCbTpnqOPEypaVlzhY81f7ojpdxWJfiEX
         uNEGXCE9RgBkHaxcI5HJcx9R39jArPgSkeTgJqh3uqelrhXMDfiwzNOwYCkS0I0yNtWa
         svXnVfnxzCtQ1N16WFGj9iWXDv/h3236GX5f7wG3Ab2pnroAs6NU5BrFLXwBWZXAD3wB
         gjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nqOWBc5Vkt6mpmIWMkw8cPEAfhoVE6+CoM7HYKuIu8s=;
        b=i238eJWy+0fB7hXSDOOE6wYuKUvMJoNJPxsMYOl1SDd+PwsOEnT7Z8qnU8GaKMZT/P
         F8MRW6IGshPPqdyDIS/Nq8zvpcO+fNERVTN0RvNZ8JCs0jrqh9izar0mqvNFZaSReNhL
         6iBNstOJtEiYJzpcKcGTxEHDF2DAnn4MnkQMAxPPbZgKufy9d8cu1THfxZe9f8tdY5wf
         oqBoZ6gTL16UuGWh348u4P7oxU/xXDSw9OrQ3SaJpj+JKjvku+Umc+c9BXg7W0BZLU/x
         PhjvSIvz9L7IYEO3ivoB+A304uEjzMR135odUgxF4uIUiTvj5mAUQ3JZ6IDCO8tvbR0D
         bY0w==
X-Gm-Message-State: AOAM5323bgGtZ8XGtpe+rwG98yCp1BaqJ7Mwd30ubeL6f9nhlCruyecZ
        CPELwu/9zk9MtjSwtO0HMIMLoIJKHOk/1dAOKSqaBmi7J34=
X-Google-Smtp-Source: ABdhPJyY/2stx8PhpsQFWpDFP4m6A0jn6atr7DNeD7UEb/Hdiezsr7390YIlJdKM7opXTdkG3ceWEMM4xgWZSnqGB2M=
X-Received: by 2002:aa7:d4ca:: with SMTP id t10mr1003169edr.42.1622075432187;
 Wed, 26 May 2021 17:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <YK7iO96g+7yIC0l1@google.com>
In-Reply-To: <YK7iO96g+7yIC0l1@google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 27 May 2021 02:30:21 +0200
Message-ID: <CACRpkdbBGAbZXsFiekoQUH2MRh4V0e6gR78+cLh+CM2NzXP-dA@mail.gmail.com>
Subject: Re: [PATCH] Input: cyttsp - do not force interrupt trigger
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linux Input <linux-input@vger.kernel.org>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 2:05 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> Instead of forcing interrupt trigger to be "falling edge" let's rely on the
> platform to set it up according to how it is set up on a given board based
> on data in device tree or ACPI tables.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> Linus, Ferruh's email has been bouncing for ages, it looks like you have
> the hardware and you are already looking over another Cypress touch
> controller, mind if I put you down as a maintainer for this one as well?

That's fine, just list me if you want, one more or less.

Yours,
Linus Walleij
