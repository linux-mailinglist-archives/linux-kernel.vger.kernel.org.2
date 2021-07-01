Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8C33B92CC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 16:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbhGAOHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 10:07:32 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:28623 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbhGAOHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 10:07:31 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210701140459epoutp040a2f6df73da152304c606cb19ad9d405~Nr8Swiv2J1381413814epoutp040
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 14:04:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210701140459epoutp040a2f6df73da152304c606cb19ad9d405~Nr8Swiv2J1381413814epoutp040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1625148299;
        bh=IsGSNyDRzmkA11rDtqCy+WlE/3QGZJsC0ekGLoVhPXg=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=e/+C46DU+pdtmd1G0D2HNQFX8QOk6mmV7cw4icdumfU8PNNmAhP8Isjl6HyECo7Eh
         LUFXp1Oopr5R88dhdBU0bDOYeTVFLESC0Nt6t7ZndgXzvS+FcOJuh47j4wf0leOu7I
         BI3OM/xtRWv+7FlqSS6x7GGhcMlqwKV24RbSDw9o=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210701140459epcas1p159feafa442638f24e649cdc352053bcb~Nr8SUcb8G3054330543epcas1p1o;
        Thu,  1 Jul 2021 14:04:59 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.159]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4GG0Mt2RXCz4x9Pt; Thu,  1 Jul
        2021 14:04:58 +0000 (GMT)
X-AuditID: b6c32a36-2b3ff7000000254f-c3-60ddcb8a410f
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2F.84.09551.A8BCDD06; Thu,  1 Jul 2021 23:04:58 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] of: fdt: remove unnecessary codes
Reply-To: ohoono.kwon@samsung.com
Sender: =?UTF-8?B?6raM7Jik7ZuI?= <ohoono.kwon@samsung.com>
From:   =?UTF-8?B?6raM7Jik7ZuI?= <ohoono.kwon@samsung.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>
CC:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        =?UTF-8?B?6raM7Jik7ZuI?= <ohoono.kwon@samsung.com>,
        "ohkwon1043@gmail.com" <ohkwon1043@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20210701140457epcms1p2cc43a7c62150f012619feab913f017af@epcms1p2>
Date:   Thu, 01 Jul 2021 23:04:57 +0900
X-CMS-MailID: 20210701140457epcms1p2cc43a7c62150f012619feab913f017af
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFKsWRmVeSWpSXmKPExsWy7bCmnm7X6bsJBv1NnBbzj5xjtZj55j+b
        xf2vRxktLu+aw2axd7+vxa6fK5gtWvceYXdg99g56y67x6ZVnWwed67tYfPo27KK0ePzJrkA
        1qgcm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygK5QU
        yhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BYYGBXrFibnFpXnpesn5uVaGBgZGpkCV
        CTkZ3xedYS/YwlExYetPpgbGBWxdjJwcEgImEo235jJ1MXJxCAnsYJQ4/3EPaxcjBwevgKDE
        3x3CIDXCAkYSf/8uYQQJCwkoSmw77QYRtpKY1vePCcRmE7CQeL72JyuILSKQJLFj5RRGkJHM
        AlOYJDY3HmOF2MUrMaP9KQuELS2xfflWRghbVOLm6rfsMPb7Y/Oh4iISrffOMkPYghIPfu6G
        iktK3Gy7ywKyQEKgn1Hi/roWKGcCo8SSJ5OgPjOXeLahhR3iGV+Jg3/0QMIsAqoSU161Qw1y
        kbh98yzYB8wC8hLb385hBilnFtCUWL9LH6JEUWLn77mMECV8Eu++9sD9smPeEyaQcgmgkct+
        e8C81Tf9MtQBHhLfG9aCvSUkECix6vFuxgmM8rMQgTsLyd5ZCHsXMDKvYhRLLSjOTU8tNiww
        Qo7PTYzgRKhltoNx0tsPeocYmTgYDzFKcDArifBOmH43QYg3JbGyKrUoP76oNCe1+BCjKdDH
        E5mlRJPzgak4ryTe0NTI2NjYwsTM3MzUWEmcdyfboQQhgfTEktTs1NSC1CKYPiYOTqkGJqng
        wuRP4fqG8bdlsy2+H330277jyux9Ya9OxHxhbRfbGPJ35VZV34orU65wx4XOZCl9GPd3JY/i
        vCPW2+zq9aben3l8a3149lnNRddLSyYeKP+j3ZQvWzen49UVGc03y+bGcnz89yZuUX7Hhqun
        /tm/XiTv13Wif7Xz+4YjfKqli19+m1n35t/zE9UPEs+EsFc4Ntttvppnv1k268m2fUUxQjmT
        z2jcets4K8k6k7f1fGrAt6CsWdWbJQqCDbh93ITf2bierZ689W1WxgzPu3nhvApe4qfuzTX7
        /yLor3WNf5uN2K3I4hXix055fzyU0C15OXvGiVOKV/gC34cui+WRMXr2jKk/307gklCNiBJL
        cUaioRZzUXEiAJEDq58NBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210701140328epcms1p85149318b6c18fa18b3c7c8e966c14db0
References: <CGME20210701140328epcms1p85149318b6c18fa18b3c7c8e966c14db0@epcms1p2>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While unflattening the device tree, we try to populate dt nodes and
properties into tree-shaped data structure.

In populate_properties function, pprev is initially set to
&np->properties, and then updated to &pp->next.

In both scenarios *pprev is NULL, since the memory area that we are
allocating from is initially zeroed.

I tested the code as below, and it showed that BUG was never called.

-       if (!dryrun)
+       if (!dryrun) {
+               if (*pprev)
+                       BUG();
                *pprev = NULL;
+       }

Let's remove unnecessary code.

Signed-off-by: Ohhoon Kwon <ohoono.kwon@samsung.com>
---
 drivers/of/fdt.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index ba17a80b8c79..5e71f5eb35b1 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -200,9 +200,6 @@ static void populate_properties(const void *blob,
 				 nodename, (char *)pp->value);
 		}
 	}
-
-	if (!dryrun)
-		*pprev = NULL;
 }
 
 static int populate_node(const void *blob,
-- 
2.17.1
