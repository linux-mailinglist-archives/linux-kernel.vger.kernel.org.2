Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248AE44D781
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 14:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbhKKNt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 08:49:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:46332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232699AbhKKNtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 08:49:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC23760FDA;
        Thu, 11 Nov 2021 13:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636638426;
        bh=WG9wJbTMC7Iu3sjAXUql1RYYi/T4YPOsMKVcdhFxOHk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tQVD0f6T/wdj9oSeIuAFHGWvQAikDDxxNXLvgEHBpnIKnvsm/MpcW7sIIhN8krQXG
         iDis9Yp2LPcbOTcXL8YHpLk2YFRRSPtAs+p/eHX0PTMy5EDY4Zc7pCwyHbeAWL+i5u
         swBc+rsu+rYj17PFqH4dgqTv54PM9yyhJC+DQV+lZFYtV2a5MHEmePavlLkLEAretx
         84weUPqJB6VknZY5lagoXQIdlFGi9t/VwQFCAoOxKCRlQcfuHPg7lyNxJmgqVdU0Ip
         M2KK6b+9yKrKmUAMbKBJt176BaTmDy7+j0I/hFYdCwmurxCls7+Om+VLIb/KR8occE
         0PACp1+N6dVRA==
Date:   Thu, 11 Nov 2021 05:47:04 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: net/core/dev.c:6917 napi_disable() error: uninitialized symbol
 'new'.
Message-ID: <20211111054704.02775229@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <202111110259.SiMy91ja-lkp@intel.com>
References: <202111110259.SiMy91ja-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Nov 2021 11:32:38 +0300 Dan Carpenter wrote:
> Jakub, could you change the netdev patchwork bot to include the Link:
> tag so I can look up the thread for this with b4?  The LKP robot sets
> the In-Reply-To header when it pulls the patch from a thread.  In this
> case, it's pulling it from a git tree but it could be modified to use
> the Link tag as well if it doesn't already.
> 
> I don't know how we would handle patches with multiple Link: tags,
> though.  I guess it's supposed to be in chronological order so the last
> lore.kernel.org tag is the correct one?

Hm, we'd need to coordinate this, because we have multiple people
applying patches from the netdevbpf pw instance and most add the 
Link tag locally.

Do you know if pw is capable of adding the Link so this would just 
be a switch for Konstantin to flip?

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   cb690f5238d71f543f4ce874aa59237cf53a877c
> commit: 719c571970109b0d0af24745d31b202affc9365f net: make napi_disable() symmetric with enable
> config: i386-randconfig-m021-20210928 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> net/core/dev.c:6917 napi_disable() error: uninitialized symbol 'new'.
> 
> vim +/new +6917 net/core/dev.c
> 
> 3b47d30396bae4 Eric Dumazet   2014-11-06  6901  void napi_disable(struct napi_struct *n)
> 3b47d30396bae4 Eric Dumazet   2014-11-06  6902  {
> 719c571970109b Jakub Kicinski 2021-09-24  6903  	unsigned long val, new;
> 719c571970109b Jakub Kicinski 2021-09-24  6904  
> 3b47d30396bae4 Eric Dumazet   2014-11-06  6905  	might_sleep();
> 3b47d30396bae4 Eric Dumazet   2014-11-06  6906  	set_bit(NAPI_STATE_DISABLE, &n->state);
> 3b47d30396bae4 Eric Dumazet   2014-11-06  6907  
> 719c571970109b Jakub Kicinski 2021-09-24  6908  	do {
> 719c571970109b Jakub Kicinski 2021-09-24  6909  		val = READ_ONCE(n->state);
> 719c571970109b Jakub Kicinski 2021-09-24  6910  		if (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
> 719c571970109b Jakub Kicinski 2021-09-24  6911  			usleep_range(20, 200);
> 719c571970109b Jakub Kicinski 2021-09-24  6912  			continue;
> 
> Can we hit this continue on the first iteration through the loop?
> 
> 719c571970109b Jakub Kicinski 2021-09-24  6913  		}
> 719c571970109b Jakub Kicinski 2021-09-24  6914  
> 719c571970109b Jakub Kicinski 2021-09-24  6915  		new = val | NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC;
> 719c571970109b Jakub Kicinski 2021-09-24  6916  		new &= ~(NAPIF_STATE_THREADED | NAPIF_STATE_PREFER_BUSY_POLL);
> 719c571970109b Jakub Kicinski 2021-09-24 @6917  	} while (cmpxchg(&n->state, val, new) != val);
>                                                                                          ^^^
> Warning.
> 
> 3b47d30396bae4 Eric Dumazet   2014-11-06  6918  
> 3b47d30396bae4 Eric Dumazet   2014-11-06  6919  	hrtimer_cancel(&n->timer);
> 3b47d30396bae4 Eric Dumazet   2014-11-06  6920  
> 3b47d30396bae4 Eric Dumazet   2014-11-06  6921  	clear_bit(NAPI_STATE_DISABLE, &n->state);
> 3b47d30396bae4 Eric Dumazet   2014-11-06  6922  }

Indeed, fixed yesterday by 0315a075f134 ("net: fix premature exit from
NAPI state polling in napi_disable()"). Thanks!
