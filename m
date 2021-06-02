Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9033939863B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbhFBKUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbhFBKTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:19:32 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126F9C061347
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 03:17:45 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id g204so903905wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 03:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O9iIf6zIMattTW/alV/9VT7gtBfDmu2Z2RdNdHc+834=;
        b=ONIgXmYJd1qjLKOTGHrbCG3Urp/fw+Op4avACr5zJQCxd60DT/K8uer8Y20+742e+6
         9KJZb5lnFhuN1eE6sb/NimLHBWLg6L/fypednUQq8Ir4LWI9lSQzcpgexTJDG0HMA9C3
         yRopcrYziW+Eai2VyR2J/YVyO7p0x0f2wtIgzmlZN83cdQ9p9iK1iaiaCnVukMFP81EE
         ouF0nr9yBSitL0XvK4lxHxuYgRtFiG2aSUSIGf8AgBigEUvNqX6kup6JIvUZKMBC39r1
         VmdqgUWFstZsj0rJnJLA9LtLRKiBH7vDLUZDR6XkFVEEGRzzvmw4qYrrUsMobvvSlL9L
         ROgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O9iIf6zIMattTW/alV/9VT7gtBfDmu2Z2RdNdHc+834=;
        b=I1HSUnBI1o7qQscVuUu2ux4nMYZ3S2TVSI3I6v8UN5wuXmwfXvudGC5pPAEm/s28y1
         //EM/MnJI6NIP3sc2MyoD/fxNC1z55iNqT/CwOXQBvrXQfonD/fhlWNsIJgUuxHGz8qZ
         Iq0HBnVmyzUuc/1xTNXYeBssbDxBZ7puNhJVcTASvavDXv5D+jmp7KPXmUlrRiIiM/GM
         W+c1akTlQ8pXeRaBgOpL/3mNZGGxGp3piieJ0C2M3cULlfB5/hT4SXp+hUWPR/GjDjCD
         qlYxiCodyR4yfdm2jb9PB4/xcgSOTK4AHGq5n0TXwWUkF2ttf7pRwfAxkOm76ZgB5b11
         aiyA==
X-Gm-Message-State: AOAM532sccji8xvboHZYafrb5gnhQI3ovliXL5YbpQ5bKecknlAasGy5
        EuWrHXg4gNMExqZwg3TNvOrysQ==
X-Google-Smtp-Source: ABdhPJwRdQ1H5GkOhiTpyCUEjoVrQCMIlPxMLgxh17oU9dl1M2Cdmlw57RsVhL8ZO/wJ3//pVi98jA==
X-Received: by 2002:a1c:ed14:: with SMTP id l20mr4328451wmh.20.1622629063711;
        Wed, 02 Jun 2021 03:17:43 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id q11sm1593265wmq.1.2021.06.02.03.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:17:43 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Andre Hedrick <andre@linux-ide.org>,
        Frank Tiernan <frankt@promise.com>, linux-ide@vger.kernel.org
Subject: [PATCH 10/21] ide: pdc202xx_new: Supply missing description for 'set_indexed_reg()'s 'value' param
Date:   Wed,  2 Jun 2021 11:17:11 +0100
Message-Id: <20210602101722.2276638-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602101722.2276638-1-lee.jones@linaro.org>
References: <20210602101722.2276638-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ide/pdc202xx_new.c:84: warning: Function parameter or member 'value' not described in 'set_indexed_reg'

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: Frank Tiernan <frankt@promise.com>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ide/pdc202xx_new.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ide/pdc202xx_new.c b/drivers/ide/pdc202xx_new.c
index 7c276b8aeb5fe..537521213e148 100644
--- a/drivers/ide/pdc202xx_new.c
+++ b/drivers/ide/pdc202xx_new.c
@@ -79,6 +79,7 @@ static u8 get_indexed_reg(ide_hwif_t *hwif, u8 index)
  * set_indexed_reg - Set indexed register
  * @hwif: for the port address
  * @index: index of the indexed register
+ * @value: value of the indexed register
  */
 static void set_indexed_reg(ide_hwif_t *hwif, u8 index, u8 value)
 {
-- 
2.31.1

