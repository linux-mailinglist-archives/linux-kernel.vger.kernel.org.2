Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 541353F95A5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 09:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244365AbhH0IAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 04:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244467AbhH0H7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 03:59:49 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF49C061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 00:59:00 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id k20-20020a05600c0b5400b002e87ad6956eso3732943wmr.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 00:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yl2Mj/R+A9DBvNhnNuUXi4ZsTfdfpnV8MVghnmu8vDE=;
        b=my9FC6Q1o7OMKPWkk28LONG8AW34poqWGOGCm85GxTmJdo+lJ1xe5qWn/6eb036IU8
         pchEuizBy7kZJdjPrwxbghywYTorR33cO4FpiECUrn7hbquAw08fdeAYHQ0aNxN6jeq1
         9UBctY17riiXKrqmbXzojvQfnv6Q82/YSUw2LgEsTTPd9hz4VGaaq5R6qTFdiCzX9Bum
         JLD+r4uT7xRlvU8abUrpuLvasYVwKCt1E3FeX3tB9KhpMqFUb4bTdrfRMeduek0QWUCH
         AqEI1FGVS+qmZf7leRdUjyz4v7BhODf4+U8m1LTsyG0hgXLJi1VMKyJfD9PkAYV8qXH4
         Nrbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yl2Mj/R+A9DBvNhnNuUXi4ZsTfdfpnV8MVghnmu8vDE=;
        b=PdZ270VgTb7e10jCcSaLZiuzLBKOdk+efc3yQ33R5y8LdH0PxI5Ig+VtjMcISj7tom
         qqdF8/GttqdKNjm5toDn6WO/My4oUyd5BMYtGbu6NJP1EEEgMrTbAxP9htaeyPd2qGnN
         SUyyLxHXDQXRyL59g9WdnDU+Kpt9kGSSAZpUrJTxyyRgsuZNpjAThsVbg2AjK8xnas/A
         v80Ln7MPYysvnX09j/3mo4pdf91mjVAw8+R/L/wofGaM51ZO+BWViU4wXa7ot6AqvwPA
         4xyofLckyD5d4jZY81gXsBEEGDel6gmH+6Q+dZqDmAMaoCPgKV4HZvOU5yLXequGFzp/
         w2ZQ==
X-Gm-Message-State: AOAM531YYiGN8iZy3Xx6K54ZpRoSlDw9GufczX/lIdqRNqZZqmb5BikB
        tY4OKERIQOEcZaqJGejbyhLtFw==
X-Google-Smtp-Source: ABdhPJz6QBRdeENxEHKsVH1FM1utGJzt9h197J+dbiptbGd5jvxjcAC7B2kmlfA0IrZxhPtG2K6blQ==
X-Received: by 2002:a05:600c:19d1:: with SMTP id u17mr7414355wmq.21.1630051139143;
        Fri, 27 Aug 2021 00:58:59 -0700 (PDT)
Received: from jackdaw.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id u8sm10934746wmq.45.2021.08.27.00.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 00:58:58 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Pavel Hofman <pavel.hofman@ivitera.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jack Pham <jackp@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Ferry Toth <ftoth@exalondelft.nl>
Subject: [PATCH] usb: gadget: f_uac2: fixup feedback endpoint stop
Date:   Fri, 27 Aug 2021 09:58:53 +0200
Message-Id: <20210827075853.266912-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the uac2 function is stopped, there seems to be an issue reported on
some platforms (Intel Merrifield at least)

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
"adaptive". This indicates that problem is coming from the feedback
endpoint, which is only used with async synchronization mode.

The problem is that request is freed regardless of usb_ep_dequeue(), which
ends up badly if the request is not actually dequeued yet.

Update the feedback endpoint free function to release the endpoint the same
way it is done for the data endpoint, which takes care of the problem.

Reported-by: Ferry Toth <ftoth@exalondelft.nl>
Tested-by: Ferry Toth <ftoth@exalondelft.nl>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Hi Felipe,

 This solves the issue reported here [0] and makes revert [1]
 unnecessary.

 [0]: https://lore.kernel.org/r/20210824201433.11385-1-ftoth@exalondelft.nl
 [1]: https://lore.kernel.org/r/20210826185739.3868-1-ftoth@exalondelft.nl

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

