Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAC13E56DD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 11:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239043AbhHJJ3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 05:29:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46662 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239040AbhHJJ3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 05:29:34 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 818EF2200C;
        Tue, 10 Aug 2021 09:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628587751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DwWkqfGxBvOom/EUoDetOXPBY1+wkqS9nBtbruSLbt4=;
        b=TYkFJqHBrOfHe53WnsCxFqbJQE6pyPpwQsQSI1LmBjRLos7jjopwmlffYUCZmzfasFj2Z2
        125iAHWwdKXsRc098b/Vz1dyuusO9MWyqHPsZ/A8mZl7vEdAPaR7Lr/ucfGa+N/n5v25w3
        NYpg9OL8fowQCe1EG1OOV8zK/bXNSk8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628587751;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DwWkqfGxBvOom/EUoDetOXPBY1+wkqS9nBtbruSLbt4=;
        b=YgPssJJiJoy/SuvrGM9aQ8IpGhhd7He5kyZX1zF6ZkYDFGYHUuX25pVRTrHZ5DUr04WDqJ
        ZRRBQPUsgeqterAg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 7072D13651;
        Tue, 10 Aug 2021 09:29:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id eUcyG+dGEmEAaAAAGKfGzw
        (envelope-from <osalvador@suse.de>); Tue, 10 Aug 2021 09:29:11 +0000
MIME-Version: 1.0
Date:   Tue, 10 Aug 2021 11:29:11 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/3] hugetlb: simplify prep_compound_gigantic_page ref
 count racing code
In-Reply-To: <20210809184832.18342-2-mike.kravetz@oracle.com>
References: <20210809184832.18342-1-mike.kravetz@oracle.com>
 <20210809184832.18342-2-mike.kravetz@oracle.com>
User-Agent: Roundcube Webmail
Message-ID: <19f47b787269b95bb76d81bb1e6bfcc3@suse.de>
X-Sender: osalvador@suse.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-09 20:48, Mike Kravetz wrote:
> Code in prep_compound_gigantic_page waits for a rcu grace period if it
> notices a temporarily inflated ref count on a tail page.  This was due
> to the identified potential race with speculative page cache references
> which could only last for a rcu grace period.  This is overly 
> complicated
> as this situation is VERY unlikely to ever happen.  Instead, just 
> quickly
> return an error.
> Also, only print a warning in prep_compound_gigantic_page instead of
> multiple callers.

The above makes sense to me.
My only question would be: gather_bootmem_prealloc() is an __init 
function.
Can we have speculative refcounts due to e.g: pagecache at that early 
stage?
I think we cannot, but I am not really sure.

We might be able to remove that else() in case we cannot have such 
scenarios.


-- 
Oscar Salvador
SUSE L3
