Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC9A4260B3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 01:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbhJGXst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 19:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhJGXss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 19:48:48 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497E8C061755
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 16:46:54 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id v2-20020a05683018c200b0054e3acddd91so5060256ote.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 16:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=gVE/1ADkJ8MTOhXMg6RxOoE4mte4x5DusQmTFFGGsBU=;
        b=WoVlPccxHbuRTr5ECO9lMIta1ZkIBn8OSGWFIgYT2q5pUtArA7URZdzzXp35EDfPSy
         KEigeax+oRE1HBvTYEr4YUpbI8NLvI0ma+lLdK38aDH4lzNGWrgK6AUTcv/yalhej6S0
         NOlhvK9kCoW2oDdzEVJoL/HY6DGgCG1vxQODk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=gVE/1ADkJ8MTOhXMg6RxOoE4mte4x5DusQmTFFGGsBU=;
        b=QudUWa1KJpsCaJttbMOyCdTedlNV3gubkN8Z3emxKea0walr1Nwdv/z1O01NhKpv7S
         RdQ5gyk2ZtHgffCheICmcqVQR4pCbbcs6pptSosW8OeC94A+kpyADS0Y3vP+5f9PszSc
         LjmwUBNjamXZ6lplem8BSIrCAObDLRLbAQ8kHSIpA+cB6Y9sSkbU5v5BF+NvLYPTzE7a
         n2cxY1FXUtYGFUAuEDP8ugn5vM0jSKFfEWvQYsTABR+hspW0ZLCK6hl38kyk0n0dQWzb
         ADFxL2I0xsYF7vLodk5mbE+ncjqwIhuYaw+s+uuJZUphrvdBcm3tgCxzEcJN9JcbIrSG
         9EKg==
X-Gm-Message-State: AOAM5309fPetOoC3Acqdh3DOWzVHI2tT/Fpck92mWNa+Uf4FfFLyHdcd
        RNNCcdZlHWKcfT6bpBywyghdGbZmZUSQ0WblyEHxdw==
X-Google-Smtp-Source: ABdhPJxlFP1/S8B0xAWuFNOhsUPgTNfrPc0wkMbmhmTCldN7UU+Qjct3D18HQXZEaHm/3kIj7Vvs8oXLVNcbNBEbTbE=
X-Received: by 2002:a9d:5a90:: with SMTP id w16mr21830oth.126.1633650413709;
 Thu, 07 Oct 2021 16:46:53 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 7 Oct 2021 19:46:53 -0400
MIME-Version: 1.0
In-Reply-To: <20211007140854.1.I70615769f27bbaf7e480419d0f660f802b1fea43@changeid>
References: <20211007140854.1.I70615769f27bbaf7e480419d0f660f802b1fea43@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 7 Oct 2021 19:46:53 -0400
Message-ID: <CAE-0n53Ch+YYTzO31w0Gv5zvn6oUJGRMGxqdO_h4_ULaQ+7_fA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Add Herobrine
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2021-10-07 14:09:11)
> Herobrine is a Chrome OS board/platform based on the QCA SC7280.
> Add a .dtsi for the platform parts and a .dts for the board
> specific bits. Currently the .dtsi has everything except the
> compatible strings, things will likely get shuffled around in the
> future as we learn more about the differences between boards.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
