Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF993A9584
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 11:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbhFPJH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 05:07:28 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:22411 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbhFPJH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 05:07:26 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210616090501epoutp03747f70731d0d84f40b3c5509c24067f9~JBLGT5uhO0763107631epoutp03S
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 09:05:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210616090501epoutp03747f70731d0d84f40b3c5509c24067f9~JBLGT5uhO0763107631epoutp03S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1623834301;
        bh=myOAqeIc6heLE/UNDGthBzZkw4lnE8HqhfmiMgQ+BjI=;
        h=From:To:Cc:Subject:Date:References:From;
        b=mmqdwQwBRmh8LeTmlOJg61n7ZVk4XALuIOYklW/aicu0zl6JKXeuOYj4oNOyS/BVy
         4m9/r4/Bz7W9JJ+/MnJVNOqxarpsTYQZf8hjoGpNQJy8ZCADybFLKFCn0pBn4ZMYvQ
         bqz16nehcAInJqZaxenrWJ1eLVHYxh59/br6VfWM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20210616090500epcas2p2049065b2cfe90bcd775da77aeeb5afb1~JBLFnbTQ70573705737epcas2p2e;
        Wed, 16 Jun 2021 09:05:00 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.191]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4G4fQf2SPKz4x9Q3; Wed, 16 Jun
        2021 09:04:58 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        C5.F6.09717.8BEB9C06; Wed, 16 Jun 2021 18:04:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20210616090456epcas2p314eef483f4d8cb7b50aa429727317e16~JBLBk5ooy1950619506epcas2p3X;
        Wed, 16 Jun 2021 09:04:56 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210616090456epsmtrp29a48f2a23c86b8e6dcd19c378d945322~JBLBkKO5C2994229942epsmtrp2F;
        Wed, 16 Jun 2021 09:04:56 +0000 (GMT)
X-AuditID: b6c32a48-4fbff700000025f5-0f-60c9beb8274d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        7F.59.08163.8BEB9C06; Wed, 16 Jun 2021 18:04:56 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210616090456epsmtip1efe78e4d7cd05c10fc88a227e52edc3a~JBLBWad9z0765407654epsmtip1W;
        Wed, 16 Jun 2021 09:04:56 +0000 (GMT)
From:   Daehwan Jung <dh10.jung@samsung.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Daehwan Jung <dh10.jung@samsung.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Johan Hovold <johan@kernel.org>,
        Lukasz Halman <lukasz.halman@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: sound: usb: fix rate on Ozone Z90 USB headset
Date:   Wed, 16 Jun 2021 17:50:39 +0900
Message-Id: <1623833442-149455-1-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEKsWRmVeSWpSXmKPExsWy7bCmhe6OfScTDM7dU7a4cvEQk8WdBdOY
        LJoXr2ezaLrRw2pxedccNotd/+8yWXTu6me12PB9LaMDh8eGz01sHjtn3WX32LSqk81j/9w1
        7B773i5j8+jbsorRY/2WqywenzfJBXBE5dhkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoa
        WlqYKynkJeam2iq5+AToumXmAJ2mpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkw
        NCzQK07MLS7NS9dLzs+1MjQwMDIFqkzIydi1/iZLwXr2is0bbjA2MN5g7WLk5JAQMJFY9HgN
        YxcjF4eQwA5GiQcfPrBDOJ8YJW7+u8wIUiUk8JlR4u7nQpiO75P/QXXsYpT4cvcSG0TRD6CO
        L+pdjBwcbAJaEt8XgvWKCBhL9J+dBTaUWeALo8TTOatZQBLCAmYSV9Z9BitiEVCVWPdrGzOI
        zSvgJtG5ciELxDI5iZvnOplBmiUEzrFL/Hz6nhEi4SKxduZGqB+EJV4d38IOYUtJfH63lw3k
        CAmBcolF8+0gejsYJdZ8OgvVaywx61k7I0gNs4CmxPpd+hDlyhJHboGtZRbgk+g4/JcdIswr
        0dEmBNGoLDH98gSopZISB1+fY4awPSR6VnSwQEIhVmLNsx9MExhlZyHMX8DIuIpRLLWgODc9
        tdiowAQ5ijYxghOblscOxtlvP+gdYmTiYDzEKMHBrCTCq1t8IkGINyWxsiq1KD++qDQntfgQ
        oykwuCYyS4km5wNTa15JvKGpkZmZgaWphamZkYWSOC8H+6EEIYH0xJLU7NTUgtQimD4mDk6p
        BqatS6JdD1jzMj1g1dudPL+Qe/vCSwwsZz+x7LQ7OjH8hMSmpCmvVp29XBvj8jjm0j/LRe9q
        1y84f+7G28mPd/7Ytl/7dueTV4WucdJMp+qWHTx3rip9m1lSZZSR0xYbsQDpfQsifNXCX29i
        lzyS+0JOJ/qEG6+BEsub/4serN9y98uVvl1ily8d2/E/x6lmi5YKn17PXd63HVaX3jFpGjkt
        +zHVuOvY7/ubfF9bcXasKs3fFpHOIOF7+f7hixLnpbluShnmFt1/wxhfvbAhWmPeN6N3H3Jf
        2VTLMpw7OdvFa2py9JfpFl/Sd3X80yj/WVG79lBRdq1D7nZ7L28ez0XnZq5Pu2V24NvMuwve
        NIYUKLEUZyQaajEXFScCANGAohr1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMLMWRmVeSWpSXmKPExsWy7bCSnO6OfScTDE495ra4cvEQk8WdBdOY
        LJoXr2ezaLrRw2pxedccNotd/+8yWXTu6me12PB9LaMDh8eGz01sHjtn3WX32LSqk81j/9w1
        7B773i5j8+jbsorRY/2WqywenzfJBXBEcdmkpOZklqUW6dslcGXsWn+TpWA9e8XmDTcYGxhv
        sHYxcnJICJhIfJ/8j7GLkYtDSGAHo8SppudsEAlJiaVzb7BD2MIS91uOsEIUfWOUuN26lbmL
        kYODTUBL4vtCRpAaEQFjif6zs9hBapgFfjFKbD3QwAySEBYwk7iy7jNYEYuAqsS6X9vA4rwC
        bhKdKxeyQCyQk7h5rpN5AiPPAkaGVYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsYweGm
        pbWDcc+qD3qHGJk4GA8xSnAwK4nw6hafSBDiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQ
        QHpiSWp2ampBahFMlomDU6qB6byUywKG3fnaZ66FuHp/zV3HyJ22tPmHjJD2X06G+jCgJ++V
        9ecxqZenLj0jUffmwX+DLe3+PAdW6PUE1u39Up90NHW5TPKZxkPWdc8yt1y4MLP8mfVO1nXP
        Wtpq/7znFBYxN32YvfZGndEJlYt/Vss8cNn6e6WYzPUjWeb1+nXJn4xbLvnsNdLum31hvvvq
        8jN7zzHwL7Jpb2J5Ysz4eNWlmAsrpVrT30YcZxYSDFsl+vOy5qHlN18pN1veD3MOWX+x49wl
        3gs7j3lrnbuu4/TIJn7bmbcNh44y52dLXROQ3qgW0akvLVWyYOkxM4fTj3MOGx2f8byRpehS
        naf8VGl1aVNNbkFDD1br15uUWIozEg21mIuKEwFe4t15pgIAAA==
X-CMS-MailID: 20210616090456epcas2p314eef483f4d8cb7b50aa429727317e16
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210616090456epcas2p314eef483f4d8cb7b50aa429727317e16
References: <CGME20210616090456epcas2p314eef483f4d8cb7b50aa429727317e16@epcas2p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It mislabels its 96 kHz altsetting and that's why it causes some noise

Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
---
 sound/usb/format.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/format.c b/sound/usb/format.c
index 2287f8c..eb216fe 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -223,9 +223,11 @@ static int parse_audio_format_rates_v1(struct snd_usb_audio *chip, struct audiof
 				continue;
 			/* C-Media CM6501 mislabels its 96 kHz altsetting */
 			/* Terratec Aureon 7.1 USB C-Media 6206, too */
+			/* Ozone Z90 USB C-Media, too */
 			if (rate == 48000 && nr_rates == 1 &&
 			    (chip->usb_id == USB_ID(0x0d8c, 0x0201) ||
 			     chip->usb_id == USB_ID(0x0d8c, 0x0102) ||
+			     chip->usb_id == USB_ID(0x0d8c, 0x0078) ||
 			     chip->usb_id == USB_ID(0x0ccd, 0x00b1)) &&
 			    fp->altsetting == 5 && fp->maxpacksize == 392)
 				rate = 96000;
-- 
2.7.4

