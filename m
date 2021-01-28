Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50CE2307577
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 13:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbhA1MD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 07:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhA1MDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 07:03:07 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDA0C061788
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 04:02:04 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id h7so7238314lfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 04:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=usfc03r7bo+9iWnGhn3YJY+bfRfQpQsiPPvtGVZjTJo=;
        b=npthAUeo3rWK36iMclfXUXlzdH0VQDifjmso0bBCFVXOyQtra7DzyHgEmzJCt30dt/
         SJ9fMz6E+ZXbymrWtxziw9opC0BGbilGWBJXbYZg/g+BYXgWz07+qrex1EOMXMqIpzpE
         6jYfIeX/eLZOEM3VQR+NV2YEMCt5h3yT2zkYs2fBjC+YshcbiveecNrV2CoAJtG6ZVel
         ii8PNYw1BYp2K+WyqndwkTLNHTfxmpxwnUysv03/L8DCd9xBIWL+Ex04T8ZFQN2SR4Jv
         XJrieSOBP7Hg+fXfNeCpqIezF0N6+ilCD2nUbDQYYsRnM51XurcjK/Q5y7e31SHMaiG8
         0S7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=usfc03r7bo+9iWnGhn3YJY+bfRfQpQsiPPvtGVZjTJo=;
        b=WnZPdPwhlO/zBnp3gZDN2mcpR2KKVsNNFGjknb3AeCLzqznk3B1jhq3ePRzhECd2I5
         xoM2YyQNYDTA4o954XaFUuXnPPABRbsdEardMc9NFm59TyLPU6R8ZJRXgu3ErzFNnKaK
         NzcdCOl7Rs97FzPZuvuFw47QJgAXXsBZ9aJuBifteoYeGgLQ/qJGA2TKhx0AjdYp41u8
         9E5lPMmKt/xPvrm7dy1+ho+XwCIuNzkFMH6xPHHXMst5pezbIY1XPs5WH7EKQB3f3i3r
         iUjS7LVdB+aeq71aWvpcZ8rgtx8DSQwhwV58dtFvNepBZ86UkMiAc5u8dmMxtPuCBele
         tShw==
X-Gm-Message-State: AOAM5304TAcRkUcC8RbGo8MOJ1Nn+oRTEt4grPxB1rq/J+CUt8oPRivl
        DwaKCGY9Rrz6hGmECgCvK2HCax/8CD29yOWbwYQO6Q==
X-Google-Smtp-Source: ABdhPJza5WEqdY64nMdJh4p+Ysom/A+I1BzOUDl9O6I2P4XzvnsQTS6dm+guTw4PUOLC3FEaVrkSaMBAp3FtmqHRCno=
X-Received: by 2002:a19:b8e:: with SMTP id 136mr7679656lfl.29.1611835321876;
 Thu, 28 Jan 2021 04:02:01 -0800 (PST)
MIME-Version: 1.0
References: <20210127000303.436595-1-drew@beagleboard.org> <20210127000303.436595-2-drew@beagleboard.org>
In-Reply-To: <20210127000303.436595-2-drew@beagleboard.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Jan 2021 13:01:51 +0100
Message-ID: <CACRpkdYkyxXmxhikvnpxc07MmWPweFAphRPCMd02Ye4EyuOVNQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: am335x-boneblack.dts: unique gpio-line-names
To:     Drew Fustini <drew@beagleboard.org>
Cc:     =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 1:05 AM Drew Fustini <drew@beagleboard.org> wrote:

> Based on linux-gpio discussion [1], it is best practice to make the
> gpio-line-names unique. Generic names like "[ethernet]" are replaced
> with the name of the unique signal on the AM3358 SoC ball corresponding
> to the gpio line. "[NC]" is also renamed to the standard "NC" name to
> represent "not connected".
>
> [1] https://lore.kernel.org/linux-gpio/20201216195357.GA2583366@x1/
>
> Signed-off-by: Drew Fustini <drew@beagleboard.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
