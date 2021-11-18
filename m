Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880FD455AFC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 12:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344400AbhKRLzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 06:55:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:36362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344422AbhKRLyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 06:54:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D90F2613D3;
        Thu, 18 Nov 2021 11:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637236280;
        bh=6NsGQeJkYE/h4+gY3Tdq71/Dua/S5GFKQb0Dp/iMWXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=YVofebohI0ACFzhoYGbU2+QxRe0HA3XT/GFaTFmqOm1Zx4vsNYxUp8SUgRhjQy9YK
         aIr379BCZKLtAp946n2Ob+ZgeLpbrx8IgaEsWP77wUFVXK/tlcqPEHQmNSXipkhrPZ
         vp1AOUXsuFmgA3gwRnYfSWwDYDsSGm2SSXcoUaBrK4SmDD+lZ+axn1pcyZmOHXBAOE
         xxe/jWGfKOoHW61a2OTB5WAn4x9ngMcP99vLs6C400Z/baMz5pzVlJapGdRdxKjuH/
         1keEDfYtCIR5lvI/nxUfLIWCCS6tUJKTYMo2J3kXO/A1CvodPm4sXQYGVtFQ2fjI08
         lP/Yc/5EOubBw==
From:   SeongJae Park <sj@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     sjpark@amazon.de, sj@kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1] mm/damon/schemes: Add the validity judgment of thresholds
Date:   Thu, 18 Nov 2021 11:51:13 +0000
Message-Id: <20211118115113.20234-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <2ebc35fcafe61f9dfbb61cfb5dd3fa2c567c37fa.1637208947.git.xhao@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xin,


Thank you for this patch.

From next time, please send patches for DAMON to sj@kernel.org instead of
sjpark@amazon.de.

On Thu, 18 Nov 2021 12:16:02 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> In dbgfs "schemes" interface, i do some test like this:
>     # cd /sys/kernel/debug/damon
>     # echo "2 1 2 1 10 1 3 10 1 1 1 1 1 1 1 1 2 3" > schemes
>     # cat schemes
>     # 2 1 2 1 10 1 3 10 1 1 1 1 1 1 1 1 2 3 0 0
> 
> There have some unreasonable places, i set the valules of these variables
> "<min_sz, max_sz> <min_nr_a, max_nr_a>, <min_age, max_age>, <wmarks.high,
> wmarks.mid, wmarks.low>" as "<2, 1>, <2, 1>, <10, 1>, <1, 2, 3>.
> 
> So there add a validity judgment for these threshold values.
> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> ---
>  mm/damon/dbgfs.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
> index befb27a29aab..a4c94d563d3d 100644
> --- a/mm/damon/dbgfs.c
> +++ b/mm/damon/dbgfs.c
> @@ -215,6 +215,17 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
>  			goto fail;
>  		}
>  
> +		if (min_sz > max_sz || min_nr_a > max_nr_a || min_age > max_age) {
> +			pr_err("mininum > maxinum\n");

I think this error message is not really needed.

> +			goto fail;
> +		}
> +
> +		if (wmarks.high < wmarks.mid || wmarks.high < wmarks.low ||
> +		    wmarks.mid <  wmarks.low) {
> +			pr_err("wrong wmarks\n");

Ditto.


Thanks,
SJ

> +			goto fail;
> +		}
> +
>  		pos += parsed;
>  		scheme = damon_new_scheme(min_sz, max_sz, min_nr_a, max_nr_a,
>  				min_age, max_age, action, &quota, &wmarks);
> -- 
> 2.31.0
