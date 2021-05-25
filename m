Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599B33905E1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 17:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhEYPxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 11:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbhEYPxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 11:53:11 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6271CC061756
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 08:51:41 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id e2so32455388ljk.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 08:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o2BITxJeURolxCke3CdL4VW8uGYWErBJVsMNOBoANVg=;
        b=QjMPWfR77EmfcdcbElloKCE5opIP7wXaOU6VDNR2tsUFCeXzG2eMZGp66BqROg0Cz+
         ucJ7EBjOAJcqDi7ddqOQ8kthv/Xi6OrMnPnEIaygfCLPWQWG1scEInilWoBL3UazFlIq
         ma5PJWhRhP3Ds6P2Q9d4Yrw3hZeM0OClMQ8AyQCjNIvlA2//n+SmxQv2SZUPigNjv/N9
         cRzy9MSGxn/O0kTqryhgqillQluWLg8i1I7koyJIYEeTVIEKTSNBverpwj5zClfFHDIN
         JDRFlX3qWSoigrgt3HRdgf4eskN+tbsaXFAv0qyVukmjsY4T0WdswBO1b0bCxAUyT12O
         qmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o2BITxJeURolxCke3CdL4VW8uGYWErBJVsMNOBoANVg=;
        b=UJyDYjje/maWpai9sSqU0gIq5XJp9kEjAJYyBhAzaYSel1RXaVeb2wx1TzpnFZ0TfZ
         gV6gs9OGqE4tw7qd4PZKIeRrTcdo/rueaCgK+KvdV33cULc74acB1Zai5EtRRjzY6Rm0
         7X4xRJH5jjbtShykOaBL85RSYPo7Wz+wMhnSwKqrS8/j98wSIcyJOlp3qN5mJIJzLbw8
         21R6VR0cWjwblQNl3cSqM3Q2IHXrbqO/h35zYSA6AlD71VthO/3zrbM6hHh9km/ZQ0kn
         8pOINb8WLlLkbWlQAK+YOUyQX9HourKypnb6HBVmWRXsz+4sBBmx2mEd9ys5U2mb98iF
         /6+w==
X-Gm-Message-State: AOAM532sPdu2h2sW17MqspGJStQXTeVVDHj14tv+AdWqkG5jsvfc1Rka
        ZE7u9Ay/7aqON77IzCbop05HOOz9UpeppYqv1g5/iA==
X-Google-Smtp-Source: ABdhPJzze4bqogalPiiXYhQSV4Axxug2d0T9vkqKGYvuw+UgQeq7Qiie3zdmCDwElEOVv90Z9aoX6pYIJgLmld5LqEs=
X-Received: by 2002:a2e:22c3:: with SMTP id i186mr21422534lji.273.1621957899615;
 Tue, 25 May 2021 08:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <09091e75157ea28dcad1605008532016304356a4.1621509932.git.matti.vaittinen@fi.rohmeurope.com>
 <7f19bf2bb61ad64a9df94ab16bc1cca08e8efe43.1621509932.git.matti.vaittinen@fi.rohmeurope.com>
In-Reply-To: <7f19bf2bb61ad64a9df94ab16bc1cca08e8efe43.1621509932.git.matti.vaittinen@fi.rohmeurope.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 May 2021 17:51:28 +0200
Message-ID: <CACRpkdYjFoLD83Kn1WMR3fdn6=eD5MpM16wOmA41Oqp__AcM1A@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: bd71815: Use gpio-regmap
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Michael Walle <michael@walle.cc>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-power@fi.rohmeurope.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 1:30 PM Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:

> Utilize the gpio-regmap helper and drop the custom functions
>
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

Very nice!

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
