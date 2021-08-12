Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED653EAC59
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 23:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236454AbhHLVX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 17:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbhHLVX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 17:23:28 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE1FC061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 14:23:02 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id y34so15978542lfa.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 14:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tjnLas4N38VG1m6ngVp/nKbMad+Le5jniGEKC9/f/AI=;
        b=MXWrG/3xOqi8ily+EcD8UFrv2cZ8HoPYEmzUwkZbpnFCeK+N47Cjkha3j17KWz05OK
         vX85Imq1+eOG78/hrTPhFMyiZo1Z6Q9/o9u//bsnP+/iHJzd3p1GJDZNkSxrT5N2oTSG
         0v4LnzMXGTQ7jjGPeDkS9fCH/g+jx/cREcHkqxls1i229tBc9Cp1NHXlJLjS5wz4thod
         T7rDsNFGvhoqvMkkVV0Fc/wpEjKXFq/AXYy+n5sfA3TJbdOueGjS8HrovJyUj0uMh4Rl
         wJ6gC0hmGy+SprZa44Dh2+EcOGJwgInuv5WBpbR9URukxBOKnkVuhTDd0MIyvVmnI7Nn
         O0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tjnLas4N38VG1m6ngVp/nKbMad+Le5jniGEKC9/f/AI=;
        b=DSzqigyRDAND/sZ8+bp273KJ/f4xYjMZ4B0kyKtSziiwjebx6zJTTI/0LmpVZpRDSz
         WuC76C9Bn9fi7Y3WTwYZzvUJYAfl/aWaU4ThIWEKt8gHXjsM9x6jdSeW0ysR3aCFICK8
         SYDUDLeaOmNhdxmv4gXU/0SFTIERm069v2EEfgMDMecYLNyL2cA0P/c+006NFum1YbpG
         3FCYxNtyb5mx/eNSnywQ8soP1dDmUKn1JTyzGd2JX51KBZ+f3ZSz2Ij4GT3nx2Fq+pIz
         auo0WmRm/5BIdAbSyT2/q/lb4SVN1nD9XJtTP3QGc0aCykH0Paou7kBFM/wvtcic5fol
         J26w==
X-Gm-Message-State: AOAM530pwObIjNVGelSdonsrDz/YAUM7V/IndQrw8gm3b38SBwj9WEUd
        PYSgwNXaCpPKM/pzLHeXxjdPCA==
X-Google-Smtp-Source: ABdhPJz/anlsUnp0mfpy0EkAT/Lpv+5EMg5m7i7pyxjTOplUpJrzrf3oaG3AcLuJz3F89935FLlydw==
X-Received: by 2002:ac2:5fee:: with SMTP id s14mr3897521lfg.646.1628803380918;
        Thu, 12 Aug 2021 14:23:00 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id o16sm372463lfl.309.2021.08.12.14.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 14:23:00 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 1BF2C102BEE; Fri, 13 Aug 2021 00:23:14 +0300 (+03)
Date:   Fri, 13 Aug 2021 00:23:14 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Joerg Roedel <jroedel@suse.de>, Andi Kleen <ak@linux.intel.com>,
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
Message-ID: <20210812212314.4fkrmzebluyl3umo@box.shutemov.name>
References: <d091b333-9ef8-ac32-58c5-c325d29f26d7@intel.com>
 <9748c07c-4e59-89d0-f425-c57f778d1b42@linux.intel.com>
 <17b6a3a3-bd7d-f57e-8762-96258b16247a@intel.com>
 <796a4b20-7fa3-3086-efa0-2f728f35ae06@linux.intel.com>
 <f445da8b-c044-3765-65f2-f911dbf6a507@intel.com>
 <3caf5e73-c104-0057-680c-7851476e67ac@linux.intel.com>
 <YRTZr/Pxyb8fsV58@suse.de>
 <25312492-5d67-e5b0-1a51-b6880f45a550@intel.com>
 <20210812204924.haneuxapkmluli6t@box.shutemov.name>
 <708c758f-2305-4fe6-ddcd-6881794402a5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <708c758f-2305-4fe6-ddcd-6881794402a5@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 01:59:01PM -0700, Dave Hansen wrote:
> On 8/12/21 1:49 PM, Kirill A. Shutemov wrote:
> > On Thu, Aug 12, 2021 at 07:14:20AM -0700, Dave Hansen wrote:
> >> On 8/12/21 1:19 AM, Joerg Roedel wrote:
> >> maybe_accept_page()
> >> {
> >> 	unsigned long huge_pfn = page_to_phys(page) / PMD_SIZE;
> >>
> >> 	/* Test the bit before taking any locks: */
> >> 	if (test_bit(huge_pfn, &accepted_bitmap))
> >> 		return;
> >>
> >> 	spin_lock_irq();
> >> 	/* Retest inside the lock: */
> >> 	if (test_bit(huge_pfn, &accepted_bitmap))
> >> 		return;
> >> 	tdx_accept_page(page, PMD_SIZE);
> >> 	set_bit(huge_pfn, &accepted_bitmap));
> >> 	spin_unlock_irq();
> >> }
> >>
> >> That's still not great.  It's still a global lock and the lock is still
> >> held for quite a while because that accept isn't going to be lightning
> >> fast.  But, at least it's not holding any *other* locks.  It also
> >> doesn't take any locks in the fast path where the 2MB page was already
> >> accepted.
> > 
> > I expect a cache line with bitmap to bounce around during warm up. One
> > cache line covers a gig of RAM.
> 
> The bitmap bouncing around isn't going to really matter when you have a
> global lock protecting it from writes.

The idea with static key would not work if we mark shared memory as
unaccepted there.

> > It's also not clear at all at what point the static key has to be
> > switched. We don't have any obvious point where we can say we are done
> > with accepting (unless you advocate for proactive accepting).
> 
> Two easy options:
> 1. Run over the bitmap and counts the bits left.  That can be done
>    outside the lock even.
> 2. Keep a counter of the number of bits set in the bitmap.
> 
> > I like PageOffline() because we only need to consult the cache page
> > allocator already have in hands before looking into bitmap.
> 
> I like it too.  But, it's really nasty if the value is only valid deep
> in the allocator.
> 
> We could keep the PageOffline() thing and then move it to some other
> field in 'struct page' that's only valid between ClearPageOffline() and
> prep_new_page().   Some magic value that says: "This page has not yet
> been accepted, you better check the bitmap."  Something like:
> 
> 	if (TestClearPageOffline(page))
> 		page->private = 0Xdeadbeef;
> 
> and then check page->private in prep_new_page(). There should be plenty
> of 'struct page' space to hijack in that small window.

PageOffline() encoded in mapcount and check_new_page_bad() would complain
is mapcount is not -1.

> BTW, I was going to actually try and hack something up, but I got
> annoyed that your patches don't apply upstream and gave up.  A git tree
> with all of the dependencies would be nice. <hint, hint>

Okay.

-- 
 Kirill A. Shutemov
