Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328133F14A8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 09:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236904AbhHSH73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 03:59:29 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52478 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbhHSH7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 03:59:25 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1CEB5220AB;
        Thu, 19 Aug 2021 07:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629359929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GasiM7Gy5clKgsCGkYZlWv0QVHBzwTvldYtpCJdLXlY=;
        b=F/EtMP5KGs1HWPLA29hG+3PQYkUbvNF6FWEBiwDZc2Z2AJJGG0g/5m5ndZe2yxr93HAWuj
        yBcCD/txDvEp7IqUcLhalILcKdFnQjyT8heCgiJ4jeRmirL2Yt4o3Tvh91z/5ZKGKbaacK
        9HrQ2hO7xm07IbVAyNB3dA/O36Fm7Q8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629359929;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GasiM7Gy5clKgsCGkYZlWv0QVHBzwTvldYtpCJdLXlY=;
        b=CNSD3tLSPcXd5p99d1UpO7Ehx9Mu3IroRkaLNmapediVk8MBqEHzK4lOYu72geIGzEPPIU
        DDZw6mtXroOYG5AQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 97E57136DD;
        Thu, 19 Aug 2021 07:58:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id aGpJIzgPHmFyEAAAGKfGzw
        (envelope-from <jroedel@suse.de>); Thu, 19 Aug 2021 07:58:48 +0000
Date:   Thu, 19 Aug 2021 09:58:46 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Peilin Ye <peilin.ye@bytedance.com>
Subject: Re: [PATCH RESEND v2] docs: x86: Remove obsolete information about
 x86_64 vmalloc() faulting
Message-ID: <YR4PNjIM3W5zkPnt@suse.de>
References: <20210818220123.2623-1-yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818220123.2623-1-yepeilin.cs@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 03:01:23PM -0700, Peilin Ye wrote:
> From: Peilin Ye <peilin.ye@bytedance.com>
> 
> x86_64 vmalloc() mappings are no longer "synchronized" among page tables
> via faulting since commit 6eb82f994026 ("x86/mm: Pre-allocate P4D/PUD
> pages for vmalloc area"), since the corresponding P4D or PUD pages are
> now preallocated at boot, by preallocate_vmalloc_pages().  Drop the
> "lazily synchronized" description for less confusion.
> 
> While this file is x86_64-specific, it is worth noting that things are
> different for x86_32, where vmalloc()-related changes to `init_mm.pgd` are
> synchronized to all page tables in the system during runtime, via
> arch_sync_kernel_mappings().  Unfortunately, this synchronization is
> subject to race condition, which is further handled via faulting, see
> vmalloc_fault().  See commit 4819e15f740e ("x86/mm/32: Bring back vmalloc
> faulting on x86_32") for more details.
> 
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Peilin Ye <peilin.ye@bytedance.com>

Reviewed-by: Joerg Roedel <jroedel@suse.de>

> ---
> Hi all,
> 
> Resending this with Muchun's Reviewed-by:.
> 
> Thanks,
> Peilin Ye
> 
> Changes in v2:
>     - More information for x86_32 in commit message (Joerg Roedel
>       <jroedel@suse.de>)
>     - Use my new email address for work
> 
>  Documentation/x86/x86_64/mm.rst | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/Documentation/x86/x86_64/mm.rst b/Documentation/x86/x86_64/mm.rst
> index ede1875719fb..9798676bb0bf 100644
> --- a/Documentation/x86/x86_64/mm.rst
> +++ b/Documentation/x86/x86_64/mm.rst
> @@ -140,10 +140,6 @@ The direct mapping covers all memory in the system up to the highest
>  memory address (this means in some cases it can also include PCI memory
>  holes).
>  
> -vmalloc space is lazily synchronized into the different PML4/PML5 pages of
> -the processes using the page fault handler, with init_top_pgt as
> -reference.
> -
>  We map EFI runtime services in the 'efi_pgd' PGD in a 64Gb large virtual
>  memory window (this size is arbitrary, it can be raised later if needed).
>  The mappings are not part of any other kernel PGD and are only available
> -- 
> 2.20.1
> 
