Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB1034D2F2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 16:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhC2O5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 10:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbhC2O5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 10:57:04 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF807C061756
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 07:57:04 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id j2so14049722ybj.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 07:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kKi8HN+bpgIonbipayQY6bUaqDWQRM56PWjQCa1XcVc=;
        b=QHeXTIE0ojKJtQ0VDW1civaMMSYxCTYIxgjq32eR6dbldNbJ7h34t8c01oC8YDfRcV
         +VfX7+582QTTxV7FU2T+0vinC8y9SAnTAPI2oyf4H2fJoytHlIUn/HU1KebfH/VjGAOA
         gUDS5T0FIs1S8Hyvg6Iw76337LbQmKY4tI39R/AtDZoGCVkZy+8FqZDzE0eArbRy39Ua
         DPUVqWL1FDXXwDvhxpJZ8HpSprI9KioF7qtuh+GGsZ09Gst3MBl6CyJigBzZRWpk4aF7
         /ExD1o3GqUcKDji/hVdsgRgXcEjq/aY3FAb/1WNU6JDHKh4f6xlC3SviRJ/gTj51od+O
         juqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kKi8HN+bpgIonbipayQY6bUaqDWQRM56PWjQCa1XcVc=;
        b=ipSP1ETRSo4siWxTebq3emBkru48Qf/ekPCRLAS90VtuNXGimZRQnWOyyu8dE3H6Lt
         jULj3AZn2aZdlw+1qy5Ol+XJtdWYLFpMkRP/Z05yQQ/0MNkMElzmOMkXxtISgnXbD0AR
         HSY6dfClVxjsmXxoqYv8bRwiK4raKH79R9q5ZviTIUvWhXdnrhHCH6rPnRXaWzXV0w/s
         IP3Uz+izr8bdTGr5gPMyqCkjD7yC/Agqfwy6KOEkGkDrpIogvCg1hwhAjUID6aDUsRp4
         v6e3MCY7zRzTJVDL/bYpBwIaLnWPA2f6YTPy14mFynT/xs0uiVJ3ng0SNdE51xSYEHez
         6nYA==
X-Gm-Message-State: AOAM5322tuM76qFr2onWaF9vNnyEM0fpcNA5ZWgjvATwrkGekGXiGMN8
        Ul2DGtlUeN7sRXvmA2gYWShwtBvalSvVt1yyxt+3MQ==
X-Google-Smtp-Source: ABdhPJzu5ULT+omARvahbH1jKInTaaNAdmdNq4fRz3u1JYVIeDwdMailkmG8CbM4ZA/xaEU/YPrnxVrzakIRb4bNgp0=
X-Received: by 2002:a25:69c1:: with SMTP id e184mr38733388ybc.345.1617029823530;
 Mon, 29 Mar 2021 07:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <1616264220-25825-1-git-send-email-sbhanu@codeaurora.org>
 <CAD=FV=WLZCSd6D5VFyD+1KBp5n1qyszER2EVaEMwYjQfPSSDnA@mail.gmail.com>
 <b77f207b-2d90-3c8b-857f-625bd3867ed1@codeaurora.org> <6fdf704c4716f5873d413229ca8adc57@codeaurora.org>
In-Reply-To: <6fdf704c4716f5873d413229ca8adc57@codeaurora.org>
From:   Doug Anderson <dianders@google.com>
Date:   Mon, 29 Mar 2021 07:56:52 -0700
Message-ID: <CAD=FV=Wa4fT5wZgd0==8kLy_tzTLgdZ-HwdfOEAM9pMeMjjFyg@mail.gmail.com>
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
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 25, 2021 at 11:57 PM <sbhanu@codeaurora.org> wrote:
>
> >>> +                       max-frequency = <192000000>;
> >> Why do you need to specify this?
> This helps to avoid lower speed modes running in high clock rate,
> and As Veerabhadrarao Badiganti mentioned

Just to be clear, both Stephen and I agree that you should remove
"max-frequency" here (see previous discussion). Bjorn is, of course,
the file decision maker. However, unless he says "yeah, totally keep
it in" I'd suggest dropping it from the next version.


> >>> +                                       required-opps =
> >>> <&rpmhpd_opp_low_svs>;
> >>> +                                       opp-peak-kBps = <1200000
> >>> 76000>;
> >>> +                                       opp-avg-kBps = <1200000
> >>> 50000>;
> >> Why are the kBps numbers so vastly different than the ones on sc7180
> >> for the same OPP point. That implies:
> >>
> >> a) sc7180 is wrong.
> >>
> >> b) This patch is wrong.
> >>
> >> c) The numbers are essentially random and don't really matter.
> >>
> >> Can you identify which of a), b), or c) is correct, or propose an
> >> alternate explanation of the difference?
> >>
>
> We calculated bus votes values for both sc7180 and sc7280 with ICB tool,
> above mentioned values we got for sc7280.

I don't know what an ICB tool is. Please clarify.

Also: just because a tool spits out numbers that doesn't mean it's
correct. Presumably the tool could be wrong or incorrectly configured.
We need to understand why these numbers are different.

-Doug
