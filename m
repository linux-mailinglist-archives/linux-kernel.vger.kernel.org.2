Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D70380802
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 13:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbhENLEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 07:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbhENLEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 07:04:41 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E4FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 04:03:30 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id ep16-20020a17090ae650b029015d00f578a8so1458175pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 04:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KYhwRsIjmmDQoRaXIA1DH3Dl3o2+V2T44/0mjaXPLrw=;
        b=iwJHfLjkOvhpxGaJZlhJAFNsXhc7Ghol7euXzbchTWMkLDKt1nWr4rpecOIA5UyeIw
         7CuO9Y8307qEWsVFclxlXr3rnt2HOswgzocklhHul1nhS23o1PQKrwKKx2l+bVWBRKTg
         t+AoL4u4c8nE6fY7copBOwjQc/NeV35LoBYALf1C3rHA0ESKlIDIFE5nEEh1QZ68zUh9
         SbCsqnnN2HXmRTpWclGWXMc1xPjHxbPl0wsF783BlnIYf6+X8Cp/w7n2vbOMrjGZdgWu
         Hqi4+WSBEI44mRLTETcX476wT5f7M1x5FIgk+yVbAAJCMhIczwKzjvRXkCFLTcu6ZP39
         3knQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KYhwRsIjmmDQoRaXIA1DH3Dl3o2+V2T44/0mjaXPLrw=;
        b=qA1ZsDidGpY3hgR4q+zQ6zIUy7bCeQhdsm8lEJ3uW7eOwPbK/wr7xR3OvjcF709acX
         ymxZJHIuZ3npgbkY4JRRfTHKCPN1R357334rlruBEf+FeVJOSa41ehIJc+nhrT2EUoFr
         w5YGm5H8r7iLh9RbDGocHEak8PAZgEF28dcphBRQQ+HoySxdwd8aq5QdQwTsSu7KqbPe
         xtFZ8EDm2siRXJKhotPZkYKuDoPqLv9/zipoVtoR+VI//Ov5gCgWg0R2j+kuPGVuw/aF
         UNJ0kjjQq51MPcDYfJfqxWyY+sSjKn9Gpm8npmw0FCeYmszJ+IYgOrvX+VyXhuOAsKwh
         GKOw==
X-Gm-Message-State: AOAM532/mrmq3Xcu5Ki3Yl8XZLbeFOZtezVdFmmfEE0/xX4CrN1TnVJs
        eouTxGkNh52KhM4M7S06PUY=
X-Google-Smtp-Source: ABdhPJyNyPORn3xFQWQJILEcGf6+yqjAPhL5UUABeWMhxt+R7LbI0/VgjSmlMmWC47zJA6Z0L8VDow==
X-Received: by 2002:a17:902:bd4c:b029:ee:d673:198f with SMTP id b12-20020a170902bd4cb02900eed673198fmr31157655plx.19.1620990209697;
        Fri, 14 May 2021 04:03:29 -0700 (PDT)
Received: from test-System-Product-Name.sunix.com.tw (61-220-142-250.HINET-IP.hinet.net. [61.220.142.250])
        by smtp.gmail.com with ESMTPSA id v18sm4108254pff.90.2021.05.14.04.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 04:03:29 -0700 (PDT)
From:   Moriis Ku <saumah@gmail.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Morris Ku <saumah@gmail.com>
Subject: [PATCH 2/2] mfd:Add SUNIX SDC series mfd driver
Date:   Fri, 14 May 2021 19:03:13 +0800
Message-Id: <20210514110313.4072-1-saumah@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Morris Ku <saumah@gmail.com>

This patch add support for SUNIX SDC series board.

Signed-off-by: Morris Ku <saumah@gmail.com>
---
 mfd/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mfd/Makefile b/mfd/Makefile
index c1067ea..0a59187 100644
--- a/mfd/Makefile
+++ b/mfd/Makefile
@@ -256,3 +256,6 @@ obj-$(CONFIG_MFD_ROHM_BD70528)	+= rohm-bd70528.o
 obj-$(CONFIG_MFD_ROHM_BD718XX)	+= rohm-bd718x7.o
 obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
 
+obj-$(CONFIG_MFD_SUNIX_SDC)	+= sdc_mfd.o
+obj-$(CONFIG_MFD_SUNIX_SDC_PCI)	+= sdc_pci.o
+
-- 
2.20.1

