Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C463F50F9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 21:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhHWTDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 15:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhHWTDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 15:03:45 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CADC061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 12:03:03 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id k14so17522077pga.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 12:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YkK/qTUrFTgZHIDt5iH1aOGIxZdv/W3IYDYjxB9+gv8=;
        b=XNjiVLI5da6K+7Jse8Fgb5p4m/1QcZdOYot9XspK6KeEKERUWxaubqh2aqcjCDNEZc
         p95jOdjCxWmYLtkIv6FAFJvaTcb7X1NmB8H2IWSajFtL8pS3E+Dq+N46SFdO9O1Kqmgp
         RzesYjCaYpr7cZRoRWh2iU3An0W89admLKv+e7gZG4IlhXtTsjhM+I4Dc7FYeO3YYmqB
         c2ud01WfyiZVPeztjkGvA2IZpNQON3hjAQftRalgJg0mWAPe6SGnT9knvXk66kiRxLtE
         in2AF3jJMwePu4odUJdearNjVxo7BzvOC4JSwWw/0fKpUEoROCvw8Q8JgNko0VTqNsoU
         1hbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=YkK/qTUrFTgZHIDt5iH1aOGIxZdv/W3IYDYjxB9+gv8=;
        b=qh7M1wGLT2feiwEUgXIq8SA6YdN0wUCLdZq2t5gsHlIyFJQFvyJ03MlpRWerCxFPJ/
         f/tBp646hlWS4vutkJ6Y9tChLeD2O14fhbBLPrfp0SoqEzjE8z21opdaKX0+DlkT7noK
         urvdWRI3SkP9lGvUVjTNdWg1ZslCk0lYAjCX1GpeXBsyiIbL+nwlXglDAKyT7oGvsb7T
         lfHLzLpl4f3tsePeWdGw/J4tbiVBDPnrVjR7I7sJRtrkBCB8qh/1NbIOtlPGbupCSXDd
         zXW0oQaqxIqnUEgE5pkM0k0es4oxk7NHmzqjEACUSymOh4FzSPZz6EZVlvkLhVYxyrgg
         GiKQ==
X-Gm-Message-State: AOAM532jUlygRfeK9LsffP8854zD/bNucc/GbRR7eL77cVzrYZqG8yGd
        Gr5xh5/LaXh26kJjAfMazfM=
X-Google-Smtp-Source: ABdhPJxD3tUc5r+znTp2rC4qlGtDnCxGZH7VlEciAVce/eWfJNemQuIskblHYqrapuEPJHsdeLRHVg==
X-Received: by 2002:a62:ea06:0:b0:3e1:62a6:95b8 with SMTP id t6-20020a62ea06000000b003e162a695b8mr35715128pfh.70.1629745382526;
        Mon, 23 Aug 2021 12:03:02 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id o2sm12926703pgu.76.2021.08.23.12.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 12:03:02 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 23 Aug 2021 09:03:00 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Huaixin Chang <changhuaixin@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        anderson@cs.unc.edu, baruah@wustl.edu, bsegall@google.com,
        dietmar.eggemann@arm.com, dtcccc@linux.alibaba.com,
        juri.lelli@redhat.com, khlebnikov@yandex-team.ru,
        luca.abeni@santannapisa.it, mgorman@suse.de, mingo@redhat.com,
        odin@uged.al, odin@ugedal.com, pauld@redhead.com, pjt@google.com,
        rostedt@goodmis.org, shanpeic@linux.alibaba.com,
        tommaso.cucinotta@santannapisa.it, vincent.guittot@linaro.org,
        xiyou.wangcong@gmail.com
Subject: Re: [PATCH 1/2] sched/fair: Add cfs bandwidth burst statistics
Message-ID: <YSPw5B0Njj3sUdKB@slm.duckdns.org>
References: <20210816070849.3153-1-changhuaixin@linux.alibaba.com>
 <20210816070849.3153-2-changhuaixin@linux.alibaba.com>
 <20210823183210.bih6p77fh3gwdfic@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823183210.bih6p77fh3gwdfic@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 02:32:10PM -0400, Daniel Jordan wrote:
> burst_time is nsec, not usec.
> 
> Just "burst_time" seems the way to go for consistency with
> throttled_time in the same file, though "burst_usec" nicely has units
> and would have the same name between cgroup1 and 2.

The cgroup2 interface rule is that time units are in usecs. The right thing
to do is keeping the _usec postfix (to avoid confusion due to the unit
change from cgroup1) and converting it to usecs for printing.

Thanks.

-- 
tejun
