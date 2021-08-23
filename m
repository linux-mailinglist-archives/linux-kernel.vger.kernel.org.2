Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3EA83F53CA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 01:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbhHWXvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 19:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbhHWXut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 19:50:49 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED511C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 16:50:05 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id o16-20020a9d2210000000b0051b1e56c98fso26259781ota.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 16:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=WoDDjdzbvPyEs19Npp+KsDh7LDnbNT5MIojU8+tk5Fw=;
        b=lxV+LoLa6AmzEui46cKIIlmIVceP1kYM8VWwX7911dwfuaalkODC+0x8OScWBEMuc+
         R5+iNiCXJR/9dZKmqhyjGONtNUjng1Uh4paCMbcZbPTX1zbc9gwrOZeeQJ6c9R9p97ut
         8sh+04l2eksB3ZaemEeRRbtxSvyMcIGshrD+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=WoDDjdzbvPyEs19Npp+KsDh7LDnbNT5MIojU8+tk5Fw=;
        b=mRKQa2SrYI6rhtaU9qEs+ibZ+Gh96s+RH/a5okbtq4gjhZwZsRrcMsNjcud4AVp4v+
         XiCZKdqqBoTwCe9fBr+++cDjsINY5JdSrl6kYtHAezQRxGFp9AF9tOcIUNFNv2TwoZfo
         FuswDu64ipm76YivmayiOObgZmU+LLxeJ72Hoy7bPFJnlwVFDhQeDf0P4knndXZjScd2
         ec6HsjNj0VUmeA6lyxLvQ9uviW63oD2pTrLkXYfV3We3JZHghnllz6RmRLsWM0vgKAxa
         Cr2GaiAz/GUKjaKwfYYVQDiyVolYCKNqPQFWDfhhkpx04btmE0uXJA6PK36GFhjr8rPy
         1jXw==
X-Gm-Message-State: AOAM532pk8WSdhis30OlUlf1tg2/53VXweuJKPdYR/bX8PwblGNtVa1+
        Co1acttUxRTmbeRYePBDptCzVdX1bp5dUhzSonDRZA==
X-Google-Smtp-Source: ABdhPJyplZFiLcT/PUaK7ZB+YTOaFz++lRFqFYou4I57i80IsaoaIZAZ18qqb81QRva1zUDu1wKPZC4CXzo1GJhyYpY=
X-Received: by 2002:a05:6830:2473:: with SMTP id x51mr22956792otr.34.1629762605326;
 Mon, 23 Aug 2021 16:50:05 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Aug 2021 18:50:04 -0500
MIME-Version: 1.0
In-Reply-To: <20210823134726.1.I1dd23ddf77e5b3568625d80d6827653af071ce19@changeid>
References: <20210823134726.1.I1dd23ddf77e5b3568625d80d6827653af071ce19@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 23 Aug 2021 18:50:04 -0500
Message-ID: <CAE-0n52Rp9QGUYeP==YdXEJAwbtHtZX=5b3gaR-smLMFybsf6A@mail.gmail.com>
Subject: Re: [PATCH] thermal: qcom: spmi-adc-tm5: Don't abort probing if a
 sensor is not used
To:     Amit Kucheria <amitk@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2021-08-23 13:47:30)
> adc_tm5_register_tzd() registers the thermal zone sensors for all
> channels of the thermal monitor. If the registration of one channel
> fails the function skips the processing of the remaining channels
> and returns an error, which results in _probe() being aborted.
>
> One of the reasons the registration could fail is that none of the
> thermal zones is using the channel/sensor, which hardly is a critical
> error (if it is an error at all). If this case is detected emit a
> warning and continue with processing the remaining channels.
>
> Fixes: ca66dca5eda6 ("thermal: qcom: add support for adc-tm5 PMIC thermal monitor")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Reported-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Should we also disable the 'charger-thermistor@0' node in
sc7180-trogdor.dtsi on lazor boards, instead of the thermal zone, or in
addition to the thermal zone? It isn't used so there's not much value in
exposing it.
