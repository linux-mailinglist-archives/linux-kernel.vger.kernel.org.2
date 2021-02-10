Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE3F315CD4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbhBJCD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbhBJApw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 19:45:52 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD32C0617A9
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 16:42:35 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id r21so244435otk.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 16:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ZnFgpWZW/pibsdLxTLSbnISeByhzyHarQxXUqXKzeg=;
        b=hItZCUkUv3hVP0EKFKWGCHiq7LK6jTKvkwxQLRTVv+G2duyo63PGIc8YpI3DXE6v6Q
         93/TWf1dv1X8blaa5DeXeJ06ryE89D1TQkJDMHeu8+4PcwShh/BskEUrk4FnAjGukA1/
         b6mCu9NEcGcDsOJPB1nb3PYD86+w1ds5Zeedg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ZnFgpWZW/pibsdLxTLSbnISeByhzyHarQxXUqXKzeg=;
        b=KlnN2tJ1Mmtps/cNd3RISTiDNppKHODrzDoQsfQn4uJrZsBeGGsvIZwqF0ipjAisCo
         825v58TouH+1jKHBP3U+A/GPKBCGuwvVz8pR9eMzL1GERowpSxsJyfRKpYzGmMsjg+8l
         Uiv7dv2zvPCkbqgcfTTGLBsDaSlmx13QNXa6dotf0oxyC3tGOoD8yV0l6aO7L1oUMV2n
         hCoAGfiDAMXEXvhSYF5QedftPwtiveDlYD0sMAGg40yv1r7+vmUdjBYTX4ggdRjjRFL2
         CCg+ZXMomQE7VYeBIFS/kpTb4tjDHD0bXO0ZmlmIodRiWUDo5KySV3sSOPWIV3I93d0b
         Y4WA==
X-Gm-Message-State: AOAM533uetfuBYkvVlPS5PqukjZsDkpaP/oaRQSW7gsfh22g1mXwd3+A
        47PZ9gY5enFqLHBQLbA2Ub6UDg==
X-Google-Smtp-Source: ABdhPJweKOk0U05wNNP7z8KOUn9C3PAmUn3jmo0QzHPBvGkR1giuIk30fNASdJrHyDRZtCLGpIiDCQ==
X-Received: by 2002:a9d:4e2:: with SMTP id 89mr259973otm.140.1612917755107;
        Tue, 09 Feb 2021 16:42:35 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s123sm103060oos.3.2021.02.09.16.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 16:42:34 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] ath10k: change ath10k_offchan_tx_work() peer present msg to a warn
Date:   Tue,  9 Feb 2021 17:42:24 -0700
Message-Id: <3b1f71272d56ee1d7f567fbce13bdb56cc06d342.1612915444.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1612915444.git.skhan@linuxfoundation.org>
References: <cover.1612915444.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the comment block in this function and the FIXME for this, peer
being present for the offchannel tx is unlikely. Peer is deleted once tx
is complete. Change peer present msg to a warn to detect this condition.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath10k/mac.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index e815aab412d7..53f92945006f 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -3954,9 +3954,8 @@ void ath10k_offchan_tx_work(struct work_struct *work)
 		spin_unlock_bh(&ar->data_lock);
 
 		if (peer)
-			/* FIXME: should this use ath10k_warn()? */
-			ath10k_dbg(ar, ATH10K_DBG_MAC, "peer %pM on vdev %d already present\n",
-				   peer_addr, vdev_id);
+			ath10k_warn(ar, "peer %pM on vdev %d already present\n",
+				    peer_addr, vdev_id);
 
 		if (!peer) {
 			ret = ath10k_peer_create(ar, NULL, NULL, vdev_id,
-- 
2.27.0

