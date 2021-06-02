Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB33D3986D2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhFBKsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbhFBKsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:48:21 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2942DC06175F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 03:46:36 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id x2so830466vss.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 03:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lU4ssir5ha790z/YDO8JkSsgJnGdXi3MThLCynIZgQo=;
        b=vqebK4a9puYhP29ag3POVtlAMRMrRjYn/IpNrbKiIvpXyJ0cwNNXsIVY4FKoN8/ptQ
         f0INNEhBcJCFbpHZyzR5piDZ9/dDlMvn+TsgMQGdNqYmzD8XvLKrDPaPKkX4nGwtWDax
         YewB6nRLN7os5hNFy192Rt0StTtJLMqamlv7foN3oa7lZ35W2u+nr0ChBHxprDTEDvtF
         kFAbUSCrQyekf4YXXV1+Mc3bk8uGHr4dpX0LZaNUOOHARb9VnCDfBVZvEHepRhD+YUCm
         rVUpyuP6r2Tfla8ibe3sSMOPO4FBUAxVo5u3PXO8BmIgk4AQ0MRFS1Nml21q+x47hAwS
         C5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lU4ssir5ha790z/YDO8JkSsgJnGdXi3MThLCynIZgQo=;
        b=QQnMGY3BlcGi9FsP9NFjlz7o/ifh8CrecesjzOPr8Zs8UBjSvBFty1H7lOrpHkgRJp
         THnxlIwUHPnSDwJvLNzoobLTOCt8R3Lrrv35OjEYgS0XZVGNydIX9wJSCyf0qhrok4I6
         DmGPQByBg0hzngxWOj43maCcsA6BWUFJcS4sAct5rlpGAT0bwbjy1G2Hp0xc5skY6Yjv
         9GqDJydvRBdY86b0Xh2QufFSd0O9ZXJKR9LQB+/hHvqHYVTI4KocKqtv0MU+9/tJzyOT
         Tyqe+KOPpf5UTisTa9jsdbqG/Q2lSwYoS55dicxoeYGYNCxwl/+n3rht4a+2uGa0OvTo
         P6wA==
X-Gm-Message-State: AOAM532uAgs8ZTvAZ+E4guSb48+g/Nwwt4I++Di/7F2Z48Ai8EJXq/37
        LwQLpD28WchxYbVi+ziOc/bovO0GpWPPTeclCpjBJUxxGg1BH/nr
X-Google-Smtp-Source: ABdhPJzlB78QnhjyIdgQMDdksxecG7umULRl0xmzYj+ipwhRfTA5kJm+Ij5WkFCtwblqN64JW0lUoZFN6Jph51SJtdU=
X-Received: by 2002:a05:6102:5da:: with SMTP id v26mr1752302vsf.19.1622630795277;
 Wed, 02 Jun 2021 03:46:35 -0700 (PDT)
MIME-Version: 1.0
References: <1622095949-2014-1-git-send-email-rnayak@codeaurora.org>
 <1622095949-2014-2-git-send-email-rnayak@codeaurora.org> <YLYV3ov/iBffZMg4@gerhold.net>
 <20210601114426.3vhh2twocqx254b6@vireshk-i7>
In-Reply-To: <20210601114426.3vhh2twocqx254b6@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 2 Jun 2021 12:45:59 +0200
Message-ID: <CAPDyKFqmBoMwQkWHT-w8A2=PeXeDgxE8n=D4prdEyuxM+ZOAaA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: power: Introduce 'assigned-performance-states'
 property
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jun 2021 at 13:44, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 01-06-21, 13:12, Stephan Gerhold wrote:
> > > +    child4: consumer@12341000 {
> > > +        compatible = "foo,consumer";
> > > +        reg = <0x12341000 0x1000>;
> > > +        power-domains = <&parent4>, <&parent5>;
> > > +        assigned-performance-states = <0>, <256>;
> > > +    };
> >
> > Bjorn already asked this in v1 [1]:
> >
> > > May I ask how this is different from saying something like:
> > >
> > >     required-opps = <&??>, <&rpmpd_opp_svs>;
> >
> > and maybe this was already discussed further elsewhere. But I think at
> > the very least we need some clarification in the commit message + the
> > binding documentation how your new property relates to the existing
> > "required-opps" binding.
> >
> > Because even if it might not be implemented at the moment,
> > Documentation/devicetree/bindings/power/power_domain.txt actually also
> > specifies "required-opps" for device nodes e.g. with the following example:
> >
> >       leaky-device0@12350000 {
> >               compatible = "foo,i-leak-current";
> >               reg = <0x12350000 0x1000>;
> >               power-domains = <&power 0>;
> >               required-opps = <&domain0_opp_0>;
> >       };
> >
> > It looks like Viresh added that in commit e856f078bcf1
> > ("OPP: Introduce "required-opp" property").
> >
> > And in general I think it's a bit inconsistent that we usually refer to
> > performance states with phandles into the OPP table, but the
> > assigned-performance-states suddenly use "raw numbers".
>
> I must have missed that discussion, sorry about that.
>
> The required-opps property, when present in device's node directly, is about the
> (default) OPPs to choose for that device's normal functioning as they may not do
> DVFS.

Alright, so it looks like we already have the DT binding that we need for this.

That leaves us with the question, at what place should we parse it
(call of_get_required_opp_performance_state()) and set the performance
state for the device?

Does it still make sense to do it while attaching the device to the
genpd, you think? Or, is there another better common path?

For fixed regulators, the binding is parsed during the probe and then
the performance state is set/dropped at regulator_enable/disable().

>
> Good point Stephan.
>

Kind regards
Uffe
