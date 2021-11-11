Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733BC44D624
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 12:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbhKKL5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 06:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbhKKL5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 06:57:10 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2B7C061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 03:54:21 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id h62-20020a25a544000000b005c5d9b06e57so8899416ybi.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 03:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4kL0X2JVV0XjaUHDlSkh7aIxrPJS+P1TxygnVknNAZg=;
        b=Q+/jtBb//RU4wXxTAhXSVm2orlgn4RWfwrSjrQlNKVkWGlTrLvz9MJ96wWDFx/4DBn
         8nfP/26EVLTEEXNF8fgtFKprei22rUtMhyowsZU4vLDFEfAgkwHFa23Nw46oD+VMrfaV
         8ukt0PyOqV2V1gbFykDZm4V9iSer4Wi5lYigGnsxqn/lzGnBZ0Hdi8LP8vK7RK4LSm0l
         KWkjCr3vQ0hbfr8MJLEmYVYxuSi8r39LtkxTGoVlchAjYi+XbN0SGszIDnqsO1/a+LDv
         nw/SdPnQ7l/LOSQ71L93BdLvyi1CSMfHQQZxya7I6X7olgrs2syvV6EnhCIixiUkTpDR
         ASMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4kL0X2JVV0XjaUHDlSkh7aIxrPJS+P1TxygnVknNAZg=;
        b=PbtVur8pktq6I49QyPEXA7I0/rYYMKaSCnrr/xKGCctDwmc+KrGUqg9QI8oW8GkJ2v
         CS9gqTxVs3Tm8+gAisAoZumpwoqOEZhZatrp3JRe4nBWAR/ZSzUvvA+XAC+JbPcuQtcX
         lQJwtOZkvrGH5oxuppy3ykJBConRSnDCTYmRqNkic+oZVuNGYDbrrL/742Z7x/3FxnBj
         0kPlTbdkg8KNriuDnrEoW7HYbfsCWtKy/4XQLntmCMa09reJ6ExCKyg6ZeopXkel7tMp
         h1l8CtGeAlmda58J7CDjoC8Vo8O6tQzdacXecrKC0tKxbXmXdkF8EYZcdSMpGfW4ht4F
         ggnQ==
X-Gm-Message-State: AOAM5304Icp7ejpfs1KW/AJBD4BmG8R7zZfjIRtHUuhaP19RtOxbgb9K
        DsieAIsW5V+NqNr3XfzU6eV32/uNiV9h
X-Google-Smtp-Source: ABdhPJypRDIh4yurXN82mQRqslDI7fpio42+fj+0QjBuTXIyRZ/XgO7FeGopIjdipnZupcHi2ly03+HNzBey
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b87e:3eb:e17e:1273])
 (user=apusaka job=sendgmr) by 2002:a05:6902:1205:: with SMTP id
 s5mr8240471ybu.71.1636631660862; Thu, 11 Nov 2021 03:54:20 -0800 (PST)
Date:   Thu, 11 Nov 2021 19:53:52 +0800
In-Reply-To: <20211111195320.1.Id7366eb14b6f48173fcbf17846ace59479179c7c@changeid>
Message-Id: <20211111195320.3.I35b7f3a496f834de6b43a32f94b6160cb1467c94@changeid>
Mime-Version: 1.0
References: <20211111195320.1.Id7366eb14b6f48173fcbf17846ace59479179c7c@changeid>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH 3/3] Bluetooth: Limit duration of Remote Name Resolve
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

When doing remote name request, we cannot scan. In the normal case it's
OK since we can expect it to finish within a short amount of time.
However, there is a possibility to scan lots of devices that
(1) requires Remote Name Resolve
(2) is unresponsive to Remote Name Resolve
When this happens, we are stuck to do Remote Name Resolve until all is
done before continue scanning.

This patch adds a time limit to stop us spending too long on remote
name request.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

 include/net/bluetooth/hci_core.h | 3 +++
 net/bluetooth/hci_event.c        | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index eb08dd502f2a..941cfbb024d1 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -89,6 +89,7 @@ struct discovery_state {
 	u8			(*uuids)[16];
 	unsigned long		scan_start;
 	unsigned long		scan_duration;
+	unsigned long		name_resolve_timeout;
 };
 
 #define SUSPEND_NOTIFIER_TIMEOUT	msecs_to_jiffies(2000) /* 2 seconds */
@@ -1763,6 +1764,8 @@ void hci_mgmt_chan_unregister(struct hci_mgmt_chan *c);
 #define DISCOV_LE_FAST_ADV_INT_MIN	0x00A0	/* 100 msec */
 #define DISCOV_LE_FAST_ADV_INT_MAX	0x00F0	/* 150 msec */
 
+#define NAME_RESOLVE_DURATION		msecs_to_jiffies(10240)	/* msec */
+
 void mgmt_fill_version_info(void *ver);
 int mgmt_new_settings(struct hci_dev *hdev);
 void mgmt_index_added(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 2de3080659f9..6180ab0e8b8d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2129,6 +2129,12 @@ static bool hci_resolve_next_name(struct hci_dev *hdev)
 	if (list_empty(&discov->resolve))
 		return false;
 
+	/* We should stop if we already spent too much time resolving names. */
+	if (time_after(jiffies, discov->name_resolve_timeout)) {
+		bt_dev_dbg(hdev, "Name resolve takes too long, stopping.");
+		return false;
+	}
+
 	e = hci_inquiry_cache_lookup_resolve(hdev, BDADDR_ANY, NAME_NEEDED);
 	if (!e)
 		return false;
@@ -2716,6 +2722,7 @@ static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (e && hci_resolve_name(hdev, e) == 0) {
 		e->name_state = NAME_PENDING;
 		hci_discovery_set_state(hdev, DISCOVERY_RESOLVING);
+		discov->name_resolve_timeout = jiffies + NAME_RESOLVE_DURATION;
 	} else {
 		/* When BR/EDR inquiry is active and no LE scanning is in
 		 * progress, then change discovery state to indicate completion.
-- 
2.34.0.rc0.344.g81b53c2807-goog

