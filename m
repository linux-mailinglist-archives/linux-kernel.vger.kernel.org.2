Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFFE42D829
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 13:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhJNL2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 07:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhJNL2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 07:28:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AE0C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 04:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/5zUfFoaiFBe8rfbKfTgk8jA8kMuRwKwp9CkU8MGJHU=; b=P8qtkmiD6MqHh/LdtaQwCNARXR
        08F9cGCooJMOx/zzha05/ZgDG2fk7yy7SrlvtsHcYc95hxvuPZ5RoeCwNBiT3X/ejU4/X9BN9cwMc
        aBQoxt0D8poevpEtHYmRHSBBY1Sb9HRVT8V/Er9VNrSgUoZv1IDBECiWHilTOi8gD+BcM4mhRvlln
        s7sKDSnW8mPAnQePFcpcrqeiSZLVZJkezNAXlm8pMyH1r3whRbj2/AJZ3triprujtJYGNhShFGtWJ
        55pQwsig5S4LUx+G+tyJ1C/kJLQBakLjAMZMhE5h/n52rGx4ZCW112uuy73tAHosI/kXlmVgHwALc
        NYdQ2cbw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mayqU-008Hx7-Pz; Thu, 14 Oct 2021 11:25:10 +0000
Date:   Thu, 14 Oct 2021 12:24:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Zqiang <qiang.zhang1211@gmail.com>
Cc:     akpm@linux-foundation.org, sunhao.th@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: backing-dev: use kfree_rcu() instead of
 synchronize_rcu_expedited()
Message-ID: <YWgTZjDtZik/9l4J@casper.infradead.org>
References: <20211014082433.30733-1-qiang.zhang1211@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014082433.30733-1-qiang.zhang1211@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 04:24:33PM +0800, Zqiang wrote:
> The bdi_remove_from_list() is called in RCU softirq, however the
> synchronize_rcu_expedited() will produce sleep action, use kfree_rcu()
> instead of it.
> 
> Reported-by: Hao Sun <sunhao.th@gmail.com>
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> ---
>  include/linux/backing-dev-defs.h | 1 +
>  mm/backing-dev.c                 | 4 +---
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
> index 33207004cfde..35a093384518 100644
> --- a/include/linux/backing-dev-defs.h
> +++ b/include/linux/backing-dev-defs.h
> @@ -202,6 +202,7 @@ struct backing_dev_info {
>  #ifdef CONFIG_DEBUG_FS
>  	struct dentry *debug_dir;
>  #endif
> +	struct rcu_head rcu;
>  };

Instead of growing struct backing_dev_info, it seems to me this rcu_head
could be placed in a union with rb_node, since it will have been removed
from the bdi_tree by this point and the tree is never walked under
RCU protection?

