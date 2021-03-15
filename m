Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F041633C8C9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 22:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbhCOVt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 17:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbhCOVtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 17:49:18 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34400C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 14:49:18 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id s2so10280870qtx.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 14:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y8Ctq0g/toRBjs9iL8s88ECUGF1puSJjpiFNl2vNGJQ=;
        b=WmMpkHYindb+LZ9jDwNWfpQ6LLEnax8gmvAN4GjHAd7F/G8HAl8R9epV+4+0neeiHh
         W5gnE6nKWdmAWkR8CN+G7waiDbKENnOIXMQeFf27dAzrOZNfqRQGyl52yASFb6tn5/X6
         xw4jKtVge4TTPXADouuNNqZNl/gTydPWXjXew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y8Ctq0g/toRBjs9iL8s88ECUGF1puSJjpiFNl2vNGJQ=;
        b=YW81aZWykGDzXQgCEXpTH3Hk+f/887ToikSfxitlIKZovmvSM6YI/beae3RhbM1KSF
         VZbvj7UL3PEDeKnxe2hlKr2gOgrzPd59s6KuxlQ9BxV0klK56SQ+qgHdqbKT/23QGnxI
         AEDR3xGqfsPpjfHNeeob5WwvG8vPSeMfnnJOJ9XafHPtZyca6KCQ0oI5eoHYUp5J7xIp
         DBJF+aEWEW87WnuHx65DBJD4zEfMtC5LHqPctOQ3c71Tq89hjHFb3NGxJdwaJWjIV2Ep
         CSs27ZF94GXb46ypuAOEmWL/72NPtWIFL6yy5yM6QQX+8h6Tymk4zJJobxspxJnSdONC
         k4UQ==
X-Gm-Message-State: AOAM532b7d63nVCQz+COxn9kENAfXIqistg0PmcUfFqZeRjevsm6ddhC
        QuzjccyD7nARCZUG4U//1CB6fMOJPtpsuQ==
X-Google-Smtp-Source: ABdhPJwLfwFJevjvL/4p8kF6jOfYkHKtZLAyvqYzowW+dV8m7qPB2TYxLcJFLYeesoodXLPSANLLdg==
X-Received: by 2002:aed:3001:: with SMTP id 1mr13063075qte.344.1615844956894;
        Mon, 15 Mar 2021 14:49:16 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id 8sm4245461qkc.32.2021.03.15.14.49.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 14:49:15 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 133so34757550ybd.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 14:49:07 -0700 (PDT)
X-Received: by 2002:a25:ab54:: with SMTP id u78mr2804200ybi.276.1615844947079;
 Mon, 15 Mar 2021 14:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210312183228.550779-1-mka@chromium.org> <20210312103211.v2.2.I4138c3edee23d1efa637eef51e841d9d2e266659@changeid>
In-Reply-To: <20210312103211.v2.2.I4138c3edee23d1efa637eef51e841d9d2e266659@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 15 Mar 2021 14:48:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U6xNaTLaP5Hz4EVTd3EY-ptTCaLJ84X6=C_6E9Gdq03w@mail.gmail.com>
Message-ID: <CAD=FV=U6xNaTLaP5Hz4EVTd3EY-ptTCaLJ84X6=C_6E9Gdq03w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sc7180: Add pompom rev3
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 12, 2021 at 10:32 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> +       linux,keymap = <
> +               MATRIX_KEY(0x00, 0x02, KEY_BACK)
> +               MATRIX_KEY(0x03, 0x02, KEY_REFRESH)
> +               MATRIX_KEY(0x02, 0x02, KEY_ZOOM)
> +               MATRIX_KEY(0x01, 0x02, KEY_SCALE)
> +               MATRIX_KEY(0x03, 0x04, KEY_SYSRQ)
> +               MATRIX_KEY(0x02, 0x04, KEY_BRIGHTNESSDOWN)
> +               MATRIX_KEY(0x01, 0x04, KEY_BRIGHTNESSUP)
> +               MATRIX_KEY(0x02, 0x09, KEY_MUTE)
> +               MATRIX_KEY(0x01, 0x09, KEY_VOLUMEDOWN)
> +               MATRIX_KEY(0x00, 0x04, KEY_VOLUMEUP)
> +
> +               MATRIX_KEY(0x03, 0x09, KEY_SLEEP)       /* LOCK key */

I don't think you want the LOCK key. See <https://crrev.com/c/2719075>


-Doug
