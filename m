Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2972C3A4F2C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 15:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhFLOAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 10:00:50 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:46940 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhFLOAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 10:00:49 -0400
Received: by mail-io1-f53.google.com with SMTP id b14so19579654iow.13
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 06:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=himBjQKtq4rWlc/v9yNLPdlT7s2MvK1OSVhcMGgSEBU=;
        b=ZxVsBil9YsJlisWXXU9+tXyw9zjxbqVO58KRicpvNsRFXG40lqnvNHOFOxqrMBcfzH
         iNmTEeVMSg/FJvewUt5Txdpd+fok5jKQo21sYt+wEN8Kr2wiN1dM3DYPggk5JBrlhjOr
         0yyxNtVKeOWpAQuvhQVFrKiyXavuy6OXBVzNAYsKqFfWgzn3OD2XC9dJgI/xSovfI+g2
         ADzydnqU+UvyR0BMCPG0fCEmkp0dHv70HnmFq9C1HzyKgbdyWd+zR2/1uhVQ8R0vhfy+
         q0mjDgbErJgkkZo8oZjC5eXqFgvEDfkAuzYd+J6x3kCrwW/8fSGpOnmIo1vV6aZRatT7
         uLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=himBjQKtq4rWlc/v9yNLPdlT7s2MvK1OSVhcMGgSEBU=;
        b=BVk38hzOyiWpEOPzYLjo1gcQlQ+6ku47m5o6mAVBsCJHAvFDyJ1OECpkbLi/1Lwgya
         4kUqdCNt+W/+j4hm189QotN32YaJXCyfgQAPtKc+aB2rz4vHNITgeoYo7teXb47rMR1E
         r5CpxvX2OH1vD4T7BWxQeMCtlu/YK7OFJ5XCKuZN51ESvKTmQwxkeUqUqhwuUjh6BE/G
         ZFH1TIBRBFS+kZ4Pmwu/6keRGcFMsywjHALc1f+SYwGN5DGEq9d8fk8cq40ySZkliXzI
         j+OcE4O5QFxwr1p476SmClWLtoCY2iJFGylWVh4KXgV7meQ4TaNSdvQkbxIHsppSp6Sa
         2POQ==
X-Gm-Message-State: AOAM531GMWi2QFqFfpCJJqjLBDSVwQCgaooko6bdOJMohXt8J3J6uANB
        KSStltgwLD+X/OKu4h8/Hsoyn78rOQgFJA96
X-Google-Smtp-Source: ABdhPJzE0mf0zYYusr1qAKAcVGd97Ng2OSvQTtraMUG7rE+MYv0LAt6XAlBsWfH767pEF80H8rIs+Q==
X-Received: by 2002:a5e:8e03:: with SMTP id a3mr7205454ion.116.1623506259839;
        Sat, 12 Jun 2021 06:57:39 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id r11sm5021172ilm.23.2021.06.12.06.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 06:57:39 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     subashab@codeaurora.org, stranche@codeaurora.org,
        davem@davemloft.net, kuba@kernel.org
Cc:     lkp@intel.com, bjorn.andersson@linaro.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/1] net: qualcomm: rmnet: always expose a few functions
Date:   Sat, 12 Jun 2021 08:57:36 -0500
Message-Id: <20210612135736.3414477-1-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent change tidied up some conditional code, avoiding the use of
some #ifdefs.  Unfortunately, if CONFIG_IPV6 was not enabled, it
meant that two functions were referenced but never defined.

The easiest fix is to just define stubs for these functions if
CONFIG_IPV6 is not defined.  This will soon be simplified further
by some other development in the works...

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 75db5b07f8c39 ("net: qualcomm: rmnet: eliminate some ifdefs")
Signed-off-by: Alex Elder <elder@linaro.org>
---
 .../net/ethernet/qualcomm/rmnet/rmnet_map_data.c  | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
index d4d23ab446ef5..8922324159164 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
@@ -188,6 +188,14 @@ rmnet_map_ipv6_dl_csum_trailer(struct sk_buff *skb,
 		return -EINVAL;
 	}
 }
+#else
+static int
+rmnet_map_ipv6_dl_csum_trailer(struct sk_buff *skb,
+			       struct rmnet_map_dl_csum_trailer *csum_trailer,
+			       struct rmnet_priv *priv)
+{
+	return 0;
+}
 #endif
 
 static void rmnet_map_complement_ipv4_txporthdr_csum_field(void *iphdr)
@@ -258,6 +266,13 @@ rmnet_map_ipv6_ul_csum_header(struct ipv6hdr *ipv6hdr,
 
 	rmnet_map_complement_ipv6_txporthdr_csum_field(ipv6hdr);
 }
+#else
+static void
+rmnet_map_ipv6_ul_csum_header(void *ip6hdr,
+			      struct rmnet_map_ul_csum_header *ul_header,
+			      struct sk_buff *skb)
+{
+}
 #endif
 
 static void rmnet_map_v5_checksum_uplink_packet(struct sk_buff *skb,
-- 
2.27.0

