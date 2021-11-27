Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6101945FC22
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 03:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348522AbhK0CoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 21:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhK0CmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 21:42:05 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F6BC09B079
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 17:38:02 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso16257027otj.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 17:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/qy2fVsf4IGu5lXH6K0cKVvkPysB8kLgQcCvFksozo8=;
        b=zZRP5+zdTlaagOcbSDxdZ8PuDDuUy/L7LJO3ttHZgQKDlJZE15kNsEiERS21axDcsC
         LUccGVJA9lb+7+bYI5T26Wcb0epFTa0M1Nx7WJgiB79+Z+psUQFoEeivKe2Bfll4f7Ei
         kGlgsOtT3+8TXnqwDPZjqH7LzRmyLYemCBZe+O+KhCaiEkZ9Y2U1l7ffKXknVZqlwtwQ
         FYg8gLxqYn+eSuaag/GfU7zEZfVgmhRyor0e+o0IH9sqXJffV6Ku+SSRsgZJPeXC3Zdk
         hSJzuzKj1vhJCythfVssJF0MTrJMICurmBvllcMeH3K37r+MWPcIZuEYhUMft9+VL7Ul
         wajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/qy2fVsf4IGu5lXH6K0cKVvkPysB8kLgQcCvFksozo8=;
        b=KMsMwrp0nR/cZBrk4oWuaN7B1aJ0qpBn06NkDWSamU2rkMo1JG084ztcMpLbQXtOEO
         B+r1EDQovfngBn68NJZCosrGQGl4nB21fgF1hSZGEeaqvdIQqfoGsUxa/9wBMA8L4445
         38j+JMsoXeL6CHzbXvcJB6OhZujkjKThSYIapOVmx+GcIj7BgDlSnHwkxzdkJX9w150X
         uWLBTCCLZ3ius2eZb4zEEICR00DAxdSEA15YxKgKMPntIRtMcs6tQljdYR78Juq78fBn
         2mBMIP8gimC1rJSxwdYUjMOIjZGG+DxtIXWL2D4mFZjba4G0r2J+AWFx80ybPVyncPn2
         AJjA==
X-Gm-Message-State: AOAM532bz2kpve2QVdHsImMJTA7CnS+xeMaXwT8I6v5/ZowPwk7cWRSB
        o3dc+KdbtKgqtbCMq+QUcN8fX9vfKFL7Sghed8In6A==
X-Google-Smtp-Source: ABdhPJwz7YlhjlehvhsdllSAlratkmK3DP53zBfQyCzOUts83RiuSgVdEJlFvaYiY3fJrk8VgZ7a0E75/laPJ89l+QE=
X-Received: by 2002:a9d:74d0:: with SMTP id a16mr30440684otl.237.1637977081591;
 Fri, 26 Nov 2021 17:38:01 -0800 (PST)
MIME-Version: 1.0
References: <CACRpkdau+wHpoWa1JrLt35dnCHJejs8HZkkzZCrrcnRCx3SinQ@mail.gmail.com>
 <20211126163657.65471-1-dominikkobinski314@gmail.com>
In-Reply-To: <20211126163657.65471-1-dominikkobinski314@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 27 Nov 2021 02:37:50 +0100
Message-ID: <CACRpkdYdOvpS0GgHw9UfMrfnUeEphKUk-y-0vKYSsS9dWc3r3g@mail.gmail.com>
Subject: Re: [PATCH v2,1/5] pinctrl: qcom: spmi-gpio: Add pm8226 compatibility
To:     Dominik Kobinski <dominikkobinski314@gmail.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        ivo.ivanov.ivanov1@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dominik Kobinski <dkobinski314@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 5:37 PM Dominik Kobinski
<dominikkobinski314@gmail.com> wrote:

> From: Dominik Kobinski <dkobinski314@gmail.com>
>
> Thank you for applying the patch. I believe the second one in this series (https://patchwork.kernel.org/project/linux-arm-msm/patch/20211125215626.62447-1-dominikkobinski314@gmail.com/) should be also applied to the pinctrl tree.

Looks like the regulator tree should take this one?
It is a regulator binding...

Yours,
Linus Walleij
