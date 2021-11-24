Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927CD45D0EA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 00:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345951AbhKXXQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 18:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344034AbhKXXQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 18:16:50 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A30BC06173E
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 15:13:40 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id k4so3082748plx.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 15:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=crfmL1J6lNLWpnWCWXe3wcSd/BVJQ67tS3gvAa/yZ9k=;
        b=CJTj/xgmNxZ3D75A0X2jyMsMkrSTFZj+f+vK9T04i4SSA9SulyowzIs7iwE7ogIPBp
         wp0IzcRdZyK3t/8nrDqQQC+dLMmfr6N+d8vKjAxLPFkVfMMXoVUObvAxQWzSBk5aGD7e
         t2/OpKxzd6tQTtFDjO8M2uaTrSmSPaT6j7Pws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=crfmL1J6lNLWpnWCWXe3wcSd/BVJQ67tS3gvAa/yZ9k=;
        b=aVq7i3oMppusUOc7DIuQjkxJXdpwmR9oQVhTBqKX6vvGjUMhirgki+WpMgHW6Ht7lz
         Ey5F+m1HBKTS74XjtoS5U3hGNW26/TXZpOkivjGj3Hthev56058lzX0d1Q1PNGfnjp7M
         x/9nr9746R5PCmvhSl2F2xQ7+syx17nOcDOrrKqXBtjk4bHlIFm2zbWNBMHYipZRlf3y
         bMVXvZPkl5nM2v12VaSmH4yT4Wg82WVgmhhVAoRuLgESQLgOQ1NvFIOBAfrcaJh7Xxnb
         KGGln2rDtts6t0mmMnkXkedbjVPSl6759wWGG2Pgm0AO0obNuaahy/2g4deIwoN5vGg7
         MeGg==
X-Gm-Message-State: AOAM530QjMA42YcTlWrQYZO5qCOHI4J7oEVTdr4ON9pdSiu6HF96/Mb3
        tGLhwpssi2jOQdgc9/7nWPD4I+kKTLcH7g==
X-Google-Smtp-Source: ABdhPJwlSMYGZvrizyh+vZims2TLlvTVoP1eP2z8MqzlHVbYSDf+4IcIcxbIMzTPxghHMqjLpykWug==
X-Received: by 2002:a17:903:10d:b0:142:6343:a48e with SMTP id y13-20020a170903010d00b001426343a48emr23518670plc.29.1637795619570;
        Wed, 24 Nov 2021 15:13:39 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:6bc9:896a:9df2:5d61])
        by smtp.gmail.com with ESMTPSA id nn15sm5783296pjb.11.2021.11.24.15.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 15:13:39 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     wonchung@google.com, bleung@chromium.org,
        heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rajat Jain <rajatja@google.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 3/4] usb: Link the ports to the connectors they are attached to
Date:   Wed, 24 Nov 2021 15:10:12 -0800
Message-Id: <20211124231028.696982-4-pmalani@chromium.org>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
In-Reply-To: <20211124231028.696982-1-pmalani@chromium.org>
References: <20211124231028.696982-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Creating link to the USB Type-C connector for every new port
that is added when possible.

Originally submitted as commit 63cd78617350 ("usb: Link the ports to the
connectors they are attached to") but later reverted in
commit 5bdb080f9603 ("Revert "usb: Link the ports to the connectors they
are attached to"") due to a cyclic module dependency, which has since
been resolved.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 Documentation/ABI/testing/sysfs-bus-usb | 9 +++++++++
 drivers/usb/core/port.c                 | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/testing/sysfs-bus-usb
index 2ebe5708b4bc..a017cf610d9b 100644
--- a/Documentation/ABI/testing/sysfs-bus-usb
+++ b/Documentation/ABI/testing/sysfs-bus-usb
@@ -244,6 +244,15 @@ Description:
 		is permitted, "u2" if only u2 is permitted, "u1_u2" if both u1 and
 		u2 are permitted.
 
+What:		/sys/bus/usb/devices/.../(hub interface)/portX/connector
+Date:		April 2021
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Link to the USB Type-C connector when available. This link is
+		only created when USB Type-C Connector Class is enabled, and
+		only if the system firmware is capable of describing the
+		connection between a port and its connector.
+
 What:		/sys/bus/usb/devices/.../power/usb2_lpm_l1_timeout
 Date:		May 2013
 Contact:	Mathias Nyman <mathias.nyman@linux.intel.com>
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index 53a64ce76183..83f5eac6691c 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -585,6 +585,7 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 	}
 
 	find_and_link_peer(hub, port1);
+	typec_link_port(&port_dev->dev);
 
 	/*
 	 * In some cases, the Type C port gets registered later, so
@@ -637,5 +638,6 @@ void usb_hub_remove_port_device(struct usb_hub *hub, int port1)
 	peer = port_dev->peer;
 	if (peer)
 		unlink_peers(port_dev, peer);
+	typec_unlink_port(&port_dev->dev);
 	device_unregister(&port_dev->dev);
 }
-- 
2.34.0.rc2.393.gf8c9666880-goog

