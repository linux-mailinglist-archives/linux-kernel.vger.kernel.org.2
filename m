Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5ACE307D77
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhA1SJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbhA1SFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:05:08 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12781C061221
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 10:02:59 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id m13so6325516wro.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 10:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bku/TZDwGiY5vuh8zroI/7gSSOC7kKg9Wo8De+jk1lQ=;
        b=Nurqslu0d9ZwZ10IWWGqE6G9xt1JePKcmpIrRynNCMdLIAc+57LzYLJKEL7PvrBXjw
         6bGtME1fvy03oT7Jllc0teJLFoQrunhkSoJfyUIWryc3t0vG0CnlN7sFstoC6Ko9HM4x
         /UzgUlxzWm9yrbEHJB8EcxTBGS/m98p7ZpId/OcKIhvBHeFPZ2tm4clYfnYWLSBw/DKE
         yRmbLqUkhOlJ/BmotlqnwRtmPduKAJHrfOcNs2DsYl9yz5s3FNzw71H1HvDIznGpfL+b
         vy4ulT08Wj2ss/C1JDa2ZnxFTJ3DiZ3PZhrdAPB0YttCZ83ZbVSp6dbRcqb0GldlIUq6
         J5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bku/TZDwGiY5vuh8zroI/7gSSOC7kKg9Wo8De+jk1lQ=;
        b=VhklgC9lTcXTuXD/boqxN5dVgiE+5cC38zTC7mV8j9zvYpdvZ5rQjqzDxk/py1gpMY
         ARFFyo5iTM04y79XxLx1GZiHyhC40YtR7JuxzVg7Rof8qMg80XGrgb+Vzsscl9A9rMS5
         ueux80ra9EMCXCc+8xRza+XaqHtD1y7+h5uqW3jY87u1kU2PjM0D41YKJBcMvoClM6Oy
         4FR5gXDSEcp3qxG2Z5mnso37sIc0YZA7O9m99GUmbSwkYS6IZwS6pkJH7AvkERMlgczX
         zDwQOq3lrDCLd0vrmwY9TeXOE8Fo70A9HCp7MgbxzjO4FnVqhzB/lfeGda0ersbmZwq2
         uVbA==
X-Gm-Message-State: AOAM530I4rgAqUfIywgGq+y6HMxwfiqoocGgomgp5ygFEJ9WCFkVJ8m2
        lmDe0c2n1ymTFrxoeJqSjsg713T1c+ZQDYVS
X-Google-Smtp-Source: ABdhPJxrEupt53VzeI+7GcG+/MAFplgDc5K42e8phIxQ6WxAavhFiIMN6vtlA3P8N4zstFeBVpogiw==
X-Received: by 2002:a5d:4e47:: with SMTP id r7mr323827wrt.312.1611856977884;
        Thu, 28 Jan 2021 10:02:57 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id u6sm8280794wro.75.2021.01.28.10.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 10:02:57 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Andre Hedrick <andre@linux-ide.org>, linux-ide@vger.kernel.org
Subject: [PATCH 12/20] ata: pata_hpt366: Provide missing description for 'hpt366_filter()'s 'mask' param
Date:   Thu, 28 Jan 2021 18:02:31 +0000
Message-Id: <20210128180239.548512-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210128180239.548512-1-lee.jones@linaro.org>
References: <20210128180239.548512-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_hpt366.c:200: warning: Function parameter or member 'mask' not described in 'hpt366_filter'

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_hpt366.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/pata_hpt366.c b/drivers/ata/pata_hpt366.c
index 2574d6fbb1ad3..06b7c4a9ec954 100644
--- a/drivers/ata/pata_hpt366.c
+++ b/drivers/ata/pata_hpt366.c
@@ -192,6 +192,7 @@ static int hpt_dma_blacklisted(const struct ata_device *dev, char *modestr,
 /**
  *	hpt366_filter	-	mode selection filter
  *	@adev: ATA device
+ *	@mask: Current mask to manipulate and pass back
  *
  *	Block UDMA on devices that cause trouble with this controller.
  */
-- 
2.25.1

