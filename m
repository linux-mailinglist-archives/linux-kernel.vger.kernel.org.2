Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1298642D68B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 11:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhJNJ6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 05:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhJNJ55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 05:57:57 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE09C061570;
        Thu, 14 Oct 2021 02:55:52 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id ec8so21927502edb.6;
        Thu, 14 Oct 2021 02:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=74OxFDQINVP0t2Tym9riIimusp8CKNtXPfS58HmDiLw=;
        b=BS3g7dZGSS+szT6wf9qurt+RBfc0UoAM3kDnpqYZBSvbGq3ebU1UZHUSXwn5DYagOn
         uvm22zri7XDVR2V/BNROSi7XPrguJodp/U0OLusEP8WUYZM+MWa9tRwKsHewBYskDx0b
         ChgmNr7tWfYhfi1vP5HCChHcHD8thT9sQN5kEz8IMfjOq+buxwnn99DTB9VZp2xExb7o
         GCOSEI9mnnzWM1YyNbMQHBF6X0VGQ692z1THXDHoDfi9mVWTs4pLhXV5TbrOdnCKOrXX
         dPj3JQ0MxFCafqrhIxqWYQhRJRE60pjnDFRWYJa5Y+kqr/3ZmF5UD6dALujoXlx01dSk
         u/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=74OxFDQINVP0t2Tym9riIimusp8CKNtXPfS58HmDiLw=;
        b=IU+//E9QpNe1jAJNB5UnDteA53co3O4SZlgu4qXJKY+CYcjvBJ/4eQfZpO05vyTCIE
         1UKptOO+2vkOm1rjHQV3QB/1w/MYMoDuhx0EUjAYE3A/v5qk9BLeX8S7PdJjXV+rHf4w
         BdZdXNbYNiZ8vqnRkLsZg5HC08rSIb3IpCe1R+xdBIyqMdh/XicmAPe+gb3qbE+0Cy2I
         gfo4HWJrEZ0MQJl8RLBTO7ZF9d1CqA1Q3Wctp+MgnQx/+jCqe7OlSYACX+S7tTXDPGzL
         JH5H5akyG0orKxW5yh+nfqGZXKKMZLa2UdkpHvTn5AaAWx07iou/GL+YL4rxd+ZCUkyd
         hoYw==
X-Gm-Message-State: AOAM531GUKPMRnztVvlWiAYeXtf3Y2UEFqZjVC0h7Z7k+hyODVChHK51
        yh2B/s3QfBiz67EBQ0XQ9w==
X-Google-Smtp-Source: ABdhPJwBHbs0l+qwtXWx6kiyM/z9QoRTuUFdwCI8NaqkcTZIJ9KfqxmcIMU5Y2fSgZC1yz6FzYc58g==
X-Received: by 2002:a17:906:a382:: with SMTP id k2mr2543789ejz.454.1634205351095;
        Thu, 14 Oct 2021 02:55:51 -0700 (PDT)
Received: from ?IPv6:2a02:810b:f40:4200:e1d9:2e2e:532d:87df? ([2a02:810b:f40:4200:e1d9:2e2e:532d:87df])
        by smtp.gmail.com with ESMTPSA id h18sm1513410ejt.29.2021.10.14.02.55.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 02:55:50 -0700 (PDT)
Subject: Re: [PATCH v1 1/6] clk: divider: Implement and wire up
 .determine_rate by default
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-clk@vger.kernel.org, sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
References: <20210702225145.2643303-1-martin.blumenstingl@googlemail.com>
 <20210702225145.2643303-2-martin.blumenstingl@googlemail.com>
From:   Alex Bee <knaerzche@gmail.com>
Message-ID: <4eb964ac-4fff-b59d-2660-2f84d8af5901@gmail.com>
Date:   Thu, 14 Oct 2021 11:55:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210702225145.2643303-2-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 03.07.21 um 00:51 schrieb Martin Blumenstingl:
> .determine_rate is meant to replace .round_rate. The former comes with a
> benefit which is especially relevant on 32-bit systems: since
> .determine_rate uses an "unsigned long" (compared to a "signed long"
> which is used by .round_rate) the maximum value on 32-bit systems
> increases from 2^31 (or approx. 2.14GHz) to 2^32 (or approx. 4.29GHz).
>
> Implement .determine_rate in addition to .round_rate so drivers that are
> using clk_divider_{ro_,}ops can benefit from this by default. Keep the
> .round_rate callback for now since some drivers rely on
> clk_divider_ops.round_rate being implemented.
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
This commit  breaks composite clocks with multiple parents, since it 
adds a  determine_rate callback, which is preferred over 
clock_round_rate in  clk_composite_determine_rate in clk-composite.c and 
the "best-parent"-determination  is only done for clock_round_rate-op 
there.
There is no "best-parent"-determination  in determine_rate in 
clk-divider which clk-compsite seems to expect - nor any multiple 
parents handling at all.  That means that the composite will always stay 
at the same/initial parent  clock (from the mux), without ever changing 
it (even if necessary).

This breaks lot of clocks for Rockchip which intensively uses 
composites,  i.e. those clocks will always stay at the initial parent, 
which in some cases  is the XTAL clock and I strongly guess it is the 
same for other platforms,  which use composite clocks having more than 
one parent (e.g. mediatek, ti ...)

Example (RK3399)
clk_sdio is set (initialized) with XTAL (24 MHz) as parent in u-boot.  
It will always stay at this parent, even if the mmc driver sets a rate 
of  200 MHz (fails, as the nature of things), which should switch it to 
any of its possible parent PLLs defined in 
mux_pll_src_cpll_gpll_npll_ppll_upll_24m_p (see clk-rk3399.c)  - which 
never happens.

Reverting this commit makes it work again: Unless there is a quick and 
obvious fix for that, I guess this should be done for 5.15 - even if the 
real issue is somewhere else.

Alex

> ---
>   drivers/clk/clk-divider.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
>
> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> index 87ba4966b0e8..f6b2bf558486 100644
> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -446,6 +446,27 @@ static long clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
>   				  divider->width, divider->flags);
>   }
>   
> +static int clk_divider_determine_rate(struct clk_hw *hw,
> +				      struct clk_rate_request *req)
> +{
> +	struct clk_divider *divider = to_clk_divider(hw);
> +
> +	/* if read only, just return current value */
> +	if (divider->flags & CLK_DIVIDER_READ_ONLY) {
> +		u32 val;
> +
> +		val = clk_div_readl(divider) >> divider->shift;
> +		val &= clk_div_mask(divider->width);
> +
> +		return divider_ro_determine_rate(hw, req, divider->table,
> +						 divider->width,
> +						 divider->flags, val);
> +	}
> +
> +	return divider_determine_rate(hw, req, divider->table, divider->width,
> +				      divider->flags);
> +}
> +
>   int divider_get_val(unsigned long rate, unsigned long parent_rate,
>   		    const struct clk_div_table *table, u8 width,
>   		    unsigned long flags)
> @@ -501,6 +522,7 @@ static int clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
>   const struct clk_ops clk_divider_ops = {
>   	.recalc_rate = clk_divider_recalc_rate,
>   	.round_rate = clk_divider_round_rate,
> +	.determine_rate = clk_divider_determine_rate,
>   	.set_rate = clk_divider_set_rate,
>   };
>   EXPORT_SYMBOL_GPL(clk_divider_ops);
> @@ -508,6 +530,7 @@ EXPORT_SYMBOL_GPL(clk_divider_ops);
>   const struct clk_ops clk_divider_ro_ops = {
>   	.recalc_rate = clk_divider_recalc_rate,
>   	.round_rate = clk_divider_round_rate,
> +	.determine_rate = clk_divider_determine_rate,
>   };
>   EXPORT_SYMBOL_GPL(clk_divider_ro_ops);
>   
