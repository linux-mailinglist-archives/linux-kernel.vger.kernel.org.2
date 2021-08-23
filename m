Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B82B3F4B3E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 15:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237123AbhHWNAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 09:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235731AbhHWNAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 09:00:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9C8C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 05:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wC2pSzEizJSOr5+fmrmCRQtwwiOclWc0X5mPPcWRRUE=; b=kadJ6WU0DOyAGDdISb9kAv7L+S
        s/AMeFMoptb2Nzw83CqkwrrKGpWi+ChaZSjjmMvgx8vj3oHMtKIPah+/Ok/SoPMVaCcx07xRH7lJa
        A8ZAhnwqVbH4d38hdnRhPxsKxctf3nBrqRa8AuOxspQEJ+7p9fxi+DUAVBN5Y0tBLiNbgSmoMvcZD
        rQ7TLt7pu5AVts5kW/4gV53q6Sv92NqUPfJJ8bJ9XeIWXZRZkfjWHHK//7z+dRVHMzlK6puAVQPSk
        o6r5X8KTBsgYKnwN7iLN+LhwpzkXD67CwwqFGK5CQA2IQvk6ASnQ6MKZeRaIh1dTvo7UQglgaFf9D
        xG7DSOdA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mI9XU-009kEp-PK; Mon, 23 Aug 2021 12:59:21 +0000
Date:   Mon, 23 Aug 2021 13:58:56 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH 1/2] kernel/workqueue: Make schedule_on_each_cpu as
 EXPORT_SYMBOL
Message-ID: <YSObkFQEPY3f1XKE@infradead.org>
References: <f824a9b589be576f5dac9109ca07d65d6b83219a.1629712557.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f824a9b589be576f5dac9109ca07d65d6b83219a.1629712557.git.riteshh@linux.ibm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 03:37:45PM +0530, Ritesh Harjani wrote:
> Make schedule_on_each_cpu as EXPORT_SYMBOL.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  kernel/workqueue.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index f148eacda55a..6f15e4afbf38 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -3309,6 +3309,7 @@ int schedule_on_each_cpu(work_func_t func)
>  	free_percpu(works);
>  	return 0;
>  }
> +EXPORT_SYMBOL(schedule_on_each_cpu);

Please don't export random bits just for a test.  Especially non without
an EXPORT_SYMBOL_GPL.
