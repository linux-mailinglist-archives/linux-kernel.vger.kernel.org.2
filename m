Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA053DFCAB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 10:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbhHDITq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 04:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236277AbhHDITj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 04:19:39 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500A1C061798
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 01:19:27 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id o13-20020a17090a9f8db0290177972c9adeso1408512pjp.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 01:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=C1EVFl+pMa5xKDarlXbCwR3ZQAR2GrvW09BixTn6J/8=;
        b=W5hgfrZDKalDsMytlNPR0fkoArwsxYmw/i+MAyb1IrmBWUhxCPdE5z9zLdHPP5yTvu
         +rh5WS+D+AhpmTi6GFiZnA55lTcuHrvUZdrJOF/6lUOh9mGdrxBbwTxv/CdKsvUfqB5v
         gigE6Q+ikeRWolpIK74dv1u5HPTRasUGW2vNH7yxAavvny5YrY1kdmV1CW6e6duT4NgB
         2YF4WzSHI9bfhFNjqQVmLZu++ohxjzIZ8Elb7UEIEvIg2aZQ7IpEgj5Fj8br55OVMfqv
         EWn1/XhGyR+A9BGlRmh3LX+cyN5THQknxfKycUw8x8sb3eersDYKvtHwyv/avYj6tRBB
         lfmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C1EVFl+pMa5xKDarlXbCwR3ZQAR2GrvW09BixTn6J/8=;
        b=Tl0IZMXmTvQIvW4Cwt93ZgoWOYFKVMLGY5t5QnTpBU09quE1fyk+O0MInxYcNquMuS
         ihRP/7X8AMThgVhHcGaMQMq0JSsS1r47XIsTOZ83IZ96ka48XEtlCHSdwnv+hBbOh1b2
         vBSdxCNZwN7Qla7N3Xhj0cbPFZOasezPsKmyuFuMy9p/HrpJQPF78cHcXg+7za5fjJhh
         j96bBW4hygFNGYDl2YxZP4jDQh85EuOZpuLX3VlKL6bpeORBrERFnJgt8jD4WjXf7grM
         EX+lPdgfYt4uq66d4YR99x62LcFY0SWra3xixK5jeMPS7cJAVpIVdWhq53xEr3zRaK3w
         E2Xw==
X-Gm-Message-State: AOAM5330jsa8814Q6g11zAcOQ8II+rIRa8aLOFL+PF3x4/BK8w1Ucd1C
        VkbIu/G4YgAPo/NtDmRDym+1u2Y5swO/
X-Google-Smtp-Source: ABdhPJx8Q/lL774JTLuDicVKFxGtOTVqf/nwjZS8BaVrMF1Xz/dKsBBD54XVSvUyAuFB6qStJn/WF+I+oibv
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:7eb8:c2f5:2e08:d4bc])
 (user=kyletso job=sendgmr) by 2002:a17:902:bd83:b029:12c:1fea:7dc with SMTP
 id q3-20020a170902bd83b029012c1fea07dcmr21770700pls.59.1628065166725; Wed, 04
 Aug 2021 01:19:26 -0700 (PDT)
Date:   Wed,  4 Aug 2021 16:19:16 +0800
In-Reply-To: <20210804081917.3390341-1-kyletso@google.com>
Message-Id: <20210804081917.3390341-2-kyletso@google.com>
Mime-Version: 1.0
References: <20210804081917.3390341-1-kyletso@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH v6 1/2] dt-bindings: connector: Add pd-disable property
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

Set "pd-disable" property if the Type-C connector has no power
delivery support.

Signed-off-by: Kyle Tso <kyletso@google.com>
---
Changes since v5:
- Changed the property name to "pd-disable"

 .../devicetree/bindings/connector/usb-connector.yaml          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index 92b49bc37939..7eb8659fa610 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -111,6 +111,10 @@ properties:
       - 1.5A
       - 3.0A
 
+  pd-disable:
+    description: Set this property if the Type-C connector has no power delivery support.
+    type: boolean
+
   # The following are optional properties for "usb-c-connector" with power
   # delivery support.
   source-pdos:
-- 
2.32.0.554.ge1b32706d8-goog

