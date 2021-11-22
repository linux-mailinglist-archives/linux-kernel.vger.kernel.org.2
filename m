Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0024C458F2A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 14:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbhKVNNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 08:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbhKVNNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 08:13:43 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B18C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 05:10:37 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id p4so17983029qkm.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 05:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+PnC8Q/2hoId1m9hye9rp84tP4YYq89c/x16u1wHuFM=;
        b=PPMyp7kYd+NLYf06P+27pAK8/eb/WAO4+jZmPPIWlkits3mBuFI3cfiyFeymoThetT
         y27pqncW/0GFX1FFrUUPrb7MGpp/JnOBuZVpk45v/v3yOziPbRBNHLjWalRH0BUdH7Go
         +J3gA8072dVZMJcZchDrbSBvJ9NjYNe5LpiiLo8YhiA990wenMYsg9+9V+mjcXhiDeXQ
         hsZt7NFxFcNfFUPbU/sTSXFOf+Ymrc4rBDbl5gXMRHTHtyhVFzkRAO/5/5pFfo/scYDR
         Jx3XmAGSShPJy6HTbtPfaV68TEtHlm7C11MHEykPAh0XNrifhMYZZ1GKpvWNXMTLN1cF
         wXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+PnC8Q/2hoId1m9hye9rp84tP4YYq89c/x16u1wHuFM=;
        b=cJqx+W0Bqq3XjtPkLAgrdOIxu13U+FF7ty87vCntXcRiuUHxHcKeBj9RyVGhaB/sno
         ySwaUYkJVUXiqMSDFzn5foj1Ksvh66oUxnz/hUZVuLM5JHEQo0wqWf9oQVL4NQsH7aBJ
         9W3/PJxwjI6Gfdu4UbJL6a/pw2PYNK71KH7xIivsUfjYvQsa1mjr2Ot4U4UYTDBSPWOq
         bnl5UW/DsiFls/lRTDxHfTg9S9PYiTziqpofCtmKQt/3w04oYMMW6RAf49ImsYYgBgRL
         cl1OKzJUy1FLCjIGF0XjKF0bJJmhxWVnY9n9sN4Z/f9LuJapn6UVCRbcwcEqzp0KNjA2
         CgIg==
X-Gm-Message-State: AOAM533lQumhAXh/HN579DpleC2W9bFSswLBASIGDEMjgSVJ6AiczzPY
        BVqW3HlJFl6OFCZVIIJVFaU=
X-Google-Smtp-Source: ABdhPJxMuj8b4MzbGxSOjAIa521bjob2/X1Tz9+Eowpwui4EVFC9GGJFxoZb3DaeGvko5806WGrJ1A==
X-Received: by 2002:a37:a956:: with SMTP id s83mr48738890qke.422.1637586636295;
        Mon, 22 Nov 2021 05:10:36 -0800 (PST)
Received: from localhost.localdomain ([181.23.85.46])
        by smtp.gmail.com with ESMTPSA id s13sm4651343qki.23.2021.11.22.05.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 05:10:35 -0800 (PST)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH RESEND] staging: vchiq_core: remove superfluous static_assert statement
Date:   Mon, 22 Nov 2021 10:09:26 -0300
Message-Id: <20211122130926.342128-1-gascoar@gmail.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After removing the BITSET_T typedef in commit d8a364820e01 ("staging:
vchiq_core: get rid of typedef") the static_assert statement becomes superfluous
as now we are checking if the size of the u32 type is 4 bytes. Hence, just
remove the static_assert statement.

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index 53a98949b294..55abaf02a196 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -74,8 +74,6 @@
 	((fourcc) >>  8) & 0xff, \
 	(fourcc) & 0xff
 
-static_assert((sizeof(u32) * 8) == 32);
-
 #define BITSET_SIZE(b)        ((b + 31) >> 5)
 #define BITSET_WORD(b)        (b >> 5)
 #define BITSET_BIT(b)         (1 << (b & 31))
-- 
2.34.0.rc0

