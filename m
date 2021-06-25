Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37EBE3B484D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 19:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhFYRoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 13:44:14 -0400
Received: from mga14.intel.com ([192.55.52.115]:49800 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229531AbhFYRoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 13:44:13 -0400
IronPort-SDR: mAcWzs3W1tPR5KuaIsGhf3E3IIe8vOPRpLJU+Ga3ZLVV78F277SOTf4evYHJqJdiXzHw+Qqaip
 Qm5vLMHc7mFw==
X-IronPort-AV: E=McAfee;i="6200,9189,10026"; a="207534083"
X-IronPort-AV: E=Sophos;i="5.83,299,1616482800"; 
   d="scan'208";a="207534083"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 10:41:51 -0700
IronPort-SDR: y+zZJUuUktTWp0baZaYD7IMxqtb/RtRBCiJBYQdZkGw1HTGpkSzMi2LF/HlAlm4qhu+SIlMyNK
 Fcn1TvWBOqdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,299,1616482800"; 
   d="scan'208";a="624584369"
Received: from alison-desk.jf.intel.com ([10.54.74.53])
  by orsmga005.jf.intel.com with ESMTP; 25 Jun 2021 10:41:49 -0700
Date:   Fri, 25 Jun 2021 10:37:10 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     13145886936@163.com
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, gushengxian <gushengxian@yulong.com>
Subject: Re: [PATCH] tools/testing/nvdimm: NULL check before vfree() is not
 needed
Message-ID: <20210625173710.GA14491@alison-desk.jf.intel.com>
References: <20210625072700.22662-1-13145886936@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625072700.22662-1-13145886936@163.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Gushengxian,

The code change looks good.  A couple of cleanups noted below...
(same feedback on next patch too)


On Fri, Jun 25, 2021 at 12:27:00AM -0700, 13145886936@163.com wrote:
> From: gushengxian <gushengxian@yulong.com>
> 
> NULL check before vfree() is not needed.

The commit message needs to say what was done, not the why.
Example: "[PATCH] tools/testing/nvdimm: Remove NULL test before vfree"

Then, the commit log explains why this should be done.
Example: "This NULL test is redundant since vfree() checks for NULL."

Coccinelle reports this vfree() case. If you did use Coccinelle
to find it, please mention that in the commit log.
Example: "Reported by Coccinelle."

> 
> Signed-off-by: gushengxian <gushengxian@yulong.com>

The email addresses don't match (13145886936@163.com,
gushengxian@yulong.com) and it's not clear that you are using your
full, legal name in the 'name line.

You can find more info on this feedback at:
https://kernelnewbies.org/FirstKernelPatch
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Alison

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
