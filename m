Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8563E8932
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 06:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbhHKEW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 00:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhHKEWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 00:22:54 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D853CC061765
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 21:22:30 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id r19-20020a0568301353b029050aa53c3801so1910103otq.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 21:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=M+Fy0eR1+iop2G2YtVgpRm77F8HTctO7zKKFznc4zBo=;
        b=Fo9g5LijgBrQLPT6MYDEQNxX6viodg54hr7z4FkxTTA21xFg3ZrnNnIuV5eOFU6HpM
         HeXLgv/LwnWd2M9n9fm3NUb6HDbfUx4E4CtwuAH2Q51QtqvgmaESGr+NmF0AXxHRXs5n
         ewFZnhcT5+bJ+kMcpEX9LWMIvBWWSLrSYEXws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=M+Fy0eR1+iop2G2YtVgpRm77F8HTctO7zKKFznc4zBo=;
        b=eWrbu97SGFimbSOoT4VxH2wCwbU/gBWdKC2M9tr1CwTZdZzUMjwlkRRH2ynIyC6pG8
         8axmjjusvBXMykwUtb1wSrcNsKumo1ySEL+6ke1OLI1GottyWfS56gYU0vLbaqDmX9wI
         M8OCqsbml+grDI20sbk6XRUaSN8AkeTwbKkmAcbaEuFPJMap+ssiuzUlP+LWM5d9uckR
         DQBvYp9QGSnwhe+8GSJkeaCY0bk0bhKbgyqF7zv5jCXV3AD6Z5qJStDBze6UG1r66KIc
         ZUprhKvXhl3o0xJ5KpadwZRWBfJSPLdTbFAKXMUBTzXYCl6DWLNvEA74aUtgMntAZEbY
         XCUQ==
X-Gm-Message-State: AOAM531cKxHknj8Vh7SixiarYgU4QO8iXA+PprzJr+qhhEK+YJ5ZLtV+
        yqIXFeWK7f5IK9X2IS3forfdt/Dv2WBNgZS3mYwJvA==
X-Google-Smtp-Source: ABdhPJwFN1LHRL2LcpvpMcDdnpPoGURPoblDU8DwG8F5DDcdYAcQghp0zgONfhmA3uMvE4qsiAJCUK817GUSoi+F0hI=
X-Received: by 2002:a05:6830:44a7:: with SMTP id r39mr23466057otv.25.1628655750208;
 Tue, 10 Aug 2021 21:22:30 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Aug 2021 21:22:29 -0700
MIME-Version: 1.0
In-Reply-To: <YRMXOlA5a98BwT3i@builder.lan>
References: <20210721175432.2119-1-mdtipton@codeaurora.org>
 <20210721175432.2119-5-mdtipton@codeaurora.org> <CAE-0n52iVgX0JjjnYi=NDg49xP961p=+W5R2bmO+2xwRceFhfA@mail.gmail.com>
 <YRMXOlA5a98BwT3i@builder.lan>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 10 Aug 2021 21:22:29 -0700
Message-ID: <CAE-0n53L_muNfpcunPmAWh-dG1h_y8xVqUG-es2CY8jdbnM8mg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] interconnect: qcom: icc-rpmh: Add BCMs to commit
 list in pre_aggregate
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Mike Tipton <mdtipton@codeaurora.org>, djakov@kernel.org,
        agross@kernel.org, saravanak@google.com, okukatla@codeaurora.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Alex Elder <elder@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2021-08-10 17:18:02)
> On Tue 10 Aug 18:31 CDT 2021, Stephen Boyd wrote:
>
> > Quoting Mike Tipton (2021-07-21 10:54:32)
> > > We're only adding BCMs to the commit list in aggregate(), but there are
> > > cases where pre_aggregate() is called without subsequently calling
> > > aggregate(). In particular, in icc_sync_state() when a node with initial
> > > BW has zero requests. Since BCMs aren't added to the commit list in
> > > these cases, we don't actually send the zero BW request to HW. So the
> > > resources remain on unnecessarily.
> > >
> > > Add BCMs to the commit list in pre_aggregate() instead, which is always
> > > called even when there are no requests.
> > >
> > > Fixes: 976daac4a1c5 ("interconnect: qcom: Consolidate interconnect RPMh support")
> > > Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
> > > ---
> >
> > This patch breaks reboot for me on sc7180 Lazor
> >
>
> FWIW, it prevents at least SM8150 from booting (need to check my other
> boards as well), because its no longer okay to have the interconnect
> providers defined without having all client paths specified.

So maybe the best course of action is to revert this patch from Linus'
tree? It's not a super huge deal as "can't boot", but certainly makes
reboot annoying on sc7180.
