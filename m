Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5733D3837
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 11:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhGWJS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 05:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbhGWJS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 05:18:57 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A637EC061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 02:59:30 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bp1so1190992lfb.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 02:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SpdYc3xSgtWajYNjziQJhjZECPeeHzOqtqZRcb4yQqc=;
        b=J4vXy3PkMvHxHdXmu8xSRDtPSWRGZj4bvC9RE+NDkeFb/PTCBojquyjxYoZngKBukS
         StiIvPkV6z3a4W0B8hsOOpPd56wDC4/LyODf5o51sUjkXGS3ucbtUeYTkr94FeLsZI9I
         d/R2VLKwJQK3bJWZQLXJSN6SLC9IZL6xwfLqxpqKB27esWapnkfxI/ZewCl9USmE1DTo
         kZb5/7oUS8YBZG820r03EGq5+fhpw5hGyE/Qt+x4QpGZ5MjPKM/SHl6GNiSaYRBBDAWC
         bljyLdTixfD+4zsprywxA0yyv73D4hssAtXXAZHB7zNeFMXzeqagJqMleKxY2ih80i8M
         7oiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SpdYc3xSgtWajYNjziQJhjZECPeeHzOqtqZRcb4yQqc=;
        b=AjtUsmDgYGMk+1HQq1Z2eGt/wjqqBWzgP9M1T6NR4f7ZLjOqSLtZw2Tfamm8OhMOEi
         xuo8hikyBHlNHVBx3xIqCnHQMCHMtNWMPmr63FUt6xScWciwQq7XipPsiqWmE1rocs65
         HoyMToalRPY4yWnDqFBL1vauSx4Q30PdGgC4uYw33rW9S2118mYDFbBGwOeDG3CVbxEB
         HaN1CFF0ClIw2Mu69BXbm6aXRg/wmaXs0PAq1SlCeK3t/sTVYshqvhTx01IHvJ3LJ6gB
         yIAIUEWaUT2UfGjKBErAPChCd97rcE+IinwyFdDNr4DvqfKvS0XgubgwBxOfzFubBCQ8
         xT4Q==
X-Gm-Message-State: AOAM530kR7Q3gqnyV00F3hnZmoy/2cy9EAc0k8VfbGF67etHRQAwNUfK
        cmOhpu6cG/tIXwUpAo8KUC+8ElYEZl1ODus+rqAGwQ==
X-Google-Smtp-Source: ABdhPJx7muHNH1C+xeS6T8GmAgw9HYxGXW+SzTbL9t3ZL9EWXY9r5EfsyJ1gcQxXWpZrxgEPKQxHcPJfogHCjHnb5R4=
X-Received: by 2002:a05:6512:3f1f:: with SMTP id y31mr2589495lfa.29.1627034369078;
 Fri, 23 Jul 2021 02:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210712100317.23298-1-steven_lee@aspeedtech.com> <20210712100317.23298-8-steven_lee@aspeedtech.com>
In-Reply-To: <20210712100317.23298-8-steven_lee@aspeedtech.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 23 Jul 2021 11:59:18 +0200
Message-ID: <CACRpkdZh1TW32bqb91+g8OWkXBVDt0vsoObJ6GCX3LL+86_daQ@mail.gmail.com>
Subject: Re: [PATCH v6 7/9] gpio: gpio-aspeed-sgpio: Move irq_chip to
 aspeed-sgpio struct
To:     Steven Lee <steven_lee@aspeedtech.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>,
        Hongwei Zhang <Hongweiz@ami.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 12:04 PM Steven Lee <steven_lee@aspeedtech.com> wrote:

> The current design initializes irq->chip from a global irqchip struct,
> which causes multiple sgpio devices use the same irq_chip.
> The patch moves irq_chip to aspeed_sgpio struct for initializing
> irq_chip from their private gpio struct.
>
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
