Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B1C3E8F5B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 13:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237301AbhHKLTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 07:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237300AbhHKLT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 07:19:27 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1717C0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 04:19:04 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id bo18so2884416pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 04:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mC8C0xwm8W7bgu0JyGtZcqjXFuXUk/Avbe6reu50yCI=;
        b=aJdqWdV0w84zCE2qGTJuXtiN/EUul8d4ZIx2LnoWE5me1OFiMKrLMJaNmWyfawWz5o
         VOys7eOAd0Wg/PnrMXQfrwGQSnmKSaeR0rpd8m2loLS575PH50QC3Ue9Cq6XkknRvlpP
         75ql9KaXbtW75LLYirKzR93x/LLe75PoyKMpLmJvnn+XKFG+pgEHOcQw2zPf55JPHHe8
         XhRRjePUd9oPIPseAVxj1Ao8SyjU7ZQfsLZ9DDyP+r+MG5hcORJjkjVLAMbmhvzWrFpI
         so16YJ5LTEkpjHHcwWmGqAg5sUtLMcgeg6kxBKnLcL2eG3r3M4AI4sb9TJi2RGQGte5k
         NAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mC8C0xwm8W7bgu0JyGtZcqjXFuXUk/Avbe6reu50yCI=;
        b=ZW9nCjLNzbTPvsIUH0WHxkS4q61CxGTRfuveN2Ftp8xD3Pk7orB20QE5Fv3MgJaC2S
         YnWm7wnp7MN2hTHlHvttTSMcD57V+xzI9IEoMtV00l/AcR296ofRYXD0LEPzC5VBWFGw
         eiU/+FYGcDakmzvjRs1P+5t8GLzfed2+7aZP+aWdt2nS4Seg7CIVknCbYx1qdMCHUpMN
         Cu2BbWbj7k38e7c1ryQIxONHJkPmGSC0n1WXwqkyO4PYSVh2HpMhTiYmpZucsiOZ3FE7
         SzKNk+7m0XnW7H9Rwi5x4tg8lZD3cU4hmNl/bGkWYH4GCL7XZ/ikD+Fp/HlVbdLB6qmP
         69Vg==
X-Gm-Message-State: AOAM532Xw+ZoBV6XrBaMXeVJfKHZKFPRuk2azRXT6R4fE2ZjZQxCEs23
        LV2ygBHYFLIPvaEF1u4ftN+pKA==
X-Google-Smtp-Source: ABdhPJwm7QFpVQrDdQM9uD/6wNXIDd2ezHOUsmTYiL5CuXboXPsLNkKYtggVLkg3cfpqns77Dfrhgg==
X-Received: by 2002:a62:65c7:0:b029:3c3:4eff:1b26 with SMTP id z190-20020a6265c70000b02903c34eff1b26mr27485612pfb.48.1628680744167;
        Wed, 11 Aug 2021 04:19:04 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id c14sm31728792pgv.86.2021.08.11.04.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 04:19:02 -0700 (PDT)
Date:   Wed, 11 Aug 2021 16:49:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH v6 1/2] PM / Domains: Add support for 'required-opps' to
 set default perf state
Message-ID: <20210811111900.bloukqgc3f2a4f2m@vireshk-i7>
References: <1628074696-7979-1-git-send-email-rnayak@codeaurora.org>
 <1628074696-7979-2-git-send-email-rnayak@codeaurora.org>
 <CAPDyKFrebwt5=S7hqXvcqRvt+-EXLcVmRSRZt1uPf-9n7_pRDg@mail.gmail.com>
 <2afd0fac-ed28-c090-a345-3fd4284b4125@codeaurora.org>
 <20210810024308.gurvzpbe2bc2bhky@vireshk-i7>
 <e452c0b5-5555-d6e2-40da-6aa21a26766d@codeaurora.org>
 <20210811100749.kwg6435m7xj7ulwa@vireshk-i7>
 <CAPDyKFp3xmx1r_2SCbrVcT-CcyUkTUoNgiUMWoyuWw5jE6WLrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFp3xmx1r_2SCbrVcT-CcyUkTUoNgiUMWoyuWw5jE6WLrA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-08-21, 12:52, Ulf Hansson wrote:
> On Wed, 11 Aug 2021 at 12:07, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 11-08-21, 15:30, Rajendra Nayak wrote:
> > > In my case I don't want to error out if the property is missing, I want to error out
> > > only when the property exists but can't be translated into a performance state.
> > >
> > > So currently I check if the property exists and *only then* try to translate it, Ulf asked
> > > me to skip the check. If I do that and I call of_get_required_opp_performance_state()
> > > unconditionally, and if it errors out I will need to put in additional logic (check for
> > > return value of ENODEV) to distinguish between the property-does-not-exist vs
> > > property-exists-but-cannot-be-translated case.
> > > It just seems more straight-forward to call this only when the property exists, Ulf?
> >
> > The same check will be done by OPP core as well, so it is better to
> > optimize for the success case here. I will say, don't error out on
> > ENODEV, rest you know well.
> 
> This should work, while I generally favor not having to parse for
> specific return codes.
> 
> Another option is to add a new OPP OF helperfunction that just informs
> the caller whether the required-opps property exists (instead of
> open-coding that part), and if so, the caller can continue with
> of_get_required_opp_performance_state() and then expect it to succeed.
> 
> I have no strong opinion though! Whatever works for me.

I would like to work with the existing set of APIs, as the OPP core is
going to do that check anyways, again.

-- 
viresh
