Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20AB34FD41
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbhCaJlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234883AbhCaJlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:41:04 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87224C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:41:04 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id w3so29113952ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l1/mtMaWyruUy5GsP0u8+X/MRIyBkOmtJzzZNj7uzOQ=;
        b=P2q09m1bbRygwmcdpWCGAfNBVrNQ4aB/i7eJWqL1mcWI6UyE2cfNGPv5lu9iaV/6Ed
         mP68ZteDqVUPUJydTNuU+ZLVXngo8LXtVTUSWcTK0kqP/rGBn28RrUC8ceaz1qCcxxFF
         pggBC1aOG3j/42N0EsITeaJQDGrwlaPiY9tAKyiaLK5fAYw51qMYd2jI9lRe4O+07ug1
         w8sdWN4kcjj+rYJ2FBM1Dv2aLRqL0S1JPwbidjmB66VCcC5BJ2q2Z0X6t8YdhuKu9749
         QbdY5kBR09hOhDdZX46oYR+IwyGgJ9b6friF4oRdktewE/KW/oXCcZkepCQo5qBmdtcm
         a0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l1/mtMaWyruUy5GsP0u8+X/MRIyBkOmtJzzZNj7uzOQ=;
        b=ryxuhEX6PLmOuhPKdKmCROeoKYaEUtAfPR/VDVT/+uMwxzxHZDnW8ELFYoXS9J93/3
         SCYJKZAyE/wO7G2zHl4x+udW0xBDNGOAtymwBoklr4BqC01DlJTO8SCOzSXmtk5yn3Yw
         gZV7r0AYbGFq0cd0v3oC89cdxpylLQZGxKTpM6FU29chzcXHVdd0+NrQZCcbaCuQf9/X
         XuwlclyHJzgEBzXs5uIV3AZVzuScMGo4CT0fT2Zhy4Jblmf6jOHMMLqaNQf/8A+xSSjF
         OLUenu/adlHkqeo8l3sMgtNEvN1f0725xKPSaerUUZJ9flbegM6aC5vtF3lSnSsykC/l
         8Thw==
X-Gm-Message-State: AOAM533VD+hegaOppr6+KHlLb+yESIFdx9wdRriUB7WuHlG2AJjuHzME
        5sNm3dOAXOg6Na66ymE/IBJT2X/hw1+hZA==
X-Google-Smtp-Source: ABdhPJwL/fj54OHKdIWjy5cQ4hvVijERO/J1SdNPvl8TjhlRKVoh4AYMluoRGF4aH1sJIanw4SVcHA==
X-Received: by 2002:a17:906:4f10:: with SMTP id t16mr2521117eju.531.1617183663313;
        Wed, 31 Mar 2021 02:41:03 -0700 (PDT)
Received: from agape ([5.171.73.44])
        by smtp.gmail.com with ESMTPSA id n6sm841200eji.37.2021.03.31.02.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:41:03 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 27/40] staging: rtl8723bs: replace RT_TRACE with public printk wrappers in hal/rtl8723bs_recv.c
Date:   Wed, 31 Mar 2021 11:39:55 +0200
Message-Id: <41f84e20efd2fbef44271c383be9cfe3dc610427.1617183374.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617183374.git.fabioaiuto83@gmail.com>
References: <cover.1617183374.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace private macro RT_TRACE for tracing with in-kernel
pr_* printk wrappers

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
index 17a3e7bf66ef..7c8e0402f150 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
@@ -346,7 +346,8 @@ static void rtl8723bs_recv_tasklet(struct tasklet_struct *t)
 						update_recvframe_phyinfo(precvframe, (struct phy_stat *)ptr);
 
 					if (rtw_recv_entry(precvframe) != _SUCCESS) {
-						RT_TRACE(_module_rtl871x_recv_c_, _drv_dump_, ("%s: rtw_recv_entry(precvframe) != _SUCCESS\n", __func__));
+						pr_devel("%s %s: rtw_recv_entry(precvframe) != _SUCCESS\n",
+							 DRIVER_PREFIX, __func__);
 					}
 				} else if (pattrib->pkt_rpt_type == C2H_PACKET) {
 					struct c2h_evt_hdr_t	C2hEvent;
@@ -404,7 +405,7 @@ s32 rtl8723bs_init_recv_priv(struct adapter *padapter)
 	precvpriv->pallocated_recv_buf = rtw_zmalloc(n);
 	if (!precvpriv->pallocated_recv_buf) {
 		res = _FAIL;
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("alloc recv_buf fail!\n"));
+		pr_err("%s alloc recv_buf fail!\n", DRIVER_PREFIX);
 		goto exit;
 	}
 
-- 
2.20.1

