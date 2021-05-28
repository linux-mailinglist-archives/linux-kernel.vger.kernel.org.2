Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6025393ACA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 02:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbhE1A62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 20:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbhE1A60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 20:58:26 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE5EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 17:56:52 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id e2so3178165ljk.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 17:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DUgWyOBumw89BDGTv+7X0vdxC7JeU7hCOGrHDiF3VwA=;
        b=BSasaDEaLbIQAzgG1IrhjeTDlHWhNMV9Ajsb72ajXQiKtkmoo4OTX4hdRx/jXFe9lH
         tbpf5Q0hHvwAIkDrX9OnHynDLd5s3Z8+XSnnH9qvkAU+4yOVYyktN0m7fkRoIYnaKRJI
         KzTWxxz9q0+1x/GVWp4Ig53vqH1huvR/cHjdqejfapdGaWwwTqiQBp+UcbEePxYlH1Q7
         5HKEuJkjGfUtGLrS5Op63iNk/NqiKbWZCre1sDGHMWpCpHklhAmDjllKZkwlHQET1k6q
         s6FJeU6fp7L/1WlQtCon2B5zwcVnrrMiEzrrdnVw0Huk5FIfYZB92UnJPC3M6oIqBg2K
         CngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DUgWyOBumw89BDGTv+7X0vdxC7JeU7hCOGrHDiF3VwA=;
        b=KAx+7EuCsoeBymzpu2ANwYe/Z7TgqkJdqQ0sDq3RiKtB3/6GiX1xqVwZUQAnpaF1QL
         ZALi8dzM8sMTzbesb51gfSz4EKaOHKGKDGrkWR3FoiuZZCtcUB+hFvZEogHcc3YaznZA
         bKgYKxLoZ87KBNO79ZFijSKpI3yPdDx3nbfZZ3MqGjxzUC5UtIMYeTbTAM57M1W532MX
         sBmaS9Kid74IfK1BN6LOkZZZZ3pcjARBV0jTW18e4nNjh6LrbnilWJiIX+PhGnhPt0Ng
         xgD+8AQrn79TxpAt5UQxz+Gn/EUYnSOPfpHXLWQsxspzj85IosWKFse0m5ts2d+JyCXD
         oZiw==
X-Gm-Message-State: AOAM530ZQHFw7r8iGUBas16VVAbHqWyNn8KaVPb99d3KeN1wHFUWiLeH
        mDqX3o92DMiL6mGcKOlnemxkvfpnh6BUWix8jRHXoQ==
X-Google-Smtp-Source: ABdhPJwkOKyubRtDMGrbWIPiVD0SnCCFb04nXbS/cSkd+iam3V+/E9XBgUnCx6hyWBnbMftdQo+GIHXCWBc3bzLiQGM=
X-Received: by 2002:a05:651c:1049:: with SMTP id x9mr4489456ljm.467.1622163410555;
 Thu, 27 May 2021 17:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210521090158.26932-1-iivanov@suse.de>
In-Reply-To: <20210521090158.26932-1-iivanov@suse.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 May 2021 02:56:39 +0200
Message-ID: <CACRpkdYW9KCOOH_FjuPR6o4x41DvSgfmLOw201tssjAOt7q6vw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: bcm2835: Accept fewer than expected IRQs
To:     "Ivan T. Ivanov" <iivanov@suse.de>
Cc:     Phil Elwell <phil@raspberrypi.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 11:02 AM Ivan T. Ivanov <iivanov@suse.de> wrote:

> From: Phil Elwell <phil@raspberrypi.com>
>
> The downstream .dts files only request two GPIO IRQs. Truncate the
> array of parent IRQs when irq_of_parse_and_map returns 0.
>
> Signed-off-by: Phil Elwell <phil@raspberrypi.com>
> Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>

Patch applied.

Yours,
Linus Walleij
