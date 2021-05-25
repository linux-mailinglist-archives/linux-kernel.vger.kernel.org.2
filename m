Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3607439075F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 19:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbhEYRU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 13:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbhEYRUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 13:20:46 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24342C06138A
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 10:19:15 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id h24so12250995qtm.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 10:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RR4xoh8acB29qJPitkb2wSC7JB6AOVStGTvrt20hM8M=;
        b=X4X35sDWeBb8yjiu2wga4t0uG2LuMIKkR8vb8537T25TUdcZecYeNPM+6j92rt10Bj
         kHoZFMq36Kj+yuWTRdctsxqVOXm5jSQV06MN7AA6b5TdV4lu9ux13Zt6d27g5NELi5p4
         kOFjT2uI16WjvUGvOa6UOUGhDbfW/1ZaPBYlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RR4xoh8acB29qJPitkb2wSC7JB6AOVStGTvrt20hM8M=;
        b=ZiLt1M5PFksLx6L1Fk2a5RgrZvff/sj/GSO2uF5HpwK3x7KLxMJljt+YeYPGD32sgG
         A8IPKewSYdfYgOOIl1UM+T2EZxtpIAHfLV06wHrhP0SYX1Xo6VfGXIyozo2oRXpFsI29
         GS0Dz3XjuOBdZmB4bUNatS5F9oTUKSp2Sr8QSZYoauKCLfrPoX2aIelgUPL05QO8xc1n
         H7V/7kZH5UYLfOo3O1yw+lwUCcTie8yZynuN+i3mU4j8LIMW8HB/SeFBQunn9d23bTDW
         SME/9BA4Xax8ogE74w4V/0tEDGSvfwGjSn+ghZyvDdxa/roTUTYeOu3nMQKsyxDQ8NOw
         UUjw==
X-Gm-Message-State: AOAM530ncrOlmdXS9jkerMD7u1/UN8zL0Pblo1nU4F15mGhKYSjznneI
        HH5dbJ8Do+D3D3uLEg6XNBLVlLTYPphQnw==
X-Google-Smtp-Source: ABdhPJy7FJ5ZW8w2VlaG6qztiBB8BT9OoncVDbfIs2tjQ4gsDwHtoZXW1hYeMoHJvIbo38Dfq1gzxg==
X-Received: by 2002:ac8:758a:: with SMTP id s10mr10127615qtq.31.1621963153793;
        Tue, 25 May 2021 10:19:13 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id 64sm12557767qtc.95.2021.05.25.10.19.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 10:19:13 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id o18so6427093ybc.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 10:19:12 -0700 (PDT)
X-Received: by 2002:a25:d846:: with SMTP id p67mr5418346ybg.276.1621963152429;
 Tue, 25 May 2021 10:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <1621927831-29471-1-git-send-email-rajeevny@codeaurora.org> <1621927831-29471-4-git-send-email-rajeevny@codeaurora.org>
In-Reply-To: <1621927831-29471-4-git-send-email-rajeevny@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 25 May 2021 10:19:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VF+oggiTffSk5S0Bo0FA0ZaWKURkkqJBPWDjkyQ+Vspw@mail.gmail.com>
Message-ID: <CAD=FV=VF+oggiTffSk5S0Bo0FA0ZaWKURkkqJBPWDjkyQ+Vspw@mail.gmail.com>
Subject: Re: [v4 3/4] dt-bindings: display: simple: Add Samsung ATNA33XC20
To:     Rajeev Nandan <rajeevny@codeaurora.org>
Cc:     y@qualcomm.com, dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Clark <robdclark@gmail.com>, Lyude Paul <lyude@redhat.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Rob Herring <robh@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>, mkrishn@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 25, 2021 at 12:31 AM Rajeev Nandan <rajeevny@codeaurora.org> wrote:
>
> Add Samsung 13.3" FHD eDP AMOLED panel.
>
> Signed-off-by: Rajeev Nandan <rajeevny@codeaurora.org>
> ---
>
> Changes in v4:
> - New
>
>  Documentation/devicetree/bindings/display/panel/panel-simple.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> index 4a0a5e1..f5acfd6 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> @@ -242,6 +242,8 @@ properties:
>        - rocktech,rk101ii01d-ct
>          # Rocktech Display Ltd. RK070ER9427 800(RGB)x480 TFT LCD panel
>        - rocktech,rk070er9427
> +        # Samsung 13.3" FHD (1920x1080 pixels) eDP AMOLED panel
> +      - samsung,atna33xc20
>          # Samsung 12.2" (2560x1600 pixels) TFT LCD panel
>        - samsung,lsn122dl01-c01

This panel is slightly different from other panels currently listed
here because it requires the DP AUX channel to control the backlight.
However, in my mind, it still qualifies as "simple" because this fact
is probable and no extra dt properties are needed. Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
