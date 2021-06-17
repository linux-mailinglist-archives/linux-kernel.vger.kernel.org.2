Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0AC63AB715
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 17:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbhFQPP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 11:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbhFQPPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 11:15:22 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C247DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 08:13:13 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id k5so3497065iow.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 08:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R6IjdE1Ab1c2r5GwqgV+dlCerZLtvAuLnafRfT9ALeI=;
        b=nl7kh8mTFxsEnrvy3uxWmeHdlgAwdDUBxobn/V+RwZr8AMgFHO4ca227CVwWr7sqe5
         g/bMVkljqXrEglmAfcmsHcYrO8bQX+ED/ca9WgTANuCj7on/KMwFt8r7n7k5SzNzs4Uh
         U9dzh0EgHfUUE9BhwGwA+gn2WV7Ft7hbRSFfHieiq1Re6wqLKlP3WDy22ReM5+GE0VrP
         kQSqdpIWhSFBoEmIoERYF8ODAXIlbMMsjCIA6rAO4/j1iNl7KWr85EKPt7gRIWABksgt
         9PZdk7hxVuGrbIA6BiTyMKWJxvOG47F0JrBiCcBIhuwftgCne91VH6fXT/Xhjg0SYaqY
         HPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R6IjdE1Ab1c2r5GwqgV+dlCerZLtvAuLnafRfT9ALeI=;
        b=C4GoYpcdbIrTk2D5Yl+0cjnzCPWnTh5v12/oizDiGtswXq80dJndiMYv3bOEUQaReb
         QPOkvQp0rTh4FnngBxEX86ax/Qu3L8hrumzXkIFmJvWw70iNs2I2qfggrtWkYRIH4gL5
         /RE6xOsWtkWssKUzd6O2qnHzgvMJhpqYmn4qUGKs8ZTePsjbcqD+/bweZcK7m7P0O1fM
         QbcOY6VcLk36rV9/+1fpYkPvMDtPXyUnARAC31JkTZAAf+d/H74zGFaNir4CXqsA8VvC
         nJvpigx6SwU4I//Ubz2t8yVWLdtRTWDrCcIq1SztKqfub33aJmsOMxEM//2rGztBwAaJ
         6P2Q==
X-Gm-Message-State: AOAM532+ZLfXU5Vb8BX2UfFpLgxq9upLu9ufCwpGubUxTiFpgS4AH6Pq
        FyuVnP0NK7VrCWk+xX0YN34MH2Rz3cU=
X-Google-Smtp-Source: ABdhPJzQLwXN8hjiPsQAVsVVjP/3da+2bL8knlxyM23LHNPyThEiaiqNwN08tcCOxsoPwgtrI+4uaw==
X-Received: by 2002:a02:cc3b:: with SMTP id o27mr6409jap.84.1623942793219;
        Thu, 17 Jun 2021 08:13:13 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id n2sm3078950iod.54.2021.06.17.08.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 08:13:12 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1B41327C0054;
        Thu, 17 Jun 2021 11:13:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 17 Jun 2021 11:13:12 -0400
X-ME-Sender: <xms:h2bLYH87d6pfISyGfDvODbhWhnADftyAHIclWvFjFphbG-x25UGf1g>
    <xme:h2bLYDuLQvfQS3NIfKtOCyCJ7PEwvpaiQYW1vE9BqSX7f4CSfpJH6uCjtusgVcEQ-
    8kjnuTwv_R6jY0Bpw>
X-ME-Received: <xmr:h2bLYFCiMIyO574cr_ul2C8Ie4tyeSRBPfpWpjT7mrctAS5JhGyOQHQvnw4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeefuddgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehg
    mhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedvleeigedugfegveejhfejveeuve
    eiteejieekvdfgjeefudehfefhgfegvdegjeenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrsh
    honhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghn
    gheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:h2bLYDdoLKmv8vBJzwcjhTHFDREf8wXEeXLTNAUdD965iNEJ6zbhfQ>
    <xmx:h2bLYMONge4bT16uxeW6TYeMjZXr1qMlVLfCJfq1TDs1DZg5Eq5Huw>
    <xmx:h2bLYFkqMT3r1x8gnyanvXKxkxmIMpyFaJCtptw59xy50GLKcKmEuw>
    <xmx:h2bLYIB-tnenrONEF9uU3cXR-Ugl5UsYnYRKf1OapqTZ86RYuqRs5g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jun 2021 11:13:11 -0400 (EDT)
Date:   Thu, 17 Jun 2021 23:12:46 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Xiongwei Song <sxwjean@me.com>
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, linux-kernel@vger.kernel.org,
        Xiongwei Song <sxwjean@gmail.com>
Subject: Re: [PATCH 3/3] locking/lockdep: print possible warning after
 counting deps
Message-ID: <YMtmbjw5EGdXRdD8@boqun-archlinux>
References: <20210617142828.346111-1-sxwjean@me.com>
 <20210617142828.346111-4-sxwjean@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617142828.346111-4-sxwjean@me.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 17, 2021 at 10:28:28PM +0800, Xiongwei Song wrote:
> From: Xiongwei Song <sxwjean@gmail.com>
> 
> The graph walk might hit error when counting dependencies. Once the
> return value is negative, print a warning to reminder users.
> 

Thanks for the improvement, but please see below:

> Suggested-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> ---
>  kernel/locking/lockdep.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index cb94097014d8..cfe0f4374594 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -2028,8 +2028,12 @@ static unsigned long __lockdep_count_forward_deps(struct lock_list *this)
>  {
>  	unsigned long  count = 0;
>  	struct lock_list *target_entry;
> +	enum bfs_result ret;
> +
> +	ret = __bfs_forwards(this, (void *)&count, noop_count, NULL, &target_entry);
>  
> -	__bfs_forwards(this, (void *)&count, noop_count, NULL, &target_entry);
> +	if (bfs_error(ret))
> +		print_bfs_bug(ret);

Here print_bfs_bug() will eventually call debug_locks_off_graph_unlock()
to release the graph lock, and the caller (lockdep_count_fowards_deps())
will also call graph_unlock() afterwards, and that means we unlock
*twice* if a BFS error happens... although in that case, lockdep should
stop working so messing up with the graph lock may not hurt anything,
but still, I don't think we want to do that.

So probably you can open-code __lockdep_count_forward_deps() into
lockdep_count_forwards_deps(), and call print_bfs_bug() or
graph_unlock() accordingly. The body of __lockdep_count_forward_deps()
is really small, so I think it's OK to open-code it into its caller.

Regards,
Boqun

>  
>  	return count;
>  }
> @@ -2053,8 +2057,12 @@ static unsigned long __lockdep_count_backward_deps(struct lock_list *this)
>  {
>  	unsigned long  count = 0;
>  	struct lock_list *target_entry;
> +	enum bfs_result ret;
> +
> +	ret = __bfs_backwards(this, (void *)&count, noop_count, NULL, &target_entry);
>  
> -	__bfs_backwards(this, (void *)&count, noop_count, NULL, &target_entry);
> +	if (bfs_error(ret))
> +		print_bfs_bug(ret);
>  
>  	return count;
>  }
> -- 
> 2.30.2
> 
