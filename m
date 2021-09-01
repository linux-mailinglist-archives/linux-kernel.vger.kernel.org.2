Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872EB3FD3AA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 08:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242223AbhIAGGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 02:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242148AbhIAGGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 02:06:17 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B00C061764
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 23:05:20 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id r2so1664826pgl.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 23:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EyJuGn8lU3B/NQmQ+F0Gr7GFa88roaDiQ1XSKR7WpgU=;
        b=Iv4SdfAQ6JYYeQeBWQWRc2NSbGPphdIFylJZQ6CG8Fhm0h+k3u599YMDiqDlcPsvI9
         S7NfbeSQDdqLL4pco4ohsatTpHl7B+pPuN7Sf5x0SSTvgPCm67YdEe1jq1RyHCy5fnoL
         Y61u+eBK3iU2cwZyT3Rms+ed3qepElUnIGI1utGIxDapexCdvw3vENjXUecJcGoy2XmL
         V+VKoGkrD1LqzKN9o39VLzk2tYPYrs9684KUgxe1lK3rud+HPdJuxJ+kLzErV+hUzgQu
         R/a2tOFs93nVM1zm4k9bajmTxJgKC8vHAeu2BUy365WtI80Av7uovePoWj2N0TSYzdML
         +e+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EyJuGn8lU3B/NQmQ+F0Gr7GFa88roaDiQ1XSKR7WpgU=;
        b=c6vTNT3pewUeKHkFH7jBRA6azNjzUQYLWxLr35o/zfzv/xDb3Iz2LXNUqtOgQNLJgr
         /vLUWO6xKKKmEYPPgf1BTtUs46IUn+2JmDantyD93qc5VZiKQ4UKtsy7IqGDReHISJiD
         COnnKE7h0sR44oCXpkknxTWsITDFYzQ1UeGI3998K5/zH1maNNgFkZkAMspJqNESbGjL
         EJ7YNHYlSQ5lt10er8jmET+to3QfcudzzCPGFG4auDOTl9+cNeU8K2PNe2cjppZSZjlb
         ovSofFdQzLNOAhP6mlwStiApgl4TPeZRpE1IJhYk0yqqowfhdeUJyF1n3T2Vfb+cfUoH
         RoEA==
X-Gm-Message-State: AOAM530wLchakrRLTiJQcKc8XV940s1XNirq4lWfv0nQ6SMevafLcbDX
        HqvjlsB6Ydqsc5e5aOA6Uv6J7A==
X-Google-Smtp-Source: ABdhPJw7MMZ+vkCKUSYJMPruV7ag6WBQqZfid3Yt32sYpnZFZaoTQ7oXZiWOPjgPnzmtfJ4S1r0qww==
X-Received: by 2002:aa7:8718:0:b0:405:1645:16c3 with SMTP id b24-20020aa78718000000b00405164516c3mr7293043pfo.32.1630476320273;
        Tue, 31 Aug 2021 23:05:20 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id l2sm18658730pfc.157.2021.08.31.23.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 23:05:19 -0700 (PDT)
Date:   Wed, 1 Sep 2021 11:35:18 +0530
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
Subject: Re: [PATCH v10 1/8] opp: Add dev_pm_opp_get_current()
Message-ID: <20210901060518.yxkmpjfljt7yj53p@vireshk-i7>
References: <20210831135450.26070-1-digetx@gmail.com>
 <20210831135450.26070-2-digetx@gmail.com>
 <20210901043953.va4v3fwgs6ldtwar@vireshk-i7>
 <e9d9f288-fe37-a6f5-2f5f-fba227dba0c7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9d9f288-fe37-a6f5-2f5f-fba227dba0c7@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-09-21, 08:43, Dmitry Osipenko wrote:
> You will get OPP which corresponds to the lowest freq, while h/w runs on
> unsupported high freq. This may end with a tragedy.

Yeah, because you are setting a performance state with this, it can be
a problem.

-- 
viresh
