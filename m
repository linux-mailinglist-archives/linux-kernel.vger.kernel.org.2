Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E155456606
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 00:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbhKRXGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 18:06:08 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:38778 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbhKRXGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 18:06:05 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 50AEE212CC;
        Thu, 18 Nov 2021 23:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637276583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0VtH5sIKi/WbgeOAmRZTPkdFqlDqVx/oup6dlz2q7k4=;
        b=pfs+kyZkxQ60Ms5ibpPdnY/Bqak2ru5b9+dL+GA5SIV3OqPehJbo686Pcyx0enWo4EDMa2
        q5uMbShdyAcaz6Dr9gU7tugww6Ev0wiDgFGIjsD2bkNibBGSWsKb1YNcd9kuKaWbbmxIfO
        1HBiOQeFd5wwHvTBRPkSzhMRkgTQ/r0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637276583;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0VtH5sIKi/WbgeOAmRZTPkdFqlDqVx/oup6dlz2q7k4=;
        b=WNWIB8ZG+nPApb7FKizK8J+ry6HYhXw2oF+q8YpT6QtuiIOBfQxv7ypCyYUip6rOF2bgM+
        J/HAg+AphsRRJgAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ECDFA13B11;
        Thu, 18 Nov 2021 23:03:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pvlWKqTblmGoPQAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 18 Nov 2021 23:03:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Mel Gorman" <mgorman@techsingularity.net>
Cc:     "Michal Hocko" <mhocko@suse.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        "Matthew Wilcox" <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, "Mel Gorman" <mgorman@suse.de>
Subject: Re: [PATCH] MM: discard __GFP_ATOMIC
In-reply-to: <20211118132753.GB3366@techsingularity.net>
References: <163712397076.13692.4727608274002939094@noble.neil.brown.name>,
 <YZYbXC/ycmif8WIE@dhcp22.suse.cz>,
 <20211118132753.GB3366@techsingularity.net>
Date:   Fri, 19 Nov 2021 10:02:55 +1100
Message-id: <163727657594.13692.10357464624495712361@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Nov 2021, Mel Gorman wrote:
> On Thu, Nov 18, 2021 at 10:22:36AM +0100, Michal Hocko wrote:
> > [Cc Mel]
> > 
> 
> I think this patch should be ok. There are few direct users of __GFP_HIGH
> and some of them are borderline silly (e.g. mm/shmem.c specifying
> __GFP_HIGH|__GFP_NOMEMALLOC) while others just look questionable (
> drivers/md/raid10.c seems to assume __GFP_HIGH guarantees allocation
> success). Xen appears to be the worst abuser of __GFP_HIGH.

That __GFP_HIGH in raid10.c is passed to mempool_alloc(), so there is no
assumption that __GFP_HIGH will provide guarantees - the mempool does
that.
The comment - which I wrote 4 years ago and don't recall at all -
suggest it was purely about performance - get error handling out of the
way quickly.  I doubt I could justify it if challenged...

Thanks,
NeilBrown


> 
> -- 
> Mel Gorman
> SUSE Labs
> 
> 
