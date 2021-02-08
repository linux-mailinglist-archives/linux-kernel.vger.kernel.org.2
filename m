Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546923131C9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 13:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbhBHMGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 07:06:25 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:53148 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbhBHLpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 06:45:31 -0500
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210208114449epoutp03e884e25af4f0abaa688ce31a42a3e4dd~hwyFkZ4fd2154421544epoutp030
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 11:44:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210208114449epoutp03e884e25af4f0abaa688ce31a42a3e4dd~hwyFkZ4fd2154421544epoutp030
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1612784689;
        bh=gKCzOgw3cRFmI6ZSWwIDn+IL6dVAgybq9JxhXNQqdaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DtnMbX/e3MIQTBpEXTlp/bQwGfK9/aB5aEDum8cGK2dbMpzRdlu3BDBBUw4HJMKJR
         f9V92ZawJCD65KbwH5bhFToGgL97LRWwnrufJYr4L4/FrMjMEKVKsyIe50fT45vQkC
         cZvVdaXutv9eU15Kqk/tVIQNfahotBMIkQuF2YGg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20210208114448epcas2p462bd94ca613d5a725c28152380fbdc88~hwyEyj2ft1992519925epcas2p4T;
        Mon,  8 Feb 2021 11:44:48 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.40.181]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4DZ4275Mkrz4x9Q1; Mon,  8 Feb
        2021 11:44:47 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        39.EB.56312.F2421206; Mon,  8 Feb 2021 20:44:47 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20210208114447epcas2p3507f22a555355ac7710c5ca220853e0e~hwyDQRxJr1121811218epcas2p3Q;
        Mon,  8 Feb 2021 11:44:47 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210208114447epsmtrp1036bc5cbac185b737da1e1e27a73c64d~hwyDM0CIj2242522425epsmtrp1g;
        Mon,  8 Feb 2021 11:44:47 +0000 (GMT)
X-AuditID: b6c32a46-1efff7000000dbf8-6e-6021242f6b6a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        95.73.08745.F2421206; Mon,  8 Feb 2021 20:44:47 +0900 (KST)
Received: from rack03.dsn.sec.samsung.com (unknown [12.36.155.109]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210208114447epsmtip160ff7c29d8e62fc81bc50503658d2451~hwyDAASea1474014740epsmtip1O;
        Mon,  8 Feb 2021 11:44:46 +0000 (GMT)
From:   taehyun cho <taehyun.cho@samsung.com>
To:     balbi@kernel.org
Cc:     taehyun.cho@samsung.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc3: make USB_DWC3_EXYNOS independent
Date:   Mon,  8 Feb 2021 20:45:38 +0900
Message-Id: <20210208114538.134766-1-taehyun.cho@samsung.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <taehyun cho>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLKsWRmVeSWpSXmKPExsWy7bCmua6+imKCwf9t6hbH2p6wWzQvXs9m
        cXnXHDaLRctamS0mHRR1YPXYtKqTzWP/3DXsHn1bVjF6fN4kF8ASlWOTkZqYklqkkJqXnJ+S
        mZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA7RWSaEsMacUKBSQWFyspG9nU5Rf
        WpKqkJFfXGKrlFqQklNgaFigV5yYW1yal66XnJ9rZWhgYGQKVJmQk3FvySPGgoPsFTc/72Jr
        YOxn62Lk5JAQMJE4/vQKcxcjF4eQwA5GiR3XO1ggnE+MEtv+9bBDOJ8ZJa4e+8kK0/L20wMw
        W0hgF6PEon1uEEU/GCWeXW9iBEmwCWhL7G++CVYkIiAi0fZ8BhNIEbNAJ6PElcePmUASwgI2
        Eu8/LwNrYBFQlTh48zaYzStgKzGlfRsTxDZ5iUUNv8FsTgEpic/H9rJA1AhKnJz5BMxmBqpp
        3job7AkJgXPsEv9XrIM61UXi0rIuFghbWOLV8S3sELaUxMv+NnaIhnZGiV8n1rBCOFMYJT6s
        O8UIUWUsMetZO5DNAbRCU2L9Ln0QU0JAWeLILajFfBIdh/+yQ4R5JTrahCAaVSXaL96HBrC0
        xKXNN9kgSjwkdnXrQwIuV+LsxktMExgVZiH5ZhaSb2YhrF3AyLyKUSy1oDg3PbXYqMAIOYY3
        MYLToZbbDsYpbz/oHWJk4mA8xCjBwawkwhvYKZcgxJuSWFmVWpQfX1Sak1p8iNEUGNYTmaVE
        k/OBCTmvJN7Q1MjMzMDS1MLUzMhCSZy32OBBvJBAemJJanZqakFqEUwfEwenVAOTg5btjysN
        a2rXLm/T9RdStXGYvn31/QuXes+5zRNl8Vz5ZNeTBRs4DriEb92kVVNs5N2b08G6cuK7ukRD
        h3vv/778vnuuUMjvTYGq03ZH/EvbGyF66pGK+JqYzz2br/yoens3Su7M0ds3yzZnGr/4uH7h
        AZ4L275J7E28vOfIiWl3vhkerSi3mXH72qTq1PwfzhM/n75910JoxyXxuwejvpQuUed8evRO
        Tq+SXOqmPZ7a1xRrONmO3TymffqbJNuGogXmP6SPy+1nvXFQlP/91qOMBjV6HCUnS1xfK8+/
        9Eo8Sm5uygGxig4dhUPZ8nJZxzx6JJ83ZK38drtd+m20Q7jW03w3oY8XTuYrL2fm5VJiKc5I
        NNRiLipOBAAoPY7rEAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBLMWRmVeSWpSXmKPExsWy7bCSnK6+imKCwamH7BbH2p6wWzQvXs9m
        cXnXHDaLRctamS0mHRR1YPXYtKqTzWP/3DXsHn1bVjF6fN4kF8ASxWWTkpqTWZZapG+XwJVx
        b8kjxoKD7BU3P+9ia2DsZ+ti5OSQEDCRePvpAWsXIxeHkMAORolZ556wQySkJU49XsAMYQtL
        3G85AlX0jVFi+6F3TCAJNgFtif3NN1lBbBEBEYm25zOYQIqYBboZJfqeHgUrEhawkXj/eRkj
        iM0ioCpx8OZtMJtXwFZiSvs2JogN8hKLGn6D2ZwCUhKfj+1lAbGFBCQlnt7Ywg5RLyhxcuYT
        sDgzUH3z1tnMExgFZiFJzUKSWsDItIpRMrWgODc9t9iwwCgvtVyvODG3uDQvXS85P3cTIzhw
        tbR2MO5Z9UHvECMTB+MhRgkOZiUR3sBOuQQh3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYL
        CaQnlqRmp6YWpBbBZJk4OKUamFpzQwWDT6Vam6abC/TMfHXZ96/p5ZydAq6qKQxKv887CYjw
        7r37W3TDqROW/EbNzyxmTnnAwb9MWlJO6JCc7PLIHEX9EzVTVkxZqbKsgH+2XdJO7tYSnvkL
        iyztDOY+7AieeVqp30jy7FkG3cbrn27HrJmdsUcrdeFDa+GZfu9mJ2tEfYs4tn/9saLOs/rr
        /DdrqW9Uiy3442v2SpJv09KT3vu3Jn9Vs5Ccn3mR02LHm8OaC6bW/PT/ve3kgr2PZfNiuK5J
        XYtTsz2vzhVkmjJBrvzvpIYZv2yMbT4tLXb68DXRj3Mr58R9k2d+Uq2NXfV1dlDRmcyny1x8
        Wh2UWs30OlawCW2Ncdib61o5SYmlOCPRUIu5qDgRABS1HRXLAgAA
X-CMS-MailID: 20210208114447epcas2p3507f22a555355ac7710c5ca220853e0e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210208114447epcas2p3507f22a555355ac7710c5ca220853e0e
References: <taehyun cho>
        <CGME20210208114447epcas2p3507f22a555355ac7710c5ca220853e0e@epcas2p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'ARCH_EXYNOS' is no more used. 'USB_DWC3_EXYNOS' is glue layer
which can be used with Synopsys DWC3 controller on Exynos SoCs.
'USB_DWC3_EXYNOS' can be used from Exynos5 to Exynos9.

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

