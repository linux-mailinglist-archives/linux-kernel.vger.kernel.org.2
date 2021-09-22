Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1835341511A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237378AbhIVUJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237479AbhIVUIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:08:20 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C79C06139D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:06:00 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id w29so10357155wra.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QlPE3RMvxlu4CW/klh/oXgXUKT+PlUcuSMZPFLeDcKk=;
        b=lGkHQXbDhCzBgruzAV6/Bwpb75p2iqxQ/E/9t825lEZNbxTmXsVsfHN7ZRI5EPNiy3
         qHPzaqR7BEDcVMI2sdXnj2YAptFfEkjBzTVFSUJ4XNcLjCQKK+us8a88aJmVgVvlcRhT
         G2kBHtN2Rmr34WjKfs+IfDNyqSFK39QyIbWCWm5KQdZKcNGMU+V8emPH/r7IXAeRdo+4
         n3Oev9hwQ8PVNz7yiNKFImwFLxjWJMG/S74fJsqlxxzjFjLUMn3xs3CY5DIauLsT63NT
         dTwEo2gjz01Qb6LDAvBl9SqNxadQ0f6h4FGJxpHwxzEyFNy6EUx1nGLhTsKhBpwvgxWF
         bjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QlPE3RMvxlu4CW/klh/oXgXUKT+PlUcuSMZPFLeDcKk=;
        b=txwZjmf6VXZdtqfsSwfxkbsirrh73Y3tZMNwwHy64qp2qZGjDBa007O+ja0WcAXLFn
         AuxkDQ0suBF0A5zqAJTeamZErqv8fRcogZsV8WIyO/pfZOaERDQ70ifK3bxxm1vs6/hJ
         a75tkm5P9jDR4rxQz3tn5RVU4UMHinI51eZokoEq++DzhS94LuNlEVEnE6vulx4inRtw
         LEDetCBG10BadPDWaM632xs5vod+Hro+kN2danKN2tG0imEPubwJe0RDmfSshJjum7/I
         7Sz1WGjfo33A92lRlYeUy0DeiB0nEXVPOGwCPVvoHrbNom+3OTh7BsBuaxkGeKIopXyx
         Xrjw==
X-Gm-Message-State: AOAM532PSwpeVcp7P3GhVpLPO85XYhJXiE7BF/7viOnGR+yYSXVAXp5N
        P/PzkBdlCOYCUsJpjwJIuso=
X-Google-Smtp-Source: ABdhPJwqxFVPWFtIysZe6rRIfbQPZ6Lkgj9RkrgUDdXc41Ohxlk1P2Uho6KkmEvq13CYWqQwjtyG3A==
X-Received: by 2002:a7b:c3d2:: with SMTP id t18mr849486wmj.33.1632341158710;
        Wed, 22 Sep 2021 13:05:58 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id e2sm3219761wra.40.2021.09.22.13.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:05:58 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 38/47] staging: r8188eu: remove rtw_set_ie_ch_switch()
Date:   Wed, 22 Sep 2021 22:04:11 +0200
Message-Id: <20210922200420.9693-39-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922200420.9693-1-straube.linux@gmail.com>
References: <20210922200420.9693-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_set_ie_ch_switch() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ieee80211.c | 11 -----------
 drivers/staging/r8188eu/include/ieee80211.h  |  2 --
 2 files changed, 13 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index b2a376867c54..06445a4192a0 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -140,17 +140,6 @@ u8 *rtw_set_ie
 	return pbuf + len + 2;
 }
 
-inline u8 *rtw_set_ie_ch_switch(u8 *buf, u32 *buf_len, u8 ch_switch_mode,
-	u8 new_ch, u8 ch_switch_cnt)
-{
-	u8 ie_data[3];
-
-	ie_data[0] = ch_switch_mode;
-	ie_data[1] = new_ch;
-	ie_data[2] = ch_switch_cnt;
-	return rtw_set_ie(buf, WLAN_EID_CHANNEL_SWITCH,  3, ie_data, buf_len);
-}
-
 inline u8 *rtw_set_ie_secondary_ch_offset(u8 *buf, u32 *buf_len, u8 secondary_ch_offset)
 {
 	return rtw_set_ie(buf, WLAN_EID_SECONDARY_CHANNEL_OFFSET,  1, &secondary_ch_offset, buf_len);
diff --git a/drivers/staging/r8188eu/include/ieee80211.h b/drivers/staging/r8188eu/include/ieee80211.h
index 65e21d5d5b46..ba3b414aae71 100644
--- a/drivers/staging/r8188eu/include/ieee80211.h
+++ b/drivers/staging/r8188eu/include/ieee80211.h
@@ -1095,8 +1095,6 @@ enum secondary_ch_offset {
 	SCA = 1, /* secondary channel above */
 	SCB = 3,  /* secondary channel below */
 };
-u8 *rtw_set_ie_ch_switch(u8 *buf, u32 *buf_len, u8 ch_switch_mode,
-			 u8 new_ch, u8 ch_switch_cnt);
 u8 *rtw_set_ie_secondary_ch_offset(u8 *buf, u32 *buf_len,
 				   u8 secondary_ch_offset);
 u8 *rtw_set_ie_mesh_ch_switch_parm(u8 *buf, u32 *buf_len, u8 ttl,
-- 
2.33.0

