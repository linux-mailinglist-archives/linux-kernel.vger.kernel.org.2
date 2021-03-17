Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E073E33EFC6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 12:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhCQLsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 07:48:45 -0400
Received: from casper.infradead.org ([90.155.50.34]:32848 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbhCQLsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 07:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BWVFiAGb+YSCj/TPEIZd6GMBDvrcbUHtnlVHHxvWhBo=; b=rwKoLxjdW2hmCTtWyhCLrPth65
        CnBdod3jbqmzmvVpUmsSoHQcRTkUpJxovGVZ9/czegK0gIpyTni4x57HQ940JgVySZBxZJk689el+
        vXo95qmLmeD5x6kpHOQkDKhjkpMWmynmCXiD28qgkS8p2kZyyF4f58HXzLvlAeP5J9f8ir3uu+HWZ
        qyEp7C3YATW2Bck/2a6R8RDo0/NeE8nmjF6pmoF9BTGYAFFnbFq98Mxpz668FW4wV2PX15goVxkxv
        0CkEY3A9SazkuJ+GxYAKJvxlCFTOvS0WyuFXqpREfTEWyJABiGBezTXFgXJDQzEe4Dp8YtAvyyB+t
        HAlZzdpg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lMUeo-001RI4-CB; Wed, 17 Mar 2021 11:48:12 +0000
Date:   Wed, 17 Mar 2021 11:48:10 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] mm: Typo fix in the file util.c
Message-ID: <20210317114810.GF3420@casper.infradead.org>
References: <20210317033439.3429411-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317033439.3429411-1-unixbhaskar@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 09:04:39AM +0530, Bhaskar Chowdhury wrote:
> 
> 
> s/condtion/condition/

The usual subject line for this would be:

mm/util: Fix typo

> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  mm/util.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/util.c b/mm/util.c
> index 54870226cea6..f85da35b50eb 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -775,7 +775,7 @@ int overcommit_policy_handler(struct ctl_table *table, int write, void *buffer,
>  	 * The deviation of sync_overcommit_as could be big with loose policy
>  	 * like OVERCOMMIT_ALWAYS/OVERCOMMIT_GUESS. When changing policy to
>  	 * strict OVERCOMMIT_NEVER, we need to reduce the deviation to comply
> -	 * with the strict "NEVER", and to avoid possible race condtion (even
> +	 * with the strict "NEVER", and to avoid possible race condition (even
>  	 * though user usually won't too frequently do the switching to policy
>  	 * OVERCOMMIT_NEVER), the switch is done in the following order:
>  	 *	1. changing the batch
> --
> 2.30.2
> 
> 
