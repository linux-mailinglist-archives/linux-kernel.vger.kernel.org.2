Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C95C35528E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 13:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245731AbhDFLoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 07:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245719AbhDFLn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 07:43:57 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACF1C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 04:43:49 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id y1so16088454ljm.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 04:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3IjasWzqLdpd77pS1i7PqF29b9l9kltRxgeNazC6S+A=;
        b=YRQ2un+x1GRDNMpOfchUiLj6wKbHVcJWzYixrzYrHZe5ImoCpFt0V9+4E4+9yMPAa9
         YhGdeofhupjNhFZamryrPcV+7PNYst5gRopw/pGfL91wUOYuCqgCBPw6YznU3MGJ6z5O
         f6IqSg9fw02o2ah6xcK3MJZoY8+ZNddxuED2yQkLCEfwoofHf1TxLaduVd5G5wYUNSNc
         tPz4BufMK2YkMyKZMHTvashRSAwfggcKqj4BBwEr6b4pfO6Ou4kHqQuhhw7yPvPoOWX1
         39YGH2lsKvmfgO9NgF46KWBhCv6jPTUKJe4cr+QXVUK1MB2ZPIRpU1+Wrtz7Nl1pEJUB
         jyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3IjasWzqLdpd77pS1i7PqF29b9l9kltRxgeNazC6S+A=;
        b=kDSWgQ6kBRt0WW0lz8IqnXawpikHaSDHLkn+xKk84q14Q+LH1tX+e1XqeZHBS+U+1h
         l84Zg/rWBAgcT8ARkh4CtG/PVFkU97PKHc5ODdv9TGsdLOOdEpnvilOcTf8LjbUjIu6K
         zcsHmDBl6DZ/HOdtEOraifPpRcp64obho9uJk/ioKlOYAS2XfElG8hHLjO1EYWXjoOmO
         42JVV3pPtppdBWObUscq7pdp4DrR8r5nnxDLGTb6pcQ+d4T2REnxUgJPXdQeFbooc665
         utBPP1+/yZWbswZiP4f7F8QfyGuZJByY9Me05u2wWGQcIb3HVoRGU1P3k9t0ARAX6Pfi
         1RLA==
X-Gm-Message-State: AOAM5334REtJyx/HuP4yKGFBwktmUxKK97vwP6B/d19CwEeXlhfFJXaF
        SEcNEh671V0Sc2moUR3AvsA=
X-Google-Smtp-Source: ABdhPJzob+c57aneqwDNEZWAEOZJ0TYdVCA+/JWvz7YXKaR8lgr7CM2WH4MMGwOZ9mgjAOP8fIUi1A==
X-Received: by 2002:a05:651c:29a:: with SMTP id b26mr18331006ljo.451.1617709427616;
        Tue, 06 Apr 2021 04:43:47 -0700 (PDT)
Received: from zhans ([37.151.32.231])
        by smtp.gmail.com with ESMTPSA id i30sm2132615lfj.206.2021.04.06.04.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 04:43:47 -0700 (PDT)
Date:   Tue, 6 Apr 2021 17:43:46 +0600
From:   Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH v2 2/2] staging: rtl8712: Remove extra blank lines
Message-ID: <f61f6d330bc3fa53d4d420754d1d461b6cfcb2de.1617708653.git.zhansayabagdaulet@gmail.com>
References: <cover.1617708653.git.zhansayabagdaulet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617708653.git.zhansayabagdaulet@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove extra blank lines after an open brace to adhere to Linux kernel
coding style.
Reported by checkpatch.

Signed-off-by: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_io.h   | 1 -
 drivers/staging/rtl8712/rtl871x_mlme.h | 1 -
 drivers/staging/rtl8712/rtl871x_recv.h | 1 -
 drivers/staging/rtl8712/sta_info.h     | 1 -
 4 files changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_io.h b/drivers/staging/rtl8712/rtl871x_io.h
index c20dd5a6bbd1..c5b12f74ebf8 100644
--- a/drivers/staging/rtl8712/rtl871x_io.h
+++ b/drivers/staging/rtl8712/rtl871x_io.h
@@ -123,7 +123,6 @@ struct	intf_hdl {
 };
 
 struct reg_protocol_rd {
-
 #ifdef __LITTLE_ENDIAN
 	/* DW1 */
 	u32		NumOfTrans:4;
diff --git a/drivers/staging/rtl8712/rtl871x_mlme.h b/drivers/staging/rtl8712/rtl871x_mlme.h
index 46effb469fd4..d7d25f240111 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.h
+++ b/drivers/staging/rtl8712/rtl871x_mlme.h
@@ -77,7 +77,6 @@ struct sitesurvey_ctrl {
 };
 
 struct mlme_priv {
-
 	spinlock_t lock;
 	spinlock_t lock2;
 	sint	fw_state;	/*shall we protect this variable? */
diff --git a/drivers/staging/rtl8712/rtl871x_recv.h b/drivers/staging/rtl8712/rtl871x_recv.h
index 4aa39f4f3b84..1c8298bde033 100644
--- a/drivers/staging/rtl8712/rtl871x_recv.h
+++ b/drivers/staging/rtl8712/rtl871x_recv.h
@@ -37,7 +37,6 @@ struct smooth_rssi_data {
 };
 
 struct rx_pkt_attrib {
-
 	u8	amsdu;
 	u8	order;
 	u8	qos;
diff --git a/drivers/staging/rtl8712/sta_info.h b/drivers/staging/rtl8712/sta_info.h
index d042d900f30c..9b7e5ffa380d 100644
--- a/drivers/staging/rtl8712/sta_info.h
+++ b/drivers/staging/rtl8712/sta_info.h
@@ -36,7 +36,6 @@ struct wlan_acl_pool {
 };
 
 struct	stainfo_stats {
-
 	uint	rx_pkts;
 	uint	rx_bytes;
 	u64	tx_pkts;
-- 
2.25.1

