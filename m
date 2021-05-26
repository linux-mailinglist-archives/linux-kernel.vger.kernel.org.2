Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6536D3913DE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 11:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbhEZJjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 05:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbhEZJjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 05:39:41 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72DFC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 02:38:10 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso3311264pjx.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 02:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PZn6DH1g0F0JoZFUjNJyld/cDXkV8nJy84Rb6+ysftI=;
        b=B2nnKO4iG69bEQWZSYcrt8FbwPKU4bxYMIKI/qNcgO9dGHUXAITT0st0+rhx1jr4g5
         zlTK6OE1rDrly/SgtPoKHK+Rfe0IK4oJkseEe8pQWU+JieG5FC4/g5L+UUmGYs0Syn2e
         lrvXlTGm/Zv/R8jxlK9uCT12/4/VupQ/g7AnCmyoxSBzi6q+tbeDXBJ3Ih3jGsTRnL+y
         pOco1s1VJH6bbDdfR9ARInqGDtcbOtLE8MWabXzquciuvGQJLbnmDCE43L/0MURN6tI6
         u/Iw2+66oe5AJmR3juV2wqxbjqyDvLaU/PwOHvQbQzh4I0V2n1ubDuVEo5EtrFmW2n5u
         ohTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PZn6DH1g0F0JoZFUjNJyld/cDXkV8nJy84Rb6+ysftI=;
        b=s9qCISNd8f+VC+nHygCbIEL2YKVXuG0yfRlJfASZ44dbC2Z8T4zJZa1WPTegEXDI0A
         gbhX0Ckvw0dxVRjAL5jI3k+7xiqolsVcmr33uVCG3Tg+zHbuvnpzXOyTIyaHVaFU3gby
         FMzNGtxS7Z8DtVmCyc8LM8xgdiceMqn3LRauTNUzKmMluua0mX9EPLePuUApFTYSxXyS
         OzchHO/zcw/u1CCMbq9Yyj4HxKoKLm5tsFs0UhexIfEJM+/gZAGf2zbzQ5391AcA26d0
         ksUi7Oy29yhLdTFgPn9cEqpdfsmjpj6Afyj3CEi5bETzGhNEdRpCNXsVuCpxdtRAhzXO
         B/Fg==
X-Gm-Message-State: AOAM530W0Q+8EpRxrFNdKFEmEKyAWMbny5WDJGRqwfrsbyuRcedWProp
        XYEhPcJ6FranGbM/Y2wB3DqZYw==
X-Google-Smtp-Source: ABdhPJyKkLkGpolbFOoo8tr0tLuMDiIDe/KumFuVKzDt6D3L6cQOVpRwJE6oA+PCxfFwiaMyl19sZQ==
X-Received: by 2002:a17:90a:8e82:: with SMTP id f2mr3099015pjo.157.1622021890273;
        Wed, 26 May 2021 02:38:10 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id n69sm9334264pfd.132.2021.05.26.02.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 02:38:09 -0700 (PDT)
Date:   Wed, 26 May 2021 15:08:07 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com
Subject: Re: [PATCH v2 0/3] EM / PM: Inefficient OPPs
Message-ID: <20210526093807.sih5y4lgltsz3r74@vireshk-i7>
References: <1621616064-340235-1-git-send-email-vincent.donnefort@arm.com>
 <20210526034751.5fl4kekq73gqy2wq@vireshk-i7>
 <20210526090141.GA408481@e120877-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526090141.GA408481@e120877-lin.cambridge.arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-05-21, 10:01, Vincent Donnefort wrote:
> I originally considered to add the inefficient knowledge into the CPUFreq table.

I wasn't talking about the cpufreq table here in the beginning, but calling
dev_pm_opp_disable(), which will eventually reflect in cpufreq table as well.

> But I then gave up the idea for two reasons:
> 
>   * The EM depends on having schedutil enabled. I don't think that any
>     other governor would then manage to rely on the inefficient OPPs. (also I
>     believe Peter had a plan to keep schedutil as the one and only governor)

Right, that EM is only there for schedutil.

I would encourage if this can be done even without the EM dependency, if
possible. It would be a good thing to do generally for any driver that wants to
do that.

>   * The CPUfreq driver doesn't have to rely on the CPUfreq table, if the
>     knowledge about inefficient OPPs is into the latter, some drivers might not
>     be able to rely on the feature (you might say 'their loss' though :)) 
> 
> For those reasons, I thought that adding inefficient support into the
> CPUfreq table would complexify a lot the patchset for no functional gain. 

What about disabling the OPP in the OPP core itself ? So every user will get the
same picture.

> > 
> > Since the whole thing depends on EM and OPPs, I think we can actually do this.
> > 
> > When the cpufreq driver registers with the EM core, lets find all the
> > Inefficient OPPs and disable them once and for all. Of course, this must be done
> > on voluntarily basis, a flag from the drivers will do. With this, we won't be
> > required to update any thing at any of the governors end.
> 
> We still need to keep the inefficient OPPs for thermal reason.

How will that benefit us if that OPP is never going to run anyway ? We won't be
cooling down the CPU then, isn't it ?

> But if we go with
> the inefficiency support into the CPUfreq table, we could enable or disable
> them, depending on the thermal pressure. Or add a flag to read the table with or
> without inefficient OPPs?

Yeah, I was looking for a cpufreq driver flag or something like that so OPPs
don't disappear magically for some platforms which don't want it to happen.

Moreover, a cpufreq driver first creates the OPP table, then registers with EM
or thermal. If we can play with that sequence a bit and make sure inefficient
OPPs are disabled before thermal or cpufreq tables are created, we will be good.

-- 
viresh
