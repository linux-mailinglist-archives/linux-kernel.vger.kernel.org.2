Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F693FCBD1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 18:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240331AbhHaQw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 12:52:28 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43258 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240264AbhHaQwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 12:52:24 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 07A9E222C7;
        Tue, 31 Aug 2021 16:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630428684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OklJGxSi0BbSbVaTpes0b4IBJRwo4fxs/JZP6qZD18I=;
        b=2NTsRNKLu2TQozUQFmb6kqQ9YjVWwPKjLGyEAfxXNEYB0RR7tM/+K0AkfN6iXnz2hfqHgm
        nch9cMtAgEfKADPOR62XhxwPLOQP9dzu4PsOMfI4Z8SZVJyDpAGY8uCc3j2JQmL6c0mrSk
        yT08R6avt4HbpqNBC3fJZGRLwdSeyFU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630428684;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OklJGxSi0BbSbVaTpes0b4IBJRwo4fxs/JZP6qZD18I=;
        b=EIsWg9jYEpTYgfPXmleG5avQ8CrvUU7pNqWnnrqeSwUnluIZh+gDBSR8+aU2n8WXCR1tvU
        vwfa5eC2gRYRTdDg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id DF851131F5;
        Tue, 31 Aug 2021 16:51:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id xnt/NQteLmGSXQAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Tue, 31 Aug 2021 16:51:23 +0000
Message-ID: <11357114-eb6e-39a6-b16d-5e380f770943@suse.cz>
Date:   Tue, 31 Aug 2021 18:51:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: Stuck looping on list_empty(list) in free_pcppages_bulk()
Content-Language: en-US
To:     Sultan Alsawaf <sultan@kerneltoast.com>, linux-mm@kvack.org
Cc:     mhocko@suse.com, mgorman@techsingularity.net,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
References: <YS1l83lmwEYXuQsY@sultan-box.localdomain>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <YS1l83lmwEYXuQsY@sultan-box.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/21 01:12, Sultan Alsawaf wrote:
> With some more gdb digging, I found that the `count` variable was stored in %ESI
> at the time of the stall. According to register dump in the splat, %ESI was 7.
> 
> It looks like, for some reason, the pcp count was 7 higher than the number of
> pages actually present in the pcp lists.
> 
> I tried to find some way that this could happen, but the only thing I could
> think of was that maybe an allocation had both __GFP_RECLAIMABLE and
> __GFP_MOVABLE set in its gfp mask, in which case the rmqueue() call in
> get_page_from_freelist() would pass in a migratetype equal to MIGRATE_PCPTYPES
> and then pages could be added to an out-of-bounds pcp list while still
> incrementing the overall pcp count. This seems pretty unlikely though. As
> another side note, it looks like there's nothing stopping this from occurring;
> there's only a VM_WARN_ON() in gfp_migratetype() that checks if both bits are
> set.
> 
> Any ideas on what may have happened here, or a link to a commit that may have
> fixed this issue in newer kernels, would be much appreciated.

Does the kernel have commit 88e8ac11d2ea3 backported? If not, and there were
memory hotplug operations happening, the infinite loop could happen. If that
commit was not backported, and instead 5c3ad2eb7104 was backported, possibly
there are more scenarios outside hotplug that can cause trouble.

> Thanks,
> Sultan
> 

