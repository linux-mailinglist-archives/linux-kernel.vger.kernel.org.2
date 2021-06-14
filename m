Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B3F3A71A1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 23:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhFNV7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 17:59:40 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:39703 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbhFNV6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 17:58:33 -0400
Received: by mail-pf1-f181.google.com with SMTP id k15so11665374pfp.6;
        Mon, 14 Jun 2021 14:56:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S1XQUH/m8RP26gVRUSs66tHIaokdTzVysKqV1d4GWGY=;
        b=GOD1KW7OG2PS04sdTk8J0W66ZBf+uS8XAAkpy/5+AF02yMs9H9LrmYznQi0FHWRAXI
         rEFVBh3q/mLvLNnYIiyvKkY3N/WKiTFz2CefiFT8nhm/gHbp+z5B1bBWxfI7TsHtLbP5
         +r/mUHOm2QKpJwREP5KHQ0lNzjZGX7i9Bu6DL1OCqTPtKoQ/6TR57iqRXDhkVQY7p/WB
         ak97dmaKDVgWTZbqUgrVASkn6DPBfg3yz8Qy1FcGSmBkELQuTWrWDm7G9vS8JPdqNXYj
         AOrhLikQQ0UeEGfhQQhEuYoqPTpd+2tQE+hDdhbmRnI9rxLZ2MXCXl0aY62xogaHjTir
         JiDw==
X-Gm-Message-State: AOAM531Aq2GVGxbvQL3RNlYYDnghx6vD0n4tBjm9HyObXrTdCqudS+yG
        gRXqKURXYIenyuhHLANyQeY=
X-Google-Smtp-Source: ABdhPJyGmG1xDZh+iEl6WQKrlTuny9a9lOx2NDPfV5j6TCBImjrIfVRrfu35gzZCSoTj7hmD3SijpQ==
X-Received: by 2002:a62:5e05:0:b029:2fb:2ee4:2b9c with SMTP id s5-20020a625e050000b02902fb2ee42b9cmr1112264pfb.0.1623707777777;
        Mon, 14 Jun 2021 14:56:17 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id ig1sm13024465pjb.27.2021.06.14.14.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 14:56:17 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     mathias.nyman@intel.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
Subject: [PATCH] usb: renesas-xhci: Replace BIT(15) with macro
Date:   Mon, 14 Jun 2021 14:56:14 -0700
Message-Id: <20210614215614.240489-1-mdf@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace BIT(15) with RENESAS_ROM_STATUS_ROM_EXISTS.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/usb/host/xhci-pci-renesas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-pci-renesas.c b/drivers/usb/host/xhci-pci-renesas.c
index f97ac9f52bf4..5923844ed821 100644
--- a/drivers/usb/host/xhci-pci-renesas.c
+++ b/drivers/usb/host/xhci-pci-renesas.c
@@ -197,7 +197,7 @@ static int renesas_check_rom_state(struct pci_dev *pdev)
 	if (err)
 		return pcibios_err_to_errno(err);
 
-	if (rom_state & BIT(15)) {
+	if (rom_state & RENESAS_ROM_STATUS_ROM_EXISTS) {
 		/* ROM exists */
 		dev_dbg(&pdev->dev, "ROM exists\n");
 
-- 
2.31.1

