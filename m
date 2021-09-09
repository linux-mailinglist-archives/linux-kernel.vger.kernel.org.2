Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C2B405D3E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 21:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244680AbhIITRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 15:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237476AbhIITRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 15:17:33 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7687C061757
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 12:16:23 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id c19-20020a9d6153000000b0051829acbfc7so3858292otk.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 12:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=cSmbp5/L9ha5GqET54HDt7D9mL9+6axiOiis4Gfgy0A=;
        b=J7tpChOVmRXr6mO9JXCHMdOvk4p0cPikxU+5fdfOxAHih+tlrVrr93ybFI033NsXG/
         TA6xatfE3lot3FNxD3CPACGKVBBDiuwQuJe6asmVBdzw3KqwwjFziGRFKtv4etUkVgDH
         narWWYzLFXh/Fz0K/k2wbqn/J/o8Pl1MlMVgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=cSmbp5/L9ha5GqET54HDt7D9mL9+6axiOiis4Gfgy0A=;
        b=EOkR6aXMES1UAI+lm3v3R4oQlsj4zEETE1GM0QUorss1oBwNsE+rNbQfaX14cRZDD5
         Ly15ExpHiQsaYIbjRl3GzXhWNkMF99k3a+xf6HYDAvaCNdQquCKLld5yKojrcFhVl8q5
         TZNUO/cNwAGLJgE9GMIhL4gO3WSGb06UVw1wyKoMbyS6QLfEXPTBYWDoKKnh9+UKZLAh
         x/PU5gsiH7uJrsQMui4WBoBYIRIlFJLkPCisS9Cr5wiaGB9SO9DsPc1y0cn6PWaiU7V0
         qg1Z7HoF6y6XgFtXAiTbk5pvpUdy1bwd5PE2OJ87ck+XdrByrnPB7/D1lwAwaZ7hmsUW
         HsnQ==
X-Gm-Message-State: AOAM531kQaE0AWPGqTR3ewZbinTg6gQQRU3masy4xMZriVHLitvoQ+Bc
        1hcKiZo4/i3Aj1kaAtnTAhXMSy54JBh1NZXFQaKwFw==
X-Google-Smtp-Source: ABdhPJwNMb6xrFh9MNm05MP1xTJIVmxyS1vwnqlVSoojIVFhs5ssGoX2lnMOZYSXlkeJHlJvbbnBneqO1bMKVhpM3ZQ=
X-Received: by 2002:a05:6830:18c7:: with SMTP id v7mr1296037ote.126.1631214983260;
 Thu, 09 Sep 2021 12:16:23 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Sep 2021 12:16:22 -0700
MIME-Version: 1.0
In-Reply-To: <1631209245-31256-5-git-send-email-pmaliset@codeaurora.org>
References: <1631209245-31256-1-git-send-email-pmaliset@codeaurora.org> <1631209245-31256-5-git-send-email-pmaliset@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 9 Sep 2021 12:16:22 -0700
Message-ID: <CAE-0n50OXwe6emqCCH4=P=pHFS=RcgeZ2V6V7esFT_CO9mX6pw@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] PCI: qcom: Switch pcie_1_pipe_clk_src after PHY
 init in SC7280
To:     Prasad Malisetty <pmaliset@codeaurora.org>, agross@kernel.org,
        bhelgaas@google.com, bjorn.andersson@linaro.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org, svarbanov@mm-sol.com
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, mka@chromium.org, vbadigan@codeaurora.org,
        sallenki@codeaurora.org, manivannan.sadhasivam@linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Prasad Malisetty (2021-09-09 10:40:45)
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 8a7a300..db62b3c 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1167,6 +1169,16 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
>         if (ret < 0)
>                 return ret;
>
> +       if (of_device_is_compatible(dev->of_node, "qcom,pcie-sc7280")) {

What happened to the approach discussed in v5 of this series where this
is all baked into the device match data?

> +               res->gcc_pcie_1_pipe_clk_src = devm_clk_get(dev, "pipe_mux");
> +               if (IS_ERR(res->gcc_pcie_1_pipe_clk_src))
> +                       return PTR_ERR(res->gcc_pcie_1_pipe_clk_src);
> +
> +               res->phy_pipe_clk = devm_clk_get(dev, "phy_pipe");
> +               if (IS_ERR(res->phy_pipe_clk))
> +                       return PTR_ERR(res->phy_pipe_clk);
> +       }
> +
>         res->pipe_clk = devm_clk_get(dev, "pipe");
>         return PTR_ERR_OR_ZERO(res->pipe_clk);
>  }
