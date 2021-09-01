Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0393FD27E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 06:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241850AbhIAEmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 00:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235238AbhIAEmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 00:42:16 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2017C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 21:41:19 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id w7so1467989pgk.13
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 21:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q8k8JI5FQuW1Mw9/upEhUeHBL2hwhBOt8kVZIdnHXcM=;
        b=ueFckocskygmdIn2npYotKsJ8yZNB4RDDxCogdztDyt0UjXi/gKpdgxTc0azraVN98
         x0N2N/nV/Mm1iQDinTlHP10SApFsAFNDOrDVccJ5TVAAKugUdL9+mH6AXwJKEavP6JaS
         FvKqNtFh8JwKNwfJ25n4FXeEQ+qJ+yzrS/fsGAWAaX2kBJrkgjQ+FY+B7yE9b+sOqva+
         ky5j8HqwIO2/lfp6OBFcMW+SV9l4yJ9zvtlVNSzTqDepMiyBuFEpmShLomOPoIuuagtn
         XrIfTVSJ+09PCCRKYqODyjBMGA2CRObHy1MVidxo6/c/CRqU1wUYS8EWY4duv4M9BWEL
         o2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q8k8JI5FQuW1Mw9/upEhUeHBL2hwhBOt8kVZIdnHXcM=;
        b=s/4gkzor+j7IKjTdHwMiaQ+lJrr4TYHrUrGEBsfAaXWNoc77VhCh2Ij0a5fbxDJodq
         Is33sNAlVPcDXl0q/VkFM55xSoRZpkh4uwqi5g/rxTrE9GeMYwCkM1gv/qkgKdhBqHjd
         tCziZAAxlS2l3oDK7FTIamBCG98qAjbPwsh/1MyFUhbmQ0A512n5u/Rdc5crFWNXGS90
         NrzFlL5VOK41Rstf0HBibVKD+/X5XLjT0v7hI2/87P2t1Y96LWhJQAKPeqoXX+YKQjVy
         SBbp/XtfBsbuujPIJsS8+weAxBUKdQjqlN6qLyhhQR2wMrQtjT4hYUpNIGA713oGvIoz
         /spQ==
X-Gm-Message-State: AOAM532UOPNbhKPPQ3UrBTJHjlrnXfhxYL6nv48WhPVlx/NdrycPNjAX
        ZnxU5qJaqG1TL6CTbCJyiEmTXA==
X-Google-Smtp-Source: ABdhPJx5eWyZvUYCrsUn5TYkBM2Bd9wtBSNTavsfmJkMqa/KnwmVLuEH80r9qecitwRqDFzv8gNF8g==
X-Received: by 2002:aa7:8014:0:b029:3cd:b6f3:5dd6 with SMTP id j20-20020aa780140000b02903cdb6f35dd6mr31875202pfi.39.1630471279492;
        Tue, 31 Aug 2021 21:41:19 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id a21sm21633013pgl.51.2021.08.31.21.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 21:41:19 -0700 (PDT)
Date:   Wed, 1 Sep 2021 10:11:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v10 3/8] opp: Change type of
 dev_pm_opp_attach_genpd(names) argument
Message-ID: <20210901044117.abfwfebqw5lbn5zj@vireshk-i7>
References: <20210831135450.26070-1-digetx@gmail.com>
 <20210831135450.26070-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831135450.26070-4-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-08-21, 16:54, Dmitry Osipenko wrote:
> Elements of the 'names' array are not changed by the code, constify them
> for consistency.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/opp/core.c     | 6 +++---
>  include/linux/pm_opp.h | 8 ++++----
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 602e502d092e..d4e706a8b70d 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -2359,12 +2359,12 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
>   * "required-opps" are added in DT.
>   */
>  struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
> -		const char **names, struct device ***virt_devs)
> +		const char * const *names, struct device ***virt_devs)

I am sure there are issues around space around * here. Please run
checkpatch with --strict option for your series.

-- 
viresh
