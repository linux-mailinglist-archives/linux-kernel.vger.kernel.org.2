Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59A2413AF5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 21:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbhIUTsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 15:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbhIUTsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 15:48:51 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE56C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 12:47:22 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q26so72333wrc.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 12:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3LgmkxB9IHfY1uiiQk4BtfVCxmgcHEet8wgSzFroByM=;
        b=NyVEAwTiwEM3kZFLQRtZBJV5k8a3zLhjr3EAW/NYhVrBZI2QS0FXTbqic2QnP2+A1W
         EMp/1+hHQ26i9mFlzg3XUJ0D2i68OTrNEBLnlMiCc2qrzryfbCCHRA9vBe0cwhuneE6r
         N1ztK9PLyx7eOmWL6rfmUoKqdHr5lM2hJX5b3G50De96zY2fCh24duEh2NFzRLyyqrUm
         nIzzu+gXy21M+AOv3sCHWLK73EejLEygTi/E++ZNFZDgxl/+qAH1aD/NkjxLlcHRrRCP
         PQKWAP5BnkP73UAbx54V/ZhvXOR7tqowIHDYk0NuQeHTuS/+DYDncOC/i1cV2NXyej/g
         J9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3LgmkxB9IHfY1uiiQk4BtfVCxmgcHEet8wgSzFroByM=;
        b=2rbCD1WaIvCGXuqz8ncDFvAPxlKKOSbUS9W3ksop7G0EMOhrABkujhYd/nKNnJf+5H
         Hp9CMsFuNB/EFCRVkDQoYqxLClYc9XkTXOoJfbSQ94mOi3zdTWxscw0ftAgHhrs7nCsH
         WdU8SaWAHe4h7F3PkL1i89CcTMsfUlc1kz1gOGzXN0EiwNXQAQHsNBQMeBPihw5IzkqZ
         /n0f+PNbEuH/9O3sVoV6KrIsekNLmHLCSeYe+N100hQmDD7taj/IenRP8LoQzteZg61+
         Qt0hyO3OvZjcTx90XRUGf/zURsPR1EhwQZSkctr2wuzNGwPQHJAwBXEqUXb0zrdpB9sp
         xGJw==
X-Gm-Message-State: AOAM532/WE026Cj2snKQxeAdvdp3iWys7vN8CTRbEbmk6AjQWhtHEqMB
        vCuI9MKjo93H9AqSzekcJL+EnhGhQTifYg==
X-Google-Smtp-Source: ABdhPJwFnjZ39WZxAdya+gK2+R9rhlIoLIOOlrKMBu2VZNalUj6oWNaPTsH5VkM+I8A4xSlTvWn9fw==
X-Received: by 2002:adf:8919:: with SMTP id s25mr37724403wrs.185.1632253640965;
        Tue, 21 Sep 2021 12:47:20 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id s13sm3891243wmc.47.2021.09.21.12.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 12:47:20 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/8] staging: r8188eu: remove dead dynamic tx power code
Date:   Tue, 21 Sep 2021 21:46:50 +0200
Message-Id: <20210921194658.10654-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes dynamic tx power related code that is not used in
this driver.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (8):
  staging: r8188eu: remove odm_DynamicTxPowerNIC()
  staging: r8188eu: remove odm_DynamicTxPowerAP()
  staging: r8188eu: remove odm_DynamicTxPower()
  staging: r8188eu: remove write-only fields from struct dm_priv
  staging: r8188eu: remove PowerIndex_backup from struct dm_priv
  staging: r8188eu: remove dead code from rtl8188e_rf6052.c
  staging: r8188eu: remove DynamicTxHighPowerLvl from struct dm_priv
  staging: r8188eu: remove odm_DynamicTxPowerInit()

 drivers/staging/r8188eu/hal/odm.c             | 59 -------------------
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c | 57 +++++-------------
 drivers/staging/r8188eu/include/odm_precomp.h |  4 --
 drivers/staging/r8188eu/include/rtl8188e_dm.h |  6 --
 4 files changed, 14 insertions(+), 112 deletions(-)

-- 
2.33.0

