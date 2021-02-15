Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F044331B422
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 03:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhBOCvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 21:51:49 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:62329 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhBOCvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 21:51:46 -0500
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210215025103epoutp040be9ba1614b759ca00fb4c8797a79727~jzBCi5QFv2556725567epoutp04p
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 02:51:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210215025103epoutp040be9ba1614b759ca00fb4c8797a79727~jzBCi5QFv2556725567epoutp04p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1613357463;
        bh=+905rnpExaSEIB0z9tacFt0nF/ZDpIdUxOWkCA8hliA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=vNYZ2GV7mAnNYqJ3SFHNbWnblE2TC7R9qXPyxiCC5kgKgJlrkrfqNtEPnAUnKNzWJ
         pPKeE3MYgc4KDtRlDlkPV1FO4zstLSuGpOWn6JSwliV2mhM/vwXEPMDL5tpuD8QnJN
         KEV9iQQLu7frBB0NbvHJnmvdRMSCs3slMnLz+mCU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20210215025101epcas2p1cb16f5a1a72873bd258d677321c4364e~jzBAYm1Q81698816988epcas2p1L;
        Mon, 15 Feb 2021 02:51:01 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.188]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Df7ry4WXTz4x9Q0; Mon, 15 Feb
        2021 02:50:58 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        1B.10.52511.291E9206; Mon, 15 Feb 2021 11:50:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20210215025057epcas2p205c3c283a8806d818d71f90c872c6e51~jzA9jDafX1884918849epcas2p2g;
        Mon, 15 Feb 2021 02:50:57 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210215025057epsmtrp2c8cfd5011ae64f72d0c7f7be0dcf27b5~jzA9flRse2781327813epsmtrp2B;
        Mon, 15 Feb 2021 02:50:57 +0000 (GMT)
X-AuditID: b6c32a48-50fff7000000cd1f-d5-6029e19211d3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        16.2F.08745.191E9206; Mon, 15 Feb 2021 11:50:57 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210215025057epsmtip24ca856563703f651421535082eb5d723~jzA9PCBrG1014210142epsmtip2k;
        Mon, 15 Feb 2021 02:50:57 +0000 (GMT)
From:   Daehwan Jung <dh10.jung@samsung.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daehwan Jung <dh10.jung@samsung.com>
Subject: usb: dwc3: gadget: Change runtime pm function for DWC3 runtime
 suspend
Date:   Mon, 15 Feb 2021 11:38:58 +0900
Message-Id: <1613356739-91734-1-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPKsWRmVeSWpSXmKPExsWy7bCmme6kh5oJBqceKlkca3vCbnFnwTQm
        i+bF69ksLu+aw2axaFkrswOrx6ZVnWwe++euYffo27KK0ePzJrkAlqgcm4zUxJTUIoXUvOT8
        lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygvUoKZYk5pUChgMTiYiV9O5ui
        /NKSVIWM/OISW6XUgpScAkPDAr3ixNzi0rx0veT8XCtDAwMjU6DKhJyMyzc3shQ8Ya340rmJ
        rYHxJUsXIyeHhICJxO7l81i7GLk4hAR2MEr0L33PAuF8YpT43jYNyvnMKDGtcQYbTMuPLasZ
        IRK7GCXazu1ih3B+MErcP7mKuYuRg4NNQEvi+0KwIhGBiYwSrU+OAI1i52AW0JD4EgkyR1gg
        UGLdmy52EJtFQFVi6pGpTCA2r4CrxI2HJ5kgdslJ3DzXyQwyRkJgOrvEv555UAkXiX2fZzFD
        2MISr45vYYewpSQ+v9vLBnKChEC5xKL5dhC9HYwSaz6dZYSoMZaY9aydEaSGWUBTYv0ufYhy
        ZYkjt8ChwizAJ9Fx+C87RJhXoqNNCKJRWWL65QmsELakxMHX56AO8JA4t+0dWFxIIFbizYo9
        bBMYZWchzF/AyLiKUSy1oDg3PbXYqMAEOYo2MYJTkpbHDsbZbz/oHWJk4mA8xCjBwawkwntV
        QiNBiDclsbIqtSg/vqg0J7X4EKMpMLgmMkuJJucDk2JeSbyhqZGZmYGlqYWpmZGFkjhvkcGD
        eCGB9MSS1OzU1ILUIpg+Jg5OqQYmhXpGu+UHG7J1eeUtwj6vsNm+sFDo4N1MlXxd4aZ9z49a
        euSVnlrNc+CTxNzvLEzVFfbHwuMqVu81U77yQewo4+XpVyK2ru9KPdfx1eByhfYL978GRRcY
        df+mPNeL41WtLbrncY1devu+jq6yw08SrrafXDT7WfWj+3ELFnJ5fG7l5511bc7FKCehKxef
        CJ3//NVvI7OWteKCuHWbn1pOjOD/xiuYM+1C9MQfB9byzhTRmLNlDWuQ+vUzXAk3XleHcWts
        eDJl26/bQWJR9wputqmtutV77ngPb1pQ+KlH6dqlV6wuTzISMYv4k2zYkTSLr3p/eKlpMfun
        x5VXarKU8jdtzai9prp8X4PnosrDSizFGYmGWsxFxYkAV0uaMNIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHJMWRmVeSWpSXmKPExsWy7bCSvO7Eh5oJBud26Vsca3vCbnFnwTQm
        i+bF69ksLu+aw2axaFkrswOrx6ZVnWwe++euYffo27KK0ePzJrkAligum5TUnMyy1CJ9uwSu
        jMs3N7IUPGGt+NK5ia2B8SVLFyMnh4SAicSPLasZuxi5OIQEdjBK3OrqZ4ZISEosnXuDHcIW
        lrjfcoQVougbo8SR6fuZuhg5ONgEtCS+LwRrFhGYzCjR9G830FR2DmYBDYkvkSCtwgL+EgdP
        dILtYhFQlZh6ZCoTiM0r4Cpx4+FJJojxchI3z3UyT2DkWcDIsIpRMrWgODc9t9iwwCgvtVyv
        ODG3uDQvXS85P3cTIzhItLR2MO5Z9UHvECMTB+MhRgkOZiUR3qsSGglCvCmJlVWpRfnxRaU5
        qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0tSC2CyTJxcEo1MMmFOxzSL7zJ1bJs4Vq+9y+MXyx+
        8/bn88QorhP7IicdO/ti5uHGKTay2/Ns9n0vZFxqsX6SaPjnLC4+6wQ5pTMPrHef69minyDa
        z9K3njWxeKfCzQ0rt6zOPSZlEmSoZH686f1/wRs8a0RsXSbeUDmyOPvX72tROop1/Uma1o4W
        Zx9qdFiqOmgeC3KLkwnYfCzdUs1NZ9nGQLmN/HYRgRJP8hlZpl2NiVlQZevxJeAbZ9fG1Gem
        cXIrc/0UuC+bz/oe/KB/9s5dD7+KStfLPi6YOyNMklmpcPcfDtu63zNTNshf3FLa4bNN6r9I
        j+Ylvl1ab+bKfirqefO2/IG1qtisvlbD2iXt+2dO+9qlqMRSnJFoqMVcVJwIAGjkVPyBAgAA
X-CMS-MailID: 20210215025057epcas2p205c3c283a8806d818d71f90c872c6e51
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210215025057epcas2p205c3c283a8806d818d71f90c872c6e51
References: <CGME20210215025057epcas2p205c3c283a8806d818d71f90c872c6e51@epcas2p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems pm_runtime_put calls runtime_idle callback not runtime_suspend callback.
It's better to use pm_runtime_put_sync_suspend to allow DWC3 runtime suspend.

Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
---
 drivers/usb/dwc3/gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index aebcf8e..4a4b93b 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2229,7 +2229,7 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 	 */
 	ret = pm_runtime_get_sync(dwc->dev);
 	if (!ret || ret < 0) {
-		pm_runtime_put(dwc->dev);
+		pm_runtime_put_sync_suspend(dwc->dev);
 		return 0;
 	}
 
-- 
2.7.4

