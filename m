Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827A740F34C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 09:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240567AbhIQHcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 03:32:00 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:64783 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbhIQHb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 03:31:59 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20210917073035euoutp022d04be6443e042f52a44410c9c08900b~li4NHqDrS0467804678euoutp02k
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 07:30:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20210917073035euoutp022d04be6443e042f52a44410c9c08900b~li4NHqDrS0467804678euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1631863835;
        bh=S3B13fJvkOkVAxyfRZy6T0sfndyEKU3zYMGDDwM6qqo=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=armKWk47ALt8IanGFxEM50d7S6w8u8GX0W2z8YjaN29DHhifJNn7cSF3H50Bhn4Vw
         yA7SBDWFCsfyC64m0TUH2v62ily7Y1Bk+p1SQ9TIoXhGLfdqaJzQEBUjQytTymAwPO
         oyt2pEtdhRAB5swtwPwHqWiXkskuaqACe9Ni55vI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210917073035eucas1p205ee849bd820419864d1ec31255156fc~li4MyyW8y1496014960eucas1p2q;
        Fri, 17 Sep 2021 07:30:35 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 58.B5.42068.B1444416; Fri, 17
        Sep 2021 08:30:35 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210917073034eucas1p1d80385c5327a757b26f8a7bdefa3b077~li4MMwn0H2824928249eucas1p1Q;
        Fri, 17 Sep 2021 07:30:34 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210917073034eusmtrp2910272e1b5782616f58ed1a509b395e9~li4MMBEKV2227722277eusmtrp2r;
        Fri, 17 Sep 2021 07:30:34 +0000 (GMT)
X-AuditID: cbfec7f4-c89ff7000002a454-35-6144441b8bbf
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 01.BF.20981.A1444416; Fri, 17
        Sep 2021 08:30:34 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210917073034eusmtip2726435c268c221293660fc612263b7cb~li4LrkXtm0124201242eusmtip2A;
        Fri, 17 Sep 2021 07:30:34 +0000 (GMT)
Subject: Re: [RFT][PATCH] regulator: max14577: Revert
 "regulator: max14577: Add proper module aliases strings"
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <acb72aa2-4211-4c2f-1176-82d533ddf8b5@samsung.com>
Date:   Fri, 17 Sep 2021 09:30:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210916144102.120980-1-krzysztof.kozlowski@canonical.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsWy7djP87rSLi6JBme+yVtsnLGe1WLqwyds
        Fte/PGe12Pj2B5PFtysdTBaXd81hc2DzmNXQy+axc9Zddo9NqzrZPPq2rGL0+LxJLoA1issm
        JTUnsyy1SN8ugSvj0Ze3TAUb+StuXpnO0sB4k6eLkZNDQsBE4uu1SSxdjFwcQgIrGCU+3b/F
        COF8YZSY1rGUDcL5zChx4eIyVpiWdYumQbUsZ5TY1XUUquojo8S1tXOZQKqEBQoknt+ezQZi
        iwg0MknMWOcGYrMJGEp0ve0Ci/MK2ElsPDQDzGYRUJX42g5hiwokS0z728QMUSMocXLmExYQ
        m1PAQ2LfnZNgcWYBeYntb+dA2eISt57MZ4K47gSHxLI3ZRC2i8Sp6ZtYIGxhiVfHt7BD2DIS
        /3eC1HMB2c2MEg/PrWWHcHoYJS43zWCEqLKWuHPuF9BFHEAbNCXW79KHCDtK/Ly7gRkkLCHA
        J3HjrSDEDXwSk7ZNhwrzSnS0CUFUq0nMOr4Obu3BC5eYIWwPifu7rjNOYFScheTLWUg+m4Xk
        s1kINyxgZFnFKJ5aWpybnlpslJdarlecmFtcmpeul5yfu4kRmHpO/zv+ZQfj8lcf9Q4xMnEw
        HmKU4GBWEuG9UOOYKMSbklhZlVqUH19UmpNafIhRmoNFSZw3acuaeCGB9MSS1OzU1ILUIpgs
        EwenVANTiA17r0p1fRxrthyDpndVj2iXbUtFTMQx2WePknaa8GuUupac2WLqdG+9bL/Xy2fJ
        5st+tNyqSpjzML6pzLX3zDf2mpkh/RP/xJVFL4qQ+nPq+3zX5zcDL/Iuakw7G37l20Ez8f0T
        DtX0Pj4gc+Lgqjl1H1/9Vmip8k+1DmLkucpmUXdXeuvBl3eP6f2tMsy8vPlWiX9yX+4i24gt
        W+4IpJ47qecTVr1yxsG1O6P6J8grrt/aI7jvjhF/Su7UplULqudYRy8oSnwkveas/K/srxdl
        F3N8FT0SnrFnofnVrL7ZLrHZ/V57gr1KvtXZlnVMkjLkiPm/NH5XXcPfr/Eb1FZoqh2r3mqr
        N+VnhIwSS3FGoqEWc1FxIgC5k3SMrAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsVy+t/xe7pSLi6JBu23TC02zljPajH14RM2
        i+tfnrNabHz7g8ni25UOJovLu+awObB5zGroZfPYOesuu8emVZ1sHn1bVjF6fN4kF8AapWdT
        lF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJfx6MtbpoKN
        /BU3r0xnaWC8ydPFyMkhIWAisW7RNJYuRi4OIYGljBJ7r85ggkjISJyc1sAKYQtL/LnWxQZR
        9J5RYtHGmewgCWGBAomz06czgiREBJqZJObOOcwKUTWbUaL7Sx9YFZuAoUTXW5B2Tg5eATuJ
        jYdmgNksAqoSX9shbFGBZIm3r78zQdQISpyc+YQFxOYU8JDYd+ckM4jNLGAmMW/zQyhbXmL7
        2zlQtrjErSfzmSYwCs5C0j4LScssJC2zkLQsYGRZxSiSWlqcm55bbKRXnJhbXJqXrpecn7uJ
        ERhX24793LKDceWrj3qHGJk4GA8xSnAwK4nwXqhxTBTiTUmsrEotyo8vKs1JLT7EaAr0z0Rm
        KdHkfGBk55XEG5oZmBqamFkamFqaGSuJ85ocWRMvJJCeWJKanZpakFoE08fEwSnVwLTi93VH
        hyau3yIrRdP2VnqXfr/oVL7rKQej6d0VUs4B8xIDF5ixSHn7uyYuzPFO/MUlbslxuG+iPs9G
        i7jwP68vl4pddLbcePfIjY/v7tyU8vS6fiStfufJZfe23PzQxCOT/F70IOeE5wdkdyrHyair
        ySxtfRh7fbFNvoXIT/e7fDLiPJPXPfmnoHnSZfeBe9v0t6sXL2fIeC41u52Nd+9XQRbWCI9l
        yZGSzQUvmpKDlXZ3HE55+kBtqvy3FZ+C777+u/1tajVvjYXHW+VtFydIai7aZ/qx17jYtXSr
        AefcNrXJsvNSTy/Jf7amVmj9teMOfYtvuKrcnPWt7MvMHMfnomf5gs1f6X1gUWLZWafEUpyR
        aKjFXFScCAAFgJ97NAMAAA==
X-CMS-MailID: 20210917073034eucas1p1d80385c5327a757b26f8a7bdefa3b077
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210916144119eucas1p1ef79e9742c3d37d0d896f152b4252a0b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210916144119eucas1p1ef79e9742c3d37d0d896f152b4252a0b
References: <CGME20210916144119eucas1p1ef79e9742c3d37d0d896f152b4252a0b@eucas1p1.samsung.com>
        <20210916144102.120980-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 16.09.2021 16:41, Krzysztof Kozlowski wrote:
> This reverts commit 0da6736ecd10b45e535b100acd58df2db4c099d8.
>
> The MODULE_DEVICE_TABLE already creates proper alias.  Having another
> MODULE_ALIAS causes the alias to be duplicated:
>
>    $ modinfo max14577-regulator.ko
>
>    alias:          platform:max77836-regulator
>    alias:          platform:max14577-regulator
>    description:    Maxim 14577/77836 regulator driver
>    alias:          platform:max77836-regulator
>    alias:          platform:max14577-regulator
>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Fixes: 0da6736ecd10 ("regulator: max14577: Add proper module aliases strings")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>
> ---
>
> Not tested. Please test/comment.  This is an RFT also because reverted
> commit said to fix autoloading issue which I even reviewed... but really
> it should not be needed - alias gets duplicated.
> ---

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Indeed, that patch was useless and excessive. It must be some leftover 
from my initial modules tests, which for good reasons was not submitted 
in the initial series in Feb 2020. Sorry for the noise.

>   drivers/regulator/max14577-regulator.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/regulator/max14577-regulator.c b/drivers/regulator/max14577-regulator.c
> index 1d78b455cc48..e34face736f4 100644
> --- a/drivers/regulator/max14577-regulator.c
> +++ b/drivers/regulator/max14577-regulator.c
> @@ -269,5 +269,3 @@ module_exit(max14577_regulator_exit);
>   MODULE_AUTHOR("Krzysztof Kozlowski <krzk@kernel.org>");
>   MODULE_DESCRIPTION("Maxim 14577/77836 regulator driver");
>   MODULE_LICENSE("GPL");
> -MODULE_ALIAS("platform:max14577-regulator");
> -MODULE_ALIAS("platform:max77836-regulator");

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

