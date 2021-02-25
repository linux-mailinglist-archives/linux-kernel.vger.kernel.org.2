Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D08F325A16
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 00:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhBYXM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 18:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbhBYXMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 18:12:53 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DEBC061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 15:12:13 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id f33so7375302otf.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 15:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ZTnYHREJjaxknDfDoBhteeW5RbBqwnc0KAb8pOQepb4=;
        b=DZjrfGHZzY4vsUofUZQCjn59YAhiXPKAnJ0rls9m6Kt0kXHk2mBMCkFhXhrp+jbrxL
         Qwcjk51wJbhUOwPAqgrQ5RS8FW/Dcfa/sa+GGoq0nefrWiPSZRxcJPcN8M3DWrDTmuPQ
         laQpOGEIbbN0w4e/VITz2sWDKuZDnUGfdcKPS7NdlwWjkewZ6DPa7vpI7aYpQXX3qvWH
         bmljy+vS2gqnuJCBqydx8G5kbTCcDm7ZNwkImHgau1f+OPeCa77FI1zifAhaNF1QjYdG
         j6II8PQWIc32iQ6keYblKkFjoZuT0tAx0f77knppoZjysx3235SUF6G7vRGJKLVZMHVn
         5AVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ZTnYHREJjaxknDfDoBhteeW5RbBqwnc0KAb8pOQepb4=;
        b=L4bKDuwvdaz86B/F9PU21PwxnXdifxflUqjdquTzBg2E6eZuc21+dC0yRqhFuE/9Er
         /mLqAWetM9zkmGoop3hxrvRk/hLKCJsyM6HeqwXj5HfLt287x2m6gvNzrzNtPqZ4i4Ut
         SowGBn1r8tFG9KnbvGglFjz9QmeE1xTTmPUUaw5Wz4iSSV33HtzK00q12zxBWi51vgLl
         qk7R3+Ap28u0rj5mqYfDG3bvDsvn9/WKW6k2NwpzWZa8WSYeVQet+dm62E15xQmGd5bl
         so3lKoOjmnSRmt/vKKqpN8bs81wMjJvwB12VCe7z8Ecok4tB5KWv3To0YhzImw/2JS/S
         nGjg==
X-Gm-Message-State: AOAM530n3J2g7+4Sp452dMNmAceR9mj4cFLdkEc0WCkPKPNNJ3m4GMwZ
        y4jRLQGTBM9sSO+Nv6GXVR+/zQ==
X-Google-Smtp-Source: ABdhPJxOSAWbEdHaaF6Y/UpZk58fZCxjSTbQvu6j6JDDhIg9nIjzNuKFCZKlX4QL/DexIVYGr+N1Ug==
X-Received: by 2002:a9d:3bc4:: with SMTP id k62mr55700otc.318.1614294732828;
        Thu, 25 Feb 2021 15:12:12 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w30sm1327730oow.48.2021.02.25.15.12.11
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 25 Feb 2021 15:12:12 -0800 (PST)
Date:   Thu, 25 Feb 2021 15:12:10 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] mm: no more EINVAL from /proc/sys/vm/stat_refresh
In-Reply-To: <alpine.LSU.2.11.2102251502240.13363@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2102251510410.13363@eggly.anvils>
References: <alpine.LSU.2.11.2102251502240.13363@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EINVAL was good for drawing the refresher's attention to a warning in
dmesg, but became very tiresome when running test suites scripted with
"set -e": an underflow from a bug in one feature would cause unrelated
tests much later to fail, just because their /proc/sys/vm/stat_refresh
touch failed with that error. Stop doing that.

Signed-off-by: Hugh Dickins <hughd@google.com>
---

 mm/vmstat.c |    5 -----
 1 file changed, 5 deletions(-)

--- vmstat1/mm/vmstat.c	2021-02-25 11:50:36.000000000 -0800
+++ vmstat2/mm/vmstat.c	2021-02-25 11:56:18.000000000 -0800
@@ -1844,7 +1844,6 @@ int vmstat_refresh(struct ctl_table *tab
 		if (val < 0) {
 			pr_warn("%s: %s %ld\n",
 				__func__, zone_stat_name(i), val);
-			err = -EINVAL;
 		}
 	}
 #ifdef CONFIG_NUMA
@@ -1853,7 +1852,6 @@ int vmstat_refresh(struct ctl_table *tab
 		if (val < 0) {
 			pr_warn("%s: %s %ld\n",
 				__func__, numa_stat_name(i), val);
-			err = -EINVAL;
 		}
 	}
 #endif
@@ -1862,11 +1860,8 @@ int vmstat_refresh(struct ctl_table *tab
 		if (val < 0) {
 			pr_warn("%s: %s %ld\n",
 				__func__, node_stat_name(i), val);
-			err = -EINVAL;
 		}
 	}
-	if (err)
-		return err;
 	if (write)
 		*ppos += *lenp;
 	else
