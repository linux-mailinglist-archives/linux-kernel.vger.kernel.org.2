Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0C1360FD0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 18:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbhDOQFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 12:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbhDOQFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 12:05:49 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37211C061756
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 09:05:25 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id v6so36373143ejo.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 09:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ITXig72r/P4qJfRVy0cJ1lATjEOyep87XS4KEz1T+Ec=;
        b=mIpQejZ2NtqVC4ZaDGRNEYV4I4SdQ2NDyCwIsr0Jko4NRxsZQntp8F9BO7G3/3mwHQ
         FXS9Fe8/DYyeUVVO5TFcyAHqAH/gUTcP4S/Xf2xYlCxIPWjF1uR/KzuR496o5VJIwfAk
         ELi5mCwoaFHdu6vL/6IJVX4hWj4LGf2ACHWf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ITXig72r/P4qJfRVy0cJ1lATjEOyep87XS4KEz1T+Ec=;
        b=l7YuQTc8eVVC1Bzw+Ty5VAvtZTMGF8HyLnODAYxBgJKwLRhe6zc9lPMWNVAPPYmMm5
         PtnQhtxPeXPBEV/DxiYhOhctChWxlzFFv+/T3yuSwXSofNTfLKsSZfsjW0C3EDECfj8Y
         vpg9cRQbUyjMsImQcI7cbadXH2K/8I6vO7nk0B7tkezldQKmmzSuKdIeN0uAsZI/8+Bu
         qxCP9puflsevp+QM+dWmp7wa6gXZNqkmvwn1S/Od3K6EHZg/ybMPPdYxgJOHEw11Jss5
         uWKG+2deFWFQJLD3DY4JQb9NpPYCYpQjm2DrMe9KdCjN5DMVg0V0pZOw432CXnJQvS8p
         2NLg==
X-Gm-Message-State: AOAM532XxOzCeX9YMpwtuxv60zD0ED6deARPsV607B5tF/o9G+o8ATfL
        jUmniOjwtaUhMLTOKjUsnoGeAfqQtr1FXw==
X-Google-Smtp-Source: ABdhPJztNV/4726lk0mNiEnEFVuPALtN4jSqCqlpezN2V35p70I18AcPRb86d9ID3oRWUWZ9pC2rTQ==
X-Received: by 2002:a17:906:3e97:: with SMTP id a23mr4209841ejj.440.1618502723382;
        Thu, 15 Apr 2021 09:05:23 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id b8sm2998836edu.41.2021.04.15.09.05.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 09:05:22 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id e7so28660857edu.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 09:05:22 -0700 (PDT)
X-Received: by 2002:a05:6402:c1b:: with SMTP id co27mr5112872edb.61.1618502721904;
 Thu, 15 Apr 2021 09:05:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210415085829.1419147-1-simba.hsu@raydium.corp-partner.google.com>
In-Reply-To: <20210415085829.1419147-1-simba.hsu@raydium.corp-partner.google.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Thu, 15 Apr 2021 10:05:10 -0600
X-Gmail-Original-Message-ID: <CAHQZ30CeO0iFztxRMV3N+ty8bYX-wOLWnyKaDTniBtLaNhjQjA@mail.gmail.com>
Message-ID: <CAHQZ30CeO0iFztxRMV3N+ty8bYX-wOLWnyKaDTniBtLaNhjQjA@mail.gmail.com>
Subject: Re: [PATCH] driver: input: touchscreen: modify Raydium i2c
 touchscreen driver
To:     "simba.hsu" <simba.hsu@raydium.corp-partner.google.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Furquan Shaikh <furquan@google.com>,
        Sean Paul <seanpaul@chromium.org>, simba.hsu@rad-ic.com,
        jeffrey.lin@rad-ic.com, KP.li@rad-ic.com,
        linux-input <linux-input@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 2:58 AM simba.hsu
<simba.hsu@raydium.corp-partner.google.com> wrote:
>
> This path makes auto-update available when IC's status is
> Recovery mode.
>
> Signed-off-by: simba.hsu@raydium.corp-partner.google.com
> Change-Id: I5ae54896a201b949eba7514500a7e75574f5726b
> ---
>  drivers/input/touchscreen/raydium_i2c_ts.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
> index 444479ef699e..a97403c55f75 100644
> --- a/drivers/input/touchscreen/raydium_i2c_ts.c
> +++ b/drivers/input/touchscreen/raydium_i2c_ts.c
> @@ -298,6 +298,7 @@ static int raydium_i2c_query_ts_BL_info(struct raydium_data *ts)
>                                          0x10, 0xc0, 0x01, 0x00, 0x04, 0x00};
>         int error;
>         u8 rbuf[5] = {0, 0, 0, 0, 0};
> +       u32 tmpdata = 0;
>
>         error = raydium_i2c_send(client,
>                                  RM_CMD_BOOT_WRT, get_hwid, sizeof(get_hwid));
> @@ -315,7 +316,8 @@ static int raydium_i2c_query_ts_BL_info(struct raydium_data *ts)
>         error = raydium_i2c_read(client,
>                                  RM_CMD_BOOT_CHK, rbuf, sizeof(rbuf));
>         if (!error) {
> -               ts->info.hw_ver = cpu_to_le32(rbuf[1]<<24|rbuf[2]<<16|rbuf[3]<<8|rbuf[4]);
> +               tmpdata = (rbuf[1]<<24|rbuf[2]<<16|rbuf[3]<<8|rbuf[4]);
Can you use be32_to_cpup instead?

> +               ts->info.hw_ver = cpu_to_le32(tmpdata);
>                 dev_err(&client->dev, "HWID %08X\n", ts->info.hw_ver);
>         } else {
>                 ts->info.hw_ver = cpu_to_le32(0xffffffffUL);
> --
> 2.25.1
>
