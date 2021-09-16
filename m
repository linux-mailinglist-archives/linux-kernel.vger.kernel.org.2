Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9607240E5A8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 19:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345344AbhIPRNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 13:13:43 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:54100
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349604AbhIPRG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 13:06:26 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 31AA43F30E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 17:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631811904;
        bh=OstzCEYmtVLZNRdG6WO7Mm1Vo0KZNtl5VBM7iApmnEE=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=rra7U5efaiOXE+xiznz8KE/3OV7kc0Y+OsQ6cZCC20dvoFlx72aRJ2j6kAoy5jhM5
         GZStM7UxC04qjfxQbHXEYsf7rouSH6OvmkCrIeGWCn/VpSh0YguptRzIR59T+t4OWy
         zieQ5huQfbD72q5iKrDdy5hAR16yAy0h4OppmZ66s21BlcxQ0zmUBV21comac2TxMs
         xsKZ2V8sth6BPRgo61tGPwBfBDfDsOx0lwk9Ksg47/IDgtoClpHiuLmsyVAqfoagPD
         EIDWFdEQEZakMHuaaY4KT08MwIVHQa+HDEPtp4Cf47qpyMIPPVjvk71VTHPcmcLfOZ
         SuwivjzT5apcw==
Received: by mail-wr1-f71.google.com with SMTP id i16-20020adfded0000000b001572ebd528eso2687466wrn.19
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 10:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OstzCEYmtVLZNRdG6WO7Mm1Vo0KZNtl5VBM7iApmnEE=;
        b=tvN0V0/fCrz/H4dju+lfrG0S2YbUTa9sHOrbHGSvmVC/lDFU9ny9GA/igZXSlWTpU/
         5+EJmze5bfXpfAwnHnelM5WR2OzVwrrObJyl2wzgKSwFzo3G3rPsn0+DG5A9S6FT4KsB
         SEdf8CbsASbH8J1My6/16Y5IqJIcMcjA8e81QyBsVxSJn3vYscb4mUSo4EStfHjZjMhw
         /gy9zg4B5ycggtEf+CcWU5yijXgtXMvV0gGXs34PoGwCDyJXUpBrxwJOfykT9436QwWm
         hLIs7BEZ2uUqWwAf2ojrjd6N+NHkAZsn/Xaq1LyfKYL9Y7MCHZemLAzm8b/Md0AO5muU
         VMlg==
X-Gm-Message-State: AOAM532TYa2FO9dQRULJFVd/EwJJGlYQ0D1vkdjj2hewVol7hWL9y3FU
        P6KTRWA9rKKKC38rb47A0ADvk3QM/FjqwvvF3wk0mt0n9mhmPJAGR3W/gCKdH5o+ByUR0Xi6xgc
        CQ/eo0lMKb5GGpWqNct0ILh9/OJjYIWbIaEL8wzDKcg==
X-Received: by 2002:adf:e40b:: with SMTP id g11mr7347751wrm.313.1631811903572;
        Thu, 16 Sep 2021 10:05:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4kl/6AH0mpphfd4mDrnsfnhni4/TUU7nT32lFb3Prdb2KZaNGd9Q9JLbukKSrmVp+BXBQqQ==
X-Received: by 2002:adf:e40b:: with SMTP id g11mr7347728wrm.313.1631811903378;
        Thu, 16 Sep 2021 10:05:03 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id h16sm3971694wre.52.2021.09.16.10.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 10:05:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] video: fbdev: s3c-fb: drop unneeded MODULE_ALIAS
Date:   Thu, 16 Sep 2021 19:04:59 +0200
Message-Id: <20210916170459.137696-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MODULE_DEVICE_TABLE already creates proper alias for platform
driver.  Having another MODULE_ALIAS causes the alias to be duplicated.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/video/fbdev/s3c-fb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/s3c-fb.c b/drivers/video/fbdev/s3c-fb.c
index 3b134e1bbc38..1d88dcd3e26b 100644
--- a/drivers/video/fbdev/s3c-fb.c
+++ b/drivers/video/fbdev/s3c-fb.c
@@ -1810,4 +1810,3 @@ module_platform_driver(s3c_fb_driver);
 MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>");
 MODULE_DESCRIPTION("Samsung S3C SoC Framebuffer driver");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:s3c-fb");
-- 
2.30.2

