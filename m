Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A0430B616
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 04:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhBBDwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 22:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbhBBDwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 22:52:03 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD06C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 19:51:23 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id q5so17791459ilc.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 19:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DUbVLJ+6EapSl5sVNLf8sgof9k3YF74Apn4NRNuZrBI=;
        b=G139zDlnZdSnzIKH7yG75Inkorodk6X7AjLca6dTCwnjSMyL1PTsMAWZbIzfthY3R/
         l8oxeWNBoH7WS3B3ILFRsEFRguGNqVruEpnIW/oJuq9kukOrYVIY2fSXSvBptglZ0eM9
         bb2hgs2LbjxiECmNi0TNOMF+lqm5YVN30AvK20Y18+IAq4YKOET0Vli6u3q9SXw68Mhj
         6xYne4B8ydAADwTKwuzAnO6mKZ9F40RtN1M4C4i6N9Asa8uh/R9oJd5EL+sq5mg/hVpP
         iTohNwVMbv2/+j6wVhOL99ZY/Ng+qkog64cUg44UbFyz2AaHNfIDKKcZyE8pbPQV6gtM
         0HVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DUbVLJ+6EapSl5sVNLf8sgof9k3YF74Apn4NRNuZrBI=;
        b=fWD/MCvpYuIWDltaCFLhdR1cgu6cP/SB7sJ1uAJb/MU/ZRY3HGPuIUsvttsQIwLbc+
         Bv9c1ABje4N2fxc4H8A6+QAweNH3/VCj1u8spO27EdJiI56KFs/pUZrWivL5NqG8ihHp
         rCT8Ams+zgyU2UFuR2xW4UFrjCQTqKa0VqvKYBPJxdhpsfU7VIgdxA4X6JLjDwKDpDSP
         OtKQsyfCwp2yfDpnWKlMXSFVOZagqjD4+CGKOWyjshBFyPs0j8wzE2s1BM9ccMgffvGx
         UtuR421sy9SAWzuqb4zBUpBcieEQHaCFoKZyvRLQF5/0dhsqozePC1quNYbp+7o7z9TW
         Z+zA==
X-Gm-Message-State: AOAM532znyTzXVpV4g98qgXL2xZ+MFGqOqCdTGcipCOT/J+8BfdNJAYI
        FZGrxeCX4aqNsF6+i8D0Fuxl2+LKPP98HZJ60zfpWQ==
X-Google-Smtp-Source: ABdhPJxc3qlV1vDkvr6AKiJA6v8PIzxjnHjrC8AiVb4RHEO7WgoEnWmUihcs05hGWpDlchzD4tCKWKvEQhihhe0Ou5s=
X-Received: by 2002:a05:6e02:d42:: with SMTP id h2mr17203540ilj.204.1612237882649;
 Mon, 01 Feb 2021 19:51:22 -0800 (PST)
MIME-Version: 1.0
References: <1611913781-23460-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1611913781-23460-9-git-send-email-hsin-hsiung.wang@mediatek.com> <1cbf58f1-376c-fa93-98a2-53a41fa24273@gmail.com>
In-Reply-To: <1cbf58f1-376c-fa93-98a2-53a41fa24273@gmail.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Tue, 2 Feb 2021 11:51:11 +0800
Message-ID: <CA+Px+wXP2vrFbou+SCRZuXYr4XPPxYHZfk+oSM7_GPXZSD24UQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v5 8/8] arm64: dts: mt6359: add PMIC MT6359 related nodes
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Fei Shao <fshao@chromium.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Yuchen Huang <yuchen.huang@mediatek.com>,
        Ran Bi <ran.bi@mediatek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rtc@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Wen Su <wen.su@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 7:06 PM Matthias Brugger <matthias.bgg@gmail.com> wrote:
> On 29/01/2021 10:49, Hsin-Hsiung Wang wrote:
> > +             mt6359codec: mt6359codec {
> > +             };
>
> I understand that the dmic-mode and mic-type-X depends on the actual board on
> which it is used. In that case I think we should add mt6359codec node in the dts
> instead of dtsi file. I'd advise to set these properties as well as otherwise we
> get a (slightly misleading) warning in the driver.

I feel it is better to include the node in dtsi to represent the whole
MT6359 PMIC.

We could either:
- Set default values of these properties in the dtsi to avoid the
warning message.
- Or https://patchwork.kernel.org/project/alsa-devel/patch/20210202033557.1621029-1-tzungbi@google.com/
