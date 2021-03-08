Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85D2330978
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 09:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhCHIgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 03:36:12 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:21180 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbhCHIfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 03:35:43 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20210308083542euoutp01d51e39c2892e2f041475f0ec88d1ac8e~qUQ81BEmW1630016300euoutp01p
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 08:35:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20210308083542euoutp01d51e39c2892e2f041475f0ec88d1ac8e~qUQ81BEmW1630016300euoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1615192542;
        bh=1odrDJQ0gKxVXkh98uvHyrhkQv488xo+DiMLCYTYL8U=;
        h=From:To:Cc:Subject:Date:References:From;
        b=nusga9mcFHx18mxeDfSu9hB92byPY5tnFS0x4U5h/KSPaTU6+NYAZTznE2n1n+3SH
         d+3xKWeOa/UzUa8NM0eR5GgJezeE5FDH2+UPg6pxD/MSCE3VBJEG1bPys51YT6ts8l
         +5/WC/gzrWtspZxVfgX/EnqAlGwjwkWB6X6GtG6E=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210308083541eucas1p1fbc7596d0a08ac8aaee00d3c7d477055~qUQ8pkTbT2370723707eucas1p10;
        Mon,  8 Mar 2021 08:35:41 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F5.EB.09452.DD1E5406; Mon,  8
        Mar 2021 08:35:41 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210308083541eucas1p1a8f772f12006ee6082b900c1a82aa298~qUQ8XDNuz0362503625eucas1p16;
        Mon,  8 Mar 2021 08:35:41 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210308083541eusmtrp21460c9628dfd7957dfdea362caf11f82~qUQ8WZRFY2311623116eusmtrp2T;
        Mon,  8 Mar 2021 08:35:41 +0000 (GMT)
X-AuditID: cbfec7f2-a9fff700000024ec-5f-6045e1ddf7dd
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 15.24.08705.DD1E5406; Mon,  8
        Mar 2021 08:35:41 +0000 (GMT)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20210308083541eusmtip128db5ff869e1cd9f6676b19bc2151280~qUQ8J1UCk2919429194eusmtip1O;
        Mon,  8 Mar 2021 08:35:41 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH] rtc: ds1307: set uie_unsupported if no interrupt is
 available
Date:   Mon,  8 Mar 2021 09:35:37 +0100
Message-Id: <20210305174411.9657-1-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsWy7djPc7p3H7omGNw5YGpx89AKRovLu+aw
        OTB59G1ZxejxeZNcAFMUl01Kak5mWWqRvl0CV8bB338ZCzZzV/Q+7WdsYFzA2cXIwSEhYCLx
        baFoFyMnh5DACkaJA+sruhi5gOwvjBI3v+9kgnA+M0rMWLeYDaQKpGHDuW/sEInljBKT+1+x
        QrQ/Z5RoPqUOYrMJOEr0Lz0BFhcRUJDY3PsMzGYWsJeYOOs/2CBhgQCJWYuvgMVZBFQlds58
        xARyEa+AncTSA5YQu+Ql2pdvByvnFRCUODnzCQuIzS+gJbGm6ToLxEh5ieats5lB7pEQaOWQ
        2LC8kRWi2UViUucLRghbWOLV8S3sELaMxP+d85kgvq+XmDzJDKK3h1Fi25wfLBA11hJ3zv1i
        A6lhFtCUWL9LHyLsKHH7/lJmiFY+iRtvBSFO4JOYtG06VJhXoqNNCKJaRWJd/x6ogVISva9W
        QB3jIfHk73yWCYyKs5A8NgvJM7MQ9i5gZF7FKJ5aWpybnlpsmJdarlecmFtcmpeul5yfu4kR
        mBJO/zv+aQfj3Fcf9Q4xMnEwHmKU4GBWEuHt7XFOEOJNSaysSi3Kjy8qzUktPsQozcGiJM67
        avaaeCGB9MSS1OzU1ILUIpgsEwenVAOT7v1aRWeGwAfXJny9uvbwSoZrG9kY6msT42+9bUtX
        uPo67EhfjN99ZbclLJxZdj/VEip/fDy7+xbfJqsItb2Wc6PC/rNEHXR1+Dlj24kJlzeHO3n/
        925wdA+bZx3gW/B0jo+rrviJmiCZmV2WwUUTRbZv2OPiWxbG2bF439P6F4/7zPROL+kNUOKL
        ea/f8G9HzRz+xAm/TOa90qo+K13yzezMLT7e9ka5UpObviYGb2s7PJZm7chy6i9MMY5v1vo8
        6eh2H+Wje7q3xBSs1xc4GX3eQ9+u7dn+ue/9T/h9r2hPuD3PomiupdGJl6dy+6bHNhuuWWO3
        sFxOqXbGlLMqNttVQyr0/j8+U3VwSoUSS3FGoqEWc1FxIgCsEJrzeAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsVy+t/xu7p3H7omGFzfLm9x89AKRovLu+aw
        OTB59G1ZxejxeZNcAFOUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1K
        ak5mWWqRvl2CXsbB338ZCzZzV/Q+7WdsYFzA2cXIySEhYCKx4dw39i5GLg4hgaWMEmtnLWHu
        YuQASkhJrJybDlEjLPHnWhcbRM1TRol9H+awgSTYBBwl+peeYAWxRQQUJDb3PgOzmQXsJSbO
        +s8GMkdYwE9i+lxxkDCLgKrEzpmPmEBsXoFyiYV3vjNDzJeXaF++nQ0iLihxcuYTFpBWZgF1
        ifXzhEDC/AJaEmuarrNATJeXaN46m3kCo8AsJB2zEDpmIalawMi8ilEktbQ4Nz232FCvODG3
        uDQvXS85P3cTIzCotx37uXkH47xXH/UOMTJxMB5ilOBgVhLh7e1xThDiTUmsrEotyo8vKs1J
        LT7EaAr0wURmKdHkfGBc5ZXEG5oZmBqamFkamFqaGSuJ826duyZeSCA9sSQ1OzW1ILUIpo+J
        g1OqgSnNw+HxI7HTZud3SoX/spm5RNuj3+NHsFDhTK8UiRo59QTxvjNbxW3LzKuzlCsXa8pO
        aKl5bWu41iagd6nGcccbjm8916xmc1lTrrSflfvQUqvPM9nO7qsoZ791tTPl4syZsRH6qy51
        zVHSXBXSuCj39JX++eV92YsX2X0r3Tz/7cuJQU8TtblmhL81XeoRrrO36n20jIOHp/7hqPnr
        Uv9/unHOu9BjT8uxJL/MzjOnZEJWrTL+qXokYu1fZY+P9if0umP3FK5ep+6qmbksbeqm82zZ
        AQv/LT1qPzV6Wdf8wqRUfaaVdheZEgTe9MnpSbdVr3uwRsw7ml3u//lOx91Hvn5tjN0Ra1Vp
        EsMzWYmlOCPRUIu5qDgRAHMuc37zAgAA
X-CMS-MailID: 20210308083541eucas1p1a8f772f12006ee6082b900c1a82aa298
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210308083541eucas1p1a8f772f12006ee6082b900c1a82aa298
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210308083541eucas1p1a8f772f12006ee6082b900c1a82aa298
References: <CGME20210308083541eucas1p1a8f772f12006ee6082b900c1a82aa298@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


For an RTC without an IRQ assigned rtc_update_irq_enable() should
return -EINVAL.  It will, when uie_unsupported is set.

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 drivers/rtc/rtc-ds1307.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index cd8e438bc9c4..b08a9736fa77 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1973,13 +1973,6 @@ static int ds1307_probe(struct i2c_client *client,
 	if (IS_ERR(ds1307->rtc))
 		return PTR_ERR(ds1307->rtc);
 
-	if (ds1307_can_wakeup_device && !want_irq) {
-		dev_info(ds1307->dev,
-			 "'wakeup-source' is set, request for an IRQ is disabled!\n");
-		/* We cannot support UIE mode if we do not have an IRQ line */
-		ds1307->rtc->uie_unsupported = 1;
-	}
-
 	if (want_irq) {
 		err = devm_request_threaded_irq(ds1307->dev, client->irq, NULL,
 						chip->irq_handler ?: ds1307_irq,
@@ -1993,6 +1986,13 @@ static int ds1307_probe(struct i2c_client *client,
 		} else {
 			dev_dbg(ds1307->dev, "got IRQ %d\n", client->irq);
 		}
+	} else {
+		if (ds1307_can_wakeup_device)
+			dev_info(ds1307->dev,
+				 "'wakeup-source' is set, request for an IRQ is disabled!\n");
+
+		/* We cannot support UIE mode if we do not have an IRQ line */
+		ds1307->rtc->uie_unsupported = 1;
 	}
 
 	ds1307->rtc->ops = chip->rtc_ops ?: &ds13xx_rtc_ops;
-- 
2.26.2

