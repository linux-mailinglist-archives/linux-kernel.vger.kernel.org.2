Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA43397436
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 15:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbhFANcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 09:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbhFANcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 09:32:04 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73DCC061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 06:30:21 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id v8so14195015qkv.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 06:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QgAlRC15sowarDmOShJGxWuHEnM/uzw99+W0HvQo4Rg=;
        b=cUUpNv7ti+RM7h8vQNwO+Z3BWjT9sbNZV3bB/M9kDnNa0tXrvSqWCFblEmZjhRobg/
         zDCG8pInQHdVwG8gYjsLO/QJ1C+FV0KFpIRUDeCTVAdW/zoRKPinD9yHTbWioZMcbjvO
         ZXmwf4/Q0WnftuCPy9vf6zyZ5+FRTcVzC4OH+TXZB9m0ZqM5MIWdB2EZY0AGO/J8OD7a
         NIOnzAuPJujFBInYuD/Ekg6eLhaUkEdL73WSqTTmdhTJOL714v/Lp6+LTpiy9LHykHA9
         mfwVTDm0AFIh79M0ob+0YkzwXYRlyFbaGHXvxGogoZtP94wP/tGbS1v+h46OOuoydXEm
         jPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QgAlRC15sowarDmOShJGxWuHEnM/uzw99+W0HvQo4Rg=;
        b=NNGXCpYNffb1I6aXn2LnTkWi5Rj6Djz9kel3ywHMOg0z8S1WM+o9FmjqMyUJs2IF8+
         7TedKEQoGdaDyM+PU/CjhMSmUWXvvJwPENnK0lR+DxLzSlWOX3tpQg9vUroCQsJ2us/u
         TEupYEgoz8zIoSYuEh3vjYcAaGbby8rmKbBfYnK3G/f1x7AVrNHdtBMZTjaaTYhM1SP0
         1AMiaov3OjK9Taaghiw9O+HYIkHL0p1HfjyxMgIZi+V+q6aW3RqB626RzSoS40UTV/rN
         XBFFwXz9KVXALxRVmYVFFXbWgF/u+xVXotHqbNOZFKjqlz4MA1Pswrxyn2JOOXYNwOdT
         Tdhw==
X-Gm-Message-State: AOAM532uXBI4uvBB2NHCYIau/DgyLJY7AOFtFedfHaS6/h/oA9posztq
        thSS9deEXArImrjjQscDo0HFGg==
X-Google-Smtp-Source: ABdhPJw/BT/krk135SXW8kFdx0bYofrL5Ritm5HfxB3J6reIJGQDviHGncvQp1Vki9UslH5QN8yaCg==
X-Received: by 2002:a05:620a:2941:: with SMTP id n1mr21760007qkp.330.1622554221143;
        Tue, 01 Jun 2021 06:30:21 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id c6sm4355419qke.83.2021.06.01.06.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 06:30:20 -0700 (PDT)
Date:   Tue, 1 Jun 2021 09:30:19 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@surriel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH] mm: free idle swap cache page after COW
Message-ID: <YLY2ayrBpvwd29MA@cmpxchg.org>
References: <20210601053143.1380078-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601053143.1380078-1-ying.huang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 01:31:43PM +0800, Huang Ying wrote:
> With commit 09854ba94c6a ("mm: do_wp_page() simplification"), after
> COW, the idle swap cache page (neither the page nor the corresponding
> swap entry is mapped by any process) will be left in the LRU list,
> even if it's in the active list or the head of the inactive list.  So,
> the page reclaimer may take quite some overhead to reclaim these
> actually unused pages.
> 
> To help the page reclaiming, in this patch, after COW, the idle swap
> cache page will be tried to be freed.  To avoid to introduce much
> overhead to the hot COW code path,
> 
> a) there's almost zero overhead for non-swap case via checking
>    PageSwapCache() firstly.
> 
> b) the page lock is acquired via trylock only.
> 
> To test the patch, we used pmbench memory accessing benchmark with
> working-set larger than available memory on a 2-socket Intel server
> with a NVMe SSD as swap device.  Test results shows that the pmbench
> score increases up to 23.8% with the decreased size of swap cache and
> swapin throughput.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org> # use free_swap_cache()
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Tim Chen <tim.c.chen@intel.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
