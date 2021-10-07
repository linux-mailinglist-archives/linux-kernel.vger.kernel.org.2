Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C75842552D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 16:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242011AbhJGOTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 10:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241774AbhJGOTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 10:19:18 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB533C061570;
        Thu,  7 Oct 2021 07:17:24 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id l22so4481703vsq.9;
        Thu, 07 Oct 2021 07:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kUGVALwRFhn7djzeqRAdJzo6PRnh+KyG51uBsyXq45A=;
        b=jaqZE5e8m5DWhlR6wa0Cu5GO/KwD5ezq5Wetl77u6k/WSOF+OIFZtB5X06sEoc/eBU
         8jklJ6331LWgdBOdJ6ihpU9/FMM2ZIpG2j/sWpwks0Wn/IECHVu5gG7X16EzoLjOm7w3
         N+o5falri+AAh5u6BgfRcJZ0YB1LosYX06v+s1AxINyXGelKYk5oq0dEKjbR7oPe0n+2
         92p0oBQfgaE5sxepI3+b44MvB3eWWdaOiZZRW56ZP8FeJvqmkGkwO1BWZHHbbXESmD8Y
         /0KUaIecdq094kwDftzR3TakbNORF3+uj2teSr3f1VisoLVcnNbCqUofoFmwFRPPBxdA
         gi3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kUGVALwRFhn7djzeqRAdJzo6PRnh+KyG51uBsyXq45A=;
        b=F5REJmo58NLyuEhGEpL5HRjaFR+qFw38Xw4w9nXUNSjaDBCG3NfigYL0Nn8WsGUT/4
         SYGbuc1byec8+LwDuyBSrY4zqocz42bXA2tOnRRbOwFg2/aqJYeR0HH2Khkz+aHqK3nz
         7WMyxn/Jq5zbacJ9M8oMw4MDtfPgrx7mwefifd3UHa45NEZFzn6Mfi5NToEkRzsrCHUj
         0cCnP9eWXiHhrfaWIr5wNpHUke0R9Bt9+hsHX0crmIuWhVyxxIp3cnH4xqQM8vfoa1n/
         3hRLoaUN7yAXLK3tisrGgtcYE4aT6Bl7P3qh1Nf56/e/flo/z4gpTptYBGjDoSJBuiqg
         97JQ==
X-Gm-Message-State: AOAM532HNH/Bc5Ppmn83sk0pNEQF4qetsAh7R+zTHB3Nz/kmfZiPBAqq
        RK9hLZWZGSIbI1MX4g4+83pCFwX3Xg0m8teTeWg=
X-Google-Smtp-Source: ABdhPJzrlMX1yIMDFSH8vgdQa1Pg7/P42ZfgGs4XlQGy4rm89w8A0r0fc4mDtnH0qIc6gQmuA0mreZCaV1wjaWgjklw=
X-Received: by 2002:a05:6102:3e84:: with SMTP id m4mr2588359vsv.51.1633616244112;
 Thu, 07 Oct 2021 07:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211007135635.2717-1-semen.protsenko@linaro.org>
In-Reply-To: <20211007135635.2717-1-semen.protsenko@linaro.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 7 Oct 2021 11:17:13 -0300
Message-ID: <CAOMZO5DNF8pO__+Yjn32KEXDG_rq7LoOt=aKrsBz8gPfuxUxPw@mail.gmail.com>
Subject: Re: [PATCH v3] clk: Add clk_set_parent debugfs node
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mike Tipton <mdtipton@codeaurora.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On Thu, Oct 7, 2021 at 10:57 AM Sam Protsenko
<semen.protsenko@linaro.org> wrote:
>
> Useful for testing mux clocks. One can write the index of the parent to
> set into clk_parent node, starting from 0. Example
>
>     # cd /sys/kernel/debug/clk/mout_peri_bus
>     # cat clk_possible_parrents

s/clk_possible_parrents/clk_possible_parents
