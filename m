Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F8336BB79
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 00:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236803AbhDZWIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 18:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbhDZWIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 18:08:19 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA3AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 15:07:36 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id y32so40954046pga.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 15:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pDL7t8FU2ycRLM63Fb305VxNHvDCIUmpYtTkGnxHfEU=;
        b=WKjtzahpE31CTvaIFjlllnMG835QGD0aV65pi0H30EioGC20ZPbGWC09cHfS90lTAo
         axmkQRp0aJDVWzGdZ5xrbr0jc2i9XMrQgN214hGqpHAYpRwD2adBAlHaKkJeVlMQ8c76
         FWlH1aB+cw0J9R9j0lQT8wK4pCLUD08wcIbbMma9y4B5LauxmEUMzTR7kddNzX9EQ/sG
         MNpIP6V1dgKixZybUJ1NeAzEHQw7PVyzudOss0I4CNhgwieZrRKBQxgKqrYzqKpPLsfY
         VxkABzh0zPy4xzDE8V29xAX6cA1+J0wEWb4Dl696GkvUKmeRLgb+Hnm1qEYGXC/5zEF9
         IuLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pDL7t8FU2ycRLM63Fb305VxNHvDCIUmpYtTkGnxHfEU=;
        b=MrclRSokQIAm+fjmijEdgmoG/xzPgvCOk5X4jR8AkIcByTGnuDTR3oeWvr071zkLR3
         VyMYSYKhuoNkAO45GjIx+6p3yaF3Z9ORV2ZGGl/BxVCMaSrzu8jg9yQEEM/xKVE55bhh
         IObnOK52E3p7qpRi9kn30UcNkhkq3MQ8Sx33ip66B1X+zZD88t0UPbCEM95/+8jE5o86
         /BZLybDB4czjdJKvMgQrA+NandgI/M6wf43ZWCQ3EU0uop0/l8zXqr6YsJaM6L4mLrOF
         7RPjhwRs0zYWFt5shBHf74CjNRLr5a7Yb0iP2XV1bIQ/IwV7TD1cPH6vyzZyTRFDT7Eg
         bqhA==
X-Gm-Message-State: AOAM533SSHnOUs0CCSLEWE0oDHgwXqRB1rRM8Gmfdft3wFFzmu11ym4k
        hObjHWOMrG0+A5B9fTVRpW8=
X-Google-Smtp-Source: ABdhPJwrQuLmBq2AOkICKxGKIIsaF1Siw4ZWqQ+/kM2pnUHlqKn/Hd/Kc8094KZzHJXr2LSG3BSQXA==
X-Received: by 2002:a62:6d05:0:b029:250:d196:1fc8 with SMTP id i5-20020a626d050000b0290250d1961fc8mr20116180pfc.21.1619474856254;
        Mon, 26 Apr 2021 15:07:36 -0700 (PDT)
Received: from tong-desktop.local ([2601:647:4200:13:d478:1be:c725:5c32])
        by smtp.googlemail.com with ESMTPSA id f3sm632071pjo.3.2021.04.26.15.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 15:07:35 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tong Zhang <ztong0001@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] misc: alcor_pci: fix null-ptr-deref when there is no PCI bridge
Date:   Mon, 26 Apr 2021 18:07:27 -0400
Message-Id: <20210426220728.1230340-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the PCI bridge might be NULL, so we'd better check before use it

[    1.246492] BUG: kernel NULL pointer dereference, address: 00000000000000c0
[    1.248731] RIP: 0010:pci_read_config_byte+0x5/0x40
[    1.253998] Call Trace:
[    1.254131]  ? alcor_pci_find_cap_offset.isra.0+0x3a/0x100 [alcor_pci]
[    1.254476]  alcor_pci_probe+0x169/0x2d5 [alcor_pci]

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 drivers/misc/cardreader/alcor_pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/misc/cardreader/alcor_pci.c b/drivers/misc/cardreader/alcor_pci.c
index cd402c89189e..1c33453fd5c7 100644
--- a/drivers/misc/cardreader/alcor_pci.c
+++ b/drivers/misc/cardreader/alcor_pci.c
@@ -102,6 +102,9 @@ static int alcor_pci_find_cap_offset(struct alcor_pci_priv *priv,
 	u8 val8;
 	u32 val32;
 
+	if (!pci)
+		return 0;
+
 	where = ALCOR_CAP_START_OFFSET;
 	pci_read_config_byte(pci, where, &val8);
 	if (!val8)
-- 
2.25.1

