Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD20E3DB6D0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 12:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238484AbhG3KEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 06:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238421AbhG3KDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 06:03:44 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDA6C06179C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 03:02:25 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id u3so16778470lff.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 03:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yrQFmPSsOocu2SRwmrh+oMoqHYk78zWUjrW9sn+KFu8=;
        b=oYxd3h6+XDaGKJsgHhkayzoJMa7ogz8odwMrcV4t1ibAg04dNdvJLETsYmmfrkSseV
         fxC/+cc/g5SPKMCajUrG9GAdrHha0IDA+oh25ufXCtSGPbhjJgS/lHTfN+PWvDaNZbAd
         YnUOJSt/covDyIQWEoSx7UeltkeZ1gsyidlXfXeH+PC/MV90c2nV+3LPejmS+xIfmF5X
         j6bKumV6Vc1tQ98o7B/06dQH9eO80WArYKzCamWiSFuOQSDmSDIToN9zLD405Invsy4z
         YT88a57yRD9YucDPaTPDdG8Kr3ogscFeED3zOjI7M7nSrQz585OFskj4YIGXGgezNdZU
         LTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yrQFmPSsOocu2SRwmrh+oMoqHYk78zWUjrW9sn+KFu8=;
        b=kgRsviX0x8/PBKHC1OEN6CypZmH2go+c27JyfIKyBely0LbP/eIawP8w2564pQOyRN
         q5kSnFYSArq4RrNcsVMv7S0G1frUsuMnlQmahlWETjUp1CvaVKHydmkEjGEjNbgLhxTH
         WfutXzLwQddxNESd59r2Ly2hR0nwLXCM85CcRN7Bl66ULKYuO0njE5NMrdnJZj/Uls0X
         gSFBz7Za7wm0ttBcvyaRIiAswYkjhWuGzVWXVRzD0yDvwxU7eKWWCOrwlUHN99YWYyXM
         Cn0sSwWyTaTzOXAMC00H9TwWJlvamTap/CqYsGWVXEXETexEpANKGIRyPcAoXFp488sn
         V37w==
X-Gm-Message-State: AOAM5304aPICtJTboh5M7uoSijU10BJV5H2RYsLqWzmx/OqDwnu1B9aa
        Z33SSv5vyfT7BRkM61yzGR258XLEdz+qNXqEbLO2Vw==
X-Google-Smtp-Source: ABdhPJx3kzOTrIVzHNFiv5EZ/V73fXl2Hn/oaV3vs0g/lVAyoet+DXaSEX4BPoAvgqkaX+OYaNJkKMx3tMkX3MJDMq8=
X-Received: by 2002:ac2:5312:: with SMTP id c18mr1253533lfh.649.1627639343457;
 Fri, 30 Jul 2021 03:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626987605.git.quic_vamslank@quicinc.com>
In-Reply-To: <cover.1626987605.git.quic_vamslank@quicinc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 30 Jul 2021 12:02:12 +0200
Message-ID: <CACRpkdbqyi93Ncr4ANCV4ZVeZzNMMxumTJ4byu2vFZa=_0WhRg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add pinctrl support for SDX65
To:     quic_vamslank@quicinc.com
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 11:19 PM <quic_vamslank@quicinc.com> wrote:

> From: Vamsi Krishna Lanka <quic_vamslank@quicinc.com>
>
> Changes from v1:
>  - Addressed all Bjorn's comments
>
> This patch series adds pinctrl bindings and tlmm support for SDX65.

Looks good to me but waiting for Bjorn's review!

Yours,
Linus Walleij
