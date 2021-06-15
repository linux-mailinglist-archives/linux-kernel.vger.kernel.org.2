Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897D53A8BE8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 00:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhFOWib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 18:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbhFOWiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 18:38:23 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE44C061767
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 15:36:16 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso2285092wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 15:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mG6EcXHgQPh4KFS+sxj0/0DZ5DGgzbb1Rd38rg/w2dA=;
        b=uSZs5g2SqprC8RF0ycPuyfFwp0jPrHGRJO0tu8htH7ofxsYRZ1p34wgGrQT/kZkQWN
         vKEY+/4NAmkpPptPTfi39x346+TaO2Uq/fSUqaCRrXLD39TuQZdJdWEPPgCm7lfInjtY
         mpGKc8GrThIXVgyFDFRWAtjNgzlAZL/Wy8WeRLiOZUEqP9IbPMIpo5EgOt/Y4TP2BrJd
         bLlAQGy8PaDlePWSDcUB3U4f5kmtzOvy/XrHBJGX/hwYe6De1+phcQaHTpsQ5+kgApqr
         SE0MaO4jMx+7qKdmb6jz2lcz9MS/RufBAN1HwS1XTYyrrkjPYbBKaVZYe+PrdgW9xFyp
         CuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mG6EcXHgQPh4KFS+sxj0/0DZ5DGgzbb1Rd38rg/w2dA=;
        b=Q6G9z4jxKbY5vXbX27fW+WZiogQbs1WPbKomoXKKfqVtd1m8s+lqut7TI75qmUb8M2
         u011WzgAMjgQs3f3BuJiEMznOD3deaxb/v0+Jzzfg2QoJyl6IwNmbRLdfUDkg+gswBWk
         bL7fDelobX5vRFUII4KzNVP/IhiZfdDEMqe06QeaOaX5ydZFI0PbSDLwUok0geO28/b4
         eaGovX1Xxh6dpCOVBVFAkXjyVFFWAM6jrEuxhvXC+ZySJHBdXK2D9n3YsCnyZ6kX5p2F
         v8C0+LD07Ym4Mtt6MaGeQdkvfNiS+f29mgXxQhjyAjQ/gxQ2accIoiTeEUwmXWu/yt/K
         eEdA==
X-Gm-Message-State: AOAM5316OCERwP7aznBITi925BZVgRYYVNSCR/3QPrmk/Lrb8pLNFZnj
        ea4bC0pr0fynY72ITUIcjhAogg==
X-Google-Smtp-Source: ABdhPJwLswKcN2NlwsK6zyliYTz/R38llj8ybSU7CY4dWysaOcvPF8wWJTWSMdcE1wgzFUjCovyxMw==
X-Received: by 2002:a1c:ed10:: with SMTP id l16mr7632228wmh.8.1623796575116;
        Tue, 15 Jun 2021 15:36:15 -0700 (PDT)
Received: from localhost.localdomain (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id m23sm3934791wml.27.2021.06.15.15.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 15:36:14 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 3/7] staging: rtl8188eu: remove unused variables from core/rtw_efuse.c
Date:   Tue, 15 Jun 2021 23:36:03 +0100
Message-Id: <20210615223607.13863-4-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615223607.13863-1-phil@philpotter.co.uk>
References: <20210615223607.13863-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove set but unused variables from within the file core/rtw_efuse.c
in the function efuse_read_phymap_from_txpktbuf, as they are triggering
kernel test robot warnings. Also, remove the local 'lenc' array as well,
as nothing is done with its values. Keep the two usb_read8 calls
however, as this patch is purely for warnings, not to change behaviour
of the code.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/core/rtw_efuse.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_efuse.c b/drivers/staging/rtl8188eu/core/rtw_efuse.c
index 0d51bf9c9bb0..21619fd67217 100644
--- a/drivers/staging/rtl8188eu/core/rtw_efuse.c
+++ b/drivers/staging/rtl8188eu/core/rtw_efuse.c
@@ -234,16 +234,9 @@ static void efuse_read_phymap_from_txpktbuf(
 		hi32 = usb_read32(adapter, REG_PKTBUF_DBG_DATA_H);
 
 		if (i == 0) {
-			u8 lenc[2];
-			u16 lenbak, aaabak;
-			u16 aaa;
+			usb_read8(adapter, REG_PKTBUF_DBG_DATA_L);
+			usb_read8(adapter, REG_PKTBUF_DBG_DATA_L + 1);
 
-			lenc[0] = usb_read8(adapter, REG_PKTBUF_DBG_DATA_L);
-			lenc[1] = usb_read8(adapter, REG_PKTBUF_DBG_DATA_L + 1);
-
-			aaabak = le16_to_cpup((__le16 *)lenc);
-			lenbak = le16_to_cpu(*((__le16 *)lenc));
-			aaa = le16_to_cpup((__le16 *)&lo32);
 			len = le16_to_cpu(*((__le16 *)&lo32));
 
 			limit = min_t(u16, len - 2, limit);
-- 
2.30.2

