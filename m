Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D373D7978
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 17:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236977AbhG0PNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 11:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236901AbhG0PNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 11:13:18 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B080C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 08:13:17 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id t4-20020a0cef040000b02902e2f9404330so10895400qvr.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 08:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eRPX9i2Qwxgyb840VTBcgurMoYEtKqMX2n5NCNoYN5s=;
        b=WHmyiWXjxEmfGiU9Vfl1WDVj9g7b5DFcRLrzPNPlZ2rD1seBdTFyl+uvQTVfSVf8LC
         Aojmwo6DSULDYMGPCCI/VlTIlGrFci16HL6L07bc5FNeKuoL9TjyfYzlgnYRntXOjkf1
         wXG9X/ANDybpTyqUsliQanO6Hd3tPmP5pOUb8PA5uAZKILlzyhxOAgiCIaxNf5rwFJ2G
         kr6WDJfgtNRLXSIfdqQP/WiyNHireT23a+BeIH5SWIrTjf7rPIG69MNpJy4TNq6kdY9/
         MEgIKk1HTqukO3X8mTcmCNAmJa4WUBmPU8OJSkX1CEdcp8rCFNiqV6ubDg50V1ue6jeY
         WoRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eRPX9i2Qwxgyb840VTBcgurMoYEtKqMX2n5NCNoYN5s=;
        b=cXAiu1bl4D1UAG7z33TT82ZbgtdhN35POjw3DU8QdL/Z1f76z17kp9Sn+XMCfYrYHu
         zlG7IgSfTH6qOYn/tDMxZF+QZilR+O8RcS3NCBOVhVbh+qCo4lv8uqCqzJtaXZnOaK8O
         4pqVhfZ1kzWDhb1W9DtGbAq+vfrO6JO7xeMEyzR/Pp5wFTyEOrKUyN/QozZC8FluPt1K
         JtRsqjxyrypYh5bRml9I3bttOplCUMfeKlHM/e4Xyp9zEJMgV/njU/1l3WFk+mp1MJXV
         xAVsbs6aIx9mvBQw0ttVcNyWt18nRNy3oqyVpQOH3YRHi9lEFp0G6UWp7MsMK+/A42Uo
         hR8A==
X-Gm-Message-State: AOAM5337r845GRGWLnFbCzCCnoSsIbykJiK/vY6P1ReJ9wBMhVjpH5/n
        GdjrKLkXo1/sjCSzEl5hKDM8qpS6F84q
X-Google-Smtp-Source: ABdhPJwP4hYxg86JWBvDQwckVtYazVArl6BotZSi0bs9vATCDKhYprIDAzbPvio67LbsImWsL5bFcO5HJoqp
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:da7f:a21b:ee74:66a2])
 (user=kyletso job=sendgmr) by 2002:a0c:ac43:: with SMTP id
 m3mr14003604qvb.5.1627398796116; Tue, 27 Jul 2021 08:13:16 -0700 (PDT)
Date:   Tue, 27 Jul 2021 23:13:06 +0800
In-Reply-To: <20210727151307.2178352-1-kyletso@google.com>
Message-Id: <20210727151307.2178352-2-kyletso@google.com>
Mime-Version: 1.0
References: <20210727151307.2178352-1-kyletso@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v2 1/2] dt-bindings: connector: Add pd-supported property
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set pd-supported property if the Type-C connector has power delivery
support.

Signed-off-by: Kyle Tso <kyletso@google.com>
---
 .../devicetree/bindings/connector/usb-connector.yaml         | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index 92b49bc37939..8ed271feea08 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -111,6 +111,10 @@ properties:
       - 1.5A
       - 3.0A
 
+  pd-supported:
+    description: Set this property if the Type-C connector has power delivery support.
+    type: boolean
+
   # The following are optional properties for "usb-c-connector" with power
   # delivery support.
   source-pdos:
@@ -312,6 +316,7 @@ examples:
         label = "USB-C";
         power-role = "dual";
         try-power-role = "sink";
+        pd-supported;
         source-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM)>;
         sink-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM)
                      PDO_VAR(5000, 12000, 2000)>;
-- 
2.32.0.432.gabb21c7263-goog

