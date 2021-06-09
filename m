Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521363A1282
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238812AbhFILXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbhFILXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:23:01 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F86FC061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 04:21:06 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id m21so21723372lfg.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 04:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1elVfwOvcaESeQvZLqDrd8CapZfzhuucwYU0NEEL3IM=;
        b=zQXh4epnqeNGF/Zt/INy2VLEzNDzcix9fmozTSqK9HrE16nO6LEo0dyozC25DpLjhC
         NQeUL3TatwEp6kFzwvHqWDGGz8ZbWMlRQjEjjoxZFHCGfqtUSgqf85rqWCX2N02VrbOu
         tYjHUt6xdh2BQz1leRLw4KXmOh3nCrANlF3sbFciCAsi7GqR8gckNryRjQEv6vyv8xhI
         OuFWMAXtVN67ZoOtCjP0QMtIqg559UJe9U6d/YRZyuLeZ9yxWY1S53llTCalL79rwwN/
         X9znF/pIhlRhZuHFZUMjUy+Hz7uq7MQppJGqcRaNQUZbK5srBMLIdyJsK0QP4wxK2DKA
         1Xuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1elVfwOvcaESeQvZLqDrd8CapZfzhuucwYU0NEEL3IM=;
        b=cFSG5/ql+tqt9eyBR+pX77R8AQHR7vbCCVMF69R2G99YTOAEMxEm7k0k8piSFQES5S
         0Q9Hq7o66OhArEqrOK5GoH7QS2blPlmNbLttTYJJ0+/5aARaamoKUHCI5igSTJ0CWMSJ
         nvO/JLioKFOOJQy/3YvDAV7uwib9DPpVozGf1FugCscNduNSBHrz0tdgSiicrVEIFRvF
         oep2oV5tPOyzqMwRiAibFj+Pa7Rc7iZY83ccFwHEW/6rGiqRws9Sr9sTkZKI9TQ0xjZc
         aJApEwaau71uTDw767NL1Uh57lpaBNBbVsB7/474Gmcpvl64nh0Z3E48jmueVj7py3d/
         d0CA==
X-Gm-Message-State: AOAM53096ouQ5OefYIUARgOcxMOzOR6j7JgM1soi0cUyBgWJ7146ky8V
        wZjKdh+SVLf5Cv26m+GuzHo5hCEMoNwZKorEzq8BvQ==
X-Google-Smtp-Source: ABdhPJxjRNYZa7CArMuSR057imgElswJ0539mWpU00VB+QbDL43HR/W/KXcMY10hVWytT/G6HYIvfW5d9J8On6evxRg=
X-Received: by 2002:a05:6512:3241:: with SMTP id c1mr19407580lfr.29.1623237664559;
 Wed, 09 Jun 2021 04:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210607193500.3085920-1-robh@kernel.org>
In-Reply-To: <20210607193500.3085920-1-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Jun 2021 13:20:53 +0200
Message-ID: <CACRpkdaghKYiU9AgyEd3arFHiNEq-9+Xo8z4hxUxHFqrJM7n6w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mtd: Convert mtd-physmap to DT schema
To:     Rob Herring <robh@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 7, 2021 at 9:35 PM Rob Herring <robh@kernel.org> wrote:

> Convert the mtd-physmap binding to DT schema format. The arm-versatile,
> cypress,hyperflash and intel,ixp4xx-flash are all just an additional
> compatible string, so they are all merged into the main schema.
>
> There doesn't appear to be any users nor support for 'vendor-id' and
> 'device-id', so these have been dropped.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: linux-mtd@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Very nice, thanks for doing this!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
