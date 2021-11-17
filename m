Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0184540E9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 07:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbhKQGhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 01:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbhKQGhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 01:37:50 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E05C061764
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 22:34:52 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id q25so4352185oiw.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 22:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to;
        bh=W9nBJYQ47ZxrMV6bcLPL2xQhR09icnS5iG5YGO5CZkg=;
        b=BRKJ7Kgn4h04/ugFpZOdSRfxGVCK48Z3uvEiNI/i+4ANN7vV5j1DY5cXAjyRzs3/vY
         t4WmQcMqkh7jXMNLlPzsHpHAj8apOlE5O6TaCwRr9wRWzUfxNGv3LbHEFgVEaPE1m4c9
         U1MYt+rjkHC/yxXbI1f+9ar5dk+Xsov9fFcMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to;
        bh=W9nBJYQ47ZxrMV6bcLPL2xQhR09icnS5iG5YGO5CZkg=;
        b=3tBRxv87Z3uqmXdRUKW5CuL+oVdi4fgDRii3sP439JhgeobgoFxcrP7Wdk71kdrPs/
         Axc9nZvIzwGBivS4EhOItXnl/ehBBIeCRpCb3aY50HIbkkrk64xnukSW8gXd1IuTpy2m
         c4Xadxudh8UmrgaSX9wAX0/JSpgIEVtGKoAmL1b+P2Nejg3ADiuqfNL8y52qOoa3WlqB
         bjFQ1FdXmcCvh9iGLbuR8HEo1iRlzbTOW1b2k0QZITAwKNj6T/DuN+ITMHqeQGdnSive
         SLVnqogPtdp9yIoIKXgO29J/aLB/RMYs8/bBvNgG36ZZdgdIPusJMQ2DaeAxj/vbL60e
         X6oQ==
X-Gm-Message-State: AOAM533YVyZTONPEXL/5fL1F7p+y4F5OuYTHhwz15sTwK1E4jh69gi+0
        FR/ia4WaujT4XMP/ncFeNTIdIHw49xCD0H4dIPa83w==
X-Google-Smtp-Source: ABdhPJx8JVromClhtbCHPxYPkkFPqkVX+eXLMb6mIVFF85hfHjPLfK1usV9mYns8iLfYiwwMk8WYJH3OaOMkQibPSjk=
X-Received: by 2002:aca:2319:: with SMTP id e25mr58605624oie.164.1637130891469;
 Tue, 16 Nov 2021 22:34:51 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Nov 2021 22:34:51 -0800
MIME-Version: 1.0
In-Reply-To: <1637060508-30375-3-git-send-email-pmaliset@codeaurora.org>
References: <1637060508-30375-1-git-send-email-pmaliset@codeaurora.org> <1637060508-30375-3-git-send-email-pmaliset@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 16 Nov 2021 22:34:50 -0800
Message-ID: <CAE-0n53+Wt-FL38EnQhgZLEsnuKK88L7yN4dg42OZ=hVYp8XEg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: sc7280: Add pcie clock support
To:     Prasad Malisetty <pmaliset@codeaurora.org>, agross@kernel.org,
        bhelgaas@google.com, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com,
        manivannan.sadhasivam@linaro.org, mka@chromium.org,
        robh+dt@kernel.org, svarbanov@mm-sol.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Prasad Malisetty (2021-11-16 03:01:47)
> Add pcie clock phandle for sc7280 SoC.
>
> Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
