Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364733F0EC0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 01:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbhHRXnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 19:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235186AbhHRXnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 19:43:33 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4477FC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 16:42:58 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id a201-20020a1c7fd2000000b002e6d33447f9so4393864wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 16:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m5pI5ids2ZBGE+PXrmlzjU/e6GjyoaIhIF845NNsPBE=;
        b=IGQEmBm163cVsMuhcsIMU+ElZCBoYtlkGvDX1pBJxDC8Hhp2+KhPlUMuqlKlLumKhj
         53T4VZdEPAcc3cGgR0e9dMJbUB1bO6fNLGkfdG/nPTYTHWzAjweETHVd3SnkPfsLN0LC
         J1HchKwQq3IPgXedKeJCuMYlE2gHh/2YZw66XXsrEIIqpPWM+Qoqfg7uSGvF9xbt2w75
         KGUGfM3t1dpOEkkdLy7xvr1zhOBMWSai8uQg4CjAX2eTS5Q7alzCVryX2rcmSRchAe0n
         9tt42gvNsZo5nTleXIYU/Gc+yb6vFNYbLY8ho0wwxFGHdOrVHWFf/r85QU5mRRB2MtHW
         RXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m5pI5ids2ZBGE+PXrmlzjU/e6GjyoaIhIF845NNsPBE=;
        b=GpSuTUm66BCEfQSU25gqVQbfXgFVI+G+7hZaQo+wWlWMtqx5sX2ssNrkU5eBgqjH7h
         c2Ls+mNxGjFBMeawEYBd/4Y4Lzu64sQaV5M11h8ISEPj1WXgsl0S2azb/I5rUnzWZajz
         aYrRe3cAUXV6JnbVE08d0E8RUt8YkFUmTNq5lrK+flI/UpWRzuosVrVHtQuJ2v3SjKAX
         2ePyO4g3wD1tY/qmdfOHrGVOtWxmGy0rUJ55Px1SYHaWFyuRSOsWESRwMPOXFq4p6b8r
         6kwwonpXxMjNdWgtVJWVb3kF31/po6vV2FaR+5x2KjY7miYE2UF4ULT8ZRXwKi2aWbF3
         UfWw==
X-Gm-Message-State: AOAM5339EmErpEoctpBpYYU578nJGOrqXqB1G6enZ1v2ZCTbIVuAUrqm
        OpiqcZn3Bi2HbfPnw0q70p9hvQ==
X-Google-Smtp-Source: ABdhPJx7F5jKK+Lvs3Dn1JMqEjCwp6qFxlkwXUwtWfVoY/M6xdSZMw1NzM0gg+Xtx9fNB6chSFK8/w==
X-Received: by 2002:a1c:4d17:: with SMTP id o23mr10860037wmh.92.1629330176911;
        Wed, 18 Aug 2021 16:42:56 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id z8sm1194926wrt.77.2021.08.18.16.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 16:42:56 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        martin@kaiser.cx, straube.linux@gmail.com,
        Larry.Finger@lwfinger.net
Subject: [PATCH 3/6] staging: r8188eu: remove txrpt_ccx_sw_88e and txrpt_ccx_qtime_88e macros
Date:   Thu, 19 Aug 2021 00:42:50 +0100
Message-Id: <20210818234253.208271-4-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210818234253.208271-1-phil@philpotter.co.uk>
References: <20210818234253.208271-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove txrpt_ccx_sw_88e and txrpt_ccx_qtime_88e macro definitions from
include/rtl8188e_xmit.h, as these were only called from the now removed
dump_txrpt_ccx_88e function, which was itself not called from anywhere
anyway.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/include/rtl8188e_xmit.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtl8188e_xmit.h b/drivers/staging/r8188eu/include/rtl8188e_xmit.h
index 20b55e3850ba..e7eb19c4ee9d 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_xmit.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_xmit.h
@@ -133,10 +133,6 @@ struct txrpt_ccx_88e {
 	u8 sw0;
 };
 
-#define txrpt_ccx_sw_88e(txrpt_ccx) ((txrpt_ccx)->sw0 + ((txrpt_ccx)->sw1<<8))
-#define txrpt_ccx_qtime_88e(txrpt_ccx)			\
-	((txrpt_ccx)->ccx_qtime0+((txrpt_ccx)->ccx_qtime1<<8))
-
 void rtl8188e_fill_fake_txdesc(struct adapter *padapter, u8 *pDesc,
 			       u32 BufferLen, u8 IsPsPoll, u8 IsBTQosNull);
 s32 rtl8188eu_init_xmit_priv(struct adapter *padapter);
-- 
2.31.1

