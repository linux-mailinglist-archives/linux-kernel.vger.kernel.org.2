Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC123FA5C3
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 15:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbhH1ND2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 09:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbhH1ND0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 09:03:26 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF32C061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 06:02:36 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id k24so8601535pgh.8
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 06:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=grz/v4rMmgpArLNWapXH90U0PLg2ful4VnniTa/BkFM=;
        b=QmBzWKooJhpmAJeDZCYKJLdXGH9T21ozKangbOanPc6WkVZ4fuZP7rR+9yb902J60H
         +ZdtrDgjfliDsnERTgtZFGWlEyCelWU3MZtbjLtKTnWPMVo2F1rhn4btmgCO8yfpbnKR
         ypjK+PEUL7ZRVRZ0LJPA0Pt+2adqgDucyMvfIVnFkCVFb/EfyrQnyhRS6qvocrzHAwdO
         UhmRr3DaSANXTsxbIy+rdx9dySu0tHQSH2uhUeSVxlXvGQkxnc52PFYvbYs9MIjPXWuv
         diokaW2J0nTQeSRvpFuoNcdCwb3uof381re9txMXE9T72mwWpmEwImUIcBDEfkqTK2v6
         6VFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=grz/v4rMmgpArLNWapXH90U0PLg2ful4VnniTa/BkFM=;
        b=AViIzUFZ+ld39OABX272EXLbrAUWCQF20sFbtq+XZwh6FAcFGnFenp/t6TpR0DXH1m
         x8zGOsTexQLCW6gQVU5ZEOfMe+PpZ3+c5xK6FOs/ULGtrlIG4UfN1z4jCj1/CnLkywq3
         RCW0mehAeU+BKSFhhrbWhPZ9mc8rT+PsTyvSa51vEp0vePn2dAd+BApC0nIMsNajbOqb
         h+YnmOBfCqNWErUhLigU9zFpJnWdxPbq+OwcYws09pFgFQs8pv7IYeP/Tygr1fcCL/BA
         t72OOOeCwBdN4UCrQKtDgQIYhkKVNcxLduHKAk/AHAZsX8gqOt04VrV2buFDZmIUAfEJ
         CsOg==
X-Gm-Message-State: AOAM530Hartxq+5utE1hDTZzJCYO9SJfS4KVBiip3oOyrxDDf9o1Ekyx
        QQo6AUGEn/jdPaH56IAtGUQ=
X-Google-Smtp-Source: ABdhPJy+nG2ABLsi4WaNOS1JkwPHOWDCAwbCmZErBzjiK8yN6uXiOWCwjmloqMb2ZolfpjvhRerLcg==
X-Received: by 2002:a63:2243:: with SMTP id t3mr12183949pgm.114.1630155755652;
        Sat, 28 Aug 2021 06:02:35 -0700 (PDT)
Received: from user ([117.98.200.228])
        by smtp.gmail.com with ESMTPSA id q9sm9302329pfs.40.2021.08.28.06.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 06:02:35 -0700 (PDT)
Date:   Sat, 28 Aug 2021 18:32:29 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        martin@kaiser.cx, jing.yangyang@zte.com.cn,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: r8188eu: os_dep: remove unused static variable
Message-ID: <YSoz5Qip12K899SN@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused static variable rtw_enusbss from os_intfs.c file.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/r8188eu/os_dep/os_intfs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 8d0158f4a45d..c3ac0ae153f8 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -85,7 +85,6 @@ static int rtw_AcceptAddbaReq = true;/*  0:Reject AP's Add BA req, 1:Accept AP's
 static int rtw_antdiv_cfg = 2; /*  0:OFF , 1:ON, 2:decide by Efuse config */
 static int rtw_antdiv_type; /* 0:decide by efuse  1: for 88EE, 1Tx and 1RxCG are diversity.(2 Ant with SPDT), 2:  for 88EE, 1Tx and 2Rx are diversity.(2 Ant, Tx and RxCG are both on aux port, RxCS is on main port), 3: for 88EE, 1Tx and 1RxCG are fixed.(1Ant, Tx and RxCG are both on aux port) */

-static int rtw_enusbss;/* 0:disable, 1:enable */

 static int rtw_hwpdn_mode = 2;/* 0:disable, 1:enable, 2: by EFUSE config */

@@ -133,7 +132,6 @@ module_param(rtw_low_power, int, 0644);
 module_param(rtw_wifi_spec, int, 0644);
 module_param(rtw_antdiv_cfg, int, 0644);
 module_param(rtw_antdiv_type, int, 0644);
-module_param(rtw_enusbss, int, 0644);
 module_param(rtw_hwpdn_mode, int, 0644);
 module_param(rtw_hwpwrp_detect, int, 0644);
 module_param(rtw_hw_wps_pbc, int, 0644);
--
2.32.0

