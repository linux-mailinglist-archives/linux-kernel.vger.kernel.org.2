Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5884105CD
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 11:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244822AbhIRJ7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 05:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244781AbhIRJ7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 05:59:20 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE20C06175F
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:57:57 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id e26so9141187wmk.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZoNFXCBufWtJhOJmpIuy1h9miKEbhcOw8w1A9DjaL6U=;
        b=E34AJvo20m2f7HY596GaIhoE+Bei6vl2fk/zOr2cjfjBn0e1lI3boKUnXDrJNWweNb
         VTiwEQrZWfmVD1TpMyo4mVg137P0JXgVjFk/Skmz+CSZ3JeFe7wccoZDasDFRcorPfYw
         jT31Qp/yjB0k4kxCp3War871sfM5ehu8LYM+zyI6NhaWLXpRXyYnOrXfRRqtItzYnbnE
         8pva2HPI9CzrKZ0akR9FDTkIYE8DsVxfIuigvTy12s/Gb3sqCPfv9a24jbDcUME1GoQr
         trieBS5IcsNz6uA6yAmdvS4gzkMHW9+W05qPt+GZe4xKhJWKGGquNTTPswGsM6QWv7mT
         rRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZoNFXCBufWtJhOJmpIuy1h9miKEbhcOw8w1A9DjaL6U=;
        b=cvR/y4agc6N5wWY7cU+i0TtQViIytqLGTeeUA9ztIKg6E8xpklWPbou7ZI5snXv5YS
         iO3/sp/6JXruJqMYv/gbZb78udbGvRq/O/FjLTtmg0a++NwczNEobUt3cQOiMNqBfPD1
         wChaKxceAP3+FUZPe+DosUjVWMoKLxjlP4vfgo8zjqdtUDKStvozsj7POxn48xGaac59
         AK8FTGWt0NEY9oVjqntgdt4Xkq63zQazTqf2/olBb0GRmRA0utc6AdQ48Obz6aA1IyEW
         3i2CwdhJ+oiFuihgOEOJL0eJgr7ber/VS2TsQTskB4AZiSPZ3FPPnCL6aejUIIZMjf4k
         JzMw==
X-Gm-Message-State: AOAM533p1iGbBsgBsBmt0rvkCKcU6RvX0dNZjbq6ZxEeKOXfjjVf84Ej
        EmYdTjyuL8sAmG6VAZ8JAKc=
X-Google-Smtp-Source: ABdhPJxTz9nVaELkeHHe9Y0eNM7B557GRqoGCrddHd0uI9DYiwed58eUX602taYk1M02URXMnq6r+Q==
X-Received: by 2002:a1c:751a:: with SMTP id o26mr15181235wmc.94.1631959075819;
        Sat, 18 Sep 2021 02:57:55 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id o26sm13013287wmc.17.2021.09.18.02.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 02:57:55 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/8] staging: r8188eu: remove unused code
Date:   Sat, 18 Sep 2021 11:57:19 +0200
Message-Id: <20210918095727.13591-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes some unused functions and the unused struct
rf_shadow.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (8):
  staging: r8188eu: remove odm_ConfigRF_RadioB_8188E()
  staging: r8188eu: remove ODM_DIG_LowerBound_88E()
  staging: r8188eu: remove rtl8188e_RF_ChangeTxPath()
  staging: r8188eu: remove unused struct rf_shadow
  staging: r8188eu: remove HalDetectPwrDownMode88E()
  staging: r8188eu: remove rtw_IOL_cmd_tx_pkt_buf_dump()
  staging: r8188eu: remove rtl8188e_set_rssi_cmd()
  staging: r8188eu: remove EFUSE_Read1Byte()

 drivers/staging/r8188eu/core/rtw_efuse.c      | 58 -------------------
 drivers/staging/r8188eu/hal/odm_RTL8188E.c    |  9 ---
 .../staging/r8188eu/hal/odm_RegConfig8188E.c  |  8 ---
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c    | 15 -----
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 51 ----------------
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c | 43 --------------
 .../staging/r8188eu/include/odm_RTL8188E.h    |  2 -
 .../r8188eu/include/odm_RegConfig8188E.h      |  3 -
 .../staging/r8188eu/include/rtl8188e_cmd.h    |  1 -
 .../staging/r8188eu/include/rtl8188e_hal.h    |  3 -
 drivers/staging/r8188eu/include/rtl8188e_rf.h |  1 -
 drivers/staging/r8188eu/include/rtw_efuse.h   |  1 -
 12 files changed, 195 deletions(-)

-- 
2.33.0

