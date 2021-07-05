Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0EA3BB593
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 05:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhGEDaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 23:30:00 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:16415 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhGED37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 23:29:59 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210705032721epoutp04e0a90703dea1d367a5ac4fd3a22f0821~Ox0tCQz0x1589215892epoutp04j
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 03:27:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210705032721epoutp04e0a90703dea1d367a5ac4fd3a22f0821~Ox0tCQz0x1589215892epoutp04j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1625455641;
        bh=ybHSpjbcx6noV3UGW+iavvqJS/y+XPlWi+JIuohvd4c=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Fds4fGAhUHOcP8hM5frP9rSdpAjgfrtFfz1Jz0vnllPPfX3/rW95rtKzpxKr6gDc4
         koWGeE1CNroQlJfuqdrSBTNVmzOnmpd4ReABApEe/po1NibUt3PB07M4LEEYnPBi8M
         Ic8+Y8Rqb3nakUkS3pW6dkFdR5xh9LrwWfZAXpYE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210705032721epcas1p203486199f2bd8ae28b0c58c272116c9b~Ox0smSsXg2734827348epcas1p2a;
        Mon,  5 Jul 2021 03:27:21 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.163]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4GJB2G6518z4x9Pv; Mon,  5 Jul
        2021 03:27:18 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        43.ED.09586.61C72E06; Mon,  5 Jul 2021 12:27:18 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210705032718epcas1p2a88bc622479d0881c7c63fb201f05c32~Ox0qIpfLE2732527325epcas1p2i;
        Mon,  5 Jul 2021 03:27:18 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210705032718epsmtrp2caf4991417d54430e5f8baa232db9b5a~Ox0qHDcuv2205222052epsmtrp2H;
        Mon,  5 Jul 2021 03:27:18 +0000 (GMT)
X-AuditID: b6c32a39-86dff70000002572-63-60e27c16dc1b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        EF.CD.08289.61C72E06; Mon,  5 Jul 2021 12:27:18 +0900 (KST)
Received: from namjaejeon01 (unknown [10.89.31.77]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20210705032718epsmtip1ddbb68ac554d0724104e087a87d30ebd~Ox0p9k2pr2012420124epsmtip1z;
        Mon,  5 Jul 2021 03:27:18 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Linus Torvalds'" <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>
Subject: [GIT PULL] exfat update for 5.14-rc1
Date:   Mon, 5 Jul 2021 12:27:18 +0900
Message-ID: <002c01d7714d$a8699070$f93cb150$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AddxTNCi5TjqK4EERViSMJbnXEJ2Zw==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKKsWRmVeSWpSXmKPExsWy7bCmga5YzaMEg03rDCwu75rDZrHl3xFW
        i0d9b9kdmD1OzPjN4tG3ZRWjx+dNcgHMUTk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6
        hpYW5koKeYm5qbZKLj4Bum6ZOUCLlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF
        hgYFesWJucWleel6yfm5VoYGBkamQJUJORnts/eyFTRyVtxb+Zu5gXEnexcjJ4eEgInEo1ln
        mboYuTiEBHYwSqx51cAGkhAS+MQoseOoNETiM6PE1JtLWGA6DrafYoNI7GKU2PnhCTOE84JR
        YvPLa2BVbAK6Ev/+7Aeq4uAQETCT+LbEESTMLOAv0Xb1MBOILQxUsn3fcjCbRUBF4v2XeSwg
        5bwClhIdU61AwrwCghInZz5hgWiVl9j+dg4zxA0KEj+fLmOFmK4n8e1tKUSJiMTszjaoknPs
        EqdPxEHYLhLnWvtZIWxhiVfHt0A9LyXx+d1eNgi7XOLEyV9MEHaNxIZ5+9hBxksIGEv0vCgB
        MZkFNCXW79KHqFCU2Pl7LiPEVj6Jd197WCGqeSU62oQgSlQl+i4dhhooLdHV/gFqqYfElnWN
        7BMYFWcheXEWkhdnIfllFsLiBYwsqxjFUguKc9NTiw0LTJHjeRMjOP1pWe5gnP72g94hRiYO
        xkOMEhzMSiK8ofPuJQjxpiRWVqUW5ccXleakFh9iNAWG+URmKdHkfGACziuJNzQ1MjY2tjAx
        MzczNVYS593JdihBSCA9sSQ1OzW1ILUIpo+Jg1OqgSmDa0r8lLI65/mvnA42Huvi2PvrK8dc
        9wsbRN3m1lUWOYQ+f1k270nCHr5A9XcPbmmw7vqncZGfqXBlgsBrQe4DkswB5ge3b6pRkgjm
        O/vpVaDdgjVeGixa/WKHF7ywzz8j1dD4YmlZh+G35xINiutn/bVaMfsdl4n2TU7JwPVnn4bW
        uZZLH0v5+Gp+76P/7/p/RMQG5fvI7IybsHzhrb+5ToeX9bBy7NAwFfr6/v494//VHkJdjify
        2BzmvviyRuJv58WEcomVz5ynxv+86G9l9WzWxrdBS7ftay2UVdZNU/OLfJsYJPIguKh4tnIz
        V9/N295PhU41Hr7y7ZbyNhHLl3PC6vQ38s+V3Bvy6bwSS3FGoqEWc1FxIgCLLW9tCAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsWy7bCSnK5YzaMEg7OvpCwu75rDZrHl3xFW
        i0d9b9kdmD1OzPjN4tG3ZRWjx+dNcgHMUVw2Kak5mWWpRfp2CVwZ7bP3shU0clbcW/mbuYFx
        J3sXIyeHhICJxMH2U2xdjFwcQgI7GCV6909ghkhISxw7cQbI5gCyhSUOHy4GCQsJPGOU6Hlo
        AWKzCehK/Puznw2kRETATOLbEkcQk1nAX+L+ZXeQCmGgiu37ljOB2CwCKhLvv8xjASnhFbCU
        6JhqBRLmFRCUODnzCQtEp55E20ZGkDCzgLzE9rdzoE5RkPj5dBkrxB49iW9vSyFKRCRmd7Yx
        T2AUnIVk0CyEQbOQDJqFpGMBI8sqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzgkNbS
        2sG4Z9UHvUOMTByMhxglOJiVRHhD591LEOJNSaysSi3Kjy8qzUktPsQozcGiJM57oetkvJBA
        emJJanZqakFqEUyWiYNTqoFpISP/oZW/33SardZx6XEXjbV6eJt3SpeTgmipBFvs4qqT/OeZ
        WY++vMye93Jq0STRbocQyfaz2fyhL9VlHzL3xDeU7LiXxLzIan+IeLHbxMvnppXyT7yxzHrL
        vNmlUfbOduV1U+vTliZffFbXeHrmsgwnofNvVcSNa7RNxTPtjpY/NMiyscxs7Nbfp9k5fbOn
        0/LvX0+7HvAwX9qqlTanwOpIJ0PA5Bd3KxWbV+h3rZJwni/Xd/76Ho2s0HWTDxQ6GG8TvX5z
        3+yU0NVSsmFyJxs3vbnlc/Pd/N1nn++qy/55rJdBnfNNhFmJZ4TtxpdKU6oXs7dOvK8w7XrO
        44hUu8iunTNN//SezbxZkKzEUpyRaKjFXFScCABVTst42AIAAA==
X-CMS-MailID: 20210705032718epcas1p2a88bc622479d0881c7c63fb201f05c32
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210705032718epcas1p2a88bc622479d0881c7c63fb201f05c32
References: <CGME20210705032718epcas1p2a88bc622479d0881c7c63fb201f05c32@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is exfat update pull request for v5.14-rc1. I add description of
this pull request on below. Please pull exfat with following ones.

Thanks!

The following changes since commit 62fb9874f5da54fdb243003b386128037319b219:

  Linux 5.13 (2021-06-27 15:21:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-5.14-rc1

for you to fetch changes up to 1e5654de0f51890f88abd409ebf4867782431e81:

  exfat: handle wrong stream entry size in exfat_readdir() (2021-07-04 09:33:00 +0900)

----------------------------------------------------------------
Description for this pull request:
- Improved compatibility issue with exfat from some camera vendors.
- Do not need to release root inode on error path.

----------------------------------------------------------------
Chen Li (1):
      exfat: avoid incorrectly releasing for root inode

Namjae Jeon (1):
      exfat: handle wrong stream entry size in exfat_readdir()

 fs/exfat/dir.c   | 8 +++++---
 fs/exfat/super.c | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

