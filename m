Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5157F319524
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 22:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhBKV1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 16:27:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:41702 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhBKV12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 16:27:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D5EFBAE91;
        Thu, 11 Feb 2021 21:26:47 +0000 (UTC)
Date:   Thu, 11 Feb 2021 22:26:45 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: workingset: clarify eviction order and distance
 calculation
Message-ID: <20210211212645.GB2872@localhost.localdomain>
References: <20210201060651.3781-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201060651.3781-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 07:06:51AM +0100, Oscar Salvador wrote:
> The premise of the refault distance is that it can be seen as a deficit
> of the inactive list space, so that if the inactive list would have had
> (R - E) more slots, the page would not have been evicted but promoted
> to the active list instead.
> 
> However, the way the code is ordered right now set us to be off by one,
> so the real number of slots would be (R - E) + 1.
> I stumbled upon this when trying to understand the code and it puzzled me
> that the comments did not match what the code did.
> 
> This it not an issue at all since evictions and refaults tend to happen
> in a number large enough that being off-by-one does not have any impact
> - and since the compiler and CPUs are free to rearrange the execution
> sequence anyway.
> But as Johannes says, it is better to re-arrange the code in the proper
> order since otherwise would be misleading to somebody who is actively
> reading and trying to understand the logic of the code - like it
> happened to me.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Hi Andrew,

is this on your radar?

Thanks!

-- 
Oscar Salvador
SUSE L3
