Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B0131B67E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 10:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhBOJas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 04:30:48 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:22822 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhBOJam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 04:30:42 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210215092959epoutp04abcca9a66873ce5da9e2f854108e5ddd~j4dWgzj1x2617126171epoutp04w
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 09:29:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210215092959epoutp04abcca9a66873ce5da9e2f854108e5ddd~j4dWgzj1x2617126171epoutp04w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1613381399;
        bh=aY5iXOWPvN43ViRbCT0K4lIIiqwL8bLsedbtaaQaJAY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=tpm9Vj5jM2ORwGFgvBe/EnO3+ZaA6/erFIKUEWgP9m9aSewxOHe90gRRjILMOl5GN
         eZJfi52panyN14Vb1zEiEabWYaw9N5UI4EfLBMwbgf3D8pXKY79Z17C3NZxUFuAZOs
         n4k7BqPASqYmnr+WY3t1BnNd5Q+hswINNaPPROnI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210215092958epcas1p3a197231d68a6094bfed30ae38a329341~j4dWN9gra1751917519epcas1p3-;
        Mon, 15 Feb 2021 09:29:58 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.155]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4DfJjH6Jcpz4x9Ps; Mon, 15 Feb
        2021 09:29:55 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        D5.D5.02418.31F3A206; Mon, 15 Feb 2021 18:29:55 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210215092954epcas1p1d3f35f29b0d13c4d97ce1515a56a75ff~j4dSQ0VwT1522115221epcas1p1H;
        Mon, 15 Feb 2021 09:29:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210215092954epsmtrp22503f2c1722e45f06cb66c94a7681889~j4dSQHwxA1992019920epsmtrp2I;
        Mon, 15 Feb 2021 09:29:54 +0000 (GMT)
X-AuditID: b6c32a35-c23ff70000010972-59-602a3f130351
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5E.9B.13470.21F3A206; Mon, 15 Feb 2021 18:29:54 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210215092954epsmtip1ff3d7e8984140f3ac4820f5cdc1dfdce~j4dSHPlI90686106861epsmtip1D;
        Mon, 15 Feb 2021 09:29:54 +0000 (GMT)
Subject: Re: [GIT PULL v3] extcon next for v5.12
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <f21b4546-82bd-ba11-067c-318338cdd62e@samsung.com>
Date:   Mon, 15 Feb 2021 18:46:20 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <YCo+OyO6/yBH+R6o@kroah.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7bCmvq6wvVaCwdtJBhYTb1xhsWhevJ7N
        4vKuOWwOzB6bVnWyeeyfu4bd4/MmuQDmqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0Nd
        Q0sLcyWFvMTcVFslF58AXbfMHKBFSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC
        ywK94sTc4tK8dL3k/FwrQwMDI1OgwoTsjJWtMgXb2SqWbF3L2MD4i6WLkZNDQsBE4vPh42xd
        jFwcQgI7GCWadv6Gcj4xSkyYfpMRwvnGKDF/0TRGmJYZ2x6xQyT2Mkp8XTSbCSQhJPCeUaJl
        VjSILSxgIPHo8xlWEFtEQEPi5dFbQPs4OJgFaiUab9WDhNkEtCT2v7jBBmLzCyhKXP3xGGw+
        r4CdxM5vq8DOYxFQlZgz+Q6YLSoQJnFyWwtUjaDEyZlPwOKcApoS7b/3g61iFhCXuPVkPhOE
        LS+x/e0cZpA7JQTeskv8vnCYFeIBF4mW7Y+gbGGJV8e3sEPYUhKf3+1lg7CrJVaePMIG0dzB
        KLFl/wWoBmOJ/UsnM0E8oymxfpc+RFhRYufvuYwQi/kk3n3tYQUpkRDglehoE4IoUZa4/OAu
        E4QtKbG4vZNtAqPSLCTvzELywiwkL8xCWLaAkWUVo1hqQXFuemqxYYEhclxvYgQnQS3THYwT
        337QO8TIxMF4iFGCg1lJhPeqhEaCEG9KYmVValF+fFFpTmrxIUZTYABPZJYSTc4HpuG8knhD
        UyNjY2MLE0MzU0NDJXHeJIMH8UIC6YklqdmpqQWpRTB9TBycUg1ML1Ic1snmRUc3PjXffc8n
        51bc/K7le3O+J9xhvzY7t5KlYcaFEK94DfYrG7iXBi/oUP3z5Vqo1UyTV8obpaP3VPSKLXzg
        f4zZ9ebbTUmTGB1WrE0pe6VW+XGbgfKyhuUihZLNGaZOhhcsTXd2/XK1al8rcuX9250TPsxx
        7UhINmq9rlv5KT1LWYCv7e4P3Sd2OdFJ8zlnSmlFLzgWKh39tmvpQ8VWgbe3Xr+dYrYm7860
        OxLJ/zlZlE1fvVE6tGLyjVdSufoai7/u3T1net7xC4vjZhSq2Rx3tCgS4jm/8ccPV0dGi+C+
        h3Pirh+q131099nJuG3zMpZml9W4Mu5/+z7uE/Mk2wjVPZO+937WVGIpzkg01GIuKk4EAHSL
        lJMLBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsWy7bCSnK6QvVaCweY5ihYTb1xhsWhevJ7N
        4vKuOWwOzB6bVnWyeeyfu4bd4/MmuQDmKC6blNSczLLUIn27BK6Mla0yBdvZKpZsXcvYwPiL
        pYuRk0NCwERixrZH7F2MXBxCArsZJZZ+WskKkZCUmHbxKHMXIweQLSxx+HAxSFhI4C2jxOfm
        ehBbWMBA4tHnM2DlIgIaEi+P3gKbySxQK3F2wzRmiPqNjBJtX6VBbDYBLYn9L26wgdj8AooS
        V388ZgSxeQXsJHZ+WwXWyyKgKjFn8h0wW1QgTGLnksdMEDWCEidnPgGLcwpoSrT/3s8KsUtd
        4s+8S8wQtrjErSfzmSBseYntb+cwT2AUnoWkfRaSlllIWmYhaVnAyLKKUTK1oDg3PbfYsMAw
        L7Vcrzgxt7g0L10vOT93EyM4GrQ0dzBuX/VB7xAjEwfjIUYJDmYlEd6rEhoJQrwpiZVVqUX5
        8UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTAdMf20eq/hh6c3o3dv22qd
        3tp5nNt5xpe7rmqXnjhxfAl6UDth6WLtM4cYcvkZb1ufLtKZvHu24XXBzxbfY0QmLK/rmxc7
        L6XSj3fR74AFd64cXWDM672p41I/S/ldnonXNr7P7Fn6ujvqL++vlzoHBUy+PF+Vc3th5VeJ
        GSkfFLgV77NMuMW4Yr5Xl9khCf0Fz3wtGYwWWSm5R7uaunZvrt7BHHmJ745SwZcH6a+3svH3
        s4gc2h14sUS1w3T6mr0hngYv1sb4XWf7PcOjMiczu3JdnP6b52di7nVKS1o84zugu5lT/AlD
        RcODzyZ22vMmcXy9/7XzaLRgC9drRpW/m6W/VL+0ZivTuytSkvhdiaU4I9FQi7moOBEAb2zb
        1PUCAAA=
X-CMS-MailID: 20210215092954epcas1p1d3f35f29b0d13c4d97ce1515a56a75ff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210215091851epcas1p1bef95c3b1dcc958bb48667ef7dc820a2
References: <CGME20210215091851epcas1p1bef95c3b1dcc958bb48667ef7dc820a2@epcas1p1.samsung.com>
        <e52e5d36-f7f1-4a3f-869e-88cc5e15b7c3@samsung.com>
        <YCo+OyO6/yBH+R6o@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

On 2/15/21 6:26 PM, Greg KH wrote:
> On Mon, Feb 15, 2021 at 06:35:16PM +0900, Chanwoo Choi wrote:
>> Dear Greg,
>>
>> This is extcon-next pull request for v5.12. I add detailed description of
>> this pull request on below. Please pull extcon with following updates.
> 
> As 5.11 is now out, I can't take new things in my tree until 5.12-rc1 is
> out, sorry.
> 
> Please break this up into bugfixes and new features and send them to me
> for 5.12-rc1.
> 
> Or just send them to me now as patches in emails and I will queue them
> up to my trees properly when 5.12-rc1 it out.  That might be the easiest
> thing for you to do now.

I'm sorry for late reply. I'll send the patchset right now
instead of pull request. Thanks for guide.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
