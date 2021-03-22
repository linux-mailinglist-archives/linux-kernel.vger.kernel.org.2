Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623323450A4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 21:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbhCVUUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 16:20:49 -0400
Received: from mga17.intel.com ([192.55.52.151]:45108 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231303AbhCVUUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 16:20:33 -0400
IronPort-SDR: NHWswus/u7VW0hD8+F5rYXlkLoF2V88IgeBdbGGYxj4oQJW2hN00UKqZYU+XJdh3u2XaECx9Ac
 tQwZLrMGE5JQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="170303766"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="170303766"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 13:20:29 -0700
IronPort-SDR: 6C5Nj2ZylD2XYwjKPnqLs+KXDFNekRQ8zw3ZrFeke9h5NrEQaKMX3hCkNwjXiyd7VrIOp9IDz4
 ERhY2Shm5WlA==
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="414632436"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 13:20:29 -0700
Date:   Mon, 22 Mar 2021 13:20:29 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, Santosh Sivaraj <santosh@fossix.org>
Subject: Re: [PATCH] ndtest: Remove redundant NULL check
Message-ID: <20210322202029.GP3014244@iweiny-DESK2.sc.intel.com>
References: <1616407240-114077-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616407240-114077-1-git-send-email-jiapeng.chong@linux.alibaba.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 06:00:40PM +0800, Jiapeng Chong wrote:
> Fix the following coccicheck warnings:
> 
> ./tools/testing/nvdimm/test/ndtest.c:491:2-7: WARNING: NULL check before
> some freeing functions is not needed.

I don't think there is anything wrong with this patch specifically but why is
buf not checked for null after the vmalloc?

It seems to me that if size >= DIMM_SIZE and the vmalloc fails the gen pool
allocation is going to be leaked.

Ira

> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  tools/testing/nvdimm/test/ndtest.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/testing/nvdimm/test/ndtest.c b/tools/testing/nvdimm/test/ndtest.c
> index 6862915..98b4a43 100644
> --- a/tools/testing/nvdimm/test/ndtest.c
> +++ b/tools/testing/nvdimm/test/ndtest.c
> @@ -487,8 +487,7 @@ static void *ndtest_alloc_resource(struct ndtest_priv *p, size_t size,
>  buf_err:
>  	if (__dma && size >= DIMM_SIZE)
>  		gen_pool_free(ndtest_pool, __dma, size);
> -	if (buf)
> -		vfree(buf);
> +	vfree(buf);
>  	kfree(res);
>  
>  	return NULL;
> -- 
> 1.8.3.1
> 
