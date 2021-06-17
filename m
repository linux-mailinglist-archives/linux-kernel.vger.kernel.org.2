Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBDB3AB4EB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 15:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbhFQNkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 09:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbhFQNj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 09:39:58 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1170C0617AE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 06:37:48 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id p13so5088007pfw.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 06:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8YG5vMsHcsKskVBXOdCn/5yj+uSIqvs9d62rb4CfcBI=;
        b=pAQrP36eVxCnDjZJVxSfZlsst+euC5ETQKztJTtQiBJe9y7pBMWSkiFCjOz31wersS
         qrYfyryK0ZF8gOBA6xEyKq8ssrKJ57JlRdRNBdALA8GvpnYhIdskDmJjPOtbsn57sQEQ
         MAqhrDNKLXIAh+9UJcBAoMSkddQu8eTG7hxpojJHHsuNKVWcNhXNh4O8MeyEhQQmiriH
         F8dgfcngNCnHBkwtMxg30itxCAN6hSZDR9ZiKAYWj8pcGwLIb732Fijq1WertcIKYNp7
         aLBJYJHuMAckljlO4LGMN1I+JFSiu5pzfY2TjvU2A5LbKPKGr94kswXqL7xVL4TNsFmF
         BA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8YG5vMsHcsKskVBXOdCn/5yj+uSIqvs9d62rb4CfcBI=;
        b=ZRsWNa0XcQjIgdEHvVyZuHLDIb7qMQYrDP1oJ7xh4qSRA5Gn+4N8MtN1IQ3BluL3nw
         k6otgiRK5IZ/qLvSgEhC1i+tiYk3boM/O/4e6wY9bNEGp8EnK9+stjQQG3JTb4vbZMgq
         zXinuSA/fr7g/g39w4WhiGkuM0kU10RH1yOIQSFMGjdH1y9l358tCooTdGI0tkEbKq0e
         EeSU300QZAQFP/3IPlXbcRURbes0aqdSR/QPmO9sN4LUQznk8crpNdPyd6ZCfPNowetV
         KtGZFDQdZ79tVcZLxdfFkmK768Rjb0T3HG1ely5q5Wz+MXFyUYA4tQ2J5ZrIswPCDlpz
         FatA==
X-Gm-Message-State: AOAM531fvh+IkzfCbejmZ0c7RD2Q0zD5tz05SLO4coE7pNJX4pmKyl88
        t9cfbf3EAWy+B+JjTfccx9/s6VzQLKz62JRCldjRJA==
X-Google-Smtp-Source: ABdhPJxECzb3IPGjfMCeGl0qZ7eQVlp4fcsIfD2py++9U+ua348j/EMjO1vQQ/RlmIG0u4epWhC9GegcDa3f/NQsXSA=
X-Received: by 2002:a63:5a08:: with SMTP id o8mr982718pgb.120.1623937068323;
 Thu, 17 Jun 2021 06:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210616141107.291430-1-robert.foss@linaro.org>
 <20210616141107.291430-3-robert.foss@linaro.org> <b48198ff-a954-4941-32d6-65c992b345e7@linaro.org>
In-Reply-To: <b48198ff-a954-4941-32d6-65c992b345e7@linaro.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 17 Jun 2021 15:37:37 +0200
Message-ID: <CAG3jFyubcKP71_w83WWxTX9y3aTz+osTKxbq6Mo+hDTfxbf=WQ@mail.gmail.com>
Subject: Re: [RFC v1 02/11] clk: qcom: rcg2: Add support for flags
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Taniya Das <tdas@codeaurora.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Vinod Koul <vinod.koul@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2021 at 18:07, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
> > diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
> > index 99efcc7f8d88..a1f05281d950 100644
> > --- a/drivers/clk/qcom/clk-rcg.h
> > +++ b/drivers/clk/qcom/clk-rcg.h
> > @@ -149,6 +149,10 @@ struct clk_rcg2 {
> >       const struct freq_tbl   *freq_tbl;
> >       struct clk_regmap       clkr;
> >       u8                      cfg_off;
> > +     u8                      flags;
> > +#define FORCE_ENABLE_RCG     BIT(0)
> > +#define HW_CLK_CTRL_MODE     BIT(1)
>
> Downstream also has these flags for 8250, but the upstream driver ended
> up not using them for the dispcc clocks. Could you please check that you
> realy need HW_CLK_CTRL for dispcc clocks?

HW_CLK_CTRL being flagged in dispcc causes the CFG_HW_CLK_CTRL flag to
be set in the RCG_CFG registers of dispcc.

This flag simply marks the clock as having hardware control enabled or disabled.

As for the question if it is really needed, I can't answer that since
no documentation or downstream comments explain the exact behaviour.
As far as I know the only way to figure out if it is required is
disabling the flag and checking for bugs. I did find this[1] patch,
which enabled HW_CLK_CTRL_MODE.

Should I err on the side of the downstream implementation, or try to
create a minimum functional driver based on the downstream driver?

[1] https://patchwork.kernel.org/project/linux-arm-msm/patch/1514877987-8082-2-git-send-email-anischal@codeaurora.org/
