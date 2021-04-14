Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E13D35F62A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 16:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349566AbhDNO1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 10:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349527AbhDNO12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 10:27:28 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0D5C06138D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 07:27:05 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id e6-20020ac85dc60000b029019d9cbbc077so2011120qtx.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 07:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aTQH+8QFadrYoaEx7teEfO6F+xF81qJm/gbu7SJfp4M=;
        b=p+Dy4+wR6puYM9D4rzYQ0dFlGkQtuZiNm05XebXvDRpCrpegQGd4o/KJUwQLnWcb+C
         BV+LYnY3Brvs4c6UXyblt4WVNqxO4TnsC4IpYTF7PpzIggBhhOwe7tmrYcufexaCx+YE
         N9q1DjDTTz4DcN1KjkqXsFpCOYmLmQ7SWSQ/dK0gkFiqTyPXUUoTdzVgQCQglg7oJ53T
         FOTIlNNL7kIlRJWd9uc6aWVy08NIjrTCIdTIuoDvkBqjpQX0iJzTe4mL1IA9gLGWO59Q
         rgkG4E/DctjmZDiNfn5U+wwVZWp5+SMTQ8uI+WWzVNJvyzXf61gEUNgXk119i9QWHce9
         J+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aTQH+8QFadrYoaEx7teEfO6F+xF81qJm/gbu7SJfp4M=;
        b=n2BXB+NE8ymgCdhWHAodJpvSq7Mer37evpviNkX8wh43S/TJnNR8WuHLj2YCNmR+cq
         Y8PulIq7ulak6nrDfXQCcGQf8tIWBkRguQ4weipjcfkaHX3WiEixmtX/C0awT0fcQl0A
         SxSiSV7mLM8fduLN5wQeLBkaS/pZtYiE0vES8E5G9qbYObspNFgtDTObbvv6OnEGgoYM
         fuxdcXIs0oRiqjYTqaGTG1XI5cc1alfASX5ftx0njbxTZui6YaGOGBNxQuQoxI3j+p7Z
         umyUyYCv0m5bcBy9/nMy/084C+1vV5J41+xhaAHTDNW4L5cn7U0kOKa6wuxIToxim32M
         bSvw==
X-Gm-Message-State: AOAM533VRCoxF+JV1ljgA662Bfh50ssaMRh1pJppFrAK4+xWQTl9wckY
        GLlC/iAtS1mQdkXFmbTbj9uv8RZw1gI=
X-Google-Smtp-Source: ABdhPJy6NCAvWnn2HR6o730wtjP3t0Cu4NnswFnFKu09GrC3WOAoD7SpzOiFFKNOgxoH+d7GVf3p6tR16eY=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:91dd:58ac:7590:aa21])
 (user=badhri job=sendgmr) by 2002:a0c:ff02:: with SMTP id w2mr38604856qvt.23.1618410424116;
 Wed, 14 Apr 2021 07:27:04 -0700 (PDT)
Date:   Wed, 14 Apr 2021 07:26:56 -0700
In-Reply-To: <20210414142656.63749-1-badhri@google.com>
Message-Id: <20210414142656.63749-3-badhri@google.com>
Mime-Version: 1.0
References: <20210414142656.63749-1-badhri@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH v4 3/3] dt-bindings: connector: Add slow-charger-loop definition
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
Changes since v3:
* Removed additional semi-colon in the subject line
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

