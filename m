Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4903381EF4
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 15:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbhEPNCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 09:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhEPNCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 09:02:50 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1612BC061573;
        Sun, 16 May 2021 06:01:34 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id y14so1561383wrm.13;
        Sun, 16 May 2021 06:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uKxhfXqsz5KiS3/U8uvLI52MLsIje961R562h2mq3u8=;
        b=ajEVunZo3Gvh6N5465bXB+09XeuhSK4MSpnt0cIb6Z/rnwM4cyEZkIcpVpWiw/u/dU
         3IzMjNeVU26UNzFu/sHPKsA2YLpRA4t+kTKa1hGW3JO39PHhYj8cSQe6xS26NWtRuv24
         hqVvsc/mhZrLlJj/RqePV+wGT68o0pU68sUNsTBdaGqQCSWKo4XMUVFmk5YCNrl7Bb93
         ZqpuqhkR8G0rS7CTHAdfq9ybzio/1CDILDQn8/eAfveXmxNy3z7OZcnZvs06t1HS4jzP
         7veW8LiHN4oGR0DYVskeD5jFvHHaPEnx66LYPp/OUEwQM003U8U/NJcnIo16QMLQlDo9
         Q1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uKxhfXqsz5KiS3/U8uvLI52MLsIje961R562h2mq3u8=;
        b=tQiWPjiaXO6Jm38LJ9HA39s4BuyEDzHVFvxuBmpWrK5oHL2R43/WzRRGH/VoOZ1Sva
         gsLZXlbVdeTDtfxsgo4r3dXj3E1lK4aTc0aMhf9v7pnCz827k+M9BivL8pMhmQ0PMROZ
         cC78A/RRO5Umtn6uKAud5qlpN+UjYv1gvueZUyrRh05iyqG3fGQwCiP9iqrUs/sWBVMP
         741dfam/q9ySveKqWKj7Kb3uPjOixlZPdRx7eZvQpU88HQHliHP36r7dY4bqN1yeGER9
         rOTG2RCz4B1kMSY2kWnclxzRwoy7E3XrICzUUl2H6CTm4ZyXGyt4UrhSZI2DlEJ5Kve+
         d96g==
X-Gm-Message-State: AOAM530RRid2tbYOPYvpyCNvCxhf82xbWLeVe0sqbTNVPaUA9+s7heSq
        FOCPS9EFW8cKbyptChpz2ys=
X-Google-Smtp-Source: ABdhPJwSWY55GFLxHrUTMkefdD6C9KYN1+EwzpZ5LjhvdUv7VmMoksOU5bTtqF6xYoihkNkyhwSNSg==
X-Received: by 2002:a5d:6248:: with SMTP id m8mr69071465wrv.42.1621170092715;
        Sun, 16 May 2021 06:01:32 -0700 (PDT)
Received: from ard0534 ([102.156.106.137])
        by smtp.gmail.com with ESMTPSA id u126sm5937911wmb.9.2021.05.16.06.01.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 May 2021 06:01:32 -0700 (PDT)
Date:   Sun, 16 May 2021 14:01:29 +0100
From:   Khaled Romdhani <khaledromdhani216@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH-next] sched: Fix Null pointer derefrence
Message-ID: <20210516130129.GA32445@ard0534>
References: <20210515164645.22849-1-khaledromdhani216@gmail.com>
 <20210515210238.GG5618@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210515210238.GG5618@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2021 at 11:02:38PM +0200, Peter Zijlstra wrote:
> On Sat, May 15, 2021 at 05:46:45PM +0100, Khaled ROMDHANI wrote:
> > The 'curr' variable could be NULL and derefrenced by
> > pick_next_entity. Fix this by adding a check that prevent
> > the invocation of pick_next_entity with a NULL passed argument.
> 
> And why exactly is that a problem?
>
Within pick_next_entity, we could have 'left = curr'. 
Thus the function wakeup_preempt_entity which is invoked 
from pick_next_entity, derefrence the the sched entity 'left' 
that may be a NULL passed argument.
