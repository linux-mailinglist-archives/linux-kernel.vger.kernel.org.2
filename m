Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C43E34E3FF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 11:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbhC3JHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 05:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbhC3JGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 05:06:25 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D156C061762;
        Tue, 30 Mar 2021 02:06:25 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id o5so15192671qkb.0;
        Tue, 30 Mar 2021 02:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6wiVlxzeweqXdqRMER67DzvvD70TmXk/QJZVXPDOtIU=;
        b=k2D6G01xEW4ny0no24nQaYzKd1viaSs+lHjer+Gw5HIysiMu1h4UKH6tGvR5HfN5y6
         xjfHAVrJ+qi02goJD+BI7ns0LjzuNoJu922L4uoSOvq3UC+U4TR6mJj/yYZuTG4RmsFV
         GQdSMcQR2cGW9RpdRE7Km4ZdUkITc07p6Oom5tRzDzvEhL8Cmf3wMFEsLo5II0vREn6A
         /PQSHts+tdVaq9zF0j/4TULK1quLfPWtJutbs75hO6Yv/9rgb5hMuT9fXroJkMLHNsa9
         HkZwpJ0gQaMub8UZzqYyyVHphX9f5Xm8co7QIz8LfAoeCYeub8X+pKpGpTtOCfJcDc0v
         BWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6wiVlxzeweqXdqRMER67DzvvD70TmXk/QJZVXPDOtIU=;
        b=A9d1Cj5KxXoe0f486ccqv12iHeqW55vdO7PVT2NMtnbbnJJ/UoPo+bl91jhGBGN5AZ
         0nXT2ESZh7HC4y3vSL+iys6hSCPKyxS24A58oYtlnIrfF0jLroCzuRJYFhINGDxraqgQ
         B/seArV1wi2ueZqPkuWUM0uGtfdo9dEOzqPDezZlAygHdoy9iSXv0aTNSbgL656zipV5
         kHc+fye5bfdM53xo5/Rv7sEtknCS1IE3r9zYfNs9dU3yr+H4UrvHRnSRH3xHqIlReCcO
         bGGJ216+mGH6DCL0pPYxUZpAAXaCpAXvl+X5QIWEKwLFJiAukIJ5ruLNlUIsE9NRRrc8
         cQ7g==
X-Gm-Message-State: AOAM533ieIxuKwFftpPNWm1ywhd4UfOJlrEri1XYFPLmRI2uKIZbFhv4
        V7kXajihaOdRAfzVE2n0sUk=
X-Google-Smtp-Source: ABdhPJyXVpkFzaJ/XiYYUVs/8MGi3ob/QTKPgtKMaQ5upHqc9i1GBrnVPgUL5PqbVfLWp0hLznWb9w==
X-Received: by 2002:a05:620a:146a:: with SMTP id j10mr29378255qkl.345.1617095184418;
        Tue, 30 Mar 2021 02:06:24 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id 8sm14630011qkc.32.2021.03.30.02.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 02:06:24 -0700 (PDT)
From:   sj38.park@gmail.com
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, mgorman@suse.de, minchan@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        riel@surriel.com, rientjes@google.com, rostedt@goodmis.org,
        rppt@kernel.org, shakeelb@google.com, shuah@kernel.org,
        sj38.park@gmail.com, snu@amazon.de, vbabka@suse.cz,
        vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v26 13/13] MAINTAINERS: Update for DAMON
Date:   Tue, 30 Mar 2021 09:05:37 +0000
Message-Id: <20210330090537.12143-14-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210330090537.12143-1-sj38.park@gmail.com>
References: <20210330090537.12143-1-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit updates MAINTAINERS file for DAMON related files.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 59c515f0ab10..978cd8088bdc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4972,6 +4972,18 @@ F:	net/ax25/ax25_out.c
 F:	net/ax25/ax25_timer.c
 F:	net/ax25/sysctl_net_ax25.c
 
+DATA ACCESS MONITOR
+M:	SeongJae Park <sjpark@amazon.de>
+L:	linux-mm@kvack.org
+S:	Maintained
+F:	Documentation/admin-guide/mm/damon/*
+F:	Documentation/vm/damon/*
+F:	include/linux/damon.h
+F:	include/trace/events/damon.h
+F:	mm/damon/*
+F:	tools/damon/*
+F:	tools/testing/selftests/damon/*
+
 DAVICOM FAST ETHERNET (DMFE) NETWORK DRIVER
 L:	netdev@vger.kernel.org
 S:	Orphan
-- 
2.17.1

