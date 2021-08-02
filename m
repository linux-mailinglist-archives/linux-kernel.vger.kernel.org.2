Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5CF3DDF88
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 20:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhHBSre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 14:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhHBSrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 14:47:33 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F4EC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 11:47:23 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id u9-20020a17090a1f09b029017554809f35so239492pja.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 11:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dsauZAnzB9AyD5J4J9mAeEFxLwVVinDD+qnnMIl8EZo=;
        b=gjfGI/BKiYavobOussivM7E9HIvVWJTwsVefRfNXdPEAxK++5mhcGH6EOiAm51SOJY
         VY35HILT82aGYNQdpZYSCqv31GJMBgCayeJ5jRf/3oBQyMqqSxcxBcUQcmjjD9nNqABM
         T8AjlVP/eH64LqanVs12L4JmflMQ49QVXF+1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dsauZAnzB9AyD5J4J9mAeEFxLwVVinDD+qnnMIl8EZo=;
        b=Qvz+8qw7rVtmq6hoaaE0c3Na6yPYM+WT/CSZkcQIAO7E9K3CgWmaYvJn5ErPbx/jPp
         Kc/2wIu4KVVirWtDDmec9gDpWDr9wgMDmUkPh1fEMFHvpgeU2bFliECH7eJ3XFX/GBc9
         bNqqw0RV9i4+y8ybQawrypiGHHsPddfJaGiNsxre9BQU7T7ZuzQiqutFKtPqklN+r4nM
         VqYMpUqkeT7O5Lqnrep+uH9zQTAWtM/fl9JEC8+6vsUfD2jMAx9v+Bu99iySyhctKoFi
         KXRPKolMU5vE1GqWiBXfvs2ZeAl4pS+zkX/Ui3A7MyWbvP7eKUalxLoe+MPhVVOhSba7
         NQag==
X-Gm-Message-State: AOAM5300EgIDSJm+WcEs6EFc+dGkgFd3WBmkfw9S7GGvdbQST1D/bJcv
        kipKVTDL/a9wsZmDaIQZMu/pFgnj7QixXQ==
X-Google-Smtp-Source: ABdhPJyUkXYSP9WrCKharwtPrqtVNasqW+2CKMfsFBYD/WOY5RRwpcyJklwXsn8AeRVklRsz65AT4A==
X-Received: by 2002:a17:90a:d190:: with SMTP id fu16mr264674pjb.157.1627930042928;
        Mon, 02 Aug 2021 11:47:22 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:8875:fb28:686e:1c31])
        by smtp.gmail.com with ESMTPSA id l11sm13356483pfd.187.2021.08.02.11.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 11:47:22 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 1/2] platform/chrome: cros_ec_proto: Update feature check
Date:   Mon,  2 Aug 2021 11:47:10 -0700
Message-Id: <20210802184711.3872372-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EC feature flags now require more than 32 bits to be represented. In
order to make cros_ec_check_features() usable for more recent features,
update it to account for the extra 32 bits of features.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_proto.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index a7404d69b2d3..772edad80593 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -813,6 +813,7 @@ EXPORT_SYMBOL(cros_ec_get_host_event);
 int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
 {
 	struct cros_ec_command *msg;
+	u32 mask;
 	int ret;
 
 	if (ec->features[0] == -1U && ec->features[1] == -1U) {
@@ -839,7 +840,12 @@ int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
 		kfree(msg);
 	}
 
-	return ec->features[feature / 32] & EC_FEATURE_MASK_0(feature);
+	if (feature >= 32)
+		mask = EC_FEATURE_MASK_1(feature);
+	else
+		mask = EC_FEATURE_MASK_0(feature);
+
+	return ec->features[feature / 32] & mask;
 }
 EXPORT_SYMBOL_GPL(cros_ec_check_features);
 
-- 
2.32.0.554.ge1b32706d8-goog

