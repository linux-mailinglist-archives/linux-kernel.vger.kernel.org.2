Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6493EB725
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 16:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240933AbhHMO5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 10:57:20 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44268 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240198AbhHMO5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 10:57:19 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3D0162230F;
        Fri, 13 Aug 2021 14:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628866611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=slEidIfXYzT+MiWaqkcgYapT9R1n6p0OzdWrLkn7fh8=;
        b=tBfPzpWLMjXvhI46J2x162VjLl+kTSZN4cLJ9uYOPJk5FPcwdodpsOWl1oj/jonBLpysSj
        NR785d26AY9tuAeectH8uJiys1iH6W8B7sdJarOSUie381hL/jI1Mo6kyInegunIy4rmFy
        yupU5fDVOjnbr1lpJzYzoSukAEH4LNk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628866611;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=slEidIfXYzT+MiWaqkcgYapT9R1n6p0OzdWrLkn7fh8=;
        b=oCXQ5TfJrh/zLZ4Sfhl9AAyIFKDObOf5SItYpDdLewpJA3EjX5vJhs4ZQ4s71zir3VL2HO
        yOPDAJ6/VvFmu5Bg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 7F7B613806;
        Fri, 13 Aug 2021 14:56:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id gNxDHTKIFmEeEgAAGKfGzw
        (envelope-from <jroedel@suse.de>); Fri, 13 Aug 2021 14:56:50 +0000
Date:   Fri, 13 Aug 2021 16:56:48 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Andi Kleen <ak@linux.intel.com>, Borislav Petkov <bp@alien8.de>,
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
Subject: Re: [PATCH 0/5] x86: Impplement support for unaccepted memory
Message-ID: <YRaIMEp/mTLbt++E@suse.de>
References: <20210810062626.1012-1-kirill.shutemov@linux.intel.com>
 <YRTafEovVZme+KO9@suse.de>
 <20210812101054.5y6oufwwnisebuyy@box.shutemov.name>
 <e72e34b5-a232-6dc9-0cdb-cc8c97783772@linux.intel.com>
 <20210812202251.hn3c2xykm2l73avu@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812202251.hn3c2xykm2l73avu@box.shutemov.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 11:22:51PM +0300, Kirill A. Shutemov wrote:
> On Thu, Aug 12, 2021 at 12:33:11PM -0700, Andi Kleen wrote:
> > I think Joerg's question was if TDX has a single ABI for all hypervisors.
> > The GHCI specification supports both hypervisor specific and hypervisor
> > agnostic calls. But these basic operations like MapGPA are all hypervisor
> > agnostic. The only differences would be in the existing hypervisor specific
> > PV code.
> 
> My point was that TDX and SEV-SNP going to be different and we need a way
> to hook the right protocol for each.

Yeah, okay, thanks for the clarification. My misunderstanding was that
there could be per-hypervisor contract on what memory is pre-accepted
and what Linux is responsible for.

Thanks,

	Joerg

