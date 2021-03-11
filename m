Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467353369E3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 02:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbhCKBuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 20:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhCKBuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 20:50:16 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BD1C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 17:50:16 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id l132so19127330qke.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 17:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VnK/Ou5++5aAduT+vgSPu3tbQk3cRlxblRdLjBs1qkI=;
        b=jx8kG6wECMMTmF45eZ7ABrPEJNva0pZbs5+4jzarLFhqMQjLauHiGgggpV0YZCU3km
         5oDdr8oblDrFKStGvYjVBGUm5zlM8m7g/So+/LHiNjuPyICK7VO223eO7JeyXrZKhf2f
         jr1VK2/KysQwLoSVPYm59CMwVKJCXtXR8/LzyjCFdezwWjj01QKqq7oUcke7dZHOPGD8
         r/jfAV4zazGcKkH4mpqgbmwxg+IFFrKOKmvaNI8jzKJx4ZwtO8ct87XtTzQZR1pfha18
         leRNKp8JXnTzRDcIlMt7jkvDNvfoIuHw1y73qUOQ4Q8M4AaodrOTBP/cJGht2P4Ikyh/
         97uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VnK/Ou5++5aAduT+vgSPu3tbQk3cRlxblRdLjBs1qkI=;
        b=NsQHQwpX2amsHCdmUKYlGmfWZsoc+MYI0QF8nx+jNeI1hMLrW3o48e5ru8OsS9yUv9
         Wtej9OzfLewxzGZZbGBHvpbFGQikUV9Qom0N9kSePujewShGz1Epn5O4L5Y0JN3+M4V9
         4+lPLByz6xhjDj6AeKEL8abBwgf21TB8qsqkTLklCIRgY1VR7T1dCb3ul3dadEdoB6Pk
         zhIy6hMaODrPeohNxu7des8vvprJQqoUANxIPG0nKkJwjfXCZQ8a9+Er/rPqj4anUgIZ
         3//2fYLYYnk9RqQQUd1zTqLTgd7R3OyuE33s7Niz2pYCmbwSeR6zlcNUtg3ZPT9i3sXF
         Nk0w==
X-Gm-Message-State: AOAM5313KXQTTAIJ/syjodwN3a+BwYI8aDU1JJWCiKJ3H64747s4wOsT
        ofZW/zPxrFBXAJ0j6fyzZsl3hg==
X-Google-Smtp-Source: ABdhPJzOjxmf9bn5sDalj+Z+vRxLZW/gbayHuO74x/ayYgTpSVEHuOlsKwcQXlUDbDfAItsVt2VYIg==
X-Received: by 2002:a37:a38e:: with SMTP id m136mr5581896qke.250.1615427415187;
        Wed, 10 Mar 2021 17:50:15 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id v4sm798670qte.18.2021.03.10.17.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 17:50:14 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lKASr-00B0Gx-CD; Wed, 10 Mar 2021 21:50:13 -0400
Date:   Wed, 10 Mar 2021 21:50:13 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Rientjes <rientjes@google.com>,
        Ben Gardon <bgardon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>
Subject: Re: [PATCH] mm/oom_kill: Ensure MMU notifier range_end() is paired
 with range_start()
Message-ID: <20210311015013.GS444867@ziepe.ca>
References: <20210310213117.1444147-1-seanjc@google.com>
 <20210311002807.GQ444867@ziepe.ca>
 <YElwQU9mPUNwPg7q@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YElwQU9mPUNwPg7q@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 05:20:01PM -0800, Sean Christopherson wrote:

> > Which I believe is fatal to kvm? These notifiers certainly do not only
> > happen at process exit.
> 
> My point about the process dying is that the existing bug that causes
> mmu_notifier_count to become imbalanced is benign only because the process is
> being killed, and thus KVM will stop running its vCPUs.

Are you saying we only call non-blocking invalidate during a process
exit event?? 
 
> > So, both of the remaining _end users become corrupted with this patch!
> 
> I don't follow.  mn_hlist_invalidate_range_start() iterates over all
> notifiers, even if a notifier earlier in the chain failed.  How will
> KVM become imbalanced?

Er, ok, that got left in a weird way. There is another "bug" where end
is not supposed to be called if the start failed.

> The existing _end users never fail their _start.  If KVM started failing its
> start, then yes, it could get corrupted.  

Well, maybe that is the way out of this now. If we don't permit a
start to fail if there is an end then we have no problem to unwind it
as we can continue to call everything. This can't be backported too
far though, the itree notifier conversions are what made the WARN_ON
safe today.

Something very approximately like this is closer to my preference:

diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 61ee40ed804ee5..6d5cd20f81dadc 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -501,10 +501,25 @@ static int mn_hlist_invalidate_range_start(
 						"");
 				WARN_ON(mmu_notifier_range_blockable(range) ||
 					_ret != -EAGAIN);
+				/*
+				 * We call all the notifiers on any EAGAIN,
+				 * there is no way for a notifier to know if
+				 * its start method failed, thus a start that
+				 * does EAGAIN can't also do end.
+				 */
+				WARN_ON(ops->invalidate_range_end);
 				ret = _ret;
 			}
 		}
 	}
+
+	if (ret) {
+		/* Must be non-blocking to get here*/
+		hlist_for_each_entry_rcu (subscription, &subscriptions->list,
+					  hlist, srcu_read_lock_held(&srcu))
+			subscription->ops->invalidate_range_end(subscription,
+								range);
+	}
 	srcu_read_unlock(&srcu, id);
 
 	return ret;
