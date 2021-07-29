Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3693DAA28
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 19:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbhG2R3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 13:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhG2R3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 13:29:42 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE54C061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:29:38 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id o185so9340617oih.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=nuL9Gtrngyb6HozKG8XOhySmiHppyZ4SPKwk+KQp+Zc=;
        b=JdtXha2KVXzKZ2i+/dg6/TqTi8BKHsyrpUafLCGrH3a4/NrAgfn9+1VV61+cKYypI/
         zQis9HjO0mRR/RhoP0rU+vdBW8oNeszZsNBI9t+oY9amV7+Q38G2zdiUy58bnHalNRVT
         BzZ5MybexeU8CXngY8eZukXE4Gw0vor1OAyfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=nuL9Gtrngyb6HozKG8XOhySmiHppyZ4SPKwk+KQp+Zc=;
        b=F3MICoyy0vPzrthvisFOSWTmm/h2SQwWWEw/GbV30ywsfKzwu3TpVINna2D9G74ecA
         yVrwL2ctyrDTtrb6whtosfPNLMeMjjzXHe2P16ulWbcppfuK2e29tEoKGOgrSkstTDRv
         LBSTYTLdIf4yFVO2w7uv0rHcPG8m81xCTvgCqVLBb61wBLbn6bscj5DsLTjO3HgGOAuk
         WBE4u3PwjKelSEHl/oZaYAHXT4ndvmcvsH6i7oAl/Jspy1ai66CefHgjlfzTJsyIZHzt
         22rHQcRwDTy7isoYQkukOYRF2Fm+AFx+jOW4M6In8+1N8Gix7OQ9GTft85++5uhOfNT2
         HY1A==
X-Gm-Message-State: AOAM530XMCFbwTkw2AceRgGgbSV/XlBDsho+Ng5tdzceDIobp53nnQZF
        Z9Ixwi5NaE3Ym5x1CVjsFYfRvAgih48s+xc+5fCwSA==
X-Google-Smtp-Source: ABdhPJwi3G9rwu5lrD06uFLjaL3kNc79dxhFbRDbNktWD54FVP7PGqPqCjr1IvDBEJd9gDzQ74iPrFgSWrFNyjY6nRc=
X-Received: by 2002:a05:6808:114a:: with SMTP id u10mr3928249oiu.19.1627579778357;
 Thu, 29 Jul 2021 10:29:38 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 29 Jul 2021 12:29:38 -0500
MIME-Version: 1.0
In-Reply-To: <20210728172330.v3.2.Iea8318d85a23f0167fd523ea85df5630147649f9@changeid>
References: <1627473242-35926-1-git-send-email-akhilpo@codeaurora.org> <20210728172330.v3.2.Iea8318d85a23f0167fd523ea85df5630147649f9@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 29 Jul 2021 12:29:37 -0500
Message-ID: <CAE-0n50GLdByWnMxf2AZJ0r1pdZFRwG3b5t3V69wZY6H6pf32A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: sc7280: Add gpu thermal zone
 cooling support
To:     Akhil P Oommen <akhilpo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>,
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm@vger.kernel.org
Cc:     Jordan Crouse <jordan@cosmicpenguin.net>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Akhil P Oommen (2021-07-28 04:54:02)
> From: Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
>
> Add cooling-cells property and the cooling maps for the gpu thermal
> zones to support GPU thermal cooling.
>
> Signed-off-by: Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
> Signed-off-by: Akhil P Oommen <akhilpo@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
