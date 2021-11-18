Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8828745526C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 02:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242396AbhKRB6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 20:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbhKRB6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 20:58:35 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F50C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 17:55:36 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id iq11so3829780pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 17:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vd/oJdSLv2nLMzuhB/Noxo3ol/XC/Vn5+tNwcBvMn70=;
        b=FMMoCUU9jmO31V8CNgBWLoynogY1H2jIdIBcShTk3M6abbyXlvrIR2YmhkzvtDHHp2
         Hexccufe9i4/ko3tnld8dNnUxNWWVpXh8EvhqT7VPtZ0ZGarcNXaXTquAcW4rSzKiYQp
         NkenKGWGDih4or2MOjrIQNDiermZ7WKXmyRb85Z+/v18BuguGOF7VxpklKkBKWd8oHeQ
         r1Dd1v6zIXPzh86Vpg1mJ79rLdVdH5gaDCejBl/hSPQT++xw3f+1YxwYjkd8tPmKQtUz
         LJpJ+R6/AzCvtCNIr1nacLxADtekUCGM9C1OtiJqS9aWo1JP5cYz5z+cpGxnUXQo1HEw
         cVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Vd/oJdSLv2nLMzuhB/Noxo3ol/XC/Vn5+tNwcBvMn70=;
        b=ez7ORVf+rhtdaElXn8asezk9PHR0tGan/sXz1KCcBiAUTPbGhemZyCwVnyaQoSotLp
         UIiU0u9DH0hmPPPeVv3HoLLIUvhK9yjnhbJKmmF+ra2kIMX35H/U5Jo9zYuavpiQYMi5
         z9JhYJYy0sRFpRJjQrFbPClTmJmSFN9eu6yIrzeLBWH9R4M5QlPPjvZ/7rdJS1H9FaC9
         ZP+QSHXtyTRV+rWzCOj/aQXaJe6FMfE6wzIexZWiQUY0FgfS2njcU3vUL7aJ+Kt4ClS/
         TM4qGWhwJJEJi/mxkDIFprsSZaw8BU/Zw6Ag5VchHzeApC7ILUC5ttrIKl4+cdrpf4lQ
         GaDA==
X-Gm-Message-State: AOAM530+MC6JVxHW/l5cTJ5yqM7XSqGWg9z0CfN0oFedjNKY9puJbUIL
        2q7rks207i/QW7Uv4AVb2fE=
X-Google-Smtp-Source: ABdhPJwwDFM0N41hSl4M67auuXqvUJxB8cjjkgRKoWRgKHcK96+2z8IhxpdMApLUhKZRMJFqgD+E+w==
X-Received: by 2002:a17:90b:1650:: with SMTP id il16mr5708237pjb.83.1637200535399;
        Wed, 17 Nov 2021 17:55:35 -0800 (PST)
Received: from google.com ([2620:15c:211:201:ac60:a5b:b800:3af7])
        by smtp.gmail.com with ESMTPSA id p128sm878652pfg.125.2021.11.17.17.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 17:55:34 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 17 Nov 2021 17:55:33 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] kernfs: release kernfs_mutex before the inode
 allocation
Message-ID: <YZWylT2SuN+N2Z2K@google.com>
References: <20211116194317.1430399-1-minchan@kernel.org>
 <YZQLWq7WMSRF2xCM@kroah.com>
 <YZQkQcrldGFwqV/r@google.com>
 <YZSk3DECnnknOu5T@kroah.com>
 <YZSu/HiHDZxo9Wpa@google.com>
 <YZV4CtJnH+ngOcxi@slm.duckdns.org>
 <YZV+j5LivK+9Dt50@google.com>
 <YZWA+8B1xQOKCMnS@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZWA+8B1xQOKCMnS@slm.duckdns.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 12:23:55PM -1000, Tejun Heo wrote:
> Hello,
> 
> On Wed, Nov 17, 2021 at 02:13:35PM -0800, Minchan Kim wrote:
> > > So, one really low hanging fruit here would be using a separate rwsem per
> > > superblock. Nothing needs synchronization across different users of kernfs
> > > and the locking is shared just because nobody bothered to separate them out
> > > while generalizing it from sysfs.
> > 
> > That's really what I wanted but had a question whether we can access
> > superblock from the kernfs_node all the time since there are some
> > functions to access the kernfs_rwsem without ionde, sb context.
> > 
> > Is it doable to get the superblock from the kernfs_node all the time?
> 
> Ah, right, kernfs_node doesn't point back to kernfs_root. I guess it can go
> one of three ways:

Thanks for the suggestion, Tejun.

I found kernfs_root and it seems like to return kernfs_root from kernfs_node.
If it's true all the case, we would put the rwsem in kernfs_root and change
would be straightforward. Do you see any problem?

> 
> a. Follow parent until root kernfs_node and make that guy point to
>    kernfs_root through its parent field. This isn't great but the hotter
>    paths all have sb / inode already, I think, so if we do this only in the
>    really cold paths, it likely isn't too bad.
> 
> b. Change the interface so that the callers have to provide kernfs_root. I
>    don't think this is gonna be a huge problem. There are a few users of
>    kernfs and they always know their roots.
> 
> c. Add a field to kernfs_node so that we can always find kernfs_root.
> 
> I think b is likely the cheapest && cleanest.
> 
> Thanks.
> 
> -- 
> tejun
