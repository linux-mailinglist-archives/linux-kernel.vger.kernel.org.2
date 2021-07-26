Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFFE13D69FD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 01:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbhGZW3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 18:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbhGZW3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 18:29:41 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E47C061764
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 16:10:09 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id w6so12910777oiv.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 16:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=xr0OBaCUg1lxQVZHduo3c61UxOOaowAxR3nQvbPDaoY=;
        b=QwVfGNt7gpX6PM91jokNd1t6eoJKDUoFjR6ns0yBFwv02M0IASxWzmMO2p3H5OiEGd
         Wh5N352seodJsgCNNXzQToD1USgX+FAOtPMWPYJ40FyAvBw0ZCrHQxufbC7nPDBkrjsQ
         0rKmaPXPudwqpi/FK45eHKVJDOF2A5NuWzZBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=xr0OBaCUg1lxQVZHduo3c61UxOOaowAxR3nQvbPDaoY=;
        b=r8UB0OSupFKu7MJ03D8q04PXEVGzUwmzS6eehmZCSxPEkAEFcN541UVf/owuMtMdxJ
         3FHNh4NQZ0oemgaJk9l+tMTDyKnUxHyNACMK608KeDHF3kbizFOWdrAQe3g+Y6jOYoxQ
         5Y83fC17sM8dI40rlamSAFtAOtAsMikzDhxmbAgylVDgdTRVCD3j9bdznKLMqEu2KQvd
         bVh0nopWqrHfx8xGrm6V1vM2cymNs0gR1FNmt35Fm6yIdmkJhYI8XEblFU1MYyEpqX7i
         ra63aV3Au+HmOinJjn9+eh8yVDgFMVzIZqybBfPr4sLq2ITaIpMhQBL4H5b5xvCSx6vg
         /+Dw==
X-Gm-Message-State: AOAM532h1qrPU8G09v131LXDwsGL0m7j8/dVcfrSWTYz0S3JI/2OY9Iu
        AOlU1egCssCB80o3VHw1irFbueBmystomNeJlH4S2A==
X-Google-Smtp-Source: ABdhPJzhOR7wBEMb7tO2EFPOHPqSOdE1r/dNy7lCBVwnAnv1ifXRtKEBUbv8pmKc7JZKomqIgA9fYXI3uJFwoEnhJCQ=
X-Received: by 2002:a54:468d:: with SMTP id k13mr955643oic.125.1627341008513;
 Mon, 26 Jul 2021 16:10:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Jul 2021 19:10:08 -0400
MIME-Version: 1.0
In-Reply-To: <1627029074-23449-1-git-send-email-skakit@codeaurora.org>
References: <1627029074-23449-1-git-send-email-skakit@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 26 Jul 2021 19:10:08 -0400
Message-ID: <CAE-0n53bqJ8iBwBRwwf=-Fob5AObe+Nscz5RqN5G7rM8JDXv8Q@mail.gmail.com>
Subject: Re: [PATCH V7 0/3] Convert qcom pmic gpio bindings to YAML
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        satya priya <skakit@codeaurora.org>
Cc:     Das Srinagesh <gurus@codeaurora.org>, kgunda@codeaurora.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting satya priya (2021-07-23 01:31:11)
> satya priya (3):
>   dt-bindings: mfd: pm8008: Add gpio-ranges and spmi-gpio compatible
>   dt-bindings: pinctrl: qcom-pmic-gpio: Convert qcom pmic gpio bindings
>     to YAML
>   dt-bindings: pinctrl: qcom-pmic-gpio: Remove the interrupts property
>

Which tree is this series going to be merged through? bindings, gpio?
