Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF4B37541A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 14:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbhEFMvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 08:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhEFMv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 08:51:29 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CAAC06138C
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 05:50:30 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id j10so7564419lfb.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 05:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Ih4+p3zLbJgKbtyGHTBqIMZl1xrskHK8H9INh+Uv4Q=;
        b=tOVCF1VosorbmnojI82fLeeHSIKUGSQH/nyYU/9ksMYfnCNNk2WPdG6ay/mpoSJmoM
         LshYTzx//dMlid0bY/5z0+7Z7hG/1nZGsU1JgTerosNm2lPILJiPmxtQyBHTAK5K+1AU
         A74pBMjCDOnEpS6zXJLq5N9YkF6B4uk790O6cby6esqWbZS2qIihy0rgkg/oL8j5lk9E
         SERTcIDzkqSXuDPFC1z5cLQLpQYjgreb5Q4En7GoRGdQ4UnUpdKrZ8nmYj5yD6QA+fRQ
         lfATfeTiCPEZnx7QJrwGjflZxs9eOb4FVSEGGuxPImV0SOsOayxsGZAL81ftjfobmfUy
         LRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Ih4+p3zLbJgKbtyGHTBqIMZl1xrskHK8H9INh+Uv4Q=;
        b=If7X8ROIJ6+msS8gWiJ5D65efpGWrsE4UohqyRDwavywHaDOuM7Td0EwUe9BvVMloo
         TvOstdAeKUu7OJr5P+nkm2RsZZx+GpTME3tF9A0LciW3oMmObyAFO8OeoQrNUbM5J2tA
         EFx1nmUO976j4QX0+stSAcEXYiauBCj3XAswWjIrWlhiBp3bvdka+oRQDoRgyzXgBcvq
         Ng/TpsLhyiyXyQNtMf+/aKxnGdMIyCqg1a7xgvI3k/cj1SOfd+TyiRv1d1PHPQWhwO0u
         3Lp8RfpImlTYRoN/KjUNZDJznzNwgSuw4svvnLyZ/IIBMyhaEebeePFa7lKAi0EmOLbQ
         HlNg==
X-Gm-Message-State: AOAM532CuSFRC7en8IWP5JdKe538kjf9PvhqGg49i9/cFMki+eze6iY1
        KufDhlCmJq/DHv6/7xiXUDI6+l79z7h678ynGEcDQA==
X-Google-Smtp-Source: ABdhPJzE0Z+zj23Q02inSzPqU6dizoYqkz7PVA6JO3I+kCwKxDGAnYJLv5iu6gj3sJSx5oylXPN9Gz/3NPn+3xWHDF8=
X-Received: by 2002:a19:a418:: with SMTP id q24mr2665011lfc.649.1620305428769;
 Thu, 06 May 2021 05:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210504161222.101536-1-ulf.hansson@linaro.org> <20210504161222.101536-2-ulf.hansson@linaro.org>
In-Reply-To: <20210504161222.101536-2-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 May 2021 14:50:17 +0200
Message-ID: <CACRpkdYbsfVDrTpMa6P8uia0McQD2KhSKQVA-jh84ZPwBS3C6Q@mail.gmail.com>
Subject: Re: [PATCH 01/11] mmc: core: Drop open coding when preparing commands
 with busy signaling
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 4, 2021 at 6:12 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:

> Similar code for validating the host->max_busy_timeout towards the current
> command's busy timeout, exists in mmc_do_erase(), mmc_sleep() and
> __mmc_switch(). Let's move the common code into a helper function.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

This is a really nice refactoring in its own right.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
