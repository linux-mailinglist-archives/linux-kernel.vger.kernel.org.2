Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755963B4BDB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 03:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhFZBrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 21:47:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:15231 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229906AbhFZBru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 21:47:50 -0400
IronPort-SDR: hrBR+mDM9IVDqqvWCgZg5aYLQ8Qqj3B3xVktqd+IzKxzNgo+lscDgNjGoHb63WO8io3ngsw2eL
 ku/1ZlhXmMWw==
X-IronPort-AV: E=McAfee;i="6200,9189,10026"; a="271619788"
X-IronPort-AV: E=Sophos;i="5.83,300,1616482800"; 
   d="scan'208";a="271619788"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 18:45:27 -0700
IronPort-SDR: hCKD5S+oPcumuuqRBcYTvaowCF9pFxqjucntnEasGLGhyke1Ztqq/d0bbXb7YScsGWyXjVk4AC
 E7+TDajkpfDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,300,1616482800"; 
   d="scan'208";a="407134588"
Received: from alison-desk.jf.intel.com ([10.54.74.53])
  by orsmga006.jf.intel.com with ESMTP; 25 Jun 2021 18:45:27 -0700
Date:   Fri, 25 Jun 2021 18:40:47 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     13145886936@163.com
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, gushengxian <gushengxian@yulong.com>
Subject: Re: [PATCH] tools/testing/nvdimm: Remove NULL test before vfree
Message-ID: <20210626014047.GA15626@alison-desk.jf.intel.com>
References: <20210626012655.515279-1-13145886936@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210626012655.515279-1-13145886936@163.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 06:26:55PM -0700, 13145886936@163.com wrote:
> From: gushengxian <gushengxian@yulong.com>

Hi,

Thanks for updating the commit message and log.

I think you need to do something about the Signed-off-by or this
will not be accepted.  You can read more about the developer's
certificate of origin in here.
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Not sure your particular case, but maybe -

If you are submitting this on behalf of Gushengxian, then you need
to add your Signed-off-by after the current one:
ie. Signed-off-by: Your Full Name <13145886936@163.com>

Or, if this is your work, then you may need to update your
.gitconfig file, like this:

[user]
	name = Your Full Name
	email = email@example.com

The From line of the email needs to match a Signed-off-by.

Each time you repost a patch please increment the version number.
The next posting would be [PATCH v3]

Alison

> 
> This NULL test is redundant since vfree() checks for NULL.
> Reported by Coccinelle.
> 
> Signed-off-by: gushengxian <gushengxian@yulong.com>
> ---
>  tools/testing/nvdimm/test/nfit.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
> index 54f367cbadae..cb86f0cbb11c 100644
> --- a/tools/testing/nvdimm/test/nfit.c
> +++ b/tools/testing/nvdimm/test/nfit.c
> @@ -1641,8 +1641,8 @@ static void *__test_alloc(struct nfit_test *t, size_t size, dma_addr_t *dma,
>   err:
>  	if (*dma && size >= DIMM_SIZE)
>  		gen_pool_free(nfit_pool, *dma, size);
> -	if (buf)
> -		vfree(buf);
> +
> +	vfree(buf);
>  	kfree(nfit_res);
>  	return NULL;
>  }
> -- 
> 2.25.1
> 
> 
