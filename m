Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B808453BBD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 22:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhKPVjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 16:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhKPVjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 16:39:01 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91A2C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 13:36:03 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id v23so521898pjr.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 13:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IWK7OD89/E3d8/50kdm3DXiItmWvHUyayIclf0RvznU=;
        b=AyqX/2F7O+S4sQzsTx+vvxxla63ZoTYMRupxAH7Ru+VMW3NgN+Uc1GArs67SjA4Ext
         pQ2rx1zXP7jc0tGMTzLW+73K2tRhuOJqK0wP1AMlN81/2e9sbCFEepvoPPvRL6QVyszq
         u9ihRGqYqeSmh9boIDi/RejiAacY8C+cgkcCybMVUOqMKJQloE8lahwQrZxWwJoe8nLs
         fa7MYVMCjO19Bl/pUCdt8x5qR1IqRdW5F/ik3xjJYiRxkivsyETbXeVs3hqLUsxiO6or
         Mu2K4fqMxPW28LpkhjnLlCu/YfHq8+mqUmXLOQ23kBFmW5MfyIbr7nHCxNN7w60nHla2
         J6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=IWK7OD89/E3d8/50kdm3DXiItmWvHUyayIclf0RvznU=;
        b=QXASlnD87zdgyARZk4dqXHbOPyy1ZgF/250+0p0UIEtlwWG8SJosdokdn7t65hzrRB
         ZypelIxDLPi7eEb1gyKbBWoUDiUtWdwm9P8HMbr9ALJau0WFo+xWcivWtnsN0dmSwBbm
         7Jq9Jjtv9lzwgnyXdQobV9Cnb9c2e3n3EF4Y0lWo+N8SERY944R4Y3m5wawf7Ocvgwph
         1anwsG9jmClr3bqclbyMAfJnYm9TcqEOAmlb4wxOfvxGmdTtW3bwDqZGVwpdjy5WDjdA
         k2xZuP+fWoqoNi5Yjf4rYzDULJQnzzTetJsyHudaGaK08DIQOy5O3wruexFxwTL1AEOg
         Ec8A==
X-Gm-Message-State: AOAM533dBP9pEaCb8uFeq51Dd3KwgkCJdcorx58gQ1xEZF0ORyFALDeD
        SdrnPnM/PXLEWM8CK9I6Wlk=
X-Google-Smtp-Source: ABdhPJw9GjOnJ5FEkc8VRKrM2vJuEHC1ovtTXO7kqIS1RfXRFIMSmiS23cz9nnNgk2mr6T3NTcel7Q==
X-Received: by 2002:a17:90b:1185:: with SMTP id gk5mr2646515pjb.113.1637098563139;
        Tue, 16 Nov 2021 13:36:03 -0800 (PST)
Received: from google.com ([2620:15c:211:201:3a93:19e8:b5b5:97fd])
        by smtp.gmail.com with ESMTPSA id h18sm21074342pfh.172.2021.11.16.13.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 13:36:02 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 16 Nov 2021 13:36:01 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] kernfs: release kernfs_mutex before the inode
 allocation
Message-ID: <YZQkQcrldGFwqV/r@google.com>
References: <20211116194317.1430399-1-minchan@kernel.org>
 <YZQLWq7WMSRF2xCM@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZQLWq7WMSRF2xCM@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 08:49:46PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Nov 16, 2021 at 11:43:17AM -0800, Minchan Kim wrote:
> > The kernfs implementation has big lock granularity(kernfs_rwsem) so
> > every kernfs-based(e.g., sysfs, cgroup, dmabuf) fs are able to compete
> > the lock. Thus, if one of userspace goes the sleep under holding
> > the lock for a long time, rest of them should wait it. A example is
> > the holder goes direct reclaim with the lock since it needs memory
> > allocation. Let's fix it at common technique that release the lock
> > and then allocate the memory. Fortunately, kernfs looks like have
> > an refcount so I hope it's fine.
> > 
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> >  fs/kernfs/dir.c             | 14 +++++++++++---
> >  fs/kernfs/inode.c           |  2 +-
> >  fs/kernfs/kernfs-internal.h |  1 +
> >  3 files changed, 13 insertions(+), 4 deletions(-)
> 
> What workload hits this lock to cause it to be noticable?

A app launching since it was dropping the frame since the
latency was too long.

> 
> There was a bunch of recent work in this area to make this much more
> fine-grained, and the theoritical benchmarks that people created (adding
> 10s of thousands of scsi disks at boot time) have gotten better.
> 
> But in that work, no one could find a real benchmark or use case that
> anyone could even notice this type of thing.  What do you have that
> shows this?

https://developer.android.com/studio/command-line/perfetto
https://perfetto.dev/docs/data-sources/cpu-scheduling

Android has perfetto tracing system and can show where processes
were stuck. This case was the lock since holder was in direct reclaim
path.
