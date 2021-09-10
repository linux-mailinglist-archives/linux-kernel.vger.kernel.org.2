Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF78A4073D8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 01:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbhIJX1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 19:27:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233121AbhIJX1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 19:27:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 922D4611B0;
        Fri, 10 Sep 2021 23:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631316394;
        bh=nWCVWm37Cn4aTHD9fKKBK0iiTuNj5cGbnQ7UNy5fjiA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=p13Fcm19TN9LmTK4LlFXJYisdlx8j91SHYqgG2d+C217OScazn4CK+Goc+whmNQJa
         ccx3b/fMa+GAFLShtrkw2wCd2vAY0tVJ+/AqBkqitqoL9L5oLqKutEGWAUNAK+R3Y/
         sJqYpnAww5AVQqbFTNJObMcBwqD6gchOiTNTjN98IwZcwwgsltdB9KUR7ykVRaKEAN
         o9ueydR3zF1hTRSg1zy6p3RmdqXl4lQpCX4HY/6cZ/OXW5AaL4X2m1jBP05g7PMx33
         +7J7HWLwwv6rZO1z4o22ZhLOTgTt2k1dFajut6FdFj+OYvmqqJyJqr4D0oscTPpFLh
         iOJfITNuWNWmw==
Date:   Fri, 10 Sep 2021 16:26:33 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Jan Beulich <jbeulich@suse.com>
cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 08/12] swiotlb-xen: arrange to have buffer info logged
In-Reply-To: <2e3c8e68-36b2-4ae9-b829-bf7f75d39d47@suse.com>
Message-ID: <alpine.DEB.2.21.2109101626250.10523@sstabellini-ThinkPad-T480s>
References: <588b3e6d-2682-160c-468e-44ca4867a570@suse.com> <2e3c8e68-36b2-4ae9-b829-bf7f75d39d47@suse.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Sep 2021, Jan Beulich wrote:
> I consider it unhelpful that address and size of the buffer aren't put
> in the log file; it makes diagnosing issues needlessly harder. The
> majority of callers of swiotlb_init() also passes 1 for the "verbose"
> parameter. 
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>


> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -253,7 +253,7 @@ retry:
>  		panic("%s (rc:%d)", xen_swiotlb_error(XEN_SWIOTLB_EFIXUP), rc);
>  	}
>  
> -	if (swiotlb_init_with_tbl(start, nslabs, false))
> +	if (swiotlb_init_with_tbl(start, nslabs, true))
>  		panic("Cannot allocate SWIOTLB buffer");
>  	swiotlb_set_max_segment(PAGE_SIZE);
>  }
> 
