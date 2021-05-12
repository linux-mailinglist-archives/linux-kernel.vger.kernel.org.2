Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB7237C083
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 16:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhELOov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 10:44:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60081 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbhELOor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 10:44:47 -0400
Received: from mail-vs1-f69.google.com ([209.85.217.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lgq5K-00058E-PA
        for linux-kernel@vger.kernel.org; Wed, 12 May 2021 14:43:38 +0000
Received: by mail-vs1-f69.google.com with SMTP id g28-20020a67d49c0000b0290226baf5716bso11264488vsj.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 07:43:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TdWB/Esx7MvhSHhrINPBmiVw2zi4y0P4I0ON0o9Ugro=;
        b=V7vii5N/OVsZt4V1Vm2PSaG9xekFP71Nb9PX2ws6ty9BK+H2K0cA/oYxtXGVRKMpf1
         mg1/bEsvvKlvFefbMoFSvG3O6FzfPUovPD8FfEPEjVdBHrgbSU+FVq3tDVHnWEw1frks
         INTP910/dm+iJWxewnrCe7K7banKs5rRKqkuiejyrsME6xufrmGNLQeBTo6L9noFm/xW
         +EL5bpgSoL3IUp8TYSIdQGNcPPq/MLY5sKPnDXCpu1nOqjttHfngkTQDQzGbdQj7+QHY
         P9spr7MiUlBnSNcJyPEPLRj7N1217RiPn102xaU6nAzu+GI+3Xr9o/AtFFsmOychA3s4
         0GDw==
X-Gm-Message-State: AOAM530FcVrvwwXHPjov1OWt1NmnRXLRLfeTF8zQcND7wnPDy9Jb/Jn6
        PGPZsIpmx8Dz+qs3KbxXUMt4wYfoW6G0G7Vbfe5FHlNw8YmXs8MvbZulTDVzeoR4DlCj+Gq3vgK
        OBl6jpBqGjBhDc6r5hhnffuDwuyK3glwriLiNB9879A==
X-Received: by 2002:ab0:2486:: with SMTP id i6mr32363607uan.51.1620830617953;
        Wed, 12 May 2021 07:43:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwmS3AcxaoVkRWOVvL8RHwnGNz+Q2MxoouobMXIqpUEwxbzAIjuzBVl5OO0VdTkhtYHNk9dQ==
X-Received: by 2002:ab0:2486:: with SMTP id i6mr32363581uan.51.1620830617806;
        Wed, 12 May 2021 07:43:37 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.6])
        by smtp.gmail.com with ESMTPSA id a5sm1641vkl.19.2021.05.12.07.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 07:43:37 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-nfc@lists.01.org
Subject: [PATCH 2/2] MAINTAINERS: nfc: include linux-nfc mailing list
Date:   Wed, 12 May 2021 10:43:19 -0400
Message-Id: <20210512144319.30852-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210512144319.30852-1-krzysztof.kozlowski@canonical.com>
References: <20210512144319.30852-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep all NFC related patches in existing linux-nfc@lists.01.org mailing
list.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index adc6cbe29f78..83f18e674880 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12900,6 +12900,7 @@ F:	net/ipv4/nexthop.c
 
 NFC SUBSYSTEM
 M:	Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+L:	linux-nfc@lists.01.org (moderated for non-subscribers)
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/nfc/
-- 
2.25.1

