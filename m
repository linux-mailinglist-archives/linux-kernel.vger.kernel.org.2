Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127F53882B3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 00:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352740AbhERWWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 18:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236910AbhERWWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 18:22:44 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E76C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 15:21:25 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id e11so13229001ljn.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 15:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6wvxlnMACzl5Vgyrn4bxRllNgosr37fqx5aWg2Pc570=;
        b=uimXX1kMk7Yd1tMNua5/EW3Dr0eu10uzFXDOL6LNd1bgX0TH2xjaIu/RImU4snFEBE
         jJ5x8BDkyRY22nVbRAwfkSkv3dq/e+P6EKZKLA65OH95Li335DtCzXXBEv/m/NF6f8m7
         Zvx0d5XkofbSuRhx8CUOG8f4F8w92ZeCrLAKZ1kZzVIuHE+ASUG4aCHpVhcONpYFvaZa
         zgv5uxd+BeEyxlX0a/thQev7DZ0Vi93CC9L/ap9flZ2tM2N+IyammDpuAjrGLvLiMnw5
         RkHMjKFgALjIC4jrucVLN7UmnnkQCFd3rE6AXImJZ5aXalsrR5NbaUjzayIFlHtmmq7E
         LfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6wvxlnMACzl5Vgyrn4bxRllNgosr37fqx5aWg2Pc570=;
        b=nwDOERVdoeQFhTath9BbEQudkNTjhl6cmBq+xL1HBdxUBGmuQi2riDf81T7+L2I7cw
         DfXgvvR3PhjYbcx8Paduku5LTGQFv1TkxiebsRoSoVHu8DwryyRUiDmBW8I4zY7hyUaV
         HIo9tbSibftFJXUYI6XjLajT99GACuoJob4fd795gzDFHKJp5uYpZC0fcUTgEv0qPq5f
         zXTmskcclHQ6yBrd2PA1hcRU9+49qjBAGIOByog5MmOupHSr0cfBDAJkZuMnaTEayxVU
         /x5GXhrrS5htERd8ObbvqAy8IhmfB7qKsOsNwcSYYaHW574IU3+XFYJmdCbBo+8AmAEL
         HwKw==
X-Gm-Message-State: AOAM533/+VtyxxCJKujp8gULbz5VuMRa5M8gLh29lGWoKz2XW4mtZcJ7
        OUe8Zgqv/DlBp+JykrMUhiy4GvQCg9QwwKMOVOkR8w==
X-Google-Smtp-Source: ABdhPJwlnW3ly6Ny6e9IIz9/CA7MNOePxxOU0BqKeMkRRi+b2Ljau2EQiV/khaJy56dbImbe7rM07lY5GpAgcnCGeSA=
X-Received: by 2002:a2e:889a:: with SMTP id k26mr5694835lji.438.1621376484445;
 Tue, 18 May 2021 15:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210518120633.GW12395@shell.armlinux.org.uk> <E1liydf-0005BQ-PY@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1liydf-0005BQ-PY@rmk-PC.armlinux.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 19 May 2021 00:21:13 +0200
Message-ID: <CACRpkdZyGPp6oJWPMdYEEddugj4Amt4+5Hw_YVtkQuxETw5g=w@mail.gmail.com>
Subject: Re: [PATCH 4/4] ARM: change vmalloc_start to vmalloc_size
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

On Tue, May 18, 2021 at 2:15 PM Russell King (Oracle)
<rmk+kernel@armlinux.org.uk> wrote:

> Rather than storing the start of vmalloc space, store the size, and
> move the calculation into adjust_lowmem_limit(). We now have one single
> place where this calculation takes place.
>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

This is really nice.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
