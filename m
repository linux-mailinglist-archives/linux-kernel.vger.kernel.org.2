Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23AB4398653
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbhFBKVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbhFBKUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:20:08 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE77C061358
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 03:17:54 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z17so1708589wrq.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 03:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O++OUhPnombOqG4IjFy2Q1V542JLHmoGcDivLsFbcQs=;
        b=ENdVDcJ7hgcy5xRlPjOOnB5DPqcJ9+dvg90YDBjFZ75E0zsuv8ZJhzbszxzoZenlRN
         aPhKCc5jmqEX8LHBb9AlpT68BAP6QvNx7dHAmeZCV6ZQ359pjZCKd3hX3VG4LZJlxKTB
         rP/0NaUH/pCrN6WlSwuxr1cfUcJXyD/0L8KKdHFVsE9DfzyB1j3vermBVtvq8/RdUVDw
         MzJH011vXEgSYCfztXRxTW7KOB8CQ3cH2AEzhYPcTDFMeZSsvzLBDF6EBuAimORLzRhf
         tWzs0s8WMAtZPiTjejpmI3biH8RvRx8l+VVI8is54w6w7LAn8pmMhO2+qX9uBbPN/EuF
         AUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O++OUhPnombOqG4IjFy2Q1V542JLHmoGcDivLsFbcQs=;
        b=Gs3D4O6Mh5r/IoicssMcZFKkIPWWPy/PQxWOWwMkfoBJvW8lq696H00F5/6y9xJeSo
         AzxhOE4vyfCDY8YXJO6Pea35aZ6F9H7qIDXvHDR1sZoNSTl5uXOgX81wct75fYOFBNMH
         7vhTaAPI6t6K1InyXImAjXJeVf/BOYbixyqur1/7R4+mOOdR7VYGnbKsSHbJZQAvK5CR
         4kSTQRTGMehiB7t7cZ59wgqnBgLOk8yeYyYLSyPAHDDHXtJ/b3pBUx+QExP5t/9Uw/lr
         UnFYR0atrAjMWa7cDotFHpktJbLQAgw9GMfKcss43XONf3XazRkpnQL/gqR8pvgBDEun
         Z2Iw==
X-Gm-Message-State: AOAM531VnSUZC3EZarweStoS7kESHvotddRFBrV9ew9OlY4Oz7WMzERr
        F6OEzAZntxhwF3YNsuGNVvOISw==
X-Google-Smtp-Source: ABdhPJyw4df+1q/Wbu7sw08ZGjECOWBii9wPOGpX7cNc/QnKCMyFaE6vqJ3jJmo9DWrcbDVvM14ISQ==
X-Received: by 2002:a5d:5271:: with SMTP id l17mr25857039wrc.142.1622629072927;
        Wed, 02 Jun 2021 03:17:52 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id q11sm1593265wmq.1.2021.06.02.03.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:17:52 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org
Subject: [PATCH 20/21] ide: ide-acpi: Provide missing description for param 'obj_loc'
Date:   Wed,  2 Jun 2021 11:17:21 +0100
Message-Id: <20210602101722.2276638-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602101722.2276638-1-lee.jones@linaro.org>
References: <20210602101722.2276638-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ide/ide-acpi.c:229: warning: Function parameter or member 'obj_loc' not described in 'do_drive_get_GTF'

Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ide/ide-acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ide/ide-acpi.c b/drivers/ide/ide-acpi.c
index 816ebbbf699b5..fd80789722bbe 100644
--- a/drivers/ide/ide-acpi.c
+++ b/drivers/ide/ide-acpi.c
@@ -214,6 +214,7 @@ static acpi_handle ide_acpi_hwif_get_handle(ide_hwif_t *hwif)
  * @drive: the drive for which the taskfile settings should be retrieved
  * @gtf_length: number of bytes of _GTF data returned at @gtf_address
  * @gtf_address: buffer containing _GTF taskfile arrays
+ * @obj_loc: placeholder for return data
  *
  * The _GTF method has no input parameters.
  * It returns a variable number of register set values (registers
-- 
2.31.1

