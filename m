Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20DB938D20B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 01:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbhEUXlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 19:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhEUXlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 19:41:07 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD610C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 16:39:42 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id w15so25855752ljo.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 16:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NsEYV15WJxVPhF1qW2qRsDL8347kj9miuk7JSi+TA4s=;
        b=JlAxBcIhbeZBbdKctXu5+zydEdmu6ICFB4/jglKltcG+VQnqGjHihUu0djnOokpFhD
         ZyREKqJ4/MwNfCc1lRXrjyTJ2pDyDG+8Qsa5ZQcgknDTzy5F/eIWqgVMFVVdLcH4MeNP
         IfTOB3P0yZfaDcc3qZaW/BjADD+dqhBXu0bzYDC1yOQ+xB1IvV36ngoXREF40teQMKj/
         nL56siSHLSg8DQ4XEm+Dr/+Js5J5JZQ1Uviot3slasoyrAp9k2Ra20EdsRlJwryE7WTP
         iVmkIsu3+EqBQHvWSpj0fH1Hi2NRP5zVZfz2bF+TudRg9Imd9Ry4DXnAX/Zy7hmLxEoI
         jqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NsEYV15WJxVPhF1qW2qRsDL8347kj9miuk7JSi+TA4s=;
        b=TBDQTo3pYPpVa6NmqWDmhkYRT3RjXCAsdWuAHKFSdwMcjNjJJssUUr+/8Ex4LnFdeM
         CAr3V7vw0mK4ivMhur2gSaKzLgTimYmXtzlJhbQpTsvXshgSCoIlkkdY5dmmXI/KSJFd
         iBX4fZ7rGGeHykpawR0TWbPVPcFs2XTS34pssrXIUSM4f7BdMyqqpLOrYZ4HIZL4a32y
         2OhDiQie52U52uwl9Y89w+xphhqxENNbaQR6jwiJFxyu/y2DhYv1tGO/reWQAxYrO24c
         lBLGwHn3EnUQTs4L3ZljRb9SKqJi4zoiuFYppZf+nS1/KTYITUrdxcQIY6bgvPAM3bjP
         bQRA==
X-Gm-Message-State: AOAM5320AF87epGK7he2DBMYIJD8zrokT1tSIkSe77p+ToRGhVBXIgCy
        EQ3+YGg35LC3hx+KmsbeQxntEvDO5HUX8gnUXQnA1Wh96Lg=
X-Google-Smtp-Source: ABdhPJyk6mAbNkK9lDoe2gUdi8CH/jRd0If067NLN7Kj824I9z0GAEBuI5mjukyJKcSbryJVnm5M3CVOWAuSseAN+As=
X-Received: by 2002:a2e:81d0:: with SMTP id s16mr8947923ljg.74.1621640380923;
 Fri, 21 May 2021 16:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210521193540.16164-1-clabbe@baylibre.com>
In-Reply-To: <20210521193540.16164-1-clabbe@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 22 May 2021 01:39:28 +0200
Message-ID: <CACRpkdYvp0AOuMrMN7ph9DxCErh5eW8QtNyzodGgaAa+otCPdg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: gemini-dlink-dns-313: rename gpio-i2c to i2c
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 9:35 PM Corentin Labbe <clabbe@baylibre.com> wrote:

> This fixes dtcheck warning:
> arch/arm/boot/dts/gemini-dlink-dns-313.dt.yaml: gpio-i2c: $nodename:0: 'gpio-i2c' does not match '^i2c(@.*)?'
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Patch applied!

Yours,
Linus Walleij
