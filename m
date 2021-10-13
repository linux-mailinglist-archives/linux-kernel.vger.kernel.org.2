Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FE942CF09
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 01:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhJMXRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 19:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJMXRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 19:17:44 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF51C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 16:15:40 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id ec8so16643914edb.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 16:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ju4FdDxKeupxsvqXZ5L35NpfulDrv5TwhuxEV1jN1w=;
        b=JQSjgti/r7jU+WIk4smaWkBESjkcXnhOMhcHqndNqV+pUI+gmV/swSHLTLisx8xvg7
         MSfh8F5cojRM+TCzPq4pgfsrIjiBib8cv+NK3U4ThyvAXXi41u3/Evbm4kcxXXbwQnVo
         NS3NBwoNybumVkfyjt2TNNANNA/rUEOLEDZEJmfDlKeXN5i/jYpevswlCmcTi5AeTeCl
         CH9GgNgBSM1pp7BvWavRnRVXP0OAr11qjcAH54j+x8W4CMv4WMHVYBFZvEB/HP2oTA9Q
         38kv8qxrY786+dL4Ws+G/m1+TGnzm6uSVX5SIO++fw+8mm2P9H+57sOI5/H2ob/fgUkz
         zckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ju4FdDxKeupxsvqXZ5L35NpfulDrv5TwhuxEV1jN1w=;
        b=Y1j3K18cGxv1ybnfiMKzbGnfMo4JSnAUo5TB8hl9YNtYw64xlycSP1m9fxkufxZNnc
         UzJBwXKXf/7tQP6ZJ/hZWSC4oYZOxR9y8q2oRxylR4hhy+3uR5zuaoflCjIu2yWmoAaF
         tcE+nE2m1SoGjs+MCnsskqTqw9rmDep/8MMYVElbrjgfEHWul8LnHU6H800UGhmF0gOl
         jqVS3apZyacQFwLY/zWsO8l/dmh9mDqt5jShfFZ2tvpyKLy0zUZVKABzsffzcc/eUA53
         Ze1H0xZ+oKvmKZVSRGpFiU1W68ymChWaattAQn6WqoHtkbq9ieERvD2dCNtRPORQz3VN
         72ww==
X-Gm-Message-State: AOAM531jOeM5S0IIqkFSQNVCzPHIAu3D3Ik50qy2JOZSUrLSpRjaoyLU
        dZbuIvJ9ezwYDmG4XbAL+oOlHoTZjXnFLaQrZ8tr6jXeeog=
X-Google-Smtp-Source: ABdhPJzStUrpguO+PBbo8xyJG9VHVWSiDGZsLi1RJWVkaVn7fWA3k08WteQwAsSEmqhYemwIGMD0YpNsH1iotykM0s0=
X-Received: by 2002:a05:6402:34f:: with SMTP id r15mr3469367edw.111.1634166938494;
 Wed, 13 Oct 2021 16:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <20211008122454.617556-1-fabien.dessenne@foss.st.com>
In-Reply-To: <20211008122454.617556-1-fabien.dessenne@foss.st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Oct 2021 01:15:27 +0200
Message-ID: <CACRpkdayzVCz5jDneoPWtM+t0CrJ_bY53BWUa0axNu5i66NH+A@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: stm32: do not warn when 'st,package' is absent
To:     Fabien Dessenne <fabien.dessenne@foss.st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 8, 2021 at 2:25 PM Fabien Dessenne
<fabien.dessenne@foss.st.com> wrote:

> Since the 'st,package' property is optional, outputting the "No package
> detected" warning-level log when the property is absent is unsuitable.
> Remove that log.
>
> Signed-off-by: Fabien Dessenne <fabien.dessenne@foss.st.com>

Patch applied.

Yours,
Linus Walleij
