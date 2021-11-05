Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEC8446685
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 16:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbhKEP6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 11:58:15 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:56160
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232537AbhKEP6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 11:58:14 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1D8E94000F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 15:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1636127733;
        bh=bkK6gTfKiBQfKNtHU6pcGHzhWJk/mu2xTUMLvC1SmhU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=uaFilYUeN9rfFMUVYquRN1HDDxnXSGdp5rSoHLlg/xV0JhkAvnHNZwyDTS7iivB7B
         aVkAsjz98Yu9mv5hIFbaaIoiqxpWsvyFY2g23SUDdPVIJrvRXXzZ8sqaELeDc9q+wR
         kD5Yaudk27M5n3Zqcdd8kRVUlHW/nMIYzNk9MEjdkPF4fDdnc95g6vs++NG1sWQM3F
         hpxMylFRRVHwzMRyXYIzZmntJM4vZgZGk71tzSDWGKgIXNvd1oNskkaSq7vvJtNnMh
         v2wG+EGPB4ra22d/Hla8zuDskqLnC9NVkZNTnZLUtosc67CzrWGDc5lIi2MwCDxnmx
         kLV4YW0aNnxUw==
Received: by mail-ed1-f71.google.com with SMTP id d11-20020a50cd4b000000b003da63711a8aso9210249edj.20
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 08:55:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bkK6gTfKiBQfKNtHU6pcGHzhWJk/mu2xTUMLvC1SmhU=;
        b=hZfv00Y2MiLCkvyXuMsrFp4Q8Et+WgfPBNMbShWTVjg28HM4crgUYwJmYgPJe2cF0w
         YPBSxWGHTuK53afhSr8SvPUg+EHobCRrHf3jfCbV9j8fEP3jbBV1ULrMGFZZ55dP20KQ
         YD2D3auQqPTPY/x7yU6m4pQyYbw1SYI0/UI4tD1OtNm53xGkQ4wRKXcWFbUcxbb4ut9m
         +E3CBuuiK+5HZHw4aBighLlLzANYMAAUMgunDMDlyMBPiPHODscLLyPzF5awZz7MzqV5
         L/zGDZaQZsyYU7WXZbVl8WctxmQ7BTr+0XmkhCaM0T+TF3Gxt3NR0TOIPtJl4n5lZlLi
         OfpA==
X-Gm-Message-State: AOAM533JZ8VWTm+9EMjLn72ubUbnSDaTiurTwVTI3v2/bjzv/1uHtFoQ
        72R3UtdfUixQpsEiEQVRnbpAqX5eo4kZgYno4tNqK+OWf6VGCmOsAGDwhaXCpMGRvlEkXEsiYec
        xoWu7Kne7FkfNy4swwuHvgF1hTCRUvkuFdpaz9E26QA==
X-Received: by 2002:a05:6402:40c5:: with SMTP id z5mr6193840edb.185.1636127732800;
        Fri, 05 Nov 2021 08:55:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZv4GqWbag+7ya5gdVD8gpmI5A28DpPxkcj0fSg+twxAqfGbAq4tIApC1T7p0IYdgyFS3uLA==
X-Received: by 2002:a05:6402:40c5:: with SMTP id z5mr6193797edb.185.1636127732493;
        Fri, 05 Nov 2021 08:55:32 -0700 (PDT)
Received: from arighi-desktop.homenet.telecomitalia.it ([2001:67c:1560:8007::aac:c1b6])
        by smtp.gmail.com with ESMTPSA id c22sm1611539edy.66.2021.11.05.08.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:55:32 -0700 (PDT)
From:   Andrea Righi <andrea.righi@canonical.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Alexis Bauvin <abauvin@scaleway.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: net: test_vxlan_under_vrf: fix HV connectivity test
Date:   Fri,  5 Nov 2021 16:55:29 +0100
Message-Id: <20211105155529.105545-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like test_vxlan_under_vrf.sh is always failing to verify the
connectivity test during the ping between the two simulated VMs.

This is due to the fact that veth-hv in each VM should have a distinct
MAC address.

Fix by setting a unique MAC address on each simulated VM interface.

Without this fix:

 $ sudo ./tools/testing/selftests/net/test_vxlan_under_vrf.sh
 Checking HV connectivity                                           [ OK ]
 Check VM connectivity through VXLAN (underlay in the default VRF)  [FAIL]

With this fix applied:

 $ sudo ./tools/testing/selftests/net/test_vxlan_under_vrf.sh
 Checking HV connectivity                                           [ OK ]
 Check VM connectivity through VXLAN (underlay in the default VRF)  [ OK ]
 Check VM connectivity through VXLAN (underlay in a VRF)            [FAIL]

NOTE: the connectivity test with the underlay VRF is still failing; it
seems that ARP requests are blocked at the simulated hypervisor level,
probably due to some missing ARP forwarding rules. This requires more
investigation (in the meantime we may consider to set that test as
expected failure - XFAIL).

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 tools/testing/selftests/net/test_vxlan_under_vrf.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/test_vxlan_under_vrf.sh b/tools/testing/selftests/net/test_vxlan_under_vrf.sh
index 534c8b7699ab..ea5a7a808f12 100755
--- a/tools/testing/selftests/net/test_vxlan_under_vrf.sh
+++ b/tools/testing/selftests/net/test_vxlan_under_vrf.sh
@@ -101,6 +101,8 @@ setup-vm() {
     ip -netns hv-$id link set veth-tap master br0
     ip -netns hv-$id link set veth-tap up
 
+    ip link set veth-hv address 02:1d:8d:dd:0c:6$id
+
     ip link set veth-hv netns vm-$id
     ip -netns vm-$id addr add 10.0.0.$id/24 dev veth-hv
     ip -netns vm-$id link set veth-hv up
-- 
2.32.0

