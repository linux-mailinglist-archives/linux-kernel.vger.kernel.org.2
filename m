Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D6931B652
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 10:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhBOJTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 04:19:54 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:33297 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhBOJTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 04:19:45 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210215091859epoutp03102f52abe6dd603476c63df8fe75d338~j4TwcnTpq0920509205epoutp038
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 09:18:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210215091859epoutp03102f52abe6dd603476c63df8fe75d338~j4TwcnTpq0920509205epoutp038
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1613380739;
        bh=6/owuemKhVjUCH6bOSTNI5+VmTiUggn5iHpseWSD6c8=;
        h=From:Subject:To:Cc:Date:References:From;
        b=O2hOyD+/7rbZpX0JGu1I8SHFEjVNM33JcDrzDvFPYfwpNM6GOK1Wa34uWdiCSfux2
         QjnAV3dnbPkHb1RY4YyAtddAGHWo6ouSJ2PCFVrVQ0E5RMWj7hf4dNjCVUBDRM6vYX
         X3oWSAQDYDC0rC5qJ2OKciNcBt+/SX7hYwZeKm7s=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210215091859epcas1p28b057fed0e85fb5f5af48df82058a86b~j4TwLcGK_3113831138epcas1p2X;
        Mon, 15 Feb 2021 09:18:59 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.157]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4DfJSb63vSz4x9Pp; Mon, 15 Feb
        2021 09:18:55 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D4.7D.63458.B7C3A206; Mon, 15 Feb 2021 18:18:51 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210215091851epcas1p1bef95c3b1dcc958bb48667ef7dc820a2~j4ToSDsXx3080230802epcas1p13;
        Mon, 15 Feb 2021 09:18:51 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210215091851epsmtrp23643da47736497986ab09ee91e5a228d~j4ToRMfW_1494514945epsmtrp2k;
        Mon, 15 Feb 2021 09:18:51 +0000 (GMT)
X-AuditID: b6c32a36-6dfff7000000f7e2-0b-602a3c7b594e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        6D.3A.08745.A7C3A206; Mon, 15 Feb 2021 18:18:50 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210215091850epsmtip2733589a80c9ca87ccf4ce41add53638e~j4ToG0fcl0443404434epsmtip2X;
        Mon, 15 Feb 2021 09:18:50 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
Subject: [GIT PULL v3] extcon next for v5.12
Organization: Samsung Electronics
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (samsung.com)" <cw00.choi@samsung.com>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>
Message-ID: <e52e5d36-f7f1-4a3f-869e-88cc5e15b7c3@samsung.com>
Date:   Mon, 15 Feb 2021 18:35:16 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdlhTT7faRivB4O0RGYuJN66wWFz/8pzV
        onnxejaLy7vmsDmweGxa1cnmsX/uGnaPvi2rGD0+b5ILYInKtslITUxJLVJIzUvOT8nMS7dV
        8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBWqmkUJaYUwoUCkgsLlbSt7Mpyi8tSVXI
        yC8usVVKLUjJKbAs0CtOzC0uzUvXS87PtTI0MDAyBSpMyM448vIvU8EarooHV3+wNjDu4+hi
        5OSQEDCRmPyilb2LkYtDSGAHo8SMI+ugnE+MEst2XmKDcD4zSnye+pINpuX2mV5GiMQuRokD
        f1exgySEBN4zSky85QhiswloSex/cQOsQVhAR+LA+v+MIDa/gKLE1R+PwWwRAQ2Jl0dvsYDY
        zAJbGSW+LMgBsXkF7CQmvVsBNJODg0VAVeLAn1KQsKhAmMTJbS2MECWCEidnPoFqFZe49WQ+
        E4QtL7H97RxmiDvvsUs0fYa62UVi3ZQOqLiwxKvjW9ghbCmJz+/2QtVUS6w8eQTsYQmBDkaJ
        LfsvsEIkjCX2L53MBHIPs4CmxPpd+hBhRYmdv+cyQuzlk3j3tYcVpERCgFeio00IokRZ4vKD
        u0wQtqTE4vZONogSD4n53fUTGBVnIXlmFpJnZiF5ZhbC3gWMLKsYxVILinPTU4sNC4yQo3oT
        IzgtapntYJz09oPeIUYmDsZDjBIczEoivFclNBKEeFMSK6tSi/Lji0pzUosPMZoCQ3cis5Ro
        cj4wMeeVxBuaGhkbG1uYGJqZGhoqifMmGjyIFxJITyxJzU5NLUgtgulj4uCUamASm8aS8eSO
        w7attyR2SSSfvc51MnZqGdfCu/4rHG5OEM20T5Brn6Gt/takRyHIx7e50G79f13FT5926a/1
        s1z7f3913aLSc1Y6smnhs0PN1DzsLT5M6BLMSznje9KmNeqh7dGXP4TU6tMVJn9NXLW19+al
        SL4Mr0lJP19+91olv/pzeJFH1VNXhz1O+w69DngmY39w7d1lST539CXczhxUKI4OSavcmMH+
        yaPl4KUQVvWJDx5Gf9Kx/3wg7NVuW51zDhunBXz6b/eO7/j3AtNTVY3Xl134P+EZ65Z5a0PK
        jUOWC3jc3Ja7cMG+tWUrsiWf3V2jZKd2/vsrmbCKq5NaEx9Pf3lQ4Chzd0xmTfQhJZbijERD
        Leai4kQA9MgnGxQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsWy7bCSvG6VjVaCwe/3VhYTb1xhsbj+5Tmr
        RfPi9WwWl3fNYXNg8di0qpPNY//cNewefVtWMXp83iQXwBLFZZOSmpNZllqkb5fAlXHk5V+m
        gjVcFQ+u/mBtYNzH0cXIySEhYCJx+0wvYxcjF4eQwA5GiRPLPzJDJCQlpl08CmRzANnCEocP
        F0PUvGWU2HvyOAtIDZuAlsT+FzfYQGxhAR2JA+v/M4LY/AKKEld/PAazRQQ0JF4evQVWzyyw
        lVHi264oEJtXwE5i0rsV7CDzWQRUJQ78KQUJiwqESexc8pgJokRQ4uTMJ1Ct6hJ/5l1ihrDF
        JW49mc8EYctLbH87h3kCo+AsJC2zkLTMQtIyC0nLAkaWVYySqQXFuem5xYYFRnmp5XrFibnF
        pXnpesn5uZsYwSGvpbWDcc+qD3qHGJk4GA8xSnAwK4nwXpXQSBDiTUmsrEotyo8vKs1JLT7E
        KM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qBKXpb1k8tV21Rlh+PZZWPG5hH3u1/W/9L
        RFqO7WfAK8FrQpts2KsN8l+oPxI4FfCGr8dan4uzIEv9tMjsP7u+p+sz3GJP6tARur9e6/Lx
        7GOcFk4L99Qqrngvf07NT1VmiqKi6Dc7k99is7qvRVcmfvxic9Pv0VLmRRknm+YV6Gx90V6b
        qhOiNP364daa4/ttrj9yKLj88orx/GsJzxTveZTa/uVb/ufd/7vTpQ3nr17L+Gb/53+rRPKC
        xB8auk0zOu68NClP23dd5UJVCdO2CZo+SltETnudSFMwETE7kiqjec9wr+fTNuP7p0VOtzef
        +mvA/+BFqq68n+hr5W19E44+MvZh+9H/OfvrpmdTlViKMxINtZiLihMB0zHJeegCAAA=
X-CMS-MailID: 20210215091851epcas1p1bef95c3b1dcc958bb48667ef7dc820a2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210215091851epcas1p1bef95c3b1dcc958bb48667ef7dc820a2
References: <CGME20210215091851epcas1p1bef95c3b1dcc958bb48667ef7dc820a2@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

This is extcon-next pull request for v5.12. I add detailed description of
this pull request on below. Please pull extcon with following updates.

Changes from v2:
- Add missing the diff statistics information

Changes from v1:
- Add missing committer information

Best Regards,
Chanwoo Choi


The following changes since commit 6ee1d745b7c9fd573fba142a2efdad76a9f1cb04:

  Linux 5.11-rc5 (2021-01-24 16:47:14 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-5.12-v2

for you to fetch changes up to bd30a35764e136dc372e74c4856de633cb7ed8de:

  extcon: sm5502: Detect OTG when USB_ID is connected to ground (2021-02-10 08:15:28 +0900)

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

