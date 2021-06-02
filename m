Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739AA398647
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbhFBKUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbhFBKTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:19:45 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9ABC06138B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 03:17:51 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id n4so1722738wrw.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 03:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gKWfoEYc79d/DZOeZ8NSwXdjHyPPS/zrdGTYbV6jFgI=;
        b=t9c3Ok2U2XnbkvwgO1ViAtbEPfPg8i++Io7jx1sRwNxylsOdhobN8W3brVzyhGDdQy
         rivI7LgW3aIcixtJ/Q3Ehm24HetEMmOwZHVOGT/1ePMuyclfalyLIVs38nLEG3EpoMi7
         zGNr38BFeFx0xmWW4rjBlebzSYikORdn0JH1alk8TgqmHfhBBujThpYzUf1kjbk/nf7T
         rYo2fgGE9MBSMwXtJUvOnpJlIpjuLM36wSxbXC/Y6HWJnec1I5FcIun1384JwCTH795m
         s5r6UA9OOCNWYdVkH8lzAq4PdqNX7ptpVPTf8OC9a5T7XDX1R75sgeawq0+YW0+mFLx7
         LP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gKWfoEYc79d/DZOeZ8NSwXdjHyPPS/zrdGTYbV6jFgI=;
        b=njJS++ZCVQDYN8BlIEpklsVQ7vShw75Z9gvS4tJRTorwl0Hw8pq+kfCtfVsFBZiDY4
         E5YNxmD1k2SFHD2cUllTa7SFoSAbZIvcTJij7EUrzLfPw2nQmETXGTYsMw25AuCfiMcE
         hYG3XhwNCS+c+d1eBfiTVY+/I8pr6XGtGr+Afff39hOhyPyU/5fEpfwg0wHg3kA7+GeW
         OyunQKSH3Qw8kpL6hJx7CcmIJWdmSWdVbG/ctdnW7QzFAiychAXiPGHOPFsVnaWHo+ZT
         YyDMod/QdjnorSGvVxZOItyxBC/c8KIJEsuaZTe+fl2bWONArvYPqbI7nXCVJCFwjxFK
         c6RQ==
X-Gm-Message-State: AOAM533f9iIkCa/r81/ayrrm8M+1zw1v8Q8Ycd0yYJ91jEJLp5qAxerV
        vpeC7A0dRETN+FuPsL3pUTFA5g==
X-Google-Smtp-Source: ABdhPJzgaX9hoMdjBzbQoxzSpt/nMKR1xURv7VlgQLgZOWH3wZ9ZF5Mt6cvMf7q+P6QLZhHeEVc8mg==
X-Received: by 2002:a5d:4610:: with SMTP id t16mr4022764wrq.324.1622629070173;
        Wed, 02 Jun 2021 03:17:50 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id q11sm1593265wmq.1.2021.06.02.03.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:17:49 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org
Subject: [PATCH 17/21] ide: ide-acpi: Mark debugging variable 'bus' as __maybe_unused
Date:   Wed,  2 Jun 2021 11:17:18 +0100
Message-Id: <20210602101722.2276638-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602101722.2276638-1-lee.jones@linaro.org>
References: <20210602101722.2276638-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ide/ide-acpi.c: In function ‘ide_get_dev_handle’:
 drivers/ide/ide-acpi.c:126:15: warning: variable ‘bus’ set but not used [-Wunused-but-set-variable]

Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ide/ide-acpi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ide/ide-acpi.c b/drivers/ide/ide-acpi.c
index 9a4ec281b9854..816ebbbf699b5 100644
--- a/drivers/ide/ide-acpi.c
+++ b/drivers/ide/ide-acpi.c
@@ -123,7 +123,8 @@ static int ide_get_dev_handle(struct device *dev, acpi_handle *handle,
 			       u64 *pcidevfn)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	unsigned int bus, devnum, func;
+	unsigned int __maybe_unused bus;
+	unsigned int devnum, func;
 	u64 addr;
 	acpi_handle dev_handle;
 	acpi_status status;
-- 
2.31.1

