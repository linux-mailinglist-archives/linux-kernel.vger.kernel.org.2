Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778403A8C76
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 01:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbhFOX3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 19:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbhFOX3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 19:29:15 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C660C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 16:27:09 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id q5-20020a9d66450000b02903f18d65089fso604984otm.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 16:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5BxCx4oYVoVQnmCG+AUeVFZ5uMxoQG7o5BoWKZiHpDM=;
        b=FIfz3Y+gcmLkxkp0J511fi/2vZATq207eg5N+rpcpZpim3PzFIbfaWTDx+qG7YTO1z
         KJrOGb+j+W+riqK4GlvW7TyfMrjYk1jTUrO4UFyodp2+jbGnMC9Ly5XHX9QiXMYaQzek
         61a1q//DLamZInN2Rg2Oi4S23ed2TFHRVbwod6b78fUhoHExMHNrvzcLGlRYxanzkL7R
         x4s0aKGdA8CN596T1xVZiTRwvhe/zXjDDOSreeyue+T0typrQHjumQj+6yiUjaeMbZam
         oZKMMyTUddCXRsTvPRWX4drF7taBzRHq8PHLYEa5dbc/QhKE7C6CICMELxqPM5Rzjg/p
         Jxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5BxCx4oYVoVQnmCG+AUeVFZ5uMxoQG7o5BoWKZiHpDM=;
        b=qHKALnYrLlrL4uyt5prBKL61xhOCyn847E6nes/6HWAbp+gSShe14+DT2w/W2LjMm0
         +UvcW9XGG7R88+hJX3mfzLFcDXBE19afzCNNIGhck3OcmgX1WtlUKUwVpZdrBVQtYR1G
         0zaoo4KqymRxto+qL53IDUW2Z5Y4bb+2U0qS+AgGKdpKGDfR1DoCFeL+md6YD4CoJ690
         xWOkcg9HsOrUEvwA1yvyIIQjTe+jLZOe7D+fmATKjPTogQEkLJKWqAjB1Lqa2QFv2FSe
         uNkjT+85gk1UDfLDfyfPUjQP9lawldu30VEkD7ekXIAKxJjtPrGsqCkoxds3lM5au48r
         5a8Q==
X-Gm-Message-State: AOAM532/yseHIKSDRdhEecFMbgzTTnribccCIROCQ4rbe0qBSr6TmCIb
        5XqQuJYApRYFSJpxCh4XIzD77g==
X-Google-Smtp-Source: ABdhPJzgpyD7sHOuZrD3iMyiX4hXHsL5Z8m86PS01uKPkw9aNGtRYpGDTfhpgujcrT1Wqpj26fUtBw==
X-Received: by 2002:a9d:6f88:: with SMTP id h8mr1297762otq.73.1623799628214;
        Tue, 15 Jun 2021 16:27:08 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w20sm105997otl.51.2021.06.15.16.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 16:27:07 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>,
        Sean Tranchetti <stranche@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Alex Elder <elder@linaro.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: qualcomm: rmnet: Allow partial updates of IFLA_FLAGS
Date:   Tue, 15 Jun 2021 18:27:07 -0500
Message-Id: <20210615232707.835258-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The idiomatic way to handle the changelink flags/mask pair seems to be
allow partial updates of the driver's link flags. In contrast the rmnet
driver masks the incoming flags and then use that as the new flags.

Change the rmnet driver to follow the common scheme, before the
introduction of IFLA_RMNET_FLAGS handling in iproute2 et al.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Also do the masking dance on newlink, per Subash request
- Add "net-next" to subject prefix

 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
index 8d51b0cb545c..27b1663c476e 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
@@ -163,7 +163,8 @@ static int rmnet_newlink(struct net *src_net, struct net_device *dev,
 		struct ifla_rmnet_flags *flags;
 
 		flags = nla_data(data[IFLA_RMNET_FLAGS]);
-		data_format = flags->flags & flags->mask;
+		data_format &= ~flags->mask;
+		data_format |= flags->flags & flags->mask;
 	}
 
 	netdev_dbg(dev, "data format [0x%08X]\n", data_format);
@@ -336,7 +337,8 @@ static int rmnet_changelink(struct net_device *dev, struct nlattr *tb[],
 
 		old_data_format = port->data_format;
 		flags = nla_data(data[IFLA_RMNET_FLAGS]);
-		port->data_format = flags->flags & flags->mask;
+		port->data_format &= ~flags->mask;
+		port->data_format |= flags->flags & flags->mask;
 
 		if (rmnet_vnd_update_dev_mtu(port, real_dev)) {
 			port->data_format = old_data_format;
-- 
2.31.0

