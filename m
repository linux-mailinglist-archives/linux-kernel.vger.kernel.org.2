Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C43B40739E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 00:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbhIJW4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 18:56:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:57066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231225AbhIJW4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 18:56:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BEE1C611AD;
        Fri, 10 Sep 2021 22:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631314507;
        bh=VJ5ipnbbr7/hh4BSPRAZdwAh7k+W87MfA9moLBnzp0s=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=WkQpk6kZbm/ZHT+FsrAzCBeXuYhUISywAxkP9plMEH2n2yyeze9UKk7QZTjhgDLXN
         51ugguyIEa/+V8LllhC/PNyCzFILxyuwld5PTQB2gF4M9FfA5EJt7JAcq3fUkXc44z
         RjLXp9WELfVVxbNKwIxQ+1Fn2mq3NPHvUxZC/cf6KQkGWTHozf5VM/7/PVvDpAxYv0
         zQx4Vfyar5oZnFDNHBNymesr4CjJu1q1T9D1vPA995FUeYqCST0KdgOrc2bd+G/sP+
         xlo2BLhCiOi7UGnuyGemVt7DQkI2HbKUIPvBywaJNaw14X2oT5UAyJCJ2CdShrDZ2Z
         ZUniSmG/6PxxA==
Date:   Fri, 10 Sep 2021 15:55:06 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Jan Beulich <jbeulich@suse.com>
cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 01/12] swiotlb-xen: avoid double free
In-Reply-To: <ce9c2adb-8a52-6293-982a-0d6ece943ac6@suse.com>
Message-ID: <alpine.DEB.2.21.2109101554370.10523@sstabellini-ThinkPad-T480s>
References: <588b3e6d-2682-160c-468e-44ca4867a570@suse.com> <ce9c2adb-8a52-6293-982a-0d6ece943ac6@suse.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Sep 2021, Jan Beulich wrote:
> Of the two paths leading to the "error" label in xen_swiotlb_init() one
> didn't allocate anything, while the other did already free what was
> allocated.
> 
> Fixes: b82776005369 ("xen/swiotlb: Use the swiotlb_late_init_with_tbl to init Xen-SWIOTLB late when PV PCI is used")
> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -216,7 +216,6 @@ error:
>  		goto retry;
>  	}
>  	pr_err("%s (rc:%d)\n", xen_swiotlb_error(m_ret), rc);
> -	free_pages((unsigned long)start, order);
>  	return rc;
>  }
>  
> 
