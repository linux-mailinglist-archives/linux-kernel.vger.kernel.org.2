Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA72F34E54A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 12:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbhC3KUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 06:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhC3KUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 06:20:14 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CABC061574;
        Tue, 30 Mar 2021 03:20:14 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id i9so15294500qka.2;
        Tue, 30 Mar 2021 03:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=k7hxZENd7NdPTgDY/2orpsQOL2ON+8/T0SHT2+4p2oU=;
        b=qOyo8WUtNbyCQLTbQYFC4L6CFPxxsa2MI/ijfZ3jK+PazAZEPMINiCJvTTMtSQB4kH
         9GrMqYedes9YEB2hzsEUvOnq7go5SmVYhMb6zd/Zpco6JQXlA9HkKxwaIGW22Vf4i9h2
         S8/oGqkjsP3gB1m25RZx/JvuxRolQGoo07wpjMnuvdTpXgMVxwrzJ8gzGSAeHONqYDYN
         i3ZTs1SzSzyPAYSX/jzve/m8p/fJOXXWJMUl1v51EOeUDFvgXzTPE1ZkpIi+GeDfoKul
         DPQmlZ5uBAvbLYZtr8a/AqRrictKqMlSjED0eOHRIB6zjpDfPFLh5t0i5CpYQovQemdu
         LmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=k7hxZENd7NdPTgDY/2orpsQOL2ON+8/T0SHT2+4p2oU=;
        b=Y2tLQTEMHs7yejLaAGqBBRBBGq5ZqFMhvvpElb8pf5phoomCkSdBSvqATy7XeyRm8W
         vC6LkKLA/oNmXSCG2zuSUqJSmMJ5zDnyM1KEkmdtyXWkMgWq3LzzZ+Cg5v4Dfwglsy0W
         sv4QVXDWkBj7mNinkY5vC+7U2s5eRZFgqE7DDPnZ6hlyscEkApo0BgHSByuHagNxRvcb
         mhdj//tHSLdQrxMkGeWP4M3ON47DSgjRgdyN1fYkiGz/OUh19+C7828bVo/sCDG3RkE3
         1rI4J3vpUAzTJ3HDN1oGrUdpS1HFRdDQPz/UJoSjCxh9kRYM7zdmgfPIqJThm5Uzz48D
         ICAg==
X-Gm-Message-State: AOAM532503PQiC/OvS5OfT0zpmSHjF8yzfq6IVtnpb83qSiBnT/P+jPe
        UaW0Bnd00of6T7aAHor4EOQ=
X-Google-Smtp-Source: ABdhPJwJ6DQyZii4Hb/HRz8XLhQyf4qv6XeCIdgjJLTHxVNWGCWgHhoyFVBAEMWz7RUahJninMF7xA==
X-Received: by 2002:a05:620a:16d3:: with SMTP id a19mr29082409qkn.88.1617099613534;
        Tue, 30 Mar 2021 03:20:13 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id 66sm15283942qkk.18.2021.03.30.03.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 03:20:12 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     Greg KH <greg@kroah.com>, akpm@linux-foundation.org,
        SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, gthelen@google.com, guoju.fgj@alibaba-inc.com,
        mgorman@suse.de, minchan@kernel.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, riel@surriel.com,
        rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org,
        shakeelb@google.com, shuah@kernel.org, snu@amazon.de,
        vbabka@suse.cz, vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v26 07/13] mm/damon: Implement a debugfs-based user space interface
Date:   Tue, 30 Mar 2021 10:20:06 +0000
Message-Id: <20210330102006.34049-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210330095950.33427-1-sjpark@amazon.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

On Tue, 30 Mar 2021 09:59:50 +0000 SeongJae Park <sj38.park@gmail.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> On Tue, 30 Mar 2021 11:22:45 +0200 Greg KH <greg@kroah.com> wrote:
> 
> > On Tue, Mar 30, 2021 at 09:05:31AM +0000, sj38.park@gmail.com wrote:
> > > +static int __init __damon_dbgfs_init(void)
> > > +{
> > > +	struct dentry *dbgfs_root;
> > > +	const char * const file_names[] = {"monitor_on"};
> > > +	const struct file_operations *fops[] = {&monitor_on_fops};
> > > +	int i;
> > > +
> > > +	dbgfs_root = debugfs_create_dir("damon", NULL);
> > > +
> > > +	for (i = 0; i < ARRAY_SIZE(file_names); i++)
> > > +		debugfs_create_file(file_names[i], 0600, dbgfs_root, NULL,
> > > +				fops[i]);
> > > +	dbgfs_fill_ctx_dir(dbgfs_root, dbgfs_ctxs[0]);
> > > +
> > > +	dbgfs_dirs = kmalloc_array(1, sizeof(dbgfs_root), GFP_KERNEL);
> > 
> > No error checking for memory allocation failures?
> 
> Oops, I will add the check in the next spin.
> 
> > 
> > 
> > > +	dbgfs_dirs[0] = dbgfs_root;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +/*
> > > + * Functions for the initialization
> > > + */
> > > +
> > > +static int __init damon_dbgfs_init(void)
> > > +{
> > > +	int rc;
> > > +
> > > +	dbgfs_ctxs = kmalloc(sizeof(*dbgfs_ctxs), GFP_KERNEL);
> > 
> > No error checking?
> 
> Will add in the next spin.
> 
> > 
> > > +	dbgfs_ctxs[0] = dbgfs_new_ctx();
> > > +	if (!dbgfs_ctxs[0])
> > > +		return -ENOMEM;

And, I found that I'm not printing the error for this failure.  I guess this
might made you to to think below error message should printed inside the
callee.

I will add 'pr_err()' here and above unchecked failure case, in the next
version.

BTW, I forgot saying thank you for your review.  Appreciate!


Thanks,
SeongJae Park

> > > +	dbgfs_nr_ctxs = 1;
> > > +
> > > +	rc = __damon_dbgfs_init();
> > > +	if (rc)
> > > +		pr_err("%s: dbgfs init failed\n", __func__);
> > 
> > Shouldn't the error be printed out in the function that failed, not in
> > this one?
> 
> I thought some other functions (in future) might want to use
> '__damon_dbgfs_init()' but siletnly handles it's failure.  Therefore I made the
> function fails silently but returns the error code explicitly.  Am I missing
> somthing?
> 
> 
> Thanks,
> SeongJae Park
> 
> > 
> > thanks,
> > 
> > greg k-h
> 
