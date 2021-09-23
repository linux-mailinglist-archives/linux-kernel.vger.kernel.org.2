Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B03415985
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 09:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239896AbhIWHsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 03:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239773AbhIWHsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 03:48:16 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01365C061757
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 00:46:45 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id o7-20020ac86d07000000b002a69537d614so15263638qtt.21
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 00:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Hs5Rj+NJx7+HtIpxHcg+oHBvbk954rcb4LXyidx6Rwg=;
        b=s+JliFIJVOrnwMlQ9siG3F9Wi2QguFdhEczvYRLZv5jCJSUyt7HxXQwnujlvFbvvmt
         FTiXdoOIfIbe/KHSbHBOJV4MZoD+bfsVPxy5aPS1kr2S7CaPfNHUKpdepzCAf7ODEIib
         O9Aoqe1+3HDDV2bynzFEMZRynKlNYAkLoZHIctdFSTFRbMkY4UxIfHlIgJ3/s/YnNtmf
         SFPRCVJ/J8bKlGe9ZD0PJaDfcNYNsnEf+zAHKAuVQw6gQ1QyxkbyK1gFBc7WicnTzDeh
         +w6LQeCaA3lra2WUif7DWIg2abTK9nM5KlDrnXadASvSPt3uGAkCt66gb6IFRcwMkEc7
         qoug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Hs5Rj+NJx7+HtIpxHcg+oHBvbk954rcb4LXyidx6Rwg=;
        b=BRb+8nQ6cXR7GmM5jX4BnZ3E7KcWgjyHXJ9I3Y3K3nxmFUhccMcZLfnXg7OLX3ncq9
         IPDyjhri2VhckfBO45ar+i+HowqmHKMIQVniCCmgeQTwGiIiLHY9LTHBEqpA6yhGAfDz
         TxjeGbLptz+mwSlb9Pf58kXPK6zXW7yUcznaKqcQi6kA8isqOM0eAzOmYYwqeUcAh3yb
         d4c+2qpQBe2Dri7mbc3qRb+B1bFggcezPRMyiiYq1J8P+MGWC7Xhp6qBI+mPb2IpZvCE
         IOYiorsMx/b6rXcQyTo0uHvTHstwzBlZQkDyTrDsC7hvPm8sFv3LTJheVB0YRQYkWmua
         7BIQ==
X-Gm-Message-State: AOAM531Vi1hGr64FB3+QuhGkckdjiX9guiQjMO8XupS50MZNajvWp6iB
        QsClkwnYOAfazl9kftCE0XK3jzJ2ZwMO
X-Google-Smtp-Source: ABdhPJx3s4c0RgpCmKkzxC7B+/vnn5DD2zrreDc1rFHinSChs2v9vVq/r+H09Lfd+zDVsj0RlwobFWxAhmWq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:d3ff:e8f7:11f4:c738])
 (user=irogers job=sendgmr) by 2002:a05:6214:4c9:: with SMTP id
 ck9mr3145524qvb.52.1632383204146; Thu, 23 Sep 2021 00:46:44 -0700 (PDT)
Date:   Thu, 23 Sep 2021 00:46:07 -0700
In-Reply-To: <20210923074616.674826-1-irogers@google.com>
Message-Id: <20210923074616.674826-5-irogers@google.com>
Mime-Version: 1.0
References: <20210923074616.674826-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v9 04/13] perf expr: Separate token declataion from type
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Paul Clarke <pc@us.ibm.com>, kajoljain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change, so the type of expr remains <num>. A later patch
will change the computation to be an aggregate type and making this
change makes that later change smaller.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.y | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index e6005450feae..68b122e59b3f 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -20,11 +20,7 @@
 	char	*str;
 }
 
-%token EXPR_PARSE EXPR_OTHER EXPR_ERROR
-%token <num> NUMBER
-%token <str> ID
-%destructor { free ($$); } <str>
-%token MIN MAX IF ELSE SMT_ON D_RATIO
+%token ID NUMBER MIN MAX IF ELSE SMT_ON D_RATIO EXPR_ERROR EXPR_PARSE EXPR_OTHER
 %left MIN MAX IF
 %left '|'
 %left '^'
@@ -33,6 +29,9 @@
 %left '-' '+'
 %left '*' '/' '%'
 %left NEG NOT
+%type <num> NUMBER
+%type <str> ID
+%destructor { free ($$); } <str>
 %type <num> expr if_expr
 
 %{
-- 
2.33.0.464.g1972c5931b-goog

