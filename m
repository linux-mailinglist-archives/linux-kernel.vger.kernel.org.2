Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A69313164
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 12:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbhBHLvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 06:51:15 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:42936 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbhBHL3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 06:29:13 -0500
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210208112818epoutp03c7d458261b78cdcf95355124971c3a0c~hwjqos98j0966709667epoutp03V
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 11:28:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210208112818epoutp03c7d458261b78cdcf95355124971c3a0c~hwjqos98j0966709667epoutp03V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1612783698;
        bh=G/YGXetst+g+ng+HSczUSLlDg6C553zVGP+ZGVKuFLc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SgSRbgYpw375mLvf+mdnuvTwAuiLiZMVctsWlvjB5UVzd2HTxLPcX85MH8UFSCc7f
         01Z14LqAbbF2baUduGkMojIZI3XSfaH5a/GAJY2FFVgtPA+Fww1CK1bU40VxdA9py4
         G6nh5NjQ2mMeqzy+BL/KdByQOrvglyT0mhdNXPnE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20210208112818epcas2p4638de8ba999c81f3d9aad75a23340bef~hwjqRaMfi1089110891epcas2p4y;
        Mon,  8 Feb 2021 11:28:18 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.40.184]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4DZ3g51WVhz4x9Q2; Mon,  8 Feb
        2021 11:28:17 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        1D.0A.10621.15021206; Mon,  8 Feb 2021 20:28:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20210208112816epcas2p43777bb9740f7307e38cb534f01099126~hwjowg9Ql1089110891epcas2p4v;
        Mon,  8 Feb 2021 11:28:16 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210208112816epsmtrp2bae6f5d1817ee5dbee05dfb4dd4b8467~hwjov0D3C0167301673epsmtrp2r;
        Mon,  8 Feb 2021 11:28:16 +0000 (GMT)
X-AuditID: b6c32a45-337ff7000001297d-d3-602120515fe2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        02.32.08745.05021206; Mon,  8 Feb 2021 20:28:16 +0900 (KST)
Received: from rack03.dsn.sec.samsung.com (unknown [12.36.155.109]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210208112816epsmtip2b1195a246a6236c6edfc78fe0eda3045~hwjog34oS1209912099epsmtip24;
        Mon,  8 Feb 2021 11:28:16 +0000 (GMT)
From:   taehyun cho <taehyun.cho@samsung.com>
To:     balbi@kernel.org
Cc:     taehyun.cho@samsung.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc3: make USB_DWC3_EXYNOS independent
Date:   Mon,  8 Feb 2021 20:29:06 +0900
Message-Id: <20210208112906.134448-1-taehyun.cho@samsung.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <taehyun cho>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsWy7bCmuW6ggmKCwYzL7BbH2p6wWzQvXs9m
        cXnXHDaLRctamS0mHRR1YPXYtKqTzWP/3DXsHn1bVjF6fN4kF8ASlWOTkZqYklqkkJqXnJ+S
        mZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA7RWSaEsMacUKBSQWFyspG9nU5Rf
        WpKqkJFfXGKrlFqQklNgaFigV5yYW1yal66XnJ9rZWhgYGQKVJmQk7F7x1vmgu/sFQ9Wv2ds
        YDzE1sXIySEhYCLRtH4nM4gtJLCDUaJvAwuE/YlRYlI3XxcjF5D9mVHi2adFTDAN9xe2s0Ik
        djFKbH88jxWi4wejxOXd/iA2m4C2xP7mm2BxEQERibbnM5hAGpgFOhklrjx+DDZJWMBG4v3n
        ZYwgNouAqsTP5xPBzuAVsJVo7XnCCrFNXmJRw2+wek4BKYnPx/ayQNQISpyc+QTMZgaqad46
        mxlkgYTAOXaJ1TtWQTW7SFxZ+IMdwhaWeHV8C5QNNOjdXjaIhnZGiV8n1rBCOFMYJT6sO8UI
        UWUsMetZO5DNAbRCU2L9Ln0QU0JAWeLILajFfBIdh/+yQ4R5JTrahCAaVSXaL96HBq+0xKXN
        N6FsD4mDGyBsIYFcibOfH7NOYFSYheSdWUjemYWwdwEj8ypGsdSC4tz01GKjAkPkCN7ECE6G
        Wq47GCe//aB3iJGJg/EQowQHs5IIb2CnXIIQb0piZVVqUX58UWlOavEhRlNgYE9klhJNzgem
        47ySeENTIzMzA0tTC1MzIwslcd5igwfxQgLpiSWp2ampBalFMH1MHJxSDUylR55fK+p471l6
        50Fq6c2VQnWpneKby7eb8izebD03pcfF+b71Q66TDVPLv+55G1O/zVVccn37vH+Ht1V+e+8r
        4SSvfu+ablG8c/s0Z0/HC9fCPSwtD899tkNqtbbToaDdEfYzbpdYXtiWHxBtYXJDpUuUUeNf
        7cpZ3x4t/BYx7/2UpsU/93wz+rdJ1YiL+9+m0yVLRcK7nE4v/BN/UDTuRKNNzxXDfm3zTE3h
        G575HZVliotq0vf+XqXNK7HZ/M7W+dcfGTC/nniAPVbXYuJHy5+8jauu3pOP/LPSLMPt5GtW
        251vC2yOT1pbtjEwv5Q3OerSg23pwm51dU5eHD9Lpu467GizMfy8dlrLUTUlluKMREMt5qLi
        RAAQAhu7DwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBLMWRmVeSWpSXmKPExsWy7bCSvG6AgmKCQd8hVYtjbU/YLZoXr2ez
        uLxrDpvFomWtzBaTDoo6sHpsWtXJ5rF/7hp2j74tqxg9Pm+SC2CJ4rJJSc3JLEst0rdL4MrY
        veMtc8F39ooHq98zNjAeYuti5OSQEDCRuL+wnbWLkYtDSGAHo8SCzS+YIBLSEqceL2CGsIUl
        7rccgSr6xijx8vIVsG42AW2J/c03WUFsEQERibbnM5hAipgFuhkl+p4eBZskLGAj8f7zMkYQ
        m0VAVeLn84lgU3kFbCVae56wQmyQl1jU8BusnlNASuLzsb0sILaQgKTE0xtb2CHqBSVOznwC
        FmcGqm/eOpt5AqPALCSpWUhSCxiZVjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn525iBAeu
        ltYOxj2rPugdYmTiYDzEKMHBrCTCG9gplyDEm5JYWZValB9fVJqTWnyIUZqDRUmc90LXyXgh
        gfTEktTs1NSC1CKYLBMHp1QDk7rL/izjKZL7Xug0zGrPeHsppKVZzOiTqpNxUfiirWJ3fmny
        SycLLa1X7N17/l9cvYmZi2mXXpNynPCU3NeMITFfNi3/kWF+5khkZuJGq5bkA+wL4mLWX1l4
        1lGJzf1irtQNvupF3jY969/q7b/VIls/+RaD4nyd/8EXHsU/qrNezdO0mm3DUcMWjWy7FUdv
        bLorW+a+dINW4uE9ebYGh2S/qHjLKpwKb9t45k7+LqNtEqafLj9c6LykhkOhriVns1dOmv1h
        Nvb8Dj1/s7Os8xhnOYhGbHqrwPlZ7BnLmSnTm2bOkj6VKr/c3u2T+QpDY+fC8F9Hjzo1937S
        2+x1oHi17fRqfo94Pr1p92YqsRRnJBpqMRcVJwIA9C0PFMsCAAA=
X-CMS-MailID: 20210208112816epcas2p43777bb9740f7307e38cb534f01099126
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210208112816epcas2p43777bb9740f7307e38cb534f01099126
References: <taehyun cho>
        <CGME20210208112816epcas2p43777bb9740f7307e38cb534f01099126@epcas2p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'ARCH_EXYNOS' is no more used. 'USB_DWC3_EXYNOS' is glue layer
which can be used with Synopsys DWC3 controller on Exynos SoCs.
'USB_DWC3_EXYNOS' can be used from Exynos5 to Exynos9.

Change-Id: I965b415252a4c64ec5527488be7392113f7ceeb3
Signed-off-by: taehyun cho <taehyun.cho@samsung.com>
---
 drivers/usb/dwc3/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index 2133acf8ee69..dc2f92ac8ef6 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -67,10 +67,10 @@ config USB_DWC3_OMAP
 
 config USB_DWC3_EXYNOS
 	tristate "Samsung Exynos Platform"
-	depends on (ARCH_EXYNOS || COMPILE_TEST) && OF
+	depends on (USB_DWC3 || COMPILE_TEST) && OF
 	default USB_DWC3
 	help
-	  Recent Exynos5 SoCs ship with one DesignWare Core USB3 IP inside,
+	  Exynos SoCs chip with one DesignWare Core USB3 IP inside,
 	  say 'Y' or 'M' if you have one such device.
 
 config USB_DWC3_PCI
-- 
2.26.0

