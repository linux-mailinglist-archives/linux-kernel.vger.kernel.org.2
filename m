Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5AE339D98E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 12:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhFGKZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 06:25:24 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47808 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhFGKZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 06:25:21 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ED35E1FDA5;
        Mon,  7 Jun 2021 10:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623061407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3yTVmuXnYhofXBlCbo4IT8YVBm6HcKA8wUzVzSayMos=;
        b=WzFfC+Wgz7EnMtRD06x4fPqve4Fc88iJSnKAXQcb7EnFrMdFTGTGsiwLavkHVSaRziNCC1
        KOEReCqMtueednd86PjVL2UNHo+0u6vS2nSl/yflhcvDpxdE9fMEiT73GFJ8xnGVir6Fn2
        jYxAw7LfE8zDDShj3W8EwUpsRxB5Cr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623061407;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3yTVmuXnYhofXBlCbo4IT8YVBm6HcKA8wUzVzSayMos=;
        b=aoUH1FPnrcaW8PlQgRV9SfiN0ykK3H1waLliOZoBU+6SYnL4wGcL+HKsSSGu59S1RV0PuO
        jDptSuhc8e/WcgDA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 4EA63118DD;
        Mon,  7 Jun 2021 10:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623061407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3yTVmuXnYhofXBlCbo4IT8YVBm6HcKA8wUzVzSayMos=;
        b=WzFfC+Wgz7EnMtRD06x4fPqve4Fc88iJSnKAXQcb7EnFrMdFTGTGsiwLavkHVSaRziNCC1
        KOEReCqMtueednd86PjVL2UNHo+0u6vS2nSl/yflhcvDpxdE9fMEiT73GFJ8xnGVir6Fn2
        jYxAw7LfE8zDDShj3W8EwUpsRxB5Cr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623061407;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3yTVmuXnYhofXBlCbo4IT8YVBm6HcKA8wUzVzSayMos=;
        b=aoUH1FPnrcaW8PlQgRV9SfiN0ykK3H1waLliOZoBU+6SYnL4wGcL+HKsSSGu59S1RV0PuO
        jDptSuhc8e/WcgDA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id d7jdD5/zvWC2MgAALh3uQQ
        (envelope-from <osalvador@suse.de>); Mon, 07 Jun 2021 10:23:27 +0000
Date:   Mon, 7 Jun 2021 12:23:25 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mm,page_alloc: Use {get,put}_online_mems() to get
 stable zone's values
Message-ID: <20210607102318.GA12683@linux>
References: <20210602091457.17772-1-osalvador@suse.de>
 <20210602091457.17772-2-osalvador@suse.de>
 <39473305-6e91-262d-bcc2-76b745a5b14a@redhat.com>
 <ed17a39ad61edeb19b04c0f4308d5d36@suse.de>
 <YLiVAAsCTR7B6Db9@localhost.localdomain>
 <YLjO2YU2G5fTVB3x@dhcp22.suse.cz>
 <20210604074140.GA25063@linux>
 <20210607075147.GA10554@linux>
 <85984701-55ae-dfa5-2a8d-f637051b612d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85984701-55ae-dfa5-2a8d-f637051b612d@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 10:49:01AM +0200, David Hildenbrand wrote:
> I'd like to point out that I think the seqlock is not in place to
> synchronize with actual growing/shrinking but to get consistent zone ranges
> -- like using atomics, but we have two inter-dependent values here.

I guess so, at least that's what it should do.
But the way it is placed right now is misleading.

If we really want to get consistent zone ranges, we should start using
zone's seqlock where it matters and that is pretty much all those
places that use zone_spans_pfn().
Otherwise there is no way you can be sure the pfn you're checking is
within the limits. Moreover, as Michal pointed out early, if we really
want to go down that road the locking should be made in the caller
evolving the operation, otheriwse things might change once the lock
is dropped and you're working with a wrong assumption.

I can see arguments for both riping it out and doing it right (but none for
the way it is right now).
For riping it out, one could say that those races might not be fatal,
as usually the pfn you're working with (the one you want to check falls
within a certain range) you know is valid, so the worst can happen is
you get false positives/negatives and that might or might not be detected
further down. How bad are false positive/negatives I guess it depends on the
situation, but we already do that right now.
The zone_spans_pfn() from page_outside_zone_boundaries() is the only one using
locking right now, so well, if we survided this long without locks in other places
using zone_spans_pfn() makes one wonder if it is that bad.

On the other hand, one could argue that for correctness sake, we should be holding
zone's seqlock whenever checking for zone_spans_pfn() to avoid any inconsistency.


-- 
Oscar Salvador
SUSE L3
