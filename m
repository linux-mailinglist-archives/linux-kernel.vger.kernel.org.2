Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28F638BA5D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 01:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbhETXZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 19:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbhETXZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 19:25:47 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1284BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 16:24:24 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so6363681wmk.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 16:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=99Is1Ox+Utl3amtJ0W3WXbULjI/XXbGGwaImoB8VLO0=;
        b=SBhG7LJdDG6oVaDdeb1V/wPcz2OpmKfA0emiiCx8sx7w7QGGe+nk2Gbui8dplk3ueG
         JCAs/hx4f7hpDdW1E8Ycp+FbSStIqraiwdWD9CyXXvW3T4mu1RQWok0sn24AeMKWT0HP
         9ObBbfleQHRmT9vl8GHFsOlCtoDtGn8WdgZSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=99Is1Ox+Utl3amtJ0W3WXbULjI/XXbGGwaImoB8VLO0=;
        b=UlrCVSLNZsJef9sVGunEt4uwWKBaOhxoDcdVTNXPzFofZkbfQolidwhYnhzZKPLOE5
         OyWEHmIsciwgtFWKNhRoT5oRkUCxX6OponEEhjXOp9jRSg+SM9URHITF2t6zG8gaBjKk
         wMTVFAfMEs38ahGiKh5YRFiX5mIU+q6oOLUWM4vV5ctyrr1Dbp74zIfiEFSLz2HWjZ2o
         t3SCnJeMWnPB4bTtdbVG1lyE+z1xKiG1ISxNU/4NloAYvMEbluF7huLj/nt+gEXgJ6hI
         fKutY++voG6TA26aoj+0mCpFRsBlH8TxZDYWJ/eF5jqIYbuKe0LOZdy3IC24cZU92vf+
         Hkbg==
X-Gm-Message-State: AOAM532QI8NbBX47dAEBuwnN6CQ7BnHnqzCv5jXw0aSR5ndBX/Khn7yD
        Xb33onssQsb6KSTVjk9F5MxmDw==
X-Google-Smtp-Source: ABdhPJzk8F30NdHe2UWtkK774YOUN3SDUCB55L0lserV+HcNqSqQASa3kV1OPxlNWZf5JhIfJWjf3g==
X-Received: by 2002:a05:600c:4fd6:: with SMTP id o22mr5693192wmq.83.1621553062636;
        Thu, 20 May 2021 16:24:22 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:ab33])
        by smtp.gmail.com with ESMTPSA id f188sm10606713wmf.24.2021.05.20.16.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 16:24:22 -0700 (PDT)
Date:   Fri, 21 May 2021 00:24:21 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Streetman <ddstreet@ieee.org>,
        Yang Shi <shy828301@gmail.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/14] mm/memcontrol.c: Fix kerneldoc comment for
 mem_cgroup_calculate_protection
Message-ID: <YKbvpWqzN67C50DL@chrisdown.name>
References: <20210520084809.8576-1-mgorman@techsingularity.net>
 <20210520084809.8576-7-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210520084809.8576-7-mgorman@techsingularity.net>
User-Agent: Mutt/2.0.7 (481f3800) (2021-05-04)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman writes:
>make W=1 generates the following warning for mem_cgroup_calculate_protection
>
>  mm/memcontrol.c:6468: warning: expecting prototype for mem_cgroup_protected(). Prototype was for mem_cgroup_calculate_protection() instead
>
>Commit 45c7f7e1ef17 ("mm, memcg: decouple e{low,min} state mutations from
>protection checks") changed the function definition but not the associated
>kerneldoc comment.
>
>Fixes: 45c7f7e1ef17 ("mm, memcg: decouple e{low,min} state mutations from protection checks")
>Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Whoops, thanks.

Acked-by: Chris Down <chris@chrisdown.name>

>---
> mm/memcontrol.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>index 64ada9e650a5..030c1dc131ce 100644
>--- a/mm/memcontrol.c
>+++ b/mm/memcontrol.c
>@@ -6456,7 +6456,7 @@ static unsigned long effective_protection(unsigned long usage,
> }
>
> /**
>- * mem_cgroup_protected - check if memory consumption is in the normal range
>+ * mem_cgroup_calculate_protection - check if memory consumption is in the normal range
>  * @root: the top ancestor of the sub-tree being checked
>  * @memcg: the memory cgroup to check
>  *
>-- 
>2.26.2
>
>
