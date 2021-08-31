Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7189C3FC931
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 15:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbhHaOAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 10:00:23 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:23508 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbhHaN7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 09:59:12 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20210831135815euoutp013b042dcb3dd8fdf1c9154242d432e53b~gaM0_7mgE0321103211euoutp01P
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 13:58:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20210831135815euoutp013b042dcb3dd8fdf1c9154242d432e53b~gaM0_7mgE0321103211euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1630418295;
        bh=KLx+wB6fGjZ+uzwRdYhEHqROGtQk40hFjJq/qzshiXg=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=gaK9zA+wzm58PDfJgKHz40bPP12ZVtjPd5dEIddmp//5M9X6lIrmMq+HGqgntuSbb
         P2JS4JZ4YVoCtJuCjMAjDyxvJ/MZUYlsvBYckwPJFC0ZQjH8K4QNAkb6tuJShV7n2l
         LrGd08pcveVrvU2bWPvo6zxOK95y7bMvnG+28V9o=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210831135815eucas1p20597d52838acc6f1d6a76f869b2a7b25~gaM0mgNka2260822608eucas1p2k;
        Tue, 31 Aug 2021 13:58:15 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 6D.6A.42068.7753E216; Tue, 31
        Aug 2021 14:58:15 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210831135814eucas1p24ce3aa6c3d1fee0055bdfa04a875044d~gaM0E44Tw2260822608eucas1p2j;
        Tue, 31 Aug 2021 13:58:14 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210831135814eusmtrp2b0864f230ef1fd8c14ab76ec68e6831c~gaM0D9HJF2254422544eusmtrp2v;
        Tue, 31 Aug 2021 13:58:14 +0000 (GMT)
X-AuditID: cbfec7f4-c89ff7000002a454-d3-612e35770c47
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E7.42.20981.6753E216; Tue, 31
        Aug 2021 14:58:14 +0100 (BST)
Received: from [106.210.131.79] (unknown [106.210.131.79]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210831135814eusmtip1518535899bd3d7458c1ee0d4f2bcb7f8~gaMzfAZQ21720917209eusmtip1t;
        Tue, 31 Aug 2021 13:58:14 +0000 (GMT)
Message-ID: <5ef0c227-555d-a12c-1685-ff43e43bdf97@samsung.com>
Date:   Tue, 31 Aug 2021 15:58:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:92.0)
        Gecko/20100101 Thunderbird/92.0
Subject: Re: [PATCH] drm/bridge: cdns: Make use of the helper function
 devm_platform_ioremap_resource()
Content-Language: en-GB
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
In-Reply-To: <20210831135048.4305-1-caihuoqing@baidu.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsWy7djPc7rlpnqJBvO/iVr0njvJZLHm3l82
        i//bJjJbXPn6ns3i+fx1jBYn31xlseicuITd4vKuOWwWh/qiLT7NesjswOXxZWkzs8f7G63s
        Hnu/LWDx2DnrLrvH7I6ZrB4nJlxi8rhzbQ+bx/ZvD1g97ncfZ/L4vEkugCuKyyYlNSezLLVI
        3y6BK2P+vW1sBTuZKu5+mMLUwNjL1MXIySEhYCJx7ddl1i5GLg4hgRWMEs/WbmSGcL4wStz6
        uxwq85lRYnLbXRaYluV33jJBJJYzSsw+eo8FwnnPKNEweR0jSBWvgJ3E9G9H2UBsFgFVidc/
        HrNAxAUlTs58AmaLCiRIPF/6FewQYYFMiX0rDrKD2MwC4hJNX1aygtgiAmoSUyZNZwdZwCxw
        n0niye/nzCAJNgFNib+bbwIt4ODgFLCU+PCJH6JXXqJ562ywHyQEpnNKLNm8AepTF4lFVx4w
        Q9jCEq+Ob2GHsGUk/u+cD1VTL3F/RQtUcwejxNYNO6EarCXunPsFtowZaPH6XfoQYUeJnXtO
        MoKEJQT4JG68FYS4gU9i0rbpzBBhXomONiGIakWJ+2e3Qg0Ul1h64SvbBEalWUihMgvJ97OQ
        fDMLYe8CRpZVjOKppcW56anFRnmp5XrFibnFpXnpesn5uZsYgSnt9L/jX3YwLn/1Ue8QIxMH
        4yFGCQ5mJRHe7DdaiUK8KYmVValF+fFFpTmpxYcYpTlYlMR5k7asiRcSSE8sSc1OTS1ILYLJ
        MnFwSjUwCfk9dp64Nux3Q2cowxTvtK7mNVKmG078fGlySH2j4S3TlwdUmb8b6DTpeTNtylc8
        b/razOPN6vlz5jL8+h+0vPwR0yr9q4tNg4Ofup93NO3cNsFfb7m4v5vPxCyt6Ztq1teVpnKU
        sn498WPR4uC71Z+5dzzK7Ti8/a/p+ZCan+bthl+EbYxuNdxy43nZoKC3g3Mxx02ZbQpnJzTc
        W3Kr11bj6EGdW9ks0z6/5rO/ley9UnLb97iz2ZPmM3hLL0m9Wllv/nk2e0XY8RqBYBsp/b/X
        MlXEQ0rS17893d7TpcPxfoe8fdr127O3OXk/nOF1VLbDMthfts0kRP6IScUyRzV+DzvtQJ1l
        dsrmB+uUWIozEg21mIuKEwG2H1WS2AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsVy+t/xu7plpnqJBm2fdC16z51kslhz7y+b
        xf9tE5ktrnx9z2bxfP46RouTb66yWHROXMJucXnXHDaLQ33RFp9mPWR24PL4srSZ2eP9jVZ2
        j73fFrB47Jx1l91jdsdMVo8TEy4xedy5tofNY/u3B6we97uPM3l83iQXwBWlZ1OUX1qSqpCR
        X1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5eglzH/3ja2gp1MFXc/TGFq
        YOxl6mLk5JAQMJFYfuctkM3FISSwlFFizdSZrBAJcYnd898yQ9jCEn+udbFBFL1llFiyfCI7
        SIJXwE5i+rejbCA2i4CqxOsfj1kg4oISJ2c+AbNFBRIkdh/uAqsXFsiU2LfiIJjNDLSg6ctK
        sGUiAmoSUyZNZwdZwCxwn0li95anrBDbehglJi3ZAzaJTUBT4u/mm0DbODg4BSwlPnzihxhk
        JtG1tYsRwpaXaN46m3kCo9AsJHfMQrJvFpKWWUhaFjCyrGIUSS0tzk3PLTbSK07MLS7NS9dL
        zs/dxAiM4m3Hfm7Zwbjy1Ue9Q4xMHIyHGCU4mJVEeLPfaCUK8aYkVlalFuXHF5XmpBYfYjQF
        BsZEZinR5HxgGskriTc0MzA1NDGzNDC1NDNWEuc1ObImXkggPbEkNTs1tSC1CKaPiYNTqoFp
        i+qHaRXyEbWWVTab1Zjy1F4nJ3UdjIxymvmdKUav88CxV9Iha37mZVm8kFvreF6mg21fGEvg
        m+0S/+JZnOVULFtnfnjCzmdne9K9/LJuxYbPRbNTt144srf7QllcitDRM7s+7txn9PpYw8tJ
        WUqqDquMIx2nNyzRW5hkt/py7x272xEGU177v5q5/Lkb8+T8uGdtf/1bBeYv/LJYw2NC1HZV
        cdPNAVdV66dO/vbg0DzhmayOv1lybp19en3aFNcP07qlrizKmeV9eotohBh/y9UJO5dI3rvG
        yc6woY/5SN7CT8/+VcQn3PzXtHcO96TLd8zP1Ka9zvU9+Xidrpbq126NfQv3L3iUPFM/ZL7n
        OyWW4oxEQy3mouJEABXCCkprAwAA
X-CMS-MailID: 20210831135814eucas1p24ce3aa6c3d1fee0055bdfa04a875044d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210831135143eucas1p1bc6f6a6ca587818c1bb036a64723577c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210831135143eucas1p1bc6f6a6ca587818c1bb036a64723577c
References: <CGME20210831135143eucas1p1bc6f6a6ca587818c1bb036a64723577c@eucas1p1.samsung.com>
        <20210831135048.4305-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


W dniu 31.08.2021 o 15:50, Cai Huoqing pisze:
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
>
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

Regards
Andrzej
