Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A367739F3D1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 12:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhFHKoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 06:44:24 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34852 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbhFHKoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 06:44:23 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A50581FD33;
        Tue,  8 Jun 2021 10:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623148949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JRj2FQZ7QVfqBjtUOD4OpmT+xgtTDURi7+2WAKgq0eU=;
        b=E3ZlrR8iQDx2JYcCOrXRWa75EIdWTDnDbeBIHUaFAHt52VnLDc1z8FYgqUsIXjaHR7pLWR
        MYUYUXgaBEKK567SYoQdfhdylctmO0nO0yQgJhZ1/JfU7/Wd34d9t6hDSIY5r5dgYG9NW4
        T9ivPfvLQPNRUnSaFlNNS817rLI/mFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623148949;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JRj2FQZ7QVfqBjtUOD4OpmT+xgtTDURi7+2WAKgq0eU=;
        b=/iik28C4PXYiFZJpgFdM0e+0XDe3EVfPC4qsUXrgJcTzvN5Lh27kO+aMgfk4NsbLw/8q1y
        KJDmHvPSDgEqx8DA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 20101118DD;
        Tue,  8 Jun 2021 10:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623148949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JRj2FQZ7QVfqBjtUOD4OpmT+xgtTDURi7+2WAKgq0eU=;
        b=E3ZlrR8iQDx2JYcCOrXRWa75EIdWTDnDbeBIHUaFAHt52VnLDc1z8FYgqUsIXjaHR7pLWR
        MYUYUXgaBEKK567SYoQdfhdylctmO0nO0yQgJhZ1/JfU7/Wd34d9t6hDSIY5r5dgYG9NW4
        T9ivPfvLQPNRUnSaFlNNS817rLI/mFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623148949;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JRj2FQZ7QVfqBjtUOD4OpmT+xgtTDURi7+2WAKgq0eU=;
        b=/iik28C4PXYiFZJpgFdM0e+0XDe3EVfPC4qsUXrgJcTzvN5Lh27kO+aMgfk4NsbLw/8q1y
        KJDmHvPSDgEqx8DA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id KEKGBJVJv2BiCQAALh3uQQ
        (envelope-from <osalvador@suse.de>); Tue, 08 Jun 2021 10:42:29 +0000
Date:   Tue, 8 Jun 2021 12:42:27 +0200
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
Message-ID: <20210608104227.GB22894@linux>
References: <20210602091457.17772-1-osalvador@suse.de>
 <20210602091457.17772-2-osalvador@suse.de>
 <39473305-6e91-262d-bcc2-76b745a5b14a@redhat.com>
 <ed17a39ad61edeb19b04c0f4308d5d36@suse.de>
 <YLiVAAsCTR7B6Db9@localhost.localdomain>
 <YLjO2YU2G5fTVB3x@dhcp22.suse.cz>
 <20210604074140.GA25063@linux>
 <20210607075147.GA10554@linux>
 <85984701-55ae-dfa5-2a8d-f637051b612d@redhat.com>
 <20210607102318.GA12683@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607102318.GA12683@linux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 12:23:25PM +0200, Oscar Salvador wrote:
> I can see arguments for both riping it out and doing it right (but none for
> the way it is right now).
> For riping it out, one could say that those races might not be fatal,
> as usually the pfn you're working with (the one you want to check falls
> within a certain range) you know is valid, so the worst can happen is
> you get false positives/negatives and that might or might not be detected
> further down. How bad are false positive/negatives I guess it depends on the
> situation, but we already do that right now.
> The zone_spans_pfn() from page_outside_zone_boundaries() is the only one using
> locking right now, so well, if we survided this long without locks in other places
> using zone_spans_pfn() makes one wonder if it is that bad.

Givne that 

a) all current users of bad_range() are coming from VM_BUG_ON* callers
b) we only care when removing memory as the page would not lie in the
   zone anymore. But for that to happen the whole offline_pages() operation
   needs to succeed. bad_range() is called from rmqueue(), __free_one_page()
   and expand(). If offline_pages() succeeds for the range our page lies on,
   we would not be doing those operations on that page anyway?

So, I cannot find any strong reason to keep the seqlock (maybe in the future
we need to re-add it because some usecase).

Any objection on removing it?


-- 
Oscar Salvador
SUSE L3
