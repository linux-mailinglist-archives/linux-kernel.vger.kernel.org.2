Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04DB833AC6A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 08:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhCOHnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 03:43:01 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:54630 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhCOHm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 03:42:29 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210315074227epoutp035d90d8135753976c0ebed07862cb86de~sdDdhv5Ns0262602626epoutp034
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:42:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210315074227epoutp035d90d8135753976c0ebed07862cb86de~sdDdhv5Ns0262602626epoutp034
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1615794147;
        bh=rsNQQs3MRwg3UChH7DRBIUYI+oXh+lnseZp0hX9vEUs=;
        h=From:To:Cc:Subject:Date:References:From;
        b=HbzuodPOWKgqNKjXPEpDJQKuEQPenvzP57UCfrG4SGnfWM9sVWvxSiqY+tvKA7a/o
         ci+a/i+Y5KUvlxEHkDbY/YE+BF2BsKky2dj3U077CHHDk56rESFw0ojLTqTCvRBEDu
         TTFVZziZKR6DRpS3uXuzKvCXOubIEUVWnRZXwhcE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20210315074227epcas2p1b5cff42b7a5b09f286274a059926ec93~sdDdJnVVb1372513725epcas2p1y;
        Mon, 15 Mar 2021 07:42:27 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.40.182]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4DzT0J5Lzvz4x9Q6; Mon, 15 Mar
        2021 07:42:24 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        C3.A0.05262.0EF0F406; Mon, 15 Mar 2021 16:42:24 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20210315074223epcas2p11ddf190ec730f8629c1310117135f813~sdDaFA9A61372513725epcas2p1o;
        Mon, 15 Mar 2021 07:42:23 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210315074223epsmtrp14ba13fc601bf1ab78aa23acd243a3a42~sdDaETebZ1201312013epsmtrp1l;
        Mon, 15 Mar 2021 07:42:23 +0000 (GMT)
X-AuditID: b6c32a47-b81ff7000000148e-6f-604f0fe060f6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        EE.B1.08745.FDF0F406; Mon, 15 Mar 2021 16:42:23 +0900 (KST)
Received: from rack03.dsn.sec.samsung.com (unknown [12.36.155.109]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210315074223epsmtip2022c10f8254c1bc16ca3c5c6cb32bf47~sdDZ4QgO90648506485epsmtip2h;
        Mon, 15 Mar 2021 07:42:23 +0000 (GMT)
From:   taehyun cho <taehyun.cho@samsung.com>
To:     balbi@kernel.org
Cc:     taehyun.cho@samsung.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc3: remove 'pm_runtime_set_active' in resume
 callback
Date:   Mon, 15 Mar 2021 16:43:17 +0900
Message-Id: <20210315074317.7736-1-taehyun.cho@samsung.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIKsWRmVeSWpSXmKPExsWy7bCmqe4Dfv8Eg/Mn+S2OtT1ht2hevJ7N
        4vKuOWwWi5a1MltMOijqwOqxaVUnm8f+uWvYPfq2rGL0+LxJLoAlKscmIzUxJbVIITUvOT8l
        My/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB2itkkJZYk4pUCggsbhYSd/Opii/
        tCRVISO/uMRWKbUgJafA0LBArzgxt7g0L10vOT/XytDAwMgUqDIhJ2NByzS2gv8cFVdX3WNv
        YLzA3sXIySEhYCKx7ORJ5i5GLg4hgR2MEj1rFrFDOJ8YJY58n8EE4XxmlOib2wuU4QBr2fqy
        HiK+i1Gi7fRkqPYfjBJvJ01nBpnLJqAtsb/5JiuILSIgItH2HGISs0Ano8SVx4+ZQBLCAv4S
        u09fYAGxWQRUJW7PbwGL8wpYSzT9OMkMcaC8xKKG31BxQYmTM5+A1TMDxZu3zgbbLCGwi11i
        x7LXUA0uEiendrBC2MISr45vgfpUSuJlfxs7REM7o8SvE2tYIZwpjBIf1p1ihKgylpj1rJ0R
        5FFmAU2J9bv0IX5WljhyC2oxn0TH4b/QoOCV6GgTgmhUlWi/eJ8NwpaWuLT5JpTtIfHt8wpm
        kHIhgViJZc8yJjDKz0LyzSwk38xCWLuAkXkVo1hqQXFuemqxUYExcqxuYgSnPS33HYwz3n7Q
        O8TIxMF4iFGCg1lJhPezjm+CEG9KYmVValF+fFFpTmrxIUZTYPhOZJYSTc4HJt68knhDUyMz
        MwNLUwtTMyMLJXHeYoMH8UIC6YklqdmpqQWpRTB9TBycUg1MId7HquYwsjbYRlxpjLrAzrJR
        aq5B75JjZgXiL+6Gc6tqsUR7uu3+90/x/vqsh6nMXhwbp8zawf6RI/mSdsHf8xIT92Qvee9Y
        lHXf+5oR73HXC/bsvMEOm+bW/hVeIhLj1X4kXKr5j+ohzZwkzs1brGtdbrjOPHzyo5/vsd6C
        Jy0zJPlFb2d+bSyxaTJT/ZcjqXp0rhaX9YmfFkd+xdrtqKsW23rBeuu527I2qj8sb547++SL
        pu/DJuYLwZ9uyM7c0PMnQ3aiXsPiVrHbf93/SNbYTqueZdSfdCrpLf8Kl5lLQk1XXUvp8X8e
        bPSq6JKi/xsrpe/X/uSf47aPFHF5WHBO2nj1Fq3Pxa5WVkxKLMUZiYZazEXFiQDet2vBBAQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPLMWRmVeSWpSXmKPExsWy7bCSvO59fv8Eg1MrdS2OtT1ht2hevJ7N
        4vKuOWwWi5a1MltMOijqwOqxaVUnm8f+uWvYPfq2rGL0+LxJLoAlissmJTUnsyy1SN8ugStj
        Qcs0toL/HBVXV91jb2C8wN7FyMEhIWAisfVlfRcjF4eQwA5GiRNr3zF2MXICxaUlTj1ewAxh
        C0vcbznCClH0jVFi+cKnbCAJNgFtif3NN1lBbBEBEYm25zOYQIqYBboZJfqeHmUCSQgL+Eoc
        +bAJrIhFQFXi9vwWsDivgLVE04+TUBvkJRY1/IaKC0qcnPmEBcRmBoo3b53NPIGRbxaS1Cwk
        qQWMTKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYLDUEtrB+OeVR/0DjEycTAeYpTg
        YFYS4f2s45sgxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dU
        A1M837On12xeZ12aP/0o+/ycks+5nZP59Lff0hOQFAp8oN9z+1ie955PsYcPcawRu2I468qs
        u12eeUvYun8mXjbZzuwXEbhv5SlDG+/1ThPDrp7KzONqqD+8sXxibUi12/FPG/rXtvKpHs06
        ffnZ9RUXciLTzmc3r9T+WC6qN89VJvVx5rLjsVL31JLXMK+T+nqqNDT22VZN1VVLRf+fyC1N
        n5+fOMWiJ1T0QEMu89s4+4X6H28p9AQemXO2JNP4q6RHtVrYVJP784qyD2xY99349WLNkuof
        H5Y/7TbXuMvj2n3w2lzNdSuzohtv8t1Z8Ig3It1oz9OUst6amW5eF9YeD7j08Hi34jopxRl1
        v2cqsRRnJBpqMRcVJwIAOnbk37ICAAA=
X-CMS-MailID: 20210315074223epcas2p11ddf190ec730f8629c1310117135f813
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210315074223epcas2p11ddf190ec730f8629c1310117135f813
References: <CGME20210315074223epcas2p11ddf190ec730f8629c1310117135f813@epcas2p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'pm_runtime_set_active' sets a flag to describe rumtime status.
This flag is automatically set in pm_runtime_get_sync/put_sync API.
'pm_runtime_set_active' checks the runtime status of parent device.
As a result, the below error message is printed.
dwc3 11110000.dwc3: runtime PM trying to activate child device
11110000.dwc3 but parent (11110000.usb) is not active.

Signed-off-by: taehyun cho <taehyun.cho@samsung.com>
---
 drivers/usb/dwc3/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 94fdbe502ce9..e7c0e390f885 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1553,7 +1553,6 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	spin_lock_init(&dwc->lock);
 
-	pm_runtime_set_active(dev);
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_set_autosuspend_delay(dev, DWC3_DEFAULT_AUTOSUSPEND_DELAY);
 	pm_runtime_enable(dev);
@@ -1920,7 +1919,6 @@ static int dwc3_resume(struct device *dev)
 		return ret;
 
 	pm_runtime_disable(dev);
-	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
 
 	return 0;
-- 
2.26.0

