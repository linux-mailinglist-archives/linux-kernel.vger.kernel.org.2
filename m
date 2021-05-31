Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34553955BA
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 09:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhEaHIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 03:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhEaHIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 03:08:01 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E3FC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 00:06:21 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id mq2-20020a17090b3802b0290162428291f5so2986752pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 00:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OXNljNLjDHh35jBsdEQkJoC/0R7Ygjho6Qqcywt3z/w=;
        b=dDqYXJO++yROCI3CgDkyBgmQ+UMv0xeBTOST4xv3e9EqW5aBBQf5OOyuh3Rb9ZPfwK
         azuSDeNzX8Gipj79OZsJ3IcrNvRlPPbK0ZE8rHa8gRrR0KCFWg8s8tNIoIFB8abyEn8O
         Xe4lsHC7wjxDYbIQek1+ciDhVt4jiAomh1H+bRNqJdcqy14VcrpAozzP9TEBSv1+a9Ia
         qjAMq+IBMhe7Kf3GqsW5GUdJ4msVKJ4g/szcF7StIPOxidK4EPUaYhMI5vLCeNaXoHpz
         JiFnbjSmyqJhsd/pfrLGehgaahq/TBafVIBfr4unRdfPVuwED0Qp1lX5SVVFT/9ji0Ji
         r94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OXNljNLjDHh35jBsdEQkJoC/0R7Ygjho6Qqcywt3z/w=;
        b=eaDAktk8ZJmBGtGEWU4J18l+I5dAX/GGXWJgj5bbFhbgpo7mKpd+ON7RSmS4FUDqqL
         nszpaHvf8WQNoV9GVmqaWws1v2PJ3zSW2BY1YdJ5kI1L0yxYMqPpRl3nGJQ5IcfS+zN9
         BkwvshnDUKNy27L5l9jB74EmfZwctZh8x1vuuyw573kInKInxc8qo7ze3wv8aQ9KeMco
         Jsjcg/2jlDljnHAynDGsf6XN4kryxlZl69rd8MzKVzpdxoIjx+GV6j4ggRkwyS6If+mZ
         VTtbrAbdjvLDby8Fd9e+CNeRY2wP0WneoTMiRUs9lMGd2MWbREOlFqQNk8OEa7XqCjq7
         wZDg==
X-Gm-Message-State: AOAM532t32uYzBbjUJrwIDm/ftbO/s0bpiH/RDKIGn2nmK6se58yULlL
        iOyWxc4dMZYwagN/8EieRCvPTg==
X-Google-Smtp-Source: ABdhPJyPacGRbE5FRfISO20CeCikp02u9bsm2NO9TlNeNOKUtAw0orr9NXDF+N9yUBqJqfnXY/l/Ng==
X-Received: by 2002:a17:90a:288:: with SMTP id w8mr17922895pja.111.1622444781398;
        Mon, 31 May 2021 00:06:21 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c0:4701:ae70:425f:73d:12c3:3b24])
        by smtp.gmail.com with ESMTPSA id d15sm4037384pjr.47.2021.05.31.00.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 00:06:20 -0700 (PDT)
From:   Drew Fustini <drew@beagleboard.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sam Ravnborg <sam@ravnborg.org>, Arnd Bergmann <arnd@arndb.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Max Merchel <Max.Merchel@tq-group.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Drew Fustini <drew@beagleboard.org>
Subject: [PATCH] dt-bindings: add StarFive Technology Co. Ltd.
Date:   Mon, 31 May 2021 00:04:18 -0700
Message-Id: <20210531070415.269667-1-drew@beagleboard.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for StarFive Technology Co. Ltd [1]. StarFive was
formed in 2018 and has now produced their first SoC, the JH7100, which
contains 64-bit RISC-V cores [2]. It used in the BeagleV Starlight [3].

[1] https://starfivetech.com/site/company
[2] https://github.com/starfive-tech/beaglev_doc
[3] https://github.com/beagleboard/beaglev-starlight

Signed-off-by: Drew Fustini <drew@beagleboard.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index b868cefc7c55..3dd6a42fbbad 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1085,6 +1085,8 @@ patternProperties:
       (formerly part of MStar Semiconductor, Inc.)
   "^st,.*":
     description: STMicroelectronics
+  "^starfive,.*":
+    description: StarFive Technology Co. Ltd.
   "^starry,.*":
     description: Starry Electronic Technology (ShenZhen) Co., LTD
   "^startek,.*":
-- 
2.27.0

