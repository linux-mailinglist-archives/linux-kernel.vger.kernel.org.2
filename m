Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56DEF3A8BE4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 00:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhFOWiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 18:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhFOWiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 18:38:22 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEF9C061760
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 15:36:15 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id n7so330738wri.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 15:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Zdz/YG9U6kVK6aKVKn5GfU94WTJiZuN67dSZMEqKx8=;
        b=xmtwC/i1xM49cc+7sO0opfJPen2G6inIw3AO8/rH+4DTImX/OYGSuQMEGPxjTtulr5
         FsKQRlW5tIq9iOZJUneHLQi/PoAiPUGAjknFJCPwtLwsrHpFjeMCEYCXzd4hcC7rgP6w
         C9XrE8oaYDybbOlqULdcvMUW3g8GE/qfQRDdWkjqJT1OecyPwtvQCkOWpOn/kqeQQnZr
         +On374xUbDddCtSQ8T9LrqSamWH2qVKCJ83WvuCk/9iz+Lv7Tw5VILhZQe+hq6qSIWU7
         DFaEOHF4sWHSk4nfsu4lY4gL+ugjd6bB+JnkJRpC3ADU4LR6pbOOoRGUrrlR/Pl20Arn
         Znow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Zdz/YG9U6kVK6aKVKn5GfU94WTJiZuN67dSZMEqKx8=;
        b=kiT7+0SQBSbV5miAYD8Ah4iNTSQDf41PNLRfzF90RZEkjWwUv6l5ZYFDdueJgfE3NW
         m8okXzz+cDW6xDOCO+NafadPVr+k1kG7lnAqKcuBJj+bpUmuflhA8GJEzUXkBhGza8Qa
         URmDDcfATTDlSW/tD5qwnu7xZQFHGbYQbJ9fwhOidCzHCZjEea1V5jxVfyKXlezM6zA7
         qf9cqoswPGBfqE7OsLCpFD2x4qG2fjAsM18KyNEfwwwQVVWAazY9qv36Ds29YYNXqcM8
         JGs3Hd5WYDLy/wU64y10ORgytC6PvmKo6GTf9IlBkCTAUY45gyoWMCSDTbCHkZOcsKDO
         nLbw==
X-Gm-Message-State: AOAM533cXFWgQvpqAXlkaUvxfX6u6CMiKZFJRs3/M9gSbalMfbSBpZtV
        P3lAny+LsXYCIvDRRHK13Au52w==
X-Google-Smtp-Source: ABdhPJxukMMl+EK8Lcs825AfFGrWHs4LakjqAAgly6LS3JUeVG4KTMKopraTHf7h/atxrBY13qCdmA==
X-Received: by 2002:adf:bd84:: with SMTP id l4mr1543482wrh.346.1623796574378;
        Tue, 15 Jun 2021 15:36:14 -0700 (PDT)
Received: from localhost.localdomain (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id m23sm3934791wml.27.2021.06.15.15.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 15:36:13 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 2/7] staging: rtl8188eu: use prefix decrement operator on trycnt variable
Date:   Tue, 15 Jun 2021 23:36:02 +0100
Message-Id: <20210615223607.13863-3-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615223607.13863-1-phil@philpotter.co.uk>
References: <20210615223607.13863-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify trycnt condition in the do/while loop of rtw_hal_set_hwreg to use
a prefix decrement operator instead of postfix. As an unsigned 8-bit
integer, this value would actually be 255 after the end of the do/while
loop, which is almost certainly not what was intended. It is more
reasonable to assume a loop counter should be zero at the end of all
loop iterations. Indeed, the line following the loop previously contained
an if statement which assumed trycnt was 0, and therefore was never
triggered.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/hal/usb_halinit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/hal/usb_halinit.c b/drivers/staging/rtl8188eu/hal/usb_halinit.c
index 0c3f11411eae..dcdf868b394d 100644
--- a/drivers/staging/rtl8188eu/hal/usb_halinit.c
+++ b/drivers/staging/rtl8188eu/hal/usb_halinit.c
@@ -1657,7 +1657,7 @@ void rtw_hal_set_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
 				do {
 					if (!(usb_read32(Adapter, REG_RXPKT_NUM) & RXDMA_IDLE))
 						break;
-				} while (trycnt--);
+				} while (--trycnt);
 
 				/* RQPN Load 0 */
 				usb_write16(Adapter, REG_RQPN_NPQ, 0x0);
-- 
2.30.2

