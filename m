Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78711360A40
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 15:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbhDONMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 09:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbhDONMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 09:12:35 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0E8C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 06:12:10 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so12343847wmj.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 06:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TUSZ/BomOYlWKTNTQpJ8HqVOZhEzMmsbC34dCgL4juw=;
        b=aIsrTemccaGvtzgxncx3SEH3AGtsq45FIb2e3mR/w1P2nuD6g61axeT+uEGhNhck/r
         FdyuxTbKue2w6Cp1QgUqlUvtlzY7IC1GYL3n+BP4x9Wg5zKkYMlM0PyrHoch+p5fz6+C
         cnQueH0YTXw6n8jLTqkYY0/pEYopLxMYZ3kTXNGUYFMrgmLP7iavgVCe8gEf8U1wcynD
         OVor81zIa7Y+fr3YMMzJLQeeJnuHa12Wd0viQQzB8CKpz5UWJCnxYsCuo7p93hgTbgis
         K8+d9CnlrWQ9u6k1da9y4j96kPiMJQDLcJPztbDVmsd9Jv4DFA19dMBQDq/vRSVGG8d3
         zohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TUSZ/BomOYlWKTNTQpJ8HqVOZhEzMmsbC34dCgL4juw=;
        b=uZfPvSQVR8caV3WEsdieAXcf0s9hz2/yLbOMKYOp4bo2kC7bzGMZ5J/Lc8jZ38I4Hz
         /4SiUf7dLTL2gK1zXQNtJfhLHTE1GgvwD/+APbF8ANIiIKkp3qqs/BegLEjJ9j9GrYrG
         S7JxqCgboopRxDVBOJ1qn3wF+EVtcC9B3eJ3lmw/eW/Hn2jfJ8dT59nL2vjj86vo/2IO
         CZqCiyr9Aev9J6xP3Dkknxt58KU20mzvU8iSuTAsSymQsbo5WJmSSvyAKcvpaMI6RBLZ
         YCxA51ZGPgJ6N1aRiHXGIVKABT8Q7oYLZMWfUTRCy7WqY2cfG9ZUqkN9EIwNiSYuObI3
         tHLA==
X-Gm-Message-State: AOAM533oKg8zZpzrgywp1Ua29Nq8dNJpKIb5ZuGdKTLOZyFEqjczDAW4
        V+F61fE87+I1GjfL/uR/TGLiGQ==
X-Google-Smtp-Source: ABdhPJy/MDbZwe+gvLFz77StseXRnPfAQ/GuF0VdBHDh9g6iaEP5utLLO9C0ujSmdYI9OVERJg48FA==
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr3074244wmk.3.1618492329262;
        Thu, 15 Apr 2021 06:12:09 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id h81sm3291938wmf.41.2021.04.15.06.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 06:12:08 -0700 (PDT)
Date:   Thu, 15 Apr 2021 13:12:05 +0000
From:   Quentin Perret <qperret@google.com>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com, lukasz.luba@arm.com,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH] PM / EM: Inefficient OPPs detection
Message-ID: <YHg7pfGKhzlMrXqC@google.com>
References: <1617901829-381963-1-git-send-email-vincent.donnefort@arm.com>
 <1617901829-381963-2-git-send-email-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617901829-381963-2-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Thursday 08 Apr 2021 at 18:10:29 (+0100), Vincent Donnefort wrote:
> Some SoCs, such as the sd855 have OPPs within the same performance domain,
> whose cost is higher than others with a higher frequency. Even though
> those OPPs are interesting from a cooling perspective, it makes no sense
> to use them when the device can run at full capacity. Those OPPs handicap
> the performance domain, when choosing the most energy-efficient CPU and
> are wasting energy. They are inefficient.
> 
> Hence, add support for such OPPs to the Energy Model, which creates for
> each OPP a performance state. The Energy Model can now be read using the
> regular table, which contains all performance states available, or using
> an efficient table, where inefficient performance states (and by
> extension, inefficient OPPs) have been removed.
> 
> Currently, the efficient table is used in two paths. Schedutil, and
> find_energy_efficient_cpu(). We have to modify both paths in the same
> patch so they stay synchronized. The thermal framework still relies on
> the original table and hence, DevFreq devices won't create the efficient
> table.
> 
> As used in the hot-path, the efficient table is a lookup table, generated
> dynamically when the perf domain is created. The complexity of searching
> a performance state is hence changed from O(n) to O(1). This also
> speeds-up em_cpu_energy() even if no inefficient OPPs have been found.

Interesting. Do you have measurements showing the benefits on wake-up
duration? I remember doing so by hacking the wake-up path to force tasks
into feec()/compute_energy() even when overutilized, and then running
hackbench. Maybe something like that would work for you?

Just want to make sure we actually need all that complexity -- while
it's good to reduce the asymptotic complexity, we're looking at a rather
small problem (max 30 OPPs or so I expect?), so other effects may be
dominating. Simply skipping inefficient OPPs could be implemented in a
much simpler way I think.

Thanks,
Quentin
