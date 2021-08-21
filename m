Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C663F3AFF
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 16:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbhHUO1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 10:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbhHUO1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 10:27:46 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EA1C061575;
        Sat, 21 Aug 2021 07:27:07 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 17so12129004pgp.4;
        Sat, 21 Aug 2021 07:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VYf9DRd/QNNJE0qlgwZL5IvPj9fM3vjxa1L3tnLZdAA=;
        b=JzW/OnwYJGYh+C03W/KTE+7ltUNH359Vy2D4+U0kGC5w93mTZ59N+OJQ9OxsHeBfZT
         kBC3FxDVVcL89hixSsQVGf3s8D9GQ6V2ktDYZelNzMznF5lZmY4ZwIUcv2YzXGaR1Ey+
         BQd4Ys/25UMZ3agLGafRxRzBBfmuffUbzrRrttHWvVtBKd8CjQWky1DdzaEOz+I/8DJn
         K0Cgn3uQqDRcBRQ69qC16HhoRTVVcWXuR7oh6/GcpsO/QWlmxsyzaWMeLJduGelpurva
         ClwNjviDPSntMJzM0ZA6IiLJr7ekAw72h4qD/yTtvyFffPXBa8+1w3C4w0RZViKp93eZ
         Bdfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VYf9DRd/QNNJE0qlgwZL5IvPj9fM3vjxa1L3tnLZdAA=;
        b=Mb79E3UcRhxkBY0zvyufz+p5OMpfaweFhuHo2KP/MkjJ1QRd7QPuJZY+ZZSgyPQ4cp
         lFhvAtpnelW88XG3bjOAPD3HDPQQ8xO3ZRqdynk3w5b04dA5bKx8YCADYySYG0OvwKcm
         gUe/0MjFVppKTO7y3RUjLbui9UpXp5hNeldfcMeGYCCNDqTa25Unb6z9QwVp83bZDxtO
         rVq7OSyPCnNl6E2p5NILe+9UfPj66rZVrKpMahVouk8A0Kwk+x+VO/2/rqNxcg7A7T/k
         L6lCN4MrYhO9yqq/xlOe4/P9FCCxrNE5quNITRfkKsg73HufkUP4zYdLXTJGk/wgusnL
         y+7g==
X-Gm-Message-State: AOAM530EXvw2q/8J7nrQScTwWCl4ThdufZ7cO+fcTSrifb0kMGfH/HVc
        WTSKCWGu8CtianTCP65WYYj3lfRobJy0AQ==
X-Google-Smtp-Source: ABdhPJyEWNU4GkoJmwX1ceIv9AGx76IJdRR0lvzcyxD8Am78wb1BPDeaJKzg9yzCh0RA6e7aLePq8Q==
X-Received: by 2002:a65:6a0a:: with SMTP id m10mr23829753pgu.82.1629556026610;
        Sat, 21 Aug 2021 07:27:06 -0700 (PDT)
Received: from localhost.localdomain (host-219-71-67-82.dynamic.kbtelecom.net. [219.71.67.82])
        by smtp.gmail.com with ESMTPSA id a10sm10515831pfn.48.2021.08.21.07.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 07:27:06 -0700 (PDT)
From:   Wei Ming Chen <jj251510319013@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, balbi@kernel.org,
        gregkh@linuxfoundation.org,
        Wei Ming Chen <jj251510319013@gmail.com>
Subject: [PATCH] usb: gadget: Add description for module parameter
Date:   Sat, 21 Aug 2021 22:26:47 +0800
Message-Id: <20210821142647.2904-1-jj251510319013@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The description for "qlen" is missing, and there is a description
for this parameter in "Documentation/usb/gadget_printer.rst"

Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
---
 drivers/usb/gadget/legacy/printer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/legacy/printer.c b/drivers/usb/gadget/legacy/printer.c
index 2cd389575084..ed762ba9b629 100644
--- a/drivers/usb/gadget/legacy/printer.c
+++ b/drivers/usb/gadget/legacy/printer.c
@@ -50,6 +50,7 @@ MODULE_PARM_DESC(iPNPstring, "MFG:linux;MDL:g_printer;CLS:PRINTER;SN:1;");
 /* Number of requests to allocate per endpoint, not used for ep0. */
 static unsigned qlen = 10;
 module_param(qlen, uint, S_IRUGO|S_IWUSR);
+MODULE_PARM_DESC(qlen, "The number of 8k buffers to use per endpoint");
 
 #define QLEN	qlen
 
-- 
2.25.1

