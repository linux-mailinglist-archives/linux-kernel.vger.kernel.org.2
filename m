Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089913EA080
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 10:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235151AbhHLIXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 04:23:53 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54408 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbhHLIXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 04:23:52 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 56D001FF24;
        Thu, 12 Aug 2021 08:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628756606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K0sWd4XF5gYrJXMfRCAZ1I8sRxNvH4LQv37GKuMjJqs=;
        b=iVqEptSjzV5jxHxI/EDSlbiT5MDvtCWcxDf6PhBDq+KxVXarHrYzXPNcpg2GgTjmLzrJng
        EBncewPNBLsabigP19LcNsC7P72eZhAqPPFuAVVsRfIqgkgI5dArUg3hrQG49BKqLeSicc
        jvURfQjBsyYb4cnny7CTFHNLHVuDm64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628756606;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K0sWd4XF5gYrJXMfRCAZ1I8sRxNvH4LQv37GKuMjJqs=;
        b=1oalMp/6u497s5dGXi9jIQCd1LsTuwGfDIEBGClAqPxozxNxWNad6CFZulKrj7M/CyacbC
        plIOY0ZPeJri96CQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 94F2A13846;
        Thu, 12 Aug 2021 08:23:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id kxUHIn3aFGF5CgAAGKfGzw
        (envelope-from <jroedel@suse.de>); Thu, 12 Aug 2021 08:23:25 +0000
Date:   Thu, 12 Aug 2021 10:23:24 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
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
Message-ID: <YRTafEovVZme+KO9@suse.de>
References: <20210810062626.1012-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810062626.1012-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill,

On Tue, Aug 10, 2021 at 09:26:21AM +0300, Kirill A. Shutemov wrote:
> Accepting happens via a protocol specific for the Virtrual Machine
> platform.

That sentence bothers me a bit. Can you explain what it VMM specific in
the acceptance protocol?

I want to avoid having to implement VMM specific acceptance protocols.

Regards,

	Joerg
