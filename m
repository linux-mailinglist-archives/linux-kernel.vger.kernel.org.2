Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41C83BF2CF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 02:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhGHAZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 20:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbhGHAZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 20:25:58 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86833C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 17:23:17 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id w127so5656300oig.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 17:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=RbFoIrsFO5XIBA5/R77ovrZzmwL+AynSzkgJ2f7jhfU=;
        b=VtqVdY9lPfx6/Yhz6fJsozfP0L7QK8deW47mn5HtSUTeVi/BXaHkwcRUuSetNMFuv+
         x8Yhrjnke5Up7Wi7q3tBV3KbOYQAFsMdgx+87cNXyxc2Lu5XMxJMTGbDkxE03etTMIXo
         b6Imw0lJLHvtX3T/tUGCAOwUqIA+SEgiKShfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=RbFoIrsFO5XIBA5/R77ovrZzmwL+AynSzkgJ2f7jhfU=;
        b=aHwetxg+eXAGfjSU9pYLo1JM8l8q2CWVK1/w18NJnTEVICedjHixby12N363pS2Slp
         i6bBH6I7Twgv6aW12HcEDaWXgiedaBPd6CoqAIX7IfuQjxNlRAGgH7UDTfeIOmvCSklh
         m77BZi/MUN+nuQz/CLap2snv6Hn0ntvC0MQZrJ7nAERfVYsKCjvb8Sks23lkV5SQ2U8c
         VQLVI5fnZzls8IPyfbCyJ8FdjcxMsiKdmj/OEU0KQckhQzQPCNrqd5aZlc1YNrUR5/FF
         X7ke99WM3A8opAa8yuDZry63b7TICdbOW1EHT7Tm8wpS21fRcga0X/r6h7kvjF4LF2Ur
         H1sg==
X-Gm-Message-State: AOAM53223S4pJDEpSg80fq+i73Y9LeQQhqJaWRHD2ME5u6mq2CBqSnyi
        R+/1LPqAMyFZryCdkJRGhbL2nAWKiEuqAU0cS/+u/Q==
X-Google-Smtp-Source: ABdhPJzg1rZ5ea1h4hn9be4lgRL9bCGi6K92pjjcqaaI2kcvco3q8d0Q3VHMcWfzh+rCZRL2WFO4Mh/aHBfbyPTXkOo=
X-Received: by 2002:aca:3012:: with SMTP id w18mr1495720oiw.125.1625703796995;
 Wed, 07 Jul 2021 17:23:16 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 8 Jul 2021 00:23:16 +0000
MIME-Version: 1.0
In-Reply-To: <20210703025449.2687201-1-bjorn.andersson@linaro.org>
References: <20210703025449.2687201-1-bjorn.andersson@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 8 Jul 2021 00:23:16 +0000
Message-ID: <CAE-0n502u+7CNhA5_kMfc-CVvpSzdGOeputT6nxW8BvtyVBeRQ@mail.gmail.com>
Subject: Re: [RESEND PATCH 2/2] soc: qcom: rpmhpd: Make power_on actually
 enable the domain
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2021-07-02 19:54:49)
> The general expectation is that powering on a power-domain should make
> the power domain deliver some power, and if a specific performace state
> is needed further requests has to be made.
>
> But in contrast with other power-domain implementations (e.g. rpmpd) the
> RPMh does not have an interface to enable the power, so the driver has
> to vote for a particular corner (performance level) in rpmh_power_on().
>
> But the corner is never initialized, so a typical request to simply
> enable the power domain would not actually turn on the hardware. Further
> more, when no more clients vote for a performance state (i.e. the
> aggregated vote is 0) the power domain would be turn off.

s/turn/turned/

>
> Fix both of these issues by always voting for a corner with non-zero
> value, when the power domain is enabled.
>
> The tracking of the lowest non-zero corner is performed to handle the
> corner case if there's ever a domain with a non-zero lowest corner, in
> which case both rpmh_power_on() and rpmh_rpmhpd_set_performance_state()
> would be allowed to use this lowest corner.
>
> Fixes: 279b7e8a62cc ("soc: qcom: rpmhpd: Add RPMh power domain driver")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
