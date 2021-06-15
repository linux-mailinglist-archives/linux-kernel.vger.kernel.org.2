Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D923A77DA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 09:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhFOHWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 03:22:08 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:64239 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhFOHWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 03:22:06 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20210615072000euoutp0281a09b1e355476e298035fd3a4d998ba~IsGHdJJcv1005110051euoutp02g
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 07:20:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20210615072000euoutp0281a09b1e355476e298035fd3a4d998ba~IsGHdJJcv1005110051euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1623741600;
        bh=SL1Ft6VWY/RjURdlPpMzqSKXBcYq78k+CzNlalELtNw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=hi0zIQS4kkXjEU/jx++6vUsap0kOPkcI+d/ACPPczOkJEXGPgZtKZdS+EMkvSi3Qe
         oR0KJ+XrL+eN/ZZnmTB66WKTgTdEGwo/bm675pIE6vAOJkJcFqwE4zlkxea9/TB8Cu
         bZ2CFGBcA5SkkcUw7Fd5wAFAlkAJipN4rwzQqpEA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210615071959eucas1p17d73b40993aca625921fa2df1175e2ff~IsGHFn4ot2709327093eucas1p12;
        Tue, 15 Jun 2021 07:19:59 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 90.70.09444.F9458C06; Tue, 15
        Jun 2021 08:19:59 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210615071959eucas1p29ec7b2d9fa2f206a99cd3ec757e4a6bf~IsGGtUCjs1417614176eucas1p2W;
        Tue, 15 Jun 2021 07:19:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210615071959eusmtrp1e135f6e3b85c08046694ef8b87a1a6d5~IsGGsgOEV2144721447eusmtrp1G;
        Tue, 15 Jun 2021 07:19:59 +0000 (GMT)
X-AuditID: cbfec7f4-dd5ff700000024e4-be-60c8549f0815
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 18.10.08696.F9458C06; Tue, 15
        Jun 2021 08:19:59 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210615071958eusmtip12e3c533f64d669cab1d9e3f5aab42c52~IsGGF7Mdn2836228362eusmtip11;
        Tue, 15 Jun 2021 07:19:58 +0000 (GMT)
Subject: Re: [PATCH 1/1] dma: coherent: check no-map property for arm64
To:     Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Dong Aisheng <dongas86@gmail.com>,
        Will Deacon <will@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        iommu@lists.linux-foundation.org,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <7729cff3-27b4-c233-7f53-95f6140d3828@samsung.com>
Date:   Tue, 15 Jun 2021 09:19:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210614153603.GA1998@lst.de>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPKsWRmVeSWpSXmKPExsWy7djPc7rzQ04kGDxuUrb4MnUXs8X7ZT2M
        Fn83T2ezWLn6KJPFgv3WFpseX2O1uLxrDpvFvTX/WS0OfnjCatFyx9SBy2PNvDWMHjtn3WX3
        2LSqk81j06dJ7B6bl9R7TL6xnNFj980GNo+N73YweXzeJBfAGcVlk5Kak1mWWqRvl8CV8blj
        PkvBI+6KS03b2BsYj3J2MXJySAiYSNw8uZCti5GLQ0hgBaPEpDOHmCCcL4wSxz+9Z4ZwPjNK
        HNrfxwjTsuXgU6jEckaJ251drBDOR0aJiQtvsncxcnAIC7hLLF6SANIgAmQu6z0GVsMs8IBJ
        4vae32wgCTYBQ4mut11gNq+AncStg+3MIDaLgKpEx8p+JhBbVCBZ4v28GawQNYISJ2c+YQGx
        OQW0JU5c3gxWwywgL7H97RxmCFtc4taT+WA/SAj0c0r0/rvEBnG2i0TjxKmsELawxKvjW9gh
        bBmJ05N7WCAamhklHp5byw7h9DBKXG6aAfW0tcSdc7/YQF5jFtCUWL9LHyLsKPH14Q6wsIQA
        n8SNt4IQR/BJTNo2nRkizCvR0SYEUa0mMev4Ori1By9cYp7AqDQLyWuzkLwzC8k7sxD2LmBk
        WcUonlpanJueWmyUl1quV5yYW1yal66XnJ+7iRGYxk7/O/5lB+PyVx/1DjEycTAeYpTgYFYS
        4T1cfzxBiDclsbIqtSg/vqg0J7X4EKM0B4uSOG/SljXxQgLpiSWp2ampBalFMFkmDk6pBqYp
        mb2ytQev1Xv1TjepaP3l/il261KWg7+UUzlcfYwZHwRsebq6LJb9fWw7o5W3i5dVtlzageXx
        C3oKWeZ/ei2i8H6l7wfzF29d1u/5tF046/7ilwu55ZanqmwrPOqkel1J/9HD1XJW0awsX5J8
        21dMb0oI/f4473gdU0gYe9LjIO7lfzW+zdjLGmG8g+PzA64n5bsuev3eGTYx70mXw5XYb+En
        nt+cWZDj+Xff50CnKPvlqsFul6r3F032XN2x7+fGleEr79kzLcnTsA6tjYxuipnnLiLenu6v
        ftOuYD0nc/ujtJ1Z2rHrPKTF3SuEdvbULFh/Qkp3P3tfefixPpHjuRZpAZ69Jc3bO9KjlFiK
        MxINtZiLihMBAdtLWtIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsVy+t/xu7rzQ04kGJybzG7xZeouZov3y3oY
        Lf5uns5msXL1USaLBfutLTY9vsZqcXnXHDaLe2v+s1oc/PCE1aLljqkDl8eaeWsYPXbOusvu
        sWlVJ5vHpk+T2D02L6n3mHxjOaPH7psNbB4b3+1g8vi8SS6AM0rPpii/tCRVISO/uMRWKdrQ
        wkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEv43PHfJaCR9wVl5q2sTcwHuXsYuTk
        kBAwkdhy8ClzFyMXh5DAUkaJ249mM0MkZCROTmtghbCFJf5c62KDKHrPKPFkfw9LFyMHh7CA
        u8TiJQkgNSJA5rLeY6wgNcwCD5gkXm3YzALR8J1JYvqvQ0wgVWwChhJdb0EmcXLwCthJ3DrY
        DraNRUBVomNlP1iNqECyxM/17VA1ghInZz5hAbE5BbQlTlzeDFbDLGAmMW/zQ2YIW15i+9s5
        ULa4xK0n85kmMArNQtI+C0nLLCQts5C0LGBkWcUoklpanJueW2ykV5yYW1yal66XnJ+7iREY
        t9uO/dyyg3Hlq496hxiZOBgPMUpwMCuJ8B6uP54gxJuSWFmVWpQfX1Sak1p8iNEU6J+JzFKi
        yfnAxJFXEm9oZmBqaGJmaWBqaWasJM5rcmRNvJBAemJJanZqakFqEUwfEwenVAPTxnsffx5J
        7j2rzVBTE6kRUFzbuKjzIbfFwc0XpENZd1hq9npVVpeptNptYN3U9kZd6onmPN/at9Lnprku
        6mG7Vz6B/0lJzLIHm3S68/3EkrWWX738TWv53cDf175fXdCyd9/dtVGfY7+qWNWlOxolslzZ
        f1zQ7eiDZfKqpza133FbJ3Fp7kyTqSfu2pYeclok3GydkBK+Y4ZMsWmLfOWZQqPzfOnTONwE
        3255VsGuqLPhoXlAzo4Jz6d/2O53Kv+R50qjZhnjYpu5oQ3yUVMTj87M7v7r+uIg/4stl1ds
        4LVs083LFon3qUqST/zEJTbxkyOrLtdjXq2DXIoRbt7TGlv6UqdeOyb9eq5g+F0lluKMREMt
        5qLiRAD3b3J/ZAMAAA==
X-CMS-MailID: 20210615071959eucas1p29ec7b2d9fa2f206a99cd3ec757e4a6bf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210614153610eucas1p209898b2e8dc013fe6ef072060609c21d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210614153610eucas1p209898b2e8dc013fe6ef072060609c21d
References: <20210611131056.3731084-1-aisheng.dong@nxp.com>
        <20210614083609.GA18701@willie-the-truck>
        <CAA+hA=S8x4S0sgAiJbqOC-wgtOshV_jhAq6eVqX5-EAeg3Dczg@mail.gmail.com>
        <20210614145105.GC30667@arm.com>
        <6f897830-301f-3eb4-785f-de446476e676@arm.com>
        <CGME20210614153610eucas1p209898b2e8dc013fe6ef072060609c21d@eucas1p2.samsung.com>
        <20210614153603.GA1998@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 14.06.2021 17:36, Christoph Hellwig wrote:
> On Mon, Jun 14, 2021 at 04:34:05PM +0100, Robin Murphy wrote:
>>> Looking at the rmem_dma_device_init() -> dma_init_coherent_memory(), it
>>> ends up calling memremap(MEMREMAP_WC) which would warn if it intersects
>>> with system RAM regardless of the architecture. If the memory region is
>>> nomap, it doesn't end up as IORESOURCE_SYSTEM_RAM, so memremap() won't
>>> warn. But why is this specific only to arm (or arm64)?
>> Didn't some ARMv7 implementations permit unexpected cache hits for the
>> non-cacheable address if the same PA has been speculatively fetched via the
>> cacheable alias?
> If we care about that we need to change these platforms to change the
> cache attributes of the kernel direct mapping instead of using vmap.
> We already have code to do that for openrisc, someone just needs to
> write the glue code for other platforms.

ARAIR there is a problem with changing cache attributes of the direct 
mappings on ARM 32bit. The whole lowmem is mapped with 2M 'section' 
mappings. Changing cache attributes causes 2 issues. First - one would 
need to split 2M entry into 4K entries. Second - 2M section mappings for 
the whole lowmem area are located in the per-process page tables. 
Changing the cache attributes would require locking all processes and 
iterating over their page table entries, which is a huge task.

Best regards

-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

