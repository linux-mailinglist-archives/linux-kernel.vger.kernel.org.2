Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F375C3AC162
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 05:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbhFRDen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 23:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbhFRDel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 23:34:41 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8594C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 20:32:31 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id t17so6651827pga.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 20:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1IR2Jtwu8aWSfR50DxaFiQcomIN7MP6Klsy7f1btCzI=;
        b=TtMv60lza7lNizDysWmmBY57vOoGikPqFdk0B+a5JlDmUhvJPek2Y+q9Omq+R3+B2w
         ytlzcFCqwdBfo8K8WT4sR399ZKqYlmspHEk3mXH7Ne69p66UX+1Qr0GrnZkPb66BN/Lv
         9t6SOXBbI15cJrifYX03qatIhO7ieAAPs6mD+Gv1nanvG5OmS0+xzBkOgNvoREYNYxEZ
         LIP8yp6/O/8ULcITglX0svfJzbg0wcST6jc6nLLWuemQbjazFo2TPy2vsAnU+i8vvVZ6
         Mgmv3uFgwrhVlHcZpFoluSG0vF8ip10pkMuLm3IcM9u3aPRveQTiw1l8tYK2AEg7MSb2
         Lx6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1IR2Jtwu8aWSfR50DxaFiQcomIN7MP6Klsy7f1btCzI=;
        b=IhMJjN+Deou9TdqCaHDPoF910KE0T3U4oJAHpUYBCUzuR5BnzV2D9TJ3JgKFMnuhVA
         WxF2qr6LNUSg2JQBPCyTM8B/4mZm3k2uzOOibOae8NTMBi99HR4OyLI606yWylnSzmW0
         I2t4s8C0NKGdbaC73rpC8MpLzro3w2LNKrV21TgvxtjKCE3stStvM58qtDNSa62+NSF/
         vLXkyXS1DVy5cTZvKvSIuBshklDt7OmC8LFZ8ioAZ9PBz02bAFe0KoeDPivUzTy8RTh6
         xJkQzSff0lUnV3THII/6XDROuSPjHLEzYqDoRZegDQJr60GkobkDx7RDTh5u17M53fty
         tNLg==
X-Gm-Message-State: AOAM533JxTkkEuD2lXfRc9f3y2jfiQkmA/fg/K/+EtUNQtcxilQziN3x
        XLCvJE9sTayQ1m0GVCsW/VrntQ==
X-Google-Smtp-Source: ABdhPJyZujAfTBJoBP8IoVxzcmnKXOahTuBWcxxJtVS8tTuDE26rzuzY5dgIrUd7sosptn/B+2loYg==
X-Received: by 2002:a63:1011:: with SMTP id f17mr8066798pgl.274.1623987151163;
        Thu, 17 Jun 2021 20:32:31 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id r14sm6072661pgm.28.2021.06.17.20.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 20:32:30 -0700 (PDT)
Date:   Fri, 18 Jun 2021 09:02:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] opp: remove redundant continue statement
Message-ID: <20210618033228.mork47zl3xydwb34@vireshk-i7>
References: <20210617135020.16415-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617135020.16415-1-colin.king@canonical.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-06-21, 14:50, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The continue statement at the end of a for-loop has no effect,
> remove it.
> 
> Addresses-Coverity: ("Continue has no effect")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/opp/of.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 9573facce53a..d298e38aaf7e 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -197,10 +197,8 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
>  		required_opp_tables[i] = _find_table_of_opp_np(required_np);
>  		of_node_put(required_np);
>  
> -		if (IS_ERR(required_opp_tables[i])) {
> +		if (IS_ERR(required_opp_tables[i]))
>  			lazy = true;
> -			continue;
> -		}
>  	}

I had to merge this with:

"opp: Allow required-opps to be used for non genpd use cases"

Thanks for the report anyway :)

-- 
viresh
