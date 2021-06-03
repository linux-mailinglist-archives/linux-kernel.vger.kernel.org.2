Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4343399CB5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 10:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhFCIkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 04:40:13 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38908 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCIkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 04:40:11 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DC0091FD4D;
        Thu,  3 Jun 2021 08:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622709506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zt2fjzTinBjC64Cl7tJnOBqSXBywln5vqKhFtXBD5pc=;
        b=Sn1/9hQHmHfPpCwhNXwfIj5VyyYze0wc5ZHI8qH9rhEe0vlhSqPaLcNNhfcSDtu6myAow+
        Qc2o6x1ShjuGukUAzGoPrSUerMeqEy0tN5znm3UCPwNnkGgWZS3vQTedwfRf4jBEpzyxW8
        CE2TkYX9SxoJtnUcNHuTYhOB7uLaxgo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622709506;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zt2fjzTinBjC64Cl7tJnOBqSXBywln5vqKhFtXBD5pc=;
        b=vWMRHpufxPiPK2KZIdZBeBikX5sTr8Wu9dGaLDno5+njY429b3f9TzrkuxUjcapw1/D1TS
        rbgWfnnu5gxcf3BQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 3587C118DD;
        Thu,  3 Jun 2021 08:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622709506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zt2fjzTinBjC64Cl7tJnOBqSXBywln5vqKhFtXBD5pc=;
        b=Sn1/9hQHmHfPpCwhNXwfIj5VyyYze0wc5ZHI8qH9rhEe0vlhSqPaLcNNhfcSDtu6myAow+
        Qc2o6x1ShjuGukUAzGoPrSUerMeqEy0tN5znm3UCPwNnkGgWZS3vQTedwfRf4jBEpzyxW8
        CE2TkYX9SxoJtnUcNHuTYhOB7uLaxgo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622709506;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zt2fjzTinBjC64Cl7tJnOBqSXBywln5vqKhFtXBD5pc=;
        b=vWMRHpufxPiPK2KZIdZBeBikX5sTr8Wu9dGaLDno5+njY429b3f9TzrkuxUjcapw1/D1TS
        rbgWfnnu5gxcf3BQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id BgSbCQKVuGAQMwAALh3uQQ
        (envelope-from <osalvador@suse.de>); Thu, 03 Jun 2021 08:38:26 +0000
Date:   Thu, 3 Jun 2021 10:38:24 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mm,page_alloc: Use {get,put}_online_mems() to get
 stable zone's values
Message-ID: <YLiVAAsCTR7B6Db9@localhost.localdomain>
References: <20210602091457.17772-1-osalvador@suse.de>
 <20210602091457.17772-2-osalvador@suse.de>
 <39473305-6e91-262d-bcc2-76b745a5b14a@redhat.com>
 <ed17a39ad61edeb19b04c0f4308d5d36@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed17a39ad61edeb19b04c0f4308d5d36@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 09:45:58PM +0200, Oscar Salvador wrote:
> It was too nice and easy to be true I guess.
> Yeah, I missed the point that blocking might be an issue here, and hotplug
> operations can take really long, so not an option.
> I must have switched my brain off back there, because now it is just too
> obvious.
> 
> Then I guwmess that seqlock must stay and the only thing than can go is the
> pgdat resize lock from the hotplug code.

So, I have been looking into this again.
Of course, the approach taken here is outrageously wrong, but there are
some other things that are a bit confusing.

As pointed out, bad_range() (the function that ends up calling
page_outside_zone_boundaries) is called from different functions via VM_BUG_ON_*.
page_outside_zone_boundaries() takes care of taking the seqlock to avoid
reading stale values that might happen if we race with memhotplug
operations.
page_outside_zone_boundaries() calls zone_spans_pfn() to check that.
 
Now on the funny thing.

We do have several places happily calling zone_spans_pfn() without
holding zone's seqlock, e.g:

set_pageblock_migratetype
 set_pfnblock_flags_mask
  zone_spans_pfn

move_freepages_block
 zone_spans_pfn

alloc_contig_pages
 zone_spans_last_pfn
  zone_spans_pfn

Those places hold zone->lock, while move_pfn_range_to_zone() and
remove_pfn_range_from_zone() hold zone->seqlock, so AFAICS, those places
could read a stale value and proceed thinking the range is within the
zone while it is not.

So I guess my question is, should we force those places to take the
seqlock reader as we do in page_outside_zone_boundaries(), (or maybe
just move the seqlock handling to zone_spans_pfn())?

Because I does not make much sense to take it in a VM_DEBUG context and
not in "real life".

Thoughts?

-- 
Oscar Salvador
SUSE L3
