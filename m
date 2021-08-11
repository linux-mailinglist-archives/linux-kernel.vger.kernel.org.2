Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569E03E9AC2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 00:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbhHKWKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 18:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbhHKWKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 18:10:50 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA30C0613D5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 15:10:24 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id y3so4562696ilm.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 15:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UEIdKaECjUbY7rgf9DAfCgQCtR0RYp4t4j+s1C5ELwA=;
        b=IszbToVnMZEHbB/WVlNuFncfCT1WJ60B8/DlD3ZJassXJujnum4s3Rlvuitw11QfE3
         szdoJL9EEg0MO2AZjJ9u7zCog2/x5O+fe+42ZSWJYN93kEm+NVHju/cdWSzArrvS2Kfg
         hKyna67wmm6B89+hQiIK98DYu0eGOtSRVn73w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UEIdKaECjUbY7rgf9DAfCgQCtR0RYp4t4j+s1C5ELwA=;
        b=dClf5YZHbCAPHSqW8y2aJRJGYnQ+clC8TVMJuyNPkn4zVT90JDFSI2R38mgnmlEvAh
         /b09rLHZjlW1rdO6pMXOfBAchTlrWkW6W8pKsGwhwUOVb6SW4kOQa0juNnXYCff6UI8o
         vfsT9qu7pyc1K3ADNbhNCp0A0hlkDiTAzPjy/pI4xNXi+J7KB66QOjYUP60LLnqqJjfx
         y+1HvIcoY5TrfyqbtT6Lf3fubgpIMbaozZ4a5wJAmElMAyXEL1V797g8tjg1QVr++nTL
         VjX3wNpVsZRmViD9Ro7saHI+adr473wB9GS7yhQBPf1eocwt5xXOV0bx9AsvET87BAxF
         tNyw==
X-Gm-Message-State: AOAM530PBmBYkMFMjfjjudZmmlOn1JjA+qxQ1r/Fcp0lIFgI/hFbaqZr
        g9r6+As4MpAnim+6889PyX4xyM5ZvTR6MWCg
X-Google-Smtp-Source: ABdhPJwCMOQEFqdnFyL8h5V2EcoKKIhmAIDlJBn9Er+S/jsf19/Y3QlQ9TeWI+3o671xkWQwTQOeMQ==
X-Received: by 2002:a92:d987:: with SMTP id r7mr467873iln.303.1628719823834;
        Wed, 11 Aug 2021 15:10:23 -0700 (PDT)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com. [209.85.166.49])
        by smtp.gmail.com with ESMTPSA id o5sm337548ilh.60.2021.08.11.15.10.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 15:10:22 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id e186so5608757iof.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 15:10:22 -0700 (PDT)
X-Received: by 2002:a02:a581:: with SMTP id b1mr898507jam.84.1628719821924;
 Wed, 11 Aug 2021 15:10:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210721080549.28822-1-srivasam@qti.qualcomm.com>
 <20210721080549.28822-3-srivasam@qti.qualcomm.com> <CAE-0n52hdv0ehzQi2si3rPumBiO+=stoU3kkK=0e7fU_5+xUZw@mail.gmail.com>
In-Reply-To: <CAE-0n52hdv0ehzQi2si3rPumBiO+=stoU3kkK=0e7fU_5+xUZw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 11 Aug 2021 15:10:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VgwLNiAZKur7PPpB=_mOnZrkBa2cG1DZYsCxQRAd42NA@mail.gmail.com>
Message-ID: <CAD=FV=VgwLNiAZKur7PPpB=_mOnZrkBa2cG1DZYsCxQRAd42NA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: sc7180-trogdor: Add lpass dai
 link for HDMI
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Srinivasa Rao Mandadapu <srivasam@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Judy Hsiao <judyhsiao@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        V Sujith Kumar Reddy <vsujithk@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 10, 2021 at 11:06 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Srinivasa Rao Mandadapu (2021-07-21 01:05:49)
> > diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> > index 31bf7c698b8f..a4cb9ee567ff 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> > @@ -288,6 +288,7 @@ sound: sound {
> >                         "Headphone Jack", "HPOL",
> >                         "Headphone Jack", "HPOR";
> >
> > +               #sound-dai-cells = <0>;
> >                 #address-cells = <1>;
> >                 #size-cells = <0>;
> >
> > @@ -314,6 +315,18 @@ sound_multimedia1_codec: codec {
> >                                 sound-dai = <&max98357a>;
> >                         };
> >                 };
> > +
> > +               dai-link@2 {
> > +                       link-name = "MultiMedia2";
> > +                       reg = <2>;
>
> Should this be
>
>                         reg = <LPASS_DP_RX>;
>
> ? And then the dai-link@2 should change to dai-link@5? It doesn't seem
> to really matter though, so maybe not.
>
> > +                       cpu {
> > +                               sound-dai = <&lpass_cpu 2>;
>
> This should be
>
>                                 sound-dai = <&lpass_cpu LPASS_DP_RX>;
>
> ? At least from what I can tell without having it be 5 it doesn't work
> properly and external audio over DP doesn't enumerate.

I swear I provided feedback just like that. Yeah, here:

https://lore.kernel.org/r/CAD=FV=W3X8W90vPdrDAymzTKj-J7QPyn4ukaLSOhEkCme3+r_Q@mail.gmail.com

I think the problem is that the wrong patch landed. The one I see that
landed last week was v4 but I also see v7 of the same patch:

https://lore.kernel.org/r/20210726120910.20335-3-srivasam@codeaurora.org/
