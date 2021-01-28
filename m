Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525B2308196
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 23:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbhA1Wz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 17:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbhA1Wwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 17:52:36 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C1FC061355
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 14:48:46 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id s23so4018435pgh.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 14:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=jRc+9koAFnFriBYMbCECl8bNtNHOFnGAZDdGQS3iVDU=;
        b=VX8To19226WV8RDTkFQ5ObLuNZF9XVTO28Kn6srr7oOvy3bJROldWKCMUzp1PQKXf9
         DxW/pzBX8qvpyf9JYyEV0tsfWnIQwh8StSLFabjSv9bq/h+LrM8BcShVwk+8h5JEIVAC
         m7rR/FINIdZ5nzLJ4PtqwDLyuNTB4ApMNbGX1tO8SauTFQvq0jZUXb6tQjVnZTTurC4o
         JnT9bk1zHAxQ/KJOZ2l5CO8dDG2tvWtV2Yqs/XVrEpJuA4GCbDFdVRNie/dpc5yVuHhc
         6tpUXWl/fB3cIiNkDeifZnbig6ARvwbuNY0PAKYEKLOUWsV+N9z5P3YBgnwxTr3v/Wvb
         uKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=jRc+9koAFnFriBYMbCECl8bNtNHOFnGAZDdGQS3iVDU=;
        b=duKZcY8N+J+bAhQJ1PswxPN8QQ3/t6m71DwjkoR03G8o5mIfKZbADzCwKNRsXFcyOJ
         jWsg9yDqSb29zj4RwxYt2KQmhbkpV22KTPlIymrTe1hrjQ8atJKW5oTrGoBb8cVt8YYW
         cJGgfMacJId0x+6sop0+fFql7tOWxtYad4+YRFJGfjkvwD543PWW4tfUTfiHLs7wVNrW
         YocKdL+tu3ECRhMFWbRcwN3y+c/C3DYs8U65SWFk8+oX0DTan1+2s8SUOCjEJsio4Jak
         TYr0wXTMBynrNjpmtHLwXNrWBVBYmgznP+dO9rBPKvFBDS8M42Xu3sEdXj1R/YF+E7Ab
         p0Xg==
X-Gm-Message-State: AOAM532wxlFlubYpksXF/UH0yl3t4Tl/VO18K0oXVVU+BBeEwrqSUuTd
        Pq7UDwPTdo6JErcQsDkSn0vzCA==
X-Google-Smtp-Source: ABdhPJwBVbXS8W3fPe5c+jU1CL/MRyTOw1r5xPcMxMQku9sVK6cWDkTe2rvBDuGwi5tcagKuWF06SA==
X-Received: by 2002:a62:f943:0:b029:1a5:43f9:9023 with SMTP id g3-20020a62f9430000b02901a543f99023mr1512252pfm.75.1611874125638;
        Thu, 28 Jan 2021 14:48:45 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id v1sm7110414pga.63.2021.01.28.14.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 14:48:44 -0800 (PST)
Date:   Thu, 28 Jan 2021 14:48:43 -0800 (PST)
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
Subject: Re: [PATCH v2 net-next 3/4] net: introduce common
 dev_page_is_reserved()
In-Reply-To: <20210127201031.98544-4-alobakin@pm.me>
Message-ID: <d8e86f1a-d2a6-d8af-142c-f735fd3be9f2@google.com>
References: <20210127201031.98544-1-alobakin@pm.me> <20210127201031.98544-4-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jan 2021, Alexander Lobakin wrote:

> A bunch of drivers test the page before reusing/recycling for two
> common conditions:
>  - if a page was allocated under memory pressure (pfmemalloc page);
>  - if a page was allocated at a distant memory node (to exclude
>    slowdowns).
> 
> Introduce and use a new common function for doing this and eliminate
> all functions-duplicates from drivers.
> 
> Suggested-by: David Rientjes <rientjes@google.com>
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>

Looks even better than I thought!

(Since all of the changes are in drivers/net/ethernet/, I assume 
everything directly or indirectly includes skbuff.h already.)

Acked-by: David Rientjes <rientjes@google.com>

Thanks for doing this.
