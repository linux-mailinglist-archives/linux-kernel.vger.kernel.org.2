Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5878D3A108E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 12:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238301AbhFIJwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 05:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbhFIJwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 05:52:00 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76853C061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 02:50:05 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id m18so24766497wrv.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 02:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mo2MpnwO+DP1xBqMB5A5oZXEQTDPzNqnBAMMCRHk0qU=;
        b=aHVaB78QW2al8xftgLHHNIwy+SLjjHsFX1lzf7byM3S40NtD1wBBnlX8Voni3IMR/y
         zdd8lKXSqZKsAzFY2Czkh5n3H6+6gP3pQXI5vOGMbza6QLQ0+/12SDv7PX0VGsrdYXl5
         zsSkurW6FXjuYimj7xbJqW0GqnNPN0P9AcbslCbAaK3InPsHlgUHgmbQUdQAdu6xaX4F
         5LDWAQFru4FkSUFXIr/5vgZxj1iZ350sAse9682bXTbg5WTiV6akRydgOstg546rjO9y
         RVLO2H0A9YqiQGQGD2bbTZoGVQ50VY+N+D0cJShMHZA1N/jTwk1NiQ+oG0eZbn6AZAxx
         zzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mo2MpnwO+DP1xBqMB5A5oZXEQTDPzNqnBAMMCRHk0qU=;
        b=KrySFDKQ8ULp/3Xrgr9SBynjJAmzP+bNAVqChroBJBcLvdRu7JaJPq3r8ZF0FgfI2w
         SwAjGOJsmbNNbhGB9/ajjh7mFOUNKZ+FiFf+vLsDHG6qufU29GcyFJ815OmNpeACEByb
         bIhyOg5KvnTHjhH+l/GJOq/PbvIhW1XlM6BeWZQF9QdpxLOiazLn+YwH1BnPnMjNKauU
         7pxh50W2LY0pdemCGwPVCPn+nmBmTisRHbvIijNnSrU15sq57lfINMDthFXP3NMDUyhU
         dT0COXxpR2qJaljdhDtSzT1h7RtorI6bjCes8suYKisaqo7jePoipOGShPgOPK3Ieatw
         Cn1A==
X-Gm-Message-State: AOAM530sdf6SrxVdYc5YTXnD9mmiE9VpSqYYRotvU1ixKNQfjYG1biRr
        uusMdg2mmWInE1WFys4d1qFdNg==
X-Google-Smtp-Source: ABdhPJz85kXGsLZgpb12ckUI7Ql2IonQUqQ9tKtKoMUDYQLhVaXEatKs4J4Qf0A5DM7WVUVS6D+ZNQ==
X-Received: by 2002:a05:6000:1b8d:: with SMTP id r13mr27287328wru.207.1623232203913;
        Wed, 09 Jun 2021 02:50:03 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id z12sm25372344wmc.5.2021.06.09.02.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 02:50:03 -0700 (PDT)
Date:   Wed, 9 Jun 2021 09:50:00 +0000
From:   Quentin Perret <qperret@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Beata Michalska <beata.michalska@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: iowait boost is broken
Message-ID: <YMCOyL8eiu9UpnEz@google.com>
References: <CAEXW_YTcO=hbmdq3nOx2RJfT2yPyoFnQx5niB38R2Lzpsp38bA@mail.gmail.com>
 <20210607191031.GA12489@e120325.cambridge.arm.com>
 <YL+tDv/EL5ogf/0w@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL+tDv/EL5ogf/0w@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 Jun 2021 at 19:46:54 (+0200), Peter Zijlstra wrote:
> On Mon, Jun 07, 2021 at 08:10:32PM +0100, Beata Michalska wrote:
> > So back to the expectations.
> > The main problem, as I see it, is what do we actually want to achieve with
> > the I/O boosting? Is it supposed to compensate the time lost while waiting
> > for the I/O request to be completed or is is supposed to optimize the rate
> > at which I/O requests are being made. 
> 
> The latter, you want to increase the race of submission.
> 
> > Do we want to boost I/O bound tasks by
> > default, no limits applied  or should we care about balancing performance
> > vs power ? And unless those expectations are clearly stated, we might not
> > get too far with any changes, really.
> 
> You want to not increase power beyond what is needed to match the rate
> of processing I suppose.

Note that in some cases we also don't care about throughput, and would
prefer to keep the frequency for some unimportant IO bound tasks (e.g.
background logging deamons and such). Uclamp.max indicates this to some
extent.

Android for instance has a pretty good idea of the tasks it cares about,
and it'd be good to have a way to enable IO wait boosting only for
those.

Thanks,
Quentin
