Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F723F5E12
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 14:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237325AbhHXMiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 08:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbhHXMiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 08:38:17 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3FBC061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 05:37:33 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id z4so15472834wrr.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 05:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GJYXr1tQ9EygzFDus9BYevQzwoxX27JUJzZM6AwoQ/Q=;
        b=TOgfy24VyrFMnXNTA59pq37fgDL8mWQIBDKcQgeUVv5/CQn2vnZXNJRWbyMwKua2+8
         ZcE4FGtH35GNqxil4bU9Ev4idaYfT2Wn12HdpaI2rOMhy8UwS7Wbtmk9lYEnWiZRGuSJ
         PuQw+pv0uTwGAnHTxMWBSvGN2LXZtyeMZk9d/kCWxwUXA48H7WptNM29YlyuSwVCou8f
         gKf6kWC3+k8+Vjlqc2KRxRd0ujsm8kvEwkWhVno1bGBb8zNdpkeonM+ufDsPUavVIeHm
         sEKgaQHiEMTPNIHV1DmEuKXjo0+rOLxItLGdcHZW14pbh8PTUm93BJX0br+jeOm0slVB
         wr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GJYXr1tQ9EygzFDus9BYevQzwoxX27JUJzZM6AwoQ/Q=;
        b=SEorrKo1jV8KZphAaEwNXaNhbDBA2RGmUsC0m0CpzDDiDSUmpDyXI3sbook5lUPnz0
         d5huRwGIQUStXPELqenxXfXfkMGB6HQZ78ekuTsWYMdaH9bFhsntSyRwbli9WPZExJHC
         +XZD7g6+4FIHoQZUVCFfAcQsz/noHqkMv+MqlU75SWvDqwqG7QOhoB82ct2nVpXLgXWl
         Mqdh5JRJtGAvmjKjLWHfLez/dHXY926UuWTG5RrKAOFoVLDxM1rofCFkOVzrzWhV1UHK
         x8Tmy67kBkzUQ6Kia5A+DyfFYC6SgKyBPfqnpJ8yQAXImtTQPjspwcdV/Ng0ChtJ5NhL
         ZRqA==
X-Gm-Message-State: AOAM533wpEVBbdLnrdXoOSi1Hc2ADxUQyB8oZ0Z1sHLzAtCzgWw4uyH/
        A6t8cA3Uf82CsFdPs6Ah9EQ=
X-Google-Smtp-Source: ABdhPJyiunSCyQgCKbvtnEsWdpjVKt5/WbMN7JYPDMA2OuKfxpZmurGv6Lx2yJd2BtCoumCcpdOkMw==
X-Received: by 2002:a5d:5107:: with SMTP id s7mr18742280wrt.283.1629808651721;
        Tue, 24 Aug 2021 05:37:31 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::5d87])
        by smtp.gmail.com with ESMTPSA id u23sm2137450wmc.24.2021.08.24.05.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 05:37:31 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 0/3] staging: r8188eu: remove unneeded header files
Date:   Tue, 24 Aug 2021 14:36:18 +0200
Message-Id: <20210824123621.10801-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes the header files if_ether.h and ip.h as both just
duplicate in-kernel definitions.

v1 -> v2
Added a patch that removes the header file ethernet.h.

Michael Straube (3):
  staging: r8188eu: remove if_ether.h header file
  staging: r8188eu: remove ip.h header file
  staging: r8188eu: remove ethernet.h header file

 drivers/staging/r8188eu/core/rtw_recv.c      |   5 +-
 drivers/staging/r8188eu/core/rtw_xmit.c      |   1 -
 drivers/staging/r8188eu/hal/rtl8188eu_recv.c |   3 -
 drivers/staging/r8188eu/include/ethernet.h   |  24 ----
 drivers/staging/r8188eu/include/if_ether.h   |  94 ----------------
 drivers/staging/r8188eu/include/ip.h         | 109 -------------------
 drivers/staging/r8188eu/include/rtw_recv.h   |   2 +
 drivers/staging/r8188eu/os_dep/recv_linux.c  |   1 -
 drivers/staging/r8188eu/os_dep/xmit_linux.c  |   2 -
 9 files changed, 3 insertions(+), 238 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/include/ethernet.h
 delete mode 100644 drivers/staging/r8188eu/include/if_ether.h
 delete mode 100644 drivers/staging/r8188eu/include/ip.h

-- 
2.32.0

