Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C2D457D32
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 11:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbhKTKye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 05:54:34 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52586 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbhKTKya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 05:54:30 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A43AC212FE;
        Sat, 20 Nov 2021 10:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637405486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K+GB/CdpNy8QCOlyFUHjNcjIKEB48INlMQfN4qYeNAg=;
        b=e+x03XQRvMs3kJnZfNfvUvyqaYvtvQhAGt017bMtE352ZiKVAmNb5AUmv1sS1N29E+GubG
        qRy6CEDyir7YZVEVyr3+EHWhl9nVGxHlkh4v5TEocvRQ4n+4NVDXDI69nHLADfJbyPxou7
        9wQaSXNbB+5N5w1wkjAHd3Zl38X9mXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637405486;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K+GB/CdpNy8QCOlyFUHjNcjIKEB48INlMQfN4qYeNAg=;
        b=GomcICTbWLUej1uFRGAHpIEy+v4Pske1JQfeknwJMcK2Ui0CiDYS9Hh1q7awBZGFWTdzDx
        lR4CBwH5xUx5iTDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B840713B16;
        Sat, 20 Nov 2021 10:51:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id x9ifHSzTmGFIdwAAMHmgww
        (envelope-from <neilb@suse.de>); Sat, 20 Nov 2021 10:51:24 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Matthew Wilcox" <willy@infradead.org>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Michal Hocko" <mhocko@suse.com>,
        "Thierry Reding" <thierry.reding@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MM: discard __GFP_ATOMIC
In-reply-to: <YZewStgII83phKtA@casper.infradead.org>
References: <163712397076.13692.4727608274002939094@noble.neil.brown.name>,
 <YZUBIbALcSHn4Rub@casper.infradead.org>,
 <163727727803.13692.15470049610672496362@noble.neil.brown.name>,
 <YZewStgII83phKtA@casper.infradead.org>
Date:   Sat, 20 Nov 2021 21:51:20 +1100
Message-id: <163740548025.13692.6428652897557849182@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Nov 2021, Matthew Wilcox wrote:
> On Fri, Nov 19, 2021 at 10:14:38AM +1100, NeilBrown wrote:
> > On Thu, 18 Nov 2021, Matthew Wilcox wrote:
> > > Surely this should be gfpflags_allow_blocking() instead of poking about
> > > in the innards of gfp flags?
> > 
> > Possibly.  Didn't know about gfpflags_allow_blocking().  From a quick
> > grep in the kernel, a whole lot of other people don't know about it
> > either, though clearly some do.
> > 
> > Maybe we should reaname "__GFP_DIRECT_RECLAIM" to
> > "__GFP_ALLOW_BLOCKING", because that is what most users seems to care
> > about.
> 
> I tend towards the school of thought that the __GFP flags should make
> sense to the implementation and users should use either GFP_ or functions.
> When we see users adding or subtracting __GFP flags, that's a problem.

Except __GFP_NOWARN of course, or __GFP_ZERO, or __GFP_NOFAIL.
What about __GFP_HIGHMEM?  __GFP_DMA?  __GFP_HIGH?

They all seem to be quite meaningful to the caller - explicitly
specifying properties of the memory or properties of the service.
(But maybe you would prefer __GFP_HIGH be spelled "__GFP_LOW_WATERMARK"
so it would make more sense to the implementation).

__GFP_DIRECTRECLAIM seems to me to be more the exception than the rule -
specifying internal implementation details.

Actually ... I take it back about __GFP_NOWARN.  That probably shouldn't
exist at all.  Warnings should be based on how stressed the mm system is,
not on whether the caller wants thinks failure is manageable.

NeilBrown
