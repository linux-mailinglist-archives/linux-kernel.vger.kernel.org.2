Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675683DA9D7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 19:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhG2RRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 13:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhG2RRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 13:17:04 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D4CC0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:17:00 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id b25-20020a4ac2990000b0290263aab95660so1744948ooq.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=a1Jpgqpv2djZJsAG0DhOFk0xd5WwpCit+wt+1ShQN3w=;
        b=IbUizu0+FfdESoAU8NUVe9wutrr/sa7srK/lGLGR6WuyGgwFNN9rj9qseZg3c5JZ2X
         Eufd/DoziaUsBlouBYPxXVAoGSs0/gO/pDUgoc/7GcJzr3yvkOoqAkkViqXG2Lcp/YRF
         6DjRLU9tPwM1ZchhAxMbQ1yVgg3bVbSifylTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=a1Jpgqpv2djZJsAG0DhOFk0xd5WwpCit+wt+1ShQN3w=;
        b=BBGQL852Yr8qLHC6bxysardFfVkBG8Q7z9gmpCZh9NUgKxxwurQrPOAtS/rVocjj3Z
         QrFU+4wAGxD5Kee6Br9a1IT0NJuXvE4h2tNa/NJ6kWLia+5NrIMsnY4dJR9dH4yUv55i
         ZEEbH0opNM8qmtkrKRPcUtMOJOjDi66IdKDwB7QtpNTeZSRTTzOyhI290/whvo2ZqcMZ
         DnV8DUh/CptzDAyqn4zy3iqBoAj+Cw20vkCp2gtN+W977hkiO7poDQ3V/luLmzPPNHci
         +dOs1MFbnlcMV1c9htMOl2d6ssIU6cT3Js1fGlv5Sjn/xO07nWRXhnGMBjzyPKKhgo6W
         Gflg==
X-Gm-Message-State: AOAM532bAq8/8AJDxwuM+rP4rrj88criQ/3ECvy0iv/TU64BtiDpsOVl
        TGbv98+0lOKmJTjzRoCoq42wvKfx6iHh/RpaGVsuIw==
X-Google-Smtp-Source: ABdhPJxUpkwe41vVtmTrJYV492tkArFcWpTZmO6apTAf5RO4udVotcMW58RvB7J4AJBtKozsIxNZvmHe6s1rATG0IFE=
X-Received: by 2002:a4a:a6c2:: with SMTP id i2mr3714787oom.92.1627579019804;
 Thu, 29 Jul 2021 10:16:59 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 29 Jul 2021 12:16:59 -0500
MIME-Version: 1.0
In-Reply-To: <e1a28bed-a2a9-2bf2-d0f0-3f608a538f69@codeaurora.org>
References: <1627147740-11590-1-git-send-email-akhilpo@codeaurora.org>
 <CAE-0n52mEy1GReYwcVrffT2KOy4EHMHH-RyCJ_mmxhaeXwGdYA@mail.gmail.com> <e1a28bed-a2a9-2bf2-d0f0-3f608a538f69@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 29 Jul 2021 12:16:59 -0500
Message-ID: <CAE-0n50-1eN3wwDukJi0JoTxCKnYx8NT1Ap2r0WDftQ621iBqQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7280: Add gpu support
To:     Akhil P Oommen <akhilpo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm@vger.kernel.org
Cc:     Jonathan Marek <jonathan@marek.ca>, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Andy Gross <agross@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Akhil P Oommen (2021-07-28 00:17:45)
> On 7/27/2021 5:46 AM, Stephen Boyd wrote:
> > Quoting Akhil P Oommen (2021-07-24 10:29:00)
> >> Add the necessary dt nodes for gpu support in sc7280.
> >>
> >> Signed-off-by: Akhil P Oommen <akhilpo@codeaurora.org>
> >> ---
> >> This patch has dependency on the GPUCC bindings patch here:
> >> https://patchwork.kernel.org/project/linux-arm-msm/patch/1619519590-3019-4-git-send-email-tdas@codeaurora.org/
> >
> > To avoid the dependency the plain numbers can be used.
>
> But, won't that reduce readability and make things prone to error?

The numbers are not supposed to change so maybe it reduces readability
but I don't see how it is prone to error.

> If
> the other patch doesn't get picked up soon, we should try this option.
> We like to get this patch merged in v5.15.

The clk binding is already picked up but Bjorn would need to merge it
into the qcom tree to use it. I don't know what the plan is there.
