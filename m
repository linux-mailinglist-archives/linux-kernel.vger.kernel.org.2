Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDF9319AB4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 08:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhBLHlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 02:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhBLHij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 02:38:39 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8112DC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 23:37:59 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id r18so6322352qta.19
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 23:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=86/r1w8AVTRm2mUBh5ZQSxhf8FoO+Vil3SuoG2iyfTY=;
        b=V23M1TeR3noOk3BE0V19VrnOGA9gG2IcmnBnEy9pNOkqck6+pEyqMigvQameu43rWt
         vcdTh3pMUS0WujWsFVaSc3qakqq6xGbOrkXlv9AmGN1uN3QA+7kWk/FIFuQSsIlmwxy+
         TWd3S3Gqe9J7shFtTwJ4v6yNqMwsYtbP+5hBniewT24eRMFvspPoaD9IFmOJafarqZgH
         HjB+T2/hsBmgS+U3KeD1uUkW4yBqrmWz8kJtmXd+n5gf2RQb4T9xYvg3cKG7bbnOHlI2
         vPGa01YKORZyU7jZpqc2eJLOEDdAW4YsjnvQEs7+d9hPtwLDw3YvK1nKU7rVLnBR2VLe
         E+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=86/r1w8AVTRm2mUBh5ZQSxhf8FoO+Vil3SuoG2iyfTY=;
        b=DW+Gy/mLjlTMaB+6lExoCXvAFptVhrgyRdzC1IIi9Z5hOSmZEZhHyUrLXVdDBuQr9k
         wDj9snsADkG3BOtKEfmwro4fig+RaX+1VZ59sBMrqqynh3xtT2P12Ww3X8yhg1ZxbmlQ
         ONrKp9+RUEZsiGwz0b2KTfm72/km/9Xa6MNruk8JZ3e2dCC7Am824+JXRTpxJe8ier4j
         s4D76SByj5aG121s9S4YTSbHyGXy4zIuNunDsbxpu8aTAV1UqyWtL5mW7MACfyhs3Yy6
         6mnzWz7+tUUX5ymaOmB93iFq8H9+pYP3MqANcthB2hnQeXMC0pR/gLjS/GCTUrg6BUCR
         u52g==
X-Gm-Message-State: AOAM531XJT+Ki60Mnn5v/Cj3xdaGGnxWWztTdT/ykc4g6BaJkgfzvzNG
        C/NSf4+q+uGYpEVBgzBemszXjSEPMxkZ
X-Google-Smtp-Source: ABdhPJxPF/gMnSJbfHML/adezcmOAKOVDK+G/gI97p1/TAD61QPT+pFVAI9xolzHZFUJPlUyRhbfSw/HmelY
Sender: "kyletso via sendgmr" <kyletso@kyletso.ntc.corp.google.com>
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:31d1:1430:2fe:5498])
 (user=kyletso job=sendgmr) by 2002:ad4:584b:: with SMTP id
 de11mr1529000qvb.13.1613115478574; Thu, 11 Feb 2021 23:37:58 -0800 (PST)
Date:   Fri, 12 Feb 2021 15:37:43 +0800
Message-Id: <20210212073743.665038-1-kyletso@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH] Documentation: connector: Update the description of sink-vdos
From:   Kyle Tso <kyletso@google.com>
To:     robh+dt@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the acronym "VDM" and replace it with the full name "Vendor
Defined Message".

Signed-off-by: Kyle Tso <kyletso@google.com>
---
 .../devicetree/bindings/connector/usb-connector.yaml       | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index d385026944ec..ce11b2027199 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -138,9 +138,10 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32-array
 
   sink-vdos:
-    description: An array of u32 with each entry (VDM Objects) providing additional information
-      corresponding to the product, the detailed bit definitions and the order of each VDO can be
-      found in "USB Power Delivery Specification Revision 3.0, Version 2.0 + ECNs 2020-12-10"
+    description: An array of u32 with each entry, a Vendor Defined Message Object (VDO),
+      providing additional information corresponding to the product, the detailed bit
+      definitions and the order of each VDO can be found in
+      "USB Power Delivery Specification Revision 3.0, Version 2.0 + ECNs 2020-12-10"
       chapter 6.4.4.3.1 Discover Identity. User can specify the VDO array via
       VDO_IDH/_CERT/_PRODUCT/_UFP/_DFP/_PCABLE/_ACABLE(1/2)/_VPD() defined in
       dt-bindings/usb/pd.h.
-- 
2.30.0.478.g8a0d178c01-goog

