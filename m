Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7E13E08B1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 21:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237734AbhHDTWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 15:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbhHDTV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 15:21:57 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3046C061799
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 12:21:43 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id m18so3828399ljo.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 12:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ylI9MXOs0Ir8PA1SSc4CWBUvb8oJBzOcDwis/U9YFVQ=;
        b=X4MpP5DhkCDW/CMWbe1IZxRUGYUWQeM73N+vdca9xUIdVP0Y5juQKu4iNsxYX7MmYc
         JP/2XHO+BXYeXnmy4snp3Sgoybts38cc2zI1AZdTx4O+7fyJ+i10Wtk2tIdasaLHK5SN
         3sXBSXl91LZBjaq6Qv94le6sGurixI8Q1rHrorSjBI9bpPKk8hi4VVzHodPGrwexNnR3
         Z9r4ihvDqWCMN/5NVPwiO0sB0VMZr6TlFT28No4CBfFnIo+WigR5oqKhPriocCvF0vM9
         VvCamXc5yyY0MHzbn4YWbAVobGBuLT+VGZ9nCm3c3tTN9+hIy/xpH5aw4lLAIkQODV2W
         rXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ylI9MXOs0Ir8PA1SSc4CWBUvb8oJBzOcDwis/U9YFVQ=;
        b=ZQHbVaafqUuqL18wAotVOy0mgqo0Iyh5pwShHWo4PnOeAtPPAS6Py8sKH45nwh6uQ1
         Pxu1ChN/G1kk0Liin8Ji6alsnqtnKmNmxshGL7AtM7ggdyOyLDGJ59c4me5u6wOPHENT
         E5GdyFm18pfreBc0QllqHrGuoHhf4fd6vb0owvs/7wWykAjZUH6ZNq0HKONbAvGtaA3Z
         Xk1cW7OC1fE296gl7yVh+MpO18XCFmxUoPJQDUxzHevHLlHPLAl4rU5IjcegOn1EVurx
         WTFX/7iBUSgOAbQiq1N4kO04TQ8aTXBRbjhCLJjwE93Ucb4wn4zwmTJxpr7+5XPG9hbA
         gaaw==
X-Gm-Message-State: AOAM531JkSCITTy+2Q1EO6Hn+SSnBf2Vny9260USctZedvCmt26KFXuk
        aVy7mWZWNBh2hkXKuNSVjC9xLPk6+M3cU3gj5LHBPA==
X-Google-Smtp-Source: ABdhPJxSA1V/rjr6BECMCBkSMvqgdG8Yhf5F4dByLuR2eLus55oS/5YtDzd9iMRxhd9NtXjxhgFa/N8SglbWP5DUc2A=
X-Received: by 2002:a2e:888f:: with SMTP id k15mr609374lji.326.1628104901981;
 Wed, 04 Aug 2021 12:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210726142943.27008-1-lukas.bulwahn@gmail.com> <20210726142943.27008-5-lukas.bulwahn@gmail.com>
In-Reply-To: <20210726142943.27008-5-lukas.bulwahn@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 4 Aug 2021 21:21:30 +0200
Message-ID: <CACRpkdYH=rQEK0sRU8DueUbvffe8DhKdH_nu7u4Pnk3MaBNmig@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] MAINTAINERS: rectify entries with
 documentation-file-ref check
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Yu Chen <chenyu56@huawei.com>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Deepak Saxena <dsaxena@plexity.net>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Joe Perches <joe@perches.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 4:30 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> A number of file entries can be automatically repaired with
> ./scripts/documentation-file-ref-check --fix.
>
> The changes from this script were manually cross-checked for sanity.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Thanks for fixing!
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
