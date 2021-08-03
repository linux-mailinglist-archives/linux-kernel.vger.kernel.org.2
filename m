Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC613DF830
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 01:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbhHCXFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 19:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbhHCXFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 19:05:51 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F0BC061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 16:05:38 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id d131-20020a1c1d890000b02902516717f562so352935wmd.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 16:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dExigQFq2bikAAyS+Bb2dcMDAwUeWzaGvsu6udgmIRI=;
        b=pe6Sakxo5vFNLsVkv3ZXJsBMud3HGwLWNJn0Nbeeo/S3k1vmOP7rGznnAkrrWgDr2y
         spdS7f3paybA/mEd9K0lpfWCHjjEhMBF/gjW7EfqyX4xDNfiS8mWMrLw9sErWn6fhiNm
         f71yV49mqQlDxOjDQoSbNt1DaEwQX18ERW6t3Mc1JzSR9q8V9R6VSOruip1uK37CYJcU
         5zHHmDV8cyzZdcdNWZ/JUE/C9WKX0eFNIvFVqypI27nP7wH6IzVbK2Fg1TriGZPleT05
         dniLkzpoyWwJBFVLyS1QtXWkUqbIFpXQGlkAuugjGkb3XZkEFEt6Aiu555Er8ZXNJfOB
         Nt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dExigQFq2bikAAyS+Bb2dcMDAwUeWzaGvsu6udgmIRI=;
        b=EAw4RMDJjRhCLkvsmx1zGzNI7jkKG3Mr5ahBqwZZiyLkGxq4GQrA6YEUVDSmxxx2ey
         W2XZFBSXb7CMVNQzAHSORr6Hgy36E+fxOBNGDQ16E0LDk7hv05gb2kGvzSrpY0X9Oew/
         X+zzeXNWKCh5+UDUqsJ2mwlxIn25e1b/Q+zhGuGCAuWpo1tqCsM2EdQ/x+5iP4r9rT9a
         e6bfhJ2x6lJEUYjLhnlP7roKOIwL1M2Q9jUz2QMzeRK0C0NseuDy7XLONryP6u69k+SZ
         vKpN/lBfqIvsp0yDu8TsmJyAWYB2G8GjDbs24qyrcaKI4lUfMMtSoXv/CCylltjpczVw
         7vkA==
X-Gm-Message-State: AOAM530NGkJKVn9LiLvwFYxFyi2mbHTOxNbCH4uCISMH5/HGktfT93rx
        DMSfFcmuTw8P7WcjjfAO4sdytA==
X-Google-Smtp-Source: ABdhPJzr19GCXECagYssGyk+ieKXA/aA1BPUQOIN8TyfH8I5xBposjYZUMoQqDwWI+c0TcOw6gt3xQ==
X-Received: by 2002:a1c:1f10:: with SMTP id f16mr6562109wmf.140.1628031937341;
        Tue, 03 Aug 2021 16:05:37 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id i29sm330045wmb.20.2021.08.03.16.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 16:05:36 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] staging: r8188eu: remove hal dir RT_TRACE calls
Date:   Wed,  4 Aug 2021 00:05:27 +0100
Message-Id: <20210803230535.74254-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes all RT_TRACE calls from code within the hal directory.

Phillip Potter (8):
  staging: r8188eu: remove RT_TRACE calls from hal/rtl8188eu_xmit.c
  staging: r8188eu: remove RT_TRACE calls from hal/rtl8188eu_recv.c
  staging: r8188eu: remove RT_TRACE calls from hal/HalPwrSeqCmd.c
  staging: r8188eu: remove RT_TRACE calls from hal/hal_intf.c
  staging: r8188eu: remove RT_TRACE calls from hal/rtl8188e_hal_init.c
  staging: r8188eu: remove RT_TRACE calls from hal/rtl8188e_mp.c
  staging: r8188eu: remove RT_TRACE calls from hal/usb_halinit.c
  staging: r8188eu: remove RT_TRACE calls from hal/usb_ops_linux.c

 drivers/staging/r8188eu/hal/HalPwrSeqCmd.c    | 20 ---------
 drivers/staging/r8188eu/hal/hal_intf.c        |  3 --
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 25 -----------
 drivers/staging/r8188eu/hal/rtl8188e_mp.c     | 43 ++-----------------
 drivers/staging/r8188eu/hal/rtl8188eu_recv.c  |  1 -
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c  |  9 ----
 drivers/staging/r8188eu/hal/usb_halinit.c     | 27 +-----------
 drivers/staging/r8188eu/hal/usb_ops_linux.c   | 38 ++--------------
 8 files changed, 9 insertions(+), 157 deletions(-)

-- 
2.31.1

