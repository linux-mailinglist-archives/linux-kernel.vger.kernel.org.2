Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB86376AF1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 21:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhEGUAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 16:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbhEGUAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 16:00:02 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F265C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 12:59:02 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id l6so9801937oii.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 12:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=1Ev/AqlCuAuxmBP5/qpJD12HiDRJtO97+BpGUTNb6rM=;
        b=RM1pf/f5OHyMOspoU/mxDuhXfnGnk3N8Yt8iAD4/3qGiKa4Fpl6bFuqYYK685F0Qra
         j8l4Cdm6WePTc6xFMcFqIo7HauGjPoWbTmrp6GAgwIoLWlji8gU0eIySUu6XUkEWj9lx
         +6yw0GzV2Jzll+k5Jsa9Mvf6StSpabvsVYU0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=1Ev/AqlCuAuxmBP5/qpJD12HiDRJtO97+BpGUTNb6rM=;
        b=Ohe3/RSsURkC7HFCC3RTWt11+k9cIRa9KiX89Mu0Niujl8eX631E6Uy6iXTcCFF7ZC
         26japaCowFeuIFk/PnU10EHkzGK3A+y10qsuEtDIdvUAtHswVcsvX8pplbgveb9OFHXt
         j4z2uh+EK6xmzhsATe6/6LLHxNTU9g+ZswgmKXNJy5g4s3qTDrtNP4+TjT5cnyuRARJR
         mKrb0IjTW05ALC1MJeGdcrgxS6l5704g8Je7owqz6RiFQG+K9I4QMBJArk24Zl5YD7Ok
         ca20OiBsVv4eQo/tFdEVk//Ahf1CFrQrTuj85fwmyFWh2/xeWqaeRwhGNLYQldJ6qGJk
         73TA==
X-Gm-Message-State: AOAM532crV++pNg8UzeA8gWuZBcxsH3cPv5dsOi8O9kHf6GAOLci59H+
        Ogf5wVepVbg92f4Py8Hfpzw8xQauD+cGEZR2c3s1pslux+U=
X-Google-Smtp-Source: ABdhPJwYQ0v6l65w9JuRCI64AGgQD1xZrXIhLQyHL/uOFiEknxIY9lk8wZUueo2xEF0siVW3cor1TnMZGmvB6RmCAog=
X-Received: by 2002:aca:211a:: with SMTP id 26mr8203109oiz.19.1620417541429;
 Fri, 07 May 2021 12:59:01 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 7 May 2021 12:59:00 -0700
MIME-Version: 1.0
In-Reply-To: <1620382648-17395-2-git-send-email-pmaliset@codeaurora.org>
References: <1620382648-17395-1-git-send-email-pmaliset@codeaurora.org> <1620382648-17395-2-git-send-email-pmaliset@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Fri, 7 May 2021 12:59:00 -0700
Message-ID: <CAE-0n53KTeF9NOrb+x7P1AG53FENRBGtCEcSxronBpJoww3jew@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: pci: qcom: Document PCIe bindings for SC720
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Prasad Malisetty <pmaliset@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        mgautam@codeaurora.org, dianders@chromium.org, mka@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Prasad Malisetty (2021-05-07 03:17:26)
> Document the PCIe DT bindings for SC7280 SoC.The PCIe IP is similar
> to the one used on SM8250. Add the compatible for SC7280.
>
> Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.txt | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> index 0da458a..e5245ed 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> @@ -12,6 +12,7 @@
>                         - "qcom,pcie-ipq4019" for ipq4019
>                         - "qcom,pcie-ipq8074" for ipq8074
>                         - "qcom,pcie-qcs404" for qcs404
> +                       - "qcom,pcie-sc7280" for sc7280
>                         - "qcom,pcie-sdm845" for sdm845
>                         - "qcom,pcie-sm8250" for sm8250
>
> @@ -133,6 +134,22 @@
>                         - "slave_bus"   AXI Slave clock
>
>  - clock-names:
> +       Usage: required for sc7280
> +       Value type: <stringlist>
> +       Definition: Should contain the following entries
> +                       - "aux"         Auxiliary clock
> +                       - "cfg"         Configuration clock
> +                       - "bus_master"  Master AXI clock
> +                       - "bus_slave"   Slave AXI clock
> +                       - "slave_q2a"   Slave Q2A clock
> +                       - "tbu"         PCIe TBU clock
> +                       - "ddrss_sf_tbu" PCIe SF TBU clock
> +                       - "pipe"        PIPE clock
> +                       - "pipe_src"    PIPE MUX

Is pipe_src necessary? Is it the parent of the pipe clk? If so, please
remove it and do whatever is necessary on the pipe clk instead of the
parent of the clk.

> +                       - "pipe_ext"    PIPE output clock

Is pipe output different from pipe?

> +                       - "ref"         REFERENCE clock
> +
>
