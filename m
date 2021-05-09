Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB403774BB
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 02:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbhEIAfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 20:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhEIAfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 20:35:33 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7DDC061574
        for <linux-kernel@vger.kernel.org>; Sat,  8 May 2021 17:34:30 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id m11so1681775lfg.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 17:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nioUacGgmn1npsnF7UjH/G9jEKx4GaZezabtRTdAHNQ=;
        b=yYcpD96kUzepSQpuQfBGevivuidrKiXsh8ogT+mWIOv1Qcmls5U6isOVtJAS74kOFF
         2/RRdzcW8gis5NsZy5QJZrw2RPGepBediQrFxIDn+Ois12Ne/Q6wwt3WLnl4bq+r8eEo
         Say48A9hZMOjaWV5Iy/A73cfhSeGkz3nGoo1avWJcqw2OavtfZNdYpBcicZUITIVp2UF
         0/QWkWxBl1M3l67KnFoYSDpYeDSHjRwP+h2eZt/9RClBnpfJClfLU1+OLWk9iMsMSs+Q
         vST+tnS90331h/ZuPy+6edYsE9FYCvN1WBbkjGtxEs2zXpyiNISxkZtivUrXni+jS4it
         LlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nioUacGgmn1npsnF7UjH/G9jEKx4GaZezabtRTdAHNQ=;
        b=cl3kSbgEU6bKGU+VE6EFf8b7tgm9fsizQKmmbKITla6fVqltkFa0fNZQXWZmjdCpkP
         pg/qxbiq6+yVgU9B/KYBNO/q8o1vuWtoKN/mDe+yu16AfNxyoZCc3XEYSwFlcNT9xgim
         RpmEmxVm2Suasxbxze7IhUw4iBfnruILtHXLpIEnOTrGqFJcNeZbwPnQ0/iv6q5x7FMp
         DIo7YWFNBqAqqK70G8w8i3kqXlzB4couZgihv0OnD1RCaqEeTT00BeZomb7EJpKnSXxS
         kX+wiukX9UkrZRPaYoV4C4kMsIDm4ia9yqnAJycaBQAQLTLoFSbiXNRPbE1jn2Iw26Ze
         wIYA==
X-Gm-Message-State: AOAM531nlWzJAhPmNkzpT4IUx8CkPv0uC2u4Xkpf2WsaC0R5FJLbWMWs
        azLTz3KjCHkPCkMV39gk4p8RM76B9qi3iQ3WXsdc3MrTLhc=
X-Google-Smtp-Source: ABdhPJxbPU5qQoWYfS6KGidcbReW4q83/88i0j0ikF/ehy9FP8scZoynk/akVfH99CeiCQ+yfmKsQDO+/cOQgzfatdk=
X-Received: by 2002:a19:b0b:: with SMTP id 11mr11191818lfl.291.1620520469033;
 Sat, 08 May 2021 17:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210508070049.2674-1-thunder.leizhen@huawei.com>
In-Reply-To: <20210508070049.2674-1-thunder.leizhen@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 9 May 2021 02:34:18 +0200
Message-ID: <CACRpkdY9wPVE+mDzLbjxp-=Au6jHn6g378Dc24=fpG50T23qRA@mail.gmail.com>
Subject: Re: [PATCH 1/1] crypto: ux500 - Fix error return code in hash_hw_final()
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Westin <andreas.westin@stericsson.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 8, 2021 at 9:01 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:

> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.
>
> Fixes: 8a63b1994c50 ("crypto: ux500 - Add driver for HASH hardware")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
