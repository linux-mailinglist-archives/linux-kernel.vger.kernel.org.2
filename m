Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228433E2A01
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 13:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243124AbhHFLrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 07:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhHFLrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 07:47:12 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEE8C061798;
        Fri,  6 Aug 2021 04:46:56 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id az7so9524716qkb.5;
        Fri, 06 Aug 2021 04:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=oSvZYEgjXBUMJARLAA5mj7rMeTJsVZ2KzcbDddf9ezY=;
        b=UCbklgrJ+k4AWoX+japorczk2FDz+rS2h0a3jJlau/lPRybBeOw9hnEXtgpS7bdZAK
         S+/TqlBaDqv5fBKIPBgcjYYa6ZF1G1MENJwjn6Pb6tsf2PcLvO6qdbO1RBZKHsxq8DaL
         wgwGqOvj62DiOTuB9yU/6kaf1jrNQk+mbFLK8PsIGySuK+yxEozcQwPXcTQqc65Jb11i
         eudE/mqge2dkwPfN81nNu3Pvh7TkaDBrfZJVyoiNUSXGqdrTtr+554YyunLDPqzwPfso
         rmqQRf7kKMQWFmyRxrNRZ8ueMznxabgzy2U2p1Z6StoPXYhYXvs+q3KA4r0h1QnW95Hk
         FuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=oSvZYEgjXBUMJARLAA5mj7rMeTJsVZ2KzcbDddf9ezY=;
        b=N7ji7JRmgT2lYcoRmtcl9Ehk4+uR+vBA50oU0ziMjo4dl7Ob76wgqIxF08I5TKA5Ye
         TDj00+61hm4RvfNQrjWtxyoEac2edqQDSb9Hy7lfnqEjcJsSBeyWsGv3qIXI6kwHgNFd
         unRiSNYS8Xk+AJlGy0jrbUKeUoCuvja77Dq9V5gpgEfs2xbOAp5BQnjaBjSBgWoS0bPF
         f+MZyuobPzW/3He5TeHC/6x5crU7W9VQvK3I+Tw9hqaV3Y6YLqKOW+nFtQKzB83taJuc
         ZwQ/q5GPxgJpePjL9CnPTmwxta0P3ETPuzyYm6XUpnBe5fGE+EfbijZ6PYcqjbIYqW/d
         02ow==
X-Gm-Message-State: AOAM530Vp73awKeo660aZtG9bEQz8aNbKMdG8LNC3TVVcZjz0dbWPtMm
        QAopYCurpE0aBy+yzyDQvRc=
X-Google-Smtp-Source: ABdhPJwhd9iXX/w9VyHcvCZIRZDSbhFQfgCpgHgBvMWIdmtf+9m4b9T+7vm2iA683MCT8CkSxcFpmA==
X-Received: by 2002:a05:620a:59:: with SMTP id t25mr9325387qkt.194.1628250415679;
        Fri, 06 Aug 2021 04:46:55 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id w185sm4618092qkd.30.2021.08.06.04.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 04:46:55 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj38.park@gmail.com>,
        SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, jgowans@amazon.com, joe@perches.com,
        mgorman@suse.de, mheyne@amazon.de, minchan@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        riel@surriel.com, rientjes@google.com, rostedt@goodmis.org,
        rppt@kernel.org, shakeelb@google.com, shuah@kernel.org,
        sieberf@amazon.com, snu@zelle79.org, vbabka@suse.cz,
        vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v34 07/13] mm/damon: Implement a debugfs-based user space interface
Date:   Fri,  6 Aug 2021 11:46:44 +0000
Message-Id: <20210806114645.6777-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210805174304.3c3d8c8ee971bc9ddf6988af@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

On Thu, 5 Aug 2021 17:43:04 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Fri, 16 Jul 2021 08:14:43 +0000 SeongJae Park <sj38.park@gmail.com> wrote:
> 
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > DAMON is designed to be used by kernel space code such as the memory
> > management subsystems, and therefore it provides only kernel space API.
> > That said, letting the user space control DAMON could provide some
> > benefits to them.  For example, it will allow user space to analyze
> > their specific workloads and make their own special optimizations.
> > 
> > For such cases, this commit implements a simple DAMON application kernel
> > module, namely 'damon-dbgfs', which merely wraps the DAMON api and
> > exports those to the user space via the debugfs.
> > 
> > ...
> >
> > +static int __init damon_dbgfs_init(void)
> > +{
> > +	int rc;
> > +
> > +	dbgfs_ctxs = kmalloc(sizeof(*dbgfs_ctxs), GFP_KERNEL);
> > +	if (!dbgfs_ctxs) {
> > +		pr_err("%s: dbgfs ctxs alloc failed\n", __func__);
> > +		return -ENOMEM;
> > +	}
> > +	dbgfs_ctxs[0] = dbgfs_new_ctx();
> > +	if (!dbgfs_ctxs[0]) {
> > +		kfree(dbgfs_ctxs);
> > +		pr_err("%s: dbgfs ctx alloc failed\n", __func__);
> > +		return -ENOMEM;
> > +	}
> 
> checkpatch points out that the "alloc failed" messages are unneeded -
> kmalloc(GFP_KERNEL) will have already emitted a stack trace.  Is this
> fixup OK?

Yes, of course.  I also see you already kindly applied this in the -mm tree[1],
appreciate!

[1] https://www.ozlabs.org/~akpm/mmotm/broken-out/mm-damon-implement-a-debugfs-based-user-space-interface-fix.patch


Thanks,
SeongJae Park

[...]
