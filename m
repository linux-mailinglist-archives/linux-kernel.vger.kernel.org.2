Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B90357581
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 22:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355949AbhDGUH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 16:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355937AbhDGUHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 16:07:50 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A77C0613DE
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 13:07:37 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d127so1462712ybc.17
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 13:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=t6Wz/CVZhwgzgH8yLnIu+vnyKNs6ZhIxtjweGyR/2B8=;
        b=FSC2jYpPA82SAAkfv1hMUNBohzVcc7Th6hrXiJqSgER6+jeR4Ccx4adLo9Hn+SW1hu
         cwAAscw+AetobhNdNh+yBc5og9bElI6Iz/RcobSM1X19YTxv8AG8RM28QDvqCnRcaJJB
         fJPctp+wQlmCDQ6ck64VOXj2kGoo2OpjzosSBBzcOKNiTU4hgXUKRtGy/FFy1IND5EQ3
         spJZ8YWOC+YwKmDutHXr/z/KIvVPk0kKgt0rYSQYDw+FalpkvXJszSIMmbPyaWjamQSM
         tbAsNyheZj1QrZoJL4TXbLmmz/7DiDZqdkq+hX5S9PdX2XG8FPduZZapDvsE0J5lPCC7
         odYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=t6Wz/CVZhwgzgH8yLnIu+vnyKNs6ZhIxtjweGyR/2B8=;
        b=ZVMgtQDlCvP5Li7/maWX1b88cEhuvOPErnZkVa6ROVSvd/CJ8ulN9mYGZWD7Eml6LM
         0RV2hWCbFdJUHQXsYbceWS+/C2l2xMv00fWzWoqo+ed7V1c+AwsN85DIFduielQWr6TW
         9E5BFzkVk6i5/DDAighyq/WDPAelQrVYYkFjB+MRa3A3/qyovLDBuiNe739wMuFDX0HW
         6y/WsCewE+ndbZoRUYftI3RIFflJDewIU1u198Z1lhQLui4vauG/OimhTw7EonvWzLF3
         nfcPeXNIPPM1FTunkPupr7SU99/+fWClUxKWpLfdlcIMj7KuW2LdSp1L6eid5UAzPvY9
         trCw==
X-Gm-Message-State: AOAM533G8Qljf8ZPmy8a/MWmXIueS7MgleEFyrxBDHQFDX2JhLxg0Yho
        Qa/102tqGQcWrAYEnxk4j7IM0snBsu4=
X-Google-Smtp-Source: ABdhPJxurCs/KLCLksXagV4vQfDZRQNrdM8eLYqSSfdRv8DfRKA8DybKoHd/G9wFRtUg3C5RNhK3GIMdrrE=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:991:6d08:9e6d:683d])
 (user=badhri job=sendgmr) by 2002:a25:5146:: with SMTP id f67mr6672249ybb.332.1617826057017;
 Wed, 07 Apr 2021 13:07:37 -0700 (PDT)
Date:   Wed,  7 Apr 2021 13:07:23 -0700
In-Reply-To: <20210407200723.1914388-1-badhri@google.com>
Message-Id: <20210407200723.1914388-6-badhri@google.com>
Mime-Version: 1.0
References: <20210407200723.1914388-1-badhri@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH v2 6/6] Documentation: connector: Add slow-charger-loop definition
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Kyle Tso <kyletso@google.com>,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow slow charger loops to comply to pSnkStby requirement,
this patch introduces slow-charger-loop which when set makes
the port request PD_P_SNK_STDBY_MW upon entering SNK_DISCOVERY
(instead of 3A or the 1.5A during SNK_DISCOVERY) and the actual
currrent limit after RX of PD_CTRL_PSRDY for PD link or during
SNK_READY for non-pd link.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 .../devicetree/bindings/connector/usb-connector.yaml       | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index b6daedd62516..09ad3ad983a6 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -197,6 +197,13 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [1, 2, 3]
 
+  slow-charger-loop:
+    description: Allows slow charging loops to comply to pSnkStby. When set makes
+      the port request pSnkStby(2.5W - 5V@500mA) upon entering SNK_DISCOVERY(instead
+      of 3A or the 1.5A during SNK_DISCOVERY) and the actual currrent limit after
+      reception of PS_Ready for PD link or during SNK_READY for non-pd link.
+    type: boolean
+
 required:
   - compatible
 
-- 
2.31.1.295.g9ea45b61b8-goog

