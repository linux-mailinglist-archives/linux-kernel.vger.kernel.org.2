Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCA34607DF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 18:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358753AbhK1RPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 12:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbhK1RNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 12:13:06 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23DEC061748
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 09:09:49 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id j3so31417953wrp.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 09:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/yxy7igUIzD5d3hWmN5Qkd98jhWVRja4dh3krlzXO+g=;
        b=oE8hRthZ77ihjHp5OUMH2PflxLKomEon44x5+V7u/XAF72chxz1jX20/3kSHpZkO70
         QNWxR0ElNPEPjCk/jGeVyAf5KpQ0LUgI77BbAnK6sm36rTyJ/g8UhcDVAq9gq+3YvWEz
         PA1Nf5McF+Jj8Zo/xawDFP6v2e3HL2+8lASSVa+lpl+Vm+p/UOeIKiX3epi446toUnuq
         4/hKsWs5qKyjDMZIxRDpytrQLPeoGb/1sOHm845V5QxQAaolja665geP1Rfj7fMW9lZq
         1slLOohDoyCDHlNW7qoua8lWlVfc55JjKicUpf7UliUX7X/gaexTURebRQvmEb8zWSwb
         39gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/yxy7igUIzD5d3hWmN5Qkd98jhWVRja4dh3krlzXO+g=;
        b=rnDWy4Ew/lXWDdplQivN5gtXGY4HEuN1/foYbSKDC/gTvmePZfNKaIxhhpttsGY1Pb
         hZ0ZXkUIn0O0Wzxkm4JiI/F/m4YNn8DKpewFys1TunAQGUSVEtgEOJMjKT/j+ygOBIoC
         8Nb1xsyVSLH5SJrQdQfPzUwIOZPe4ji9bK8IbtLJEuLBO40mLN8jPqJtQG9Qt8Rt56Fm
         qa14CjCRohr/O2bmqWOEqSa6sVIF8+VpkcMUK/9kXkc5/36BlE+DJaYF05ZK/MB9ZZ6C
         LU71O5kn4XGCGuxQFevreCyGHDjxG5VTZ/B/Pu+R70KNnWU7ikpWhj8F6sObn57SOZvi
         fCZw==
X-Gm-Message-State: AOAM533MG7otmjdSnduozE/ZEqaQ55Faub3Fc+NuuUtmCeUaGaAorGJ4
        PVqnnknLPq9jkJFLsb+Vd+M=
X-Google-Smtp-Source: ABdhPJyVT90TpYBg485ng3xlkMp9j/gSUgzUn7bZuH4yXSyh6LGOUm93VV9Y9XNTwrhLLsjwCfCR/A==
X-Received: by 2002:a5d:4cd1:: with SMTP id c17mr27948157wrt.31.1638119388584;
        Sun, 28 Nov 2021 09:09:48 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ac86])
        by smtp.gmail.com with ESMTPSA id n15sm18243845wmq.38.2021.11.28.09.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 09:09:48 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 00/10] staging: r8188eu: remove rf_type and rtw_rf_config
Date:   Sun, 28 Nov 2021 18:09:14 +0100
Message-Id: <20211128170924.5874-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes rf_type from struct hal_data_8188e and the
module paramater rtw_rc_config.

Tested on x86_64 with InterTech DMG-02.

v2:
included the previously sent series
"staging: r8188eu: remove more usages of rf_type"

Michael Straube (10):
  staging: r8188eu: remove rf_type from rtw_update_ht_cap()
  staging: r8188eu: remove rf_type from issue_assocreq()
  staging: r8188eu: remove rf_type from storePwrIndexDiffRateOffset()
  staging: r8188eu: remove rf_type from getTxPowerIndex88E()
  staging: r8188eu: remove TxCount from getTxPowerIndex88E()
  staging: r8188eu: remove rf_type from writeOFDMPowerReg88E()
  staging: r8188eu: remove rf_type from bb_reg_dump()
  staging: r8188eu: remove unused HW_VAR_RF_TYPE
  staging: r8188eu: remove rf_type from struct hal_data_8188e
  staging: r8188eu: remove module parameter rtw_rf_config

 drivers/staging/r8188eu/core/rtw_mlme.c       | 12 +--
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 25 ++----
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   |  4 -
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 85 +++----------------
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c |  6 +-
 drivers/staging/r8188eu/hal/usb_halinit.c     |  3 -
 drivers/staging/r8188eu/include/drv_types.h   |  1 -
 drivers/staging/r8188eu/include/hal_intf.h    |  1 -
 .../staging/r8188eu/include/rtl8188e_hal.h    |  3 -
 drivers/staging/r8188eu/include/rtw_rf.h      | 10 ---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  | 27 ++----
 drivers/staging/r8188eu/os_dep/os_intfs.c     |  3 -
 12 files changed, 30 insertions(+), 150 deletions(-)

-- 
2.34.0

