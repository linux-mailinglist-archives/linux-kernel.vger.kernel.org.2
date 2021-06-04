Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE4239C2C6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 23:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhFDVqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 17:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbhFDVqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 17:46:20 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6464C061767
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 14:44:33 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id x22-20020a4a62160000b0290245cf6b7feeso2575726ooc.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 14:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=JC25WRkZBCsb3Y5fTmPTp2hPTJRZh/K4xt7YQY7D4O4=;
        b=JEuNpd7gylFZbn17vVqmqdfMkxy98APrgbMp+o9mS3siWPpRSQ5uuQC27Gq+IxH3f/
         Uw+n45L9SrKQgTZzpmwBj276JTiqal+9MsRFOLtEithQ8VpG70/P3q64NpP/EmQW/sol
         OxiBdWTz0xPY6SHodkTBiCS7Ga0O9GDcAtfUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=JC25WRkZBCsb3Y5fTmPTp2hPTJRZh/K4xt7YQY7D4O4=;
        b=J5xFBQUIvTstVReWg4QxiExGFtGd2aovH6AoZHGOAThLcseAiPpVdg2D8KnZfZRqIt
         WmC+NNGg8kB3yRRaZS4DhZ6kVDgNJV4+MQ/A6YGV3pWqPUUkBqeKY2Jb9Ts3h5ESB0jh
         Si5TrLJnli7OYACDFHOXclUWVyuefLJJBy4nwYBKFVdJhsUQVQBLFpqdYeqf5sUssNEr
         ekBbCmvmH9e+MfJWCJP08xH6MZCKp7zXxtsZJjr9G3cTPWjv4eFq1MW/n3hU8ricnBtJ
         dxKUCHUO6wHM/UfJbQzNrWEc5almD8frxz5ynr3/fN3uxsB9r0iSMDyFOwuI4sgy/hbV
         zcLQ==
X-Gm-Message-State: AOAM530kl0bpnhSVJtVrKEYyPAiVaAt0VN9lnSLIal1RKyqVkTlSTF62
        unVtR+5iL39vCrK0s+1UvYrRzdN9XYVZrPtYxspAnw==
X-Google-Smtp-Source: ABdhPJy6w6LzfZQraXTUpEoGT0ueZEnZUPP6hi0L9uLghxBapXi3lqND0wjFan+pdkwveTfBuC+LSOhCIDuLCnteMIM=
X-Received: by 2002:a05:6820:1048:: with SMTP id x8mr5240459oot.16.1622843073335;
 Fri, 04 Jun 2021 14:44:33 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 4 Jun 2021 21:44:33 +0000
MIME-Version: 1.0
In-Reply-To: <cb2a6cd35df42314c5e5230bcac752be@codeaurora.org>
References: <1620382648-17395-1-git-send-email-pmaliset@codeaurora.org>
 <1620382648-17395-2-git-send-email-pmaliset@codeaurora.org>
 <CAE-0n53KTeF9NOrb+x7P1AG53FENRBGtCEcSxronBpJoww3jew@mail.gmail.com> <cb2a6cd35df42314c5e5230bcac752be@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Fri, 4 Jun 2021 21:44:32 +0000
Message-ID: <CAE-0n52y3yuyOrexC+EsnsX6ULDwKDz1PczGwHB211hKu=uj1g@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: pci: qcom: Document PCIe bindings for SC720
To:     Prasad Malisetty <pmaliset@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        mgautam@codeaurora.org, dianders@chromium.org, mka@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Prasad Malisetty (2021-06-04 04:26:57)
> On 2021-05-08 01:29, Stephen Boyd wrote:
> > Quoting Prasad Malisetty (2021-05-07 03:17:26)
> >> Document the PCIe DT bindings for SC7280 SoC.The PCIe IP is similar
> >> to the one used on SM8250. Add the compatible for SC7280.
> >>
> >> Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>
> >> ---
> >>  Documentation/devicetree/bindings/pci/qcom,pcie.txt | 17
> >> +++++++++++++++++
> >>  1 file changed, 17 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> >> b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> >> index 0da458a..e5245ed 100644
> >> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> >> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> >> @@ -12,6 +12,7 @@
> >>                         - "qcom,pcie-ipq4019" for ipq4019
> >>                         - "qcom,pcie-ipq8074" for ipq8074
> >>                         - "qcom,pcie-qcs404" for qcs404
> >> +                       - "qcom,pcie-sc7280" for sc7280
> >>                         - "qcom,pcie-sdm845" for sdm845
> >>                         - "qcom,pcie-sm8250" for sm8250
> >>
> >> @@ -133,6 +134,22 @@
> >>                         - "slave_bus"   AXI Slave clock
> >>
> >>  - clock-names:
> >> +       Usage: required for sc7280
> >> +       Value type: <stringlist>
> >> +       Definition: Should contain the following entries
> >> +                       - "aux"         Auxiliary clock
> >> +                       - "cfg"         Configuration clock
> >> +                       - "bus_master"  Master AXI clock
> >> +                       - "bus_slave"   Slave AXI clock
> >> +                       - "slave_q2a"   Slave Q2A clock
> >> +                       - "tbu"         PCIe TBU clock
> >> +                       - "ddrss_sf_tbu" PCIe SF TBU clock
> >> +                       - "pipe"        PIPE clock
> >> +                       - "pipe_src"    PIPE MUX
> >
> > Is pipe_src necessary? Is it the parent of the pipe clk? If so, please
> > remove it and do whatever is necessary on the pipe clk instead of the
> > parent of the clk.
>
> Here pipe_src is MUX. Newer targets require changing pipe-clk mux to
> switch between pipe_clk and XO for GDSC enable.
> After PHY init, need to configure MUX.

Ok. I see, so we have to change the parent of the parent of the pipe
clk?
