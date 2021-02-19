Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A73731F465
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 05:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhBSEUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 23:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhBSEU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 23:20:27 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D43C061786
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 20:19:47 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id o63so2768610pgo.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 20:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RhgTQl74piidFTPTNsaeD8Q6qRGbOi8PF5Wq06A31cU=;
        b=I1S3Nti/cUNdk13z1bTmsdz5anls7gH7p3S5WR6kZhvU6zj0tTMDwCaFvB8qZxyYpR
         APZpboPW2hbFSgW9lq8xEqClQMzP8VWK5z91RJaMSH9atf4CZzuUrMabKo1W1Gk7IqY1
         ycbAWm31ZsF+96DZxmbm0mL4cwjhXBCwUqVF31CHNBvc6nKGXEFkd/tmxPzLzwI8sm4c
         q8ar8xxe8hAenQsFTvtcVZbgC111x16wljs1H5TWEqY3iWSoKHorIlu1Qn5Z0zpnJbkV
         LcCV9+MyQtJR3EnOOpxVjGd9t1ExBcIiHTBEPAlhSza/5H1Zb9Hwx+QGFVMXQtPRdMN1
         5BEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RhgTQl74piidFTPTNsaeD8Q6qRGbOi8PF5Wq06A31cU=;
        b=X0cEgVCd9aBonO67v+DTzccgnN9mH8ohGtyyXjfgb9o63XPJXbC5nZl8MldQwjBLDI
         njQ0cCeyiCsUmSPPVYE9A5wGusLapjBXIuZGlIxT84MOOFMfr/UtFvP+td8DJ9+IA23H
         ooqBevNqKnoVFwLFYdTPrktucumqDruMde30maoIRh6LdhuIW1kwIxVJA0MzR2e4Tmti
         HYMoNHs6OQD9iW7RZw7U6w7TqjMmZk10xNX0EPzDeLFNGX5luSWzIoclcIp/S8qbqYd8
         ZAswbKTQPFPCkBX30bBaEg0IrKCDdzSWH8D+k9HfpipJJm8JLtwXllOIczXFuCuoLLw1
         2pUw==
X-Gm-Message-State: AOAM530CV73hBgmfKllj5vh2pnTdo9ML8s/tRtkXbvPKWRmhaEFHD6Wd
        ibGwvQZJw28vbO22mbjkaq2PxA==
X-Google-Smtp-Source: ABdhPJyPaNIXgMLopqD/ys5r76SceD3/rv5GP4z/uSiR+7J5jnUUKkebn2zFGX8AmOg0ryV0dphl0Q==
X-Received: by 2002:a63:d24e:: with SMTP id t14mr6801232pgi.348.1613708387229;
        Thu, 18 Feb 2021 20:19:47 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id m4sm6867987pgu.4.2021.02.18.20.19.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Feb 2021 20:19:46 -0800 (PST)
Date:   Fri, 19 Feb 2021 09:49:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nicola Mazzucato <nicola.mazzucato@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, sudeep.holla@arm.com, rjw@rjwysocki.net,
        vireshk@kernel.org, cristian.marussi@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        ionela.voinescu@arm.com
Subject: Re: [PATCH v8 0/3] CPUFreq: Add support for opp-sharing cpus
Message-ID: <20210219041944.uox45mesrabvfm72@vireshk-i7>
References: <20210218222326.15788-1-nicola.mazzucato@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218222326.15788-1-nicola.mazzucato@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-02-21, 22:23, Nicola Mazzucato wrote:
> Hi Viresh,
> 
> In this V8 I have addressed your comments:
> - correct the goto in patch 1/3
> - improve comment in patch 2/3 for dev_pm_opp_get_opp_count()

LGTM. I will apply them after the merge window is over. Thanks.

-- 
viresh
