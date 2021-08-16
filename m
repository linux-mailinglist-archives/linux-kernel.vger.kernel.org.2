Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE613EDA64
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 17:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237170AbhHPQAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 12:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237380AbhHPQAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 12:00:09 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB631C0617AF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:59:36 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id z9so24274366wrh.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pneosDARu3FWmahaZQQKanjShxTTQDb7R85mkUv+f3c=;
        b=LKDRmrhqKi5Mwr6/GT63BiP4qHp10Uokk2Lr90sdpMxGVIN0ttFyfHjla8LXOUfoFl
         DddAsAjJoclyfPBXXr5UjYkYdQTMHyS7EvD1SwpWp7Iz0wmZQU6XccfXDTYkDka/CIwX
         aU26Mw8m84/HZ+65f2wfo67DQ6kd4tuD9db1umidsB/9JghVmRRQpJDdXE4ulwwWxLN3
         J/ECERFUgwe35NXDDgSD/rQ8mMsxVq1qiJHC/MNCZml+M0v0UceRHRd8tzhLB79vKhdj
         1AIOkQN6HaOR78nuvHUhI4Aw5uPwki+e32WfdFzEou3xigPWdaBbEFkJDaufHpYvu3MN
         DjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pneosDARu3FWmahaZQQKanjShxTTQDb7R85mkUv+f3c=;
        b=iphRHawzcOWh2ekU/oU5pNeeBuNVsO72qLr+7zSZeLneuSMvdU3u2PpyomoJ/0NxFl
         ryVwGU6HrXV0fnz6UmNPpl8pycsEKzFBKk5Qgv6+06aD6fOT1ZGocgCqXQ84Zdw94dFE
         djI3O5/gRw54AhxcRsh4gr2Fdfw8r4BW/ZIdoyCEkxo8hCiZyoFShN1H8t1/tpillj3P
         BjJHP46AyUWPJaKsOskIchxgeVm6fbwu0CY/9n0FmX5LGf+pbxC4yBHVOJTcj2J4ovp+
         RSMmUh+D2k3de/RuAZGAPds9bwtnO03CwAp28eWqd7usFyPWMna5s0bjTEKelibfXU7v
         jaLA==
X-Gm-Message-State: AOAM531q8Jy8C0enso21p2nh4Pu4m5YBkTDkaQo3dSAgkQVyoKgyWGtM
        lgJ7rNqDdXXWx/c+LJolzkk=
X-Google-Smtp-Source: ABdhPJziPYXa1OFEiBzgIT61oDyoCChTBrsl3huMDfxotk3CX0oeqeH0NoWsrMJcW59KazCZ+u8RlA==
X-Received: by 2002:a5d:4ec5:: with SMTP id s5mr12420382wrv.267.1629129575667;
        Mon, 16 Aug 2021 08:59:35 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id a77sm11589597wmd.31.2021.08.16.08.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 08:59:35 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 13/23] staging: r8188eu: clean up spacing style issues in core/rtw_mp_ioctl.c
Date:   Mon, 16 Aug 2021 17:58:08 +0200
Message-Id: <20210816155818.24005-14-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210816155818.24005-1-straube.linux@gmail.com>
References: <20210816155818.24005-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up spacing style issues in core/rtw_mp_ioctl.c reported by
checkpatch.

CHECK: spaces preferred around that '|' (ctx:VxV)
WARNING: space prohibited between function name and open parenthesis '('

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mp_ioctl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mp_ioctl.c b/drivers/staging/r8188eu/core/rtw_mp_ioctl.c
index fed94d66aee0..36091eac0e0f 100644
--- a/drivers/staging/r8188eu/core/rtw_mp_ioctl.c
+++ b/drivers/staging/r8188eu/core/rtw_mp_ioctl.c
@@ -309,7 +309,7 @@ int rtl8188eu_oid_rt_pro_set_antenna_bb_hdl(struct oid_par_priv *poid_par_priv)
 		SetAntenna(Adapter);
 		_irqlevel_changed_(&oldirql, RAISE);
 	} else {
-		antenna = (Adapter->mppriv.antenna_tx << 16)|Adapter->mppriv.antenna_rx;
+		antenna = (Adapter->mppriv.antenna_tx << 16) | Adapter->mppriv.antenna_rx;
 		*(u32 *)poid_par_priv->information_buf = antenna;
 	}
 
@@ -734,7 +734,7 @@ int rtl8188eu_oid_rt_pro_read16_eeprom_hdl(struct oid_par_priv *poid_par_priv)
 }
 
 /*  */
-int rtl8188eu_oid_rt_pro_write16_eeprom_hdl (struct oid_par_priv *poid_par_priv)
+int rtl8188eu_oid_rt_pro_write16_eeprom_hdl(struct oid_par_priv *poid_par_priv)
 {
 	return 0;
 }
@@ -754,7 +754,7 @@ int rtl8188eu_oid_rt_rd_attrib_mem_hdl(struct oid_par_priv *poid_par_priv)
 	return 0;
 }
 /*  */
-int rtl8188eu_oid_rt_wr_attrib_mem_hdl (struct oid_par_priv *poid_par_priv)
+int rtl8188eu_oid_rt_wr_attrib_mem_hdl(struct oid_par_priv *poid_par_priv)
 {
 	return 0;
 }
-- 
2.32.0

