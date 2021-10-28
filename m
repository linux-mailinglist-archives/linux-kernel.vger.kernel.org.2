Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E2D43F2E7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 00:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbhJ1Wli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 18:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbhJ1Wlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 18:41:37 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59C2C061767
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 15:39:09 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id bm39so53326oib.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 15:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to;
        bh=NL2ODXrSm6ZhmFLsby2Ei6hqV0q649I4yE01/l32yPQ=;
        b=EzEx8hrE3mS6JZIoGFLUs+ApD5NhXSxVevnPM4sWKpiHe9d/BAezq0wvniKjXvDBhq
         HbWNzFYwXZXAiTw8rUlunRoFkU17UHGYFAGyaiGznIRKixX8NruEmgqBx06xaK3nBDYA
         4vyCtXotGrGKOamqpYsaqALhn/KSPva5VoJLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to;
        bh=NL2ODXrSm6ZhmFLsby2Ei6hqV0q649I4yE01/l32yPQ=;
        b=P0cbzga4bwzq4IfLRXWoUfska9dev0B0+IvekNmliIwhj8aw7xd1ZQ3YOldh0Nt+6F
         /u+Lg7wIUhHf1peIfpAMK5Zt0uMHpQNUrVflEOs5m6Q5PPu+ATa+3iktPmdpqIuBCnER
         zCYUqcy1qEf99ZymFe6mJb22OzGS5R7Y7nnaQydjosFUP0j7OpOyJ0HDbLqq/IhMHio2
         CVL8EazeBvf6Jq7mk0sS66q8rG4SE7JJhDjqEqkxZgND7okt45deZJzfNiFu+D+Rqidc
         qI15dj9XOsTqz8lVL9MjFJrrzahqEqqOkNRDa42qzDCkkpz2sMPYOFk6SsCFgT3DYATN
         l2aQ==
X-Gm-Message-State: AOAM532cBEEJDYtjCttozetYbIIQdhn+N1Sa56YNMczaQDXQYE6t3zQD
        O1ndZnKMD1g2Q8VmwAx877hFO5hpxJ3SP1mIPl0gMQ==
X-Google-Smtp-Source: ABdhPJwNY2fhQGXvyKhKxiZbkYaL+OKNaCpFlag84zdAsz24L+gCDmW3Zn3S1HtqV5VnAkP3JQPd6x+9VqfiQqM2IKQ=
X-Received: by 2002:a05:6808:2124:: with SMTP id r36mr5406711oiw.64.1635460749103;
 Thu, 28 Oct 2021 15:39:09 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 28 Oct 2021 15:39:08 -0700
MIME-Version: 1.0
In-Reply-To: <CAE-0n51PGVQ6GT7RMTQajEM54NLOUZBGPkVKmVaG1JV7Fgv9Ag@mail.gmail.com>
References: <1634234784-5359-1-git-send-email-pmaliset@codeaurora.org> <CAE-0n51PGVQ6GT7RMTQajEM54NLOUZBGPkVKmVaG1JV7Fgv9Ag@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 28 Oct 2021 15:39:08 -0700
Message-ID: <CAE-0n51noyV7KW9JcY5-TdERC_RSLQDtdqMR4_LDFHJGGE3yiw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7280: Add pcie clock support
To:     Prasad Malisetty <pmaliset@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org,
        sanm@codeaurora.org, vbadigan@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2021-10-21 11:06:53)
> Quoting Prasad Malisetty (2021-10-14 11:06:24)
> > Add pcie clock phandle for sc7280 SoC and correct
> > The pcie_1_pipe-clk clock name as same as binding.
> >
> > fix: ab7772de8 ("arm64: dts: qcom: SC7280: Add rpmhcc clock controller node")
>
> This is wrong. Should be
>
> Fixes: ab7772de8612 ("arm64: dts: qcom: SC7280: Add rpmhcc clock controller node")
>
> > Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > ---
> > This change is depends on the below patch series.
> > https://lkml.org/lkml/2021/10/7/841
>
> Why doesn't that patch update this clock cell then?

Looks like Bjorn already picked it up so that answers my question.

>
> > ---
> >  arch/arm64/boot/dts/qcom/sc7280.dtsi | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > index 39635da..78694c1 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > @@ -569,9 +569,10 @@
> >                         reg = <0 0x00100000 0 0x1f0000>;
> >                         clocks = <&rpmhcc RPMH_CXO_CLK>,
> >                                  <&rpmhcc RPMH_CXO_CLK_A>, <&sleep_clk>,
> > -                                <0>, <0>, <0>, <0>, <0>, <0>;
> > +                                <0>, <&pcie1_lane 0>,
> > +                                <0>, <0>, <0>, <0>;
> >                         clock-names = "bi_tcxo", "bi_tcxo_ao", "sleep_clk",
> > -                                     "pcie_0_pipe_clk", "pcie_1_pipe-clk",
> > +                                     "pcie_0_pipe_clk", "pcie_1_pipe_clk",
>
> This can be split from the patch to fix just the name in one patch and
> then add the pcie1_lane phandle in the next patch. That way new features
> aren't being mixed together with the string fix.
>

In addition, I see that Rob sent a patch[1] that fixes the interrupt-map
in the pcie node. Can you send a similar patch for sc7280? It looks
wrong. We need another two zeroes like on sdm845.dtsi. So please resend
this series with three patches and the appropriate Fixes tags.


[1] https://lore.kernel.org/r/20210928192210.1842377-1-robh@kernel.org
