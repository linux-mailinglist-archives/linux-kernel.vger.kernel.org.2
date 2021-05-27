Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADBA6393006
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 15:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236561AbhE0Nra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 09:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236335AbhE0Nr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 09:47:29 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E1DC061760
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 06:45:55 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id j10so127084lfb.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 06:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W+RY/ZnJxUazn0U77RqA9l4c/3Pra+EKNP8BXkqQSSo=;
        b=YqtqCpXaY77DgycIF3WQZ6O3jSe3xuuTR3mSksTjFk4UWlm9pv3ehJXzwbQxIY/2W4
         bmyONPuytS9+vrVqbbagtVTJlfD9w8zl1zSJqscaodlTRrDfm7Ok74XtnmkpIQf0xpJI
         42teqaJ5Ca9TieNzzbh2Y0LJ7WLu5JeGwaP1ZQPO4TamblRJqZNdU/X9Ubqs7CnF5zCm
         qD1DoZoo9FV15TjyCdEYJzed+PmE//6qRK9KqPtk5NdYPhT0YpzbpTeK+08hC8BYU6Z6
         dJA5NarG75cAlMf8j35puf7D/K00LVDT2oeWkdNj+fHYhQJJ2zf0yUCtrTzXsQ2VWNRW
         eMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W+RY/ZnJxUazn0U77RqA9l4c/3Pra+EKNP8BXkqQSSo=;
        b=f0GqB2GmOUb/bK/gYQ7qSHxeXGzJkxdccC/2kVLylQX4IXAiyVc8KPDZfcU84u0kVh
         vCbwjOVaVX2IkBSdBsOAyJt3bZGqe67Qdd4CRU218dM6p8R8sXJfKlsGTBX0WQo1jgew
         eg/TAer+FztdP3DwM8CnODjYCe+h6z0io3Pmixe9ONHhpKDt8iwEjc7MFuNV/bn6PSNw
         bWmhJ3QQQAWwMlB3oX1rqEF6lp5lrK0xdWnAu8HwfjcaUCB3ShgmJp6IcD5lf3iIA1ab
         R/82B8zsVTvUbrUrO9K2AJZrqHuXoaqUWh4fRMn+vA+AvwEeJHEhOJG6gjwAW9Vz7GdA
         vTqw==
X-Gm-Message-State: AOAM533Klk3mj5dYBRdrhY7uSxqGEhlNQZN8nDdyoEnqDuVHs4Sf165b
        jRbjprfBCHIU6vEPgQPv9/nJyGC8zzR0qb86d4fWSk1tLsk=
X-Google-Smtp-Source: ABdhPJz0SZ/0YT2tnJ88UE0/1hK3tktsGRtCG2FJ2ldHfMYh3qCu27J6/i0yDb7Q55GDD9Ii6r4OuTTTlVAdYpBHOM8=
X-Received: by 2002:a05:6512:1185:: with SMTP id g5mr2454860lfr.586.1622123153392;
 Thu, 27 May 2021 06:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <20201207155106.172057-1-colin.king@canonical.com>
In-Reply-To: <20201207155106.172057-1-colin.king@canonical.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 27 May 2021 15:45:41 +0200
Message-ID: <CACRpkdby8f0KjJygdmHLS818z6sVxs5vkV5Fx_X3qNea41NTQQ@mail.gmail.com>
Subject: Re: [PATCH] ixp4xx: fix spelling mistake in Kconfig "Devce" -> "Device"
To:     Colin King <colin.king@canonical.com>
Cc:     Linus Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 7, 2020 at 4:51 PM Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
>
> There is spelling mistake in the prompt text in the Kconfig. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch applied.

Yours,
Linus Walleij
