Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958574126AA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 21:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347383AbhITTUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 15:20:12 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:33391 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347482AbhITTSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 15:18:10 -0400
Received: by mail-pl1-f181.google.com with SMTP id t4so11779146plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 12:16:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0W/o5ZoyGa1oJqJxxVEWjBlKAnqr2zruLqjAEVsS5cI=;
        b=QniF894uWJHaqwIiXCrvpvpQNTs0KM+4AwfMUNKJFBBldF4NJK4cc30PYrTMDQUgdW
         FLD7qJYajmvPu8oLfCylG4QcEAQqqV51meIs+Ieco3C9N6gfmqtKTVwpDPaCrmh+/gou
         PKpbysK9qanAmSsoMy1JpAF7gZsW4Rl9x06ZOmU/HvDjIgKbu8WpOeOUYMBet59wiv0R
         LZfhkcw7wtrY0McG5qWPsUfd7jKrpb0GawzewYwQwjOEHwP47Xd4EbcAV48gM9pMPzmb
         wD/kRbA4/L8GpWHbjh8C9ETKATo6XFIi1+IaETSj0tgz0NkB9aQqtMGBiddoEYZNQsdx
         EUWA==
X-Gm-Message-State: AOAM533cDGiPuWmu/rYJToN7yEZQY9wDLtjjFQm/k1rp1j6205r+CVmM
        x8/awrP2wQXQqhkkfqFjPEo=
X-Google-Smtp-Source: ABdhPJzh6O/KZmA+yP3dCC4Uf8vMmPP9LJ3Xin0kTc/V2+ANxrN37cnlw3Pa2FYalADPNsJhKkDvHw==
X-Received: by 2002:a17:90b:1291:: with SMTP id fw17mr631393pjb.135.1632165402859;
        Mon, 20 Sep 2021 12:16:42 -0700 (PDT)
Received: from sultan-box.localdomain ([204.152.215.247])
        by smtp.gmail.com with ESMTPSA id c9sm123389pfi.212.2021.09.20.12.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 12:16:42 -0700 (PDT)
Date:   Mon, 20 Sep 2021 12:16:39 -0700
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Mark the OOM reaper thread as freezable
Message-ID: <YUjeF6YsHKljSFis@sultan-box.localdomain>
References: <20210918233920.9174-1-sultan@kerneltoast.com>
 <YUiBRdrkjIdB/rSN@dhcp22.suse.cz>
 <YUiu42krQjSTVPnc@sultan-box.localdomain>
 <YUjGIuQciY7HNj+Y@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUjGIuQciY7HNj+Y@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 07:34:26PM +0200, Michal Hocko wrote:
> The intention and the scope of the patch should be in the changelog.
> Your Fixes tag suggests there is a problem to fixed.

I guess References would be more appropriate here? I'm not familiar with every
subsystem's way of doing things, so I just rolled with Fixes to leave a
breadcrumb trail to the original commit implicated in my change. What would you
suggest in a case like this for mm patches?

> My memory has faded but I suspect it was to make sure that the oom
> reaper is not blocking the system wide freezing. The operation mode of
> the thread is to wait for oom victims and then do the unmapping without
> any blocking. While it can be frozen during the operation I do not
> remember that causing any problems and the waiting is exactly the point
> when that is obviously safe - hence wait_event_freezable which I believe
> is the proper API to use.

This isn't clear to me. Kthreads come with PF_NOFREEZE set by default, so the
system-wide freezing will already ignore the reaper thread as-is, although it
will make that determination from inside freeze_task() and thus
freezing_slow_path(), which involves acquiring a lock. You could set
PF_FREEZER_SKIP to skip the slowpath evaluation entirely.

Furthermore, the use of wait_event_freezable() will make the reaper thread enter
try_to_freeze() every time it's woken up. This seems wasteful considering that
the reaper thread will never actually freeze.

Sultan
