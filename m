Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C11232CC48
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 07:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbhCDF7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 00:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234505AbhCDF7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 00:59:49 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA63C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 21:59:09 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id c16so6043515ply.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 21:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Id5BCIAdEAw9kvv1oTI4WoBnYjlfumhW6rcJtR1/p80=;
        b=MjFRX9uqMmt4hp4Ip00iBEz7h/4FW+ZL7kPbVl9KTaHpznt3G3DnBrCDdDUTHX82Sy
         rmltWhdUf6IpRf+p3jpbpGQFAnBIBVs3LptOeZwfEgQR1XHgF6OlEpV+hVLzYUOQdhsK
         W4rokGimrFs4ZXM6TcRfsCCYMRIn1OBdznKKw5wv9BBA+RpuPmxPB2YZUJerOgvOoRzY
         5Cy8urdxIx+KCAKlADIfWeJAS4rdYS4mVaqysTFIyKFrke+yzjBMz0Z0aVD1thmRQc2O
         Sm6QKIXnXTVGd1W4gKJGSC+J4Qd67uwmHIbOGSXFOLhLr/hhI5/E4yPq2R2aIJFm/WV3
         Mxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Id5BCIAdEAw9kvv1oTI4WoBnYjlfumhW6rcJtR1/p80=;
        b=S/VIWYhXb6vAuZ918msOXyDRWanZB1bYf9dAPuPus+HHsRq4aRlqwGd/N4L6DD+cHk
         53fHZyxErPP5/z5LNGV8iCICvBUPXkq4zc0HUotnFPLw6Xl93yTw9JiTIT+WEQ7yvTKJ
         D//D+zutZDDycjVYchXIK/tj0qUGaRQEuA1ZJrl8GBYt8/UdSmhCBsA7GfCExYhaEPXQ
         JrNx71ujvV0koX2Gkq5+9oikb7yz+nnrSbtdQmk+iw9JskNpCJ9SnNIE2zLmhgOliXyu
         +AwLui5qmqNt3FL+4phjSR1CA1/o7VOJWwZa5JcRJZoQRuj/hMTjz6Eoe2kfktODPOZq
         L2Fg==
X-Gm-Message-State: AOAM533EuKEJ3ElOuTYM4Wc/WhqZknXTi5H7Lo4p5AZ2LeFGD2XpOpaA
        nW+fK6LzUo2aVx+dEv3g43eEPA==
X-Google-Smtp-Source: ABdhPJx2lKVwf32ybpR0Wf6LWK0x0vIAD4OQg/cHZikJQ8X0t/iCmS1Rzsk2oiLi0N2Grsm5pjqsvA==
X-Received: by 2002:a17:902:ed8d:b029:e2:b3fb:ca95 with SMTP id e13-20020a170902ed8db02900e2b3fbca95mr2556977plj.17.1614837549280;
        Wed, 03 Mar 2021 21:59:09 -0800 (PST)
Received: from x1.hsd1.or.comcast.net ([2601:1c0:4701:ae70:a76a:a553:bfca:caa6])
        by smtp.gmail.com with ESMTPSA id g24sm17987313pfk.216.2021.03.03.21.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 21:59:08 -0800 (PST)
From:   Drew Fustini <drew@beagleboard.org>
To:     Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-sctp@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Drew Fustini <drew@beagleboard.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
Subject: [PATCH] net: sctp: trivial: fix typo in comment
Date:   Wed,  3 Mar 2021 21:55:49 -0800
Message-Id: <20210304055548.56829-1-drew@beagleboard.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo of 'overflow' for comment in sctp_tsnmap_check().

Reported-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Drew Fustini <drew@beagleboard.org>
---
 net/sctp/tsnmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/tsnmap.c b/net/sctp/tsnmap.c
index a9c6af5795d8..5ba456727f63 100644
--- a/net/sctp/tsnmap.c
+++ b/net/sctp/tsnmap.c
@@ -75,7 +75,7 @@ int sctp_tsnmap_check(const struct sctp_tsnmap *map, __u32 tsn)
 		return 1;
 
 	/* Verify that we can hold this TSN and that it will not
-	 * overlfow our map
+	 * overflow our map
 	 */
 	if (!TSN_lt(tsn, map->base_tsn + SCTP_TSN_MAP_SIZE))
 		return -1;
-- 
2.27.0

