Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320C334E4FB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 12:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhC3KAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 06:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbhC3KAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 06:00:01 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0757C061574;
        Tue, 30 Mar 2021 03:00:01 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id q26so15257249qkm.6;
        Tue, 30 Mar 2021 03:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=xBOa27jqyjYu408xi8Nc36ha7jQgQUaKKty7Tja3iFI=;
        b=LO2FR5Jojz0dNXWOaasz+41gbLvtn2Q3zmXDHq225YydhroM0m2w/fLXk89OhVzse8
         a4XITI1mIdXz7LiJGzMqCeuFCl3lc5HCjUNk50kw/MMbgQQx3wUVmNyUS8Iykbrf9YTK
         rYVvBarFUo1ZHPrGcDGnU85hT/1dm//pIWhbGnRbqQjZGsDiNGnqsL7zzVLA9eIL/PL2
         o8rdV6NtSHIKD/SR3nK4Tf1Fte6JSnPlLhaGdwc1t0wd9mqOPgJQCoCL5mbOzM4m4lPB
         g7zkgWLKNIbBMQeh9kIhTb6dAMsM3Kzw/vu20fVTiQ1n/m4oDrLEA1J5jE67wUd+24Ts
         W5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=xBOa27jqyjYu408xi8Nc36ha7jQgQUaKKty7Tja3iFI=;
        b=TnWrC3+2anz710IcueD647vGsXVPuCAdpamfcE0zFdEaTtv8miLW3kaOsgTdF0b4w6
         s9npAqX6+hpnGn3CU9jwI48A6YJwIw4hW4nw2as5tdZfu6oNoHrUG3FrqBhjKwsqDbeU
         C+E1wAPeHMLS0U9DnR3Va0o7aAQk7TbyY9QeW45I0zYkyhJ9jDPymtjoahWhZ6lPxpAm
         cuYtWhOvC0MRh8C4eih4ujHtt1Qz26tdcg2df19xIIh6HlXUc445C+Czkl8edBoB9HRn
         QSohfabxjMeqreocxUqTKBg3fLLb48XfqGPnS9JDNchhXLUwRqEKq/t1iROGFyT1Dyp8
         Zg6w==
X-Gm-Message-State: AOAM532sWFsWWwd8oRHSPBhAZkZMlP71bvkXj6t8BU94K889rbVPA0yN
        wQPBqDqJhwCvrVoXljPHV9U=
X-Google-Smtp-Source: ABdhPJxUN+dwxVCJiXl92JJ6opVcoSwUqYWYnY5xpTg6gh0MztkoTi6b0yoTRvecHjd6uUCtL/XZXw==
X-Received: by 2002:a37:8c42:: with SMTP id o63mr29447351qkd.449.1617098400927;
        Tue, 30 Mar 2021 03:00:00 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id 18sm16043166qkr.90.2021.03.30.02.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 03:00:00 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     Greg KH <greg@kroah.com>
Cc:     sj38.park@gmail.com, akpm@linux-foundation.org,
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
Date:   Tue, 30 Mar 2021 09:59:50 +0000
Message-Id: <20210330095950.33427-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <YGLt5R1AlgGrPtv4@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

On Tue, 30 Mar 2021 11:22:45 +0200 Greg KH <greg@kroah.com> wrote:

> On Tue, Mar 30, 2021 at 09:05:31AM +0000, sj38.park@gmail.com wrote:
> > +static int __init __damon_dbgfs_init(void)
> > +{
> > +	struct dentry *dbgfs_root;
> > +	const char * const file_names[] = {"monitor_on"};
> > +	const struct file_operations *fops[] = {&monitor_on_fops};
> > +	int i;
> > +
> > +	dbgfs_root = debugfs_create_dir("damon", NULL);
> > +
> > +	for (i = 0; i < ARRAY_SIZE(file_names); i++)
> > +		debugfs_create_file(file_names[i], 0600, dbgfs_root, NULL,
> > +				fops[i]);
> > +	dbgfs_fill_ctx_dir(dbgfs_root, dbgfs_ctxs[0]);
> > +
> > +	dbgfs_dirs = kmalloc_array(1, sizeof(dbgfs_root), GFP_KERNEL);
> 
> No error checking for memory allocation failures?

Oops, I will add the check in the next spin.

> 
> 
> > +	dbgfs_dirs[0] = dbgfs_root;
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Functions for the initialization
> > + */
> > +
> > +static int __init damon_dbgfs_init(void)
> > +{
> > +	int rc;
> > +
> > +	dbgfs_ctxs = kmalloc(sizeof(*dbgfs_ctxs), GFP_KERNEL);
> 
> No error checking?

Will add in the next spin.

> 
> > +	dbgfs_ctxs[0] = dbgfs_new_ctx();
> > +	if (!dbgfs_ctxs[0])
> > +		return -ENOMEM;
> > +	dbgfs_nr_ctxs = 1;
> > +
> > +	rc = __damon_dbgfs_init();
> > +	if (rc)
> > +		pr_err("%s: dbgfs init failed\n", __func__);
> 
> Shouldn't the error be printed out in the function that failed, not in
> this one?

I thought some other functions (in future) might want to use
'__damon_dbgfs_init()' but siletnly handles it's failure.  Therefore I made the
function fails silently but returns the error code explicitly.  Am I missing
somthing?


Thanks,
SeongJae Park

> 
> thanks,
> 
> greg k-h
