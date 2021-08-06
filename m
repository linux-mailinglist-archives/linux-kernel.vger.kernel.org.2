Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C7F3E2E55
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 18:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbhHFQdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 12:33:10 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45578 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbhHFQdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 12:33:08 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BE9D1223F7;
        Fri,  6 Aug 2021 16:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628267571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iPNej9lFt6dK2k5I9jgpntfFoN7CqbJ2BOa04lX6Q+8=;
        b=wxWDlSJ21OYZs7EoTl7cXt2y5V9xHzSEvWrzFOGTI7YcsJhNZK7ENk25Y+jvyw3sknO7z6
        zgmpvIsZVucZM9cB7ULQqd2lmIO/zoSKlBZHjPAMj7wIzFxL/ivSS00H5fmPfHk/Gy/4zT
        hvOt/iqdSKLUA2QNWFsKIlkSwO7yCLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628267571;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iPNej9lFt6dK2k5I9jgpntfFoN7CqbJ2BOa04lX6Q+8=;
        b=WhoOmzvyvfhoS3zCSaKGc41C3UthceVWf4sqy3TTVdMZNyEd3t2T5EFKfSdtOZLO0y7VM1
        H5/1UsX7Uw4KAjCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 943CB13A96;
        Fri,  6 Aug 2021 16:32:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gVJJIzNkDWFBaAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 06 Aug 2021 16:32:51 +0000
Subject: Re: [RFC PATCH 00/15] Make MAX_ORDER adjustable as a kernel boot time
 parameter.
To:     Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>,
        linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org
References: <20210805190253.2795604-1-zi.yan@sent.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <0d374eed-cc52-a656-b338-1156782bdf7e@suse.cz>
Date:   Fri, 6 Aug 2021 18:32:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210805190253.2795604-1-zi.yan@sent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/21 9:02 PM, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Hi all,
> 
> This patchset add support for kernel boot time adjustable MAX_ORDER, so that
> user can change the largest size of pages obtained from buddy allocator. It also
> removes the restriction on MAX_ORDER based on SECTION_SIZE_BITS, so that
> buddy allocator can merge PFNs across memory sections when SPARSEMEM_VMEMMAP is
> set. It is on top of v5.14-rc4-mmotm-2021-08-02-18-51.
> 
> Motivation
> ===
> 
> This enables kernel to allocate 1GB pages and is necessary for my ongoing work
> on adding support for 1GB PUD THP[1]. This is also the conclusion I came up with
> after some discussion with David Hildenbrand on what methods should be used for
> allocating gigantic pages[2], since other approaches like using CMA allocator or
> alloc_contig_pages() are regarded as suboptimal.

I see references [1] [2] etc but no list of links at the end, did you
forgot to include?
