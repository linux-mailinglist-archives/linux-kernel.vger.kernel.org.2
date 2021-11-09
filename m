Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9614944B3DF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 21:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244247AbhKIUYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 15:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244234AbhKIUYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 15:24:21 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28D1C061767
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 12:21:34 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id bl27so980728oib.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 12:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2bkcPZxFy4otFLdNug+cuD0qwesnkaZRZdhfmKMjIhQ=;
        b=AT3ewhh5rfdjFWpDWhNwT9yqY0kdlPWvW1TGijSZQxjbDseYcq/D2kPFS3rLbEVJhm
         O3QeTPPgPVWWEK4Ua7kiPX8RkjATovcRiD3KNjDYDcybTClXQAaZvc66GEYLOGvA2Z6m
         wal8X+lvAep8AF7V+yu1lNtcju75GflZZwRhoNANvZ/9CaPAMSlLgOTCqQtTD2fXZx+i
         U43QrFIU3z4wZL5ifbWqyf8pDp5ZvlOCCTjtXOjjtLARbBmJPAgo+CW+ZeNktAQ2MW6I
         3lRRUlDfduWtCHfp98gjDExpCjFr/jwCcVOJM0RgGnTBhDz4qALzTI13rO0RQI2YQuMK
         aU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2bkcPZxFy4otFLdNug+cuD0qwesnkaZRZdhfmKMjIhQ=;
        b=HLTp9BgRNnG1lDyquorsg5rueGGLawgWTEYsdem8UjPOTHj3cf8A1K60CxwqPJcq/6
         nIYFRa+c+YIbn0S4/wTC3g3U3rmPGdbQDXbM1FxgTs2ZAsiVkJeGXs4BvsTmSjNzmwrA
         +qn71St0ANnxLQ0ErUOU0esA0HVteQrkHRmLBILZ+irSfKwsgqxSpqcLXNjmwkhiPx27
         sl7Z4mXxa4B6JNbqyYWIS/RQSxqRI3YWBBein0ceIZEjARtYuu7iShmXp+H8rhlC2pR4
         Y15eRQ024jFMYvl54e1uGxpCYFlu3IyqurnK5fgEcUmINYxdCaqx86xxv9UEIWVHjduu
         wolw==
X-Gm-Message-State: AOAM530KehehrwlM9wWT0dTnsFrJNYPauZ47YP2bH9tqGQtWJSMMPZHn
        uik7A6xqZ9Bd5lgh/LuZZQfiPNoSkZx//qVJdXYx5WizPQI=
X-Google-Smtp-Source: ABdhPJzy5H8Qpb/5Cgyv/YOM54pkbhWTSoxC79x4FvNlgpvaTFmf2JW/zcONsoNsaCxEc1r3xTjLki60c2d9mnCd77g=
X-Received: by 2002:a05:6808:60e:: with SMTP id y14mr8510016oih.162.1636489293983;
 Tue, 09 Nov 2021 12:21:33 -0800 (PST)
MIME-Version: 1.0
References: <20211104170835.1993686-1-bjorn.andersson@linaro.org>
In-Reply-To: <20211104170835.1993686-1-bjorn.andersson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Nov 2021 21:21:21 +0100
Message-ID: <CACRpkdbSJRTcXdPO_CAHQ93CXszawvY9EQH4bcXWjSfuU+Y17A@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: sm8350: Correct UFS and SDC offsets
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, vladimir.zapolskiy@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 4, 2021 at 6:06 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:

> The downstream TLMM binding covers a group of TLMM-related hardware
> blocks, but the upstream binding only captures the particular block
> related to controlling the TLMM pins from an OS. In the translation of
> the driver from downstream, the offset of 0x100000 was lost for the UFS
> and SDC pingroups.
>
> Fixes: d5d348a3271f ("pinctrl: qcom: Add SM8350 pinctrl driver")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Patch applied for fixes.

Yours,
Linus Walleij
