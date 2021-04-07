Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D5F356DDF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 15:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242902AbhDGNvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 09:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352641AbhDGNus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 09:50:48 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBEBC061761
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 06:50:25 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id 12so3575343wrz.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 06:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=agWTThKJnzpXbfQJioyYRi1VTSU31768MskVIC2gqW4=;
        b=jmtsFcqklHHmMrKwWd2iroaNilgCYrRb+1g4cmVaqB2uWDAGz3svccfiPd5VWa1pVl
         rCF4M5Vq/Rij8svJt/Jw+GUMin9bZDzUUYRrALhgqv+1ayIhb3pfsU4rFrvaMpsqywZS
         DwEvz/GPMuyuzxp37lEgmS+qNuMG87UqV2I+LTJPa5Zd4Vuy3/6BJCrhCUbC1N9EsoT/
         mIq1x3g96qmIHdxNmhKJc4cpiTywL8l3TmGAMN0/q0UUqD1mT5z6vkWEOgtIi4R3Z1XO
         7D0Om2+5p8DYtR8tE7Jv3qUZlhhg2cpU/vUTNSncWx2krAurdpJoOL2oP86wJ/KPEDYc
         B1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=agWTThKJnzpXbfQJioyYRi1VTSU31768MskVIC2gqW4=;
        b=KJxJZbEfL2A3ZxypbywaFjFfCT7+KzSf6c9qw3s6/gfes/YoclScd9glcHsGzrx/mE
         MfiXNjyN9P74oTgg8hIG8uql6hXXqPWGJnc4aH28mndAhPxvg/Scvxi+ytaHNVTi7cQ9
         ofajoq68id4u60Woy8tmojLaYrZEw1Lu0WzgailYD1rvdC45/caO3ZdWfSl3jQ4rsMT9
         LstqZvKSMDjbW9N1Y0YXodOYcJWDVV79TeuhWHp//HGkdeH4ZNmn3Lw1KZZ8Bak0YSAw
         T1vvzg0hIUl/wI0kBBE36TIoYIAc9tGs0KTCsb9CCw3gE/hbD/CALFqQBRx4vKUdFd2I
         BUIQ==
X-Gm-Message-State: AOAM5315TktJJqAxQfJMbuMCE181wuNtB/U5ZF7maT6K1x3V6PD8CWX7
        PIBawURb9cRS4Xx49K/4HMA=
X-Google-Smtp-Source: ABdhPJxphLhhA9NmKcBRuu0OvxDwttWJGTyRAzXCv/wE8fUhmujzISOt9xPFniIeNtqT4cSAf28Zew==
X-Received: by 2002:adf:f64e:: with SMTP id x14mr4572832wrp.203.1617803423995;
        Wed, 07 Apr 2021 06:50:23 -0700 (PDT)
Received: from agape ([5.171.81.68])
        by smtp.gmail.com with ESMTPSA id k11sm8714212wmj.1.2021.04.07.06.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 06:50:23 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 17/19] staging: rtl8723bs: fix comparison in if condition
Date:   Wed,  7 Apr 2021 15:49:41 +0200
Message-Id: <b32610045cad3c385b236266d7a10665ed202150.1617802415.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617802415.git.fabioaiuto83@gmail.com>
References: <cover.1617802415.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix following post-commit checkpatch issue:

WARNING: Comparisons should place the constant on the right side of the test
1833: FILE: drivers/staging/rtl8723bs/os_dep/mlme_linux.c:151:
+		if (NULL == buff)

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
index f5c94509ad71..0a16752f805b 100644
--- a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
@@ -148,7 +148,7 @@ void rtw_report_sec_ie(struct adapter *adapter, u8 authmode, u8 *sec_ie)
 	buff = NULL;
 	if (authmode == WLAN_EID_VENDOR_SPECIFIC) {
 		buff = rtw_zmalloc(IW_CUSTOM_MAX);
-		if (NULL == buff)
+		if (!buff)
 			return;
 
 		p = buff;
-- 
2.20.1

