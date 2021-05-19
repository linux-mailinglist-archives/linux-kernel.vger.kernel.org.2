Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4033883BD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 02:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238890AbhESA30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 20:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234258AbhESA3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 20:29:25 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD13C061760
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 17:28:05 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id v5so13472824ljg.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 17:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ht3HQ9bxacMTfT6I3FfUJ3J7S7nbkDcvYxZIjBScjJ0=;
        b=CfQ585UskHxoWGkItuzyQTKz3IN16vWY7mK0y9GLJvbCh8++XzHtu5wus9b9o02/Wp
         jqZBu/xvw0pPYeW4NTFDUOrDj4DwlBrUIwsjmeJm6irlCwEpMNJNPWvcCIcHIRdfvytl
         6PcAWEdZggP+sLoAkUbFOGDsTFN55/puxgqewNedlUVFqm5FGowP1KX7Q2XG4kVSZEzJ
         nUcNnDLOy1rjtC0+qoVQ0PXqppCS/RnjvkrBNkKFdfeIiDgjX5+RWKxH76t7Jd4HfgbO
         zhM8SLCijMZHFrElM7Ccmmg80h2WRwlFMdNOv+hrZQesRFtIsLzqau3kCYmDfJpPhhAW
         tc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ht3HQ9bxacMTfT6I3FfUJ3J7S7nbkDcvYxZIjBScjJ0=;
        b=O2cCFWpa0PTeNLC+upJx1SDOW/LpdPys8rmKZNq7NiaQDNfuhD1s45gmHyYh4WiC2D
         78qmP6zALt1VAY10Iug/0kDs6fEOxG5SPFs19CCY8r5+0UFPayG3aPwdRIy+1sj4Udlz
         hZSDve/HOzxRr/71gcQsCeZfr5NCMoQSOEjYIggazmfLZ1bTY8W6EdXa5in4vKQXxxMB
         +oRaIaPNPx34o10Bdy0R7q0c1jut2NaUHn5M7T2G/3kxHb/ACHhveAUotmzuDWXFakRG
         9puzLr19VlkX+8z3000TpRAC8vlWBSR7Tld0g7OKyby6bsR3pzSSjJrjEQu74BOpkEbi
         gzAA==
X-Gm-Message-State: AOAM531yGBxmSiEoBTn53OJW/p2yZ+iL0H9+I/GJIRuoLKnjUNgLWHNz
        ZpiO0NMkkEAQ9Bh3rFSjK851/7GfzaBCRi1DuMyzCOTlxIY=
X-Google-Smtp-Source: ABdhPJxLpppqudrabuhF5o9ZlLsbEiV1Tb0mqbmVtz8CcdhBR1Z10UaabEpkE5AxXCUSNz7R42gFp96tA2qfkAbWoc4=
X-Received: by 2002:a2e:814d:: with SMTP id t13mr5936495ljg.467.1621384084026;
 Tue, 18 May 2021 17:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210429003751.224232-1-bjorn.andersson@linaro.org>
In-Reply-To: <20210429003751.224232-1-bjorn.andersson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 19 May 2021 02:27:53 +0200
Message-ID: <CACRpkdbtGFKoeo2zdun3cPBvZqTMnKP+dnbf5k14BHjhd-09cg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: spmi-mpp: Add compatible for pmi8994
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Brian Masney <masneyb@onstation.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 2:37 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:

> The PMI8994 has 4 multi-purpose-pins, add a compatible for this hardware
> block to the MPP driver.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Patch applied!

> PS. I see that while the related gpio driver was converted to hierarchical IRQ
> chips the mpp driver didn't get the same treatment. We should fix this at some
> point...

Oooups. I think Brian & I discussed that and that we "take GPIO first"
or so, and then forgot step 2. It should pretty much be a copy/paste
operation of the gitlog of what Brian did with the GPIO driver.

Yours,
Linus Walleij
