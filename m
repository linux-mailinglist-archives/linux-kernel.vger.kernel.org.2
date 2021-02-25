Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E92325A15
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 00:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhBYXLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 18:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhBYXLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 18:11:05 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4764C061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 15:10:24 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id o3so7842159oic.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 15:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=UoFZ3P+KXBpGD+fINLtjQ4hHuKvSMz6V0Loo7Q31eYE=;
        b=Ag5Y0cWXGQ0NQ2EVRB9JQ2g/cpIuo+DrXimIs7k+Ob3SvIX+Lp1cXH/iwuwJJwDHIx
         Trwx0ZusHbbCCzH/3HKeNUYIAe9G5DJABGLdo3iqzsG7dYiwdSbZZ1hlL6mX92bTJDMB
         X/w2z+jB6/D2fOTfAe2a0a+xuuT/3UCIGGCxWvT7EZazFvbQq7Q7T88LvADqFPGzRSak
         KiIG64Kqir31MK2Ky10fKDchAY9MMWMj2Wd0MvtiCJSaIwKWVbDRoQfb1Yg2IXg1Heyj
         SgGO1nsDVVAiT2eRVD2vnhRVlazztfqW0P/T17/o37VD5IqCdzUgzaBoLQ+C+KPxZm4A
         4FnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=UoFZ3P+KXBpGD+fINLtjQ4hHuKvSMz6V0Loo7Q31eYE=;
        b=tZNGC8jNdrbZWGpc+pRDy6wd9sAra8tqdDUSZrmKC5OrDWLKGIampl/rGBYM/c/dTk
         sExowsdKrzvfkBA6eb5/WVN05BmNQ2RsE3rjUXP0k7frazzlWQcVtLX/I0/srpoBhu7s
         G+9cemx6WdwalyVZWkhUzQNvmkHhAIpmUSbgO0PNWr4hg/otWBA2BoSrB4r4wx+7OjGh
         VjHT/lwc5u9o0/sbcoPnxYh+5VJ3ktFmJAXc4iZBPgB/I6/P87oKq3Gvi+288AbTHchH
         gY6ASD9PknFvFOYK4f6O1+eGZi7gT/YZxaB8+OwzVLA0h1yqTU6MEr/e53QgpgHeI2aV
         WRgQ==
X-Gm-Message-State: AOAM530OJ53l09nAO1Psia+rfE+S3V+eJbBQSFfsn4rbsStXoj6doy77
        em1gq65nXzbARbpGRWaJUARvOA==
X-Google-Smtp-Source: ABdhPJxC6tBTkBwA9flUNg/EUWPw8ia4+6NNqrERZrqLrN+xw2R0fuvAHWmvXokE9sqC0d1fHewvpA==
X-Received: by 2002:aca:5f83:: with SMTP id t125mr113321oib.114.1614294623998;
        Thu, 25 Feb 2021 15:10:23 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 109sm1379612otj.8.2021.02.25.15.10.22
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 25 Feb 2021 15:10:23 -0800 (PST)
Date:   Thu, 25 Feb 2021 15:10:09 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] mm: restore node stat checking in
 /proc/sys/vm/stat_refresh
Message-ID: <alpine.LSU.2.11.2102251502240.13363@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4.7 52b6f46bc163 ("mm: /proc/sys/vm/stat_refresh to force vmstat update")
introduced vmstat_refresh(), with its vmstat underflow checking; then
v4.8 75ef71840539 ("mm, vmstat: add infrastructure for per-node vmstats")
split NR_VM_NODE_STAT_ITEMS out of NR_VM_ZONE_STAT_ITEMS without updating
vmstat_refresh(): so it has been missing out much of the vmstat underflow
checking ever since. Reinstate it. Thanks to Roman Gushchin <guro@fb.com>
for tangentially pointing this out.

Signed-off-by: Hugh Dickins <hughd@google.com>
---

 mm/vmstat.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- 5.12-rc/mm/vmstat.c	2021-02-24 12:03:55.000000000 -0800
+++ vmstat1/mm/vmstat.c	2021-02-25 11:50:36.000000000 -0800
@@ -1857,6 +1857,14 @@ int vmstat_refresh(struct ctl_table *tab
 		}
 	}
 #endif
+	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
+		val = atomic_long_read(&vm_node_stat[i]);
+		if (val < 0) {
+			pr_warn("%s: %s %ld\n",
+				__func__, node_stat_name(i), val);
+			err = -EINVAL;
+		}
+	}
 	if (err)
 		return err;
 	if (write)
