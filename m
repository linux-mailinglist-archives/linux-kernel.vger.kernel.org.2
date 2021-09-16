Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A0640ED25
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 00:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240759AbhIPWMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 18:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbhIPWMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 18:12:47 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837E7C061756
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 15:11:26 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id m3so22599302lfu.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 15:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6LvSfd+oI41H6Om1rL7Jhn9kpcVwL+kRoJZVRWE5RMg=;
        b=iNZ53wr8Hb4bzCLF6PkVEFxG14WopLJYJsVixNsrZoo5Ff823mrGn+lr3Tk+9nPmUV
         5QgR0leP2yIQsq6L9/iXiNV9RjJOhHZJFQGRJXJpCNr+mTgSvoXjpleLfGB/IbvZEGjp
         QsYkD+m3Z5ySKZgERdi1pghoyA5o1+ymply0OS6+ldsL1fHiZ7HbTKmiC2QZIZWnpx2u
         KYyBs7Iwy98ITyr+GZ1B5GyStUc5Tn0DLMaZQH6X2QVnPJk69i6tB98tfyHai7Y8TEfJ
         e+XNBKwqWfuLcKm6EGmIW+yIWtrH6k+PVAAa2xly/zw+BVa4jmaQKhYTBAbte0DwNJ/2
         f1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6LvSfd+oI41H6Om1rL7Jhn9kpcVwL+kRoJZVRWE5RMg=;
        b=LKoCkbB9cm2vzO/CG3NERt61z0542Ds67PkAWwfNdTzikWQ9a2QqxLgSnFIzNZyWlh
         yx+xMV0ga+oEgMezPJOiro+KprtTaHX67+huwDTkPnu10QuzrK2zRUxj0/GUSgUB634X
         Z8bRbxrJjrkB74xq8vnoiMJzKGvg8v0WhYLYKe3ahraVWWYySrOq0kghbWiuPTJd0smU
         L6A46P3XGyyyyjTPJsLJdWbUf87pLvMWC+b0t94RLFjfk/J1bC0cxxSDwNZJCbuu55sO
         4eETkPyFnuNjNW5C9thExjxH2TLALEhl/+7Aiv5ieVpFMegUWOGNWs+f11Jon7e6UXOI
         ++6w==
X-Gm-Message-State: AOAM530dq2SAvcvtUVhTPa91JetJX2iGK6usSRUEJ72ZxomxEvDDdNMv
        LQY/ewPf2lxffvpatxQljG9YQjiorZVDqLc43mtxnMUuxV0=
X-Google-Smtp-Source: ABdhPJwzHDkcJA9/P85VBxJeOWAsCoQzQpiUX95nEcEBvcAi594TiH8xGSb3V+Sxej7UbLGijHC6SzgPBXNBapvEhtU=
X-Received: by 2002:a2e:1548:: with SMTP id 8mr6691975ljv.358.1631830284908;
 Thu, 16 Sep 2021 15:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210826123516.14441-1-colin.king@canonical.com>
In-Reply-To: <20210826123516.14441-1-colin.king@canonical.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 17 Sep 2021 00:11:14 +0200
Message-ID: <CACRpkdYDWN+7DG_93P239YD4qMa2=d8wYw9BOdgp0YpbNTiM+g@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: Fix spelling mistake "atleast" -> "at least"
To:     Colin King <colin.king@canonical.com>
Cc:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 2:35 PM Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a dev_err message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch applied.

Yours,
Linus Walleij
