Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7BE31B6BE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 10:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhBOJvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 04:51:22 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:10448 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbhBOJui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 04:50:38 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210215094953epoutp02d6fcb85b39421793ab61ece14a0917dc~j4uunz-5T1517115171epoutp02C
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 09:49:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210215094953epoutp02d6fcb85b39421793ab61ece14a0917dc~j4uunz-5T1517115171epoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1613382593;
        bh=DuMVsjTdIq8Ninv/gh53/PXRPNYeEjpqeD/BhRip6hE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YvnBTqYNdwNoUw/8Eq+OcxIx4ndjPqnTDDy3R8rDeGISwlLj/YpfvEAzzZ/nHwSjp
         nHy8tqdzJvFtu8AAXt45iolCZzAPs1AhpOdAh0L9MZt33Xk4vpTaAMeqn4oAmSm+D4
         TIIva8wBw/qCY+wVFg2EH5pdiacKVTB/L8H9HjsM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210215094952epcas1p34646834d3a8b1b116d6f5e8b9f43a0da~j4uuJVJ6Z0273302733epcas1p3u;
        Mon, 15 Feb 2021 09:49:52 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.155]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4DfK8H58Mdz4x9Pv; Mon, 15 Feb
        2021 09:49:51 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        95.D3.63458.FB34A206; Mon, 15 Feb 2021 18:49:51 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210215094951epcas1p1dd89e994519ae901dcbc743d0a9ae669~j4usr75aY0975909759epcas1p18;
        Mon, 15 Feb 2021 09:49:51 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210215094951epsmtrp2e17085a89420eba6223ba25d2e43b701~j4usrOuME2912229122epsmtrp2O;
        Mon, 15 Feb 2021 09:49:51 +0000 (GMT)
X-AuditID: b6c32a36-6dfff7000000f7e2-dd-602a43bf749f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        80.2E.13470.FB34A206; Mon, 15 Feb 2021 18:49:51 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210215094950epsmtip26a80a7796ce475ca81465112b502ac20~j4use0BTj1775517755epsmtip2I;
        Mon, 15 Feb 2021 09:49:50 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     gregkh@linuxfoundation.org
Cc:     cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/3] extcon: Add stubs for extcon_register_notifier_all()
 functions
Date:   Mon, 15 Feb 2021 19:06:08 +0900
Message-Id: <20210215100610.19911-2-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210215100610.19911-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMKsWRmVeSWpSXmKPExsWy7bCmge5+Z60Eg0UHlC0m3rjCYnH9y3NW
        i+bF69kszp/fwG5xedccNovbjSvYHNg8Nq3qZPPYP3cNu0ffllWMHp83yQWwRGXbZKQmpqQW
        KaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gAtV1IoS8wpBQoFJBYX
        K+nb2RTll5akKmTkF5fYKqUWpOQUWBboFSfmFpfmpesl5+daGRoYGJkCFSZkZ5z58J25YCNv
        xfdFe5gaGL9wdTFyckgImEh8nrOEsYuRi0NIYAejxKHlk1hAEkICnxglbm7xhbC/MUqcmcsJ
        0/BrcxMTRMNeRokb509CdX9hlHi5r5kVpIpNQEti/4sbbCC2iICcxJPbf5hBipgF+hglTrw7
        wQiSEBYIlbj++Aw7iM0ioCrRuOgLmM0rYCXxeupXdoh18hKrNxxgBrE5Bawlds5rBdsmIbCP
        XeL84/tsEEUuEpPfvmSFsIUlXh3fAtUsJfH53V6ommqJlSePsEE0dzBKbNl/AarBWGL/0slA
        D3EAnacpsX6XPkRYUWLn77lghzIL8Em8+9rDClIiIcAr0dEmBFGiLHH5wV0mCFtSYnF7J9Qq
        D4meZZOhQQT08M69r1gnMMrNQtiwgJFxFaNYakFxbnpqsWGBEXKUbWIEpy4tsx2Mk95+0DvE
        yMTBeIhRgoNZSYT3qoRGghBvSmJlVWpRfnxRaU5q8SFGU2DoTWSWEk3OBybPvJJ4Q1MjY2Nj
        CxNDM1NDQyVx3kSDB/FCAumJJanZqakFqUUwfUwcnFINTDodzFFNX6MLK06xpd95G3/KfoW9
        UuGWVQfmXznevvL3oqIbetv3bjFqmRwWq8fOociq0nn06wRp575ToTrrt0ZG3bNYOC13+eK+
        XWWevZETJRO1V8kdV52cWcH+45rsVdOri91/WKU3lPTsla1Ji+Xc17X+3kLV21N95pvElW93
        c7TVjg1UMt8vOW3JsgNb3ynqiH1gXVibXR0f/XI3+/P9kalyp+6dtp9wc1u7y8MSAc7Qo6v/
        stx7+Htx18pXqzL3bnD+q/hzZaOI27mfZ5JuTzdwCl5y/hhvkwDrz12MMvq/pv74tGdepIhM
        BcNXzsN2m9fLrHK6scC7f5GAkjfn+dPfDM0vMEhfsJn7basSS3FGoqEWc1FxIgAdAJhR5gMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphluLIzCtJLcpLzFFi42LZdlhJXne/s1aCQcNrVouJN66wWFz/8pzV
        onnxejaL8+c3sFtc3jWHzeJ24wo2BzaPTas62Tz2z13D7tG3ZRWjx+dNcgEsUVw2Kak5mWWp
        Rfp2CVwZZz58Zy7YyFvxfdEepgbGL1xdjJwcEgImEr82NzF1MXJxCAnsZpSYvW0NG0RCUmLa
        xaPMXYwcQLawxOHDxSBhIYFPjBITeqNAbDYBLYn9L26AlYsIyEk8uf2HGWQOs8AURoldBxrY
        QRLCAsESe48tYQaxWQRUJRoXfQGL8wpYSbye+pUdYpe8xOoNB8BqOAWsJXbOa2WEWGYlsWz6
        cqYJjHwLGBlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIEB5iW5g7G7as+6B1iZOJg
        PMQowcGsJMJ7VUIjQYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZ
        Jg5OqQammqIenn93JVpqzZd+8lv0tJZnN2eh8/SKoi3O/lzsv7gmTOzYvaCrfOnChcfcxTbf
        lqy+E7XZLMQ8MVnDW2X6BJHZ6zYFTEu7eZ+9TDVqrXSZmHpeeuSOu0XLd7YuvllZUV/yKtLO
        jkfd5vqZY537Ohrqw86c1jrDVTIj4MIj2R25nosEN/sGxD37W8DIsvZbQYCoztVvNgx+fodD
        bTZP0a/JMjNN3XnC6t1V1XWTxZl4f2/v+/AvIOVdJDP79tux4l2BH6epcxvrSwRFJbHPaTv4
        4OqzNaHbVKx1r518kHvAtG/dzcgCi4lGsZvvaT8olNW+PlFMrnrSsmciiYfDzaqsKtkrEjac
        YvDff1+JpTgj0VCLuag4EQBsD+fynwIAAA==
X-CMS-MailID: 20210215094951epcas1p1dd89e994519ae901dcbc743d0a9ae669
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210215094951epcas1p1dd89e994519ae901dcbc743d0a9ae669
References: <20210215100610.19911-1-cw00.choi@samsung.com>
        <CGME20210215094951epcas1p1dd89e994519ae901dcbc743d0a9ae669@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

Add stubs for extcon_register_notifier_all() function for !CONFIG_EXTCON
case.  This is useful for compile testing and for drivers which use
EXTCON but do not require it (therefore do not depend on CONFIG_EXTCON).

Fixes: 815429b39d94 ("extcon: Add new extcon_register_notifier_all() to monitor all external connectors")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 include/linux/extcon.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/extcon.h b/include/linux/extcon.h
index fd183fb9c20f..0c19010da77f 100644
--- a/include/linux/extcon.h
+++ b/include/linux/extcon.h
@@ -271,6 +271,29 @@ static inline  void devm_extcon_unregister_notifier(struct device *dev,
 				struct extcon_dev *edev, unsigned int id,
 				struct notifier_block *nb) { }
 
+static inline int extcon_register_notifier_all(struct extcon_dev *edev,
+					       struct notifier_block *nb)
+{
+	return 0;
+}
+
+static inline int extcon_unregister_notifier_all(struct extcon_dev *edev,
+						 struct notifier_block *nb)
+{
+	return 0;
+}
+
+static inline int devm_extcon_register_notifier_all(struct device *dev,
+						    struct extcon_dev *edev,
+						    struct notifier_block *nb)
+{
+	return 0;
+}
+
+static inline void devm_extcon_unregister_notifier_all(struct device *dev,
+						       struct extcon_dev *edev,
+						       struct notifier_block *nb) { }
+
 static inline struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name)
 {
 	return ERR_PTR(-ENODEV);
-- 
2.17.1

