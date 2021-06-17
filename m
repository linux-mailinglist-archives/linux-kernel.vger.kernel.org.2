Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1C03AA99E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 05:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhFQDgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 23:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhFQDgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 23:36:01 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF0EC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 20:33:54 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id g6so3891393pfq.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 20:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YVqIcoZrg+RvpigGZrAOTiszoBMuUnCz4PKfzeq83ZY=;
        b=grYGYheRU7Z5BoMtwQEq1jIWb43Dk2CZv0mAYBvQYOdhEUD3GT1Fm7LFdjkcS4MnTH
         6iZzuRCfDIsGKhI5jma2NpGMnuX7ABB91nmn0MhTsxfM7IiYuRpDWvNgBaDjfN3LY+fN
         fu9CunPv3oHr7CPvZ15b0oBqOD4knAWm8wSbd68PlloYRWofFZ1d00iNCPjxyC/BUuCN
         OptcOGWJLO9g/0ihx/desuCEp6OGsMF60cX+YQr7IKBNBXmDOVHRURbMn+nLEgHCS+/9
         uVXuBJKOVc1bM2/b0adiksmRqYfKLzO5fkopDs0wiqCmVSn642Z+t3NnjvKCK0xq9Aox
         75tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YVqIcoZrg+RvpigGZrAOTiszoBMuUnCz4PKfzeq83ZY=;
        b=BeVtN/4H0be8sPknARWKsqw8uTIpYFPJbC5/A4BMCR7EumQ8wVlpLYRWh+vvJMh8FG
         XZTua+DGEcJjX1laLNZMsEpppxTujljHTOmYATSb1M3tE7B3z4IJ06lnL7hziJ0US0mh
         J1VO3/H54Jsas952RrB2VtGrq+D/59TiQuaBuaCkhEhWrTyUZoxWWdTyKeqGuUR2hc4H
         co2y/YRdhgAGLHqMUoyCxJJyrY8bUZdQdPDf9Ai8+yPFij4qi0kfMyG5SJiyk+kZJKG0
         gtnLzpmobfbgZQNeiWbV2RDC6YV4dKWiOgHliCcNNVSRCdWnJ+f1hQnUk2kh9xVH0jRn
         rO+w==
X-Gm-Message-State: AOAM530p3PCQxIScQ3zpWQEguBmQOnEjK2AN6aBd3MpqcdlPsZ+izSRF
        Kty2qqQzbwCaP1xUgaaBFMh/yw==
X-Google-Smtp-Source: ABdhPJyfP347OmSV3zgOULaptwnvXPrmS4Z/2QXEmXpeF1PtnyjH0buQ3wcVIDM54lin3E8JHdQp+w==
X-Received: by 2002:a62:5e04:0:b029:2ea:a8dc:25d3 with SMTP id s4-20020a625e040000b02902eaa8dc25d3mr3235715pfb.6.1623900833560;
        Wed, 16 Jun 2021 20:33:53 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id a20sm3522211pfk.145.2021.06.16.20.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 20:33:52 -0700 (PDT)
Date:   Thu, 17 Jun 2021 09:03:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        "Viresh Kumar )" <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "andrew-sh . cheng" <andrew-sh.cheng@mediatek.com>
Subject: Re: [PATCH] opp: of: Allow lazy-linking of required-opps to non genpd
Message-ID: <20210617033351.44pxdpjicm62byuh@vireshk-i7>
References: <20210616053335.4181780-1-hsinyi@chromium.org>
 <CGME20210616075555epcas1p136129544501878b4bedaf8e46f9a43dc@epcas1p1.samsung.com>
 <20210616075548.ghp3lmjf4y6pyxoy@vireshk-i7>
 <b9310754-2105-2a93-ecbf-513d9a80a91a@samsung.com>
 <20210616090945.sn337tftdcp7y7y6@vireshk-i7>
 <742b2623-e8ff-db1f-9168-bdbde98110dd@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <742b2623-e8ff-db1f-9168-bdbde98110dd@samsung.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-06-21, 10:13, Chanwoo Choi wrote:
> The devfreq driver(exynos-bus.c) has used the dev_pm_opp_set_rate()
> and used the passive governor without the required-opp property.

Which is fine.

> I have a plan to use the required-opp property
> between devfreq drivers (exynos-bus.c) with dev_pm_opp_set_rate().
> 
> I'll support them on later if this approach doesn't break the any
> rule of required-opp property.

You will be required to make some changes in core for that I am
afraid. It won't work automatically.

-- 
viresh
