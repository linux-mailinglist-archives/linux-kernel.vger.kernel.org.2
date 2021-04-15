Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F44360E76
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 17:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbhDOPPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 11:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235443AbhDOPFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 11:05:08 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AF2C06138D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 08:04:39 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r7so11636114wrm.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 08:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DZX4sYgXxdpSbOuCJhVuGZb+k3GPukvecVA74S1iE6s=;
        b=aAhEncwIF7d0dA91BzoO7BbFVR7LjQSgzLEeNecJFaQoNGu5hvAnx6gjfwRgnliLMg
         D3iM0MPKWB6Qa58oWJU/+YtCGh2e2hAWsxcCUsg/3j+AF946AIeQiUNF1dXmM9JIEd0j
         x7OJORbgBzjj5I6N6mOeb1iuCuPzP8vD8jSlB2TD97mDz+7DcuMyCaFcnn0TNRvm5y9D
         d5ICY7gE2IfP0foAzxB5rf3DXgiD5tkCAI5UmphNL2DwkayFc/CIF5fxLwFvP7fS7Ese
         B8rdO7yLJ9gxWZ0Qzno6+sq1oS+ZYph2uPSydRW5nyWkY+JGNxV8SDBlJTjaFsTaT8jy
         fo/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DZX4sYgXxdpSbOuCJhVuGZb+k3GPukvecVA74S1iE6s=;
        b=WdK196ojPynIplvKzH5cSIgnVZsLW6s3AaI+lgSOZdlJ6dSOcZsZw6zDZWBjmwC0pD
         kgUYsugVnGoJDeMKCG3iNCsCL51E4ByCcmsdHdZUnQ0OETFLiC8ptkOkev1XG7+X2m/x
         TL3vgm/B4StRvjW9o9wFxS+m3eF/XiuC2rYr9WKRjYSY51QEJ+8rPTIuxiy7OyxY5HEv
         ec1K5+Btw1yiQzAwjtsU/I/jsJxr87AU2OdHvHMN9DZg9BI+foK91QhNVobEnua4OGIP
         gd2a4WGe+11T/j8vAdUuwlR9VdJIJ0dEn27CjecjIQMKNOZpTeBAtP597LLPp+14QaUY
         XboA==
X-Gm-Message-State: AOAM531SZJ4vccyS3qgmw5tLDB9CJZEgosR/N13JWUszwNAhtjB0IjlL
        qDOInJyhlbOXezURutx0UubBhg==
X-Google-Smtp-Source: ABdhPJwz2c4bbyUfYDdljuXh0JGRMa40XpTlCfr5FYSXBBBiGXtCO0qRQQChDuAKOh+mInn49ucxvg==
X-Received: by 2002:adf:a40c:: with SMTP id d12mr3972733wra.91.1618499077694;
        Thu, 15 Apr 2021 08:04:37 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id o62sm9377757wmo.3.2021.04.15.08.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 08:04:37 -0700 (PDT)
Date:   Thu, 15 Apr 2021 15:04:34 +0000
From:   Quentin Perret <qperret@google.com>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com, lukasz.luba@arm.com,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH] PM / EM: Inefficient OPPs detection
Message-ID: <YHhWAvpReXjGwbl/@google.com>
References: <1617901829-381963-1-git-send-email-vincent.donnefort@arm.com>
 <1617901829-381963-2-git-send-email-vincent.donnefort@arm.com>
 <YHg7pfGKhzlMrXqC@google.com>
 <20210415141207.GA391924@e120877-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415141207.GA391924@e120877-lin.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 Apr 2021 at 15:12:08 (+0100), Vincent Donnefort wrote:
> On Thu, Apr 15, 2021 at 01:12:05PM +0000, Quentin Perret wrote:
> > Hi Vincent,
> > 
> > On Thursday 08 Apr 2021 at 18:10:29 (+0100), Vincent Donnefort wrote:
> > > Some SoCs, such as the sd855 have OPPs within the same performance domain,
> > > whose cost is higher than others with a higher frequency. Even though
> > > those OPPs are interesting from a cooling perspective, it makes no sense
> > > to use them when the device can run at full capacity. Those OPPs handicap
> > > the performance domain, when choosing the most energy-efficient CPU and
> > > are wasting energy. They are inefficient.
> > > 
> > > Hence, add support for such OPPs to the Energy Model, which creates for
> > > each OPP a performance state. The Energy Model can now be read using the
> > > regular table, which contains all performance states available, or using
> > > an efficient table, where inefficient performance states (and by
> > > extension, inefficient OPPs) have been removed.
> > > 
> > > Currently, the efficient table is used in two paths. Schedutil, and
> > > find_energy_efficient_cpu(). We have to modify both paths in the same
> > > patch so they stay synchronized. The thermal framework still relies on
> > > the original table and hence, DevFreq devices won't create the efficient
> > > table.
> > > 
> > > As used in the hot-path, the efficient table is a lookup table, generated
> > > dynamically when the perf domain is created. The complexity of searching
> > > a performance state is hence changed from O(n) to O(1). This also
> > > speeds-up em_cpu_energy() even if no inefficient OPPs have been found.
> > 
> > Interesting. Do you have measurements showing the benefits on wake-up
> > duration? I remember doing so by hacking the wake-up path to force tasks
> > into feec()/compute_energy() even when overutilized, and then running
> > hackbench. Maybe something like that would work for you?
> 
> I'll give a try and see if I get improved numbers.
> 
> > 
> > Just want to make sure we actually need all that complexity -- while
> > it's good to reduce the asymptotic complexity, we're looking at a rather
> > small problem (max 30 OPPs or so I expect?), so other effects may be
> > dominating. Simply skipping inefficient OPPs could be implemented in a
> > much simpler way I think.
> 
> I could indeed just skip the perf state if marked as ineffective. But the idea
> was to avoid bringing another for loop in this hot-path.

Right, though it would just extend a little bit the existing loop, so
the overhead is unlikely to be noticeable.

> Also, not covered by this patch but probably we could get rid of the EM
> complexity limit as the table resolution is way faster with this change.

Probably yeah. I was considering removing it since eb92692b2544
("sched/fair: Speed-up energy-aware wake-ups") but ended up keeping it
as it's entirely untested on large systems. But maybe we can reconsider.

Thanks,
Quentin
