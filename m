Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3FC4165AD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 21:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240205AbhIWTLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 15:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237009AbhIWTLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 15:11:02 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E22C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 12:09:30 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t18so20222463wrb.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 12:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=khs6fyMWQQ2ulAhLlVxbV3Pe3yGuhZnnaZwYc/ZZ41I=;
        b=ptLs5wTlayLGzt7vfE5v+H/Cp2oicBwOLoaes5qC2z6n6riaDVI4A4R1yWMILkuIkN
         PBgW2uBu4YWVJr5qG1bgmTY37cXPwBqDGVh0P28PBhP2mnC5gb1iyvjWobnmlvVFrTiT
         OuI1WxpFQA4FhiAf9/DkFRkzAh/EQPyjO6bchrL42/tFFRoq13l7ZVN0bNCQoISRSmYg
         JzKvbzhIEv0j/+p/ERW2CZZZDxIxdorUBYk3oDZv0vTTctBjfgdUsbu7kh/zzrWnvHHZ
         FErXWrThMmlYl7fYc9f/FFCdkIwkWjZq26qKU9GzZurzWt3maECY+/8zwjKC9zOJfxs1
         KTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=khs6fyMWQQ2ulAhLlVxbV3Pe3yGuhZnnaZwYc/ZZ41I=;
        b=hRQOv7rHKcFZOdu3J1p+g1V93mV/iozkhbh+csjzvhKMdYi5X1u3KdaLWAyiyGc/zs
         DRECkfnh/C7+PMwzlMX+jXxFuI9YtrwtE5MF22qtk1t3ppmvtUZB5CDtezd0avrIdmEc
         3FtPhCCOHyVZAZQ8LSLN0Jh/dAjQHRs/ZGxc3ScKJfOOUXDqmmq49c2Txqt+B89wt8Io
         a4M7e04WJGMoqJDZM0WaEUWuLzB6UHaC6Y1VWAajo0xFk96yZG+IEfNEDFSSngYUna7p
         QioS9UHjk3FL1+Skn15IqY9mitdgvr1VJz4gWVI1ZdHhiNpv/RXdkvGYnfQE9vaAtjCe
         HzqQ==
X-Gm-Message-State: AOAM530V8gdxkArtCUsllpdOADQDdakhff7kt8V1ypLqIQXR83VIXBID
        WsD7+/zhKEOZgPFU/Cyu3/XjxzcQMbvr4A==
X-Google-Smtp-Source: ABdhPJxwbuJQa39YsVtrGLZC5E/w0kMteeAGUzIj6NLPbxz14eOCmLDXV4Ld0TvVx4e7kUFT/p1bvg==
X-Received: by 2002:adf:f988:: with SMTP id f8mr7171708wrr.54.1632424169242;
        Thu, 23 Sep 2021 12:09:29 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cad])
        by smtp.gmail.com with ESMTPSA id e28sm6323591wrc.10.2021.09.23.12.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 12:09:28 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 00/17] staging: r8188eu: remove unused functions from rtw_cmd.c
Date:   Thu, 23 Sep 2021 21:09:03 +0200
Message-Id: <20210923190920.3580-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes all unused functions from rtw_cmd.c.

Michael Straube (17):
  staging: r8188eu: remove rtw_cmd_clr_isr()
  staging: r8188eu: remove rtw_createbss_cmd_ex()
  staging: r8188eu: remove rtw_getbbreg_cmd()
  staging: r8188eu: remove rtw_getrfreg_cmd()
  staging: r8188eu: remove rtw_getrttbl_cmd()
  staging: r8188eu: remove rtw_led_blink_cmd()
  staging: r8188eu: remove rtw_readtssi_cmdrsp_callback()
  staging: r8188eu: remove rtw_set_ch_cmd()
  staging: r8188eu: remove rtw_set_csa_cmd()
  staging: r8188eu: remove rtw_setassocsta_cmd()
  staging: r8188eu: remove rtw_setbasicrate_cmd()
  staging: r8188eu: remove rtw_setbbreg_cmd()
  staging: r8188eu: remove rtw_setphy_cmd()
  staging: r8188eu: remove rtw_setrfreg_cmd()
  staging: r8188eu: remove rtw_setrttbl_cmd()
  staging: r8188eu: remove rtw_setstandby_cmd()
  staging: r8188eu: remove rtw_tdls_cmd()

 drivers/staging/r8188eu/core/rtw_cmd.c    | 500 ----------------------
 drivers/staging/r8188eu/include/rtw_cmd.h |  18 -
 2 files changed, 518 deletions(-)

-- 
2.33.0

