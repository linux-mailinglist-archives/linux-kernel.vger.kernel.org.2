Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFFB3F0CE9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 22:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbhHRUpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 16:45:16 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:53336
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233517AbhHRUpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 16:45:14 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 4311740CD2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 20:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629319478;
        bh=w/RbWNVq+6eK1IK1LMIbc97kV5SfHCBYyyVBgM9fYUc=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=qNLWBLXlYXs6NOwRt7SAuypw46XqdPYepDPl/6NcT0sTvhnCBeRRJZl6ypFewI8I4
         VvU4lc/81nIgs7A79GEyAj1J8O9ofMyZHYSEOgQNByEGsP52Xaz2hn2kJ81+e3foWe
         CLsc/kGgA+9F7FdCdp1BPLTMuENy30gSdhgwlcTwzz62ctEQNafd9r2Dlzv+EYCo9p
         3vkEtsHyeSP7WL3npvqo20+Q9spMEoCunABbslRwIKo8yblvsP5QOuE2+r/fzQ1nqL
         wqG4LQZZ0Rvm9dWiQVOGgWHpWKD6C7tBSVlZ3q0fzn6Xcs9NrsJ8XLnv1IjwNDNFTs
         XwPD7HdHPQKQw==
Received: by mail-ed1-f70.google.com with SMTP id b25-20020a05640202d9b02903be7281a80cso1677487edx.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 13:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w/RbWNVq+6eK1IK1LMIbc97kV5SfHCBYyyVBgM9fYUc=;
        b=hMTmsBzCUcLa4cvLg5XykejCxq/Enejch03z3wsnDClDZ3jgWXrpwvbxraHWQZdh9e
         U7PCzxrqFLnihcrENlWqSEU8dqV27OITcxGvBMAbxLni0W7jfnPbGv78+ry8AkBMlKv+
         WyWQhcRclIZYvACrx7k5KSHE0Qv4hKktqXKVMCk0h6r0ew8Az5uBXlMlUU+FrGoGbF4+
         AdcMfrHs1cVtYeCgBgJhHKgzRTsjmcb/tkb9uqPceujitCcdqwAiFdDgFwp8dkM6tdTp
         W1mNXjrf1IpMLQps0V4POZFvxAq1EAalZWiF7YkyUGqyy9JKY7TVPtpQA+Lb4zsD/FVT
         YeVw==
X-Gm-Message-State: AOAM532sf3yzK6DdCpu05uFTTlDmoasnkqCiQD0Av46tda3zGqEdrUN1
        mhR/Rq3sG3+xHjjPoyG0/4/tKHmEZxA+yMfkRvBAOjf/X+H7mektVgpVQdAFDquQ5qD2xGwe8pr
        vUss0kJM9ettX++uA1AYFIuAzsb/Z6zxorqxEoi7cEg==
X-Received: by 2002:a50:d749:: with SMTP id i9mr12432941edj.248.1629319477835;
        Wed, 18 Aug 2021 13:44:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjqxRCuuOtlEqf7OA30Ywtxe0S0ibN48o7NzGEO8v0ICIqx5eRtOtCcHicPX3MQxUZo4bEDw==
X-Received: by 2002:a50:d749:: with SMTP id i9mr12432928edj.248.1629319477667;
        Wed, 18 Aug 2021 13:44:37 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id j11sm341372ejy.112.2021.08.18.13.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 13:44:37 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Jason Wang <wangborong@cdjrlc.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH][PULL/direct] ARM: s3c: delete unneed local variable "delay"
Date:   Wed, 18 Aug 2021 22:44:22 +0200
Message-Id: <20210818204422.17919-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <wangborong@cdjrlc.com>

"delay" variable on line 79 can be deleted by returning "0" on line 88.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
Link: https://lore.kernel.org/r/20210624055627.22295-1-wangborong@cdjrlc.com
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---

Hi Arnd and Olof,

I have just one patch for Samsung ARM mach/soc, so sending this
directly.

Best regards,
Krzysztof


 arch/arm/mach-s3c/mach-gta02.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-s3c/mach-gta02.c b/arch/arm/mach-s3c/mach-gta02.c
index aec8b451c016..418939ce0fc3 100644
--- a/arch/arm/mach-s3c/mach-gta02.c
+++ b/arch/arm/mach-s3c/mach-gta02.c
@@ -79,13 +79,12 @@ static struct pcf50633 *gta02_pcf;
 
 static long gta02_panic_blink(int state)
 {
-	long delay = 0;
 	char led;
 
 	led = (state) ? 1 : 0;
 	gpio_direction_output(GTA02_GPIO_AUX_LED, led);
 
-	return delay;
+	return 0;
 }
 
 
-- 
2.30.2

