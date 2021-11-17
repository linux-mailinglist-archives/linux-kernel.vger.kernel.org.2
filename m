Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6B2454131
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 07:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbhKQGub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 01:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbhKQGu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 01:50:28 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DD8C061746
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 22:47:30 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id m6so4319335oim.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 22:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=Zak65d0llgOFfhY3hybLsYtI2ouYCuOebdLehBe3uDQ=;
        b=kJDBoZqckhA1ufpBGBrbzY8MhU4rh7qrsdI+cIC5Onil2qj5n8EcSnY0WEtjtyGLH6
         IE/58w4qBV0Dg4fs1Ihrh+8iFniCCSX+CO2qsZmSt4RYPtxda+aEyP5JJWqSuRzIdoZX
         Tf65fEItflO3+FzH0pKzrmGdQZ+jfOE+Ak2cg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=Zak65d0llgOFfhY3hybLsYtI2ouYCuOebdLehBe3uDQ=;
        b=L9ivjjjWMB8X9w2d0WwWADWYoy08Wmm8zV8Tx2BB2yrc/sf7wN61R/s8f62o+2gZ7e
         zHKrLmxeKTsSF50Px9TtGhGVoYhdyPg5eBvzg90y/7h/Bq/XXE3YogF1m0L1wbKZh2uC
         cZaWcwfwWl88RCbwDsvEeU/dV+8UkHwptBStk4+ScPuWknVuoFQ+J7ZIHSxCryPRP33a
         CK3ZP+vJIFv51o7CMQkxwDrSD0IUxMFPMJ0lHRErVyE8PrJWOcE7HhDaT/QIMlt8wxeL
         BwLwgxI1Q8ejaFkuEmvo2PJ51h92g76xBb3xrW8B3FWX5rbruQEejaOpMlvGUlwa3Sq6
         YNHw==
X-Gm-Message-State: AOAM530NWZqOx81WiMJIqz7gyELZlnlQ9BSSjKILDtd3nNofbhLoyt5S
        Pl+QkvhCAU530kFY0TncAxIsb/4t/at6H8T1r4dXpw==
X-Google-Smtp-Source: ABdhPJxXlEg2JLK1FcPrTGa04zmneplUZhBuAZ+dBWt9jp44No5UGmnqM6QBox1hxIZFuPlSyhlYpe0evSb69UmBqWU=
X-Received: by 2002:a54:4506:: with SMTP id l6mr58797206oil.32.1637131650176;
 Tue, 16 Nov 2021 22:47:30 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Nov 2021 22:47:29 -0800
MIME-Version: 1.0
In-Reply-To: <20211103234410.1352424-2-bjorn.andersson@linaro.org>
References: <20211103234410.1352424-1-bjorn.andersson@linaro.org> <20211103234410.1352424-2-bjorn.andersson@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 16 Nov 2021 22:47:29 -0800
Message-ID: <CAE-0n52XWvOsWm36+ucuwbOa4ceKRAYWFtPnD3Xg5emfiQGK-Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] phy: qcom: Introduce new eDP PHY driver
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2021-11-03 16:44:10)
> Many recent Qualcomm platforms comes with native DP and eDP support.
> This consists of a controller in the MDSS and a QMP-like PHY.
>
> While similar to the well known QMP block, the eDP PHY only has TX lanes
> and the programming sequences are slightly different. Rather than
> continuing the trend of parameterize the QMP driver to pieces, this
> introduces the support as a new driver.
>
> The registration of link and pixel clocks are borrowed from the QMP
> driver. The non-DP link frequencies are omitted for now.
>
> The eDP PHY is very similar to the dedicated (non-USB) DP PHY, but only
> the prior is supported for now.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
