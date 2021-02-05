Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAC4311182
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 20:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhBESIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 13:08:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:49190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233205AbhBEPU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:20:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F82864E37;
        Fri,  5 Feb 2021 17:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612544542;
        bh=mRLXcHycpqWz6RYXFguofgmcLIjLH8pb28gtXmfiZCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k3+Grm3Ba3qTErfUpaE6Q8Mj3x1WEQphDRx2WaMnWgsPGoHn66f5fmN/2yqCKCsyZ
         a6ZXinFwLp4coumI+IkweP08nYIKGzcpqmUZA/mvhs4zdon4YYGVqWCvF+j6PuTGsL
         9ONDjwilxLCBTJs1Y3FLFgMrgmsxOnP8ASrytGgeIyXan3XiS6S1YhOZnwMIeBCORN
         4oDGC85tMQ9dpqU6hVyZBxJ2BF7v0B/D+uhF1DxcIEZ2IgR1RPLSw/CudTRRkz7p+n
         0t5SB3l4MoLf+qoQRZg9+r4EcNpnXtjnAOAx1TeoiUbl2hBwFNrmJBD9ik0eC2eBlr
         ghaON+vxn2m9Q==
Date:   Fri, 5 Feb 2021 17:02:14 +0000
From:   Will Deacon <will@kernel.org>
To:     Lecopzer Chen <lecopzer@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>, ardb@kernel.org,
        aryabinin@virtuozzo.com, broonie@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        dan.j.williams@intel.com, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>, gustavoars@kernel.org,
        kasan-dev@googlegroups.com,
        Jian-Lin Chen <lecopzer.chen@mediatek.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, linux-mm@kvack.org,
        linux@roeck-us.net, robin.murphy@arm.com, rppt@kernel.org,
        tyhicks@linux.microsoft.com, vincenzo.frascino@arm.com,
        yj.chiang@mediatek.com
Subject: Re: [PATCH v2 2/4] arm64: kasan: abstract _text and _end to
 KERNEL_START/END
Message-ID: <20210205170214.GD22665@willie-the-truck>
References: <20210204124658.GB20468@willie-the-truck>
 <20210204145127.75856-1-lecopzer@gmail.com>
 <20210204145547.GD20815@willie-the-truck>
 <CANr2M1-=ONun5fLNoODftmfcuWw49hj9yXsrxkqrfCEtELX1hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANr2M1-=ONun5fLNoODftmfcuWw49hj9yXsrxkqrfCEtELX1hw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 12:06:10AM +0800, Lecopzer Chen wrote:
> I think it would be better to leave this for you since I'm not
> familiar with the relationship
> between vmemmap() and NUMA_NO_NODE.
> 
> So I would just keep this patch in next version, is this fine with you?

Yes, ok.

Will
