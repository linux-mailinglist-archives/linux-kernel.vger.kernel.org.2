Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8749A308617
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 07:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbhA2GxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 01:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbhA2Gwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 01:52:55 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09287C0613ED;
        Thu, 28 Jan 2021 22:51:53 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d16so7689183wro.11;
        Thu, 28 Jan 2021 22:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QAsVvG9i6Xg0y3Z1EJ3mhfNvPnvT0DDgRmi3UPHJgto=;
        b=MXnFGHNfVsgv75DveAyf8zkaosI3iTjms/W3mLKet/J9DZhvbGw+EsdLRtJDRhZbrs
         KYQPOGLTUVX5ZoUQrQu7cKF4onc8O4oN33CQxJypuoIs+Iyw8NlxiQ6M/QFhXSsRbynJ
         DaQpSMeNf1ouV0YC/VFw/FNWjwUYBGVe7spUV6t1HTuLTtm4Z4cAUPkfc0M1MozFzYj/
         PpOvTkfA/NnSnwEMdpa9o55aK6TgHLpWEvAp0qiJFeWmXZsSSnmguazxEkWM9rm7Tkzr
         0JfPlciNOAWrJYL6+fHNOE3FFNfBunY69CVv7dPVcaiS5K00gX8MnOkB01BlBn38efd5
         iWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QAsVvG9i6Xg0y3Z1EJ3mhfNvPnvT0DDgRmi3UPHJgto=;
        b=oQ5RgUNf/6a4JT0zEfvJ5W+4/Z4nTRLoTMoXv2DP0f+pMbcsKTvkYLSzhGfZDEj2oe
         NfGTZOR1Aae9wp4Vfc9REsikWUvx7LvGaDyzXXY1FGfrdkErkGwiUYWwpFE5E2YNn3l/
         5s9TC1sXPpguWQhsUWrk2WhFTutnWBBItIyK68AuruRsriMMwptVBKr/gpo3a1z1VvUc
         VkzKKDW2LluPptCHJ+fcU8r4whCMbGCnoKh8dVVbFDd0vxYI+lOGQcZwzk3FDdpcarkP
         qtX7PeLKutP+iz52kSz3IpUy0VCOdKzYLArw8Yn54B1rRTicXD9g4J6KiWxU0ZmqNJca
         1JkA==
X-Gm-Message-State: AOAM530wRIb3CqcP32f5dG//fyn3TCc1T8+Vq/ATwnOi491V8YxBEMhP
        8rFLz+MdkHOAE9XCw0T3jajCw0LSBSE=
X-Google-Smtp-Source: ABdhPJyRGogyKK9SoDnWoLHIbG1ZpyS8Yl8plcqXAyP9cQ9WyEmmoy6qB9HqWGDtJuH5rra37OHr+g==
X-Received: by 2002:adf:fb85:: with SMTP id a5mr2737803wrr.331.1611903111777;
        Thu, 28 Jan 2021 22:51:51 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id b7sm11501236wrs.50.2021.01.28.22.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 22:51:51 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Dongjin Kim <tobetter@gmail.com>
Subject: [PATCH 4/5] dt-bindings: arm: amlogic: add ODROID-HC4 bindings
Date:   Fri, 29 Jan 2021 06:51:36 +0000
Message-Id: <20210129065137.5473-5-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210129065137.5473-1-christianshewitt@gmail.com>
References: <20210129065137.5473-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the board bindings for the ODROID-HC4 device.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index b21ba8ba23dd..5f6769bf45bd 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -165,6 +165,7 @@ properties:
         items:
           - enum:
               - hardkernel,odroid-c4
+              - hardkernel,odroid-hc4
               - khadas,vim3l
               - seirobotics,sei610
           - const: amlogic,sm1
-- 
2.17.1

