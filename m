Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64343EB382
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 11:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239883AbhHMJrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 05:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239866AbhHMJq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 05:46:58 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAC6C061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 02:46:31 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id l6so2387761vkr.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 02:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GFzl/KQ2L8VW5O2jJZmcKVoInan5EFPzJ3PXngNSoek=;
        b=ydhrXPzp0oZlMxvJoqotvWAvjAD5U7ohINwf58MKTJ+ONQmMRqEAGP5P0nU6GqVjIU
         a44YiBFd7kdKnMF0LEbboE3CUnPha5Rf/EUSKLX4JgnfTW8qmZMikS13G/eLNg3HuG7v
         1n3esvUdHGelQTPlst+zvPZIYlaXXZz9pvKV9jP3Ag+sYA/hoTn44sZpPsx/aMfWtmm6
         /RLWc8C8C/sxqG9r4+NwPQkOpErabzLiQePM2pC14RdmAq4e+jSZ55cdMT2rU9Ii2vFm
         jNZJXPPaQx0QSFsWGn4dVFRTfwIdDK5uChTsTIQlmPzZ3JSfRdePz6QISCqB9fykaUvi
         G+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GFzl/KQ2L8VW5O2jJZmcKVoInan5EFPzJ3PXngNSoek=;
        b=heTSn/+0FWoBw+9igGJ7NgX9ro0cdf3eT1WBu49Tn5eoqbn7frzxXTDx+9fsI5FR0l
         8mF4hvITpUgnlEHP4hFi9kU3YCOQ/lNWiNJkjY5EtV5Eir4MbjaqK39y4HXhnUVrjE+Y
         uqaupbYML0qnBcfSKOnKtTj4DOrW357gSrMn6cPZIHGpJsKriVmV1bsn3262/5gAEF49
         g6PPvK/iuWU6nx+5e6DBdvf+kF8omXNNbL25ir9oxm3Vc8zzIghCeJSIuuUdjzy5F5Qc
         xFqcmj55J+ocpjdZpp0g4P/HBg7Nqy2U3aX9lo7BGJVD2YUEUI0htJtB2M0HMn8J2pcO
         rUxg==
X-Gm-Message-State: AOAM530C8NUxJSL/7JnSKe93DXiD0/tk9QntOH1aw3SOd+3RAHXUlB5C
        G6dfD+d4gSBsC0JcsHSmSWrxJ/yxW3qNBHuM+iHh9w==
X-Google-Smtp-Source: ABdhPJyA63eft/amiBmW7SOjz7zOo09Kx+BNyXIup0lD+NtLwzRQXiRQn/fPFWBE0aHEt+V43UsmsZPQqe7YXNfCJ7w=
X-Received: by 2002:a1f:a301:: with SMTP id m1mr695286vke.6.1628847990547;
 Fri, 13 Aug 2021 02:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210703025449.2687201-1-bjorn.andersson@linaro.org> <45bfb6ae-d131-10d7-1924-48c98a957667@linaro.org>
In-Reply-To: <45bfb6ae-d131-10d7-1924-48c98a957667@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 13 Aug 2021 11:45:54 +0200
Message-ID: <CAPDyKFoxbm5ki5z0NcbcpJ6bbFntitYTiwX0Bxe01NaB6Db3uQ@mail.gmail.com>
Subject: Re: [RESEND PATCH 2/2] soc: qcom: rpmhpd: Make power_on actually
 enable the domain
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2021 at 15:21, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 03/07/2021 05:54, Bjorn Andersson wrote:
> > The general expectation is that powering on a power-domain should make
> > the power domain deliver some power, and if a specific performace state
> > is needed further requests has to be made.
> >
> > But in contrast with other power-domain implementations (e.g. rpmpd) the
> > RPMh does not have an interface to enable the power, so the driver has
> > to vote for a particular corner (performance level) in rpmh_power_on().
> >
> > But the corner is never initialized, so a typical request to simply
> > enable the power domain would not actually turn on the hardware. Further
> > more, when no more clients vote for a performance state (i.e. the
> > aggregated vote is 0) the power domain would be turn off.
> >
> > Fix both of these issues by always voting for a corner with non-zero
> > value, when the power domain is enabled.
> >
> > The tracking of the lowest non-zero corner is performed to handle the
> > corner case if there's ever a domain with a non-zero lowest corner, in
> > which case both rpmh_power_on() and rpmh_rpmhpd_set_performance_state()
> > would be allowed to use this lowest corner.
> >
> > Fixes: 279b7e8a62cc ("soc: qcom: rpmhpd: Add RPMh power domain driver")
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >
> > Resending because the hunk in rpmhpd_update_level_mapping() was left in the
> > index.
>
> So, colleagues, what is the fate of this patch? Is it going to be
> applied? Or we agree that current approach (power_on +
> set_performance_state) is the expected behaviour? My patches on gdsc
> rework depend on this patch, but I can rework in them in favour of
> required-opp approach.

Today, genpd treats performance states and power on/off states as
orthogonal. You know this already, ofcourse.

Although, to clarify, this means that the genpd provider has to deal
with the scenario when its ->set_performance_state() callback may be
invoked, while the PM domain is turned off, for example. Similarly,
genpd may power on the PM domain by invoking the ->power_on()
callback, before the ->set_performance_state() has been invoked. And
finally, the power domain may be turned off even if there are some
active votes for a performance state.

So for now, the genpd provider needs to deal with these cases. Yes, we
have discussed changing the behaviour in genpd around this and I think
there have been some good reasons for it, but we are not there, at
least yet.

[...]

Kind regards
Uffe
