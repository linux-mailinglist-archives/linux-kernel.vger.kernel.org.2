Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1873E2D6E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 17:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244161AbhHFPRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 11:17:17 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59454 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbhHFPRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 11:17:16 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D72CC1FEDC;
        Fri,  6 Aug 2021 15:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628263019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ji7CNaKcKGHeWsie3QdsczqRV/JKE+/AAwQ8IVed0y4=;
        b=OmmOV4/V+3J4IDCgzcpuvnlYwlEPuguUXfMNvgIUO+2EMBszfJw7GJo0j/eBoRSKsEjZSL
        6os1q31ixX3UaAQXJiBQohNbuFos9kPhNdOottXZYPhk9Q62QhZlJ53BSDSOuvMSoOqciT
        anV15cj9aRsrGr5gdsN0DBK8FUwBDBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628263019;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ji7CNaKcKGHeWsie3QdsczqRV/JKE+/AAwQ8IVed0y4=;
        b=VqEyOwMDrK8XCX4Pl4ntewOdtNSWg8cIdbtynH9VJ7IccIi+oxHCJV3vYb5cbl4/MsmHje
        x2G35Cre4yEskxDg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id A815E13A86;
        Fri,  6 Aug 2021 15:16:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id zxRLKGtSDWHMKgAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Fri, 06 Aug 2021 15:16:59 +0000
Subject: Re: [RFC PATCH 12/15] mm: Make MAX_ORDER of buddy allocator
 configurable via Kconfig SET_MAX_ORDER.
To:     Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>,
        linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20210805190253.2795604-1-zi.yan@sent.com>
 <20210805190253.2795604-13-zi.yan@sent.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <1a5c17ac-7f63-6aae-b83b-4438bfa6fe34@suse.cz>
Date:   Fri, 6 Aug 2021 17:16:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210805190253.2795604-13-zi.yan@sent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/21 9:02 PM, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> +config SET_MAX_ORDER
> +	int "Set maximum order of buddy allocator"
> +    depends on SPARSEMEM_VMEMMAP && (ARCH_FORCE_MAX_ORDER = 0)
> +	range 11 255
> +	default "11"
> +	help
> +	  The kernel memory allocator divides physically contiguous memory
> +	  blocks into "zones", where each zone is a power of two number of
> +	  pages.  This option selects the largest power of two that the kernel
> +	  keeps in the memory allocator.  If you need to allocate very large
> +	  blocks of physically contiguous memory, then you may need to
> +	  increase this value.
> +
> +	  This config option is actually maximum order plus one. For example,
> +	  a value of 11 means that the largest free memory block is 2^10 pages.

It's enough that it's confusing for the devs, we could spare the users and add
+1 to the value they specify :)

>  config HAVE_MEMBLOCK_PHYS_MAP
>  	bool
>  
> 

