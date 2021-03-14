Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0B833A35C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 07:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbhCNGai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 01:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhCNG34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 01:29:56 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262A1C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 22:29:56 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id 94so7033274qtc.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 22:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i0AgUiFWAfiDnRbuJ6o2vztOkIPraq3pQVqZ/3yA8Uk=;
        b=rwkADDk9JUQk8WBEAquf3lCL9+4jilHY5ZEw7OabbsNXHQkBvGy9aAmbxqLaRcsBpF
         9C3Bgoc5RRzxwqWlfHzXmthcUllxexK86KTOn9YJhjhYP5VcUT2d3dTYHxGW7+T7SBYl
         oVfv2MALkVZatHEHNHoO7IQ8cF11Vm/0W/cv9E2iCq2SWvCS5ILmizCICzSv/BkmzK1m
         UDYcLQaUiL9iFuBt4uojGg0tGe1su+9xwW1pAW++nErnP5Zt1UxuMxiedvtQxeEc6ofl
         A6E2TDjGGIwRtbDIqM+dfwgE+dp8ltGbAJaJ6jpDUfB2n9NInfY9VuZn+ZrE+7kKyyID
         UUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i0AgUiFWAfiDnRbuJ6o2vztOkIPraq3pQVqZ/3yA8Uk=;
        b=ijev+QrZS/rU24RapiUuWbaNaxtvok86aoHowCddptB5EWclsEFp9iSabO989YBp1u
         j2vVdfzn8RUe8/GPd0m44NTjmo0eXUFWsmaC9Oi5ye6goqLLFB1zFHY+WU+LQ1cYpmMj
         hgEC1/wVsMA3iHui/DKXG4Ggs4kXZY84u09qUYiqtTmmUTr42fKrDq+cmd2N5cBbPr6T
         eSYxUnN4JgD1TYyEKO+q/6O3n83oJHt6W9LKeXYAOok3mhAtcEPL5zgQ78DjKFVwcq6e
         VatXN2fT0a/Vo0Crd6M0Q1mf9N5L4ks6IUdabZQpA6GG3FE06ZJ3GRAvArekGGIXAkM3
         /0NQ==
X-Gm-Message-State: AOAM531usfAxOVDknnzgowxmjqNkUuoBMOLIrkTzNWTVagWdiey104zA
        +PtMW2Oldgr9X5wghSQIhvw=
X-Google-Smtp-Source: ABdhPJxPtwXQJ52MxAMWBVV99YqghbQRh/18lJ7qtqBCNwIbYeJ7p571mNgtk6Q4EzmcDhPvmVNk6Q==
X-Received: by 2002:ac8:76c5:: with SMTP id q5mr18276175qtr.197.1615703395148;
        Sat, 13 Mar 2021 22:29:55 -0800 (PST)
Received: from localhost.localdomain ([37.19.198.30])
        by smtp.gmail.com with ESMTPSA id s133sm8723760qke.1.2021.03.13.22.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 22:29:54 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        unixbhaskar@gmail.com, nico@fluxnic.net,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH V2] tty: vt: Mundane typo fix in the file vt.c
Date:   Sun, 14 Mar 2021 11:57:16 +0530
Message-Id: <20210314062716.28539-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/spurrious/spurious/
s/worse/worst/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Changes from V1:
  Incorporated Randy's suggestion.

 drivers/tty/vt/vt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 284b07224c55..d9366da51e06 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4448,7 +4448,7 @@ void poke_blanked_console(void)
 	might_sleep();

 	/* This isn't perfectly race free, but a race here would be mostly harmless,
-	 * at worse, we'll do a spurrious blank and it's unlikely
+	 * at worst, we'll do a spurious blank and it's unlikely
 	 */
 	del_timer(&console_timer);
 	blank_timer_expired = 0;
--
2.26.2

