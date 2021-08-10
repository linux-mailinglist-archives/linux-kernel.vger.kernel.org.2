Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC2B3E23B7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 09:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242871AbhHFHIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 03:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbhHFHIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 03:08:39 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69B6C06179A
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 00:08:23 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id b1so5856304qtx.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 00:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8v6kprns5CP71Og9SwwrzxzwlPrkxlGXJS2Peqqg05c=;
        b=I9Qtk2Z3aUp69yE7XB+dMGm/K2SVBqEWxXnCXzMD3v+A68F7AUvBhMs3UtqjPHn/30
         VL8fm1pUNPEVaG9CKvXtFixt3DHCqCwXAkjB+6aFIaYwNzpa8q5YHI0MSqamdvv/UALO
         qoGfwK0mo8XVvtUAtSO6Tu6dG8Rm32NaJvtpSure9mOTCC4xCCyPuKQQ2ADrK9vVRITV
         VIlsmLVGBlxGJ+aNjZFVYkt9FWs2ih+50/D9JbxoXSLwig4tPGvK38dC2Zpd42AUf/dj
         yww1wCL9ZyEaTqV62BKA1KtjFHJa7CVtLGFqEXrrTC5Pho20SP6uwkyY8scN+9XUSCem
         HVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8v6kprns5CP71Og9SwwrzxzwlPrkxlGXJS2Peqqg05c=;
        b=rLkKP+kTcBf0+V1y85CWn2g+41plVVyaKKg5ux9341jfdFRbfkw3NrL2iHawt3pCQF
         ntMAqxdX1ABfzBavj96PFeQYGNcJAQQMO8Ghbe8P9WAIS16bxWcczcEjNmpZNjZnJrgk
         QYFMM52fu0J/v+vs4KcvHlPLVHrQJu0PNuggWfWXXfHVsPs61Q5Hkofp4xZVNRs+4ZyP
         VoLA9nZM5ILKs5RMhCLNLzH8eRgcmjgGL3K2rEppgL0M/INn3mjEOXuSzOXptg7+YSVw
         9XRpB2qnjRJrZYGGMthVUHxslySCPhGJAt+atZo2vcuJyelfAqbqGMslbEqsWdz+zhLH
         Jr9w==
X-Gm-Message-State: AOAM533QPN9bcFnRJ4m8ATbua+8kATcm05+W0u6kqu3wPyiVbIliefc4
        RoORXPTG7jbKMdcDLzbUfaryrynX6iDXZp9whPtInw==
X-Google-Smtp-Source: ABdhPJwZJjWNwQc2GLaNWSE4U1kR/DIUZnRAOZnqxukRfnii7bkVthy9u4zRIm4N+L11+2iDhSH3JlBXVOxkkFb7WxE=
X-Received: by 2002:ac8:44a8:: with SMTP id a8mr7687963qto.238.1628233702729;
 Fri, 06 Aug 2021 00:08:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210731195034.979084-1-dmitry.baryshkov@linaro.org> <162820760640.19113.2386978922035728014@swboyd.mtv.corp.google.com>
In-Reply-To: <162820760640.19113.2386978922035728014@swboyd.mtv.corp.google.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 6 Aug 2021 10:08:11 +0300
Message-ID: <CAA8EJppSVotv-O=2h3BVqAC6f7xG+2BvUREesKs9v7RJkLORrQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] PM: add two devres helpers and use them in qcom cc
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Taniya Das <tdas@codeaurora.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Aug 2021 at 02:53, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Dmitry Baryshkov (2021-07-31 12:50:31)
> > Most of the drivers using using pm_runtime_enable() or pm_clk_create()
> > follow the same pattern: call the function in the probe() path and call
> > correspondingly pm_runtime_disable() or pm_clk_destroy() from the
> > probe()'s error path and from the remove() function. This common code
> > pattern has several drawbacks. I.e. driver authors have to ensure that
> > the disable/destroy call in the error path really corresponds to the
> > proper error clause. Or that the disable/destroy call is not missed in
> > the remove() callback.
> >
> > Add two devres helpers replacing these code patterns with relevant devm
> > function call, removing the need to call corresponding disable/destroy
> > functions. As an example modify Qualcomm clock controller code to use
> > new helpers. In this case we are able to drop error path and remove
> > functions completely, simplifying the drivers in question.
>
> There are lots of folks on the To: line so I'm not sure who is supposed
> to apply this. Please indicate which maintainer tree you're planning to
> land a series through if it touches different areas of the tree.

I'd prefer for them to go through the clock tree.

-- 
With best wishes
Dmitry
