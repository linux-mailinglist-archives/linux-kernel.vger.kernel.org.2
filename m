Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 775A2441222
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 03:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhKAC0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 22:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhKAC0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 22:26:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4BAC061714;
        Sun, 31 Oct 2021 19:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Q6ZAJzHp/d1wIOZgcMMjKOzpX1S/wfI1y2rL7tlK/iU=; b=Yzn6agCs5K0Y375M4heXim/QCw
        QMO4liQGIzBYe9AaPTh8+bycDFE95CeuIYay74lJkQ3eV+e/vGugfR/MCCkpYiWnQjw/zHd/J0VVb
        fe8eCRnjoPHHd+nE9tuLQO+J/IDzPDdG2jFbqCzd1jKrMfZdKWjgOPe1T8bQzWyAFbTAbUA/jDQdb
        JBKGH+V7pHQysa8SKaqdxgseZk0GxM/iIfNnprcZFCdBm84gOvUHqS5Z9a86mMAJm/c/LRaSFG7/Q
        wSvqDwy25ZkI6rAQenBZJ5feEhxwaWnU5sb643HkSlgAVn26VTg6bXNefooExYxCGikYWSf6CVqOq
        fZvjmB2g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhMxA-003SE6-AM; Mon, 01 Nov 2021 02:21:57 +0000
Date:   Mon, 1 Nov 2021 02:21:40 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yihao Han <hanyihao@vivo.com>
Cc:     "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Sven Schnelle <svens@stackframe.org>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@vivo.com
Subject: Re: [PATCH] parisc: using swap() instead of tmp
Message-ID: <YX9PNEEiaFn803RF@casper.infradead.org>
References: <20211101021047.22945-1-hanyihao@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101021047.22945-1-hanyihao@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 31, 2021 at 07:10:45PM -0700, Yihao Han wrote:
> @@ -127,16 +127,13 @@ static void __init setup_bootmem(void)
>  		int j;
>  
>  		for (j = i; j > 0; j--) {
> -			physmem_range_t tmp;
>  

If you're going to delete that line, you should also delete the
blank line after it.

>  			if (pmem_ranges[j-1].start_pfn <
>  			    pmem_ranges[j].start_pfn) {
>  
>  				break;
>  			}
> -			tmp = pmem_ranges[j-1];
> -			pmem_ranges[j-1] = pmem_ranges[j];
> -			pmem_ranges[j] = tmp;
> +			swap(pmem_ranges[j-1], pmem_ranges[j]);
>  		}
>  	}
>  
> -- 
> 2.17.1
> 
