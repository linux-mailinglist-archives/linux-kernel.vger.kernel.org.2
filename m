Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931663E1566
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 15:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241634AbhHENLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 09:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbhHENL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 09:11:28 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C45C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 06:11:13 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id yk17so9444748ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 06:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YuTZiK//J9JAwj4PAE08Ebr5Vz170oeRV5G9mQzcF20=;
        b=P+W6LH2gBtT85pYdgfDnKnsj9a7BZd/vMK0QLxTDymVHEMh/nH2OoZ/OnOoaDINqFK
         etABbv7sTQdonN4K7P1uonfzn6cR6yt/iftCbnjS6RYn8MEuNXCQ5TocU1Mjz1JxoiUN
         rpzC0lp4X/qB9QML+TBH8z6+RwolIRFWCKby+Rl0EUNj6/KvvQvKlq4KkRxL3UGxJw1r
         GhA1cjrzbgg/rlDoYrCP+h4UOQJ+ImkAlroD5YUp8cuF5LeUY5aWrIVdRoqke439tTMj
         3vBqMUebKR8IHFCK0mo/CBbkwyetArmYtJgJ/IWhxrt7VWXP1/6b4Tx3pdSHu6wWXwvF
         mQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YuTZiK//J9JAwj4PAE08Ebr5Vz170oeRV5G9mQzcF20=;
        b=W9Vmquf3aQacqOiiRhTLY/Is6DCR6NeDU4txfjChqaGdLkVICP/s/c6rW6q+9BauWC
         z9LGqE2luPt/chgsKMJ2O4kHI/XVsXZXWBva+Vuw1zKD1PP3NlV4x+kuGYZpJOaq6Jmz
         MpkhOBbw+Jx+eTZMpWwqvmpzYnfgH3OgrbA40zNwvXaVAT3bK6Xf6uRK9q2WtddqzxKw
         tRnJl30cb9iLlPiVpD3JPriCF7+qPQuu98QK5HeyhSCM4CkXWCySq09Ya2+KoqUBkLUR
         sv8nln0TELTaFgPVdGvk191nRFN8KoX+inDVMixxjsWE4OeZsmHgsm5gjKkMDd6FUi38
         UlIQ==
X-Gm-Message-State: AOAM532fl6hmGfiJjszFK8FsMZ0RDaETwwnibXMt7VxmI02mwA6jvxgQ
        CHqCx/Leusl+/W3dvv1tNPs=
X-Google-Smtp-Source: ABdhPJwD9ix9lfeQvlComKKmYrqugIKWAfczOqDdQChbDntLD4DZCMZaRNTNQF1239hApg5LvUo9Aw==
X-Received: by 2002:a17:906:b34c:: with SMTP id cd12mr4844963ejb.104.1628169071952;
        Thu, 05 Aug 2021 06:11:11 -0700 (PDT)
Received: from localhost.localdomain (host-82-51-42-96.retail.telecomitalia.it. [82.51.42.96])
        by smtp.gmail.com with ESMTPSA id qa34sm1690363ejc.120.2021.08.05.06.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 06:11:11 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] staging: r8188eu: Fix incorrect types in arguments
Date:   Thu,  5 Aug 2021 15:11:08 +0200
Message-Id: <20210805131108.19775-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC + Sparse emit warnings of passing incorrect type in arguments of 
some functions because of different base types. Fix them by changing 
the types of the parameters of the above-mentioned functions.
In the meantime, remove the unnecessary casts of those arguments
which are then passed to memcpy() within those same functions.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_br_ext.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index 27c8ec3b7d62..e4110d5bc6f2 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -134,37 +134,37 @@ static inline void __nat25_generate_ipv4_network_addr(unsigned char *networkAddr
 }
 
 static inline void __nat25_generate_ipx_network_addr_with_node(unsigned char *networkAddr,
-				unsigned int *ipxNetAddr, unsigned char *ipxNodeAddr)
+				__be32 *ipxNetAddr, unsigned char *ipxNodeAddr)
 {
 	memset(networkAddr, 0, MAX_NETWORK_ADDR_LEN);
 
 	networkAddr[0] = NAT25_IPX;
-	memcpy(networkAddr+1, (unsigned char *)ipxNetAddr, 4);
+	memcpy(networkAddr+1, ipxNetAddr, 4);
 	memcpy(networkAddr+5, ipxNodeAddr, 6);
 }
 
 static inline void __nat25_generate_ipx_network_addr_with_socket(unsigned char *networkAddr,
-				unsigned int *ipxNetAddr, unsigned short *ipxSocketAddr)
+				__be32 *ipxNetAddr, __be16 *ipxSocketAddr)
 {
 	memset(networkAddr, 0, MAX_NETWORK_ADDR_LEN);
 
 	networkAddr[0] = NAT25_IPX;
-	memcpy(networkAddr+1, (unsigned char *)ipxNetAddr, 4);
-	memcpy(networkAddr+5, (unsigned char *)ipxSocketAddr, 2);
+	memcpy(networkAddr+1, ipxNetAddr, 4);
+	memcpy(networkAddr+5, ipxSocketAddr, 2);
 }
 
 static inline void __nat25_generate_apple_network_addr(unsigned char *networkAddr,
-				unsigned short *network, unsigned char *node)
+				__be16 *network, unsigned char *node)
 {
 	memset(networkAddr, 0, MAX_NETWORK_ADDR_LEN);
 
 	networkAddr[0] = NAT25_APPLE;
-	memcpy(networkAddr+1, (unsigned char *)network, 2);
+	memcpy(networkAddr+1, network, 2);
 	networkAddr[3] = *node;
 }
 
 static inline void __nat25_generate_pppoe_network_addr(unsigned char *networkAddr,
-				unsigned char *ac_mac, unsigned short *sid)
+				unsigned char *ac_mac, __be16 *sid)
 {
 	memset(networkAddr, 0, MAX_NETWORK_ADDR_LEN);
 
-- 
2.32.0

