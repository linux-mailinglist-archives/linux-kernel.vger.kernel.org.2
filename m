Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B81E3E1A28
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 19:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238547AbhHERN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 13:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237497AbhHERN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 13:13:26 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B26C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 10:13:11 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id nh14so10468640pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 10:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QA00P76bflJpvFVXRXCqF/ydJ5VOL2iYfCDbkN0GqY8=;
        b=dPL//LUqTtrv8CLM5kof9yFH7N2piQ/iZSo6IKnwqe6aj5AsKoXqNSIm7k7gjlxR8O
         iuzUumNd3+dySQUHoINH6ZvB7cYFzRnwohovKAaUAeBoejGAUrIzOHUBOugv3D9j/5CE
         8L/RmhA0fyA7Xxm7rDs7T9A6IZxLETE0paOods9c+ot1mUkJOeOr2QMW83MnyDP6R5SG
         UEE7ncNeKzEmkjtosOO+xCKNwYqwv7SoOQBgwy6iFEGHcjI8cjvpwxFHbLA1lcIe6ggf
         14HVTtNF4RRJEOP65jqQb3Pv/E7YIVdSPMARry9mZT3x2yd4qROW9JvMiKVmlZYfb+wp
         9QMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=QA00P76bflJpvFVXRXCqF/ydJ5VOL2iYfCDbkN0GqY8=;
        b=dwkAiPrgckwgeLWuhfszY9ESIYYmYitz1DEHdm+EF5bpbaKj6l7Bi3gWbjeN0LzivR
         iTq4kTkOVeZJNfnzYZgYQl5DRLEfJ6owiiRnL8B9NgcQlTK61xLf7PhWLysKbIutbMR5
         d6vVmn7LdUMTk++kNIGsG+DgfcOlhU+fM6KbcwYLi5vQlLUP+CRum2VHUqvWX8Wc4pII
         oxDswuiaORiNTlI9J3lMehamtmliAdFUUr/6+vz4SNkkGwanGF3sY3/WAFPTEsRPzh2z
         0mDwZeLJ1ozTIyG+ERFhr3UksPCS2QqDJCDj6uvdIAI58deAeHP83v6JFfpqymvCUIbM
         kZew==
X-Gm-Message-State: AOAM533EU+up086Ngs2fRXZGB3U2nOFQowpXKH4fehabZuCV77S1LvPc
        bLG2EWXtRVlTIPVUqdD1qY8=
X-Google-Smtp-Source: ABdhPJxX4D3KwnOrHMR0fi0zPokEsF0OiWg9Ye/AaA06LrH3XFRI9rd5cNxLnJ9xehybB6O48X0hJw==
X-Received: by 2002:a17:902:8bc3:b029:124:919f:6213 with SMTP id r3-20020a1709028bc3b0290124919f6213mr4867351plo.51.1628183591035;
        Thu, 05 Aug 2021 10:13:11 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:71c8])
        by smtp.gmail.com with ESMTPSA id y26sm7412826pfp.176.2021.08.05.10.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 10:13:10 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 5 Aug 2021 07:13:06 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Paul Turner <pjt@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] sched: cgroup SCHED_IDLE support
Message-ID: <YQwcIpnKq3TYYIIL@mtj.duckdns.org>
References: <20210730020019.1487127-1-joshdon@google.com>
 <20210730020019.1487127-2-joshdon@google.com>
 <20210805101849.GH8057@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805101849.GH8057@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Aug 05, 2021 at 12:18:49PM +0200, Peter Zijlstra wrote:
> So I'm tempted to apply this, but last time TJ wasn't liking it much for
> the interface or somesuch. His argument that this encodes the
> hierarchical scheduling behaviour, but I'm not really buying that
> argument, as it doesn't really add more constraints than we already have
> by the hierarchical relative weight.

Interface-wise, writing 1 to idle file is fine. This does move away
the interface from being a purely semantical weight tree, which is a
concern and I have a difficult time seeing that the stated benefits
are significant enough to justify the changes. That said, this is
primarily a scheduler decision, so if you think the addition is
justified, please go ahead.

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
