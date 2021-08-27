Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075293F9701
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 11:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244842AbhH0Jar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 05:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244818AbhH0Jaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 05:30:35 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC524C061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 02:29:45 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b6so9372536wrh.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 02:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1xUF9cH5LkIQ+vY1rJ84NxUnxKCkjh40P+zqUVE+ais=;
        b=eUa51EalOnCi+1Lc9AW3VuuFcgX8DMEMXIhAIbm9blwTlLLVAxGh1MU8emI1K3hp4g
         04JuoN/Nar/afYf5kIDWIiSW9RN9cwO+PmCNPmkx4IUGxepcKgRopwE93fkk9oXQy6gH
         SH1i30vnk591WtkFOwXL9jHw17Z4i4JguGqhLMzFEYxQPXx29I2nkoLRfIcV3n1LjePZ
         /5ZouUKNV2p2uCl0iYhlyjLOu0UNvfUdNeTuvMoIbBsiSrV//Ne1iXZS46sAmf44Wh0H
         HmdxQX0gc1A7RArj1DcuDvQoQjJzw3fXuBxLzSoOg6kWQrVPAZw/7yb1LnDEml9oOq95
         L4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1xUF9cH5LkIQ+vY1rJ84NxUnxKCkjh40P+zqUVE+ais=;
        b=GGoWES13O82JvusAtBcA6BeGJgrxYaUWTFDFuWXeIpWOWMRuuK5YJ9Q4UpLjM1AF0z
         cNx095drz/W4Az3dWZUeCd3zlp96R41pNg3U8Blj5KuvQaz8gfy8JdduLqPtzEWlAt12
         OQdHx3/8T6ohitOrvDoxG2u5iOJHyUR9mXGYedM9RD4nLLxkhilGJO/QpYx62prUfuWm
         xB1ukD4aWMCavT2gwrcWDyLzcH3iPqEuRRELzMp9bHL6i+YvnqDRjAoap8TFV769ccgP
         yjzzHMsCVb2fIiTV/8Gj2wR4J3vAaM+qTmYguXQs4AqnTZXPfvSYGXK0/NmdQDvNuE4B
         FKOQ==
X-Gm-Message-State: AOAM532VgV6ICDDsHK4lEbW1/XU2J8EXjCtpa6GSUrmNFJwfV0MPLOuT
        bpJzViRCxAdbUc2HNjwY/KR9ew==
X-Google-Smtp-Source: ABdhPJz07gsE3HRVZao/zMs1UTazUDypn/B827ah8dCDRUNWK9ebZjINVlN2pzpQrahmQUH1n5Hi2w==
X-Received: by 2002:adf:914e:: with SMTP id j72mr9256929wrj.218.1630056584407;
        Fri, 27 Aug 2021 02:29:44 -0700 (PDT)
Received: from jackdaw.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id s13sm11048515wmc.47.2021.08.27.02.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 02:29:44 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH] usb: gadget: u_audio: fix race condition on endpoint stop
Date:   Fri, 27 Aug 2021 11:29:27 +0200
Message-Id: <20210827092927.366482-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the endpoint completion callback is call right after the ep_enabled flag
is cleared and before usb_ep_dequeue() is call, we could do a double free
on the request and the associated buffer.

Fix this by clearing ep_enabled after all the endpoint requests have been
dequeued.

Fixes: 7de8681be2cd ("usb: gadget: u_audio: Free requests only after callback")
Reported-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/usb/gadget/function/u_audio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/function/u_audio.c b/drivers/usb/gadget/function/u_audio.c
index 63d9340f008e..9e5c950612d0 100644
--- a/drivers/usb/gadget/function/u_audio.c
+++ b/drivers/usb/gadget/function/u_audio.c
@@ -394,8 +394,6 @@ static inline void free_ep(struct uac_rtd_params *prm, struct usb_ep *ep)
 	if (!prm->ep_enabled)
 		return;
 
-	prm->ep_enabled = false;
-
 	audio_dev = uac->audio_dev;
 	params = &audio_dev->params;
 
@@ -413,6 +411,8 @@ static inline void free_ep(struct uac_rtd_params *prm, struct usb_ep *ep)
 		}
 	}
 
+	prm->ep_enabled = false;
+
 	if (usb_ep_disable(ep))
 		dev_err(uac->card->dev, "%s:%d Error!\n", __func__, __LINE__);
 }
@@ -424,8 +424,6 @@ static inline void free_ep_fback(struct uac_rtd_params *prm, struct usb_ep *ep)
 	if (!prm->fb_ep_enabled)
 		return;
 
-	prm->fb_ep_enabled = false;
-
 	if (prm->req_fback) {
 		if (usb_ep_dequeue(ep, prm->req_fback)) {
 			kfree(prm->req_fback->buf);
@@ -434,6 +432,8 @@ static inline void free_ep_fback(struct uac_rtd_params *prm, struct usb_ep *ep)
 		prm->req_fback = NULL;
 	}
 
+	prm->fb_ep_enabled = false;
+
 	if (usb_ep_disable(ep))
 		dev_err(uac->card->dev, "%s:%d Error!\n", __func__, __LINE__);
 }
-- 
2.33.0

