Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE9835DEF7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 14:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242404AbhDMMcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 08:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241422AbhDMMbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 08:31:06 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25918C061348
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 05:30:47 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u21so25599830ejo.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 05:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pAgxhBv5/NtB+cWLkX3BpIezGlDEtSC6ik2muIVW1Gc=;
        b=CxyDwaoJqNN/OwD7hAXxGSPuhJmXJM48x6CShyhYyO+l76LLtt8YRUsBDWgcCALiyR
         rO54kBHPYbvfVh7ohrqZD0xVFPDcNgfn7P86G/txg+UOmxlMRXisdxIsFHHXA1NCHvQA
         qmTm5tiEjL7F5dStR7q20BjNwsoQUGJJOEjqQahu84Snf6aqCP9RPi0C8q8YjhqsjjZ/
         AGRDtvpGaEByPOLwXAeFduUkkzXiPcnRzvori0VT57wE4v+FUQ0VBUpD7SjBW7MOD9QD
         U+RxaeaE62jBJ/OQV4clfralWwhWz2+wLXpsJ+2zhRJf/KXwGZaFh4KpuV+KIyL4Wx7Z
         KKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pAgxhBv5/NtB+cWLkX3BpIezGlDEtSC6ik2muIVW1Gc=;
        b=j49QhRqYYizahzYH6LqH9YQXsJd8A5U+kg2bBN3FETbhGV14TgA6CtWJyCggwu/3Er
         6lSPVn13Pklv7TP75B7YuzwmPW3eb+cCQGtI0B1Te4vRF03U06tck0yebHbo69viUaSg
         0RuWg6ZfidQDQFHTVqdKRLlJgI3h4V9PVIBtGfC9zQojT5nKLFDBq7fcfhGeKJ/MPQAH
         PhfDxaGCVcn7Z+6CNLPp9y+Z0bOpEMz+D9CUFD2eWGrz/3KywOhvc655VdnQ8ZMZhyqA
         PEVXh9w2QaNdM/D0NIrlA65wv5K5FbMFIG/Od4vKWH0XmILa9SB5s/Obj3gqiGNBjt/D
         DRxQ==
X-Gm-Message-State: AOAM530Jd07gcUVZSKSM1kY3Wk/N6pNugdAuCCG0Pt4pSBwJUJtGxg/O
        bsVLelOjKQaI9Z343jW8G6w=
X-Google-Smtp-Source: ABdhPJy3RUm5199KNZFcG3FHQV8zoLwzVvCxYhlXgazrCE7Jv9Oxy5BfBiNl7OdKuv4V91V9cuGGog==
X-Received: by 2002:a17:906:1444:: with SMTP id q4mr32001626ejc.343.1618317045883;
        Tue, 13 Apr 2021 05:30:45 -0700 (PDT)
Received: from linux.local (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id d22sm687391ejz.79.2021.04.13.05.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 05:30:45 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH] staging: rtl8192u: ieee80211: Replaced strncpy() with strscpy()
Date:   Tue, 13 Apr 2021 14:30:41 +0200
Message-Id: <20210413123041.24260-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced strncpy() with strscpy() because of compilation time warnings
about possible truncation of output [-Wstringop-truncation].
Furthermore, according to the Linux official documentation, strscpy() is
preferred to strncpy.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index 25ea8e1b6b65..aa58eedf5e86 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -1385,12 +1385,12 @@ inline void ieee80211_softmac_new_net(struct ieee80211_device *ieee, struct ieee
 			 * essid provided by the user.
 			 */
 			if (!ssidbroad) {
-				strncpy(tmp_ssid, ieee->current_network.ssid, IW_ESSID_MAX_SIZE);
+				strscpy(tmp_ssid, ieee->current_network.ssid, IW_ESSID_MAX_SIZE);
 				tmp_ssid_len = ieee->current_network.ssid_len;
 			}
 			memcpy(&ieee->current_network, net, sizeof(struct ieee80211_network));
 
-			strncpy(ieee->current_network.ssid, tmp_ssid, IW_ESSID_MAX_SIZE);
+			strscpy(ieee->current_network.ssid, tmp_ssid, IW_ESSID_MAX_SIZE);
 			ieee->current_network.ssid_len = tmp_ssid_len;
 			netdev_info(ieee->dev,
 				    "Linking with %s,channel:%d, qos:%d, myHT:%d, networkHT:%d\n",
-- 
2.31.1

