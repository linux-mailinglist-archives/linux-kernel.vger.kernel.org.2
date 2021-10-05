Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4319A421C39
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhJEBxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhJEBxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:53:37 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98404C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 18:51:47 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id o59-20020a9d2241000000b0054745f28c69so23938911ota.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 18:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=/dkkNpzviYCaFJdQwMp6k08JJ4wijyXvlqLTqGJ1jh0=;
        b=KZCmz7fxQrAK4JnFowRP+/GRUfcb8L4k8Iu9g8CaERdWmvQsS+RiyhmrNv9SvQFEVD
         T6AKEugQqWmsk78/vMnUt2wqQclXISFFYi59AYl7vZ2GtZoJF0OQYJwQVjb2P9mQb/U/
         e3SbW7IIiKTlDvh5hbg3VYgXdxMEdU2XdcDCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=/dkkNpzviYCaFJdQwMp6k08JJ4wijyXvlqLTqGJ1jh0=;
        b=ZWoP5jNYQifAJLZaCPajEHEAYlfekr3lF+hMZ4wbpK32/hVSgFW5cbi2PrMYxHTewn
         dcLdbSC14jWjbZw9PM9LxzS5HLaZ4vUBmfz7jC7knEJ6Vrp7vccmSqJPM47uH3dydIs2
         S8vODMR766PDbAI+XyNLoqnNLVm7V2M8D3S66qMkAUBLpnChJCkjME1+HjVjhpp0cNjW
         IQiQNXJac1ppR3JA3nLMD2XeJt+hun6tOVxJAE9kjvQQGtbkoTS5WTalfnEjtv0g+g7S
         bxdSM9RGzMQqkfRkTrUzAPOb+t6iusspdpSd2adK4E8aILrc/uBZLZjRHN1r3/n2tAwZ
         vhPg==
X-Gm-Message-State: AOAM531KBkhHs02igEDZ1sGIa+R1NdOBfmT3rPjJBbry39FQo1km5eLu
        kXyeAUoSP9rnjBRTLLUL/FVth3yGywBgKIwlweXtiw==
X-Google-Smtp-Source: ABdhPJzWLCe5J9N4NEvFccqk7qSekAwNhX8l0RI/XU9tNyqKDe6UT1+tzQun6F9V3idqi29P8qX/SPyM7+msx2mkAW4=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr12435757otn.126.1633398707037;
 Mon, 04 Oct 2021 18:51:47 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 4 Oct 2021 21:51:46 -0400
MIME-Version: 1.0
In-Reply-To: <8f344213978f31c04e80b804a931db56@codeaurora.org>
References: <1629282424-4070-1-git-send-email-mkrishn@codeaurora.org>
 <1629282424-4070-2-git-send-email-mkrishn@codeaurora.org> <CAE-0n50b=pX=1MFwGPDvDR=O03tUAkAgyMonGm2+SXBft=16KQ@mail.gmail.com>
 <5adf2ab2c2a162272509d253bd797721@codeaurora.org> <CAE-0n53kQU=8pdcWR0OZap1wDgxxwed0qvfaGruc71YT5Cj1iA@mail.gmail.com>
 <8f344213978f31c04e80b804a931db56@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 4 Oct 2021 21:51:46 -0400
Message-ID: <CAE-0n53wqdo7NBZn4UMRZDtc3MrF6JdvZpjcfGapJT1s5iV2jQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] arm64: dts: qcom: sc7280: add display dt nodes
To:     mkrishn@codeaurora.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kalyan_t@codeaurora.org,
        sbillaka@codeaurora.org, abhinavk@codeaurora.org,
        robdclark@gmail.com, bjorn.andersson@linaro.org,
        khsieh@codeaurora.org, rajeevny@codeaurora.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting mkrishn@codeaurora.org (2021-09-30 23:39:07)
> On 2021-09-30 23:28, Stephen Boyd wrote:
> > Quoting mkrishn@codeaurora.org (2021-09-30 04:56:59)
> >> On 2021-08-19 01:27, Stephen Boyd wrote:
> >> > Quoting Krishna Manikandan (2021-08-18 03:27:02)
> >> >> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> >> >> b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> >> >> index 53a21d0..fd7ff1c 100644
> >> >> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> >> >> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> >> >> +
> >> >> +                       status = "disabled";
> >> >> +
> >> >> +                       mdp: mdp@ae01000 {
> >> >
> >> > display-controller@ae01000
> >>
> >> Stephen,
> >>     In the current driver code, there is a substring comparison for
> >> "mdp"
> >> in device node name as part of probe sequence. If "mdp" is not present
> >> in the node name, it will
> >>     return an error resulting in probe failure. Can we continue using
> >> mdp
> >> as nodename instead of display controller?
> >>
> >
> > Can we fix the driver to not look for node names and look for
> > compatible
> > strings instead? It took me a minute to find compare_name_mdp() in
> > drivers/gpu/drm/msm/msm_drv.c to understand what you're talking about.
> > Perhaps looking for qcom,mdp5 in there will be sufficient instead of
> > looking at the node name.
>
> Sure Stephen. I will make the necessary changes in msm_drv.c to look for
> compatible string instead of node name.
> Can I include these two changes (changing mdp--> display controller and
> msm_drv.c changes) in a separate series ?
>

Sure. So you'll send the drm driver change now and we'll get the DT
change after that with the more generic node name?
