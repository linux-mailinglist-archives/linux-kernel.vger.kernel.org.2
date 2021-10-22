Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036BD4373E0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 10:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbhJVIt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 04:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbhJVItw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 04:49:52 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3EBC061766
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 01:47:35 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id g10so3945317edj.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 01:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JmAB8n7UaBcqYspnUH1iQzfV3fA+SByJ94PZYXKecgY=;
        b=gyorI5vGrD9IhuHFhU/KkDM1nFaqujFinq+t+bGAHtXot0dwkxhgJSDcxw1mFMZ7OQ
         Ov/Gfysm5u6WJ0BMc7wZv4YbrBq8G6OFNCJEthw+kQ5ayX483OGVkvPW272MrmNOzhMh
         MrP/DzsE1HNWCtBrimo8RzqgtqlMk0qHvcnouR2+AOL8PN3viQVp6Ld83RUD5MrrGngG
         9h3DTIc79we8YhPAZBZ465ed+VvFzulpM6qS+uLffcsz1DXHnJxLO/ElEYvU9QlcYR6S
         VPrK4U1xHb9cd2Z5jL0dhLfbhMGzpFKRV6AWO2WSiAUk5JgKsiC20uV41Okcr43QdezR
         XUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JmAB8n7UaBcqYspnUH1iQzfV3fA+SByJ94PZYXKecgY=;
        b=jm+UNavOpoqisCuRCL2uFvr7RBN1cJgLx7vrY5D2oilz86UAQjifZI9glVRMIsCGIC
         F3WQ3TzdfMstlDxQY/klpmlKaALpgZW+7FuGlvONN9SiAhW7UVp2hwU7A0+XmGflpY+A
         twywuyw8ZJMuC7jeCvjAttu7r9nfMKjs4XssYXEiKTaWmGds1lS9QfKwnVZ4VZJ5E6+d
         uRLaa2aQDMZsk27YGpanvxG+lC4v0qgOi58mT8XR13E3qf4iGs9ZyVNly72uI6aIU7nR
         bkFDuVhboWcu3SeZo7a6DGMDtnVwcNEenGBrA6uv9EM7ZAftInW+DQLw5qDlxR3/r4ek
         kxkg==
X-Gm-Message-State: AOAM531P2ukEcnf0IrmgSK8aXREWv3jY+Ip8ODaJ+e9yWqsYnuZ6t7EC
        7CYOHu2IbfE9P96ifhBmeUo=
X-Google-Smtp-Source: ABdhPJzNNb49pqZzRrAeDU6m19bn2YnCFz9HODjYgSAi54fRKRrKEk06vLI7brgsQVCbNgoEMIYVVQ==
X-Received: by 2002:a17:907:72d0:: with SMTP id du16mr9615355ejc.226.1634892453809;
        Fri, 22 Oct 2021 01:47:33 -0700 (PDT)
Received: from localhost.localdomain (host-80-181-148-119.pool80181.interbusiness.it. [80.181.148.119])
        by smtp.gmail.com with ESMTPSA id au26sm3446979ejc.53.2021.10.22.01.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 01:47:33 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 2/2] staging: r8188eu: Remove unused semaphore "io_retevt"
Date:   Fri, 22 Oct 2021 10:47:27 +0200
Message-Id: <20211022084727.28035-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211022084727.28035-1-fmdefrancesco@gmail.com>
References: <20211022084727.28035-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove semaphore "io_retevt" because it is never used.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/include/osdep_intf.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/osdep_intf.h b/drivers/staging/r8188eu/include/osdep_intf.h
index 90b37655e9e0..0d7009269aab 100644
--- a/drivers/staging/r8188eu/include/osdep_intf.h
+++ b/drivers/staging/r8188eu/include/osdep_intf.h
@@ -34,7 +34,6 @@ The protection mechanism is through the pending queue.
 	struct urb *piorw_urb;
 	u8 io_irp_cnt;
 	u8 bio_irp_pending;
-	struct semaphore  io_retevt;
 	struct timer_list io_timer;
 	u8 bio_irp_timeout;
 	u8 bio_timer_cancel;
-- 
2.33.1

