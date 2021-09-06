Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89BDB401253
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 03:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238623AbhIFBCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 21:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235845AbhIFBCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 21:02:20 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F196CC061575
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 18:01:16 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id v20-20020a1cf714000000b002e71f4d2026so2851253wmh.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 18:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SO/Jocqxu+IOs3sdvJh2k+WzMJN/xlAm6Qko2Xrfsn0=;
        b=2L2dI9zPAA6cXt7gicaLBZtxQ+JDoSdl0FDbZAFCx8fyPMqNoOZOxW5r/pHphayhR7
         QIW+oYqIDWUyku2257ZduQoMYzXQzzOe4RePDhPgs5a4y/uAdYQQ/SVT/kvFXcIT29Ri
         GJMj3Kq/BhhSPWadeFrNc/39bFEw5XzhggmO0J+/cCDGaizTfCClvHgdIh9QZTzE/R/F
         vy/6MMlAMIMMCnbdV7MrwLbhD0vBn4FCdhJFbioOVAREYAbHVBpsmqyccp7Ytv221yw5
         /z51K/IBzGVwqAqY619qDwfhlmGRcJkIJ3CtkmlFxpRKTMmd9PNYm/sqfduM3jm+EzgE
         IHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SO/Jocqxu+IOs3sdvJh2k+WzMJN/xlAm6Qko2Xrfsn0=;
        b=AESX0yqmaTpqem3KaIpZF5ZoTpDIF1zZ7y5KHLtkByKsc5j4Qou2PkfY2NJoz7+4Pw
         hDPsLe6m+0qKrIxjOWmiq2TXb7TAh+IXCvGQheeeKHxuCnYmHVBMjokkYFBDvZQTqWFR
         HRUM4i5hpopeJknw0CEF/zGZ6RUbMHagLeBdLvf20QZFvRyimt7Y2PIH8lztLzlbs25t
         8tuMUR8I7aVgG92J/iHWO1MGlcHmELz/cQ+DAetos221Ns5Sbq/+rtLeUGD4H++MTah3
         Kx9ogMLdtv/rnVQhCnyBSqhD4fAOdiGuUYtG6b621ZupYVNNDJ5izcKcoEqacWz7MoNS
         N72Q==
X-Gm-Message-State: AOAM530l+/qRzPcBgXBK74N3SHhNCcQ7VRI8e5kfkVNrVn4DE9RT0sTw
        JxbFXTJuCXL97Aqu+OQvCTHh5Q==
X-Google-Smtp-Source: ABdhPJwY7z9AQegBqrJ3fbGKy1g1YlTg0s3+p6zSwNbqu8aCRqjWrOuS2T2NwQOX7STqXdpxSIggCA==
X-Received: by 2002:a05:600c:3ba3:: with SMTP id n35mr8618291wms.166.1630890075576;
        Sun, 05 Sep 2021 18:01:15 -0700 (PDT)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id r25sm5151232wrc.26.2021.09.05.18.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 18:01:15 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 08/14] staging: r8188eu: remove interrupt_handler from struct hal_ops
Date:   Mon,  6 Sep 2021 02:01:00 +0100
Message-Id: <20210906010106.898-9-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210906010106.898-1-phil@philpotter.co.uk>
References: <20210906010106.898-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove interrupt_handler function pointer from struct hal_ops, as it
is unused.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/include/hal_intf.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index fa3c09e3c2f1..c4c04f929225 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -156,8 +156,6 @@ struct hal_ops {
 
 	void	(*read_adapter_info)(struct adapter *padapter);
 
-	s32	(*interrupt_handler)(struct adapter *padapter);
-
 	void	(*set_bwmode_handler)(struct adapter *padapter,
 				      enum ht_channel_width Bandwidth,
 				      u8 Offset);
-- 
2.31.1

