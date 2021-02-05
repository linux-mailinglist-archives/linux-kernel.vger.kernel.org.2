Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22919310167
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 01:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhBEAMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 19:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbhBEAMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 19:12:47 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BB1C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 16:12:06 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id q131so3146588pfq.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 16:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b4ycEO4evAawcZSSp5/4zazbkQfIzLENcMS782LOHnM=;
        b=AR3/UfbnaRS0WW5Opg+6Iwllpjmb39MMQyQmhd5xHbgW2wrZ46dXzoQo/EsX0tVb0p
         oUCElygVNIK6KK85kIX5apojC1S72j3L8d8/g2NmxIT7+WwuJqiXb9WtQiq5Ldb+j3Yo
         jkioddhYuta3LDBDuudquQOKGwlphK0AcnJmfD6JRb8roABp/7UIJ9TBE5SJAg4SWTpk
         KmCbp90fnZ6kENwSaPY6aeim8vpU6ejBKNADJ6SdJ9JHS3I6j65n1GBaeYtpLvvRYsU4
         KEr2iNcqsNEkbQzLKFnCzpYed/+/gxxI0w43RisVlB2xgRQL/zIT1eGW6JUW8Db2k6oN
         wFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=b4ycEO4evAawcZSSp5/4zazbkQfIzLENcMS782LOHnM=;
        b=fIAB1sP0q/cHoSnRFouse5YnxlPIRqsFVAaZ9vD1BtbB5mLn/N1douZs3xyk9qyZog
         huzgqjCenISbU97N0SXJ0EOriaa6+9Gyrt1fSLnOdYxOYG1oI4OF/vC8FHjbLJKAylKO
         2MRaFKUMcPzvrSRL864nhJuJZRsLrhGpqe89POeEZtPwlfgoM9ZfD+9FAZxQfYX51IxO
         znEZjLXGLuSlNFv+nPEQma3RmEzooUvk0QvbTOmhFsy33wwsBBiylu3b6Cg55kI0QSLT
         dtobILdci708T1PI+8GaHGhq9oRD0DuqWnMCrbOhKCQiu48ASNhNgcXtkGY9lPwYYnso
         4R7Q==
X-Gm-Message-State: AOAM532MOSsEO2arC4FHcGfRVPsCdLjiL5D8csZmfreGj9XnvaY1EVrp
        i2X5U1LLnYOr3YzaBqEyD5Q=
X-Google-Smtp-Source: ABdhPJxE+lnwoYnBRrHGmeO0kssUBOMKGbyC0+XmDpwn+BygstIH/TX6KSbDEVGIPZaBnCEfsk//WQ==
X-Received: by 2002:a63:3191:: with SMTP id x139mr1508555pgx.272.1612483926459;
        Thu, 04 Feb 2021 16:12:06 -0800 (PST)
Received: from google.com ([2620:15c:211:201:598:57c0:5d30:3614])
        by smtp.gmail.com with ESMTPSA id j65sm7153639pfb.23.2021.02.04.16.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 16:12:05 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 4 Feb 2021 16:12:03 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        gregkh@linuxfoundation.org, surenb@google.com, joaodias@google.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: cma: support sysfs
Message-ID: <YByNU4Q7cc7gYwPh@google.com>
References: <20210203155001.4121868-1-minchan@kernel.org>
 <7e7c01a7-27fe-00a3-f67f-8bcf9ef3eae9@nvidia.com>
 <YBxT9XFE6QAQ4T9N@google.com>
 <cda5547b-0c78-756b-bd0c-f3e534d04bff@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda5547b-0c78-756b-bd0c-f3e534d04bff@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 03:14:56PM -0800, John Hubbard wrote:
> On 2/4/21 12:07 PM, Minchan Kim wrote:
> > On Thu, Feb 04, 2021 at 12:50:58AM -0800, John Hubbard wrote:
> > > On 2/3/21 7:50 AM, Minchan Kim wrote:
> > > > Since CMA is getting used more widely, it's more important to
> > > > keep monitoring CMA statistics for system health since it's
> > > > directly related to user experience.
> > > > 
> > > > This patch introduces sysfs for the CMA and exposes stats below
> > > > to keep monitor for telemetric in the system.
> > > > 
> > > >    * the number of CMA allocation attempts
> > > >    * the number of CMA allocation failures
> > > >    * the number of CMA page allocation attempts
> > > >    * the number of CMA page allocation failures
> > > 
> > > The desire to report CMA data is understandable, but there are a few
> > > odd things here:
> > > 
> > > 1) First of all, this has significant overlap with /sys/kernel/debug/cma
> > > items. I suspect that all of these items could instead go into
> > 
> > At this moment, I don't see any overlap with item from cma_debugfs.
> > Could you specify what item you are mentioning?
> 
> Just the fact that there would be two systems under /sys, both of which are
> doing very very similar things: providing information that is intended to
> help diagnose CMA.
> 
> > 
> > > /sys/kernel/debug/cma, right?
> > 
> > Anyway, thing is I need an stable interface for that and need to use
> > it in Android production build, too(Unfortunately, Android deprecated
> > the debugfs
> > https://source.android.com/setup/start/android-11-release#debugfs
> > )
> 
> That's the closest hint to a "why this is needed" that we've seen yet.
> But it's only a hint.
> 
> > 
> > What should be in debugfs and in sysfs? What's the criteria?
> 
> Well, it's a gray area. "Debugging support" goes into debugfs, and
> "production-level monitoring and control" goes into sysfs, roughly

True.

> speaking. And here you have items that could be classified as either.
> 
> > 
> > Some statistic could be considered about debugging aid or telemetric
> > depening on view point and usecase. And here, I want to use it for
> > telemetric, get an stable interface and use it in production build
> > of Android. In this chance, I'd like to get concrete guideline
> > what should be in sysfs and debugfs so that pointing out this thread
> > whenever folks dump their stat into sysfs to avoid waste of time
> > for others in future. :)
> > 
> > > 
> > > 2) The overall CMA allocation attempts/failures (first two items above) seem
> > > an odd pair of things to track. Maybe that is what was easy to track, but I'd
> > > vote for just omitting them.
> > 
> > Then, how to know how often CMA API failed?
> 
> Why would you even need to know that, *in addition* to knowing specific
> page allocation numbers that failed? Again, there is no real-world motivation
> cited yet, just "this is good data". Need more stories and support here.

Let me give an example.

Let' assume we use memory buffer allocation via CMA for bluetooth
enable of  device.
If user clicks the bluetooth button in the phone but fail to allocate
the memory from CMA, user will still see bluetooth button gray.
User would think his touch was not enough powerful so he try clicking
again and fortunately CMA allocation was successful this time and
they will see bluetooh button enabled and could listen the music.

Here, product team needs to monitor how often CMA alloc failed so
if the failure ratio is steadily increased than the bar,
it means engineers need to go investigation.

Make sense?

