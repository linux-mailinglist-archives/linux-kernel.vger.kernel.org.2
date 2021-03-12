Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1BE633891E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbhCLJs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbhCLJsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:48:09 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9027C061762
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:48:08 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso15378709wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KspmBqbjk4SwVrkpMki278CpteugIPA4FRqHSDe0Ld8=;
        b=PfGNhCuiylvRyEiNZbO3LIdrXW/jc8eL59kkSyl0fViEKSTvsMn788NKa9LkvSHVLH
         4FoPEU09JiF2MA2h1DJYFfxnkP1qKskNvqzfBDULEjOXaBiPIAbd9KAsZYtf50acv42U
         KQO2+3lXXPHEQOnxhf8KMTySQQKLrWDgGjUc2wVPvb6+oFWCSXYxn39ljfOAxVyKSyXE
         LPG2cZ+0LPQPtEkZAB8jrfbqi3I59gQw1yI1y/8C4evLcB/FPOGPGcLIOA7ncUlrILxv
         K4hRklub2FTrgHEVXdYEhqHkl7q6ZVG2D/lAw2qpgNCXd8AZaE3yHfvnWwiPUMof3izN
         Sstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KspmBqbjk4SwVrkpMki278CpteugIPA4FRqHSDe0Ld8=;
        b=Kk3VoewH32+zHIdqEJmrQKSgBJvreGAeid3cDBKQRsooNinU1oS4zc0g1G9pWzIwuB
         mDY1t5nSTA6sjHNBccVmamloniVjbKOuZf+oeNwXLAINYVmXcduVnT+LTVhrYO12SFMp
         0Ww7BbnCNIa3NdvZL9zosuGjXce7IH/EN7y4g3DayNJCdMGubUKVPpdJomitj/GabeKS
         uBNDJ/J/djCe6BdNLjZ3n8Td0yWPFcCi5IBOEXNsy5QPFcCHhntpQ2+WJyGQTQsSXAbT
         kPzLUCiAIHoF8HTXT5ANddenP99nIR9dWwdXlq93EHFPQmDBfA+9KCgpdH4DX6zEf5Ug
         E02A==
X-Gm-Message-State: AOAM533ydKabdWhr2old28VilhxrKTe8Rd34Xd6ybw7awcHQcC6hP8bU
        TuxxaFIS2F6O+AkuVI+wQHbNCg==
X-Google-Smtp-Source: ABdhPJxEJ4kH9AI7TGyWx1qdbaHektoIOh8enAFviuPK++9j/6n683lyESUY0h4BrPuidfioDst4XQ==
X-Received: by 2002:a7b:c209:: with SMTP id x9mr12178799wmi.92.1615542487458;
        Fri, 12 Mar 2021 01:48:07 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id f7sm1539536wmq.11.2021.03.12.01.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 01:48:07 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Bradley Grove <linuxdrivers@attotech.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 18/30] scsi: esas2r: esas2r_log: Supply __printf(x, y) formatting for esas2r_log_master()
Date:   Fri, 12 Mar 2021 09:47:26 +0000
Message-Id: <20210312094738.2207817-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312094738.2207817-1-lee.jones@linaro.org>
References: <20210312094738.2207817-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/esas2r/esas2r_log.c: In function ‘esas2r_log_master’:
 drivers/scsi/esas2r/esas2r_log.c:155:3: warning: function ‘esas2r_log_master’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]

Cc: Bradley Grove <linuxdrivers@attotech.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/esas2r/esas2r_log.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/scsi/esas2r/esas2r_log.c b/drivers/scsi/esas2r/esas2r_log.c
index b545798e400c4..d6c87a0bae098 100644
--- a/drivers/scsi/esas2r/esas2r_log.c
+++ b/drivers/scsi/esas2r/esas2r_log.c
@@ -101,6 +101,11 @@ static const char *translate_esas2r_event_level_to_kernel(const long level)
 	}
 }
 
+#pragma GCC diagnostic push
+#ifndef __clang__
+#pragma GCC diagnostic ignored "-Wsuggest-attribute=format"
+#endif
+
 /*
  * the master logging function.  this function will format the message as
  * outlined by the formatting string, the input device information and the
@@ -170,6 +175,8 @@ static int esas2r_log_master(const long level,
 	return 0;
 }
 
+#pragma GCC diagnostic pop
+
 /*
  * formats and logs a message to the system log.
  *
-- 
2.27.0

