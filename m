Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D146372AB5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 15:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbhEDNN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 09:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbhEDNN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 09:13:56 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A70C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 06:13:00 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id r9so13094622ejj.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 06:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HzckpB2RAMOBd5T4XWzNGlvU9ohIMVxQWJop+FdQAYs=;
        b=qfmDDx80AO89QhPMNuePmFAqmebjkbPHO2EpWFp99nDuilRO6a59EQUVmoLPMyzdaU
         v5G4mquyA++4WMo6CDXfNTraDgbG5rt+utBVzbXr/qixbm5l2HiT4KUouIFPtILb8HeK
         GLciEiIubQIOwHlE+nC08O2nnJypexEm8D8QE/kPcBgmtQEeW13f17uBtvesTz92Z14D
         S9Pe301Z9ffvr5MOidmf9nhopoDzl7/Xq7TcdDoq+nxUU6su1zlUSSKgJmp2gVVkg+gI
         3v0lBi1TkXnaDWyWsEefp8kjIesTyAx3QwOTcpSnJ2HZYqX6AliVAhoOYgM3h8YUHnQf
         KWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HzckpB2RAMOBd5T4XWzNGlvU9ohIMVxQWJop+FdQAYs=;
        b=nsJH3ttEdAmRqQG4ZogDXkWprKu/cets6j2I5xnofw0dSYld7lxcVkwe4U5ujlXJOV
         Ok4GyD+XuDiGB9lK4CCyywYyt/fnQwWN1kBUhlrI8Gc973Q/ZUGtCVd5rLuzkC7fvnlP
         UhaL+IgY/RXO/VoMewZCAXWodgf4DSvbFUoZ+0OCz+KJWnv5KtS2NOoOMUWup+QqQj6J
         hFKYooajHQHfA+6g0p7NUt713OMzQ/XPxIHSH4Szoq6hvaal5O+PQHwWwUxmyiXVDWda
         1QLy2BqzSGFFFAQ7UxB6+esytgG0VuOVPVNnRqi0QjzpAvYxDDtXWo93a2k3HXc8Tn8L
         TsWw==
X-Gm-Message-State: AOAM533b4D06IYnDzVDAQ7zNienWucstl5IkQkUMGTxTaPnQS4v/RhMb
        hJvQPsgSCz9wNl0X75g5d3y3eyTZ/XOEAw==
X-Google-Smtp-Source: ABdhPJyZ0axJrad/YH/LldGphACiWaTCACu6P1qlfjXlOsmgeXWaxGIGwgzX2b5Ew2o+7MzHndymmQ==
X-Received: by 2002:a17:907:2176:: with SMTP id rl22mr17569409ejb.155.1620133979277;
        Tue, 04 May 2021 06:12:59 -0700 (PDT)
Received: from agape ([5.171.72.210])
        by smtp.gmail.com with ESMTPSA id u6sm1404735ejn.14.2021.05.04.06.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 06:12:58 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] staging: rtl8723bs: use in-kernel aes encryption
Date:   Tue,  4 May 2021 15:12:54 +0200
Message-Id: <cover.1620133620.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset replaces the private AES routines used to
encrypt data with in-kernel ones.

Fabio Aiuto (3):
  staging: rtl8723bs: align argument position in a new line
  staging: rtl8723bs: use in-kernel aes encryption in OMAC1 routines
  staging: rtl8723bs: use in-kernel aes encryption

 drivers/staging/rtl8723bs/core/rtw_security.c | 327 +-----------------
 .../staging/rtl8723bs/include/rtw_security.h  |   1 +
 2 files changed, 15 insertions(+), 313 deletions(-)

-- 
2.20.1

