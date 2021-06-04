Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C949B39AFFD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 03:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhFDBqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 21:46:31 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:12577 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhFDBq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 21:46:29 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210604014442epoutp01b0e4c2f37595dec2ef9cbd9288e7fdf4~FPbOQOkyT0104501045epoutp01o
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 01:44:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210604014442epoutp01b0e4c2f37595dec2ef9cbd9288e7fdf4~FPbOQOkyT0104501045epoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1622771082;
        bh=Co8F/FZCK0h33VsOB2WY4fputFxkjYG/m10Td5PR/8M=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=JV1KJvAbdjYZMx4H4z9686MNcn6uXhIL1z+YocD2TpcXUhywKZOfveh0O6yDuv0ei
         p36L54uPA/sUJbPd9tkzWSa5du0HHbjVJK00CBoGzfDypyxFSphUhURNHRaHwdl7VI
         fP+KwI8OYPAGxtSTm2TlxDdbsCNh7B22bn917/zI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210604014441epcas1p14a553459b7470d995f88ba0878081ea8~FPbNqDX4z1570715707epcas1p1E;
        Fri,  4 Jun 2021 01:44:41 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.153]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Fx5D71bhZz4x9Q9; Fri,  4 Jun
        2021 01:44:39 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        2D.5A.10258.38589B06; Fri,  4 Jun 2021 10:44:35 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210604014435epcas1p178c2afb0aa12d73c5181f727a0eaad7b~FPbHv9Ryv1570715707epcas1p16;
        Fri,  4 Jun 2021 01:44:35 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210604014435epsmtrp10a0be7cfb26159b988d64b9a63010092~FPbHvGwHU0055900559epsmtrp1j;
        Fri,  4 Jun 2021 01:44:35 +0000 (GMT)
X-AuditID: b6c32a38-419ff70000002812-46-60b985838117
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C9.49.08637.28589B06; Fri,  4 Jun 2021 10:44:35 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210604014434epsmtip2bb5c58c12240395abb53f8cc63550216~FPbHfh47r0765107651epsmtip2M;
        Fri,  4 Jun 2021 01:44:34 +0000 (GMT)
Subject: Re: [PATCH v4 0/3] extcon: sm5502: Add support for SM5504
To:     Stephan Gerhold <stephan@gerhold.net>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <2beb794a-8249-1245-c78e-8abce4a42a55@samsung.com>
Date:   Fri, 4 Jun 2021 11:03:23 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20210603085222.89465-1-stephan@gerhold.net>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7bCmrm5z684Eg5srLS3mHznHanF51xw2
        i9uNK9gsrrzcwWLRuvcIu8WNuSYWm7//ZXRg92hbYO+xaVUnm8f/O2vZPfq2rGL0+NdV4vF5
        k1wAW1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7Q
        IUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScAssCveLE3OLSvHS95PxcK0MDAyNT
        oMKE7IxJU6UK2nkr7k/aytbAuJCri5GTQ0LAROLB7ibWLkYuDiGBHYwSe44+ZodwPjFKXNy7
        kwmkSkjgG6NEy+/MLkYOsI6pPcwQNXsZJf51rWKDcN4zSqy5M4MNpEFYwEni0M73rCANIgIh
        ElsPm4DUMAusYpT4umQLC0gNm4CWxP4XN8Dq+QUUJa7+eMwIYvMK2EksmnCcFcRmEVCRODT7
        E9gRogJhEie3tUDVCEqcnPkEbA6ngKXEmb0bwGqYBcQlbj2ZD2XLS2x/OwfsUgmBmRwSC25d
        YIb42UXi3PsV7BC2sMSr41ugbCmJl/1tUHa1xMqTR9ggmjsYJbbsv8AKkTCW2L90MhPIZ8wC
        mhLrd+lDhBUldv6eywixmE/i3dceVkho8Up0tAlBlChLXH5wlwnClpRY3N7JNoFRaRaSd2Yh
        eWEWkhdmISxbwMiyilEstaA4Nz212LDABDmuNzGCk6iWxQ7GuW8/6B1iZOJgPMQowcGsJMK7
        R21HghBvSmJlVWpRfnxRaU5q8SFGU2AAT2SWEk3OB6bxvJJ4Q1MjY2NjCxNDM1NDQyVx3nTn
        6gQhgfTEktTs1NSC1CKYPiYOTqkGpvh3ZVtMWfNTbFZb8jC+a7nFmWcy2ytlnrLjs+9Lnryc
        UaUdOHXjlCzjX+8ysub75L5raDyloLkwrJf74G/HU81r70rmrL/9t+xP03Fj3T656rv9uwI4
        NeOF3Ve8OyeZ0SLzUv6BcSHf/Y/l/jmnbjV95RCOWBMmKu6+4pNPk7hi8oTQ4G47bsYX0gdK
        99rV1nuwn78tt9Nr79lzyz8o7Y9++06o4W+PNXP7qTNfOvwupqTc3bbfRGfLZJH22kXnq19o
        6J/apXpk9dlJBsrbJpmw6udbtvCKrBeqPHXi4m8miWtpcmfPnw9kX7pH6+6VaUV+tmdOqB2b
        qh/xfCpfbPzd5XdPvb1qWXLuVv8aUSWW4oxEQy3mouJEAGloBaIrBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42LZdlhJXre5dWeCwfOnTBbzj5xjtbi8aw6b
        xe3GFWwWV17uYLFo3XuE3eLGXBOLzd//Mjqwe7QtsPfYtKqTzeP/nbXsHn1bVjF6/Osq8fi8
        SS6ALYrLJiU1J7MstUjfLoErY9JUqYJ23or7k7ayNTAu5Opi5OCQEDCRmNrD3MXIxSEksJtR
        4uqq96xdjJxAcUmJaRePMkPUCEscPlwMUfOWUWJ741cWkBphASeJQzsh6kUEQiSunVoINohZ
        YBWjxORPN9ggOnoYJbreXGQDqWIT0JLY/+IGmM0voChx9cdjRhCbV8BOYtGE42CTWARUJA7N
        /sQEYosKhEnsXPKYCaJGUOLkzCdgmzkFLCXO7N0AFmcWUJf4M+8SM4QtLnHryXyouLzE9rdz
        mCcwCs9C0j4LScssJC2zkLQsYGRZxSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kRHFFa
        mjsYt6/6oHeIkYmD8RCjBAezkgjvHrUdCUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcS
        SE8sSc1OTS1ILYLJMnFwSjUwtRd7pR6YMmv/GxPruUf77oT8OSUV0sZW9bqg+NyD6MKpgu9/
        9ssundr6/ub9ty4udiz1s1X8u1do2qon1128pjy9eGGuu8yKiJUCYdnH1Z0iz5ZFK0/jiJ2/
        VPDxgoiAw/t/LOC9ZX96cfq9LT9kEmwdc2c1Ke+8Mmnp5/+zlvM0bUhar6d5ZoE0c8lZ4ZQn
        cs2lkwqfSbtdZFC+s8Bdd9mFiQXZgj7xmyIqTjYdn1zczHW6t13BjnXBizu9tzTX+Hvum50U
        UfjL8viuyS8WVl3lzHSU6je3K/lkrVL2Rcw0xl/ym8c6w+sTPsivadDZc/U328YKS3G5VXLL
        77xSuxJyfaH7rMNX34qIhu2/qcRSnJFoqMVcVJwIALyCejsXAwAA
X-CMS-MailID: 20210604014435epcas1p178c2afb0aa12d73c5181f727a0eaad7b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210603085249epcas1p29dd8274c475b84be071e257ecdd9d37a
References: <CGME20210603085249epcas1p29dd8274c475b84be071e257ecdd9d37a@epcas1p2.samsung.com>
        <20210603085222.89465-1-stephan@gerhold.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/21 5:52 PM, Stephan Gerhold wrote:
> This patch series adds support for SM5504 to the existing extcon-sm5502
> driver. SM5502 and SM5504 are fairly similar so support for SM5504 can
> be added with a few simple changes to the code.
> 
> I tested this patch series on both SM5502 (Samsung Galaxy A5 2015)
> and SM5504 (Samsung Galaxy S4 Mini Value Edition) and it seems to work
> just fine for both.
> 
> ---
> Changes in v4:
>   - Add NULL check for .parse_irq (suggested by Chanwoo Choi)
>   - Add Rob's Acked-by: on the dt-bindings patch
> Changes in v3:
>   - Drop patch 1-4 (already applied)
>   - Avoid if (type == TYPE_SM5504) everywhere in the code, instead
>     introduce a struct sm5502_type that encodes chip-specific information.
> Changes in v2: Fix compile warning in last patch
> 
> v3: https://lore.kernel.org/lkml/20210601200007.218802-1-stephan@gerhold.net/
> v2: https://lore.kernel.org/lkml/20210531133438.3511-1-stephan@gerhold.net/
> v1: https://lore.kernel.org/lkml/20210520112334.129556-1-stephan@gerhold.net/
> 
> Stephan Gerhold (3):
>   dt-bindings: extcon: sm5502: Document siliconmitus,sm5504-muic
>   extcon: sm5502: Refactor driver to use chip-specific struct
>   extcon: sm5502: Add support for SM5504
> 
>  .../extcon/siliconmitus,sm5502-muic.yaml      |   6 +-
>  drivers/extcon/Kconfig                        |   2 +-
>  drivers/extcon/extcon-sm5502.c                | 200 +++++++++++++++---
>  drivers/extcon/extcon-sm5502.h                |  82 ++++++-
>  4 files changed, 252 insertions(+), 38 deletions(-)
> 

Applied them. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
