Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBC33F4A3C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 14:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236902AbhHWMD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 08:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236701AbhHWMDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 08:03:08 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C4CC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 05:02:25 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id q11-20020a7bce8b0000b02902e6880d0accso13911798wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 05:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jNvlRovpXI4/yiNj+yBTSjAklyY67wlpFcUrW0vobjc=;
        b=Vh06A6X5BK6nsBWLgxiHTpAsx9IoANP2InVt0EtRgxnp+ye2/2tx31hVUBLqkRiiVS
         SWvCjHVzEa9XVe/yrnFAI0SM9f35F0RPo8AKjHsWfo3WnixOvg0d3kE273ATkDc0xCDq
         vxRCE06728IztBn72xkjOWX+L8Qw3J9NWPo00pqqkGvVntQeKdbGJvKlGSFvmcn2L4k9
         hK7p/DZVZ6pvXfLXKedq60hugd/oBccJ0v3msLfdWZTde8vsieN3DjrVKP4+jDVbZst9
         tBof1h1/C1qGu83n4j6vv15cJMEOR3UrZCwFCHOisNZw1Jh7ebzyv3xpAFPxWuuRGB0z
         yUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jNvlRovpXI4/yiNj+yBTSjAklyY67wlpFcUrW0vobjc=;
        b=LFmwi74x2BBhvxRyaRCyPmblvme64dbv8uNtU2w0l5Czkhq5PSLPTgdKSHZIEHbBVH
         atdAB5LTcO70E//gtO+JE3iveY2lLVioJTK62GyBPJfsoUKLkBZLrH609J+JmCzoGkg/
         0A/MPMzCnLGQfAP6e+6H76xnqcUz0kJx2tQ7aYk4ikj+TfBQ8orRLGrIC7UJWmPfPwPw
         8cVHz/s5i1nr3vY1CnXb5r4BwcvCZF+JSvy8coW4qD0mp5t0DrABjBoNn3E8XcdzLk1m
         APZKN+5QWXGi5HYFaFk60tHzuyfXATdQ4DJ/40Jq3TPPBi2d6xkI8K32zTOFZP5URPEa
         zccA==
X-Gm-Message-State: AOAM532tARqjKlxyucxNU22TwtO6rM2EbxUYyHMI+vHUycI+MkRtFuZt
        bCEWAD/DktqNYJbV8mMmM/U=
X-Google-Smtp-Source: ABdhPJw1U3bhnDR4DGHufWdD9asrsVTC+iE0x9DW5K9NvXGKRdk1n131old9+dXDhMOh83w7OK9eRQ==
X-Received: by 2002:a1c:f706:: with SMTP id v6mr12328443wmh.167.1629720139764;
        Mon, 23 Aug 2021 05:02:19 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::3c39])
        by smtp.gmail.com with ESMTPSA id g5sm901332wrq.80.2021.08.23.05.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 05:02:19 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/8] staging: r8188eu: use is_multicast_ether_addr instead of IS_MCAST
Date:   Mon, 23 Aug 2021 14:00:58 +0200
Message-Id: <20210823120106.9633-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series replaces most uses of the custom IS_MCAST macro with
is_multicast_ether_addr. The goal is to get rid of IS_MCAST.
There is only one usage left in rtw_sta_mgt.c, but that one needs
more effort to verify that the buffers are properly aligned, so I
left it as is for now.

Michael Straube (8):
  staging: r8188eu: ensure proper alignment for eth address buffers
  staging: r8188eu: use is_multicast_ether_addr in core/rtw_mlme.c
  staging: r8188eu: use is_multicast_ether_addr in core/rtw_mp.c
  staging: r8188eu: use is_multicast_ether_addr in core/rtw_recv.c
  staging: r8188eu: use is_multicast_ether_addr in core/rtw_security.c
  staging: r8188eu: use is_multicast_ether_addr in core/rtw_xmit.c
  staging: r8188eu: use is_multicast_ether_addr in hal/rtl8188eu_xmit.c
  staging: r8188eu: use is_multicast_ether_addr in os_dep/recv_linux.c

 drivers/staging/r8188eu/core/rtw_mlme.c      |  4 ++--
 drivers/staging/r8188eu/core/rtw_mp.c        |  4 ++--
 drivers/staging/r8188eu/core/rtw_recv.c      | 20 ++++++++++----------
 drivers/staging/r8188eu/core/rtw_security.c  |  8 ++++----
 drivers/staging/r8188eu/core/rtw_xmit.c      | 15 ++++++---------
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c |  3 +--
 drivers/staging/r8188eu/include/rtw_recv.h   | 10 +++++-----
 drivers/staging/r8188eu/include/rtw_xmit.h   |  8 ++++----
 drivers/staging/r8188eu/os_dep/recv_linux.c  |  2 +-
 9 files changed, 35 insertions(+), 39 deletions(-)

-- 
2.32.0

