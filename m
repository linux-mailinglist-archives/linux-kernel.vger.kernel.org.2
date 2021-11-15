Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242BC451DBC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351401AbhKPAc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345291AbhKOT2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:28:00 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC68C055342
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 10:48:35 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id z10so49743980edc.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 10:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ysuEr0u02GPrsnGGmLrkUAjMpAgf4SZgK4tloxt9aPs=;
        b=RLq4N3dvxag78VGv0pC4uxFpugPrZ/T3Ke9Ieh2AuPoSCP2/eQRmALMLo0L/Uyu6SV
         nVvF2Boj1rD7nj0cho4G05mJlkLEmu1aFd+p5anfaLy3DoUPwSx7hmvBYx7pNkRV6xPU
         O6euG2f7im6feJKdjM2mbeMuKgx4abcHxj6rmLSw80XBPVc63u/iFXRmIVP5eCummOe/
         hUxTORpKUWJqbGpb+F+3w1WRr+bb+78YiTwLtO3FXQvVmkLBL0bV1bHa6jtv5Y+r3yup
         1l0VYjp02SCJ33YTP73Q3ng1nuh5XB1qwdshKCmE4Smri+uceg4+8e4LFtRy2rIs4Cwq
         gqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ysuEr0u02GPrsnGGmLrkUAjMpAgf4SZgK4tloxt9aPs=;
        b=gCvHO3/ugLYscjsWUYjmZP+y/LFRngZHeWmpJjy6IeE31FLK5Ttdo1CTtfhTmue/xa
         jupGb2fpw5zZ+/sH4Eg57/2NHXEHDFKdW6nJ9Oc+nC+Qb/lsunJlLTooGe1LAMi/IAGS
         R2LY/FZtIxVKqNtVx3mTU+uwWvsk5NK7TOYVLViFZ7laKtLLVk8Y+oQVDCJcBAeQxPsy
         pltr1e5BEBF0yf+ApEL8SGgDChNpYCIJrwdhRfS6/iOBTOpNx9cE+sBZCxlX/FzGVEHh
         54J1BMl+fDZIMcFVgON1XxqdZnE/D/JtRdzFzE5fiu4V2jjCR2rBghJEInPZVxRp6CQ6
         mPYw==
X-Gm-Message-State: AOAM531kJVEk0C8Mi6lOOjTM2sBXjF6ny+1ihmvngJiIK/UjeOvR4BFP
        Asz8By0h8JmbvF00AC/qwW8HBg==
X-Google-Smtp-Source: ABdhPJxgMJf1ypEFOS06Pxotij3gl5ZeBSb0i+a/uNgv+kAjGD2Cscn3KhEg0ZOnaw7sQeHTvpaclg==
X-Received: by 2002:aa7:cc0c:: with SMTP id q12mr1230154edt.169.1637002114523;
        Mon, 15 Nov 2021 10:48:34 -0800 (PST)
Received: from apalos.home (ppp-94-66-220-79.home.otenet.gr. [94.66.220.79])
        by smtp.gmail.com with ESMTPSA id u16sm7892690edr.43.2021.11.15.10.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 10:48:34 -0800 (PST)
Date:   Mon, 15 Nov 2021 20:48:30 +0200
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@openeuler.org,
        hawk@kernel.org, akpm@linux-foundation.org, peterz@infradead.org,
        will@kernel.org, jhubbard@nvidia.com, yuzhao@google.com,
        mcroce@microsoft.com, fenghua.yu@intel.com, feng.tang@intel.com,
        jgg@ziepe.ca, aarcange@redhat.com, guro@fb.com,
        "kernelci@groups.io" <kernelci@groups.io>
Subject: Re: [PATCH net-next v6] page_pool: disable dma mapping support for
 32-bit arch with 64-bit DMA
Message-ID: <YZKrfvt01uTosWc8@apalos.home>
References: <20211013091920.1106-1-linyunsheng@huawei.com>
 <b9c0e7ef-a7a2-66ad-3a19-94cc545bd557@collabora.com>
 <1090744a-3de6-1dc2-5efe-b7caae45223a@huawei.com>
 <644e10ca-87b8-b553-db96-984c0b2c6da1@collabora.com>
 <93173400-1d37-09ed-57ef-931550b5a582@huawei.com>
 <YZJKNLEm6YTkygHM@apalos.home>
 <YZKgFqwJOIEObMg7@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZKgFqwJOIEObMg7@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Mon, Nov 15, 2021 at 09:59:50AM -0800, Christoph Hellwig wrote:
> This is just popping out of nowhere on lkml, but yes ARM LPAE
> uses a 64-bit dma_addr_t, as a 64-bit phys_addr_t implies that.
> Same for x86-32 PAE and similar cases on MIPS and probably a few
> other architectures.
> 
> But what is the actual problem with a 32-bit virtual and 64-bit
> pysical/dma address?  That is a pretty common setup and absolutely
> needs to be deal with in drivers and inrastructure.

page_pool (the API in question), apart from allocating memory can manage
the mappings for you.  However while doing so it stores some parts (incl
the dma addr) in struct page.  The code in there could be simplified if 
we skipped support of the 'mapping' feature for 32-bit architectures with 
64-bit DMA.  We thought no driver was using the mapping feature (on 32bits)
and cleaned up that part, but apparently we missed 
'32-bit -- LPAE -- page pool manages DMA mappings'

Regards
/Ilias
