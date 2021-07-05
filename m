Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC173BB75E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 08:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhGEHAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 03:00:36 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:17046 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhGEHAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 03:00:36 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20210705065758euoutp016b2d726747fe6d2ebc35d9b2e93a87d7~O0sl0wPWc0973209732euoutp011
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 06:57:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20210705065758euoutp016b2d726747fe6d2ebc35d9b2e93a87d7~O0sl0wPWc0973209732euoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1625468278;
        bh=UUa70T+WgrCbukYQrWUDJu5tgqgySPr5MCU6pomjZq4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=p89BU0WU/1LdlQoZ+pzQnRunU4SkiwMTR1FH8n7IdXgPdBB/AEsSJHMbfmRgMgAXf
         tjghrh4RdPRA5kWB4zufN6RxoutUmzYfWLRYLETWyAIxY7R9ZnSd70jzPC5MTmWJrD
         AMd8UTPWOdZVtWmnZDRRUZD8LTMoKvW/+zBiWuDg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210705065757eucas1p13f44aa8a9704278104f9023499c6237e~O0sliSod90111801118eucas1p1f;
        Mon,  5 Jul 2021 06:57:57 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 0D.3D.42068.57DA2E06; Mon,  5
        Jul 2021 07:57:57 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210705065757eucas1p115e2b3c11853d09c7685f5c54726d79c~O0slDohiu0190401904eucas1p1H;
        Mon,  5 Jul 2021 06:57:57 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210705065757eusmtrp2938da762948fbff5e8597774915c4a1d~O0slC2idi1229112291eusmtrp2i;
        Mon,  5 Jul 2021 06:57:57 +0000 (GMT)
X-AuditID: cbfec7f4-c71ff7000002a454-9e-60e2ad75f215
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id CF.0D.31287.57DA2E06; Mon,  5
        Jul 2021 07:57:57 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210705065756eusmtip14cd0b25fe568d2b13affc1569a7fcb84~O0skZXSrg0640806408eusmtip1V;
        Mon,  5 Jul 2021 06:57:56 +0000 (GMT)
Subject: Re: [PATCH v1 3/6] clk: bcm2835: Switch to
 clk_divider.determine_rate
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-clk@vger.kernel.org, sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <647c4c32-f4e6-dbea-66b9-f92bc502525e@samsung.com>
Date:   Mon, 5 Jul 2021 08:57:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210702225145.2643303-4-martin.blumenstingl@googlemail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRmVeSWpSXmKPExsWy7djP87qlax8lGLQs1bVY23uUxeLXuyPs
        FpseX2O1+Nhzj9Xi8q45bBYTb29gtzi26CSLxY2H2hZPZ25ms/h3bSOLxbvVTxgduD1m3T/L
        5rFz1l12j6cTJrN7bFrVyeaxeUm9x+dNcgFsUVw2Kak5mWWpRfp2CVwZRyb8Yy9YLlBxdekN
        lgbGi7xdjJwcEgImEs/nnGPpYuTiEBJYwSjx++t+KOcLo0TfwZVsEM5nRokbP9uZYVoeNT+H
        qlrOKDHz1zwo5yOjxIG+N4wgVcICARJHFm0A6xARyJb4PLmfCaSIWWALk0RDy2cmkASbgKFE
        19suNhCbV8BO4vOMs2DNLAIqEo0Pj4LZogLJEu/nzWCFqBGUODnzCQuIzSngJfFi+nswm1lA
        XmL72znMELa4xK0n88GWSQj84JB4unoFK8TdLhITz92H+kFY4tXxLewQtozE/50wDc2MEg/P
        rWWHcHoYJS43zWCEqLKWuHPuF9CpHEArNCXW79KHCDtKTLw4gwUkLCHAJ3HjrSDEEXwSk7ZN
        Z4YI80p0tAlBVKtJzDq+Dm7twQuXmCcwKs1C8tosJO/MQvLOLIS9CxhZVjGKp5YW56anFhvl
        pZbrFSfmFpfmpesl5+duYgSmrdP/jn/Zwbj81Ue9Q4xMHIyHGCU4mJVEeEWmPEoQ4k1JrKxK
        LcqPLyrNSS0+xCjNwaIkzpu0ZU28kEB6YklqdmpqQWoRTJaJg1OqgUnXlUVMkuezfkpRy6ON
        uzxKj/JPrHYQPcHcuXGGVtyRNdt0bxSxrX49Rzkl17lRpfjTthcMgZ/ZVU/O3yLJf6xnIteX
        DWWbZA4aSVxoOzPH5hLX9lazaA/D+OaD39dtm/onuqTte0P5lyC/+k7GaR7MER/75WYua9tV
        9+K4eMSLFU8XPbze9cR6M7+3dNaGPbHLqhVSvlfzM/otSqquqgrWzJ5m4rDhwilDhQclon2L
        2p0zsnxOOE8W/SScV3+rkmvJzz/hYULv57w3t3U89nz76i67g9/nCZ7vZW/aX7hs0VLrGRXc
        z3YYpDnpJS9SbNyzIf2j7hWmE4/UxK2sd2ye3dL6+/2S7+dXfEv8o6HEUpyRaKjFXFScCAAZ
        gLeIygMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsVy+t/xu7qlax8lGJz8wG+xtvcoi8Wvd0fY
        LTY9vsZq8bHnHqvF5V1z2Cwm3t7AbnFs0UkWixsPtS2eztzMZvHv2kYWi3ernzA6cHvMun+W
        zWPnrLvsHk8nTGb32LSqk81j85J6j8+b5ALYovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws
        9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyjkz4x16wXKDi6tIbLA2MF3m7GDk5JARMJB41P2fp
        YuTiEBJYyiix/GQTO0RCRuLktAZWCFtY4s+1LjaIoveMEjOfPGEDSQgL+En82dIN1iAikC1x
        78g7MJtZYAuTxJHzRRANdxkl7jR+ZgJJsAkYSnS97QJr5hWwk/g84ywjiM0ioCLR+PAomC0q
        kCzxc307VI2gxMmZT1hAbE4BL4kX09+zQCwwk5i3+SEzhC0vsf3tHChbXOLWk/lMExiFZiFp
        n4WkZRaSlllIWhYwsqxiFEktLc5Nzy021CtOzC0uzUvXS87P3cQIjNJtx35u3sE479VHvUOM
        TByMhxglOJiVRHhFpjxKEOJNSaysSi3Kjy8qzUktPsRoCvTPRGYp0eR8YJrIK4k3NDMwNTQx
        szQwtTQzVhLn3Tp3TbyQQHpiSWp2ampBahFMHxMHp1QDk+OMzVszmquXbV4RJiqnWCcRZRO7
        t+HD5OaX8ckXBXd8zE/Jcej9p6gtIKrlvWUe85E6bgWul0tLPfrkqoICFvMK51/YvTr5GQtj
        UpyJWPiJbz73rKPffFywZr/3IYWvrDa3ZgSms8eZCa6T5Qs7cHk/15IVzCsSLyo5H3JYXsMr
        wq7TbW6Zuypks3/q/MSpG358Wf21Zp/zYab/Esp3o6fUeizZk3lk72n5bR5zVp5+38kW/fjQ
        /tCcwEnSFa80p1yMKPXxSDB0uH7rs9vbNy/t+87rnfTbPPP0+R1qfqpsm24GMt2dn5YktiJl
        v1KM+vQOZ72PQqqXqo/eVTAyb1gkLSR790J3z45z4eW6SizFGYmGWsxFxYkAaH1V9lsDAAA=
X-CMS-MailID: 20210705065757eucas1p115e2b3c11853d09c7685f5c54726d79c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210702225206eucas1p1731315e780983b422e206874c16bc0a4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210702225206eucas1p1731315e780983b422e206874c16bc0a4
References: <20210702225145.2643303-1-martin.blumenstingl@googlemail.com>
        <CGME20210702225206eucas1p1731315e780983b422e206874c16bc0a4@eucas1p1.samsung.com>
        <20210702225145.2643303-4-martin.blumenstingl@googlemail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.07.2021 00:51, Martin Blumenstingl wrote:
> .determine_rate is meant to replace .round_rate in CCF in the future.
> Switch over to .determine_rate now that clk_divider_ops has gained
> support for that.
>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: linux-rpi-kernel@lists.infradead.org
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/clk/bcm/clk-bcm2835.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
> index 1ac803e14fa3..a254512965eb 100644
> --- a/drivers/clk/bcm/clk-bcm2835.c
> +++ b/drivers/clk/bcm/clk-bcm2835.c
> @@ -805,11 +805,10 @@ static int bcm2835_pll_divider_is_on(struct clk_hw *hw)
>   	return !(cprman_read(cprman, data->a2w_reg) & A2W_PLL_CHANNEL_DISABLE);
>   }
>   
> -static long bcm2835_pll_divider_round_rate(struct clk_hw *hw,
> -					   unsigned long rate,
> -					   unsigned long *parent_rate)
> +static int bcm2835_pll_divider_determine_rate(struct clk_hw *hw,
> +					      struct clk_rate_request *req)
>   {
> -	return clk_divider_ops.round_rate(hw, rate, parent_rate);
> +	return clk_divider_ops.determine_rate(hw, req);
>   }
>   
>   static unsigned long bcm2835_pll_divider_get_rate(struct clk_hw *hw,
> @@ -901,7 +900,7 @@ static const struct clk_ops bcm2835_pll_divider_clk_ops = {
>   	.unprepare = bcm2835_pll_divider_off,
>   	.recalc_rate = bcm2835_pll_divider_get_rate,
>   	.set_rate = bcm2835_pll_divider_set_rate,
> -	.round_rate = bcm2835_pll_divider_round_rate,
> +	.determine_rate = bcm2835_pll_divider_determine_rate,
>   	.debug_init = bcm2835_pll_divider_debug_init,
>   };
>   

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

