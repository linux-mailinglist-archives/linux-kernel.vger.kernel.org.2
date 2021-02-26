Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070EF3268CE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 21:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhBZUiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 15:38:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:50764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230477AbhBZUh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 15:37:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5521E64F03;
        Fri, 26 Feb 2021 20:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1614371837;
        bh=Ly0f27B7LvWPQIY/noxzHUfAiBR7+fZJjZHCqygyerw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zJhisgXnLiT9g94dR6TY00koT/Ql+rflRrpcB41mBSqMhYtj/D6Yx166tD0LQTGmp
         qlINLn7lfkO6b+9EncYHBQ+FTqGI6/MOMpYyC76WwLDirIBX32wST/4Dz+JkrSKAHo
         WmM/b4uUHPf7DrEkKbDAoqnnT6lrzQZEjJ7aCOPI=
Date:   Fri, 26 Feb 2021 12:37:16 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     atishp@atishpatra.org, peterz@infradead.org,
        srikar@linux.vnet.ibm.com, valentin.schneider@arm.com,
        vbabka@suse.cz, mpe@ellerman.id.au,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@android.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 1/2] mm: Guard a use of node_reclaim_distance with
 CONFIFG_NUMA
Message-Id: <20210226123716.6bc2a463e0ee9d1770c7966b@linux-foundation.org>
In-Reply-To: <20210226201721.510177-1-palmer@dabbelt.com>
References: <20210226201721.510177-1-palmer@dabbelt.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Feb 2021 12:17:20 -0800 Palmer Dabbelt <palmer@dabbelt.com> wrote:

> From: Palmer Dabbelt <palmerdabbelt@google.com>
> 
> This is only useful under CONFIG_NUMA.  IIUC skipping the check is the
> right thing to do here, as without CONFIG_NUMA there will never be any
> large node distances on non-NUMA systems.
> 
> I expected this to manifest as a link failure under (!CONFIG_NUMA &&
> CONFIG_TRANSPARENT_HUGE_PAGES), but I'm not actually seeing that.  I
> think the reference is just getting pruned before it's checked, but I
> didn't get that from reading the code so I'm worried I'm missing
> something.
> 
> Either way, this is necessary to guard the definition of
> node_reclaim_distance with CONFIG_NUMA.
> 
> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
> ---
>  mm/khugepaged.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index a7d6cb912b05..b1bf191c3a54 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -819,8 +819,10 @@ static bool khugepaged_scan_abort(int nid)
>  	for (i = 0; i < MAX_NUMNODES; i++) {
>  		if (!khugepaged_node_load[i])
>  			continue;
> +#ifdef CONFIG_NUMA
>  		if (node_distance(nid, i) > node_reclaim_distance)
>  			return true;
> +#endif
>  	}
>  	return false;
>  }

This makes the entire loop a no-op.  Perhaps Kirill can help take a
look at removing unnecessary code in khugepaged.c when CONFIG_NUMA=n?
