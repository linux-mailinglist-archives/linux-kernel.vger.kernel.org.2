Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02DC2377350
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 19:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhEHREx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 13:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhEHREw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 13:04:52 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD517C061574;
        Sat,  8 May 2021 10:03:49 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id x188so10213733pfd.7;
        Sat, 08 May 2021 10:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OycDK6KPVRb8//ZVPv/9u6PQEVkLayHxqAb9uY3wxwM=;
        b=fzkHYQBi002p+fXFrGA9M5xSlHEKSUdWqVIIEUG8v+TUNcyNg8JDTRgVkTplcC3f9P
         cV3gyEFz93fJVqhKyAnX+g/M4yVbLXzPRiyDb6qAPVFy9lvkGIaI4VCFSnK/xVI06oAx
         3GzTaBB2TkvVD+NheiKMekK9m1/xJ4RgPEm9spvHYI3jpQ7lB6B2pHjjZhnVPkTZNFOi
         U8kqZ1kJX4WDiC/7le4seGI/GYbw08Zlq46lAYcqV7ooHit9OzewvWl54YyVZal0IF9z
         vj1fEqhJIgnROo71prH3mI8BYaJbBMVn/pRwXek4B/r02pkMk3LvlIuPZIhjtGpnabVe
         Vssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OycDK6KPVRb8//ZVPv/9u6PQEVkLayHxqAb9uY3wxwM=;
        b=VQ3W1cwc7pe3g2AdSUgYCGqFcA764Bhl7h2llrw7D+dKOuw97sUfvx1+dWDyLsPL7w
         Odl+HxTuU5xEwrDqpHI80avPnc+GmMybibWayUGj8VCfPUrHD2ae7zYFi2mHB9ouzkxg
         mJo/J2KWsCwwEKQuFIaMWN3bSkswWUm3Ylm+Jz8cUsuQrfa74Kp/aJioxfpS4dQTH1zm
         JW4/UqeyFu4zVmDhW8n5IGYNUoNKB1Qolgud6/F7cswN0MoH1HfS0VLCI6t++P+PNXY6
         9IunLgPDRSKvVfwvUIyfxoEMWBTxv7BkzHUXSZ8oT12TcCW5aiO1SFTXw6la88Dmr350
         l9BQ==
X-Gm-Message-State: AOAM532K/nWUtaV6bIc5RdDPrFwpPkxFofWoDi2Ua7bggqiaQ4WR5g3H
        V7/4Mo6SUUZGdGwL2Kb2Am2Uw3NwUpo7Pg==
X-Google-Smtp-Source: ABdhPJw2rSrpCfMqQngV4D+Aw+dxWU+rMTvoRot+Rk20vI0fb9ATLhDow1uqrAvT1FMkLVoyQXGRMA==
X-Received: by 2002:a63:fe53:: with SMTP id x19mr16011394pgj.372.1620493429173;
        Sat, 08 May 2021 10:03:49 -0700 (PDT)
Received: from localhost.localdomain ([2001:4490:4409:357e:ddc0:965d:2b13:8892])
        by smtp.gmail.com with ESMTPSA id g190sm1674468pfb.60.2021.05.08.10.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 May 2021 10:03:48 -0700 (PDT)
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     b-liu@ti.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurav Girepunje <saurav.girepunje@gmail.com>
Subject: [PATCH 0/2] Remove unused variable in musb_host.c
Date:   Sat,  8 May 2021 22:33:15 +0530
Message-Id: <20210508170317.24403-1-saurav.girepunje@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains 2 patches to remove unused local variable
from function musb_tx_dma_set_mode_cppi_tusb and function
musb_tx_dma_set_mode_mentor in musb_host.c file.

Saurav Girepunje (2):
  usb: musb: Remove unused local variable dma, urb, offset
  usb: musb: Remove unused function argument dma, qh, offset, length

 drivers/usb/musb/musb_host.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

--
2.25.1

