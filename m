Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954F542F589
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 16:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240399AbhJOOhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 10:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240417AbhJOOhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 10:37:34 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C068C06176A
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 07:35:27 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id j8so18386597uak.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 07:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dyzl3P7DZRGqshOKvxCFF4c9hztnCOx9dCdEwf3z48o=;
        b=fCA1/Mx8Wx4HD26C2GobDtiFNBVWxx8Apth/0bJpJefFV7OQ5MrVIPgRMBNyaL9Byd
         rxFQKH2tLsYFV/Hc2JnK5uXbTVoRCAtzQk5nKO5QKqo8d68U6SJALbtbTNT/ttOB8IjN
         AErQmd4AFqCMtvXRkJ0Lqr0+ijfzJvtNHUd5vr4lSFwT15xLYCuzYa3Y2T7uw/a75y4R
         fIAGEKLQWswk6amv4HFks4L5FKoiqjWSJJdWERS3RMYIRmkopRHqsnWvsKEVvCXHQdpi
         aemyj4+A/h1bLfcxYClQ9XvarVa+TBIPiqeGDXkZvB8cYOwJLiWlLOwfwfA1LbccB2In
         Tr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dyzl3P7DZRGqshOKvxCFF4c9hztnCOx9dCdEwf3z48o=;
        b=eplACK75HE57hecaWudMze2OroNb3hGzTVbHckW0lZ6MXDrzPrdXbEB4QLmT0Pl7q7
         BJ0zgYoqUpVUyztBGekuTPyZBzOTDozRWXry/f4TNAhPRTKn05jZUo+l7d0PpaLSmap4
         nyRjJbjgPVfkKzdKxZthiPx9VyT8OQGkdhx0HFmuVXMafEihI34EIfXbEhGzou77p2Ww
         nkD8+XGpV9ONpq4bIfdJzXuuGlV3HpuTDDELBdwHoKA8v0X+CtNT9S7Ms3sS+GUCFzQe
         XVWP32Id3biPoiz03+Qbv7h14FT3Yo2zZv+/rLK8nompwPwT7hrF7paiv3pnZoB4sqID
         uQAQ==
X-Gm-Message-State: AOAM532LUcNvQbMDJYdme8UVGwYgH3BiTjOTu+sTGUV8zD1i7O8oMBbh
        PKXwxdZBi/vnRdZbbC4bgkAumKmdmx2tDQLldMULmA==
X-Google-Smtp-Source: ABdhPJw1G6RrMl0a+Cbkl9++iuc5F7VDW14l2hO3UQMme2WeLYVa/Brsyt2UcPIYPAS9JbdJyMVvqad8L7w4GXy58g4=
X-Received: by 2002:a67:ab48:: with SMTP id k8mr14401258vsh.30.1634308526705;
 Fri, 15 Oct 2021 07:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <20211008154352.19519-1-semen.protsenko@linaro.org>
 <20211008154352.19519-6-semen.protsenko@linaro.org> <CAPLW+4n41GY_OszS=VgzgywVrD+epY1NTmwL1ghHZ=0DCYcbYQ@mail.gmail.com>
 <a98f7f83-8478-aa38-7699-0a5dce44616d@kernel.org>
In-Reply-To: <a98f7f83-8478-aa38-7699-0a5dce44616d@kernel.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Fri, 15 Oct 2021 17:35:15 +0300
Message-ID: <CAPLW+4kXbon+m_px-CuqUqdYTJE0V=bMxqqzyLSn37Lr=nAU7g@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] clk: samsung: Introduce Exynos850 clock driver
To:     Sylwester Nawrocki <snawrocki@kernel.org>
Cc:     Ryu Euiyoul <ryu.real@samsung.com>, Tom Gall <tom.gall@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2021 at 16:30, Sylwester Nawrocki <snawrocki@kernel.org> wrote:
>
> Hi Sam,
>
> On 12.10.2021 10:14, Sam Protsenko wrote:
> > Hi Sylwester,
> >
> > On Fri, 8 Oct 2021 at 18:44, Sam Protsenko<semen.protsenko@linaro.org>  wrote:
> >> This is the initial implementation adding only basic clocks like UART,
> >> MMC, I2C and corresponding parent clocks. Design is influenced by
> >> Exynos5433 clock driver.
> [...]
> >> Signed-off-by: Sam Protsenko<semen.protsenko@linaro.org>
> >> Reviewed-by: Krzysztof Kozlowski<krzysztof.kozlowski@canonical.com>
> >> ---
> > Can we also apply this one?
>
> I think so, apologies for a bit excessive latency on my side. The patch looks
> good to me, I have just applied it to clk-samsung tree. Thank you for your work
> and good luck in upstreaming remaining parts of the exynos850 platform.
>
>

Thank you, Sylwester! A lot of work remains to be done on E850 clock
driver, so I guess I'll be bothering you soon enough :)
