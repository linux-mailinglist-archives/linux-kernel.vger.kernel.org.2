Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391DF346104
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 15:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhCWOHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 10:07:52 -0400
Received: from mga14.intel.com ([192.55.52.115]:44865 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232160AbhCWOG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:06:57 -0400
IronPort-SDR: +y3/JVDdoIIC31NpJkB7XNAKY5teYlH9d+EnquSRvdiCAmQ0GXJFB21x5iEq8X39uEqUrXINUv
 iU++ooq6gRmg==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="189882968"
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="189882968"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 07:06:56 -0700
IronPort-SDR: xx5MaGxRVyHqmO79WHr0rAI4B69Xc/n2M2G8cNkPVKLu7k30HN1Kd0f3IeX0lmIN6mDh1JW1Yi
 huciVuHbkGxQ==
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="513754729"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 07:06:50 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 23 Mar 2021 16:06:47 +0200
Date:   Tue, 23 Mar 2021 16:06:47 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Fix a double put in tb_cfg_read_raw
Message-ID: <20210323140647.GV2542@lahna.fi.intel.com>
References: <20210323031512.12234-1-lyl2019@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323031512.12234-1-lyl2019@mail.ustc.edu.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 22, 2021 at 08:15:12PM -0700, Lv Yunlong wrote:
> In tb_cfg_read_raw, req is allocated by tb_cfg_request_alloc()
> with an initial reference. Before calling tb_cfg_request_sync(),
> there is no refcount inc operation. tb_cfg_request_sync()
> calls tb_cfg_request(..,req,..) and if the callee failed,
> the initial reference of req is dropped and req is freed.
> 
> Later in tb_cfg_read_raw before the err check,
> tb_cfg_request_put(req) is called again. It may cause error
> in race.

Hmm, tb_cfg_request() does tb_cfg_request_get() too and in case of error
it does tb_cfg_request_put(). So the refcount should be fine. What am I
missing?

> 
> My patch puts tb_cfg_request_put(req) after the err check
> finished to avoid unexpected result.
> 
> Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> ---
>  drivers/thunderbolt/ctl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thunderbolt/ctl.c b/drivers/thunderbolt/ctl.c
> index f1aeaff9f368..bb60269c89ab 100644
> --- a/drivers/thunderbolt/ctl.c
> +++ b/drivers/thunderbolt/ctl.c
> @@ -890,11 +890,11 @@ struct tb_cfg_result tb_cfg_read_raw(struct tb_ctl *ctl, void *buffer,
>  
>  		res = tb_cfg_request_sync(ctl, req, timeout_msec);
>  
> -		tb_cfg_request_put(req);
> -
>  		if (res.err != -ETIMEDOUT)
>  			break;
>  
> +		tb_cfg_request_put(req);
> +
>  		/* Wait a bit (arbitrary time) until we send a retry */
>  		usleep_range(10, 100);
>  	}
> -- 
> 2.25.1
> 
