Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A77663F6C16
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 01:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbhHXXIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 19:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbhHXXIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 19:08:36 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D529EC061764
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 16:07:51 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id y18so12865993ioc.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 16:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WE+YtBA3gJnr+ACnUTzWBgYKs5rZNaGQyfyCqSLCJh4=;
        b=XR8IPmMsfb9AITUHo8H7bgAFJbyTroEyqBamjYr4/G1KWUAhK9q9B/TaXjlqsz6JNL
         lmuSqtjEAd6pcHjtv9EvIFF0nyacrsz1Op48/IRk4c4mBbQP72dS06JO6BHCq14yNc3P
         Pp9LH7ufBggVEDobtoj8S/HX0fEXtUOLKHkS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WE+YtBA3gJnr+ACnUTzWBgYKs5rZNaGQyfyCqSLCJh4=;
        b=GNYSosCybHu56PgIcgDBlJU34ngO4OVlxvpp0g/QTYpx6Te0VobtpRyX4muAS2kQcv
         S8gvpWcIF11IJJaDHb2dfBgk90sfwwQYxzmt5fNw4d7qq8U+69kzkojwLqbkuMsFsjoy
         G2UsvNyHo6xDVeF0gKJZ/loJ8MbeKlMgmwQ7t3D6VKJS0xqxn9wWkYg7k3fvoztmmInI
         ZHh76UO3FAvzQALjq4BoEB/OzXL0Ewj23r1rUTZN46/3xpyU4B5bHoE9DfI9nZ/4Bq6K
         xZPir+a49rE/kBQfX9Lyf2HgL2mnSxGIgBquOnbepPgZ+1a2jLQ972Z1QvSoq2Iy106h
         GJug==
X-Gm-Message-State: AOAM533aGpnbIc3E1jrRfdbelIC1HiQlwuhbQDJ9EzgEqUxHexnZhg5a
        JgnuKVnezCuxLGp21ZPX2Rv3aqY/9IWKRQ==
X-Google-Smtp-Source: ABdhPJy+ZmDy2TV8PwFwHbUOVthFQlzdRWfuLz8B+u7664V4f37mHsuV6R/k0EYyuFtUqRyxqSi6Gg==
X-Received: by 2002:a6b:e917:: with SMTP id u23mr33757075iof.19.1629846471141;
        Tue, 24 Aug 2021 16:07:51 -0700 (PDT)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com. [209.85.166.41])
        by smtp.gmail.com with ESMTPSA id d12sm7196044iow.16.2021.08.24.16.07.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 16:07:50 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id j18so28392813ioj.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 16:07:50 -0700 (PDT)
X-Received: by 2002:a02:644:: with SMTP id 65mr3305905jav.84.1629846469728;
 Tue, 24 Aug 2021 16:07:49 -0700 (PDT)
MIME-Version: 1.0
References: <1628726882-27841-1-git-send-email-sbillaka@codeaurora.org> <1628726882-27841-3-git-send-email-sbillaka@codeaurora.org>
In-Reply-To: <1628726882-27841-3-git-send-email-sbillaka@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 24 Aug 2021 16:07:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VgWm76kb1KwsieTXUmddPgkENtGBQ2UtMzQ38ob+6EKw@mail.gmail.com>
Message-ID: <CAD=FV=VgWm76kb1KwsieTXUmddPgkENtGBQ2UtMzQ38ob+6EKw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] dt-bindings: Add SC7280 compatible string
To:     Sankeerth Billakanti <sbillaka@codeaurora.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        Krishna Manikandan <mkrishn@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 11, 2021 at 5:08 PM Sankeerth Billakanti
<sbillaka@codeaurora.org> wrote:
>
> The Qualcomm SC7280 platform supports an eDP controller, add
> compatible string for it to msm/binding.
>
> Signed-off-by: Sankeerth Billakanti <sbillaka@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 3 +++
>  1 file changed, 3 insertions(+)

The ${SUBJECT} of the patch should probably be updated to say _what_
you're adding the SC7280 compatible string to. In this case, that
would be the msm dp-controller.

-Doug
