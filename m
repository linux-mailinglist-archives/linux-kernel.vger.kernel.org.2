Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB33310471
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 06:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhBEFSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 00:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhBEFSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 00:18:10 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28295C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 21:17:30 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id o21so2321777pgn.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 21:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O4cRtZruXboHwdwpsrWR0FgPvU0D3io6KdJXESFf9ao=;
        b=ZJgt47b89QUQlQpNCk2RzHQADY4sdnAmKJ8jK3iomTBS3kuVnET2qJ6TYJeTas0uQJ
         N0VKrsuo+G8G0p/2boVtfJfg3WK3+LDUux+tXVl+kqApyjiKQW3bL98+eOloGeRPPxck
         fOLu0QXckPuYgiY63CcKCU8bppXngLh0YJMFJzcWN6XboFp8cuku9yqi64aViGN4pphN
         VqqaW1wGpXpfoqTDLx0cqdIm9/og7/djeduxtCDG+URYROaS7lTVA5QqflqhW7e3yEvX
         1L6xToHizavx21g27FDOAuwMWUrFEZaQE1GbrQxTDo/lI22mtH/33BeysNCLX1dOt5gf
         /6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=O4cRtZruXboHwdwpsrWR0FgPvU0D3io6KdJXESFf9ao=;
        b=KlcSU03hLas5AoV+M7/QddFAouxvnBsDafoZcQFBTE8Nog6vu6OwZYgLfxgL156Zqr
         LRs6l3Sr9SWPAA2XleyoGo3z9THODYwHhm2SiNzmvxOqWIqXIOh8ZboOwsdlsrsiv7u+
         2AV4FF6ORaf8dt0QZC/uDMH/NW3OoUs0sOzl1ug1rQn6ard11AAQJuNqrqkR8XlQgAJt
         G2QvXhf+vdkmcjX1+HTE97FxDSro1XYeSp5cJHFcuEl+3DRB96tu9FX2EzDuYOVoP6Ae
         E3cdYvRTvt0vTa87VU2Yx2XC1YkH8QS/OG94qLlTDMlLl4Uj8fJQB7e5wPlp9ofWdKFx
         0qbg==
X-Gm-Message-State: AOAM530yVkexMq1ON9euT4cb3WdVPZ6Nd7MnyucCi15emMeA3ZLvgQcJ
        pNK6cLMVG74csh6405wTbZGIUrifJJo=
X-Google-Smtp-Source: ABdhPJwD0qHX0hn2zLkvYd5rTaz7KYjrQysriZgmB3LZpcD7MhILeJTe+jTIlkjKVWAnr5Ixl2cTTw==
X-Received: by 2002:a65:6152:: with SMTP id o18mr2668294pgv.392.1612502249646;
        Thu, 04 Feb 2021 21:17:29 -0800 (PST)
Received: from google.com ([2620:15c:211:201:598:57c0:5d30:3614])
        by smtp.gmail.com with ESMTPSA id v3sm7158907pff.217.2021.02.04.21.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 21:17:28 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 4 Feb 2021 21:17:26 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        gregkh@linuxfoundation.org, surenb@google.com, joaodias@google.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: cma: support sysfs
Message-ID: <YBzU5uUbwa+QIwBQ@google.com>
References: <20210203155001.4121868-1-minchan@kernel.org>
 <7e7c01a7-27fe-00a3-f67f-8bcf9ef3eae9@nvidia.com>
 <YBxT9XFE6QAQ4T9N@google.com>
 <cda5547b-0c78-756b-bd0c-f3e534d04bff@nvidia.com>
 <YByNU4Q7cc7gYwPh@google.com>
 <87d7ec1f-d892-0491-a2de-3d0feecca647@nvidia.com>
 <YByi/gdaGJeV/+8b@google.com>
 <71c4ce84-8be7-49e2-90bd-348762b320b4@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71c4ce84-8be7-49e2-90bd-348762b320b4@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 06:52:01PM -0800, John Hubbard wrote:
> On 2/4/21 5:44 PM, Minchan Kim wrote:
> > On Thu, Feb 04, 2021 at 04:24:20PM -0800, John Hubbard wrote:
> > > On 2/4/21 4:12 PM, Minchan Kim wrote:
> > > ...
> > > > > > Then, how to know how often CMA API failed?
> > > > > 
> > > > > Why would you even need to know that, *in addition* to knowing specific
> > > > > page allocation numbers that failed? Again, there is no real-world motivation
> > > > > cited yet, just "this is good data". Need more stories and support here.
> > > > 
> > > > Let me give an example.
> > > > 
> > > > Let' assume we use memory buffer allocation via CMA for bluetooth
> > > > enable of  device.
> > > > If user clicks the bluetooth button in the phone but fail to allocate
> > > > the memory from CMA, user will still see bluetooth button gray.
> > > > User would think his touch was not enough powerful so he try clicking
> > > > again and fortunately CMA allocation was successful this time and
> > > > they will see bluetooh button enabled and could listen the music.
> > > > 
> > > > Here, product team needs to monitor how often CMA alloc failed so
> > > > if the failure ratio is steadily increased than the bar,
> > > > it means engineers need to go investigation.
> > > > 
> > > > Make sense?
> > > > 
> > > 
> > > Yes, except that it raises more questions:
> > > 
> > > 1) Isn't this just standard allocation failure? Don't you already have a way
> > > to track that?
> > > 
> > > Presumably, having the source code, you can easily deduce that a bluetooth
> > > allocation failure goes directly to a CMA allocation failure, right?
> 
> Still wondering about this...

It would work if we have full source code and stack are not complicated for
every usecases. Having said, having a good central place automatically
popped up is also beneficial for not to add similar statistics for each
call sites.

Why do we have too many item in slab sysfs instead of creating each call
site inventing on each own?

> 
> > > 
> > > Anyway, even though the above is still a little murky, I expect you're right
> > > that it's good to have *some* indication, somewhere about CMA behavior...
> > > 
> > > Thinking about this some more, I wonder if this is really /proc/vmstat sort
> > > of data that we're talking about. It seems to fit right in there, yes?
> > 
> > Thing is CMA instance are multiple, cma-A, cma-B, cma-C and each of CMA
> > heap has own specific scenario. /proc/vmstat could be bloated a lot
> > while CMA instance will be increased.
> > 
> 
> Yes, that would not fit in /proc/vmstat...assuming that you really require
> knowing--at this point--which CMA heap is involved. And that's worth poking
> at. If you get an overall indication in vmstat that CMA is having trouble,
> then maybe that's all you need to start digging further.

I agree it could save to decide whether I should go digging further
but anyway, I need to go though each of instance once it happens.
In that, what I need is per-CMA statistics, not global.
I am happy to implement it but I'd like to say it's not my case.

> 
> It's actually easier to monitor one or two simpler items than it is to monitor
> a larger number of complicated items. And I get the impression that this is
> sort of a top-level, production software indicator.

Let me clarify one more time.

What I'd like to get ultimately is per-CMA statistics instead of
global vmstat for the usecase at this moment. Global vmstat
could help the decision whether I should go deeper but it ends up
needing per-CMA statistics. And I'd like to keep them in sysfs,
not debugfs since it should be stable as a telemetric.

What points do you disagree in this view?
