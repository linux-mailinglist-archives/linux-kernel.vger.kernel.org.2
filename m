Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6E243476E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 10:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhJTI5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 04:57:44 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49048 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhJTI5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 04:57:43 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EFF902195C;
        Wed, 20 Oct 2021 08:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634720127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=drSdqOUgPDLzIHMDdiQEpBl1jbGldtxzCXUREGTCpAM=;
        b=u6aivwsI93BOLQ2BzXCgWIomMSDlUSdi3jJ0dPetefXsuaecwNvzbFyEFtsbnKv2NzpK9R
        5dKlih6TC9wCQ3gvT2070HjuklrmgnYWcbLqBVGB8EnU9rrdnQ8c+gPbzITYF91aW8ig0Y
        AIyAKqCKtlWbBVflVmXRWGEBwTrxkuk=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8F892A3C33;
        Wed, 20 Oct 2021 08:55:27 +0000 (UTC)
Date:   Wed, 20 Oct 2021 10:55:27 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: skip current when memcg reclaim
Message-ID: <YW/Zf/s/CtRFlJ87@dhcp22.suse.cz>
References: <1634278529-16983-1-git-send-email-huangzhaoyang@gmail.com>
 <YW0u67o8wl3CGikP@dhcp22.suse.cz>
 <CAGWkznEO9SyNFEBqL8=JxewVTvaUhwFLPow69mi=R1MJ=XCpow@mail.gmail.com>
 <YW1rcv4bN1WWhzLD@dhcp22.suse.cz>
 <CAGWkznG65_FGx9jU7rjj5biEdyHZ=kcPwmXj6cGxxVmPy2rdKQ@mail.gmail.com>
 <YW6LSVK+NTiZ05+X@dhcp22.suse.cz>
 <CAGWkznHSPAu572BjoE510Sm+G9vGetKg-v2TkjwtcmZGo8MPVw@mail.gmail.com>
 <YW7G7znfHxd52b/T@dhcp22.suse.cz>
 <CAGWkznGb05Uykxz=9K+8uB6axS7LCo_7hMXAn7DFJXvAmkFy5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznGb05Uykxz=9K+8uB6axS7LCo_7hMXAn7DFJXvAmkFy5Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20-10-21 15:33:39, Zhaoyang Huang wrote:
[...]
> Do you mean that direct reclaim should succeed for the first round
> reclaim within which memcg get protected by memory.low and would NOT
> retry by setting memcg_low_reclaim to true?

Yes, this is the semantic of low limit protection in the upstream
kernel. Have a look at do_try_to_free_pages and how it sets
memcg_low_reclaim only if there were no pages reclaimed.

> It is not true in android
> like system, where reclaim always failed and introduce lmk and even
> OOM.

I am not familiar with android specific changes to the upstream reclaim
logic. You should be investigating why the reclaim couldn't make a
forward progress (aka reclaim pages) from non-protected memcgs. There
are tracepoints you can use (generally vmscan prefix).

-- 
Michal Hocko
SUSE Labs
