Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E6C318394
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 03:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhBKC3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 21:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhBKC3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 21:29:31 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2913C061786
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 18:28:51 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id v19so1925037qvl.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 18:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v/JR6cxBec2OO4AyQr8LqOFJlkaTALkaG4hkaa3+jH0=;
        b=tmRca4PB2kps0fAMgBJNaTQMArARvSx/SfChzgUdm89r1VOxPYGtgjUqVJbGvABQBi
         b1p0l2nSh7eJd4bBjJyqeqxxzLEQMSvO8U2c8yeds2A1CQZbqXlsRAzJKmGHJukytAFJ
         m/GJu+/zc7xAK2nEL38pW+FCnNngPCIIy0dc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v/JR6cxBec2OO4AyQr8LqOFJlkaTALkaG4hkaa3+jH0=;
        b=ZLo41lTagGGh7Zfm8lh8eC68S8k5tBBxB3Xa0+/cpq5bCDVcT3YwnSK1YQ8QdvcGMq
         OMGW6vpxMbyaGwXSBZzsIn+EVP+F5HMO9SMwLLpbc9iDBO6/0ScXuqIpSMZOtzso+LrI
         Fju1Ysqht6R2bZBonN3SDZ+9pf64f4UQQw5ECWnToRQbF4cd5CYTK1/SPB8g0E2LuEVe
         7Ivi9VPFyv4JAqadVfhCXOXyQ3wO9t5pLDwOVVk/+t8GxJdIFnuIwDXyOicqZ5OZtMh6
         jVgFkRXO/VOBNczgvmD8c6giWlGFNzTK+8DYDov3ji+9uGMA4ORosMA4LiINNQ2hBIY2
         eAww==
X-Gm-Message-State: AOAM530i+tT5R0t6aeuKpjE5a49tQNSU5Yc3VwEfVnLdgk/XSMMLghqj
        M1RkMkWhzoz76hm6j9VXjDgEg2iZan5IT9NXtGsD4SLEs92znA==
X-Google-Smtp-Source: ABdhPJwx4HM5jl8YL/e1RHuGN3F2Bjd7U1tHpztED7tcsPkI5wXPP1SMXIcnSHppZZwsNvyRd5ps9xcpcH8nuzQqmAQ=
X-Received: by 2002:a0c:ec83:: with SMTP id u3mr5631558qvo.55.1613010530875;
 Wed, 10 Feb 2021 18:28:50 -0800 (PST)
MIME-Version: 1.0
References: <20201114135044.724385-1-daniel@0x0f.com> <20201114135044.724385-3-daniel@0x0f.com>
 <160843556037.1580929.13575770228476494246@swboyd.mtv.corp.google.com>
 <CAFr9PX=f=HyHBk4s3e_vnMDC53R1X18m7sKFCLMMjitPm+8oEQ@mail.gmail.com>
 <160848984935.1580929.936824086681978646@swboyd.mtv.corp.google.com>
 <CAFr9PX=oLqQqvykiwOGAGg1H2CG0BTEqn0TuSrijodjxY52LxQ@mail.gmail.com> <161292417080.418021.13416197091150418216@swboyd.mtv.corp.google.com>
In-Reply-To: <161292417080.418021.13416197091150418216@swboyd.mtv.corp.google.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Thu, 11 Feb 2021 11:28:40 +0900
Message-ID: <CAFr9PXkGeFUyGCKZgYF+0uJT1ywad42RvPg39ggO8WRngY8uWw@mail.gmail.com>
Subject: Re: [PATCH 2/6] dt-bindings: clk: mstar msc313 mpll binding description
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     DTML <devicetree@vger.kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Wed, 10 Feb 2021 at 11:29, Stephen Boyd <sboyd@kernel.org> wrote:
> The child clks should be using clk_parent_data to point to the parent
> clks through DT. That way the name of the clk doesn't matter except for
> debug purposes.

I think I get it now. I was using of_clk_parent_fill() to get the
parent clocks sourced
from the mpll but I seems like I should be filling out an array of
struct clk_parent_data
with the indices of the parents and using
clk_register_composite_pdata() etc instead.

Thanks!

Daniel
