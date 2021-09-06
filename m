Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1246401EFE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 19:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243897AbhIFRLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 13:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243850AbhIFRLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 13:11:43 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FAAC061757
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 10:10:38 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id y6so12330923lje.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 10:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3NzOsAcij7qkGRYYRF+Gk9quH4ScOJdJCPVo4O4v2Iw=;
        b=GHRGp+FUEkuHWw+ma0xVKQKa3h0umQo2tZK29UHxYju0b6ue16Kq14o9Umrg1V2MzP
         OQQXLK8KNB+v/BxOIbCyTw0czVpMCwn+5JzpnXPuLMl7EWNQ7sHs3zh9WjxrvQpPpYiZ
         8LWWFMoMXZzjIgD/LiK4RPs8rIKwXYvFnw1MxOfktunYrvXWKxEQi+cNLd54jz/QxD82
         q5LZAvOaV1YZcbxrnCO9UXixRhXWa0Bb2CxeCigV01UXcy2uhxYVs602hEfUK+25gyzr
         O5FHrFpdUDfVO+z3EN+pb5IA++Pltvth3nAlf/Z4d1qU3iaIikLXoUvP/g8bceHOwcf6
         WvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3NzOsAcij7qkGRYYRF+Gk9quH4ScOJdJCPVo4O4v2Iw=;
        b=FIuD5rd79DxAOwNVGF7EvsPbgOSkDEPp5M+W30UtO9CXJNuDlXCvxjN8CaXp6RKCRn
         X6kytiOtZh7OALd8Cg7bhcrLl1UPQL/C09XfTrpUP6aCPCB3P+q9Nva7fI/In0ZnEAPW
         xMs92iyiYY6YuuJY+rEyGdcxdTkSf2jBO43bX+HNSlKX4y48zfhzL9hqZ21L/xvSSzpe
         M1cIjRJXhhm9oehIanEog9wdgAgv/ZCxwPfUDSMKOQuew0ijSmQTk12H7MI5hNbtxHcE
         moqXdq5LhXCy6/Q6lfVX3bPR5UepmmiIpxgyIEN0chX/KInivYslHz0f4iHBQIDYWq0S
         6nHw==
X-Gm-Message-State: AOAM5321LTT06aWQaH1Z9T2hWf6xV23ZH6XteH1VzMMJXnumKF5K3+45
        IQUBGp8uO6v/0v/fb0baAH1fVjwPUxEW1Em3jZP9Zw==
X-Google-Smtp-Source: ABdhPJz02lZ2+/F+0r9vZ7g0b7LkWahcgAWP9qXLtKcaYaug81bz1fYecfyuvbPq62onmDQwmmLi7+yTxyKqBDnGYbQ=
X-Received: by 2002:a2e:7303:: with SMTP id o3mr11093870ljc.273.1630948236659;
 Mon, 06 Sep 2021 10:10:36 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20210827093855epcas1p4ac8e34d779fe30de3e03bcadedcb66c8@epcas1p4.samsung.com>
 <20210827093119.32481-1-cw9316.lee@samsung.com>
In-Reply-To: <20210827093119.32481-1-cw9316.lee@samsung.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 Sep 2021 19:10:00 +0200
Message-ID: <CAPDyKFoXtep02GTFgKZmAoa7cN6CMBErf4UukWhrk5jU10Lj_g@mail.gmail.com>
Subject: Re: [PATCH] mmc: mtk-sd: Remove unused parameters(mrq)
To:     Chanwoo Lee <cw9316.lee@samsung.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        grant.jung@samsung.com, jt77.jang@samsung.com,
        DooHyun Hwang <dh0421.hwang@samsung.com>,
        Seunghui Lee <sh043.lee@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Aug 2021 at 11:39, Chanwoo Lee <cw9316.lee@samsung.com> wrote:
>
> From: ChanWoo Lee <cw9316.lee@samsung.com>
>
> The mmc_request structure(*mrq) is not used. //msdc_cmd_find_resp
> I remove the unnecessary code related to the mmc_request structure.
>
> Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>

Queued for v5.16 on the temporary devel branch, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 4dfc246c5f95..813f57f6d9cc 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -961,7 +961,7 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
>  }
>
>  static inline u32 msdc_cmd_find_resp(struct msdc_host *host,
> -               struct mmc_request *mrq, struct mmc_command *cmd)
> +               struct mmc_command *cmd)
>  {
>         u32 resp;
>
> @@ -997,7 +997,7 @@ static inline u32 msdc_cmd_prepare_raw_cmd(struct msdc_host *host,
>          * stop << 14 | rw << 13 | dtype << 11 | rsptyp << 7 | brk << 6 | opcode
>          */
>         u32 opcode = cmd->opcode;
> -       u32 resp = msdc_cmd_find_resp(host, mrq, cmd);
> +       u32 resp = msdc_cmd_find_resp(host, cmd);
>         u32 rawcmd = (opcode & 0x3f) | ((resp & 0x7) << 7);
>
>         host->cmd_rsp = resp;
> --
> 2.29.0
>
