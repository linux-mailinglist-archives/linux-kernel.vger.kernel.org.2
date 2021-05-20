Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5D4E38B910
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 23:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhETVlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 17:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbhETVlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 17:41:49 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB308C061763
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 14:40:27 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id h24so2533667qtm.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 14:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZIgxNeJtIZOCUu26nn+aGqgcAu9hM+yO4Nw/eB0jBeE=;
        b=OQqXZJQ0WQrHpmGQhIiwMtNefwOL7yYcMbOia1kGiGWxNB3k8j/ikmE+Pgtt0Cqjuu
         tmIdpKxL+hf08loIQOk+J8Fh/l4KYpp/jV7K+vvTqq+etwPRC5CLRJyHvtMQIRVdxm29
         pSHqTAtKSinj4v9l/XhymSogCplDJ2+uHGogE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZIgxNeJtIZOCUu26nn+aGqgcAu9hM+yO4Nw/eB0jBeE=;
        b=OeMoNWyzOmmbPlkSqC1VkpC/8xlVx2NKmVxLRVtstM15JVnJgV+AQ5BmHWrpZsDeRc
         WYIEUIh2QB/iPKZjseZkPuQVoVxhe6eVlXmKIuwJXA/KdV1Sbe2v3a0O/pt0EKnd/X/l
         A2OfJgzgBwoqY3jhFK90uV60NBJRZawSABYDpenYLk4RS60fEW75PsinPBm1CwJYBtof
         FnHqC5OGPX4u8sXQ8TrjrkFaYRJsw3woNp8m7z/GGi5C+sDeyB+CPPxSkHVfyOrJSDUL
         YtXs9GILS2GOOZDSc18FK30lGBUVZW23vXaCZrAj0OM4na4bGI+y+SHwtSyxbS21dPza
         8w3Q==
X-Gm-Message-State: AOAM531F/gc1dU3hgl7LFkQZt8FR3EozkJk/wrNPwM6+mm0K7kFKZTEI
        jLgvCmiNxAMmuiOYk8ILiCfomi1jUVPUjw==
X-Google-Smtp-Source: ABdhPJynaLedkQ6d1tjnLCotZSO5wbqjrFUNBIf9Hv9f4Qp5qFIUkWnZh2q36JBlXkL1NTTlCDN4ow==
X-Received: by 2002:ac8:6b0a:: with SMTP id w10mr7416945qts.60.1621546826543;
        Thu, 20 May 2021 14:40:26 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id 7sm3456890qtu.38.2021.05.20.14.40.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 14:40:25 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id r7so2705465ybs.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 14:40:25 -0700 (PDT)
X-Received: by 2002:a25:80d4:: with SMTP id c20mr10916531ybm.345.1621546824581;
 Thu, 20 May 2021 14:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210513122429.25295-1-srivasam@codeaurora.org> <CAE-0n51jjHWSFiip-utVKjAQbaJuj+oKq0GPLgw2q2mG_9B=eg@mail.gmail.com>
In-Reply-To: <CAE-0n51jjHWSFiip-utVKjAQbaJuj+oKq0GPLgw2q2mG_9B=eg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 20 May 2021 14:40:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uzg+a6ZrinAnq_=29103JPs0=oWTa3VkfTUbPRkvGyjw@mail.gmail.com>
Message-ID: <CAD=FV=Uzg+a6ZrinAnq_=29103JPs0=oWTa3VkfTUbPRkvGyjw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: Add wakeup delay for adau codec
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Judy Hsiao <judyhsiao@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Mon, May 17, 2021 at 3:44 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Srinivasa Rao Mandadapu (2021-05-13 05:24:29)
> > Add wakeup delay for fixing PoP noise during capture begin.
> >
> > Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
> > Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
> > index 4c6e433c8226..3eb8550da1fc 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
> > @@ -23,6 +23,7 @@ / {
> >         adau7002: audio-codec-1 {
> >                 compatible = "adi,adau7002";
> >                 IOVDD-supply = <&pp1800_l15a>;
> > +               wakeup-delay-ms = <15>;
>
> Is this part of the binding?

It doesn't seem to be, but it's supported by the code. It's also in
the generic "dmic" bindings. The bindings are pre-yaml. Seems like
someone needs to take charge and clean those up, but I'm not sure we
need to block this patch on it?

Though I'm not an expert on audio stuff, assuming that this works OK
I'm fine with:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

-Doug
