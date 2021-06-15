Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8593A88E4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 20:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhFOSxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 14:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbhFOSxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 14:53:31 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD10C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 11:51:26 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 3-20020a05600c0243b029019f2f9b2b8aso204508wmj.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 11:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uwIcPiwJdf3jh813ElBB+grh5aH2j38/LFNqkrYcIlU=;
        b=SNM+6i9dSydccRVYue2Eyioctg9Arn8GAmZtmj7X4nOpxWlP1Be22Kc9kdAuBA8FKV
         a+8qa8gUG+FijhNizuPt6TMZuefrvkpv0SjwA8XM+Oo5dugNFE1MzsvryIpeS5TPdBJr
         2EatG4YlZW6Voqw4G8V4h7R5I8RZ5bGrQC+FD9eRDSgBUBROo8ES6E2dZBVBeF+wsK5j
         0VaoetlhOTz7qgKk55Le44cxbEPo9k221U7/9On09HY/grPIOWC39tBDI0GCJLso0E3r
         +quGQw8b1LSRYZ+nGQU2syJf9Mb182jAdn5eFRHNcH+W24h2pPUgSPDScYnU9umkIHFE
         8Liw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uwIcPiwJdf3jh813ElBB+grh5aH2j38/LFNqkrYcIlU=;
        b=uQ7d5d/SUtMBld8a1xvgAQhG+1W9ypmZMaPEg68/3zE6CppBG3mrRcABxPzlzFFnWP
         VtKyStGTUBuHqknhdd75Gxj9wLTXhlkWWPjHAfRYZHYahxL1J1ACJ3rgkbE04q29yQDh
         +yx9fCNgzVHIyX+uUIX173nJ6RvGxsJ8Ajlg+bWTFBqKyaJSLnpTGgkDlhRBYJwnhY8J
         6p+fBsTU/vgKdzTv1oY/srLRNWmFumnzAeqqgsDp0Xw7V8snedWtTcNFkzlamdN2i7MJ
         YHtxQb30w/LXIGoUktPshVdX/Z8NEgylskFsYa/5SdE+oKWGFQeHlqTj7xso6jk9SCRB
         V6vA==
X-Gm-Message-State: AOAM5320+0ikL7lx4lD0qsUetAkeJ2TumGGWP0RdHTC3pK93iDJxOMTz
        yotvX1NmWp5NoQpJdUoqEIFCug==
X-Google-Smtp-Source: ABdhPJwU9DENtfQ4wuryNf4W2aw/IXAhNb/BXtgIIcVGtewfEuj9HVGn8YOQKgMmF7i8j9lSUiwt1w==
X-Received: by 2002:a7b:c10b:: with SMTP id w11mr6922360wmi.186.1623783084817;
        Tue, 15 Jun 2021 11:51:24 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:87fa:cbf4:21a6:1e70])
        by smtp.gmail.com with ESMTPSA id j5sm11544847wro.73.2021.06.15.11.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 11:51:24 -0700 (PDT)
Date:   Tue, 15 Jun 2021 20:51:18 +0200
From:   Marco Elver <elver@google.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, boqun.feng@gmail.com,
        will@kernel.org, glider@google.com, dvyukov@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] kcsan: Introduce CONFIG_KCSAN_PERMISSIVE
Message-ID: <YMj2pj9Pbsta15pc@elver.google.com>
References: <20210607125653.1388091-1-elver@google.com>
 <20210609123810.GA37375@C02TD0UTHF1T.local>
 <20210615181946.GA2727668@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615181946.GA2727668@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 11:19AM -0700, Paul E. McKenney wrote:
[...]
> Queued and pushed for v5.15, thank you both!
> 
> I also queued the following patch making use of CONFIG_KCSAN_STRICT, and I
> figured that I should run it past you guys to make check my understanding.
> 
> Thoughts?

You still need CONFIG_KCSAN_INTERRUPT_WATCHER=y, but otherwise looks
good.

I thought I'd leave that out for now, but now thinking about it, we
might as well imply interruptible watchers. If you agree, feel free to
queue the below patch ahead of yours.

Thanks,
-- Marco

------ >8 ------

From: Marco Elver <elver@google.com>
Date: Tue, 15 Jun 2021 20:39:38 +0200
Subject: [PATCH] kcsan: Make strict mode imply interruptible watchers

If CONFIG_KCSAN_STRICT=y, select CONFIG_KCSAN_INTERRUPT_WATCHER as well.

With interruptible watchers, we'll also report same-CPU data races; if
we requested strict mode, we might as well show these, too.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
---
 lib/Kconfig.kcsan | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 26f03c754d39..e0a93ffdef30 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -150,7 +150,8 @@ config KCSAN_SKIP_WATCH_RANDOMIZE
 	  KCSAN_WATCH_SKIP.
 
 config KCSAN_INTERRUPT_WATCHER
-	bool "Interruptible watchers"
+	bool "Interruptible watchers" if !KCSAN_STRICT
+	default KCSAN_STRICT
 	help
 	  If enabled, a task that set up a watchpoint may be interrupted while
 	  delayed. This option will allow KCSAN to detect races between
-- 
2.32.0.272.g935e593368-goog

