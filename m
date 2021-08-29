Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5460F3FAA6C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 11:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbhH2J0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 05:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbhH2J0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 05:26:13 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA11C061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 02:25:21 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id bt14so24086239ejb.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 02:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3ERpR5xRKdfRwZYTB55/K1Gw6Me8MLOQ3TscUX9zEgs=;
        b=uy2+vu68l3UkpcTybvBp608ylbvFoWhpZIqfqB0AUe10/IwqPTeyJ9AaiI7GuDexq8
         z50G/H76LE3vWHVJ5mcDkXvw+Htj74Yyh611n78Fw+5Lsa8EEQ+TF2du3h6p6QtOxpmE
         bjax7VdyGxyaAT7ka4EITj0lDqMI52mfHD3hao+9OPtbMb/iVhoEAxfGB0/JiLfBeBrc
         jdhOhFnNmgUUIXWwLu4KxPbgUTpcfTbMOMFFQWpw1D5pg4d4a5e8/sxyQi1Oe5idn1oj
         mQplMjXtVqEW0qWz9m0JeMem4ssc4G1g+UnKIJhgcD/oXg2AbkLuZM+s/gzig9orgakC
         3KDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3ERpR5xRKdfRwZYTB55/K1Gw6Me8MLOQ3TscUX9zEgs=;
        b=VIA327g471DGZ4eTHBf10FnQYzJVeMo/pbnFoQq4X97Zb9wdF8I0qUK+z+su4i/n0J
         z2c6tQ8U4Tee5PbdTW2EvBnO9SenGUChjA6BUfq8fCSIm/wxkunba6aEDyMH1S17rwvx
         yc4cR8KRcL/nCeA1BoCXsjV5zWT4Ak9QFM75h5QK40lPXjD3/mTxfgmiKHsz05y15KoJ
         147tVIK3JkoDP19LxTtExkAeaGpAVMEuWtVpmv0efSfGP9yPPbmVH0XVrXuhXzlmhcI6
         DgaQA2xEvSS3QYEd3Ta9P2VtJejHEDHIAQe/+ie/8YiepivZQCI+MafjdFXF3ECsq2Nv
         6LLQ==
X-Gm-Message-State: AOAM533qfcX+L/HlkpdQ04iCadF5xzIhNtGIgibqewUNBi+q5eUOn/ae
        jWMz+R3Gf/GigeYCw1WSorE=
X-Google-Smtp-Source: ABdhPJzALoYz4d7psZwONMqTAGa10eNd8EaKURpQxKmUryGwQVyewSTL9p6LJ4oxU/lLbTH63tjb2A==
X-Received: by 2002:a17:906:1454:: with SMTP id q20mr19637316ejc.446.1630229119899;
        Sun, 29 Aug 2021 02:25:19 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::16fa])
        by smtp.gmail.com with ESMTPSA id d23sm5814414edt.39.2021.08.29.02.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 02:25:19 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/6] staging: r8188eu: remove unused functions
Date:   Sun, 29 Aug 2021 11:24:56 +0200
Message-Id: <20210829092502.3658-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes unused functions from core/rtw_wlan_util.c.

Michael Straube (6):
  staging: r8188eu: remove rtw_get_oper_bw()
  staging: r8188eu: remove rtw_get_oper_choffset()
  staging: r8188eu: remove get_bsstype()
  staging: r8188eu: remove CAM_empty_entry()
  staging: r8188eu: remove is_ap_in_wep()
  staging: r8188eu: remove should_forbid_n_rate()

 drivers/staging/r8188eu/core/rtw_wlan_util.c  | 91 -------------------
 .../staging/r8188eu/include/rtw_mlme_ext.h    |  6 --
 2 files changed, 97 deletions(-)

-- 
2.32.0

