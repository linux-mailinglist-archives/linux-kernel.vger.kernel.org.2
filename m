Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACAF735EB04
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 04:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345895AbhDNCkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 22:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345683AbhDNCka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 22:40:30 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2BAC061756
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 19:40:09 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id cm5-20020a17090afa05b029014dcddf9939so9336842pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 19:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qaeiP4TcmkgXReccF8JNSG63nl5JyNyZTFgqbhXpA8w=;
        b=Inaem3hvoh6bBnQ/t6s8zhXAyDUbPjoohiMB3we9nLNBh9OKJSk3yK1ERidnzbCHKZ
         8av0rHQJyFviHs3ODvVWEuBu5GgTUa02STo6Z1Vh0ois97JRYkWHQyptVwRgwoRqqdlp
         jJfbzKXePPrVxhP0YSvbNs9AJ1lvAxYtAyPxAdzq66BU8IVKBGZXLTzI+mc7OlKjsF3l
         b/8UvlKL+4XI5AlKBqS5QDBKrFGMW3hzsYog3y+O+yWhQpaO4jb6Q+GJFGG3CnCXY5zb
         LebyUhmGy0RY2GgthKz/nGW7bfOuMWsmoe1FNMfsvD7Fw+fNnuPNXzEdftYUUZVvApUC
         0olw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qaeiP4TcmkgXReccF8JNSG63nl5JyNyZTFgqbhXpA8w=;
        b=a85mBz9AbEU5BvV96oyFW95oM/XiAr8jkIKkO0KHqOJM2NAJxzIpE+q8IXsUwE+rf4
         Chvp13/YB11l9tr4M+mroRvTyNkEWukRWN9Jf6dTStvSp4Fl0OeD888tr1jS5uDHNoDf
         3r8isDisvchjgAHFBIo7sjNA/MeJV2fx8n4ptKX9Y2ZH6kMpaM+xktPIy8h1j4uuBUnP
         6iY3FODA9wIKcVfhMnQDBktdTwrqgXA2ix3sYU/lyzHfAWDxKt9hSxVmskXlEzV6hfRx
         PN+3Yg0DKe0OXsPVUhkEmHflKCBq+sRItrFGtwsl5WCBBGQ2XcCVTm4VKgraI8+sas1J
         q5qA==
X-Gm-Message-State: AOAM532FZhijYtgh3TgLD82RMkY+bXcyt/8eM9hvjGcfIrJtQCX7e7Wy
        j9+M7BsEdK+XAXT80OWBygpk+3zCiXk=
X-Google-Smtp-Source: ABdhPJwPV18N9xjx5dwA3igxAJiFUaZL/VMUHoyaPfs+7PbKnBAcBE9xSAnWOXyldokRvRo3Bqkk4S2P2pk=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:91dd:58ac:7590:aa21])
 (user=badhri job=sendgmr) by 2002:a62:4d86:0:b029:252:c889:2dd8 with SMTP id
 a128-20020a624d860000b0290252c8892dd8mr1790835pfb.41.1618368009191; Tue, 13
 Apr 2021 19:40:09 -0700 (PDT)
Date:   Tue, 13 Apr 2021 19:40:00 -0700
In-Reply-To: <20210414024000.4175263-1-badhri@google.com>
Message-Id: <20210414024000.4175263-3-badhri@google.com>
Mime-Version: 1.0
References: <20210414024000.4175263-1-badhri@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH v3 3/3] dt-bindings:: connector: Add slow-charger-loop definition
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

Allows PMIC charger loops which are slow(i.e. cannot meet the
15ms deadline) to still comply to pSnkStby i.e Maximum power
that can be consumed by sink while in Sink Standby state as defined
in 7.4.2 Sink Electrical Parameters of USB Power Delivery Specification
Revision 3.0, Version 1.2.

This patch introduces slow-charger-loop which when set makes
the port request PD_P_SNK_STDBY_MW(2.5W i.e 500mA@5V) upon entering
SNK_DISCOVERY (instead of 3A or the 1.5A during SNK_DISCOVERY) and the
actual currrent limit after RX of PD_CTRL_PSRDY for PD link or during
SNK_READY for non-pd link.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
Changes since V2:
To address Rob's comments
* Updated commit and the binding description.
* Updated subject as well.
---
 .../devicetree/bindings/connector/usb-connector.yaml   | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index b6daedd62516..32509b98142e 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -197,6 +197,16 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [1, 2, 3]
 
+  slow-charger-loop:
+    description: Allows PMIC charger loops which are slow(i.e. cannot meet the 15ms deadline) to
+      still comply to pSnkStby i.e Maximum power that can be consumed by sink while in Sink Standby
+      state as defined in 7.4.2 Sink Electrical Parameters of USB Power Delivery Specification
+      Revision 3.0, Version 1.2. When the property is set, the port requests pSnkStby(2.5W -
+      5V@500mA) upon entering SNK_DISCOVERY(instead of 3A or the 1.5A, Rp current advertised, during
+      SNK_DISCOVERY) and the actual currrent limit after reception of PS_Ready for PD link or during
+      SNK_READY for non-pd link.
+    type: boolean
+
 required:
   - compatible
 
-- 
2.31.1.295.g9ea45b61b8-goog

