Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB25354147
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 12:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237856AbhDEKtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 06:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234135AbhDEKtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 06:49:45 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8D7C061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 03:49:39 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id fn8so381669qvb.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 03:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vYyE3mZbTCDzxA81uU/nO8mDAdIU/E4f/sVrNUxsbdg=;
        b=CTTko/Wk/fNM1ajS61qm+Z3JC79c/1MK8tKFQk3LWBL+vlET4Jjgq97yknaGKFEQNJ
         yyimvc63RIZujcjUF0M3k7vgl2yb8Pw0aJYoyNb3FjDNDbv/G+2uEwAi6wN9kepHvVn3
         v6/xxgO0Qp2StN5Jiwhwj4MVabqgIe7Wtzk7BktcDu9PPv12Ro2z1SM3i3p7Mbiak/oH
         2+nlxVBTa4EglvRxa7x9FusoxQ32E7GEVigrrtcBdKopwt4uWuhABxDi5b9+4hzbrgVv
         zYO+MZbaw684kFOJQQ6XjFXCu4xMB+yFidTy6bKtJExzdRs/bkVd73w9NCf2tYvyz0vP
         OeqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vYyE3mZbTCDzxA81uU/nO8mDAdIU/E4f/sVrNUxsbdg=;
        b=OzfNRRBSWh93wxSAB6a09Vnm28h1cQnMZnMmdhkJ0fpTynR8FjfRhF387k0YZe8Vz2
         +kQRXN7N0INNFKBKz6XCMOAMdQE3jCAo9m77DwgiDzV1NAPjI5eaoEOVz7eiQ59K7KwM
         +5TlKlSiF9R+gpCyvyKFWQfxjk4d0kdib0FudcMvcCJSw7afCecDzLQU0s6xun58cjv/
         v2ENM1UkZs3oAKVfsQgOermQwirTGg4HCbQys797OBjj93Jxs0iIoSHY0yUwMsaEJ/AI
         VNwZyCSq06g051Eww3u0bN/pXs+tStxA5x1rmnhcXUoU/zqcXLsGtM7eL2H1DV0ZVtfh
         dGLQ==
X-Gm-Message-State: AOAM532EaM3lUCaUzKKfsi3/KiKA5yyqFEJUml2HQYoDFtbufoouUdOU
        8hMVHDWS1G/z/Q4ITmG79QM=
X-Google-Smtp-Source: ABdhPJwLfTnrVFKfgNkeZSI+N7p/ajlybIy6WxRrLCdn0N+iWtm2as/izx4ELXbPILcjjygfP8FJjg==
X-Received: by 2002:ad4:576a:: with SMTP id r10mr12523163qvx.12.1617619778907;
        Mon, 05 Apr 2021 03:49:38 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:214:8290:6b95:72bd:5607:9b84:56df])
        by smtp.gmail.com with ESMTPSA id p66sm13349634qka.108.2021.04.05.03.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 03:49:38 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v4 6/9] w1: ds2438: fixed a coding style issue to preferred octal style
Date:   Mon,  5 Apr 2021 07:50:06 -0300
Message-Id: <20210405105009.420924-7-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210405105009.420924-1-sampaio.ime@gmail.com>
References: <20210403044821.390485-1-sampaio.ime@gmail.com>
 <20210405105009.420924-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changed the permissions to preferred octal style.

Signed-off-by: Luiz Sampaio <sampaio.ime@gmail.com>
---
 drivers/w1/slaves/w1_ds2438.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/w1/slaves/w1_ds2438.c b/drivers/w1/slaves/w1_ds2438.c
index 56e53a748059..ccb06b8c2d78 100644
--- a/drivers/w1/slaves/w1_ds2438.c
+++ b/drivers/w1/slaves/w1_ds2438.c
@@ -388,7 +388,7 @@ static ssize_t vdd_read(struct file *filp, struct kobject *kobj,
 	return ret;
 }
 
-static BIN_ATTR(iad, S_IRUGO | S_IWUSR | S_IWGRP, iad_read, iad_write, 0);
+static BIN_ATTR(iad, 0664, iad_read, iad_write, 0);
 static BIN_ATTR_RO(page0, DS2438_PAGE_SIZE);
 static BIN_ATTR_RO(temperature, 0/* real length varies */);
 static BIN_ATTR_RO(vad, 0/* real length varies */);
-- 
2.30.1

