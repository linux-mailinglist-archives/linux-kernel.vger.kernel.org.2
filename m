Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830B83103BD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 04:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhBEDh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 22:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhBEDg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 22:36:27 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39226C0611C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 19:34:49 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w11so147585ybq.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 19:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=RIYGazHKwdiw8rZDp51KX5sbecBkFaXLqVCFGOqV4wU=;
        b=VFDeaWSUgomDUxLAC3wdb5aTGJ97LZERGnGBFBKQ1LFZTue7BSLwZCMOyiugq42rYz
         C5MO2rsuQyHd8xgbUmhsjeJ4qIJf5TEVjqfU+O/lMxDZ8R8ybm4btbA8rsHRadUtGF7T
         aY+TI8ZT7HMSCph4r18yF82O2kk1LTwMnDW/qgx3tS4j94qDtVFtJsDEX9TcUJq7bOEh
         RUwQL1LBx/jeU+wxfmDMcAttkIVektziHifMc7A77m2q+Rg6KpiDOPdCZ6ftMeOvCgFv
         eyIFyiagoe8d43aYVodyVe7K94oAIVETyTC3a8LoZmYSFrAR2TN9XYY1SpAWjQEbGPCs
         W5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RIYGazHKwdiw8rZDp51KX5sbecBkFaXLqVCFGOqV4wU=;
        b=egJeqzzbkmtwmmWDyPnpKksMjn2B5Uy4gGC+csYE5w1Dq+hKzzex8WA6ad0r++Bw3O
         yQik3nIV/kNg+FrLk/Zn0Ye0lED9LLYZfMizH5aWZJ16txTFHedAJxB67/nXK0E6Nx9g
         KNnIn71lQvVkcFva1tUyuSd/x+0DCGIS9xKdEWJMqsPpj3aifRAQUiBMpDKNiIXHX6Za
         9Lr7q9WWj6IRilyrVwVLY8fV6XUD6p5/63BfWN/6NOY8Igk2yZ1GN3u6JxRHFcsSZJea
         KftbedeSsASGC7DtjEZMtsp+8dF3L3dkpbvI5+cwOV3MHbKYloTuZiLkU6igIxtyw/iB
         /oTg==
X-Gm-Message-State: AOAM532qWdF2Ph9zIYi1BnYlq3D7Q6GeQ9m16icJGhBlijOWMwZrBYBp
        6Okn0SnUiVKqH/FelXyjq2iUG/l65MQl
X-Google-Smtp-Source: ABdhPJwNDNmEPnvWeNyiRJve6FpmwifBvfgLKSmsdeq7q10FQrwEuhwekKenfO+9dez4RQk/hq+bkYDvZWve
Sender: "kyletso via sendgmr" <kyletso@kyletso.ntc.corp.google.com>
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:dd94:c753:a81d:c855])
 (user=kyletso job=sendgmr) by 2002:a25:c381:: with SMTP id
 t123mr3653853ybf.299.1612496088518; Thu, 04 Feb 2021 19:34:48 -0800 (PST)
Date:   Fri,  5 Feb 2021 11:34:15 +0800
In-Reply-To: <20210205033415.3320439-1-kyletso@google.com>
Message-Id: <20210205033415.3320439-8-kyletso@google.com>
Mime-Version: 1.0
References: <20210205033415.3320439-1-kyletso@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v6 7/7] usb: typec: tcpm: Get Sink VDO from fwnode
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, hdegoede@redhat.com, robh+dt@kernel.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a079973f462a ("usb: typec: tcpm: Remove tcpc_config
configuration mechanism") removed the tcpc_config which includes the
Sink VDO and it is not yet added back with fwnode. Add it now.

Signed-off-by: Kyle Tso <kyletso@google.com>
---
Changes since v5:
- no change

 drivers/usb/typec/tcpm/tcpm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index b45cd191a8a4..be0b6469dd3d 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -5722,6 +5722,20 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 			port->new_source_frs_current = frs_current;
 	}
 
+	/* sink-vdos is optional */
+	ret = fwnode_property_count_u32(fwnode, "sink-vdos");
+	if (ret < 0)
+		ret = 0;
+
+	port->nr_snk_vdo = min(ret, VDO_MAX_OBJECTS);
+	if (port->nr_snk_vdo) {
+		ret = fwnode_property_read_u32_array(fwnode, "sink-vdos",
+						     port->snk_vdo,
+						     port->nr_snk_vdo);
+		if (ret < 0)
+			return ret;
+	}
+
 	return 0;
 }
 
-- 
2.30.0.365.g02bc693789-goog

