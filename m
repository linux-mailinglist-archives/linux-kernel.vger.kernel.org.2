Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A754378DA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 16:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbhJVOQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 10:16:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231953AbhJVOQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 10:16:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 70DBE6128B;
        Fri, 22 Oct 2021 14:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634912060;
        bh=+LSY+lBk0VcuOK02x0pQs2CrnIpazX/toffgrseGQyY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hAXfeT3Jic73fLZMdK8YRmHF5RZi7ruaRofFMaNNGra6c76vy2N7ilhOlk/pRhUfp
         wudfYpCeSxxZuCTZOoFiKSH5dy6csKZ54ofX0ewHkcJUVyM7OnQJJgVxW4h2V+2n5j
         vxMoBngmpyL+zktNNa9/9rTmO9I9sqA4Dxs+EmJ9mvvQel7WdXd/nn9XC5SLd5Tbn3
         T0DehnnwApJ2I02tbi4BcBJz7q59SrPO3+2dMe66R9xfTH06Nqr5gHM062Ed9lTV4W
         H5yrlUF9M+Tcm7paXADd2Mi3OLtU4+P3UqNi+cx2q208lumJm8qhcupx2eFdJVtzcE
         L8ZovpOi4X3vQ==
Message-ID: <b4d6a7ab-15a3-8bcd-7627-ea9c3200c012@kernel.org>
Date:   Fri, 22 Oct 2021 22:14:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] erofs: get rid of ->lru usage
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
References: <20211022090120.14675-1-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20211022090120.14675-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/10/22 17:01, Gao Xiang wrote:
> Currently, ->lru is a way to arrange non-LRU pages and has some
> in-kernel users. In order to minimize noticable issues of page
> reclaim and cache thrashing under high memory presure, limited
> temporary pages were all chained with ->lru and can be reused
> during the request. However, it seems that ->lru could be removed
> when folio is landing.
> 
> Let's use page->private to chain temporary pages for now instead
> and transform EROFS formally after the topic of the folio / file
> page design is finalized.
> 
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Kent Overstreet <kent.overstreet@gmail.com>
> Cc: Chao Yu <chao@kernel.org>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
