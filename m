Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAAA23D3D7B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 18:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhGWPlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 11:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhGWPlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 11:41:08 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D34C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 09:21:41 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id u3so2939851lff.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 09:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SliTX8Iw8l9nFjbx/gRlB+2uInDqKw48vi+rU2al8Nc=;
        b=z2CkY6HOoSWT8+R5fkxgZ069VX+3PJN1Nvq/DmH1sahvH73bCUdm7/j6kXiDunpTps
         cUSxVODN7M+P8LW7IBoaBbne7Xspvb0LzLvB0Kq7/uHI8Q6QXuW0IoT6RaGfGaaRUPpf
         tBEKmvdDfRRvyq7poBebhbAx8eGV0FJGBGNgyJJS7SBlgjtwL3PRWg/k35p5fsvYgj9B
         oQJ7GOjmdDMlYnXHWjdX1BvfssKceNTv/onAJz6FBzOoXqLAWFB2akrZ7JiNtZn905Sb
         IJ6tLfZ2F+z2AmtsSST04NUyrHQxHmIqwAxTrOmTa2BJRsSVSFtZX3o2QRBinJ+0Bts5
         YIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SliTX8Iw8l9nFjbx/gRlB+2uInDqKw48vi+rU2al8Nc=;
        b=JH+tjDuBqD169wEswtU7aTu+po2TZUad06MHVkSWOsB6x628EOGSO3WtY2mfbNsof/
         RoUw0xmtykp5bBPsp0yJO8PzfJglAbEmVdyS6ozq1y1dBryz9tkgo8PR4PsN2KBymagO
         Cna6CG3My9owwojtP0664O+Rx/ieQpVuFjLaOpEuhEXKQSAu1cTfhvxOCbAh5ecKvSZD
         YKtxnetqcHMTChfYQpV7hgVpau9BZ5jYU1jCOAe3rWBzTKYNi7KVzVRuaqCNI+NbuQVx
         61IUa8njQF7WuovC8dpRT0dT6h8DL1um57LIqAzOC53p065JTBm8IDzFGhI5XxUOMThF
         3DXQ==
X-Gm-Message-State: AOAM531twMyeavcxiaW8gXdJTJ4DxeCxPXNu7ONI1mShJT2ZG/fhQY4I
        +6I7DS3R82N+FpybEDOER+ymNZjS8PvGJJVKgIqUOg==
X-Google-Smtp-Source: ABdhPJwyeo7rGBpxoxiquAEUXMh8R1GJJMHfyFuO8ePzx4uDJagKcKEm/Zrtnh+n4Oi7Tcg2iBTeqT0sI+9NsaX9hM0=
X-Received: by 2002:a05:6512:169e:: with SMTP id bu30mr3470614lfb.291.1627057299505;
 Fri, 23 Jul 2021 09:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210629123407.82561-1-bhupesh.sharma@linaro.org>
In-Reply-To: <20210629123407.82561-1-bhupesh.sharma@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 23 Jul 2021 18:21:28 +0200
Message-ID: <CACRpkdacTi-9YzhOqpfFkNhzSATmbWHs=wMoJcsXwG8pBeW7Mg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] pinctrl: qcom/pinctrl-spmi-gpio: Add support for
 pmic-gpio on SA8155p-adp
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     MSM <linux-arm-msm@vger.kernel.org>, bhupesh.linux@gmail.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 2:34 PM Bhupesh Sharma
<bhupesh.sharma@linaro.org> wrote:

> Changes since v3:
> -----------------
> - v3 series can be found here: https://lore.kernel.org/linux-arm-msm/20210617053432.350486-1-bhupesh.sharma@linaro.org/T/#m2b1bf2d32dfdde3196dc5342722e356ee1f87456
> - Rebased patchset on pinctrl/devel branch.
> - Added Reviewed-by from Bjorn for patches 1 to 4 and Ack from Rob for
>   patches 1 and 2.

This v4 patch set applied!

Sorry for taking so long, I had a bit too much to do.

Excellent work on the patches Bhupesh!

Yours,
Linus Walleij
