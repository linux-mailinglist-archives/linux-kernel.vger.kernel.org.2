Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6349837BA21
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 12:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhELKNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 06:13:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52862 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhELKNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 06:13:12 -0400
Received: from mail-pj1-f70.google.com ([209.85.216.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1lglqU-0000ef-RZ
        for linux-kernel@vger.kernel.org; Wed, 12 May 2021 10:12:02 +0000
Received: by mail-pj1-f70.google.com with SMTP id k12-20020a17090aaa0cb029015cf15dc26dso790608pjq.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 03:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AXmw//E0cZdgl8Tn4xq6+XBH5BKJOxpePBPkJ3f+YAM=;
        b=rHPo3rgdEhJyKODeI/pSKzSauBeBDoGE68jG1KiRQPK/8B2imsTYK3ABScHCs+9/bl
         9/dzIkJFmLf8jjE8wvohxxRtMEH7Cr8uwyPfpnxWYGG7F6MwJyUL2nh8KDCIoDbMTli3
         FEbScq29Yw8zOIaBs6BlwD0tgfpwm6twYk4XN7QTEhLuY8SG6X9oE/i8Qy+VxsxMPOwY
         vvZxzXE6M2/f+ppo1Zqrzy36HoDys3gqd1BatriwE9LN51QGwGcc5SYuBfdFqpVjrilN
         2ofNC4y1Y4DbaJCC7Zmx2ZPUfj/Yp4GOggM9IJdrW9F9Vj6hPV0AMHk1w6HHxu2Vzgtm
         iNIQ==
X-Gm-Message-State: AOAM532zG2PFy/FKJNnXHTaTdLnIP/LMLcs1tudltftUNjF92JPobE+/
        5cQnFrQ76h+s5gkkMomFmsbst1MAiENkcQrwGA3N4NBcvDwSGVV4up+Sp7VyYSIKEWTLsp/ekIc
        zrZ65rMQlUGxCiJSHJWe1Yy6TnBRTmVL42EAGjHSc
X-Received: by 2002:a17:902:8ecc:b029:ef:6471:dc08 with SMTP id x12-20020a1709028eccb02900ef6471dc08mr6946024plo.5.1620814321473;
        Wed, 12 May 2021 03:12:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAFHv/wAAw04sOry2MoS6JedWkQCIzLRyNuIcNOSfo37hrDNzl5i5/K5d02VIM8W0Tay4fgg==
X-Received: by 2002:a17:902:8ecc:b029:ef:6471:dc08 with SMTP id x12-20020a1709028eccb02900ef6471dc08mr6946007plo.5.1620814321128;
        Wed, 12 May 2021 03:12:01 -0700 (PDT)
Received: from Phocidae.taipei.internal (61-220-137-38.HINET-IP.hinet.net. [61.220.137.38])
        by smtp.gmail.com with ESMTPSA id a79sm6946272pfa.166.2021.05.12.03.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 03:11:59 -0700 (PDT)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     shuah@kernel.org, kuba@kernel.org, davem@davemloft.net,
        skhan@linuxfoundation.org
Subject: [PATCHv2] selftests: xfrm: put cleanup code into an exit trap
Date:   Wed, 12 May 2021 18:11:31 +0800
Message-Id: <20210512101131.45306-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the xfrm_policy.sh script gets terminated by any reason, the netns
namespace files created by the test will be left alone.

In this case a second attempt to run this test will fail with:
  # Cannot create namespace file "/run/netns/ns1": File exists

Move the netns cleanup code into an exit trap so that we can ensure
these files will be removed in the end.

Changes in V2:
  - Update commit message and patch title.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/net/xfrm_policy.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/xfrm_policy.sh b/tools/testing/selftests/net/xfrm_policy.sh
index bdf450e..bb4632b 100755
--- a/tools/testing/selftests/net/xfrm_policy.sh
+++ b/tools/testing/selftests/net/xfrm_policy.sh
@@ -28,6 +28,11 @@ KEY_AES=0x0123456789abcdef0123456789012345
 SPI1=0x1
 SPI2=0x2
 
+cleanup() {
+    for i in 1 2 3 4;do ip netns del ns$i 2>/dev/null ;done
+}
+trap cleanup EXIT
+
 do_esp_policy() {
     local ns=$1
     local me=$2
@@ -481,6 +486,4 @@ check_hthresh_repeat "policies with repeated htresh change"
 
 check_random_order ns3 "policies inserted in random order"
 
-for i in 1 2 3 4;do ip netns del ns$i;done
-
 exit $ret
-- 
2.7.4

