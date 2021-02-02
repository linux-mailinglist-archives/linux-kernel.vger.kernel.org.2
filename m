Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA2ED30B439
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 01:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhBBAkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 19:40:09 -0500
Received: from mga07.intel.com ([134.134.136.100]:1286 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230000AbhBBAkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 19:40:09 -0500
IronPort-SDR: jTW3CDdWq0Eye8yu191Nttzm9TvsfZxxmU8Xam/IVx+SXW9ghKXlzymKnQJEDemLzAsoBAjo0p
 sChuqrHfJxBw==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="244857716"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="244857716"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 16:39:27 -0800
IronPort-SDR: hF1RcR0g2YqnQc/kXdTtwjvLHy0Os+sVlwhWN82ZXYiR6/myuIBvKIqOPJ1qm1udb372V/Nk2e
 blUtrx4hsXXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="370174219"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.28])
  by fmsmga008.fm.intel.com with ESMTP; 01 Feb 2021 16:39:26 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/swap_state: Constify static struct attribute_group
References: <20210201233254.91809-1-rikard.falkeborn@gmail.com>
Date:   Tue, 02 Feb 2021 08:39:25 +0800
In-Reply-To: <20210201233254.91809-1-rikard.falkeborn@gmail.com> (Rikard
        Falkeborn's message of "Tue, 2 Feb 2021 00:32:54 +0100")
Message-ID: <8735yfl2v6.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rikard Falkeborn <rikard.falkeborn@gmail.com> writes:

> The only usage of swap_attr_group is to pass its address to
> sysfs_create_group() which takes a pointer to const attribute_group.
> Make it const to allow the compiler to put it in read-only memory.
>
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Looks good to me.

Acked-by: "Huang, Ying" <ying.huang@intel.com>

> ---
>  mm/swap_state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index d0d417efeecc..3cdee7b11da9 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -901,7 +901,7 @@ static struct attribute *swap_attrs[] = {
>  	NULL,
>  };
>  
> -static struct attribute_group swap_attr_group = {
> +static const struct attribute_group swap_attr_group = {
>  	.attrs = swap_attrs,
>  };
