Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6473D8A9D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 11:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbhG1J3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 05:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbhG1J3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 05:29:46 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027E3C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 02:29:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x7-20020a0569021027b029055b9b68cd3eso2162771ybt.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 02:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RUJPh6UqFvsmnaeSLFxYRKVeU3eXey0w6Oeu1NKymnI=;
        b=SAUZTquQMTOFe3oo+mO1hGfbqJlmT+2gKwTClaKYJ/O2cpkGEViRDgvq7webhvbRkC
         xCTxqkcR31iJTz1JxG7j+34DjrkTr6OqQ6fwcjYx40q+UCmvtKqa1F4vZYrtm9fBHshx
         nQNvY3FkrocKOb0ic68hEMQGjvzDUOUlNXnHFAa1tqNDz/OgB8yqpuLFf+q56oZbh+v1
         GuSRUXZUP7HDEaaX+BVTrWG63Hqd20/wIokRwncseKTd2zbe143s605qRg5QuBhD1EAX
         CjHyHrqSIcpxa5dE9dbUyuAmqkufTpkAs8eY2A46iv4525GE8P/UigjmqKpAKzMkKFH+
         KWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RUJPh6UqFvsmnaeSLFxYRKVeU3eXey0w6Oeu1NKymnI=;
        b=prgW96eB1RcjGgpUKLVCX1gRtaH1L6A2838evUMllll/OiXv4noxwgwdrLXfjtB8O2
         pXLiRl+/2lihi01OITFU8gh5cCtiRndZvFe20UzI7ebEM1sSabRXwCaZXjl1pOXRntDz
         TLMcJgPiRuxkR66SYIo7Vmqc2tFVAfNfbndDAS+so4VlFv/gNdFVK/a0IvgzdCoYdav6
         Ea7OiYIaE3SzacT4gKrfmU6vUCvb6nN5P3vwT1e4btLRXZCE5tjJm8CNeB4wQt0D+4we
         C0Tm3PlzW1SIVLyrUX48aL67bwfvydJjcyttJLOYtOPpurLCHS+7qXMW21ClUjtYiaGl
         S1Xw==
X-Gm-Message-State: AOAM532GfpyiLC+gqtSoPHwACt5V2kclAb2WQrMKjUEBdhs8ulxwd4UA
        KSWQriYx7GZ0DDbS4T35R+BvVSIgRDF9
X-Google-Smtp-Source: ABdhPJxIed430XTN1GHV69yeSBEg8wY0pGsT1vjQrsjClecO5dJSZdfCxhtFXLHjMS6YdFjr+5AgRyclgpYp
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:da7f:a21b:ee74:66a2])
 (user=kyletso job=sendgmr) by 2002:a25:24d4:: with SMTP id
 k203mr21079840ybk.383.1627464584182; Wed, 28 Jul 2021 02:29:44 -0700 (PDT)
Date:   Wed, 28 Jul 2021 17:29:29 +0800
In-Reply-To: <20210728092930.2552619-1-kyletso@google.com>
Message-Id: <20210728092930.2552619-2-kyletso@google.com>
Mime-Version: 1.0
References: <20210728092930.2552619-1-kyletso@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v3 1/2] dt-bindings: connector: Add pd-supported property
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

Set "pd-unsupported" property if the Type-C connector has no power
delivery support.

Signed-off-by: Kyle Tso <kyletso@google.com>
---
changes since v2:
- Negated the meaning and the name of the dt property. Now the name is
  "pd-unsupported".

 .../devicetree/bindings/connector/usb-connector.yaml          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index 92b49bc37939..21ec470117a6 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -111,6 +111,10 @@ properties:
       - 1.5A
       - 3.0A
 
+  pd-unsupported:
+    description: Set this property if the Type-C connector has no power delivery support.
+    type: boolean
+
   # The following are optional properties for "usb-c-connector" with power
   # delivery support.
   source-pdos:
-- 
2.32.0.432.gabb21c7263-goog

