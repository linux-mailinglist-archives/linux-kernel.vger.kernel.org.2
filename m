Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C37389F4F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 09:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhETH66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 03:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbhETH6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 03:58:36 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B86C06138B;
        Thu, 20 May 2021 00:57:12 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id q10so15300074qkc.5;
        Thu, 20 May 2021 00:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HqCRLHZPebCKJ+eV3cYONSq5nOItE3CxF9a/qB8bJmo=;
        b=BNOTZEtgEfVspx4CmWaJkVA8C3cPBUcLtMblROTklmk9OIM6gXbh3agajl4uEj8lmq
         1mHJo/yKf28lBO1/JpXY5/rwtL6e1q2B/BXrNKqDH5J6nrxMYSsqD3G+Yy1h/suxmHxu
         IWFYFe181dgjGtr/2OqskvVieaeZA7rn7OYlvjt0WVvaJwIG/MROCc5A7zODMKPuaHJF
         LUegtCUaha9wvL+syh0iIwGN5U6GgkiIybX4qPMkP/jPzoUK3GbTiQe9yYpK3xnB21X2
         uh8AwATFlILVWdiqqBYv5nUf0UNjsGDIOEKFUc+QLUgTIqziiYCJ0t7RycIC1R1+Wud7
         mbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HqCRLHZPebCKJ+eV3cYONSq5nOItE3CxF9a/qB8bJmo=;
        b=lPgw0pr//coui1qwPCygSJD9gCvmT1QUoF5qPH6zASISGMw31carptvoIiVlvg7vVI
         7AQU7bnfxY2Kjdfk/C8YkZgt1HsZ+y5MPBeANQATcuShMwJlYcyB8d5+ApEgHdoKKiNY
         Q1IjriV6koSouEnDHG6SQawyNNCwHoKttwY1TVajc3hUMvxyygslkDrPLYUnHH3XjUf1
         ph8qDhRAev5skFLW0nB+fzHyIyXakF7sZ/M6Kx0UJuvNokKuLMffqRv7IhmOiMKFK5mL
         VNtnyII5bKf+rYfz0B4iKLLaTrpN9WEHqNwohN0b2149p8htgZcIMGBQQN4MPjs/QeKM
         ZarQ==
X-Gm-Message-State: AOAM5336+kWyLCtQiyqzGuuIFzXk9oBi7JsOYlWpMxWBBSQxzJNxvZNe
        gxyyvSl4joWteBs22bVHDBc=
X-Google-Smtp-Source: ABdhPJx2AvHchFYCHw1n1NpGRJOt4GXKkZfVBF9Awri0GCZ8bPFW1HozNPlRP9GHH2hs+sQ1XoC6SA==
X-Received: by 2002:a05:620a:12a4:: with SMTP id x4mr3448782qki.487.1621497432051;
        Thu, 20 May 2021 00:57:12 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id g9sm1478254qka.38.2021.05.20.00.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 00:57:11 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
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
Subject: [PATCH v29 13/13] MAINTAINERS: Update for DAMON
Date:   Thu, 20 May 2021 07:56:29 +0000
Message-Id: <20210520075629.4332-14-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210520075629.4332-1-sj38.park@gmail.com>
References: <20210520075629.4332-1-sj38.park@gmail.com>
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
index ba0cc0a67b32..a2794f5f0360 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5040,6 +5040,18 @@ F:	net/ax25/ax25_out.c
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

