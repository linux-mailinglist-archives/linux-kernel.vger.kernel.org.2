Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1767635FCA5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 22:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349955AbhDNU0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 16:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349935AbhDNU0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 16:26:34 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEAFC061760
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 13:26:11 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id p3so2934058ybk.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 13:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uXB/h0HritpGaogqR4MZ0Syh5r+OFtVKW/hzSi9q7iw=;
        b=gmTqsMWsFi+G0V3Us4qP+jMCjW/ogfkX9UIVn0orHc7UWb0Tdbd6S6ynCZhGYn9aB/
         JeiCFwrlqgLREEJfzkhy0CThiuhlTxiASsKxMsaV5ccjx22BZVUAG0cPPFjIfLvyVPYw
         Rm7x8aX3VOAZBSbD5Bu3gokPJUUyNB4VWJXC7FF3hkZQv3CZgqFG887jNDLndyiMd0iB
         j5ryaMtSsP5zWVdGzfES+axDLqO5sTTnJDJXUzzVQxmGHsgsS7Ap99VjSQdFLbFf6MUf
         vsC9bzC2+Ip+qx5eZj8PN7i5JJdQ0wDd7A8qQrDvgubwEhzZ/0IR29/WspIfz9gdP1IE
         AOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uXB/h0HritpGaogqR4MZ0Syh5r+OFtVKW/hzSi9q7iw=;
        b=rvjiR9FwL0KXuZO4oqX8agDOa4CpNXywuN4ddUsZOD3OIk0noPm9eA5Wagd9utt+4+
         up+2F4PgNaCVosiuMZOguz/X8RVPqBvNzcZJ3IKchPOoSBnzZyJxrMFPDF6rmx21ziQA
         u9zm8df96d96L5thgO7IuG3TnIvPGH0AxI8SCHryQ5g56MC60HSOcxxlio39yrU8ZYv3
         rsDC+mptN0s+TyUC4c/Pyhsg3uZzLMvsv/OciCgmimBD3YN8U5LGk5D8gyQB26LT81fu
         GQXOZbUFvAb5eovqMcVIAcdH7CXpgyrgHbupE0oPZttD8IeCXlTcMA8M/xOqxhGjtSEO
         VFfg==
X-Gm-Message-State: AOAM532GuyL01u1BgutGERHPqQl8cDjJXfqa/8VvJ5801xjvtrBZ24lM
        08JInkdJ/IonUXW+OH7CO327mmGspqm4hJdEM4xOFw==
X-Google-Smtp-Source: ABdhPJy68/JQ2akezNu6ZdB4kqML+b9w63gefQDDXSh7QMIsi4KZSHn4ZxpYoICD3BhsO3PYRnXFJtwrAc0x2iTGIIg=
X-Received: by 2002:a25:6088:: with SMTP id u130mr56279885ybb.257.1618431970036;
 Wed, 14 Apr 2021 13:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <1616264220-25825-1-git-send-email-sbhanu@codeaurora.org>
 <CAD=FV=WLZCSd6D5VFyD+1KBp5n1qyszER2EVaEMwYjQfPSSDnA@mail.gmail.com>
 <b77f207b-2d90-3c8b-857f-625bd3867ed1@codeaurora.org> <6fdf704c4716f5873d413229ca8adc57@codeaurora.org>
 <CAD=FV=Wa4fT5wZgd0==8kLy_tzTLgdZ-HwdfOEAM9pMeMjjFyg@mail.gmail.com> <8126e130e5c0ea1e7ea867414f0510c0@codeaurora.org>
In-Reply-To: <8126e130e5c0ea1e7ea867414f0510c0@codeaurora.org>
From:   Doug Anderson <dianders@google.com>
Date:   Wed, 14 Apr 2021 13:25:58 -0700
Message-ID: <CAD=FV=XavWbf_b7-=JT6V5_RNA8CjdK4oRu7H719AaPDJ5tsqQ@mail.gmail.com>
Subject: Re: [PATCH V2] arm64: dts: qcom: sc7280: Add nodes for eMMC and SD card
To:     Shaik Sajida Bhanu <sbhanu@codeaurora.org>
Cc:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Ram Prakash Gupta <rampraka@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>,
        sartgarg@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>, cang@codeaurora.org,
        pragalla@codeaurora.org, nitirawa@codeaurora.org,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Georgi Djakov <georgi.djakov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 13, 2021 at 3:59 AM <sbhanu@codeaurora.org> wrote:
>
> >> >>> +                                       required-opps =
> >> >>> <&rpmhpd_opp_low_svs>;
> >> >>> +                                       opp-peak-kBps = <1200000
> >> >>> 76000>;
> >> >>> +                                       opp-avg-kBps = <1200000
> >> >>> 50000>;
> >> >> Why are the kBps numbers so vastly different than the ones on sc7180
> >> >> for the same OPP point. That implies:
> >> >>
> >> >> a) sc7180 is wrong.
> >> >>
> >> >> b) This patch is wrong.
> >> >>
> >> >> c) The numbers are essentially random and don't really matter.
> >> >>
> >> >> Can you identify which of a), b), or c) is correct, or propose an
> >> >> alternate explanation of the difference?
> >> >>
> >>
> >> We calculated bus votes values for both sc7180 and sc7280 with ICB
> >> tool,
> >> above mentioned values we got for sc7280.
> >
> > I don't know what an ICB tool is. Please clarify.
> >
> > Also: just because a tool spits out numbers that doesn't mean it's
> > correct. Presumably the tool could be wrong or incorrectly configured.
> > We need to understand why these numbers are different.
> >
> we checked with ICB tool team on this they conformed as Rennell & Kodiak
> are different chipsets,
> we might see delta in ib/ab values due to delta in scaling factors.

...but these numbers are in kbps, aren't they? As I understand it
these aren't supposed to be random numbers spit out by a tool but are
supposed to be understandable by how much bandwidth an IP block (like
MMC) needs from the busses it's connected to. Since the MMC IP block
on sc7180 and sc7280 is roughly the same there shouldn't be a big
difference in numbers.

Something smells wrong.

Adding a few people who understand interconnects better than I do, though.

-Doug
