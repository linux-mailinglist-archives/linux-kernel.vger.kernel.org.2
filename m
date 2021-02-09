Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6932D314D47
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 11:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbhBIKia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 05:38:30 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:28334 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbhBIKe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:34:56 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210209103404epoutp03d4ab44d1e9a6937243390f5460552513~iDdmSQ7sE0378503785epoutp03O
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 10:34:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210209103404epoutp03d4ab44d1e9a6937243390f5460552513~iDdmSQ7sE0378503785epoutp03O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1612866844;
        bh=xl8NR+91H4gB0CkcxGhdg49Ur+0dDED5G9iO2bt74SY=;
        h=From:Subject:To:Cc:Date:References:From;
        b=Dn/Unply/yAc+ajAdNVxeMSKI/RRgmAQAaac4blUgGRVRzIGmWmjntcxyVgkkM7wv
         6lbTETuaXeQ8WiohODCdNffdL4m3geh2H0RdJFITJzQqjHHk6WJ9gIX8qj5LGIXX4c
         QWNtq1MlB1crED0hGFzeGM3PYzFRoT8ENp+uCKXE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210209103404epcas1p48dd1bdbc81b52a17edf0f984476ea48d~iDdmBk3h_2024720247epcas1p4b;
        Tue,  9 Feb 2021 10:34:04 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.156]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4DZfQ14HHLz4x9Pv; Tue,  9 Feb
        2021 10:34:01 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        6E.70.09582.51562206; Tue,  9 Feb 2021 19:33:57 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210209103356epcas1p35b1c52bf4f7597feadec360f6b7c3ae9~iDdfHLp1y2746127461epcas1p3X;
        Tue,  9 Feb 2021 10:33:56 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210209103356epsmtrp1f2a3148fea5ef55bda074c3a28e34b2f~iDdfGiSLw1456814568epsmtrp1z;
        Tue,  9 Feb 2021 10:33:56 +0000 (GMT)
X-AuditID: b6c32a37-8afff7000000256e-ae-60226515fc53
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E8.C0.08745.41562206; Tue,  9 Feb 2021 19:33:56 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210209103356epsmtip1a1790203bf9333fc895d1df466d7db93~iDde4DAZY1563115631epsmtip1N;
        Tue,  9 Feb 2021 10:33:56 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
Subject: [GIT PULL] extcon next for v5.12
Organization: Samsung Electronics
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        "Chanwoo Choi (samsung.com)" <cw00.choi@samsung.com>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
Message-ID: <199cf833-c46e-de3f-0996-492adc18eda3@samsung.com>
Date:   Tue, 9 Feb 2021 19:49:59 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdlhTX1c0VSnBYPUxaYuJN66wWFz/8pzV
        onnxejaLy7vmsFncblzB5sDqsWlVJ5vH/rlr2D36tqxi9Pi8SS6AJSrbJiM1MSW1SCE1Lzk/
        JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwdor5JCWWJOKVAoILG4WEnfzqYo
        v7QkVSEjv7jEVim1ICWnwLJArzgxt7g0L10vOT/XytDAwMgUqDAhO2Pi4aesBes5K26+W8DU
        wHiTvYuRk0NCwETi7ZPNjF2MXBxCAjsYJZrfXGWDcD4xSlzdt4AdwvnMKPHo1U9WmJZd2w4w
        QSR2MUps3NzFCJIQEnjPKNG0MgnEZhPQktj/4gYbiC0soCnx52AzC4jNL6AocfXHY7B6EQEN
        iZdHb7GADGIWeMMosWv+QmaQBK+AncStYxAHsgioSJx4OJsJxBYVCJM4ua2FEaJGUOLkzCdg
        Q5kFxCVuPZnPBGHLS2x/O4cZZKiEwFt2ic77p1ggznaRONH0nRnCFpZ4dXwLNASkJF72t0HZ
        1RIrTx5hg2juYJTYsv8C1M/GEvuXTgbawAG0QVNi/S59iLCixM7fcxkhFvNJvPvawwpSIiHA
        K9HRJgRRoixx+cFdJghbUmJxeycbhO0hMb13NvsERsVZSN6ZheSdWUjemYWweAEjyypGsdSC
        4tz01GLDAmPk6N7ECE6UWuY7GKe9/aB3iJGJg/EQowQHs5IIb2CnXIIQb0piZVVqUX58UWlO
        avEhRlNgAE9klhJNzgem6rySeENTI2NjYwsTQzNTQ0Mlcd4kgwfxQgLpiSWp2ampBalFMH1M
        HJxSDUynVUuPXnKerh4eE2uy0jBa49ZtzeU1O75IbZ8TYj6dx76o74uoUOJvpZnPChbrFUkW
        a1+sqdJzvWhgd1pu76rNe5fe6btmKOnrseMuI+ORnmJWx+7Wl6cvLZzq3zTB+4Vv6p3PnAb+
        mw+vay7bseiMdGz5mj2Hlh/9EWW/Qn692fqkshmrFjJsl92UKa5dfq5eeXbglP73n7rmbP3b
        mTX7yMymrM+cfUw3r9/6v/XHsTW/dKInyuWaXgqrVo2uNPsjEn5nW+OEq2uPiL+faqsacSg+
        cyXvnrnP4qOCE5t+HLmQJxKeIi8s1zJ18kwDYVk5lbOONzzSr05Z85HtpXGyuWqd+bmLiTMe
        S6ZrRBcpsRRnJBpqMRcVJwIALvDvmx0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsWy7bCSnK5IqlKCwY7thhYTb1xhsbj+5Tmr
        RfPi9WwWl3fNYbO43biCzYHVY9OqTjaP/XPXsHv0bVnF6PF5k1wASxSXTUpqTmZZapG+XQJX
        xsTDT1kL1nNW3Hy3gKmB8SZ7FyMnh4SAicSubQeYuhi5OIQEdjBKLPrzhRkiISkx7eJRIJsD
        yBaWOHy4GCQsJPCWUaLnUCWIzSagJbH/xQ02EFtYQFPiz8FmFhCbX0BR4uqPx4wgtoiAhsTL
        o7dYQOYzC7xhlJg98RVYglfATuLWMYgjWARUJE48nM0EYosKhEnsXPKYCaJGUOLkzCdgQ5kF
        1CX+zLvEDGGLS9x6Mp8JwpaX2P52DvMERsFZSFpmIWmZhaRlFpKWBYwsqxglUwuKc9Nziw0L
        jPJSy/WKE3OLS/PS9ZLzczcxgsNfS2sH455VH/QOMTJxMB5ilOBgVhLhDeyUSxDiTUmsrEot
        yo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qBSfusU5ifZmFm5hdjYZO1
        Wp7/MoS798p9ETtzgrnhxPHJKTwrZZl+rve8kVDetXaanFNqrnHKYQOtY0z/Xlv9qHTZIf5L
        Zb50WNmEnodVvDsObLj3K8Rt/+/P32patN79VN72lHMBQ1/ObIuSFt4t0+9mV93R/PGTZ93V
        XdvVr3y7s02aeXs2k/2GtMr501Q51wRM3H5FeuqnUKdngZ9LLn4K0T/rv3eNDLsLN2OUluC7
        F7UZMY+/XL57eF7on0VaWR8aSgQiDZWdIg6eNVQX+278vDqIL+uRv+UW3RUqUheYJRKME0Le
        3DPcWNTS38m35/3R5pudqk3LNyv5+u33evdwr3rau8NpXQ+2im+4o8RSnJFoqMVcVJwIAEGh
        WAzuAgAA
X-CMS-MailID: 20210209103356epcas1p35b1c52bf4f7597feadec360f6b7c3ae9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210209103356epcas1p35b1c52bf4f7597feadec360f6b7c3ae9
References: <CGME20210209103356epcas1p35b1c52bf4f7597feadec360f6b7c3ae9@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

This is extcon-next pull request for v5.12. I add detailed description of
this pull request on below. Please pull extcon with following updates.

Best Regards,
Chanwoo Choi


The following changes since commit 6ee1d745b7c9fd573fba142a2efdad76a9f1cb04:

  Linux 5.11-rc5 (2021-01-24 16:47:14 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-5.12

for you to fetch changes up to d8cc19be483ab2d74a1dd372d50ff9ac6cf37fa7:

  extcon: sm5502: Detect OTG when USB_ID is connected to ground (2021-02-09 19:42:06 +0900)

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      extcon: Add stubs for extcon_register_notifier_all() functions

Nikita Travkin (1):
      extcon: sm5502: Detect OTG when USB_ID is connected to ground

Timon Baetz (1):
      extcon: max8997: Add CHGINS and CHGRM interrupt handling

 drivers/extcon/extcon-max8997.c |  4 ++++
 drivers/extcon/extcon-sm5502.c  | 22 ++++++++++++++++++++--
 include/linux/extcon.h          | 23 +++++++++++++++++++++++
 3 files changed, 47 insertions(+), 2 deletions(-)


