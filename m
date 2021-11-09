Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5984B44A5CB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 05:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240666AbhKIEf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 23:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240579AbhKIEf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 23:35:26 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7064C061767
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 20:32:41 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id u74so10369242oie.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 20:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XPW05/I7JWkMC7nH5tjGxCD4A2fkhvnHq9/c9af0GlQ=;
        b=VFf04iPQt21pyD9jgemG/8UjO2n+aCufGZ28WT29USfCMN6WMRHlJwx6YXw+G3e/hi
         l9o4HvJMRjBXcEtDAfVqfI/VaiwPf2WUa4KQ0P7QxDCtMWmKQjLBzOs+WMGiajpfWV6f
         tJvIJtL62+qGxeqv3bId01R5WrekNfG5dXKMnM1Co3lyCKvfakCxjba5fV1JyCegCZj2
         Utq5TtiPKuebOMiYUKoJf2lr1+CEfFHS4Zxmsb10U26N4R220mDZuQ7KqHAgoI48UelD
         9GNTCoVNJQBCLaaKtRh+eysMJuWfQcbwR4Biv7fUkF/W0ifQ3BcBJLRP5A2PfWbpV2Xb
         iriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XPW05/I7JWkMC7nH5tjGxCD4A2fkhvnHq9/c9af0GlQ=;
        b=LBF+W3oI5JmTIv5C8rSVtqa6CQJlHACCcX6V4aM6N6M6xjsMVXewHvP5IB4WUkbWcZ
         tCC52zy2xtaLCaBQaNb+AmjHbHmKLPDzDoWxeBZSOKgZdHO+kxrp5l/cc/a+0GZL9Zb7
         8LyYaNAN/+5aoqN7/YO48wjeflJQvPPfuerhfAlZlANLvfeGxwo0oJLJ/WFeefeLsELo
         6iUwssLsXchIsBfimetjszE9GpojP269lsdJr/i/nfvd62FckKIYZz6TmvzYCZiaQnd5
         1n5fwgIIjp9MluiQY2dDmAdexhwB+HzYtHvTWuq3DFAvlHjtrB5ZBKfUdfvKJ7P4eaf9
         s24w==
X-Gm-Message-State: AOAM530U/d1GtLGcGkc/FHT5kFG4kEx7pf8hQzwvyD5eS/oONN9DLzY/
        X2G9KJjfdjS2wfQqlwyWRdQ9yuSocsvsQlvOyyD5UQ==
X-Google-Smtp-Source: ABdhPJyiXYZZr89IAwXjMdgsg06kxN10S6s/oac8LsbHgXOCPomhOTw0JA/nU8TmlBO67To6uEcKTgdCFGNIZPdoNy4=
X-Received: by 2002:a54:4791:: with SMTP id o17mr3342475oic.114.1636432360933;
 Mon, 08 Nov 2021 20:32:40 -0800 (PST)
MIME-Version: 1.0
References: <20211027134509.5036-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20211027134509.5036-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20211027134509.5036-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Nov 2021 05:32:29 +0100
Message-ID: <CACRpkdbY7QtjACCu63k+=Mn-XeLN3+fOjmKYR0w2NbhEZYGbeQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] pinctrl: pinconf-generic: Add support for
 "output-impedance-ohms" to be extracted from DT files
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 3:45 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:

> Add "output-impedance-ohms" property to generic options used for DT
> parsing files. This enables drivers, which use generic pin configurations,
> to get the value passed to this property.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Looks good to me:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I suppose Geert will queue this patch with the rest of the Renesas stuff?

Yours,
Linus Walleij
