Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC2E73D560C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 11:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhGZIWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 04:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbhGZIWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 04:22:05 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE6BC061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:02:33 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id i1so10754173plr.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=m2PkWVzinhOCRo3IGzVGrt63/A23oKKmVsPMQyo7PTw=;
        b=FY+UeXPr2uTrkK9TRyGO9fg62FZmL0DWVOERpKDuc3mN0/nYNb2w4Fhd+8r8v79cSi
         xsTVteM9dE4KDr9W/3OE/d4Mym3p8Mk9twh9tlTBKUXFTt5mEp/58FVK0l69Mg2vq5wR
         1G6wfu8Y87sIvLLMv5dGEpONizVbIBrr6pfzTpLwp48yHHS57vIGluDdnOkaZog24VFk
         54iiK3jtXvBGRO8Z8gc2O2I+oQBjVRsmgZPKUU2XJINjflDRy24EWFMMuPlPEmRUStXL
         s0zUwG3nm3NCCW8yyyX9Ard2zlPjGJfDLd8ul/ckDfMaS9/0tWY+I5V6T+gWln/iR0C9
         sjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=m2PkWVzinhOCRo3IGzVGrt63/A23oKKmVsPMQyo7PTw=;
        b=slgQP8Hf5OyIlR0J9gB/qf4Iqch3QjVekid+EnL+J3vBlI/q0w9cN76mdfc+3ku4tu
         4OTkaEH3AmYkGDjHFePc7gbAFGdeUdnYWMUpEXrM9mgXwd3WZ+j51YeITUt1fvjI8J8A
         oZAnnaaV0F+648FcStyQiQ+VMbx/aCSxRi4e6LBbxoWCY3fRWcoMVbBCMNwWF3bkKjTz
         +YMlFAD30nbHCJ3/oUhCx1nUu1nohcCVhi5ggc1eIsXDmSNd+G598aYmijWMs+tKOfEF
         fHaC/ka1PNsSgiGJLHsh5U/trvF1Biz98f0k8FEFvrQ2KstGNuJqys5IXDO51pEw9jEv
         PUsA==
X-Gm-Message-State: AOAM530zQ4bgToUwJG6YxjI2sS0VQkJgRcFFYTCPEeumM2LIzcjKKVwC
        OUVD/1mxROwuTv4gvg7MyrOmyA==
X-Google-Smtp-Source: ABdhPJxxRV+PHI9ZVH/W3WGvcEF5g6VdV1A+fJNtMaleKWCAh48BmH1VvwKy91J85Gmd4o9G/ItHVg==
X-Received: by 2002:a17:902:be0f:b029:12b:6dff:2a22 with SMTP id r15-20020a170902be0fb029012b6dff2a22mr13666172pls.1.1627290153214;
        Mon, 26 Jul 2021 02:02:33 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id ce15sm37175324pjb.3.2021.07.26.02.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 02:02:32 -0700 (PDT)
Date:   Mon, 26 Jul 2021 14:32:30 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: remove WARN when no valid OPPs remain
Message-ID: <20210726090230.ghsxqzv3pjw55ell@vireshk-i7>
References: <aae042425e7a55d7d0f873cdfc3712953fb0df10.1627288191.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aae042425e7a55d7d0f873cdfc3712953fb0df10.1627288191.git.mirq-linux@rere.qmqm.pl>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-07-21, 10:30, Michał Mirosław wrote:
> This WARN can be triggered per-core and the stack trace is not useful.
> Replace it with plain dev_err(). Fix a comment while at it.
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/opp/of.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index c582a9ca397b..01feeba78426 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -985,8 +985,9 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
>  		}
>  	}
>  
> -	/* There should be one of more OPP defined */
> -	if (WARN_ON(!count)) {
> +	/* There should be one or more OPPs defined */
> +	if (!count) {
> +		dev_err(dev, "%s: no supported OPPs", __func__);
>  		ret = -ENOENT;
>  		goto remove_static_opp;
>  	}

Applied. Thanks.

-- 
viresh
