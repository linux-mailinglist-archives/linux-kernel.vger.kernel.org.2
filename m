Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136AA3F15B6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 11:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237366AbhHSJES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 05:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237350AbhHSJEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 05:04:09 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8E0C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 02:03:31 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id by4so7819119edb.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 02:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vY3GZJPMYn6vS4R/74kCrYt0CIjzYgwZIOWTM7q36E8=;
        b=T0NvdnO2TesKoZtHGxcnTTxmFcyUfm1UzjTlAeKm1yATm/iDmXpv9wRpVrqS0SEYeQ
         lUXqglioAKyHW4pR/+yWwASFMfm+0LaT4A9eiK/znr23E8S50SWP1eqmwFqkjU8Zl+hJ
         Wv2I4vxq8EHB6NgVP9OMK8/ZtMaGWV7I6oaKEoClyNFuRxhMGeUhV9BDN326tzMaZxyj
         4QGVI6RcGqVkPLDU5Ajw7iZpqcqpMxIfCVjADOrpLb9caJ+AdHC29GHDA6PJ24AVw5m6
         WLJ4f3Ur6au8yazSnGThfHw0dsUyrHYqMeEC6+KQf3Z2Ip6zW34fBVbbascSzCnk28yJ
         Tr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vY3GZJPMYn6vS4R/74kCrYt0CIjzYgwZIOWTM7q36E8=;
        b=dCBgSvDRg0GTqsryyKzlJTTZOMf/YJWvoPQZ1dLui/zwLghzLuRY1DEALMWNM0dSWN
         fz4TVnvO8oF7z7JuPxDUrfxEli8Yui6Z2sDv0Q+SCdRSAJnutZVAvfMzIFKaGNqMeldd
         u/cHlWplfKvKGfYdP6J+rCnLuYOSofjVhE+Ym/PgvGWyjmNUd4kGc0tR1tRFXqYqh64p
         xdJ6PkxWh2/ErvqXNDhu/Nycib0URkqcCyBjmPBHGP/ZEMOysj2U9txx8O8Go5+LXrHV
         5DUMDZA5PVIZXuBSPwQVS5e5/ICxQyS2x6rUEd+s6rrhX3pW6c0MMJ1jepZLbKYGyTU5
         CugA==
X-Gm-Message-State: AOAM532So4AKeMbyS+bF6dId+v8CPKTCxN+91Ho8+++qDzm9gK7HcoNk
        IuA9S27jEkZTML1BdoLxYbU=
X-Google-Smtp-Source: ABdhPJy5ELko6QdKjpbICRNWBsnoqBK4LtKLolcWhKm/6cjTFZ9YArV1BxEWU7jehojQFSUI5dxppw==
X-Received: by 2002:a05:6402:4d:: with SMTP id f13mr15240964edu.275.1629363810471;
        Thu, 19 Aug 2021 02:03:30 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::687e])
        by smtp.gmail.com with ESMTPSA id cn16sm1386687edb.9.2021.08.19.02.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 02:03:30 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2] staging: r8188eu: fix scheduling while atomic bugs
Date:   Thu, 19 Aug 2021 11:02:14 +0200
Message-Id: <20210819090214.3269-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These allocations are sometimes done under a spin lock so they
have to be atomic. The function call tree is:

-> update_beacon() <- takes a spin lock
   -> update_BCNTIM()
      -> set_tx_beacon_cmd()

Fixes: 15865124feed ("staging: r8188eu: introduce new core dir for RTL8188eu driver")
Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v1 -> v2
Added Fixes: tag to commit message.

 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index f6ee72d5af09..b7df269e4149 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -8129,13 +8129,13 @@ u8 set_tx_beacon_cmd(struct adapter *padapter)
 	u8 res = _SUCCESS;
 	int len_diff = 0;
 
-	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
+	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
 	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
 
-	ptxBeacon_parm = kzalloc(sizeof(struct Tx_Beacon_param), GFP_KERNEL);
+	ptxBeacon_parm = kzalloc(sizeof(struct Tx_Beacon_param), GFP_ATOMIC);
 	if (!ptxBeacon_parm) {
 		kfree(ph2c);
 		res = _FAIL;
-- 
2.32.0

