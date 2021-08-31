Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37CEF3FC7B8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 14:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbhHaM73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 08:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbhHaM7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 08:59:19 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994B0C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 05:58:24 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t15so21353311wrg.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 05:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RlSDoTBJbwZ1+/0ecNtGprCwalpFdAzDsfxdMM/e3GM=;
        b=l6S/pUeAfrJSprNCOKEOYd0+Fgv9a+ujQ0HxDPG00/VLHsmDx1l+WWWaPEfcR6hOvm
         vcCJB/kZxW0s+dCeUdJryWsSUpt3N7YnGoU3xfWpBQ8BBRKp2XPW4v5C54TW6+mGqpa6
         FgTQX4vh4vrH2Uxa2zZRNnyyZu8u+Hm+JDdoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RlSDoTBJbwZ1+/0ecNtGprCwalpFdAzDsfxdMM/e3GM=;
        b=KxArDLWU3El6R7Ajp5082N+PFQx5e4rZW4H+k/tuAuczedrnzrVHYRtxqmODKVkxdr
         bGnhMEc5kT9I7s+u9F9/tFHR8u+IFK26bAg5B1GGTK8G4AwAQ7VvLAhYAzSeGUl/UI9M
         87qdOJshnh8orvCwr5VHjeNZh7j+jP07sDDn3aGPCsfB3VbMB4EEPm3qVVzJPKPl/HR3
         yyv5Dr3YO7yk239cml9S7jF2KsYbODbVrtNz5GJyWsnucsK6Y+U6468hgW3+H1vN1Geg
         9h0YC+NwGEsy3/yLLtMHQaBgolvb5A5TAMW7Fb77lR9l/JUIvzivgyffkNM9nekJREBR
         5ALQ==
X-Gm-Message-State: AOAM53107Uasg1hCwZfXjBtXbZhfQ0uhyHXVVaq0ge3t3h+bPTgEwbbq
        yeunbM5XoG23/IKW9Ind/z/GMw==
X-Google-Smtp-Source: ABdhPJyMvnQ+99yRM6iY3/8/7Ati9ZYYEYbENFZ+LfxvFcbOSPr25fVfv9Cxv1kXbG2Hy0eQbccQfA==
X-Received: by 2002:adf:b743:: with SMTP id n3mr31397338wre.243.1630414702960;
        Tue, 31 Aug 2021 05:58:22 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:bdb8])
        by smtp.gmail.com with ESMTPSA id m1sm2590293wmq.10.2021.08.31.05.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 05:58:22 -0700 (PDT)
Date:   Tue, 31 Aug 2021 13:58:21 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Rik van Riel <riel@surriel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        stable@kernel.org, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm,vmscan: fix divide by zero in get_scan_count
Message-ID: <YS4nbYA61E9N2FqD@chrisdown.name>
References: <20210826220149.058089c6@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210826220149.058089c6@imladris.surriel.com>
User-Agent: Mutt/2.1.1 (e2a89abc) (2021-07-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel writes:
>Changeset f56ce412a59d ("mm: memcontrol: fix occasional OOMs due to
>proportional memory.low reclaim") introduced a divide by zero corner
>case when oomd is being used in combination with cgroup memory.low
>protection.
>
>When oomd decides to kill a cgroup, it will force the cgroup memory
>to be reclaimed after killing the tasks, by writing to the memory.max
>file for that cgroup, forcing the remaining page cache and reclaimable
>slab to be reclaimed down to zero.
>
>Previously, on cgroups with some memory.low protection that would result
>in the memory being reclaimed down to the memory.low limit, or likely not
>at all, having the page cache reclaimed asynchronously later.
>
>With f56ce412a59d the oomd write to memory.max tries to reclaim all the
>way down to zero, which may race with another reclaimer, to the point of
>ending up with the divide by zero below.
>
>This patch implements the obvious fix.
>
>Fixes: f56ce412a59d ("mm: memcontrol: fix occasional OOMs due to proportional memory.low reclaim")
>Signed-off-by: Rik van Riel <riel@surriel.com>

Thanks, good catch. No strong preference on this vs. max3(), so feel free to 
keep my ack either way.

Acked-by: Chris Down <chris@chrisdown.name>

>
>diff --git a/mm/vmscan.c b/mm/vmscan.c
>index eeae2f6bc532..f1782b816c98 100644
>--- a/mm/vmscan.c
>+++ b/mm/vmscan.c
>@@ -2592,7 +2592,7 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
> 			cgroup_size = max(cgroup_size, protection);
>
> 			scan = lruvec_size - lruvec_size * protection /
>-				cgroup_size;
>+				(cgroup_size + 1);
>
> 			/*
> 			 * Minimally target SWAP_CLUSTER_MAX pages to keep
>
>
