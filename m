Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8163EA07A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 10:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbhHLIUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 04:20:39 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54110 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234086AbhHLIUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 04:20:30 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CA93E1FF1F;
        Thu, 12 Aug 2021 08:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628756401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+nfS8qOmyfIYA2Mf0aXHVt9ATNP8lz9AMeYrHpMK/5s=;
        b=ts3pYMzUQcqW0Gkjtx/WWY4ScRfH6uEO1D1ScsIYDXqU08PDeiGoi3wZ+TYWnjaUNXMZnt
        9nJxXhDbxc/aDjU0st2scpFDc1JlMpQTEN1WW9haG84zo5mWpLmUMfJnp75AiN60JJaFCj
        7fTvQa9gvRrgzyU2MDL0IEhHeeUhO3M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628756401;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+nfS8qOmyfIYA2Mf0aXHVt9ATNP8lz9AMeYrHpMK/5s=;
        b=rx07iiQdwqQZKFzKHGNSz061RUNeiXz+xircouhbBQ40fgNk+wU+puXtI49WOq3zRQLUQ4
        k3+SW73FBj9csdBQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id F379413846;
        Thu, 12 Aug 2021 08:20:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id FHKcObDZFGGaCQAAGKfGzw
        (envelope-from <jroedel@suse.de>); Thu, 12 Aug 2021 08:20:00 +0000
Date:   Thu, 12 Aug 2021 10:19:59 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 1/5] mm: Add support for unaccepted memory
Message-ID: <YRTZr/Pxyb8fsV58@suse.de>
References: <20210810062626.1012-1-kirill.shutemov@linux.intel.com>
 <20210810062626.1012-2-kirill.shutemov@linux.intel.com>
 <d091b333-9ef8-ac32-58c5-c325d29f26d7@intel.com>
 <9748c07c-4e59-89d0-f425-c57f778d1b42@linux.intel.com>
 <17b6a3a3-bd7d-f57e-8762-96258b16247a@intel.com>
 <796a4b20-7fa3-3086-efa0-2f728f35ae06@linux.intel.com>
 <f445da8b-c044-3765-65f2-f911dbf6a507@intel.com>
 <3caf5e73-c104-0057-680c-7851476e67ac@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3caf5e73-c104-0057-680c-7851476e67ac@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 02:20:08PM -0700, Andi Kleen wrote:
> Also I agree with your suggestion that we should get the slow path out of
> the zone locks/interrupt disable region. That should be easy enough and is
> an obvious improvement.

I also agree that the slow-path needs to be outside of the memory
allocator locks. But I think this conflicts with the concept of
accepting memory in 2MB chunks even if allocation size is smaller.

Given some kernel code allocated 2 pages and the allocator path starts
to validate the whole 2MB page the memory is on, then there are
potential races to take into account.

Either some other code path allocates memory from that page and returns
it before validation is finished or we end up with double validation.
Returning unvalidated memory is a guest-problem and double validation
will cause security issues for SNP guests.

Regards,

	Joerg
