Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD596388082
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 21:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351853AbhERTaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 15:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbhERTaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 15:30:06 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6352AC061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 12:28:47 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g24so6052155pji.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 12:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rsvs60aN2Tn4zdMpprOFok80g2REFGU9zS+Btntv1Ps=;
        b=masGlSlSWJ0TJs2SaAcTU0IGJlrLidnaTsVPqVpcnKVXQerKu+8jiJLAbkYcPRmFKl
         58KvTFEL4r1cudFwviocinQq/lQyiSvzBWLO0xd3b9+PYWhokcVzQWcNpqzjpdcBK9jx
         pYqRCMesiksTohv867v7qQjuj/4dfNbRQZetz76Z9brfIiIXKA3EO2NNpdfgRD43kCQZ
         GrcSJmEtmu26E/S6EeDlCEGyypoDzrsQ7PB5IAanYF9woMp40Tc3+YISv6ssj33ZyVwX
         /mOeAlwpauZWuAd96KildXdwpoQqWpRwPfGVDIlI0iZVTIdiihIDeLKzQsTShuuzYGUT
         KOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rsvs60aN2Tn4zdMpprOFok80g2REFGU9zS+Btntv1Ps=;
        b=QJ6cgo1Vbrsb72990VUwWq7RcHaVEhVbfnJjd4ATmcQnedthuFCEBOtJ3kKFdesCoj
         3Pn4YWaFvTPYR2KomAG6uqpQa9YN7CNTuOsDO5Y8xWiAlFp4wcHoGqSQM15ZEQ+BjkyF
         MaXPHbjhzYPUO0Gh4QKwQqE9JPkPdIUdSE3rHVhP84kbsoTwy9UavZVMWdKGEsJCNWm4
         SPJ61H/ebMJzY5hmQm5FahaArDKBpSrWu76/zZh4ajRt2AzWpHXGw/JvOJgyT22/E2Qp
         MReAk0imSsfQh24SQhcDoVA56TSZuKTlG6BfFFoM4VcyLE/qmQGlubN4Hh7Q4/uhIn1B
         hw3w==
X-Gm-Message-State: AOAM531NkvenvyfQKj1OumqGe4p11+Oa2nq+ho5SUKRNCPwEy24lOspo
        8VPB0a51JSMFFFaF0SS9Uy6odBLjw3pmHhyS
X-Google-Smtp-Source: ABdhPJypDZIaLv9s4QJg9Oax+DP4vpTFqCWMM050+GeC4NE//enu1b88OfdMt8y3x+NXfZEQCcRsBw==
X-Received: by 2002:a17:902:b68c:b029:e6:bb9f:7577 with SMTP id c12-20020a170902b68cb02900e6bb9f7577mr6318048pls.0.1621366126750;
        Tue, 18 May 2021 12:28:46 -0700 (PDT)
Received: from tong-desktop.local ([2601:647:4200:13:45d1:3e2e:2ae6:a74])
        by smtp.googlemail.com with ESMTPSA id t15sm1814970pjh.0.2021.05.18.12.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 12:28:46 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tong Zhang <ztong0001@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>
Subject: [PATCH v4] misc: alcor_pci: fix null-ptr-deref when there is no PCI bridge
Date:   Tue, 18 May 2021 15:28:18 -0400
Message-Id: <20210518192820.181500-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cb099c69-0d59-7a12-b0bc-2ce71264363e@canonical.com>
References: <cb099c69-0d59-7a12-b0bc-2ce71264363e@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an issue with the ASPM(optional) capability checking function.
A device might be attached to root complex directly, in this case,
bus->self(bridge) will be NULL, thus priv->parent_pdev is NULL.
Since alcor_pci_init_check_aspm(priv->parent_pdev) checks the PCI link's
ASPM capability and populate parent_cap_off, which will be used later by
alcor_pci_aspm_ctrl() to dynamically turn on/off device, what we can do
here is to avoid checking the capability if we are on the root complex.
This will make pdev_cap_off 0 and alcor_pci_aspm_ctrl() will simply
return when bring called, effectively disable ASPM for the device.

[    1.246492] BUG: kernel NULL pointer dereference, address: 00000000000000c0
[    1.248731] RIP: 0010:pci_read_config_byte+0x5/0x40
[    1.253998] Call Trace:
[    1.254131]  ? alcor_pci_find_cap_offset.isra.0+0x3a/0x100 [alcor_pci]
[    1.254476]  alcor_pci_probe+0x169/0x2d5 [alcor_pci]

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
Co-developed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Co-developed-by: Colin Ian King <colin.king@canonical.com>
---
v2: check before calling alcor_pci_find_cap_offset()
v3: Add comment. Enable the dev_dbg() output when priv->parent_pdev is NULL.
v4: fix inverted if statement, thanks to Colin <colin.king@canonical.com>

 drivers/misc/cardreader/alcor_pci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cardreader/alcor_pci.c b/drivers/misc/cardreader/alcor_pci.c
index cd402c89189e..de6d44a158bb 100644
--- a/drivers/misc/cardreader/alcor_pci.c
+++ b/drivers/misc/cardreader/alcor_pci.c
@@ -139,7 +139,13 @@ static void alcor_pci_init_check_aspm(struct alcor_pci_priv *priv)
 	u32 val32;
 
 	priv->pdev_cap_off    = alcor_pci_find_cap_offset(priv, priv->pdev);
-	priv->parent_cap_off = alcor_pci_find_cap_offset(priv,
+	/*
+	 * A device might be attached to root complex directly and
+	 * priv->parent_pdev will be NULL. In this case we don't check its
+	 * capability and disable ASPM completely.
+	 */
+	if (priv->parent_pdev)
+		priv->parent_cap_off = alcor_pci_find_cap_offset(priv,
 							 priv->parent_pdev);
 
 	if ((priv->pdev_cap_off == 0) || (priv->parent_cap_off == 0)) {
-- 
2.25.1

