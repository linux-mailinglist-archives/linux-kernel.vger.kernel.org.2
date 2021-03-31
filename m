Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070DC34FD47
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbhCaJmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbhCaJlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:41:00 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D3DC061761
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:40:59 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id jy13so29120152ejc.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QNFxids6U9D/dKDx/610dkY//hXLOEttQc5qObgmL9k=;
        b=qldOFHSwo2wnWqwGUxHuHPtBREDpcQXw3e3RclqtaT+Jkgl3/u8e4VyftzPP4nHrIm
         TLzegsn8Qrmso7KrpHEKaLH/6dHeFq+G/pf/8dQTy6Mtf1KO7WfOzO8rD98LwZxzqcEA
         36qpSYORPESCtG7G45CTzZe4qqtk+cLtwLCN4QXHiwIkUGwT98B+sedEvcGS3yfkLG+P
         s81Np4hhfVX3v5mAenDlcedS+FX8bMHGICZc4cukh2Ag4rIh3mWVzvDbu0ryuOfSy0AD
         ri/Hq2o7r4mIPJLbbOWlx39q0iO5wSjfsUcph7hTomqHVfml+Wg733T+3pRXv92JVMLk
         4nYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QNFxids6U9D/dKDx/610dkY//hXLOEttQc5qObgmL9k=;
        b=SZD7DcTUWW/3OF0bhFnqIvfJVR9ZA3vugSvkZV/n8rtYtMPzvSehm73Y736wz0raEb
         gi9xaeW1EsdZyAOF/Pr5d6+G+4gdFBAAcv9kQcBySEsBV3PQ3TgPfTNfBGJ7vLrpsc0M
         hg6f5arnLXuIRaf/iua7h8AsByaWpPkr0/WT1lZnSUHvgfXpHU/+cK+YpZKUhPiW30KX
         LG0Y95MF8JoGGWV+02jzSjPBOcjt3giC8ojhPHhWLF7Z5lAPFAc5SHcL+sLTnYUFg2Oi
         xcsESHsUsOGDnPv8YyVyShkFLA63ySP5rm5Apz4VGD26xUwWhR13rEWSWNxbSXnkmPck
         D0/A==
X-Gm-Message-State: AOAM531LCX6ACy5qz/k6FWdSXTGbC4FMpRABKXO7xRd54EoNDBiNqavs
        ls0sn4nRVK5GES4JSPJLpRo=
X-Google-Smtp-Source: ABdhPJzmk/XkWmzwLzBJuaghbHwqq5ZSAWbkn2zAWyT31ZZNkw1NYjaoAo5dsbJdMWud6R9fxJBjlw==
X-Received: by 2002:a17:906:cb18:: with SMTP id lk24mr2517434ejb.70.1617183657903;
        Wed, 31 Mar 2021 02:40:57 -0700 (PDT)
Received: from agape ([5.171.73.44])
        by smtp.gmail.com with ESMTPSA id e8sm1144891edq.77.2021.03.31.02.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:40:57 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 24/40] staging: rtl8723bs: replace RT_TRACE with public printk wrappers in hal/hal_intf.c
Date:   Wed, 31 Mar 2021 11:39:52 +0200
Message-Id: <820be3e002c4f50f4f8d265c2ca05448db667bbd.1617183374.git.fabioaiuto83@gmail.com>
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
 drivers/staging/rtl8723bs/hal/hal_intf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index aa4356327636..87de2a3bda4e 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -108,7 +108,7 @@ uint rtw_hal_init(struct adapter *padapter)
 		DBG_871X("rtw_hal_init: hal__init fail\n");
 	}
 
-	RT_TRACE(_module_hal_init_c_, _drv_err_, ("-rtl871x_hal_init:status = 0x%x\n", status));
+	pr_err("%s -%s:status = 0x%x\n", DRIVER_PREFIX, __func__, status);
 
 	return status;
 }
-- 
2.20.1

