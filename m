Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1800D429B56
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 04:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbhJLCSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 22:18:51 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:45478 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbhJLCSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 22:18:50 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20211012021646epoutp0432aa215a6ff73a1ec4ea42e2a65fd9da~tJuViQ2vP0119301193epoutp04G
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 02:16:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20211012021646epoutp0432aa215a6ff73a1ec4ea42e2a65fd9da~tJuViQ2vP0119301193epoutp04G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1634005006;
        bh=bjF8GfGDktGMGST+t3Qhy6O/bl7MPaWqkwBXBE1Yksw=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=EPRKeOK+rvppe4kJoP6Cp5AB4XgPzU6IE0SMLcaBAwXVq3ww1JV2GrPoRqQhNbQ4/
         I3p4i51AWwqNpOdQakTndHF95kaQ+wF3uSS9gfrLzA4XoNACW05mebA7wXHZWq+noy
         i6biMoInopQnvvCDbjP+YKi5L1iRsl20ULQJ/yTk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20211012021645epcas2p204cc2e5e077dfdb931a1eebb6044a885~tJuU8hu2Z1895118951epcas2p22;
        Tue, 12 Oct 2021 02:16:45 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.92]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4HSzn40DBZz4xBKn; Tue, 12 Oct
        2021 02:16:40 +0000 (GMT)
X-AuditID: b6c32a48-d75ff70000002500-c9-6164f006ef8d
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        4E.E7.09472.600F4616; Tue, 12 Oct 2021 11:16:39 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [PATCH v2] f2fs: fix to use WHINT_MODE
Reply-To: keosung.park@samsung.com
Sender: Keoseong Park <keosung.park@samsung.com>
From:   Keoseong Park <keosung.park@samsung.com>
To:     Chao Yu <chao@kernel.org>,
        Keoseong Park <keosung.park@samsung.com>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>
CC:     "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tanghuan@vivo.com" <tanghuan@vivo.com>,
        "changfengnan@vivo.com" <changfengnan@vivo.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Jinyoung CHOI <j-young.choi@samsung.com>,
        Sung-Jun Park <sungjun07.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <a59baec0-02cf-28d6-17cd-3ff6dfdf0a01@kernel.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20211012021638epcms2p88d9f7abf1abe4ddb29d314d950b537cb@epcms2p8>
Date:   Tue, 12 Oct 2021 11:16:38 +0900
X-CMS-MailID: 20211012021638epcms2p88d9f7abf1abe4ddb29d314d950b537cb
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGJsWRmVeSWpSXmKPExsWy7bCmhS77h5REg3/nGC3W9O1isjg99SyT
        xctDmharHoRb9PZvZbN4sn4Ws8Xxk+8YLS4tcre4vGsOm0Xn9DUsFnOOdrI7cHtsWtXJ5rF7
        wWcmj74tqxg9Pm+S89jwqYM5gDUq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJc
        SSEvMTfVVsnFJ0DXLTMH6C4lhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToF5gV5x
        Ym5xaV66Xl5qiZWhgYGRKVBhQnbGotO9TAWrWCtm3lzI1sC4nqWLkZNDQsBE4srTP2xdjFwc
        QgI7GCWuzjnB2MXIwcErICjxd4cwSI2wgLnEx7Xn2UBsIQElia6FW5kh4gYS66bvAbPZBPQk
        pvy+wwhiiwiUSJzfe5gdZCazwDcmiW9PH7JBLOOVmNH+FGqxtMT25VvBGjgF7CQerNnIBBHX
        kPixrJcZwhaVuLn6LTuM/f7YfEYIW0Si9d5ZqBpBiQc/d4PdLCEgKXHmsCtEuFxi4fllYDdI
        CHQwSrz+vgBqjr7EtY6NYDfwCvhKfH7UzQTSyyKgKnHzrCpEiYvE7dfdYOcwC8hLbH87hxmk
        hFlAU2L9Ln2ITcoSR26xwDzVsPE3OzqbWYBPouPwX7j4jnlPoB5Uk3i0YAvrBEblWYhwnoVk
        1yyEXQsYmVcxiqUWFOempxYbFZjAozY5P3cTIziBannsYJz99oPeIUYmDsZDjBIczEoivG85
        UhKFeFMSK6tSi/Lji0pzUosPMZoCPTmRWUo0OR+YwvNK4g1NLA1MzMwMzY1MDcyVxHnn/nNK
        FBJITyxJzU5NLUgtgulj4uCUamCa9+5aPEvTv6lPH5RufrnGoz3/2Vqmp+tYmNSUdx8RdHi1
        dtNm/kM9NvIVNVp9YU9PKz3a6uqsxcf7K3gx4xf2l4ekN68OfJ1+3mPnWe0buZtVK/Qiog8k
        uiXPfLuw7+Xn+XGz0u+czZuUsFHsBvui/Wd+qiRVv1G486yYNd/hi6p/Vm/QpIJbypE3G7n+
        Nct0xK7Tkk83/eO43fGA0pwnQT/LrQ12uORETtVb/oo7Q7Kix1Qt4bJgwd+o8Bubj0XFK31Y
        fu6km2zbaom387zez7o8O23R1qyZifNuaImH/JsQKCXje2lLT8/pu5FbH+7eviN7rqrVsQ+P
        0hJDv+wTmfLhjWP+0qPqn7QSOJayKbEUZyQaajEXFScCAPZYazopBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210930005939epcms2p7303bf6f96c824720f824989746491cba
References: <a59baec0-02cf-28d6-17cd-3ff6dfdf0a01@kernel.org>
        <20210930005939epcms2p7303bf6f96c824720f824989746491cba@epcms2p7>
        <CGME20210930005939epcms2p7303bf6f96c824720f824989746491cba@epcms2p8>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

>On 2021/9/30 8:59, Keoseong Park wrote:
>> Since active_logs can be set to 2 or 4 or NR_CURSEG_PERSIST_TYPE(6),
>> it cannot be set to NR_CURSEG_TYPE(8).
>> That is, whint_mode is always off.
>> 
>> Therefore, the condition is changed from NR_CURSEG_TYPE to NR_CURSEG_PERSIST_TYPE.
>> 
>
>Fixes: d0b9e42ab615 (f2fs: introduce inmem curseg)
>
>> Cc: Chao Yu <chao@kernel.org>
>> Reported-by: Huan Tang <tanghuan@vivo.com>
>> Signed-off-by: Fengnan Chang <changfengnan@vivo.com>
>> Signed-off-by: Keoseong Park <keosung.park@samsung.com>
>
>Reviewed-by: Chao Yu <chao@kernel.org>

Thank you for your review.

Best Regards,
Keoseong

>
>Thanks,
>
