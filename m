Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320CE3922C4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 00:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbhEZWfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 18:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbhEZWfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 18:35:00 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FB6C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 15:33:27 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id a5so4217115lfm.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 15:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+q6KaFxTPrGNNLwCmGAKEAgGlUkRO/QzSCDrfx0DrSg=;
        b=wIL4RkZTimsFgGynXx75Vevi3OQSEWAGaZI61p/Zf5rRDcq0EC/ANeaHxDeVlYuon9
         SArWJYsVvQwA93vz0r5icREmsbQFG/9BvKQpw/7clyuRu8kNEA8ZbcKW+6vhEnRpXHR2
         4sNaTWjPv8oBoT3Gg6XtHnKGGZY5ALNo5n33JZIsLFqWT6XBg17FZrfnU/dYX2pNpRS2
         SKhM/BArPmQFvHRNHZ2kBmijBMGAL1Pf7hTeV+AT779ThunhLrPEEQL/TeXOGg507TtV
         h7Pk020KNFLt7jpA6agibScFz6G0tuR6BeONO4nBnqDV0qzvCfLy0qeO9LKRgUIG+Mw3
         FiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+q6KaFxTPrGNNLwCmGAKEAgGlUkRO/QzSCDrfx0DrSg=;
        b=Kv6iBhVnFtgM9oQo5BwiiTru9ANoLSwPza2yoX7K6/bsDaalFdKZ9eGmOoRIrRE260
         vqN2IPUKwlpI4Ikv/DM3gcls617wfOq2F32K9sOHVjLLKozoKSzffQ4tn+OMyKEwF1YT
         Ax40IfCcIYP05XcBb/OxbSnnyBwv7w19uKBQrYEJSHSMdGDJn4bj83zM9dmis9hIze3G
         sbdhSyOxKwjbZ32f4v2fQXlETCHxc68HTfk2jnHFZrr5TXl5WBbybmGK60VF8BQ6VQMc
         SSwxqYnKJ2XBdgHqK6kG4ezdeRnwSxpZ4peTStxgwgTVaXo/MTIqndr8Tf0pr+MAnv1y
         jZtg==
X-Gm-Message-State: AOAM531kkDhOVrq3YIjmgr1Z10pAgdWxlNiRMama2Rkv5eazWBDAj12I
        uyPe312tYyPr8U8+9DPGUJ/PIA2ctJAYp4Qw0dg/ntnBF9g=
X-Google-Smtp-Source: ABdhPJwknJu0coBSwEXImOs1iWFs12E7H1AAxxtj3DzRAXFPL4IC5NQtTaeeFX3l9ZoJK3fa7b5MydykV+kcHntTlJA=
X-Received: by 2002:ac2:544f:: with SMTP id d15mr212533lfn.465.1622068406233;
 Wed, 26 May 2021 15:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210526081038.544942-1-lee.jones@linaro.org> <20210526081038.544942-8-lee.jones@linaro.org>
In-Reply-To: <20210526081038.544942-8-lee.jones@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 27 May 2021 00:33:15 +0200
Message-ID: <CACRpkdYjx3DyKoKpcQetXyB5uU8dqNb-qjzUbzNOj9Zqy=CmsQ@mail.gmail.com>
Subject: Re: [PATCH 07/10] bus: qcom-ebi2: Fix incorrect documentation for '{slow,fast}_cfg'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 10:10 AM Lee Jones <lee.jones@linaro.org> wrote:

> Fixes the following W=1 kernel build warning(s):
>
>  drivers/bus/qcom-ebi2.c:112: warning: Function parameter or member 'slow_cfg' not described in 'cs_data'
>  drivers/bus/qcom-ebi2.c:112: warning: Function parameter or member 'fast_cfg' not described in 'cs_data'
>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-arm-msm@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org

Thanks Lee!

Yours,
Linus Walleij
