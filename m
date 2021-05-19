Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8011B3883A2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 02:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbhESANn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 20:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbhESANl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 20:13:41 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF751C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 17:12:22 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id q7so15020678lfr.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 17:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QkFJB+otnmwltLGFDsGxwuEk5BhOyR7tWdo4yOWY1wc=;
        b=vvBSqOjC78aj5fWRQSsZoFhAPgjyKXreaLn2qc0ueH0m+gryUOA27w2Z+SpYbsW+AP
         wK9J8Qugui3AbS4s0k85oG0VOb5+yNdNc22hkAcg9x9RQIzaoaP8m7j8eAYTrEC/GG+p
         YZMWkAW4B95iGlH2UkU2TftwyCks9Lr6EexgrQWQQLOGdn1LqflzAxDqxSGWQfEItNau
         AgrUm9ex+QWTrpjXbk80zgpFBlCIMYxEsfEhwVXv4sS34SGhO21Y/L17k5N2VhlNdUSo
         UN43A4PQEiEPxbuA/RMexrA9PtL+9lEKgrI5RUcBJoTuA86MdeqX5CtAGoErWgTaBXso
         9mvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QkFJB+otnmwltLGFDsGxwuEk5BhOyR7tWdo4yOWY1wc=;
        b=Hu89BeJrahBegWAbYH7fJtkdNaeHR3XlsqVaKZI5/JAdmsWEHYQAdLDGH7hp1aMPUQ
         gHLaB/haCYtqSOnI+IwMnYnMV3aNjkeW/B5AhkotqNZcoTzAe/8VDUfzV6W2I8+4iRBQ
         VsyS6rH7h+iW62oRkY401wWnflQKTFtGXR/SdfMQEitM1he8SyrhM6vekw/w2I7qkEYC
         D8hAr29LBGVhgl1Bm1jp7dHIHwdmNdsHN0ZsP0TIuMU/amnx/8hh2/rBEurujnWuLc0I
         Dpocpxu+j0F4B13BQwD5QANZDV5kRakGY/aFemqo/Ec91f2Eidfyc49VXCSuiMS3bj7O
         S+Sw==
X-Gm-Message-State: AOAM533GVVIwb0llBRWehoONxwTXV8SyNSbq0F4VWm9W7DqcAsmR5D6F
        BKAI0TszDj+7EU/xzqft6lrI4pXSJgPGEjYN5zo5OA==
X-Google-Smtp-Source: ABdhPJy4FzN7hFkVlARsIv205HJnTPbWVjj0FRfYHskNGYlGD2BX2/SZGDwbbYLTxXAevIsKhZJd4qstb4GB0eWfjr8=
X-Received: by 2002:ac2:5145:: with SMTP id q5mr3450917lfd.529.1621383141079;
 Tue, 18 May 2021 17:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <1619353584-8196-1-git-send-email-jrdr.linux@gmail.com>
In-Reply-To: <1619353584-8196-1-git-send-email-jrdr.linux@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 19 May 2021 02:12:10 +0200
Message-ID: <CACRpkdb+3MjbtFvo3t-hX9uDDTdnPQx-KfZAqQUrvQQQ42mqKg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: aspeed: Fix minor documentation error
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 25, 2021 at 2:26 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:

> Kernel test robot throws below warning ->

Patch applied for fixes!

Yours,
Linus Walleij
