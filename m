Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40EDB33A37E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 09:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbhCNIWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 04:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234609AbhCNIV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 04:21:56 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4789C061763
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 00:21:56 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so13170759pjv.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 00:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F7t5K6FQXwh1AvOAKrcjxJNmhozmlop1jrckC1EZ5MY=;
        b=uJBxXfBYuYuOyW+AQhAvtgzqhiuH4OIi9AB3CTF7gMF52wmijJ7NBiTJbv1blSxJwc
         OmlflovO4PiSMnIAmh60kpFvuoysCIuK7QShQ/XBl2FJwZmMiWhygyP/xdHYOEC2/tEf
         1lLR7w8NhLmAKGwxEn6isD1Ph1ZSXHwj9MpvFUcIa/m7slYvUjvdHDEwDT/VGErlBdNr
         ph1GTP96fkWsZ7g+4wAwJ6UfWKXZ+5wfpLPzyxPwIfqROoxUVw82iB/3d5R61En2Cpa+
         NcUTDw5ZP4dnDWTmK/V4MrJe6sVYrr1Uwkvp7HAUG4wG5WvN3L3Yu6Fc13OpS3LS6bw7
         tlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F7t5K6FQXwh1AvOAKrcjxJNmhozmlop1jrckC1EZ5MY=;
        b=W5HnZZMolFS9O738F8dbs6M9r/cPlqmGDEtSyX6in/yFXsYa3CLXrmkQt34NwTkmJ1
         YfjIIhVKHvtLWrGBkXl9SNGWzft0UvOdWZSk13wQzaETBz66Zq3u49bfHsdU7rRIiDv2
         oeOCxGWuUANdqqtvBnztHXEvJlAtFW6vN84XdNKqdPGXguHtPCOeXlk90Sld+S5ojYr7
         PmjMuJX48AeMUXk27SDsaMTYuAPpjjS+kgoeuChDXZlMXXUKVLaqMxK2SWz8zHq8HyMa
         PmW0r3LO8bbtOy7YJwgwu0hAkDERXB6yDorf2fA5V2F4Ud3x2AIhIa2DzuJzIOQD2Hu9
         p7jA==
X-Gm-Message-State: AOAM5330aiwFt5Y9UrsBikmdTBpR2Sh0tnpeqRZkPEBo5mnlGOVDdFRt
        5jFgOnEtaU2SN1f3wR+3ykGoR4C/CAG66UQKkeoISg==
X-Google-Smtp-Source: ABdhPJxv+W9HT+9fyyp/Do5HvczoqOvvPhNyTLOAvGmvL7geCSdoqZ1QAxsz95mOWtBGftCeKpM/K996tx2H9qONpAY=
X-Received: by 2002:a17:902:b210:b029:e6:33b4:cd9e with SMTP id
 t16-20020a170902b210b02900e633b4cd9emr6006219plr.67.1615710115931; Sun, 14
 Mar 2021 00:21:55 -0800 (PST)
MIME-Version: 1.0
References: <20210311111727.8433-1-colin.king@canonical.com>
In-Reply-To: <20210311111727.8433-1-colin.king@canonical.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Sun, 14 Mar 2021 09:21:19 +0100
Message-ID: <CAMZdPi_GWq8RsoQ6nN3W4hivc4UK+Kkru7C7S-CViyKLmjqOGw@mail.gmail.com>
Subject: Re: [PATCH][next] bus: mhi: core: remove redundant initialization of
 variables state and ee
To:     Colin King <colin.king@canonical.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2021 at 12:18, Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The variables state and ee are being initialized with values that
> are never read and are being updated later with a new values. The
> initializations are redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>

> ---
>  drivers/bus/mhi/core/main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
> index 2c61dfd01353..3faf8bade520 100644
> --- a/drivers/bus/mhi/core/main.c
> +++ b/drivers/bus/mhi/core/main.c
> @@ -428,9 +428,9 @@ irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *priv)
>  {
>         struct mhi_controller *mhi_cntrl = priv;
>         struct device *dev = &mhi_cntrl->mhi_dev->dev;
> -       enum mhi_state state = MHI_STATE_MAX;
> +       enum mhi_state state;
>         enum mhi_pm_state pm_state = 0;
> -       enum mhi_ee_type ee = MHI_EE_MAX;
> +       enum mhi_ee_type ee;
>
>         write_lock_irq(&mhi_cntrl->pm_lock);
>         if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
> --
> 2.30.2
>
