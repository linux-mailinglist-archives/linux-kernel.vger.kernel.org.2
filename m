Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131D83F16C6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 11:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237857AbhHSJzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 05:55:48 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39682 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhHSJzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 05:55:47 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3A63E200B8;
        Thu, 19 Aug 2021 09:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629366910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pBx7UvjXszKNzjrsiqHLkrPggQDMMUiJVYYt4I/aFBY=;
        b=Gb3P5uQsliDPSyaSdPwt9DDA/+NZsn8pb8lq88jTIZv9/3O282MkGBKjMJd02MfQAmRiux
        80YRH5jd6dF9pnmUxVfjcUCM9qYttgOcCAPatQS1HNpTDeChF5LVaQitWdRtlPCjp6h+e5
        GG1YL5EYBriHTJE6nc5LgGgpfQypIlw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629366910;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pBx7UvjXszKNzjrsiqHLkrPggQDMMUiJVYYt4I/aFBY=;
        b=ZTvPUcKZrNXECsQm0diB42W33txsl3l+81DrtzSPnII0dabhm0Flu3KcbMI2L+aqhwYkvs
        c7v2zmNCoxx6QICg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 6602F1389C;
        Thu, 19 Aug 2021 09:55:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id iY8kF30qHmGZNAAAGKfGzw
        (envelope-from <jroedel@suse.de>); Thu, 19 Aug 2021 09:55:09 +0000
Date:   Thu, 19 Aug 2021 11:55:07 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
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
Message-ID: <YR4qexszQ+Wxqe5r@suse.de>
References: <d091b333-9ef8-ac32-58c5-c325d29f26d7@intel.com>
 <9748c07c-4e59-89d0-f425-c57f778d1b42@linux.intel.com>
 <17b6a3a3-bd7d-f57e-8762-96258b16247a@intel.com>
 <796a4b20-7fa3-3086-efa0-2f728f35ae06@linux.intel.com>
 <f445da8b-c044-3765-65f2-f911dbf6a507@intel.com>
 <3caf5e73-c104-0057-680c-7851476e67ac@linux.intel.com>
 <YRTZr/Pxyb8fsV58@suse.de>
 <25312492-5d67-e5b0-1a51-b6880f45a550@intel.com>
 <YRaGch+D5HPtUk9l@suse.de>
 <b0228048-d2c2-6081-cfae-147e17acf785@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0228048-d2c2-6081-cfae-147e17acf785@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Tue, Aug 17, 2021 at 05:00:55PM +0200, David Hildenbrand wrote:
> Not sure if already discussed, but what about making sure that free pages
> are not a mixture (partially unaccepted, partially accepted).
> 
> You'd have to expose the pages in that granularity to the buddy
> (__free_pages_core), indicating the state. You'd have to reject merging
> pages of differing acceptance state.
> 
> Accepting a page would then be handled outside of the zone lock, completely
> controlled by the state.
> 
> So a page in the buddy would either be completely accepted or completely
> unaccepted, signaled e.g., by PageOffline().
> 
> Consequently, when allocating a 4KiB page, you'd split an unaccepted 2MiB
> page into separate unaccepted pages. You'd grab one of the unaccepted 4KiB
> pages and accept it before initializing it and handing it out.

Yes, that is the alternative to over-accepting memory on allocation. But
the problem here is that accepting/validating memory is an expensive
operation which also requires a hypercall. The hypercalls on SNP and TDX
can accept/validate multiple pages in one call. So the recommendation is
to accept memory in bigger chunks, like the 2MB that have been proposed.

Only accepting memory in allocation size might be too slow, as there is
a lot of code doing order-0 allocations. I think this approach will also
be more intrusive to the page alloctor, as it needs more changes on the
free path to check for acceptance states before pages can be merged.

Regards,

	Joerg
