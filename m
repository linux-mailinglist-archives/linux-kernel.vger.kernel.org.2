Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD723DA949
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 18:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhG2Qn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 12:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhG2Qn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 12:43:28 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905F1C061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 09:43:25 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j9-20020a2581490000b02905897d81c63fso1730971ybm.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 09:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+vXJXnWw4i/uZjkWX5JtWCOlsWNzjAsTCHJJYSUJPqg=;
        b=DeXGHwZ26J/RmPqe0tvmGC10hTSpp6xifoGBlog/q3hsEyb6x7Aue+LUMEk5Q33fIj
         d56RbbxHoMmyF2vKZ5LiBtVD6fceN9t1dTf7PglIOLZERUg/kQcZ9cWNz5ONZB/KItVc
         gNy5N1kgv1vxgfU/BmFGuszHkW7dDnOG94NX/oVezluQmQm6UXRmG8Qv1GKjw+PlJVQk
         uzWbeeYQ1aPK/snNzAvndpWlhAjrXvpBlG0kN48w3ZnnYInNH1lDUn6Bx2bnkjd611HR
         ngjlyFL1P/cYF163wu5ai+SB6xVzRXg5YT/GH26xMLaq4CLDUlfYh3Mk/bAfUTxJ0Dfx
         lTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+vXJXnWw4i/uZjkWX5JtWCOlsWNzjAsTCHJJYSUJPqg=;
        b=Qd+o4hGMXTst86XiGVBbQjFtcj/SshOLhmxlHe20rc5qcEQoiWo1fGpdmEvsErIMFj
         fTYD+e5VZnZ04ByMr5wO41yP3BRqGS52TADZ/QG90vh05GZxLOH27yTm1djJHwBUEzn9
         gJOMTa4Xm+RBKi1EsQHPa4W/MFZ8j74Gqtc9BtXLV4djbK+RBAFULRD4XkjBmBHx553V
         PochKzeRULPT8xteN2YCtccpKOrsNXqZ4mHty5xCS0KE8SmqcVRl8nidpaBHbA5dtujV
         VeJ3BeMwu3stg8QmGm0ZssvSfVqcKC+TPUhbzZDSI8C2wxszwy8to9qMqoah1+JPkLpK
         bXgA==
X-Gm-Message-State: AOAM530j9nywxtiD53TtEDn2ek5wGhKrfGdhH/444KILEd/z6AXdaShn
        xaDTD6tQugRh7bi0/ND4nHcJ+oNlHm+vEftZ9Q==
X-Google-Smtp-Source: ABdhPJwVXBQAWZwfhc/BekQ1qtupMFZFls7enotw/WCy2nXFNP8xBlx4nkU04KIBWiQ0qwvcHW/q34tI22ot2MdnZQ==
X-Received: from michaelfsun.mtv.corp.google.com ([2620:15c:202:201:9678:c075:a4e7:f144])
 (user=michaelfsun job=sendgmr) by 2002:a25:b3c9:: with SMTP id
 x9mr7360564ybf.514.1627577004790; Thu, 29 Jul 2021 09:43:24 -0700 (PDT)
Date:   Thu, 29 Jul 2021 09:43:21 -0700
Message-Id: <20210729094319.1.Ib7a90fea41e56da34bab6811c2ecf6b255a14f51@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH] Bluetooth: btusb: Enable MSFT extension for Intel next
 generation controllers
From:   Michael Sun <michaelfsun@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Michael Sun <michaelfsun@google.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chethan T N <chethan.tumkur.narayan@intel.com>

The Intel TyphoonPeak, GarfieldPeak Bluetooth controllers
support the Microsoft vendor extension and they are using
0xFC1E for VsMsftOpCode.

Verified on a GarfieldPeak device through bluetoothctl show

Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Signed-off-by: Michael Sun <michaelfsun@google.com>
---

 drivers/bluetooth/btusb.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1876a960b3dc..23cf6e98173b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3031,6 +3031,17 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 	btintel_version_info_tlv(hdev, &version);
 
 finish:
+	/* All Intel new genration controllers support the Microsoft vendor
+	 * extension are using 0xFC1E for VsMsftOpCode.
+	 */
+	switch (INTEL_HW_VARIANT(version.cnvi_bt)) {
+	case 0x17:
+	case 0x18:
+	case 0x19:
+		hci_set_msft_opcode(hdev, 0xFC1E);
+		break;
+	}
+
 	/* Set the event mask for Intel specific vendor events. This enables
 	 * a few extra events that are useful during general operation. It
 	 * does not enable any debugging related events.
-- 
2.32.0.432.gabb21c7263-goog

