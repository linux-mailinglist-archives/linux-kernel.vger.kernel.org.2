Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDE737B0D4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 23:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhEKVda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 17:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKVd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 17:33:28 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25380C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 14:32:21 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id g24so12397673pji.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 14:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=oPUPwzBZh9t0vu/KaAlmyWD0blG9DprxJ8AItVStOX0=;
        b=u/O7hLkKI8FSZqZIZLw54oDZaPrODM7HDojqemH3hNRSHPR407bRmHJAR49t458ZZ9
         31JH8wc/21oLfwbRHqhukJ8dmsQhyKNtLcmZIStIEtlRRGGXVTZFzBIliBTWDMPKMaK9
         eBtxI9ctBp0b1hbzSDh0PKfZVQ4auAP2UqOxAVLsfzd55M+Kdt085Ulm3OmpA42yMaw3
         qRVJDCryKn8bvKrWdgNe6GjdgMISzyyEWhGXuK81Ij6xVZEeDkNr6FnLyp751bFXkmYB
         ypVP7JD/MCrUsdDuLON8zJyRr8piNbNKg3LHgY4lJV/sKPlQuVCO5Yl803f5FWX8jhFY
         40YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oPUPwzBZh9t0vu/KaAlmyWD0blG9DprxJ8AItVStOX0=;
        b=c0R9RJO/IPQT2KP5k+IWHcsEIl7EsMK6kOA8ZFMwNvCts9lClDWwv427X8PkJ/7lrL
         We3UcNukLg609rcwLELt2SamiBGLBjG6MnExhSm/HUJS9L316ZxC5OJTF/zEp/2eeluu
         XAQqaM8yLxiM5Op9hqM4yajrqr85vKm0Qnd0wZYtW4vtuXM4D/SRNag/J/5L0IZcWQA0
         nq48g49evgQBeM8jhdnHVrEM7JpniofhlmXE61UiP4sMcVYNo1dkf2kbmIi6YtGl1DGB
         NRHe3fKW8TPuYdc34y1SIbtFGgztd74rcqy0cvv7fMYBcL8mzYNAkigO6FB7d22DXYy2
         DKqg==
X-Gm-Message-State: AOAM533Q9PFlYd3R1345ifVMfs7J+4O/Jcu4VGsm0C/Z3+7P/NC2XbNp
        gMdlfuVt0o2AsBcYQy9Xvdc=
X-Google-Smtp-Source: ABdhPJyAi710RgSjMQ5qa8NLHIwaS4g6CWIMwDcmoX2NFZp0KU/sAeM5cu9ixZxPX3IkrxhsTno4Nw==
X-Received: by 2002:a17:90a:590d:: with SMTP id k13mr37992539pji.68.1620768740534;
        Tue, 11 May 2021 14:32:20 -0700 (PDT)
Received: from tong-desktop.local ([2601:647:4200:13:c47f:5a44:d296:3f16])
        by smtp.googlemail.com with ESMTPSA id f12sm13709116pfv.155.2021.05.11.14.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 14:32:20 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tong Zhang <ztong0001@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] misc: alcor_pci: fix null-ptr-deref when there is no PCI bridge
Date:   Tue, 11 May 2021 17:29:38 -0400
Message-Id: <20210511212937.1269191-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YJrFib6BD8JcX3DM@kroah.com>
References: <YJrFib6BD8JcX3DM@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device might be attached to root complex directly. In this case,
bus->self(bridge) will be NULL, so we'd better check before use it

[    1.246492] BUG: kernel NULL pointer dereference, address: 00000000000000c0
[    1.248731] RIP: 0010:pci_read_config_byte+0x5/0x40
[    1.253998] Call Trace:
[    1.254131]  ? alcor_pci_find_cap_offset.isra.0+0x3a/0x100 [alcor_pci]
[    1.254476]  alcor_pci_probe+0x169/0x2d5 [alcor_pci]

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
Co-Developed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: check before calling alcor_pci_find_cap_offset()

 drivers/misc/cardreader/alcor_pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/misc/cardreader/alcor_pci.c b/drivers/misc/cardreader/alcor_pci.c
index cd402c89189e..175c6b06f7aa 100644
--- a/drivers/misc/cardreader/alcor_pci.c
+++ b/drivers/misc/cardreader/alcor_pci.c
@@ -139,6 +139,9 @@ static void alcor_pci_init_check_aspm(struct alcor_pci_priv *priv)
 	u32 val32;
 
 	priv->pdev_cap_off    = alcor_pci_find_cap_offset(priv, priv->pdev);
+
+	if (!priv->parent_pdev)
+		return;
 	priv->parent_cap_off = alcor_pci_find_cap_offset(priv,
 							 priv->parent_pdev);
 
-- 
2.25.1

