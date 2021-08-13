Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4513EB6FF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 16:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240884AbhHMOty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 10:49:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50930 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240795AbhHMOtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 10:49:52 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 895F7201E3;
        Fri, 13 Aug 2021 14:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628866164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wKIBL6uzh4EsJDLzBlrYYCv5BAAf1ULSfw0Ye7yXh+E=;
        b=znMpGiD4YTnMv4no2yvn/2VZro+VgcU88XkoSvPX84QBF3k0mtf42UF9Lu5dqQ+/yKOve8
        RVNUD/HYcolixkPWGMSgIXVBD26/BJtGvpLZTx6a1/lWhDdTusWj81R70VjFJDUNlK0KTu
        /J5C5Synl/7aM5bKo4h0Q98znqy2jeU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628866164;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wKIBL6uzh4EsJDLzBlrYYCv5BAAf1ULSfw0Ye7yXh+E=;
        b=OaAG8lbJbxHrF2Tc9jC2WcIV8UkuHJyin6SXiWeiCCb/VSGf6QGj9qsNfmJnaAYu10+Rzo
        q+ji4KzaP8km3SDg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id BAF9C13806;
        Fri, 13 Aug 2021 14:49:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id WvJhK3OGFmGjEAAAGKfGzw
        (envelope-from <jroedel@suse.de>); Fri, 13 Aug 2021 14:49:23 +0000
Date:   Fri, 13 Aug 2021 16:49:22 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
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
Message-ID: <YRaGch+D5HPtUk9l@suse.de>
References: <20210810062626.1012-1-kirill.shutemov@linux.intel.com>
 <20210810062626.1012-2-kirill.shutemov@linux.intel.com>
 <d091b333-9ef8-ac32-58c5-c325d29f26d7@intel.com>
 <9748c07c-4e59-89d0-f425-c57f778d1b42@linux.intel.com>
 <17b6a3a3-bd7d-f57e-8762-96258b16247a@intel.com>
 <796a4b20-7fa3-3086-efa0-2f728f35ae06@linux.intel.com>
 <f445da8b-c044-3765-65f2-f911dbf6a507@intel.com>
 <3caf5e73-c104-0057-680c-7851476e67ac@linux.intel.com>
 <YRTZr/Pxyb8fsV58@suse.de>
 <25312492-5d67-e5b0-1a51-b6880f45a550@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25312492-5d67-e5b0-1a51-b6880f45a550@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Thu, Aug 12, 2021 at 07:14:20AM -0700, Dave Hansen wrote:
> maybe_accept_page()
> {
> 	unsigned long huge_pfn = page_to_phys(page) / PMD_SIZE;
> 
> 	/* Test the bit before taking any locks: */
> 	if (test_bit(huge_pfn, &accepted_bitmap))
> 		return;
> 
> 	spin_lock_irq();
> 	/* Retest inside the lock: */
> 	if (test_bit(huge_pfn, &accepted_bitmap))
> 		return;
> 	tdx_accept_page(page, PMD_SIZE);
> 	set_bit(huge_pfn, &accepted_bitmap));
> 	spin_unlock_irq();
> }

Yeah, this could work, but the global lock is likely the show-stopper
here. For SNP we also not allowed to double-validate, so we need
something that basically indicates 'validation-is-ongoing' on a per 2MB
basis.

I am not an mm expert, but a page flag probably doesn't work. The flag
would be on the head of the 2MB range and when that page is already used
somewhere else there is no guarantee that the flag will survive. But
correct me if I am wrong here :)

The other options I can come up with are not great either:

	1) using an AVL bit in the direct-mapping PMD of that page. The
	   page-table would only be walked if the bit in the
	   accept_bitmap is clear. But I am not sure that all memory
	   which needs to be validated is in the direct-map.

	2) Use another page-sized bitmap. If the machine has more than
	   64GB of memory the bit index is wrapped around. This
	   shouldn't be a performance problem at runtime, if this page
	   is only consulted when the valid bit is clear in the
	   accept_bitmap.

MM experts could certainly come up with better ideas :)

> Yeah, I think the *canonical* source of information for accepts is the
> bitmap.  The page flags and any static keys or whatever are
> less-canonical sources that tell you when you _might_ need to consult
> the bitmap.

Right, it also helps the kexec case. The only problem left is how to
track 4kb shared pages for things like the GHCB.

Regards,

	Joerg
