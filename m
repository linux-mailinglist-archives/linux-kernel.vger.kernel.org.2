Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7309322DFA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 16:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbhBWPvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 10:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbhBWPu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 10:50:58 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB86C061574;
        Tue, 23 Feb 2021 07:50:10 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id v21so2865100wml.4;
        Tue, 23 Feb 2021 07:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jq0kQtDSX5dH8ohcWOXbXLKCHW4XC2c+FwwnMqOyu8A=;
        b=Mn95eKnody6kfmlE5fsuhDTGCKEpKYtcBWhBSJRoqeZmHsoLH5OuaAg433mD41zUd5
         7+z/S0bNOSAlCu70n5GQ9tkHE+Xk5LG/UAUElWGDkBKzMg3CRkHRLUdmFhbFTj5jd+66
         7uRatcu4Th3iB0YqtGDSWRET9tqBurnEwVtUL8d09G9jRNI8C1/3MDoXbbG580F7MNrf
         VBc7JOz/B5YEAN8tmKMNjPbet1Zd91Fhfwn8SCTyS2KhhUVXT8viF2DeF1EHE2auzPjU
         tpTWqnRncEcotdVvw35HBCFon7GIpTUAFP4TxQPbTBKB/5A4F9ORmDp90c3w/CtTPtBU
         AHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jq0kQtDSX5dH8ohcWOXbXLKCHW4XC2c+FwwnMqOyu8A=;
        b=bfH9cWSRAqmJkghzYiiegRkzwZn7mC84EVB/vfEQeDCpQ+I0BKiSYt2q20jLFiyHt0
         zb4gUp3NRfp16FQTFbLMwcxrzMd3n7J9TObRbgaauF2QvluxeTA6l4JBjIc6FIy9ViOA
         fe0FBN+S/9Bw5Nc3aZdfhnsi6hbcrMN1GyfK96Cg/0HPm7WGVAvCYvae/6Jcl1kmgs7S
         cETFBEEf/63YD7lKkrf+qAw3Mb15g7zZ0kcu6fkfARYo0cdDGln0mhe2uLwpmId0U0wS
         IUTp/N3lXD9iMT/k9cMmH1hq9IdW32CLSwNHi+nui09TM8kWUEuUCU9qwIjTOw25ni8f
         54Rw==
X-Gm-Message-State: AOAM531U2Bs+C3rkiXxCceRKFW+JKwhGxELINyhEqyAqWBZs+NsoGHPe
        u7ZuwIPTBac6CIilA8plikUL2coC2boIHV1/
X-Google-Smtp-Source: ABdhPJxaWV+jkKPqgTfcLyedOekGOVSPfUwolyvZEyL1bt55OsE94y2kP27DZAoLfZmH+JvYySqJRg==
X-Received: by 2002:a1c:4c0c:: with SMTP id z12mr797142wmf.60.1614095409667;
        Tue, 23 Feb 2021 07:50:09 -0800 (PST)
Received: from skynet.lan (170.red-88-1-105.dynamicip.rima-tde.net. [88.1.105.170])
        by smtp.gmail.com with ESMTPSA id t23sm3209201wmn.13.2021.02.23.07.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 07:50:09 -0800 (PST)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     f.fainelli@gmail.com, jonas.gorski@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Tony Prisk <linux@prisktech.co.nz>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 1/2] dt-bindings: usb: generic-ehci: document ignore-oc flag
Date:   Tue, 23 Feb 2021 16:50:04 +0100
Message-Id: <20210223155005.21712-2-noltari@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210223155005.21712-1-noltari@gmail.com>
References: <20210223155005.21712-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Over-current reporting isn't supported on some platforms such as bcm63xx.
These devices will incorrectly report over-current if this flag isn't properly
activated.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 Documentation/devicetree/bindings/usb/generic-ehci.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/generic-ehci.yaml b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
index cf83f2d9afac..294bbf02399e 100644
--- a/Documentation/devicetree/bindings/usb/generic-ehci.yaml
+++ b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
@@ -117,6 +117,11 @@ properties:
       Set this flag if EHCI has a Transaction Translator built into
       the root hub.
 
+  ignore-oc:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Set this flag for HCDs without over-current reporting support.
+
   needs-reset-on-resume:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-- 
2.20.1

