Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6341443CBD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 06:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhKCFgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 01:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhKCFf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 01:35:59 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BECC061203
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 22:33:23 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b5-20020a25a205000000b005c2150fc181so2592984ybi.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 22:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xs0T0WVw07avkfyokmmkdCQmH6GIfXLpMlnt8tnR1gM=;
        b=YEa6S5jxUvaRXnXk6KYLcnE93FShL1ZE72b/FVSD34hL3j8YB4vC9QiWItu9YAS+yS
         mcQiPv56PH0TVoAgfZkApROCJVL1O2RrJah4Y2uVt1YD5Ye/dh8I16FxdTrhPxvDVJAN
         VNs6s47NqqPhQPUzNkvteUFgRZ1Tw4bYYkSIs8CP8X/AqGsOjypIuc+Sq4MgsY2owWGp
         csYCpv1qhV81L+6UZWFZE9uNElVtHXpk/Wnk/7DVf5yfVE+/FjY8o1+5eC56sRu+AaAi
         1UBI9Ic8EBg7b5HstspzA4GHwZVEI3/fAmz2jVGRyp2zGB1cB8pUEeHdPstvegT33AGS
         uLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xs0T0WVw07avkfyokmmkdCQmH6GIfXLpMlnt8tnR1gM=;
        b=7oP3yQyNmXWzgktpGU9gu72/KBQgUZdsSx2MP9LYpr7aO5OG4u83BJGbqeNTMLieHc
         d5DyHzJbzpF9tx0yjqxvMh54BU97HL9GyW1zrKVrdjIBE2GNHTPKmp9oB3p+oTPKfQIK
         748AziTyueNefRgc8PhnJDWGgR1crGh40YvJeA+A5E5DrfBhv1+k37kS++Gd65xuMMAs
         hjQXWpzDIWdLDP/U2HcBlf4po/mC0FYCbfiP3baLVhxzbtGIRX6gva2iK0yWpSpWitgV
         QOmpdVM7/d14F4JTXAmZw2JYsCWBkvOqMwhHodp/zAUyyg75z8NTt0uMF+HhWt17fjOL
         mb0A==
X-Gm-Message-State: AOAM530yFwsRRfGv64nkjaDx7rB9vbSe5rUJ6gCSIz5R9IXleFonVklY
        /OSXBEwr69W1AqGJsmpjUM0xNabZh2QQ
X-Google-Smtp-Source: ABdhPJwSvjB5cPYxJxzN/oBjy/POAcp2ZMLNYY9yCfCgcipAK6CWpatsZlfm0N6cRGHW3xDfEvyYuIQ7KhpX
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:7af7:a937:5810:b542])
 (user=apusaka job=sendgmr) by 2002:a25:d6c6:: with SMTP id
 n189mr22646041ybg.272.1635917602348; Tue, 02 Nov 2021 22:33:22 -0700 (PDT)
Date:   Wed,  3 Nov 2021 13:33:14 +0800
Message-Id: <20211103133225.v2.1.I3ba1a76d72da5a813cf6e6f219838c9ef28c5eaa@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v2 1/2] Bluetooth: Ignore HCI_ERROR_CANCELLED_BY_HOST on adv
 set terminated event
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

This event is received when the controller stops advertising,
specifically for these three reasons:
(a) Connection is successfully created (success).
(b) Timeout is reached (error).
(c) Number of advertising events is reached (error).
(*) This event is NOT generated when the host stops the advertisement.
Refer to the BT spec ver 5.3 vol 4 part E sec 7.7.65.18. Note that the
section was revised from BT spec ver 5.0 vol 2 part E sec 7.7.65.18
which was ambiguous about (*).

Some chips (e.g. RTL8822CE) send this event when the host stops the
advertisement with status = HCI_ERROR_CANCELLED_BY_HOST (due to (*)
above). This is treated as an error and the advertisement will be
removed and userspace will be informed via MGMT event.

On suspend, we are supposed to temporarily disable advertisements,
and continue advertising on resume. However, due to the behavior
above, the advertisements are removed instead.

This patch returns early if HCI_ERROR_CANCELLED_BY_HOST is received.

Btmon snippet of the unexpected behavior:
@ MGMT Command: Remove Advertising (0x003f) plen 1
        Instance: 1
< HCI Command: LE Set Extended Advertising Enable (0x08|0x0039) plen 6
        Extended advertising: Disabled (0x00)
        Number of sets: 1 (0x01)
        Entry 0
          Handle: 0x01
          Duration: 0 ms (0x00)
          Max ext adv events: 0
> HCI Event: LE Meta Event (0x3e) plen 6
      LE Advertising Set Terminated (0x12)
        Status: Operation Cancelled by Host (0x44)
        Handle: 1
        Connection handle: 0
        Number of completed extended advertising events: 5
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Extended Advertising Enable (0x08|0x0039) ncmd 2
        Status: Success (0x00)

Signed-off-by: Archie Pusaka <apusaka@chromium.org>

---

Changes in v2:
* Split clearing HCI_LE_ADV into its own patch
* Reword comments

 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_event.c   | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 63065bc01b76..84db6b275231 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -566,6 +566,7 @@ enum {
 #define HCI_ERROR_INVALID_LL_PARAMS	0x1e
 #define HCI_ERROR_UNSPECIFIED		0x1f
 #define HCI_ERROR_ADVERTISING_TIMEOUT	0x3c
+#define HCI_ERROR_CANCELLED_BY_HOST	0x44
 
 /* Flow control modes */
 #define HCI_FLOW_CTL_MODE_PACKET_BASED	0x00
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d4b75a6cfeee..7d875927c48b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5538,6 +5538,18 @@ static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	adv = hci_find_adv_instance(hdev, ev->handle);
 
+	/* The Bluetooth Core 5.3 specification clearly states that this event
+	 * shall not be sent when the Host disables the advertising set. So in
+	 * case of HCI_ERROR_CANCELLED_BY_HOST, just ignore the event.
+	 *
+	 * When the Host disables an advertising set, all cleanup is done via
+	 * its command callback and not needed to be duplicated here.
+	 */
+	if (ev->status == HCI_ERROR_CANCELLED_BY_HOST) {
+		bt_dev_warn_ratelimited(hdev, "Unexpected advertising set terminated event");
+		return;
+	}
+
 	if (ev->status) {
 		if (!adv)
 			return;
-- 
2.33.1.1089.g2158813163f-goog

