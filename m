Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3903F719B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 11:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239583AbhHYJWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 05:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbhHYJWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 05:22:16 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAD0C0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 02:21:30 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h4so5160483wro.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 02:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nr5ldMTnZyEoaDP2MOUKRrLKy0i/6wxf41UTk8wHlwU=;
        b=joKHoSBSh/xc5IsD6a7mRqzAoEeXrQ5PMN2mYlcQUUre8Xe8qCH8G1K+lW39vIQLws
         b7+7jKxYQTzjK01V7KE/pqqBqKj2Q8jW+9xFoajRHZl0PZ6q3O8msw0Az7dwdiMwYjbn
         pH9+fgQVpHDdLhgs3HhhcJHdB+uk5WgQHSwk8Rqm1AbGrItL6vq4QjR0D0fp8jVoHf7k
         xMTmHGXZcO8Q+cA8a3LWOKm4M78/eVyHfvo/d6t0bCO8pNeyx+dAE6vyWqtoSB3g+2mV
         M/Z/3dle+pqPVd6ULRROGlxVxqqAc68lONvVpS6Aw2WpT6ktfa53mXYFe2hmPmQD91X8
         uERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nr5ldMTnZyEoaDP2MOUKRrLKy0i/6wxf41UTk8wHlwU=;
        b=svEUQpF5xerwX9cfyZ1DjmaZenJ81zqxQjFdD+VEtEWb8cZwkakCRC8YuGv/K6alh5
         siIYqGrYvbv8ahvIpc/M65G7pSfUV9M/sQE+zOrwqcCCFTTFKgcjIHI+EQTYTi5GAN79
         mZJKDEHg4N6kIAuhgY2DoGbWXKDZl0+bO33EfSdhOkkZwnyYmOFtO8eDzGr+IXnN0kf+
         +UBmqOQz9lvdVzXjmM3iwIbhojyLN5XdYE6aA23dfgweDpInzmtDhVUCYvWj5Paa4nVk
         GZ7jHWXTEomIKYVstaL0xpB8YqBoO+Fd2U1q+alTBZ2zM3cXtsRygBFmVQSbfH4V6rbp
         AWqA==
X-Gm-Message-State: AOAM530H8kditmLkFwZsarsk09T49JlVinENY7piM7qcHBvTvE/nvMYs
        Zw0c5DwoWIVB8URs45OjhpeDsw==
X-Google-Smtp-Source: ABdhPJxO/I02GTgVKK7gQ23noQNpufzJHSm1c8cbXqZTodnZMin+6sXCrqBpGNF86k+aadpFt343DA==
X-Received: by 2002:a05:6000:1569:: with SMTP id 9mr15638215wrz.242.1629883289465;
        Wed, 25 Aug 2021 02:21:29 -0700 (PDT)
Received: from jackdaw.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id 18sm5416918wmv.27.2021.08.25.02.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 02:21:29 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Ferry Toth <fntoth@gmail.com>, Ferry Toth <ftoth@exalondelft.nl>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Pavel Hofman <pavel.hofman@ivitera.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jack Pham <jackp@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH] usb: gadget: f_uac2: fixup feedback endpoint stop
Date:   Wed, 25 Aug 2021 11:21:07 +0200
Message-Id: <20210825092107.124419-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210824201433.11385-1-ftoth@exalondelft.nl>
References: <20210824201433.11385-1-ftoth@exalondelft.nl>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the uac2 function is stopped, there seems to be an issue with some
platforms (Intel Merrifield at least)

BUG: kernel NULL pointer dereference, address: 0000000000000008
...
RIP: 0010:dwc3_gadget_del_and_unmap_request+0x19/0xe0
...
Call Trace:
 dwc3_remove_requests.constprop.0+0x12f/0x170
 __dwc3_gadget_ep_disable+0x7a/0x160
 dwc3_gadget_ep_disable+0x3d/0xd0
 usb_ep_disable+0x1c/0x70
 u_audio_stop_capture+0x79/0x120 [u_audio]
 afunc_set_alt+0x73/0x80 [usb_f_uac2]
 composite_setup+0x224/0x1b90 [libcomposite]

The issue happens only when the gadget is using the sync type "async", not
"adaptive". This indicates that problem is likely coming from the feedback
endpoint, which is only used with async synchronization mode.

Update the feedback endpoint free function to release the endpoint the same
way it is done for the data endpoint.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

 Hi Ferry,

 Would you mind trying this before reverting the whole thing ?
 The HW I have did not show the issue so far so I can't really check
 if it helps. Hopefully, it does ...

 drivers/usb/gadget/function/u_audio.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/function/u_audio.c b/drivers/usb/gadget/function/u_audio.c
index 018dd0978995..63d9340f008e 100644
--- a/drivers/usb/gadget/function/u_audio.c
+++ b/drivers/usb/gadget/function/u_audio.c
@@ -230,7 +230,13 @@ static void u_audio_iso_fback_complete(struct usb_ep *ep,
 	int status = req->status;
 
 	/* i/f shutting down */
-	if (!prm->fb_ep_enabled || req->status == -ESHUTDOWN)
+	if (!prm->fb_ep_enabled) {
+		kfree(req->buf);
+		usb_ep_free_request(ep, req);
+		return;
+	}
+
+	if (req->status == -ESHUTDOWN)
 		return;
 
 	/*
@@ -421,9 +427,10 @@ static inline void free_ep_fback(struct uac_rtd_params *prm, struct usb_ep *ep)
 	prm->fb_ep_enabled = false;
 
 	if (prm->req_fback) {
-		usb_ep_dequeue(ep, prm->req_fback);
-		kfree(prm->req_fback->buf);
-		usb_ep_free_request(ep, prm->req_fback);
+		if (usb_ep_dequeue(ep, prm->req_fback)) {
+			kfree(prm->req_fback->buf);
+			usb_ep_free_request(ep, prm->req_fback);
+		}
 		prm->req_fback = NULL;
 	}
 
-- 
2.33.0

