Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8235E347661
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 11:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbhCXKmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 06:42:47 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:25899 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbhCXKmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 06:42:15 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20210324104213euoutp02dd41357367ad95428dff2d21ab677304~vQT-clRcg2985529855euoutp02w
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 10:42:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20210324104213euoutp02dd41357367ad95428dff2d21ab677304~vQT-clRcg2985529855euoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1616582533;
        bh=3Fyph74/zs9R2tFp93+07edK0aaJQ/8rQxJJdXlNU5w=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=Hx7UsSohz6jKIMTf1uBPoiZnQLzyNWyXmHJ4usyzE9gO+AemP9TrxaI01JOV5Gsa/
         slJFSG+z6DhUTR4BPt1vy6hIpaY5BpGHhDVlo37KzGn/kqTU7tSz4QJXTE0iUBwZAc
         qX8YKCit03Aff3yDWv/FOkBtuzXhKlSvF4oFh2ao=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210324104213eucas1p2b7e0e1c3d612d2df7385279445c3495a~vQT_6FTnJ0246002460eucas1p26;
        Wed, 24 Mar 2021 10:42:13 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C7.FF.09444.5871B506; Wed, 24
        Mar 2021 10:42:13 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210324104212eucas1p247939b0888a7576856a3c70403d5a6af~vQT_OL_Ve0245602456eucas1p2H;
        Wed, 24 Mar 2021 10:42:12 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210324104212eusmtrp1135aef61d718f64a8a48242ef9edb33b~vQT_NPBKn1571815718eusmtrp1N;
        Wed, 24 Mar 2021 10:42:12 +0000 (GMT)
X-AuditID: cbfec7f4-dd5ff700000024e4-5e-605b17855eda
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 06.D2.08705.4871B506; Wed, 24
        Mar 2021 10:42:12 +0000 (GMT)
Received: from [106.210.131.79] (unknown [106.210.131.79]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210324104211eusmtip228f5db00b9d37603a34a9547aa84c6a7~vQT9rds450647606476eusmtip2c;
        Wed, 24 Mar 2021 10:42:11 +0000 (GMT)
Message-ID: <bb8e2cec-91ec-5494-0aa2-9d1db5fdebcd@samsung.com>
Date:   Wed, 24 Mar 2021 11:42:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:87.0)
        Gecko/20100101 Thunderbird/87.0
Subject: Re: [PATCH v1] MAINTAINERS: Update Maintainers of DRM Bridge
 Drivers
Content-Language: en-GB
To:     Robert Foss <robert.foss@linaro.org>, linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime@cerno.tech>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>
From:   Andrzej Hajda <a.hajda@samsung.com>
In-Reply-To: <20210324102019.1251744-1-robert.foss@linaro.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEKsWRmVeSWpSXmKPExsWy7djP87qt4tEJBosPsln83zaR2eLq95fM
        FiffXGWx6Jy4hN3i8q45bBYLP25lsZjx4x+jxaG+aItPsx4yW2x5M5HVgcvj/Y1Wdo87586z
        eez9toDFY3bHTFaPExMuMXncubaHzWPeyUCPA72TWTw2n672+LxJLoArissmJTUnsyy1SN8u
        gStj5ckPjAUvuSpO9DcxNjDO4uxi5OSQEDCR6L2zlqWLkYtDSGAFo8SshUtYIZwvjBKHt7Wy
        QTifGSW2/njE3MXIAdbyujsWIr6cUeLx7ElQ7e8ZJbY8BOng5OAVsJOYNuMWM4jNIqAqseXY
        VHaIuKDEyZlPWEBsUYEEicfd3UwgtrCAv8S+WxsZQWxmAXGJpi8rwc4QEbjCJHG7uY8JIuEv
        0b54BtggNgFNib+bb4It4wRa9n71Z3aIGnmJ5q2zmUGaJQSmc0p8PfmFDeJsF4l/0ysgnhaW
        eHV8CzuELSNxenIPC4RdL3F/RQtUbwfQyxt2MkMkrCXunPsFNocZaPH6XfoQYUeJ13PPQ43n
        k7jxVhDiBD6JSdumQwOLV6KjTQiiWlHi/tmtUAPFJZZe+Mo2gVFpFlKozELy/Swkz8xC2LuA
        kWUVo3hqaXFuemqxUV5quV5xYm5xaV66XnJ+7iZGYDI7/e/4lx2My1991DvEyMTBeIhRgoNZ
        SYS3JTwiQYg3JbGyKrUoP76oNCe1+BCjNAeLkjhv0pY18UIC6YklqdmpqQWpRTBZJg5OqQam
        XOFOD56Hlz9lXZG227ousKfs1AMNK+Ni44UX1Vf/rk36dIy74d9UhrS54ke8pUU+b1r+ZJ+M
        Z92jJjP2+VtspmzumnF3cVS2mptJydKdIZo609tLnHdulz1+fX3t90t/ql7ot88QOljG7W7c
        tcb7rVvgx2jPwP9vHj7svZdy2f3biw7PnoQ4y0XLtmvaWZfXzbl0WSynY48e3/EDUVqnfj2V
        U7L1fvTf5/nZpyL6GrMXfJe8Nv3aQ43Jx0yjZ+5bY9o4b4fxZ73Mt07FAqXz1EoPCv4/7cn+
        va2yKkykYMX2OQv/Rt9LeRwixHL0/+qNIhbP3q5Zv3lO4f6em3ukCjfFM88T53+8+0H2/UeF
        qkosxRmJhlrMRcWJANLIcKTVAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsVy+t/xe7ot4tEJBr9nSFr83zaR2eLq95fM
        FiffXGWx6Jy4hN3i8q45bBYLP25lsZjx4x+jxaG+aItPsx4yW2x5M5HVgcvj/Y1Wdo87586z
        eez9toDFY3bHTFaPExMuMXncubaHzWPeyUCPA72TWTw2n672+LxJLoArSs+mKL+0JFUhI7+4
        xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS9j5ckPjAUvuSpO9DcxNjDO
        4uxi5OCQEDCReN0d28XIySEksJRRovtwLYgtISAusXv+W2YIW1jiz7Uuti5GLqCat4wSnY1v
        2EESvAJ2EtNm3AIrYhFQldhybCpUXFDi5MwnLCC2qECCxNHWLSwgu4QFfCW+T9IECTMDzW/6
        spIVZKaIwBUmiW8fXrJAJHwlph17xwJx0ERGid6jOSA2m4CmxN/NN9lAbE6gve9Xf2aHqDeT
        6NraxQhhy0s0b53NPIFRaBaSM2Yh2TcLScssJC0LGFlWMYqklhbnpucWG+oVJ+YWl+al6yXn
        525iBMbutmM/N+9gnPfqo94hRiYOxkOMEhzMSiK8LeERCUK8KYmVValF+fFFpTmpxYcYTYFh
        MZFZSjQ5H5g88kriDc0MTA1NzCwNTC3NjJXEebfOXRMvJJCeWJKanZpakFoE08fEwSnVwKQT
        qLz20gzZPKlFt9Slxf6wcHpn/TZnipwlGPN8JfuFa+4Fl77wBzmrNkQ2v3i1Qmzl9JlyF1s+
        Fok+FIjMfPCLO0VlGR/L0vzcLWtF/5l2z3ecXa2jbP5J9G38HpVddZfPLlzw2VJjk63CZfc4
        g4Nr176MWbml7GP/w1qeHVleIbL/nd54HNi8qbFWvGulpc2WG2d+nY+Wc9PR3tX+NF3OZc2z
        ZH3jmlSpqo7MM0rK24/m5vzfpjn1/8zgQ4dqj315VMaZyn1QdarwwfBltw/KeIaLLPZN1DTv
        //tklXPcLAmXWf3t3c7N15259vu83Nm/f9+buxmfhHU/HVBXyP02J/XKrRSWeYd2OLycOUGJ
        pTgj0VCLuag4EQCrbz0PZgMAAA==
X-CMS-MailID: 20210324104212eucas1p247939b0888a7576856a3c70403d5a6af
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210324102037eucas1p19d40160cb48290a6dad2e15ff1eb0420
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210324102037eucas1p19d40160cb48290a6dad2e15ff1eb0420
References: <CGME20210324102037eucas1p19d40160cb48290a6dad2e15ff1eb0420@eucas1p1.samsung.com>
        <20210324102019.1251744-1-robert.foss@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu 24.03.2021 o 11:20, Robert Foss pisze:
> Add myself as co-maintainer of DRM Bridge Drivers. Repository
> commit access has already been granted.
>
> https://protect2.fireeye.com/v1/url?k=c3508e7b-9ccbb771-c3510534-0cc47a31384a-ef2b7fbec8aa658e&q=1&e=46fd05b7-d9d9-4737-99cd-cd44e40a7bc7&u=https%3A%2F%2Fgitlab.freedesktop.org%2Ffreedesktop%2Ffreedesktop%2F-%2Fissues%2F338
>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Jernej Škrabec <jernej.skrabec@siol.net>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Robert Foss <robert.foss@linaro.org>

Great.


Acked-by: Andrzej Hajda <a.hajda@samsung.com>


Regards

Andrzej


> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4b705ba51c54..16ace8f58649 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5902,6 +5902,7 @@ F:	drivers/gpu/drm/atmel-hlcdc/
>   DRM DRIVERS FOR BRIDGE CHIPS
>   M:	Andrzej Hajda <a.hajda@samsung.com>
>   M:	Neil Armstrong <narmstrong@baylibre.com>
> +M:	Robert Foss <robert.foss@linaro.org>
>   R:	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
>   R:	Jonas Karlman <jonas@kwiboo.se>
>   R:	Jernej Skrabec <jernej.skrabec@siol.net>
