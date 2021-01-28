Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E493D308193
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 23:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbhA1Wz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 17:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbhA1Wwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 17:52:49 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BC1C06121F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 14:49:30 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id h15so4177581pli.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 14:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=G+ih4TCLjMlDhHUsK2A+TR2HHdkm5AqUa1C6G/BSwSU=;
        b=MtFfpkPTsZTn0gFaHxFhSWOMva66E/lvz+hUXR3FrCHa9T0vjY+xbhdIBytnfT4hde
         0Ys5AJYDByRiNPKT0aWC33/ZwpGaEnDVdDZLHxgNhDamHGH+rUdr/YNIrHzbogxyK2ot
         0DoGbhkKgR6CODspeFMH0JINuzKgti7159D7tR9XKwR9K09g/4AR5nAIex+fNblniZwf
         nuLbHpvajXVngPXWUmYWJr62ll4sVI6GL9+9DOw2ps6euNFMlJMMKUqLwUBvfOr4+JOI
         dE/ui+K9GxRvn1sNUBZjR8TFkXXLIPq75nHYRfA916R0qHMnMt7BOLu7EI21THYWQnjm
         aX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=G+ih4TCLjMlDhHUsK2A+TR2HHdkm5AqUa1C6G/BSwSU=;
        b=ZdS8O7J1OPANEea2B8Uapgq1VgdL0lN50Mil7oHT/WFzvqztOt13jbFrRzuPSrZhxM
         89pU38aT2XcirNsWfRQdanDdeNXxz1OTW5/f00NhcAHC5UZbawBbsKDbWVrQLm75QC48
         qvoI/k1nW+ZTUehU1sr6nFxAbHYsOwGDpn7F+T6wJ+S/YnpPjG0+kBvvUm4m0r4zv+HP
         8vipud8taz7N5mC4SvDwDDP13O+VHemcNFH9IR4On2z2SBfn2RHmuO7s0Xu7Vys38osH
         WsF6S0VWaDYi9zi1dvtlAFIcZCQxs3U3Darwo/TA8Epcm/3o9qLfwC82IUVF1qyUUdYv
         C8hQ==
X-Gm-Message-State: AOAM530x8sv+jjQs9Ya0HxoWeXEwbZA9E7uejVlHRMVGizI0/NNVNnjj
        vwYXOK6oaqvyVsVAAvte4yPl3Q==
X-Google-Smtp-Source: ABdhPJyfRuzHyqHVdqBK8f0+yDGR+PAfYB5Dc8yFBfd7wqG+BeYIWPtIjMNVkXFepyiH+P/AGil0yA==
X-Received: by 2002:a17:90a:470f:: with SMTP id h15mr1601393pjg.179.1611874169526;
        Thu, 28 Jan 2021 14:49:29 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id u126sm6508563pfu.113.2021.01.28.14.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 14:49:28 -0800 (PST)
Date:   Thu, 28 Jan 2021 14:49:27 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Alexander Lobakin <alobakin@pm.me>
cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Willem de Bruijn <willemb@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Dexuan Cui <decui@microsoft.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Marco Elver <elver@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 net-next 4/4] net: page_pool: simplify page recycling
 condition tests
In-Reply-To: <20210127201031.98544-5-alobakin@pm.me>
Message-ID: <7ac4064-b63-b26f-10db-68b83e6d4c6@google.com>
References: <20210127201031.98544-1-alobakin@pm.me> <20210127201031.98544-5-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jan 2021, Alexander Lobakin wrote:

> pool_page_reusable() is a leftover from pre-NUMA-aware times. For now,
> this function is just a redundant wrapper over page_is_pfmemalloc(),
> so Inline it into its sole call site.
> 
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Acked-by: David Rientjes <rientjes@google.com>
