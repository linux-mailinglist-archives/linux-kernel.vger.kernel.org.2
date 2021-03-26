Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF9634A1C0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 07:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhCZGZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 02:25:10 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:10659 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhCZGYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 02:24:43 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20210326062437euoutp0104457b1c70307476b1e16d1ffce724eb~v0FpN7qyc2994429944euoutp01X
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 06:24:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20210326062437euoutp0104457b1c70307476b1e16d1ffce724eb~v0FpN7qyc2994429944euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1616739877;
        bh=uiWXswu74C9VwWhKhIKxbIB0dROw5uXGq+yox3AHyYs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=tf65vhSVSdoygMpUWZm2OcL6shsA59KG973KVbjzxXs1oAg1by1A7nRJMr+86xWuS
         okBefQqwF83s+D9dRSFeODorFwrXZJT6v3GXuX0vXiXnVGxQ0R99qM7lW/X0sNmopa
         7VSOGEN8tvYVi5/M0YqbyIyPsMs8wGngeze+E+7E=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210326062437eucas1p2aa32a10b3586f8f480cd310404e524b6~v0Fovrb8z1141511415eucas1p21;
        Fri, 26 Mar 2021 06:24:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id D9.A4.09444.42E7D506; Fri, 26
        Mar 2021 06:24:36 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210326062436eucas1p2492d7064a71a3f6798b0e7abe9255064~v0FoNGsYl1140511405eucas1p2E;
        Fri, 26 Mar 2021 06:24:36 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210326062436eusmtrp1aa8f3d7f79a35fd47624798f62a1b35c~v0FoMT31A2848328483eusmtrp1F;
        Fri, 26 Mar 2021 06:24:36 +0000 (GMT)
X-AuditID: cbfec7f4-dbdff700000024e4-c7-605d7e24d74b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 3D.70.08696.42E7D506; Fri, 26
        Mar 2021 06:24:36 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210326062435eusmtip182a4fed3d091bd6d473e50d8f909f79c~v0FnmKxUR0031200312eusmtip1i;
        Fri, 26 Mar 2021 06:24:35 +0000 (GMT)
Subject: Re: [PATCH] clk: bcm: rpi: Don't register as OF provider if
 !dev->np
To:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-rpi-kernel@lists.infradead.org, geert@linux-m68k.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <5c178935-1d92-9095-9f60-773eddd937c3@samsung.com>
Date:   Fri, 26 Mar 2021 07:24:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210325185749.27984-1-nsaenz@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djPc7oqdbEJBiu+W1o8u7WXyeJjzz1W
        i8u75rBZTLy9gd1ixo9/jBYXT7la3HiobbFt1nI2i3/XNrI4cHq8v9HK7nHn3Hk2j02rOtk8
        Dh3uYPTYvKTeY/Ppao/Pm+QC2KO4bFJSczLLUov07RK4Ms58mc1ccJq34s/D/SwNjI3cXYwc
        HBICJhJXfvh2MXJxCAmsYJS4/OMjE4TzhVGipfM8G4TzmVHi3/ktjF2MnGAdXZt3skAkljNK
        LG7vYIdwPjJKTDi4hQmkSljAX+L4/AlgVSIgVQumvAWrYgbZsuN8KwtIFZuAoUTX2y42EJtX
        wE7iV0cjWJxFQFVi5etOJpALRQWSJDYcioUoEZQ4OfMJWAmngLnEzMajYCcxC8hLbH87hxnC
        Fpe49WQ+E8SpXzgk7t2UgLBdJBZ8fskGYQtLvDq+hR3ClpE4PbkH7FAJgWZGiYfn1rJDOD3A
        4GiaAfW0tcSdc7/YQA5iFtCUWL9LHyLsKNF1ajUzJCT5JG68FYS4gU9i0rbpUGFeiY42IYhq
        NYlZx9fBrT144RLzBEalWUg+m4Xkm1lIvpmFsHcBI8sqRvHU0uLc9NRio7zUcr3ixNzi0rx0
        veT83E2MwCR1+t/xLzsYl7/6qHeIkYmD8RCjBAezkghvkm9MghBvSmJlVWpRfnxRaU5q8SFG
        aQ4WJXHepC1r4oUE0hNLUrNTUwtSi2CyTBycUg1MWTs7+OfdkTbd2dRxxtjcX5ep71aI4uID
        Vr8Y5qzTOBbNMNes8bJfSt6TBWo/sysiHrwwk61/fjSNfeqXaw/bmPbdvmjxdnX8iVSF0nPf
        V6mLPt/xXPFZQdjm3H8b0yZf+y70/dzdJO++U3UCWQsbuYp8jPylrCO/OHc3/N0cwjc74cTa
        1f2eG08/ClkUNUVd5UWWzceDhl9mW1W4udfcU5Kwlr/zaEbuo2W5X5fKHI82KN151Pv2nMLK
        +pMy+2/EHd9+R5vNTCsjwF7t23zeh9EhOvmrXl2cvo/hgOj3cx2hrFZ2Cz692rmt7s8lD8Hd
        V+/9W5umqL3C9naxlcX8t32hvNG79u+YLZ+a+N/mjxJLcUaioRZzUXEiALwZDXDBAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsVy+t/xu7oqdbEJBpt+CFs8u7WXyeJjzz1W
        i8u75rBZTLy9gd1ixo9/jBYXT7la3HiobbFt1nI2i3/XNrI4cHq8v9HK7nHn3Hk2j02rOtk8
        Dh3uYPTYvKTeY/Ppao/Pm+QC2KP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxM
        lfTtbFJSczLLUov07RL0Ms58mc1ccJq34s/D/SwNjI3cXYycHBICJhJdm3eygNhCAksZJbZe
        1YKIy0icnNbACmELS/y51sXWxcgFVPOeUeJwyw4mkISwgK9Ex8n57CAJEYHljBKtk9uYQRxm
        gRWMEhvvPWaBaOlilNi0+T5YC5uAoUTXW5BZnBy8AnYSvzoawXazCKhKrHzdCVYjKpAkcXnJ
        RFaIGkGJkzOfgNVwCphLzGw8yghiMwuYSczb/JAZwpaX2P52DpQtLnHryXymCYxCs5C0z0LS
        MgtJyywkLQsYWVYxiqSWFuem5xYb6RUn5haX5qXrJefnbmIERua2Yz+37GBc+eqj3iFGJg7G
        Q4wSHMxKIrxJvjEJQrwpiZVVqUX58UWlOanFhxhNgf6ZyCwlmpwPTA15JfGGZgamhiZmlgam
        lmbGSuK8JkfWxAsJpCeWpGanphakFsH0MXFwSjUwbXH+zihw0pVNUCZjzz2pzq/rKydeKX2f
        qu//4/lyk+J39pK2nTNftzSLc3PNcT+m8vFZ2Gpm/YUbJsYeOCfDd3C9c73qp9D2VIs+s1VT
        rRfe71Pb+2Gte93eN2muXSLi/9b5s89n5HSomKf/tugeS86/Z+/CbF9v+bgrsI+5pTos6NA6
        Br5lUU2P+Vo3TXncckffU/+P7JUZfItslyron3999gLjZfu8goJwJpnde1rfWH1RY3bmmbOX
        XSi+X3mh8McdU0REZ/xO3ytgYLZhX7CXuMc8A3V/de9pt/c/LZ3W5Sv1z3IGm8LLa/c89fOz
        lLtkVI884mwrfMlnKbn6u7SXH2Pm6lS9K7sYW0uVWIozEg21mIuKEwEeY2WVVQMAAA==
X-CMS-MailID: 20210326062436eucas1p2492d7064a71a3f6798b0e7abe9255064
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210325185810eucas1p1d36da720896060cc37b8d33db012044d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210325185810eucas1p1d36da720896060cc37b8d33db012044d
References: <CGME20210325185810eucas1p1d36da720896060cc37b8d33db012044d@eucas1p1.samsung.com>
        <20210325185749.27984-1-nsaenz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.03.2021 19:57, Nicolas Saenz Julienne wrote:
> There are two ways clk-raspberrypi might be registered: through
> device-tree or through an explicit platform device registration. The
> latter happens after firmware/raspberrypi's probe, and it's limited to
> RPi3s, which solely use the ARM clock to scale CPU's frequency. That
> clock is matched with cpu0's device thanks to the ARM clock being
> registered as a clkdev.
>
> In that scenario, don't register the device as an OF clock provider, as
> it makes no sense and will cause trouble.
>
> Fixes: d4b4f1b6b97e ("clk: bcm: rpi: Add DT provider for the clocks")
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/clk/bcm/clk-raspberrypi.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
> index f89b9cfc4309..27e85687326f 100644
> --- a/drivers/clk/bcm/clk-raspberrypi.c
> +++ b/drivers/clk/bcm/clk-raspberrypi.c
> @@ -337,10 +337,12 @@ static int raspberrypi_clk_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> -	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> -					  clk_data);
> -	if (ret)
> -		return ret;
> +	if (dev->of_node) {
> +		ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> +						  clk_data);
> +		if (ret)
> +			return ret;
> +	}
>   
>   	rpi->cpufreq = platform_device_register_data(dev, "raspberrypi-cpufreq",
>   						     -1, NULL, 0);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

