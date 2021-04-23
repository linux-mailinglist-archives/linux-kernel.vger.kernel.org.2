Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3743369C18
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 23:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244053AbhDWVii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 17:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243971AbhDWVif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 17:38:35 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97D1C061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 14:37:58 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z5so22448599edr.11
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 14:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ahFQQofBxdhco66YOQL+jMsNGg3VVJi31kqkEVhoiL4=;
        b=tRwP4P1Tm0knOHxGmZsYWs8ikPmtAcBtEmv0LdhF0CyJEMfqxeqi/xO0qe69Ma8r3v
         POZZQDSTTxvALZ9P4mKjcce26SrrhHagDFttvSh5iHfHbuIFuQCKsOtOUvg1UfDGK07z
         Xx27vynxI0zbkZgMDjTe87P2nnkK8giWzttRQys/6ntGvHmhv/velKF9RHcnHrssrbOW
         kDVvoW9wZi8AxkRxWFUstzHhhDYwf+OgvnNZb0YPhjYH9CJcOOQlEW2ABs7as0bcr0wx
         mbzUeXySRrvF9Nt8pStr75MSH20KlHRcU58H200JAge0B3TJkJk+USjjJduF5osVq6ii
         ysPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ahFQQofBxdhco66YOQL+jMsNGg3VVJi31kqkEVhoiL4=;
        b=uhBHXITeRo8HjK12kDaYyWkseWRS7ul+rzhkFmTvNxbw3nqVYyA3WheRBGQCq0LrCX
         jXLaXtnIq0VlUiF6l+gJVb36FTBm9CZPmOd7PLnnYn38dxnn4ljKlOvJuoU0JqaFsSwm
         ya6FFxFV5LiQyxFRB/HKmx/x42u5jyToYSZhoArOiUnMqVPR39u21EIwgbaLoJCLIF4V
         ue2P4Ls9282gtCEXiUO5nStKc+6PQeXFk8P5FXPtrL/JBiZ+hu6OxvmNc08Qac/eTrLZ
         jrW/c3Oy76tmk+AI7hAliUFtBNwIOiII4lgJYHLNWTa4ECyrtOqolXyoFcweCiNmbSh/
         TrqA==
X-Gm-Message-State: AOAM532MjWH1yqiybTkVuq8Z0srSJpT+jW4TflfQ7IQyqc5uJbEF/cmz
        UQxes8wfzMdXEBQD659B2atHf0Wnlu7dgksy0T8Tnw==
X-Google-Smtp-Source: ABdhPJzbU13qAnI2NK0ZX8uFJWfu2PlBNdDLWotnrzoER9fptUxYH5IjtIOkLYltrhDL0YcwTHwsEi4E/r77udd2pzA=
X-Received: by 2002:aa7:cd52:: with SMTP id v18mr6765845edw.97.1619213877526;
 Fri, 23 Apr 2021 14:37:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210423213048.1370821-1-bjorn.andersson@linaro.org>
In-Reply-To: <20210423213048.1370821-1-bjorn.andersson@linaro.org>
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
Date:   Fri, 23 Apr 2021 16:37:46 -0500
Message-ID: <CAOCOHw7zFSmAJKoJcbJtQLx0hVj2g-jJAHKUuP+t=NkdNPtDiw@mail.gmail.com>
Subject: Re: [PATCH] pwm: Introduce single-PWM of_xlate function
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 4:30 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> The existing pxa driver and the upcoming addition of PWM support in the
> TI sn565dsi86 DSI/eDP bridge driver both has a single PWM channel and
> thereby a need for a of_xlate function with the period as its single
> argument.
>
> Introduce a common helper function in the core that can be used as
> of_xlate by such drivers and migrate the pxa driver to use this.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/pwm/core.c    | 24 ++++++++++++++++++++++++
>  drivers/pwm/pwm-pxa.c | 16 +---------------
>  2 files changed, 25 insertions(+), 15 deletions(-)

Please disregard this (v1), I apparently left the include file change
in the index and didn't see this until I had posted the patch. This is
corrected in v2.

Regards,
Bjorn
