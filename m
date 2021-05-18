Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11CF93882A5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 00:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352701AbhERWUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 18:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236372AbhERWUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 18:20:18 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBE2C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 15:18:58 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id h9so11315114oih.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 15:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yazsg80d5R8pUukq3uU44JSO6L/ec0vuHN2nnYiZnDw=;
        b=eNHA+60Y70M5AFCs5uRynQCs5aRQ+8RuK/nuh09ecH15Heuxs+6AbybFWwB9+e6D4L
         r30NcwBr3FK1CHmVd1MBIVJBmrI8YQNxIwTG9TKaADff3Rj4p4cvI46t5MbkT0M3sMAW
         /IrRaQC3lHCvS1G0jhfZ8oZHqdBX/uSKJpuxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yazsg80d5R8pUukq3uU44JSO6L/ec0vuHN2nnYiZnDw=;
        b=uPTqiZ4ZJgxIWxOlzIo+4ZV0sRjW4Kc5TvRSKUB8fOh+lvFLr/218TxjGR9cTnGXR4
         hKokyeKuJXXrUeMxiGVl1qXsvU5kkqxBjgrLOemXQML1/3cjjb2iWU3+gIjB6MRdteLj
         kTg0DeKYKBHICU5X50onhh7WxTMEudH9AgpfDB8I02RvTOn9F/uFNcyCg8Aehz1CKjzO
         XzTw975ZRzbaIULfoAYTUXEfUv2MQp+vHpUXHiMBy6dzKq3p5qg7ZkT1hWXPuf0slB2L
         k9Ixb1eersyIzJj0vMXKRKz9M3+oucYLQmo1wrEMlqHslyu4U4ZyBs/KrVD8the5GyAW
         ItnA==
X-Gm-Message-State: AOAM530FLrVOB6uw7xp2R1fmvtdr1UmJ3Fa2TmKxR3FQd+QRXpX9HveK
        S5sZTB/bMUsS4PGLPnbGVSBsKA==
X-Google-Smtp-Source: ABdhPJy89URKoTpM78+NFQ1y4H8rpy5QjDbTENsxB3lAViQQ7zii9kuf3/Fvcr17DQbdi8c7ycmQkw==
X-Received: by 2002:a05:6808:1142:: with SMTP id u2mr5021288oiu.101.1621376338105;
        Tue, 18 May 2021 15:18:58 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h184-60-195-141.arvdco.broadband.dynamic.tds.net. [184.60.195.141])
        by smtp.gmail.com with ESMTPSA id j18sm4069667ota.7.2021.05.18.15.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 15:18:57 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-pm@vger.kernel.org
Cc:     kim.phillips@amd.com, peterz@infradead.org,
        Raul E Rangel <rrangel@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powercap/intel_rapl: Add AMD Fam19h RAPL support
Date:   Tue, 18 May 2021 16:18:53 -0600
Message-Id: <20210518161842.1.Ifec9c629767197bbd80312ebea93ec8bbfafbf06@changeid>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a77259bdcb62 ("perf/x86/rapl: Add AMD Fam19h RAPL support") added
RAPL support for Fam 19h. This CL adds the missing powercap support.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

 drivers/powercap/intel_rapl_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index b9d9eadadbb0..f0799837c2dd 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1068,6 +1068,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,	&rapl_defaults_hsw_server),
 
 	X86_MATCH_VENDOR_FAM(AMD, 0x17, &rapl_defaults_amd),
+	X86_MATCH_VENDOR_FAM(AMD, 0x19, &rapl_defaults_amd),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, rapl_ids);
-- 
2.31.1.751.gd2f1c929bd-goog

