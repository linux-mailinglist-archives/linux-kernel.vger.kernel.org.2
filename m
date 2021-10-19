Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68785432E8F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 08:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbhJSGt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 02:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbhJSGt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 02:49:56 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8950EC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 23:47:43 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x27so5128729lfa.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 23:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rIzFACJIOpTQkxZxEQoVxUHikCOaXX5FiqyLZ4CJEJI=;
        b=D533wtAg6MrSlzGb2m0tVWHI61UjUFYeOl1HPbpj5hqt3RLRUDWWVtApHy4D2J+aP1
         ONelR9FGEn/13NL+fiJ81oINAfFU+CApUep3dA+zOEupFG/7rtNmr/hhqV3eEoYVtY4l
         8wrGa2U67U/szUjNrL1ozs8VcSahMon2mGPio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rIzFACJIOpTQkxZxEQoVxUHikCOaXX5FiqyLZ4CJEJI=;
        b=WcrilVMeQJgivtPzieJL+nHT9Ma7yWFCXeomYP4fBG2YMTBsgqGa/HqO1Z77BtHwsH
         g1dLirJ1nnTKSiZ675Bue0p81CbG8HVMck/PdCJJmP4NPSipVo3/f46JNeYW1WZMEiSD
         9Eq8dMUQM996rWxoD38obW/ZqeYxqCZDJsk8kzOojWV8Gj6igrLvS64LQAzyaINhhcGy
         9ICTYribJv6/tviLJlhJP9fGb5TzqI3yQCaarVCLT670kd0sY+amamszfAtBpo5GOhhh
         qjMb5utetlp5sutJsOjqSt4ei0AnZUSDmTjkiCrTYlsjiqvNlVnw0LUyYY+2SX0KOS57
         fg7A==
X-Gm-Message-State: AOAM530jQVLy4XlAaMJ2pgVPaeJ2LBrXnL7A30cXrdfGOkIIno3XlPjO
        jz7zMeUtVtrUSEJJA9txXFjQrKTEXiEeQS2yMTwdAw==
X-Google-Smtp-Source: ABdhPJycbpCqB76HftgbC5KmrjMQOESzRPPGqSgE0BVuqBTQdyZiIcpoDSVMLlxtC7lx8QtzCJJIrO4vxxahverRcLE=
X-Received: by 2002:ac2:4e07:: with SMTP id e7mr4491623lfr.308.1634626061968;
 Mon, 18 Oct 2021 23:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <20211019062939.979660-1-ran.jianping@zte.com.cn>
In-Reply-To: <20211019062939.979660-1-ran.jianping@zte.com.cn>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 19 Oct 2021 14:47:31 +0800
Message-ID: <CAGXv+5Ex-R-LQZJhT_nDwntPjCE72OKS3YNSp+no_0xYkFbDEg@mail.gmail.com>
Subject: Re: [PATCH v2 clk:mediatek] clk:mediatek: remove duplicate include in clk-mt8195-imp_iic_wrap.c
To:     cgel.zte@gmail.com
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        ran.jianping@zte.com.cn, linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 2:29 PM <cgel.zte@gmail.com> wrote:
>
> From: Ran Jianping <ran.jianping@zte.com.cn>
>
> 'dt-bindings/clock/mt8195-clk.h' included in
> '/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c' is duplicated.It is
> also included on the 13 line.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Ran Jianping <ran.jianping@zte.com.cn>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
