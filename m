Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025E839427E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 14:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236717AbhE1M0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 08:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhE1M0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 08:26:01 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA93C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 05:24:26 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id r5so5053815lfr.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 05:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AKQYBm5ieheoBI5Pz7+iHcmbhU/ytHrIEiKQ6T7rcgA=;
        b=CnxRwzZ6oodd3D2TVxeHkq3qNl8ViUj1w/UkJovL0sg2etOZO6NI1JSZy9rMeha1Gp
         eQtNIstyLnKT0AlRG32MYNoqrsn+efyrpMTBadb6v2LLd8us6vKO0w26Eerz7wNFQrda
         tSy+Gfej0y/0cPmC6H8uwR4Mbi1yw5Q+3QwZPeR4Ic1WL+rWNiODTB4jjssQl05HJURX
         RIekPKE494JPTXHYjdtBtNnXcTPwAyenZeQusuh8z5fWVaz9KTNlAGGPf/gZfzyNKG6d
         jSObZWqhA4gTjaZiQI9SMOxZ9gdZsmbL/JF3h4NRqPuE72ouCwebla/qagCnI9Q7Td8u
         pANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AKQYBm5ieheoBI5Pz7+iHcmbhU/ytHrIEiKQ6T7rcgA=;
        b=Cx+14HUdqf5yWOw//PzzZ8JkeG2UfxCjinpCJYKeX6iBwfiZMLN3Lb3742UqhYt53r
         fLRGd2Yt/XpJvg5YpySnebLevC3yCB8JwTkIt1WHJGVITjajQerXF8NW5QMF83C6GX4D
         qsDxqqZ1jHkq/uoSTNXYfXXb0tx1O5tP63x8CcnBKyxJ1yUi14ZVA2xcEHsHUrbKFKPn
         grRF8hAULZ0rNJUCd33aJnbvsih+1QPBEApRFWEsBrth4/qREXm6VVjHcWPH0STShERM
         twwuKz/0pyx3s4ZLX49RmZ5GGgrG8Phaoq89IGVcktOiyTLpujzLCmo1JxKLJJkjpVTh
         ty5w==
X-Gm-Message-State: AOAM533X8NzRM2snm6RcST04sYObodpEZfqSJR8VzfmG6ytm5JsDslgx
        k1fiSgGvigBTK3dzjFcTbABuEtyzfSCxjuzBL2zCTg==
X-Google-Smtp-Source: ABdhPJzakAmcdEr1HGA+bwfIYsEd9CWnhoTEVXlxBnVmXmWGg3AP6Nl3TATW2k+nSo5KfWQQE0nnfC9txq6bf0Uc19Y=
X-Received: by 2002:a05:6512:11ea:: with SMTP id p10mr5463216lfs.157.1622204665094;
 Fri, 28 May 2021 05:24:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210518120633.GW12395@shell.armlinux.org.uk> <E1lmZTB-0005UP-C9@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1lmZTB-0005UP-C9@rmk-PC.armlinux.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 May 2021 14:24:14 +0200
Message-ID: <CACRpkdYB2oFZORjp47ekBWua_mXWEBnA+qziqrZxhgR5G=Gk=A@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] ARM: use MiB for vmalloc sizes
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     Yanfei Xu <yanfei.xu@windriver.com>,
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

On Fri, May 28, 2021 at 12:11 PM Russell King (Oracle)
<rmk+kernel@armlinux.org.uk> wrote:
>
> Rather than using "m" (which is the unit of metres, or milli), and
> "MB" in the printk statements, use MiB to make it clear that we are
> talking about the power-of-2 megabytes, aka mebibytes.
>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
