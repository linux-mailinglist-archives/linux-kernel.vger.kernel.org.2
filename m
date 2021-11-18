Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799B1456466
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 21:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbhKRUln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 15:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbhKRUlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 15:41:42 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C63C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 12:38:41 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id iq11so6101435pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 12:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3w1lwxCP95sWJVy1gUV6TvdAB6g68qOdIbQs324040g=;
        b=lZjMwsI6T3g6KvuG95KpwFg/qZZU1kb0j1V3u4+rp6rAJa14wJPkKMGnhRRCbwVj2Z
         NZ9JyqZG+EfHmVbDexaHv4g7WQFZR/qC8QJPcxvf7EjkA5PDQuLvdVpHJQz+CkO4zySr
         tDbIc/l2u6jEvv5/MQ9DY8eawozRlxW5Q+hqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3w1lwxCP95sWJVy1gUV6TvdAB6g68qOdIbQs324040g=;
        b=tZl9FvGr3XZ9fsbkK7jCHwSh8QRXSadD8FjrFvjNPuwi6zv8YsCvlAennPk270PzeE
         +7scXrLSDVSHeeKji1feheeuRATs9v37ld0YDxGz4rcseY8IY6C0LNaVIn0skuBh6Yga
         oGqxsmfK0cf6QDDOqt0isH0FqbxJMOiXO0M1V3HBvMJuPoSNslFghfOxIeIDTRLga1dK
         fZ2vrt9DJD31PXEyh6VyQ00E8T/mqHWXlBCDhgMV5h1REcL6n5TH5fFA/Xcs1pau66sZ
         lTyct9VISX+TLZFVZPg6+w/hHq7neKvagpK7PtEjyUQZwsV0TfY3VoWyETugoJTPOmYW
         QSug==
X-Gm-Message-State: AOAM532pxDXmcrBlzn33u25U5KCf4N+mFpHSvJi7/kwiM2Hq4ffXz5X+
        WZK6ry9SYsVpbALi9gEEmvNbww==
X-Google-Smtp-Source: ABdhPJx97It3R/kqm2LNlIoVuWVCpwYYElzsxAv4u+IBf/mlhP9ILXNF4Py/QGGCz/+1ZgeM3++Ajw==
X-Received: by 2002:a17:90a:df83:: with SMTP id p3mr13883234pjv.145.1637267921429;
        Thu, 18 Nov 2021 12:38:41 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id oj11sm9983727pjb.46.2021.11.18.12.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 12:38:41 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Christian Lamparter <chunkeey@googlemail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] mac80211: Use memset_after() to clear tx status
Date:   Thu, 18 Nov 2021 12:38:39 -0800
Message-Id: <20211118203839.1289276-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3387; h=from:subject; bh=eedQlyh5N+iyZvYtfYqL/0jwZDtmiHDhrCAfLi1SlBc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhlrnOj3IyvlyhPJQP3Xh7qw7ZfZ1D8/+TLTir9jfd 4m7aIBKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYZa5zgAKCRCJcvTf3G3AJiDoD/ 9kgxSBoiQtqRH70xmtElRI7iwlL/NrEuYmC89nwYPe664+48nU9/3PYP8fm/c5cHMWY2RNs2yucDS4 nrsLk7YziWHMEsUN6H8ARqQpRkYMHO4FNSNoZ9wxDPSuxsUv4TWElfshGTT1eKNz09MrRbOBwIYHJ6 XRdXMffjZsERppD+N17asCFU0atrJLgRhD4axFSpBlrsnL54WZRvTgYJhpAOvqI1GpPBmsg2k1l1W+ 7jZrQZ7gFjELdn2MvaC1q7gdE28YWVzaxciHNVPqolxLL0/5+I+ZRfocM8kyaZuB0+ZA2jIZwodJw1 9w97hnyUc0o27yftfv1Y/hJoeP8wa5BBGnH2J8sXDf0Jb/cZbXRBdaiGnPXWu+NwS7RJ34h4g41YuT tv5tIeUIbuFIZCmgDMwJxQHll2Gd8git+z2l4UelZP/04mHPb7JL4nY9tJwO+ZxUcBPdDcODOxWfAh 4kn+imPIlnONXlQE8peovTsUcW0ojhmSD0LxbIvqn/imnG9UJ5IsjMvqiFPmfMzy4Nxo67wYVSVIih 1zoqBID2jIJAKkik6QgYXcCgb2jvXN7yWQDx4V4FMajThrWfB/oBy1opofAdCGzWfXgJH9uyaKWqph 32X7RZeoCHHhVbdY9cVC2Fq00xPLq31ET4A+UDKTESOGtutYxPuqr9sBQcQw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring fields.

Use memset_after() so memset() doesn't get confused about writing
beyond the destination member that is intended to be the starting point
of zeroing through the end of the struct.

Additionally fix the common helper, ieee80211_tx_info_clear_status(),
which was not clearing ack_signal, but the open-coded versions
did. Johannes Berg points out this bug was introduced by commit
e3e1a0bcb3f1 ("mac80211: reduce IEEE80211_TX_MAX_RATES") but was harmless.

Also drops the associated unneeded BUILD_BUG_ON()s, and adds a note to
carl9170 about usage.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/wireless/ath/carl9170/tx.c   | 12 ++++++------
 drivers/net/wireless/intersil/p54/txrx.c |  6 +-----
 include/net/mac80211.h                   |  7 +------
 3 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/ath/carl9170/tx.c b/drivers/net/wireless/ath/carl9170/tx.c
index 88444fe6d1c6..1b76f4434c06 100644
--- a/drivers/net/wireless/ath/carl9170/tx.c
+++ b/drivers/net/wireless/ath/carl9170/tx.c
@@ -275,12 +275,12 @@ static void carl9170_tx_release(struct kref *ref)
 	if (WARN_ON_ONCE(!ar))
 		return;
 
-	BUILD_BUG_ON(
-	    offsetof(struct ieee80211_tx_info, status.ack_signal) != 20);
-
-	memset(&txinfo->status.ack_signal, 0,
-	       sizeof(struct ieee80211_tx_info) -
-	       offsetof(struct ieee80211_tx_info, status.ack_signal));
+	/*
+	 * This does not call ieee80211_tx_info_clear_status() because
+	 * carl9170_tx_fill_rateinfo() has filled the rate information
+	 * before we get to this point.
+	 */
+	memset_after(&txinfo->status, 0, rates);
 
 	if (atomic_read(&ar->tx_total_queued))
 		ar->tx_schedule = true;
diff --git a/drivers/net/wireless/intersil/p54/txrx.c b/drivers/net/wireless/intersil/p54/txrx.c
index 873fea59894f..8414aa208655 100644
--- a/drivers/net/wireless/intersil/p54/txrx.c
+++ b/drivers/net/wireless/intersil/p54/txrx.c
@@ -431,11 +431,7 @@ static void p54_rx_frame_sent(struct p54_common *priv, struct sk_buff *skb)
 	 * Clear manually, ieee80211_tx_info_clear_status would
 	 * clear the counts too and we need them.
 	 */
-	memset(&info->status.ack_signal, 0,
-	       sizeof(struct ieee80211_tx_info) -
-	       offsetof(struct ieee80211_tx_info, status.ack_signal));
-	BUILD_BUG_ON(offsetof(struct ieee80211_tx_info,
-			      status.ack_signal) != 20);
+	memset_after(&info->status, 0, rates);
 
 	if (entry_hdr->flags & cpu_to_le16(P54_HDR_FLAG_DATA_ALIGN))
 		pad = entry_data->align[0];
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index dd757f0987b0..a648484bde33 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1205,12 +1205,7 @@ ieee80211_tx_info_clear_status(struct ieee80211_tx_info *info)
 	/* clear the rate counts */
 	for (i = 0; i < IEEE80211_TX_MAX_RATES; i++)
 		info->status.rates[i].count = 0;
-
-	BUILD_BUG_ON(
-	    offsetof(struct ieee80211_tx_info, status.ack_signal) != 20);
-	memset(&info->status.ampdu_ack_len, 0,
-	       sizeof(struct ieee80211_tx_info) -
-	       offsetof(struct ieee80211_tx_info, status.ampdu_ack_len));
+	memset_after(&info->status, 0, rates);
 }
 
 
-- 
2.30.2

