Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D108397184
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 12:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbhFAKf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 06:35:29 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35172 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhFAKf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 06:35:27 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C22781FD2D;
        Tue,  1 Jun 2021 10:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622543625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VCS921ApL9LSFwrtHBUcyFVnLRi2XXAUivZ2aaWFSGs=;
        b=Tnc5SEPLQ/1zAFkGh34oI2iHhRh4Q2//2eaGnvMBQ2HRlVLnE8/A94f2jyP8ITXlN19gp1
        +21PsMYvprqq4XKIUKQj20+ePF8t+JcljHgaqFJidDU2/FVkvgK9Y1dx5p9OxQuKEZxvVj
        MbLpxpGFQNE0kaMUDtUxo3X9T/SXu+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622543625;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VCS921ApL9LSFwrtHBUcyFVnLRi2XXAUivZ2aaWFSGs=;
        b=j7jPzd4FVhOqJfzyqba8w/fdtwXvlhi9TrNZkDTXimNwP0VI/AFXh/ykOIeXPbahAf7aaF
        JxsLT7tz0P/hkQDQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 3412D118DD;
        Tue,  1 Jun 2021 10:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622543625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VCS921ApL9LSFwrtHBUcyFVnLRi2XXAUivZ2aaWFSGs=;
        b=Tnc5SEPLQ/1zAFkGh34oI2iHhRh4Q2//2eaGnvMBQ2HRlVLnE8/A94f2jyP8ITXlN19gp1
        +21PsMYvprqq4XKIUKQj20+ePF8t+JcljHgaqFJidDU2/FVkvgK9Y1dx5p9OxQuKEZxvVj
        MbLpxpGFQNE0kaMUDtUxo3X9T/SXu+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622543625;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VCS921ApL9LSFwrtHBUcyFVnLRi2XXAUivZ2aaWFSGs=;
        b=j7jPzd4FVhOqJfzyqba8w/fdtwXvlhi9TrNZkDTXimNwP0VI/AFXh/ykOIeXPbahAf7aaF
        JxsLT7tz0P/hkQDQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id LchcCQkNtmAGEwAALh3uQQ
        (envelope-from <osalvador@suse.de>); Tue, 01 Jun 2021 10:33:45 +0000
Date:   Tue, 1 Jun 2021 12:33:43 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm,memory_hotplug: Drop unneeded locking
Message-ID: <20210601103334.GA5927@linux>
References: <20210531093958.15021-1-osalvador@suse.de>
 <679d311a-8ad4-bb53-18f0-11190a2bf1b5@arm.com>
 <20210601074737.GA30768@linux>
 <f655ced2-281e-33ee-e1ea-89a0e13fc7a3@redhat.com>
 <20210601081250.GA32364@linux>
 <YLYCIZ5XNXGoE95p@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLYCIZ5XNXGoE95p@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 11:47:13AM +0200, Michal Hocko wrote:
> While you are touching this and want to drill all the way down then it
> would be reasonable to drop pgdat resize locks as well.
> It is only used in the early boot code and we have one executing thread
> context per numa node during the deferred initialization. I haven't
> checked all potential side effects the lock might have but it sounds
> like there is quite some clean up potential over there.

I am not sure about that. True is that deferred_init_memmap() gets executed
on numa-thread so it's not a problem for itself, but we also have deferred_grow_zone().
It might be that while deferred_init_memmap() is running, we also have calls to
deferred_grow_zone() for the same node and that would cause some trouble wrt.
first_deferred_pfn. I need to double check it, but IIRC, that is the case.


-- 
Oscar Salvador
SUSE L3
