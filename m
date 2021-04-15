Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6073C360322
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 09:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhDOHTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 03:19:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35482 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhDOHTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 03:19:02 -0400
Received: from mail-pg1-f199.google.com ([209.85.215.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1lWwGs-00037B-Mz
        for linux-kernel@vger.kernel.org; Thu, 15 Apr 2021 07:18:38 +0000
Received: by mail-pg1-f199.google.com with SMTP id g5-20020a63f4050000b02901f6c7b9a6d0so948967pgi.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 00:18:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5R2UEdalYH+QJwAiSQKftUG6+6vnMGSX5LzgwS8fZTU=;
        b=oEDx9J//GtiA7bogzT/k6pNRRtcWSfZ5nQU092UVeeVjOIntU56+Bj5ifb7l6yCvkv
         3F8JwY0XZNMFsZ2CwDOtfQ/wSyocPCPWgArt2PJWDa2ayCb3K9DH+SuARYNY7xSjZQ2S
         69eJxvA191Z5hBAwUCRgzLaquL07XwXMB4kZmCupo2vITgnK4Rho9ot01ryv4nqh1uZe
         SJseytWh1XtEqAI3Aa1Varf9mQHxoKU9CGGsad8HSjV8ot1JaBI4ULFwjz1ZKvVEF60W
         cdWcaVqtv6RHRtNDKI4TWYVNhXYLu+yLKM3eJ6rvLZqeFXIec+PocaHV5QPMf+gIJ9H/
         ZLyw==
X-Gm-Message-State: AOAM533QlP4ZdO0HHwv341HELUNr37S6h8wy3oB6RMyN7VsQVbteaJbG
        rCIcavzM+eJ4MRx7qywGhySXYbgHLran74S1PdH0DcW72obMxYohWUZ+iq/KFBR6YfStC5shR8+
        7nmupISd+QWwDgSPp0zR31TnZ1uy/u8xXyYJauYrn
X-Received: by 2002:a62:5cc3:0:b029:203:54be:e4c9 with SMTP id q186-20020a625cc30000b029020354bee4c9mr1955790pfb.80.1618471117357;
        Thu, 15 Apr 2021 00:18:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzulbQcEb+SL0c0oEOvqz6I23syA3ZKRAT/SnGjUswHi0aNKxnJZy3J42T0G5Q7Z+0TGkGXEA==
X-Received: by 2002:a62:5cc3:0:b029:203:54be:e4c9 with SMTP id q186-20020a625cc30000b029020354bee4c9mr1955745pfb.80.1618471116517;
        Thu, 15 Apr 2021 00:18:36 -0700 (PDT)
Received: from Leggiero.taipei.internal (114-136-27-149.emome-ip.hinet.net. [114.136.27.149])
        by smtp.gmail.com with ESMTPSA id h7sm1283475pfo.44.2021.04.15.00.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 00:18:35 -0700 (PDT)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     shuah@kernel.org, davem@davemloft.net
Subject: [PATCH] selftests: xfrm: put cleanup code into a exit trap
Date:   Thu, 15 Apr 2021 15:18:23 +0800
Message-Id: <20210415071823.29091-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the xfrm_policy.sh script takes longer than the default kselftest
framework 45 seconds timeout to run, it will be terminated and thus
leave those netns namespace files created by the test alone.

In this case a second attempt will fail with:
  # Cannot create namespace file "/run/netns/ns1": File exists

It might affect the outcome of other tests as well.

Move the netns cleanup code into an exit trap so that we can ensure
these namespace files will be removed after the test.

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

