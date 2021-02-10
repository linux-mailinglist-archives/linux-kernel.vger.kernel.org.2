Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5573C315D60
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbhBJCff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234576AbhBJCZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 21:25:56 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA26BC061574
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 18:25:15 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id o21so221177pgn.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 18:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aYPzTdpjRS8vD0e96Ew/wnajAF4aUOa1BPxj9XOTxOE=;
        b=jgcC1B/TD1aJhAFIPQ33pZxGNW+plKxt6KZkm3z/8ec2lfug46UiVsUaljSjEtqb1R
         45ZEq3v9lXTjxenbzMYygr24BjzM/ibUpUGdadqcTDbjOc/+lGYQKgU1p4GGEFzcMs+B
         ABod6QWQaXlJEw4ezPam5bTlo+OcKAiJqRT1cCpI8wNA3zJ07JzIJzV8lNU3gEy4S6Bm
         Bebsgl8Y9Lhc8BfzZSudfBSs2LfyInDbp+96QD7eHwaJQ7K1jd3zqJYj+Gt6QbuRFYoB
         fd5HU3lrh4NEnFJPfqH4SLXP+RdlIYpHwTj3CEqYrHWM7TpkaTa9jirLBePQdUvipCMO
         6xAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aYPzTdpjRS8vD0e96Ew/wnajAF4aUOa1BPxj9XOTxOE=;
        b=tPTK0q3goF5+PCN0eAXeWXhYhi3IvtnQqerhOyF24yoHx1yYZHQK664AqSelyTFUVt
         yT8fa0HZFIJfg4Hk7x+NlXL/O9ahsfjEx1XuVTgBMAFBVTcqoc4Wl26xKw6u2jR9IogN
         oSYgvSVNkM/4cVAIu5ML3j461k/1uNm43a1nzYqesiq/A55w2i6I299QvymKZz2UR45i
         8ahtS0lG+41/+ldajJ4HsEx9F2fo8tC3E7E/1F2tT+SmG8dhZiWFGKKZVl7eX4iysP3b
         AYMmIY2sb6j+ZVehxrF8Z1BYUzsH3OQw8pm2OA+EGXaUSimUnx6jZ6pzr4eMuXbh5SSb
         d0GQ==
X-Gm-Message-State: AOAM531Sf7FTJCeLaeHKYSSpn5ujCHjBS2wyMpCJ1bWlMOqrviiPRU8R
        RiB3+QTFQ1w2mCKbW6oBWgU=
X-Google-Smtp-Source: ABdhPJziU+ADH3ORG9loRZtgY8mkk0e32j6fc3j0QDRJyMTBz9q30uIITtvTB5N8DUVYYIDdSc6rFA==
X-Received: by 2002:a63:e210:: with SMTP id q16mr906933pgh.249.1612923915374;
        Tue, 09 Feb 2021 18:25:15 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id q12sm229705pfc.95.2021.02.09.18.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 18:25:14 -0800 (PST)
Date:   Wed, 10 Feb 2021 11:25:12 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        john.ogness@linutronix.de,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v2] printk: fix deadlock when kernel panic
Message-ID: <YCNECIizrMwtjAW2@jagdpanzerIV.localdomain>
References: <20210206054124.6743-1-songmuchun@bytedance.com>
 <YCDcAy39BbPItdGY@jagdpanzerIV.localdomain>
 <CAMZfGtVBVSuH=HGNs7KFOtixSviy_stoZsiG4au0RUkUnH-0rQ@mail.gmail.com>
 <YCE4tIrz/u/RkDc/@jagdpanzerIV.localdomain>
 <CAMZfGtX-bHXoF_4rU+WzDNp+LmZj3CHWmurEvjCZBCyM2uiDMw@mail.gmail.com>
 <YCJKRnBXjTNWRBZ7@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCJKRnBXjTNWRBZ7@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/02/09 09:39), Petr Mladek wrote:
> > > So then this never re-inits the safe_read_lock?
> 
> Yes, but it will also not cause the deadlock.

Right.

> I prefer this approach. It is straightforward because it handles
> read_lock the same way as logbuf_lock.

I'm fine with that approach, but this needs to be in the commit message.
Something like "lose printk_safe message when we think we will deadlock
on printk_safe flush".

	-ss
