Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADC837AEFA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 21:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbhEKTCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 15:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhEKTCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 15:02:03 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DEEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 12:00:56 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id z18so7694139plg.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 12:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1QNHHOT5/rxXgeedYeM4a2djt2oyHaG/EvVoGjfBbRg=;
        b=D3kd2aIiWfYa0HxlSPzNMFMD3VGm3LnEUf6eY+QgayueEVxDerAIkdgkipO8BqN5pC
         uffJ3xpxLMxd1UIdgb4e8TdhqV5jLiwVrLXS5YLWP2TrLrkeWreFYYMXXdqgwamzBWL8
         4nocSvHZNIGzTmudeIAgJ8KmhT13W5wRWMAnOkCC2Pmh/PhM5GabwejS9hMGILlHwtxJ
         vfNTlz7gHjlBbVE9SAP2UAka1LBDjPt8ZDuAPmvnQUAJ/Ta5a9mGxij1MRY7bFNKSA7y
         61nlQPA2MhZMUuRqrwN3PqYIViB0HBdTNnk1cYMWMmnWv4+snLtB7PQDdGN0aSon7x9G
         LD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1QNHHOT5/rxXgeedYeM4a2djt2oyHaG/EvVoGjfBbRg=;
        b=FClVP5+8Om81UXid101RLTSQKDXHTuf7ULpJSuL4IBXiD4M2uzgliuKXjo92noq0OP
         HIbdV/cqfKxZASJfkmE6oqT4/PqCIpRZ/n/pbChJtCZ4DA20XWDwW0xijlCmWKVRIpTa
         rtNumZ64dYxXLhAw+B+92sC/cJeXYSdUDiUJbJjvB7fkpKnUGNWdY+kJkTgHXpv4Ne6h
         CtNQYByq5mEDbonpkKP8BwpoPo67bLf0yDmI86iwpJO0JzA2NXn0s4ZjQJD+rzPMK4Sw
         ZvQmfE7Cnwt2s9UHiXVAGqZ0MXL3QuEz5QQPjOarbac56u3qgBQEzeeo6FcmrdN0Ajte
         yvPQ==
X-Gm-Message-State: AOAM530iJURnVMddwEIHkD853hETFukHa9fnwx7sSbrnZ+atnEntwxe7
        lu22BBNhX09VvPeNI+GCVJD3gw==
X-Google-Smtp-Source: ABdhPJzpcayWkE4ql/OVzinUyg2mbTDgXAO7HnrWZLHKN/8hsfMISsWcximIO+6a+riDpVoMJcUaeA==
X-Received: by 2002:a17:902:d491:b029:ee:5aa3:7d57 with SMTP id c17-20020a170902d491b02900ee5aa37d57mr31433298plg.26.1620759655705;
        Tue, 11 May 2021 12:00:55 -0700 (PDT)
Received: from localhost ([2601:602:9200:1465:da9d:67ff:fec6:ee6b])
        by smtp.gmail.com with ESMTPSA id p11sm14954494pjo.19.2021.05.11.12.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 12:00:55 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     soc@kernel.org, Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: ARM/Amlogic SoCs: add Neil as primary maintainer
Date:   Tue, 11 May 2021 12:00:54 -0700
Message-Id: <20210511190054.26300-1-khilman@baylibre.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Neil as primary maintainer for the Amlogic family of Arm SoCs.  I
will now act as co-maintainer.

Neil is already doing lots of the reviewing, testing and behind the
scenes support for users of the upstream kernel on these SoCs, so this
is just to formalize the current state of affairs.

Thanks Neil for all of your efforts, and keep up the great work!

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bd7aff0c120f..1f64aa7de84d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1618,8 +1618,8 @@ F:	Documentation/devicetree/bindings/sound/amlogic*
 F:	sound/soc/meson/
 
 ARM/Amlogic Meson SoC support
+M:	Neil Armstrong <narmstrong@baylibre.com>
 M:	Kevin Hilman <khilman@baylibre.com>
-R:	Neil Armstrong <narmstrong@baylibre.com>
 R:	Jerome Brunet <jbrunet@baylibre.com>
 R:	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.31.1

