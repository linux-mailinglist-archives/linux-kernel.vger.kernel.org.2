Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D3637F1D7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 06:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbhEMEJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 00:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhEMEJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 00:09:34 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59652C061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 21:08:25 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id h7so13709961plt.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 21:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=C8gRdgQ4WjHYfjOLsdgsKyTjYCtXna84aWFtwKTsc4w=;
        b=XY3bHRBb8abe5Us5NFI+wshDtCA1lrLyrbXkBaAK7ZAab2VgjOaijORgMpkMoWpNHd
         YBjUiWxBlt+zo+mKWm7WvoR8snzjkC4CCGbEbWZzfOR792My1WTQEpQdzbbWi9xB3M6c
         5eomtyazSP64PfRQSc9c4D0BLpQfNOVxbQQ+ektFT/uBD8LQSM0rce0GuI5OGQrvvjAS
         JWxPVlXqao79mUIWux45QAUFo5o9fyltefeCLMa+wFoxKHzf2vxZ+GZR0LZOkpmn4ewK
         rNl8NNrtiw0zlfUlgvj4AlymHY8nwzvO9GTw2vBAL+PNY51dD9XL3PXk5u+TO0z1cVj+
         DvDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C8gRdgQ4WjHYfjOLsdgsKyTjYCtXna84aWFtwKTsc4w=;
        b=Ooj55nSbqBv7niZmWa7qpKn4N9QokSRPHQXgG9KQvzroDdCRcNQ94XYUJfGSU+8Msw
         A6diDqSWgo5kabTnUMbXW2QKH6cT/UPGR9yR/6Uq4zQyqwxWoqozle8zRs0rY+U983CV
         tqaYJeQ2EWHcCYOZ8tnu18VOYmEXcqUdslvyxJn3sniKQHJ9VUlJrRMvBE6pTI5gIW9C
         X9ep1hDgEl9yC/OVGj5IV6Pg7kPjukYSBiia7Qe7hBC18vcFKe/vAs0jFD2YRM+QL5Nu
         oUVi477tP03qAvFL6v+CzBs3gQI/S8UIMR+nAYYSS3h/1ViO7pIqG3KldgKmtulUSXJv
         cBzw==
X-Gm-Message-State: AOAM532ynKW82Jyd+Tg0Hqh+8o0jQYrWISY7yiuUg2mExNPcWBnt22Bz
        nPfZ+Pv2Oesifujz/PBeIZM=
X-Google-Smtp-Source: ABdhPJy+OTFJQpchYMNaqi+cbajnA+tpoUSRO9efc0l2mIdYEVWOKYZN7iQNNvHhr9ffPKIsHtEYqQ==
X-Received: by 2002:a17:902:934b:b029:ef:5d8f:f2c6 with SMTP id g11-20020a170902934bb02900ef5d8ff2c6mr11681545plp.57.1620878904722;
        Wed, 12 May 2021 21:08:24 -0700 (PDT)
Received: from tong-desktop.local ([2601:647:4200:13:2065:6aeb:cf90:77e2])
        by smtp.googlemail.com with ESMTPSA id l10sm963041pfc.125.2021.05.12.21.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 21:08:24 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tong Zhang <ztong0001@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3] misc: alcor_pci: fix null-ptr-deref when there is no PCI bridge
Date:   Thu, 13 May 2021 00:07:33 -0400
Message-Id: <20210513040732.1310159-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YJwFLgvgIXHn8Zch@kroah.com>
References: <YJwFLgvgIXHn8Zch@kroah.com>
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
---
v2: check before calling alcor_pci_find_cap_offset()
v3: Add comment. Enable the dev_dbg() output when priv->parent_pdev is NULL.

 drivers/misc/cardreader/alcor_pci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cardreader/alcor_pci.c b/drivers/misc/cardreader/alcor_pci.c
index cd402c89189e..0a62307f7ffb 100644
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
+	if (!priv->parent_pdev)
+		priv->parent_cap_off = alcor_pci_find_cap_offset(priv,
 							 priv->parent_pdev);
 
 	if ((priv->pdev_cap_off == 0) || (priv->parent_cap_off == 0)) {
-- 
2.25.1

