Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F09B346833
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 19:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbhCWSz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 14:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbhCWSzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 14:55:07 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB5FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 11:55:06 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id c1so2674900qke.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 11:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RYIeg+FAZo3N58AkdDKWG73SSjjPsdnT5WfpGKmyRWc=;
        b=MenOAbW8u/FEj1QE4zVvDCRZ3GxvMYxHAqW/vQq1Otd/70qUmEd+Epa4Fr/Dul15+M
         EdpQqtmL3TaqapOrXmNEUDv2bxPuNniHwyodHkRl05h94uYjYIaMz/gpUfzCS5XEXqKo
         Is1CoCpXx0H11blhGVhdIAxQLJPMsPvgB47eKtnzVFguZPC3aHgC9VgEko/q96AEzF+A
         IvfQ6Af5wUoN5ctwn+F3LrI4Map1O26i3DAwxU6GazWtPDMp3mhMlMIEm4xJxQDYZ+02
         JAMtyR3mz9fAi0rz7ALfg6YGlcP7RtmATbMU5wSgpg+TW1ISXRWUSa7y7qqBEiyx8dIs
         BCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RYIeg+FAZo3N58AkdDKWG73SSjjPsdnT5WfpGKmyRWc=;
        b=D4zK6RUblDtjnvFSEK9awalS6RFXFwjZuZOUaWQ4cwsAKwU6wbdCusLxWltOBmA3Ml
         bxzXOysUnC7phDtdHamTxOC9thVNyJslsWaYtjc12wT8DisV534YteOTC91g7wtm1oFf
         7e6QDJaUZAh7Hs/kBvCXhRhwR2REyYf/SqnD+Yv9BoF9UXz/+wzjeCd+PcakeeDQxJdE
         TvNWLoTUGYtEaHW2eEHarlU1hHpm/VW/GKrADgR+3g52DAyi6N6NRe7dkVsnMyQq3FaR
         /eRmN450vKGXTlWFr38oztAXmrn3vSex09oCe2lwWS2NKpFDgAsdJgfbs2Q01YlbO4tH
         wBHA==
X-Gm-Message-State: AOAM532JcALyiDJsGXplCCiiumaP71EBUMYoCVeM4OaNx47xVo9lf491
        w+ADEdP3dWrUgmYXrpEBnsqhfMbIRQmm
X-Google-Smtp-Source: ABdhPJydufRLpAYUkWP7OAc5HCE53zn6a0Riy08NSpBqvYAYyUrCb2Y2cjgPOPoQcWq1/INhwREoRisU0Zt4
X-Received: from yudiliu.mtv.corp.google.com ([2620:15c:202:201:a916:b584:a08a:3fcd])
 (user=yudiliu job=sendgmr) by 2002:a05:6214:12a1:: with SMTP id
 w1mr6227626qvu.57.1616525705227; Tue, 23 Mar 2021 11:55:05 -0700 (PDT)
Date:   Tue, 23 Mar 2021 11:55:01 -0700
Message-Id: <20210323115459.v1.1.I3f19b22d6eaaa182123e373a9fa1fa85105aba07@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v1] Bluetooth: Return whether a connection is outbound
From:   Yu Liu <yudiliu@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        chromeos-bluetooth-upstreaming@chromium.org
Cc:     Yu Liu <yudiliu@google.com>, Miao-chen Chou <mcchou@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an MGMT_EV_DEVICE_CONNECTED event is reported back to the user
space we will set the flags to tell if the established connection is
outbound or not. This is useful for the user space to log better metrics
and error messages.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>

Signed-off-by: Yu Liu <yudiliu@google.com>
---

Changes in v1:
- Initial change

 include/net/bluetooth/mgmt.h | 2 ++
 net/bluetooth/mgmt.c         | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index a7cffb069565..d66bc6938b58 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -885,6 +885,8 @@ struct mgmt_ev_new_long_term_key {
 	struct mgmt_ltk_info key;
 } __packed;
 
+#define MGMT_DEV_CONN_DIRECTION_OUT	0x01
+
 #define MGMT_EV_DEVICE_CONNECTED	0x000B
 struct mgmt_ev_device_connected {
 	struct mgmt_addr_info addr;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 90334ac4a135..fc0ff6dc7ebf 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -8772,6 +8772,11 @@ void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
 	bacpy(&ev->addr.bdaddr, &conn->dst);
 	ev->addr.type = link_to_bdaddr(conn->type, conn->dst_type);
 
+	if (conn->out)
+		flags |= MGMT_DEV_CONN_DIRECTION_OUT;
+	else
+		flags &= ~MGMT_DEV_CONN_DIRECTION_OUT;
+
 	ev->flags = __cpu_to_le32(flags);
 
 	/* We must ensure that the EIR Data fields are ordered and
-- 
2.31.0.291.g576ba9dcdaf-goog

