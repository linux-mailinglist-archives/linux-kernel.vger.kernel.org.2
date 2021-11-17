Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B025A45502D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 23:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237669AbhKQWQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 17:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbhKQWQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 17:16:37 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539FDC061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 14:13:38 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id h24so3468541pjq.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 14:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XJzPff/I1wt0Bz0gGyXgys1xHsyQRTHzmNqo0bWyeQI=;
        b=AMUtcfuUU10pH4Yz18a/3pqkfityc7BKdtnAVSHR5IRTh3DUXYGzDHmZahgwMovAlp
         1RpaUVNkORCZxMSxnGQNIO1oYEV7bmRq31kSkfRw7u0DYgkzTzRuK7fTMGexhWJaSt8O
         T07nPAINupblyLyXxyiu+AiBBAggIoYVZlg7vV8ddLzIhYwHyx/akKZ7EugS6gZJCmLW
         dFLfN+ATtGjF7fmW2LYqG1K1LqF3HwO9YT3OqWsOq6f9OdsmtC6JQRr8sQ61oShYk/P9
         vvJ9zA39tBt1wLWo3A2hpIusLA74fOINnm9tcojpw50lmdx2t4lXBX5PlC9zrQIe+GOB
         PWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=XJzPff/I1wt0Bz0gGyXgys1xHsyQRTHzmNqo0bWyeQI=;
        b=VlUmm/TM7PRHaf1PBFJlVM6RPW11/zL8UQyCn8W3ulDM0GhNMwswCoPt8+1KFnr1QE
         +xHH4Q/X+omuqRE3qtmRNYcRGVLHWot4If6wMH0mrsisR7/nQcXKyNzVetuBDpERldfx
         Pd2ZcV94coSpMF+O7vnpdYYLvErI+kj5Jj1NMCGEnXR9fGSvsh5i9IP/KXd3W0wlhbZM
         3NgUjTNK4IQyJBxZPLKznzx0w4qI1iEbNeXiq3wUbVUK/WB+5IDT0NU+MBoAjne3npFy
         lUAYtzcmKfX36vQ3mr76RzOs+BlB7WzIJXkMlk8yJrOFx44AltSifTfZduQd28FHurOL
         2hTQ==
X-Gm-Message-State: AOAM530WuFvgoBqqMO369kvtIL8SU04aY+LjBWUidMkPEY+mWWmQPNYA
        +UUzlTna37WsZGczWbULoAA=
X-Google-Smtp-Source: ABdhPJywahKjrYQv17xG9oe+WLa2Il1Y70sEYpO25SkmqzkjGk1aXviCiEudDIegWM6px4hvdgJnxQ==
X-Received: by 2002:a17:90a:4a06:: with SMTP id e6mr4099468pjh.228.1637187217747;
        Wed, 17 Nov 2021 14:13:37 -0800 (PST)
Received: from google.com ([2620:15c:211:201:ac60:a5b:b800:3af7])
        by smtp.gmail.com with ESMTPSA id p3sm560013pfb.205.2021.11.17.14.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 14:13:37 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 17 Nov 2021 14:13:35 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] kernfs: release kernfs_mutex before the inode
 allocation
Message-ID: <YZV+j5LivK+9Dt50@google.com>
References: <20211116194317.1430399-1-minchan@kernel.org>
 <YZQLWq7WMSRF2xCM@kroah.com>
 <YZQkQcrldGFwqV/r@google.com>
 <YZSk3DECnnknOu5T@kroah.com>
 <YZSu/HiHDZxo9Wpa@google.com>
 <YZV4CtJnH+ngOcxi@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZV4CtJnH+ngOcxi@slm.duckdns.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

On Wed, Nov 17, 2021 at 11:45:46AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Tue, Nov 16, 2021 at 11:27:56PM -0800, Minchan Kim wrote:
> > A app launching involves dma_buf exports which creates kobject
> > and add it to the kernfs with down_write - kernfs_add_one.
> > 
> > At the same time in other CPU, a random process was accessing
> > sysfs and the kernfs_iop_lookup was already hoding the kernfs_rwsem
> > and ran under direct reclaim patch due to alloc_inode in
> > kerfs_get_inode.
> > 
> > Therefore, the app is stuck on the lock and lose frames so enduser
> > sees the jank.
> 
> So, one really low hanging fruit here would be using a separate rwsem per
> superblock. Nothing needs synchronization across different users of kernfs
> and the locking is shared just because nobody bothered to separate them out
> while generalizing it from sysfs.

That's really what I wanted but had a question whether we can access
superblock from the kernfs_node all the time since there are some
functions to access the kernfs_rwsem without ionde, sb context.

Is it doable to get the superblock from the kernfs_node all the time?
