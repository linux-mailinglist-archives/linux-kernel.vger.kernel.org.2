Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09325455060
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 23:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241149AbhKQW1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 17:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235955AbhKQW06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 17:26:58 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E32C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 14:23:59 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 136so3550016pgc.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 14:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6kd6WqCCmeR9MuK0TQwMByDorfN1e8bV41MA9R0/MZU=;
        b=AZxPaoj298KXds9snPihwfvUBGF8/mUwvRoR9MG89whM5rHyPDDabNf+uveS1xQhh/
         vVA2+lp3CCv/f8IC62Kv2jxZnnb71c24gllDboNpUJWe795A+3jxmYKp8az3lsHBWOgk
         xcGRbvWVe45CUIL9OEDaTp9RzvaroliditIxzCNNploCvCMNoHFPEZzXrecd8aC14r/l
         2RDIaBpyyGRb+GbUJhX79OYwpvXulFnchtGtaUmKCeEi5YZUqN66ys7Pa/Yfwf3PXybe
         GYLYbiS3xIW6C/zogm4y6YIjCOrGyrRaZxtd+IOU2XajkdSS08LShVNw+YnTku03J+A5
         qXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=6kd6WqCCmeR9MuK0TQwMByDorfN1e8bV41MA9R0/MZU=;
        b=2P/VYL3wl3T1SuT4x6IQ5aIFeMDJpl+U8tYdupodCCSEIGFoA1H1ce7F4KUW+GG0e6
         0kbFQX3tjWipfWTv3YCeZYWWppN3tZmfuYjVPXRNQmMEgIBmuUJ6NzVUgi1HaAPWIvDZ
         dMOnbPceK95WjJecvTEa2Mwnyf1NNFTlednjq8tkXkPhcc+XSQH6/K3HZg3Zx32HUR8N
         xEjmfpWzevTEDDcjfn8azgXIZexhxPpW9d/PpSGRDBS6tYg4lbHnG+52fT2OxgpcuhFo
         8A/xtJPNgMkkjuPwgWdRKxGKWpQWhNCJb0DbikVKKcCurhO9uDBRTGLDZCBjU92G7n9I
         IH9A==
X-Gm-Message-State: AOAM533O9IbUSNgUjFhyXpQf40u9bhxxwEjvoFHFkcaNGTOEDD2kUJot
        8mVARvm47fM67bGZxg0WX0k=
X-Google-Smtp-Source: ABdhPJzqWMt/RppXNxopIecR7BPpR3g8UofY3tK2jnmmb+FA0qE31cADzS1/eKfbukRvpbitH9QD6A==
X-Received: by 2002:a63:5f02:: with SMTP id t2mr7801545pgb.452.1637187838561;
        Wed, 17 Nov 2021 14:23:58 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id h196sm599203pfe.216.2021.11.17.14.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 14:23:58 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 17 Nov 2021 12:23:55 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] kernfs: release kernfs_mutex before the inode
 allocation
Message-ID: <YZWA+8B1xQOKCMnS@slm.duckdns.org>
References: <20211116194317.1430399-1-minchan@kernel.org>
 <YZQLWq7WMSRF2xCM@kroah.com>
 <YZQkQcrldGFwqV/r@google.com>
 <YZSk3DECnnknOu5T@kroah.com>
 <YZSu/HiHDZxo9Wpa@google.com>
 <YZV4CtJnH+ngOcxi@slm.duckdns.org>
 <YZV+j5LivK+9Dt50@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZV+j5LivK+9Dt50@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Nov 17, 2021 at 02:13:35PM -0800, Minchan Kim wrote:
> > So, one really low hanging fruit here would be using a separate rwsem per
> > superblock. Nothing needs synchronization across different users of kernfs
> > and the locking is shared just because nobody bothered to separate them out
> > while generalizing it from sysfs.
> 
> That's really what I wanted but had a question whether we can access
> superblock from the kernfs_node all the time since there are some
> functions to access the kernfs_rwsem without ionde, sb context.
> 
> Is it doable to get the superblock from the kernfs_node all the time?

Ah, right, kernfs_node doesn't point back to kernfs_root. I guess it can go
one of three ways:

a. Follow parent until root kernfs_node and make that guy point to
   kernfs_root through its parent field. This isn't great but the hotter
   paths all have sb / inode already, I think, so if we do this only in the
   really cold paths, it likely isn't too bad.

b. Change the interface so that the callers have to provide kernfs_root. I
   don't think this is gonna be a huge problem. There are a few users of
   kernfs and they always know their roots.

c. Add a field to kernfs_node so that we can always find kernfs_root.

I think b is likely the cheapest && cleanest.

Thanks.

-- 
tejun
