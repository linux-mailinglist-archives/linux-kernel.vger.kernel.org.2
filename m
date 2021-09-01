Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89353FD094
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 03:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241542AbhIABHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 21:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241207AbhIABHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 21:07:16 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306B4C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 18:06:20 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id s11so1032404pgr.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 18:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=Bk3eA3HGoVdf+D94if6LP0AzGRhODu8sBZGMlHjTOVI=;
        b=AkG2kYnNbVzSk9RsfTjSiJEqdWdEqtfocVNINxY6zZrkJnFQiWZc+uyaM3kiiVXC4F
         bjX5H8lVU66HDKscetKfJAecVuvj38iHVVJGEzRUmUefSKDQEnuRMuzXOKoBsVXhgwG6
         hRbIbtTCUwiZLEjDYzYY0tC+sbDAeKHT4ziZPW9oIyFyneiNCgJbq3LVMf47Xdjh8FGv
         B8KoeUCm/vjM7n9mLgMkLkNJ73Eh1TMcncnlGgqZ5OD4N4syEzq0BhuWrcYgygXKhfOL
         H/uE8IVyV7Qmm356LVCbOZ6IwbISeeWt5jwm3zYuSmxOYrnI5m6TPYdEm49wZAoM0kr3
         hdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=Bk3eA3HGoVdf+D94if6LP0AzGRhODu8sBZGMlHjTOVI=;
        b=dm6K58THXF5U/xIKU6/pCwLD8eGSYu3O0mB2Cf6FLt81ZE/y2eXyuA0eRpEbT2rfZ8
         XcraynrMhPxaUwHcqtcyXCG+Vj3vnOOhGhSOY4oXcxxaWPhlE/T3xe2lXZH1ck6EHP1u
         tywj6xcRVqbfHGiyFGj4KEWuu8/cRsVLKKrjfsZzoodw+QiorN9a1h+kQ6zyXGaFQoLm
         M5+IwGRNzm3G9hBaZv+iPa/ENEzEXPz0QNHIZkENcTPh56dCo4WYwFdvWhEyAK87IDF6
         FIxeiOJwfA1tARHLOGkbbuketuOMM9p+wvdKwrdpJe0uy+2HQUfhJyPX9VOUQhuDt+WR
         Cg9A==
X-Gm-Message-State: AOAM531xh+eQoTHkzx8RltTdQW7MxXqxbL9kNqarZYVxNXnYsQyOS73B
        dblfDigS46hxPJk67Y8a5ZDlbw==
X-Google-Smtp-Source: ABdhPJzCeT5zkz7Lr8PP9zK5LKQPpz2HNH6ZJjmMS+lXV2KRtv03iYM3N2XX4S5ACF63SNzewgWckg==
X-Received: by 2002:a65:620d:: with SMTP id d13mr29789947pgv.36.1630458379468;
        Tue, 31 Aug 2021 18:06:19 -0700 (PDT)
Received: from [2620:15c:17:3:b81a:d450:f5a3:8b8b] ([2620:15c:17:3:b81a:d450:f5a3:8b8b])
        by smtp.gmail.com with ESMTPSA id h9sm4296811pjg.9.2021.08.31.18.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 18:06:18 -0700 (PDT)
Date:   Tue, 31 Aug 2021 18:06:17 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Michal Hocko <mhocko@suse.com>
cc:     Feng Tang <feng.tang@intel.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm/oom: detect and kill task which has allocation
 forbidden by cpuset limit
In-Reply-To: <YS5RTiVgydjszmjn@dhcp22.suse.cz>
Message-ID: <52d80e9-cf27-9a59-94fd-d27a1e2dac6f@google.com>
References: <1630399085-70431-1-git-send-email-feng.tang@intel.com> <YS5RTiVgydjszmjn@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Aug 2021, Michal Hocko wrote:

> I do not like this solution TBH. We know that that it is impossible to
> satisfy the allocation at the page allocator level so dealing with it at
> the OOM killer level is just a bad layering and a lot of wasted cycles
> to reach that point. Why cannot we simply fail the allocation if cpusets
> filtering leads to an empty zone intersection?

Cpusets will guarantee our effective nodemask will include at least one 
node in N_MEMORY (cpuset_mems_allowed()) so we'll always have at least one 
zone in our zonelist.

Issue in this case appears to be that the zone will never satisfy 
non-movable allocations.  I think this would be very similar to a GFP_DMA 
allocation when bound to a node without lowmem, in which case we get a 
page allocation failure.  We don't kill current like this patch.

So I'd agree in this case that it would be better to simply fail the 
allocation.

Feng, would you move this check to __alloc_pages_may_oom() like the other 
special cases and simply fail rather than call into the oom killer?
