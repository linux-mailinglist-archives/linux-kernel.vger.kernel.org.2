Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4DE33A5795
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 12:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbhFMKVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 06:21:50 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:40767 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbhFMKVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 06:21:49 -0400
Received: by mail-wr1-f50.google.com with SMTP id y7so11002063wrh.7;
        Sun, 13 Jun 2021 03:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0nt1QAmwrT7KiwVRGBb2sEf7u5dtEbfMgMB1Y3n/d6U=;
        b=n3+XLPkg+KhWbd+RoKG12JNHlGBEkSKis+yiNnsXLa75ONbsZC4RmEa9GVGL6z27Oz
         PwQvsvdp+Be0MxVAlCmKyiAFZcsJXFoVJXhykN1+PFFcwooDNsCn/mao0zxQkKcGjy8+
         4F+XX9BsdT8jGZtwOQxbLKFUZBzdPHij9KwCfdjk3i1Cfq+vfBPdQMTpR2rR0oALM1c5
         XyPk8BQBALaDRvrgiUNlQIA2/7TT74Cfsiw6cHcrHKBQ0PKtWP+93eYfgKysmH4kmg9f
         y80nkJlR8XrzsLfQ4rlK/I4w7o+a/AiiqDfMxLNXUVoQJd1bJYaC5TwNk/tQywtviNVe
         HM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0nt1QAmwrT7KiwVRGBb2sEf7u5dtEbfMgMB1Y3n/d6U=;
        b=Y6I/PfX3dGXa6xsNnimzkU2NlXJWxjfUpWnVA6BJnE5sJAaYl3OoF99dLLdJyjax22
         I7xno/53dGKaTVLafVyYON0NfcEv5Eyjc8yEROAfAY0alLyqRtj0GDVrB65Nj2fqB1V3
         AoGgEVNYVsjkoJBkWZMqonnADBG5si7/oIFTY1RtAVROMMMsMmAueHkwHBRtWhg9Dob7
         GoHI6VvQ4O8KREofc5RIroppQHKv/ZvN4f5JTTETFHBhEAx0zvNI5gcf7uZH/VN5THK5
         pn5DaxxKlstn4MPYjKxqWP5ELTGxIKnk6gFdsb3TcLsW4ytNPaeNtwkbIa7wlpFj2WFK
         4UYQ==
X-Gm-Message-State: AOAM533N5LMaWMGnaYI+Uh2jXxCfdLKbfEUfDwHmExJ2NKrxG/HIzhUw
        eyipKgTydNYhI+j1gFL0RBs=
X-Google-Smtp-Source: ABdhPJz85dTGbSbzKImxg9MRP4VAM0osivUkyy5dKD+XDrJQFIu8xwXCu3eBbwz6xVLOzo1XcqoatA==
X-Received: by 2002:a5d:4f05:: with SMTP id c5mr13123620wru.341.1623579512058;
        Sun, 13 Jun 2021 03:18:32 -0700 (PDT)
Received: from cluster5 ([80.76.206.81])
        by smtp.gmail.com with ESMTPSA id f12sm15723042wru.81.2021.06.13.03.18.31
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 13 Jun 2021 03:18:31 -0700 (PDT)
From:   Matthew Hagan <mnhagan88@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Matthew Hagan <mnhagan88@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 4/4] dt-bindings: arm: bcm: NSP: add Meraki MX64/MX65
Date:   Sun, 13 Jun 2021 11:16:48 +0100
Message-Id: <20210613101658.3242777-5-mnhagan88@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210613101658.3242777-1-mnhagan88@gmail.com>
References: <20210613101658.3242777-1-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the Meraki MX64/MX65 series. Note this patch should be
applied on top of "dt-bindings: arm: bcm: add NSP devices to SoCs".

Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
---
 Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml
index 78dfa315f3d0..7d184ba7d180 100644
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml
@@ -62,6 +62,12 @@ properties:
           - enum:
               - brcm,bcm958625hr
               - brcm,bcm958625k
+              - meraki,mx64
+              - meraki,mx64-a0
+              - meraki,mx64w
+              - meraki,mx64w-a0
+              - meraki,mx65
+              - meraki,mx65w
           - const: brcm,bcm58625
           - const: brcm,nsp
 
-- 
2.26.3

