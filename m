Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C1141D1CE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 05:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347915AbhI3DRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 23:17:12 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:38629 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347082AbhI3DRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 23:17:09 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210930031525epoutp019deaa1c5abcdcbfc8395c3fbfeb43e56~peyHVMVnC3198131981epoutp01W
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 03:15:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210930031525epoutp019deaa1c5abcdcbfc8395c3fbfeb43e56~peyHVMVnC3198131981epoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1632971725;
        bh=rnDll4TvTapkIQp0szEehuNWnc8pRGBRYEn5e2vLYJw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=gMRCYP0Z8iHT76mCnD3c1sArCPDhnQiH5RDIpjAAzZWCBaNMf4UN2TQy8d2aEtdLY
         auuWjKqZ+Qusqgdj+TdIWJKtuIoMa2i91uicU30Hq7XYSHWqTUSqReQJ1UT/socUQg
         u32bqP7N9XOe6r07Fr/fG/niqcLOEq9CBms4hqhk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210930031524epcas1p24823ceba2f97d418364927b0334f3d9a~peyG2Eyqk2328823288epcas1p2l;
        Thu, 30 Sep 2021 03:15:24 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.236]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4HKdfH0wgsz4x9Q3; Thu, 30 Sep
        2021 03:15:19 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        AE.FF.13888.ABB25516; Thu, 30 Sep 2021 12:15:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210930031506epcas1p31bd20aa301492bb47035cd46688b81a0~pex17JvHX1834118341epcas1p3K;
        Thu, 30 Sep 2021 03:15:06 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210930031506epsmtrp20d34869e1d2f74b65e4075fd929ebc1a~pex16c_Ew2931629316epsmtrp2Z;
        Thu, 30 Sep 2021 03:15:06 +0000 (GMT)
X-AuditID: b6c32a39-a3d0ba8000003640-b9-61552bba782e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        0F.0E.08750.ABB25516; Thu, 30 Sep 2021 12:15:06 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210930031506epsmtip2a6677adceaa28ce256d9162712eaf279~pex1rmk2R2107821078epsmtip24;
        Thu, 30 Sep 2021 03:15:06 +0000 (GMT)
Subject: Re: [PATCH v5 0/3] extcon: usbc-tusb320: Initial TUSB320L support
To:     Yassine Oudjana <y.oudjana@protonmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Michael Auchter <michael.auchter@ni.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <07981514-563a-d64b-3fbf-ddf51e021f2c@samsung.com>
Date:   Thu, 30 Sep 2021 12:36:22 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20210925054407.944225-1-y.oudjana@protonmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmru4u7dBEg75rNhbzj5xjtbi8aw6b
        xbPnP1ktbjeuYLNo3XuE3eLquonsDmwem1Z1snlcP7OdyaOnbROTR9+WVYwenzfJBbBGZdtk
        pCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAF2gpFCWmFMK
        FApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwLdArTswtLs1L18tLLbEyNDAwMgUqTMjO+Ppz
        ClvBFt6Khj1/WBoYr3N1MXJwSAiYSHy+k97FyMUhJLCDUWLD1o/MEM4nRoldD9azQDifGSXu
        /pnO3sXICdbx59deJojELkaJO03bmEASQgLvGSUe3IoEsYUFvCT+HFvDCmKLCFRLXNr/nglk
        HbNAhsTh+fUgYTYBLYn9L26wgdj8AooSV388ZgSxeQXsJFYf7GYGsVkEVCUe3b3HAmKLCoRJ
        nNzWAlUjKHFy5hOwOKeAvcSbh6/B6pkFxCVuPZnPBGHLS2x/O4cZ4uapHBI3r1lA2C4S63eu
        hIoLS7w6vgXqLymJz+/2skHY1RIrTx5hA/lRQqCDUWLL/gusEAljif1LJ0P9oimxfpc+RFhR
        YufvuYwQe/kk3n3tYYWELq9ER5sQRImyxOUHd5kgbEmJxe2dbBMYlWYh+WYWkg9mIflgFsKy
        BYwsqxjFUguKc9NTiw0LTOFRnZyfu4kRnDS1LHcwTn/7Qe8QIxMH4yFGCQ5mJRHeH+LBiUK8
        KYmVValF+fFFpTmpxYcYTYHhO5FZSjQ5H5i280riDU0sDUzMjIxNLAzNDJXEeY+9tkwUEkhP
        LEnNTk0tSC2C6WPi4JRqYJrbqr+y996VFwUTDDMP7tkxIaIj8MdPn/5UpbBVmqefhqrZqERN
        9tvKF3pa5jhfNi/X5MO3JSaL31S5s4GDq26de5rI91bFkPuvuPsKFLdKJ6SZxzb87zz5yunt
        BdmoGlNhgQU31dfsfqPSKO72k/lv+JU/fIpPD3tva8nkW/kni70ndiPr0QlNQm7rf/216jo4
        u+nlr0q/KVMkN044NPHQiX7ThoXs8rpS67eWNq8NmvaGq/kEb+Hqs7GV5bpKx9T0/6qtn1rL
        LOIYXZSWcnR+5/9K/lvV+zZ99NjLKuxlc6TWLODsAd2crRc8WbYunSgzUbakzetJ5Em5gJmz
        P5ae0s/YI+WvfYZ7bv1bWyWW4oxEQy3mouJEAEGODN4jBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsWy7bCSvO4u7dBEg5+rhCzmHznHanF51xw2
        i2fPf7Ja3G5cwWbRuvcIu8XVdRPZHdg8Nq3qZPO4fmY7k0dP2yYmj74tqxg9Pm+SC2CN4rJJ
        Sc3JLEst0rdL4Mr4+nMKW8EW3oqGPX9YGhivc3UxcnJICJhI/Pm1l6mLkYtDSGAHo8TVvfOZ
        IBKSEtMuHmXuYuQAsoUlDh8uhqh5yyix/M92ZpAaYQEviT/H1rCC2CIC1RJr2w8xgtjMAhkS
        r+acZYFomMQo0bJuN1gRm4CWxP4XN9hAbH4BRYmrPx6DNfAK2EmsPtgNNpRFQFXi0d17LCC2
        qECYxM4lj5kgagQlTs58AhbnFLCXePPwNTPEMnWJP/MuQdniEreeQDzALCAvsf3tHOYJjMKz
        kLTPQtIyC0nLLCQtCxhZVjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn525iBEeRltYOxj2r
        PugdYmTiYDzEKMHBrCTC+0M8OFGINyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZ
        qakFqUUwWSYOTqkGpgBf96KlhTo3N+h3X5LY97PyZJPNsju/7e9vX385ZuKdJaftWFg191q9
        /82o9CGA+V3i4emKlxLib6/WeHvEgNV1UYU4y6+N586funJN02FFyK9Uo9p06+bDy3q1DytF
        xXaxV6fJvmQUcUvWve07qeZvd0nFWsPXMR26HFdOyhUdKNhk8aTVrKc0ynhFzZqYJdtdeK/X
        Gq3om3lp+c3GoNWqVz4Y7PaTeecU8/g4s86unAMHLCTjP7qu6lu/Iaj4X/DzC1fPrJrsX//2
        QszFjxuYeISN+5+t3iFs+3Xejtyo1k1ndi0LT762L63eZEPQk/pNwjO6FzVtzt6gdLbv4dqL
        Tx8vfGfiyvCw6GcJa6USS3FGoqEWc1FxIgBTKwp8EQMAAA==
X-CMS-MailID: 20210930031506epcas1p31bd20aa301492bb47035cd46688b81a0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210925054535epcas1p45ad283474c848a9ec83febd44b4965b5
References: <CGME20210925054535epcas1p45ad283474c848a9ec83febd44b4965b5@epcas1p4.samsung.com>
        <20210925054407.944225-1-y.oudjana@protonmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/21 2:45 PM, Yassine Oudjana wrote:
> The TUSB320L is a newer chip with additional features. It is close enough to TUSB320 so it works
> to some extent out-of-the-box, but for some reason it can start in UFP mode which is not desirable.
> 
> This series adds support for reset and mode setting for both chips, and does that while probing
> to ensure the chip starts with the default mode of following the PORT pin.
> 
> Changes since v4:
>  - Use ops struct instead of type enum.
> Changes since v3:
>  - Remove unused tusb_modes.
>  - Remove extra blank line.
> Changes since v2:
>  - Read state before setting default mode, then update it again after resetting.
>  - Remove mode tracing from irq handler
>  - Add a delay after reset to handle tSOFT_RESET
>  - Use a separate mode setting function for each of TUSB320 and TUSB320L.
> Changes since v1:
>  - Split first patch into two patches, one adding support for mode setting and reset on TUSB320,
>    and the other adding support for TUSB320L.
>  - Fix dt_binding_check warning:
>    ../Documentation/devicetree/bindings/extcon/extcon-usbc-tusb320.yaml:15:6: [warning] wrong indentation: expected 6 but found 5 (indentation)
> 
> Yassine Oudjana (3):
>   extcon: usbc-tusb320: Add support for mode setting and reset
>   extcon: usbc-tusb320: Add support for TUSB320L
>   dt-bindings: extcon: usbc-tusb320: Add TUSB320L compatible string
> 
>  .../bindings/extcon/extcon-usbc-tusb320.yaml  |   4 +-
>  drivers/extcon/extcon-usbc-tusb320.c          | 163 +++++++++++++++++-
>  2 files changed, 161 insertions(+), 6 deletions(-)
> 

Thanks for fixup. Applied them.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
