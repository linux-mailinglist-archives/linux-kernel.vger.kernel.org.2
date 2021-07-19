Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEDBB3CD4D6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 14:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236996AbhGSLx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 07:53:56 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57222 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236929AbhGSLxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 07:53:54 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 72B432025A;
        Mon, 19 Jul 2021 12:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626698073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2iJvPsC6ukBGO3cNftlX9R7xbJOF2Z7UoI/Wtw8cKY0=;
        b=1V2Hdxpn4S17364BHRsNN2kAuHBJPZW4Y8suHHChc6wEUGdXxfnAzNS/dQdp2OHt30ruTi
        B/iIXCUMMy6qN2+ia62+JBc1gWK/dUJAd2doxx5fFuGj4ZfP/zS2Mr4eXF1hvEkwXBEEkI
        xfQpED6Pgyfvdi3cQ+0P419Q8/iJNUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626698073;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2iJvPsC6ukBGO3cNftlX9R7xbJOF2Z7UoI/Wtw8cKY0=;
        b=UhY5cevKft+Q/4dG+0soQM+eSC3skYAJewX/6yPH+/iCE590hbzViaKO/igLvmcPvbY16o
        xpzMGKkZIYp0rGBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F1C2813CE9;
        Mon, 19 Jul 2021 12:34:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id N2mVOFhx9WD5YwAAMHmgww
        (envelope-from <jroedel@suse.de>); Mon, 19 Jul 2021 12:34:32 +0000
Date:   Mon, 19 Jul 2021 14:34:31 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Zefang Han <hanzefang@gmail.com>,
        Wei Lin Chang <r09922117@csie.ntu.edu.tw>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: x86: Remove obsolete information about x86_64
 vmalloc() faulting
Message-ID: <YPVxV/KdDBqgTaqE@suse.de>
References: <20210622031910.141262-1-yepeilin.cs@gmail.com>
 <20210716060958.GA2197@PWN>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210716060958.GA2197@PWN>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 16, 2021 at 02:09:58AM -0400, Peilin Ye wrote:
> This information is out-of-date, and it took me quite some time of
> ftrace'ing before I figured it out...  I think it would be beneficial to
> update, or at least remove it.
> 
> As a proof that I understand what I am talking about, on my x86_64 box:
> 
>   1. I allocated a vmalloc() area containing linear address `addr`;
>   2. I manually pagewalked `addr` in different page tables, including
>      `init_mm.pgd`;
>   3. The corresponding PGD entries for `addr` in different page tables,
>      they all immediately pointed at the same PUD table (my box uses
>      4-level paging), at the same physical address;
>   4. No "lazy synchronization" via page fault handling happened at all,
>      since it is the same PUD table pre-allocated by
>      preallocate_vmalloc_pages() during boot time.

Yes, this is the story for x86-64, because all PUD/P4D pages for the vmalloc
area are pre-allocated at boot. So no faulting or synchronization needs
to happen.

On x86-32 this is a bit different. Pre-allocation of PMD/PTE pages is
not an option there (even less when 4MB large-pages with 2-level paging
come into the picture).

So what happens there is that vmalloc related changes to the init_mm.pgd
are synchronized to all page-tables in the system. But this
synchronization is subject to race conditions in a way that another CPU
might vmalloc an area below a PMD which is not fully synchronized yet.

When this happens there is a fault, which is handled as a vmalloc()
fault on x86-32 just as before. So vmalloc faults still exist on 32-bit,
they are just less likely as they used to be.

Regards,

	Joerg
