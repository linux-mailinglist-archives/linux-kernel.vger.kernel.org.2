Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231293B8810
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 19:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbhF3RyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 13:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbhF3RyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 13:54:13 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930E1C061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 10:51:44 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 11so4025178oid.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 10:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=/TpbbonyK5cx17STCT313YsMTZEN2Fa3252nyd5WAKY=;
        b=jZqjlYVOYTUdCBUwZYbUuN6kEGJHaE+01/l3M/0kh7APq5t1yDwuo+++hYoCABGFz0
         x9g5o3Rjpx8HY7ff7/QyNQLNZHhXOBBrSX0v+/uXUmUrzI4JO046LWlbpgwdq8pEOMqJ
         tHznXazHFvqaC2AaPQr5lZ+yZNbFgB+d5+Gus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=/TpbbonyK5cx17STCT313YsMTZEN2Fa3252nyd5WAKY=;
        b=XlXmiBW0wcqywqfIIvArOD9coxjUqEiU83lk17+TrhL3uS98R0fe+nEpUwREJXI38b
         Toad53rLSR+1CFmwU21ubsqPi9PXi1uSccdNkdbqUVDkCmxu5bhHmiXYS+v+k4mOOb1l
         Apddb2dTWjcmnk0gN4imTfzmanncGoSpd4XPM8+9dtZvmRGyOrSN9KfzfpShtBUJbypk
         UPqCeeeYKBgPSD9YnT39MUXtxc0EdnIA4KtIy6fMk7Qyx0e2RiTvUw9JSwGaRRxIqZo5
         eRPhc+Ae/QKeGczFBNytQkcYEUHr85MC5/oZ533L3WajpHt6me89q8Pxrayhd1klHarl
         05GA==
X-Gm-Message-State: AOAM533CksTvf0CNEBYCoZllJcUiVK1u39p+1u0mf/znoNRwUgcA8zGl
        XEZyx0mIsdfIW1utq9vUuPWbQjDAyUQ2utL2iHko7A==
X-Google-Smtp-Source: ABdhPJyt1BT0yyy26ZENhSRgNlnZIfJxRS8zE0C7/7zupBgcDtyelBnghwpsMShvQXBW5bgL8j5LBbgVPi78511rLKY=
X-Received: by 2002:aca:5390:: with SMTP id h138mr3968714oib.125.1625075503995;
 Wed, 30 Jun 2021 10:51:43 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 30 Jun 2021 10:51:43 -0700
MIME-Version: 1.0
In-Reply-To: <YNYAuaBrGgdtToph@builder.lan>
References: <1622758940-13485-1-git-send-email-khsieh@codeaurora.org> <YNYAuaBrGgdtToph@builder.lan>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 30 Jun 2021 10:51:43 -0700
Message-ID: <CAE-0n500g=KuOsRgHe2vpL2JOuq+LRFEWEdEovMg8BJF4cKD1A@mail.gmail.com>
Subject: Re: [PATCH v4] arm64: dts: qcom: sc7180: Add DisplayPort node
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>
Cc:     robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org,
        agross@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        abhinavk@codeaurora.org, aravindh@codeaurora.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2021-06-25 09:13:45)
> On Thu 03 Jun 17:22 CDT 2021, Kuogee Hsieh wrote:
> > +                                             dp_out: endpoint { };
> > +                                     };
> > +                             };
> > +
> > +                             dp_opp_table: dp-opp-table {
>
> I forgot that our discussion about the node name here was on the
> previous revision, _this_ is the patch I will drop the "dp-" from and
> apply.
>
> And as I've looked at this quite a bit now:
>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>

With that node name fixed

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
