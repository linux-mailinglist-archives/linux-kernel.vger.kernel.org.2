Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D62030F392
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 14:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbhBDNAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 08:00:08 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46055 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236110AbhBDNAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 08:00:06 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20210204125923euoutp0190fb78eb19962f678d928ca42acf6733~gjODVrN2e0585805858euoutp01R
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 12:59:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20210204125923euoutp0190fb78eb19962f678d928ca42acf6733~gjODVrN2e0585805858euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1612443563;
        bh=w7hfHypJZijxK8JFc5TVj8rXVC9Oyo0ayBAp0KkUDYo=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=i767CN/+1LE3Oaqdpn2tv6LHoQpsFPgXsgI+fZ4BkdiWMDSwvEgGmqwPN8GlX3h0S
         zy4QAqC1XMdHTHkNF8wjRHBQNazL9MCTqYvAUlmvmNEFsVc6HPhP32I+24V8Yd3vri
         ZejL1lwpMlA/Yp0ginJf8kvpMhY5I9r+wWb/GwBM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210204125923eucas1p2c90b7f8976b27a610e80bd7a32c18988~gjOCnmIHZ0262802628eucas1p2b;
        Thu,  4 Feb 2021 12:59:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E4.91.27958.AAFEB106; Thu,  4
        Feb 2021 12:59:23 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210204125922eucas1p2d832c777e404561418768f013ba983d5~gjOCPrrMW2557425574eucas1p2c;
        Thu,  4 Feb 2021 12:59:22 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210204125922eusmtrp266dd073b8b33d4465b881362b6806d40~gjOCOpXC-2733127331eusmtrp2j;
        Thu,  4 Feb 2021 12:59:22 +0000 (GMT)
X-AuditID: cbfec7f2-f15ff70000006d36-85-601befaaa2ba
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id DB.9C.21957.AAFEB106; Thu,  4
        Feb 2021 12:59:22 +0000 (GMT)
Received: from [106.210.131.79] (unknown [106.210.131.79]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210204125921eusmtip175e7f6d9d0285a6a206869ecda1f0a53~gjOBGaBtr1244612446eusmtip1D;
        Thu,  4 Feb 2021 12:59:21 +0000 (GMT)
Message-ID: <b680fef2-7c8a-183b-443a-6b2b9fe595d7@samsung.com>
Date:   Thu, 4 Feb 2021 13:59:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0)
        Gecko/20100101 Thunderbird/86.0
Subject: Re: [PATCH] drm/bridge: anx7625: enable DSI EOTP
Content-Language: en-GB
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Robert Foss <robert.foss@linaro.org>
Cc:     devel@driverdev.osuosl.org, Nicolas Boichat <drinkcat@google.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sheng Pan <span@analogixsemi.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Torsten Duwe <duwe@lst.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>, Xin Ji <xji@analogixsemi.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
From:   Andrzej Hajda <a.hajda@samsung.com>
In-Reply-To: <CANMq1KAuUTqgM2mDR5WN6Ad+cATFXLPE+5rstyhfNE9Lc716+g@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCJsWRmVeSWpSXmKPExsWy7djP87qr30snGNw/zWjRe+4kk0XrsWeM
        FqfPnGKyeP1vOovFnjO/2C2ufH3PZrH6ygoWi8u3vjJbfLsClJ3Qup3Z4ur3l8wWJ99cZbHo
        nLiE3eLyrjlsFmuP3GW3ONQXbfFp1kNmixU/tzJaPFu7lNVi3t0fzA4iHnP37mL2eH+jld1j
        dsNFFo8dd5cwetzbd5jFY+esu+weCzaVeszumMnqcWLCJSaPO9f2sHls//aA1eN+93Emj903
        G9g8Pj69xeKxZNpVNo++LasYA4SiuGxSUnMyy1KL9O0SuDK+vNQq+C5UceDncdYGxmv8XYyc
        HBICJhLvd89hA7GFBFYwSqzeKNrFyAVkf2GUePN1CwuE85lRouPORSaYjtYvD6ESyxklPn5e
        wwrhvGeU2HP3GjtIFa+AncSbQ9OYQWwWARWJnqXvoeKCEidnPmEBsUUFEiQ2dG4GmyosYCkx
        52MLmM0sIC7R9GUlK4gtIhAs0bHsMBPIAmaBS6wS/StmgjWzCWhK/N18E+xwToFAiYmd3xkh
        muUlmrfOZgZpkBBo45LoeXCPBeJuF4nt68+xQ9jCEq+Ob4GyZST+75wP9Vu9xP0VLVDNHYwS
        WzfsZIZIWEvcOfcLaBsH0AZNifW79CHCjhJNqyYwgoQlBPgkbrwVhLiBT2LStunMEGFeiY42
        IYhqRYn7Z7dCDRSXWHrhK9sERqVZSMEyC8n7s5B8Mwth7wJGllWM4qmlxbnpqcWGeanlesWJ
        ucWleel6yfm5mxiBCff0v+OfdjDOffVR7xAjEwfjIUYJDmYlEd7ENqkEId6UxMqq1KL8+KLS
        nNTiQ4zSHCxK4ryrZq+JFxJITyxJzU5NLUgtgskycXBKNTCp9Rm/fqCoKHpCyKVo1Rt35fO3
        PwS4bfM5KP2qVuj0xAXr7R0MJ/Wlz7hz/sfJloObNdIsRY2rP72dpxTCs+PMAYf+XWVJT2d5
        t9WqJqW7afF4HZL4eMhx+qQ1+zbvUppziOn037aqQ9PXcM7+wr7Ip6IxJE3c8/WLyq87RfVO
        7rikNT1KtXVDZOjLlhorkwCnHbl99+N+6N/3DTn/XZvleZaDj5D6lBDptfwL5KdZv4xg8ffc
        03Rnm806+7KnAgtszmZJmeidmrCY+dlUhzq/O5U5hxdMtra6vvlV4sT7l+ZJMWwJXv2Ko7k+
        sEch8fr6g9oV9jevZK2MFA96FPvAyXz/32XNdw2W3QgwFX+sxFKckWioxVxUnAgAmFtH/CcE
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsVy+t/xu7qr3ksnGHT+UbToPXeSyaL12DNG
        i9NnTjFZvP43ncViz5lf7BZXvr5ns1h9ZQWLxeVbX5ktvl0Byk5o3c5scfX7S2aLk2+uslh0
        TlzCbnF51xw2i7VH7rJbHOqLtvg06yGzxYqfWxktnq1dymox7+4PZgcRj7l7dzF7vL/Ryu4x
        u+Eii8eOu0sYPe7tO8zisXPWXXaPBZtKPWZ3zGT1ODHhEpPHnWt72Dy2f3vA6nG/+ziTx+6b
        DWweH5/eYvFYMu0qm0ffllWMAUJRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZG
        pkr6djYpqTmZZalF+nYJehlfXmoVfBeqOPDzOGsD4zX+LkZODgkBE4nWLw9Zuhi5OIQEljJK
        nNu3lwUiIS6xe/5bZghbWOLPtS42iKK3jBLvHjaygyR4Bewk3hyaBlbEIqAi0bP0PVRcUOLk
        zCdgg0QFEiQm979mA7GFBSwl5nxsYQKxmYEWNH1ZyQpiiwgES8z4NxFsAbPAFVaJn8s/MUFs
        62eSODr7LdgkNgFNib+bb4JN4hQIlJjY+Z0RYpKZRNfWLihbXqJ562zmCYxCs5AcMgvJwllI
        WmYhaVnAyLKKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMMlsO/Zz8w7Gea8+6h1iZOJgPMQo
        wcGsJMKb2CaVIMSbklhZlVqUH19UmpNafIjRFBgaE5mlRJPzgWkuryTe0MzA1NDEzNLA1NLM
        WEmcd+vcNfFCAumJJanZqakFqUUwfUwcnFINTOlLttfnVHKcTPh37NjpX328cioyXU4L9yw3
        UNz533Def+0NJ1y/p8zM7/MqflM0MzF/b3Od4i+r745NaqFPvM5V3nNLE180z1uwJeRW8Qmn
        c/833mZ/U/5xwoe1TKtexj/e01Uyr9nIZf88PxGeLQaTX8ltuW/7au6sr/3vFMSTnJYk1HAf
        yuUVPdzw9JG3ug6jf9dXQ7XfH8SZM6MO7NCunmzK6F3PGxT/2nXpuhUPNP/FnrHj+J2uqd89
        VznbRmAq34WqvnWmjZwWOaKKXhaaa4qKA+tvvuexTzU78eKAyVs+nkJ9s1sngl06vv8v+3g9
        zOaG+H7d1bpMN8525ireTIhmFfBKdn37u+W4EktxRqKhFnNRcSIAZ++N8bsDAAA=
X-CMS-MailID: 20210204125922eucas1p2d832c777e404561418768f013ba983d5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210204123452eucas1p1eb8fd9dc5b62b036ebd9e9208e796cb9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210204123452eucas1p1eb8fd9dc5b62b036ebd9e9208e796cb9
References: <20210128111549.GA8174@zhaomy-pc>
        <CAG3jFysU4epjS3A85ZojrJn3TAC78O_jx5p_4SWsCdRBrQ5GXQ@mail.gmail.com>
        <CGME20210204123452eucas1p1eb8fd9dc5b62b036ebd9e9208e796cb9@eucas1p1.samsung.com>
        <CANMq1KAuUTqgM2mDR5WN6Ad+cATFXLPE+5rstyhfNE9Lc716+g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


W dniu 04.02.2021 o 13:34, Nicolas Boichat pisze:
> On Thu, Feb 4, 2021 at 8:07 PM Robert Foss <robert.foss@linaro.org> wrote:
>> Hi Xin,
>>
>> Thanks for the patch.
>>
>> On Thu, 28 Jan 2021 at 12:17, Xin Ji <xji@analogixsemi.com> wrote:
>>> Enable DSI EOTP feature for fixing some panel screen constance
>>> shift issue.
>>> Removing MIPI flag MIPI_DSI_MODE_EOT_PACKET to enable DSI EOTP.
>> I don't think I quite understand how removing the
>> MIPI_DSI_MODE_EOT_PACKET flag will cause DSI EOTP to be enabled. Could
>> you extrapolate on this in the commit message?
> That confused me as well, but it turns out that's how the flag is defined:
> ```
> /* disable EoT packets in HS mode */
> #define MIPI_DSI_MODE_EOT_PACKET BIT(9)
> ```
> (https://protect2.fireeye.com/v1/url?k=5bd95ebd-044267fb-5bd8d5f2-0cc47a3003e8-ce9db8ea264d6901&q=1&e=900556dc-d199-4c18-9432-5c3465a98eae&u=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Flatest%2Fsource%2Finclude%2Fdrm%2Fdrm_mipi_dsi.h%23L129)
>
> I'm almost tempted to put together a mass patch to rename all of these flags...


Yes that would be good, many of these flags were just copy pasted from 
some hw datasheet, without good analysis how to adapt them to the framework.


Regards

Andrzej


>
>>> Signed-off-by: Xin Ji <xji@analogixsemi.com>
>>> ---
>>>   drivers/gpu/drm/bridge/analogix/anx7625.c | 1 -
>>>   1 file changed, 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
>>> index 65cc059..e31eeb1b 100644
>>> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
>>> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
>>> @@ -1334,7 +1334,6 @@ static int anx7625_attach_dsi(struct anx7625_data *ctx)
>>>          dsi->format = MIPI_DSI_FMT_RGB888;
>>>          dsi->mode_flags = MIPI_DSI_MODE_VIDEO   |
>>>                  MIPI_DSI_MODE_VIDEO_SYNC_PULSE  |
>>> -               MIPI_DSI_MODE_EOT_PACKET        |
>>>                  MIPI_DSI_MODE_VIDEO_HSE;
>>>
>>>          if (mipi_dsi_attach(dsi) < 0) {
>>> --
>>> 2.7.4
>>>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://protect2.fireeye.com/v1/url?k=457f3f39-1ae4067f-457eb476-0cc47a3003e8-b702072da729d8c9&q=1&e=900556dc-d199-4c18-9432-5c3465a98eae&u=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel
>
