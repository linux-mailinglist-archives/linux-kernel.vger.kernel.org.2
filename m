Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E154B397D6E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 02:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbhFBAEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 20:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbhFBAEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 20:04:43 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C783FC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 17:03:01 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id c20so700984qkm.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 17:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4c5M/4ASBDazYuMTsoBgKbQDxXIKQJjbqe689VN4ejk=;
        b=kxYjkg/NBi6qjStnO92K4KhaG9Arp5oxtgla+7JNqQSYIHPOW6FRszAVRa6J2ZS1MT
         rtgXu5cAW8N2sAXmhNIDIF7d1eH7vgQ2ZBH1+FlRUnVXmUsjhm4q5L39e/sWWcgYj5pL
         hdfhmVnItYHJIxaLeHfR+nAdelMyolletTY1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4c5M/4ASBDazYuMTsoBgKbQDxXIKQJjbqe689VN4ejk=;
        b=Snuwu+2LcRgU6eTivA7GTgHVF47MqHBxJ/EpKsay2d922KytL2h3CDU7drKWJjEcBI
         d7y/PL5958fQjjuWYbcpN+E+MfBmoa9vNCRqLi4m/VUl4slYqKrCRnkwA17eM0gh5AMt
         OdN+m1qGTa5ao21nKxPFqPhfuW+Wm3nme2D85Hjm+OZ/kTQynTG4u7NXWgUH5bQsqysT
         d6KN75Eishrkc5mpjEARfSctIcvHaVTYZYhPtEh9G8mo1plXJ3AfUit6iN9FjpwaTRnO
         Jsum6LbYL9dllIg6IvKHTP8RRQAG49IBA2fOG/Cwse0h9zBawo0tBmaynURN6ceqReaf
         jPFg==
X-Gm-Message-State: AOAM5300hwQP9pZPDkMXhr4gKV1esSG55Vc7A674epAnEay46g+3yZUa
        DC58p6e61BlUg/uEnPAoP6bS6/z7kSwJGg==
X-Google-Smtp-Source: ABdhPJx/3rugfshJBkfaSxiPn1PnbIfQxXyMQzX6fBgm6xgZ6/8cej7b1BOomhe7MosL44nTBHGN/Q==
X-Received: by 2002:a05:620a:a0d:: with SMTP id i13mr24665725qka.278.1622592180585;
        Tue, 01 Jun 2021 17:03:00 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id s5sm1622908qtn.33.2021.06.01.17.03.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 17:03:00 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id x6so1240269ybl.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 17:03:00 -0700 (PDT)
X-Received: by 2002:a25:80d4:: with SMTP id c20mr42463237ybm.345.1622592179611;
 Tue, 01 Jun 2021 17:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210601185959.3101132-1-swboyd@chromium.org>
In-Reply-To: <20210601185959.3101132-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 1 Jun 2021 17:02:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W0qN3EqFFhftvU2AoSj5S4fV-14tCifGLiv4Rmoh9dsQ@mail.gmail.com>
Message-ID: <CAD=FV=W0qN3EqFFhftvU2AoSj5S4fV-14tCifGLiv4Rmoh9dsQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: qcom: Remove cros-pd-update on Trogdor
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 1, 2021 at 12:00 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> This compatible string isn't present upstream. Let's drop the node as it
> isn't used.
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 4 ----
>  1 file changed, 4 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
