Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6242E3B4B18
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 01:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhFYXrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 19:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhFYXrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 19:47:35 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283FDC061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 16:45:13 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id u13so19114988lfk.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 16:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H8uBLw6ZFX6X9YzS5by0gFRyk2Emmeb1ekSUfvOFvoY=;
        b=AvFKYZ+vzzHT9J7aUt5cEslmoFh+LU9rRwhqrE3rZxvKP3d+F4U3dmc5JVPn3qdrgb
         1eBUs00jlFG45sEBGWT1QPWBGPw5L/8zR7DlZP7vUxCAmcjb9u0wiOkfWZu2dmcXU5+N
         +Qu6WTVXaal4wHpVzQczDvqaC+Liz/9WMyyyV3Sf3IBVn9bf+Sb/pe2bWRmkNbsiQHaF
         sKJlZEj5mos1s2RBgjUrcjAUOyeMfq33d+TVXbXSDRxj2dXEXksiyf3mM0AO8XSOXY8J
         JImrWV/+B0BrrYNih4UHZayeDPx3IGqAzOlZJPy1l6CKfntSO9kaAUAN5md5TLG+5lnW
         Wb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H8uBLw6ZFX6X9YzS5by0gFRyk2Emmeb1ekSUfvOFvoY=;
        b=jOhO64R0gdsoBFIa8bvlgj+zMC35t4ikJ9b96+fbhnQJ3iUP20p53z8HnM92ThX8qr
         /HlN2PSPqwDoExVzOaLuoncBiSUT0i5p/3lahqBTZ7H140SvRRkfgSPLzLlctlDJ9UiE
         wy+3QSdYl3L3YTZVVOehx96cMP0VAUjrnYVTmsb9l0jstQelZDnlVjsmcWk/jL2+5HKO
         Dbgw+9OnNrntK03UxHjplHwsuWvB8iBrwSJPcQE/3dk279qaIQVm/DqWgk52CNLr5eLt
         6Bu2T2cmoFNZIlwy96J6YatFu5rrw9CjPFfLgDkldh+8/gz9lFxRN8eUTQxzS4tupyLM
         CZYA==
X-Gm-Message-State: AOAM530T2VyBfLovKQd8cfYShjezZkDW7ivol08m/32eSIdUtAVsWKCa
        Upfw3e+U7bXw8YNwdLCDyQm28UYJIBV/DcdpWl/tNg==
X-Google-Smtp-Source: ABdhPJxypD2HVseMVyphYzKo7BSTQ4YX6t962PlPC2IyviOGpXoL2SzYiEkEL+ZYOIHQKx/zjDL0v7a9mx4fOM6Bx5U=
X-Received: by 2002:a19:6e44:: with SMTP id q4mr9989361lfk.586.1624664711513;
 Fri, 25 Jun 2021 16:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <1624273214-66849-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
In-Reply-To: <1624273214-66849-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 26 Jun 2021 01:44:59 +0200
Message-ID: <CACRpkdZ2gmYSgadzuwQ77f5G338tCXv5iNdB+B8-xoaYhahz7Q@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: zynqmp: some code cleanups
To:     Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        git <git@xilinx.com>, saikrishna12468@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 1:01 PM Sai Krishna Potthuri
<lakshmi.sai.krishna.potthuri@xilinx.com> wrote:

> Some minor code cleanups and updates which includes
> - Mention module name under help in Kconfig.
> - Remove extra lines and duplicate Pin range checks.
> - Replace 'return ret' with 'return 0' in success path.
> - Copyright year update.
> - use devm_pinctrl_register() instead pinctrl_register() in probe.
>
> Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>

I like these cleanups, so: patch applied!

Yours,
Linus Walleij
