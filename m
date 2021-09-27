Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91D0419DE9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 20:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbhI0SPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 14:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbhI0SPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 14:15:31 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FBBC061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 11:13:53 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id w14so16636400pfu.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 11:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WNHCmyzlbPvuB9nhXJQbm32Ns0acbl82S1wA5K3Qv2s=;
        b=QOvQjxG/eamR5Cj11gQNfDiV6MvJJ/3/IpAMVg/D3J1CiC1turuBh7x1cttqhJtlxc
         PFeK2Zq/FT57rvZyezp70pZtgC9ChaTfXawK9rUjS0VTdmEHTH3ualWFmDSi/0Mtsk6i
         i3e6lo+QP9l2DuCAlv0Zzu3DwZLXNo4qSDu5eNodyEhjz4o8aIWEoBmvaDlGKK5ojCTH
         hm+Zy8Vt9wr2Vo0Jj/m4AOVKZuZbv4sw7p7R+pN9haCTeJ7e9VZARUP96g0HvoAYU5W6
         HILhI9dgl51u7k6xAOsKSoAg5wq+zhfwrQXYmnb1mynA7qekcV8Ll9QKZkAgy9tuZG46
         MvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WNHCmyzlbPvuB9nhXJQbm32Ns0acbl82S1wA5K3Qv2s=;
        b=D0R3V1Tnup6qMe3ILIY1ZbyzyClkGazhzueaBUs/A129/KasQHvn5cYMKklyOQ5uYm
         rELbgeIyemceB36/BqflcSzxW/i5xlznBmYaHu1xotyWhUIaPdpuSIXZJTFda2T6VBiN
         47ztz/qMXUtB0Lkod+MEvmnwse5LwB0r5aTLl63ZUOZzy1Of7Tu2OgdbiqB0zjq8z+PO
         KrkJEWcFbX08OXsISsuQv+NM5D8sAWWKwb9+gNWkqWt/jwIkSlDgo9HD6Q8WIOBevmt6
         urUCtV8L9+pEEaQa5Ek2nC6ZcePuln3voFygMPz/kErFL0xFDjKfmVPW6R/H8F5U7Ffg
         61Hw==
X-Gm-Message-State: AOAM532C7rT77pnZA/mSixDVPvr9iqtifmiPbcaf4MK8sloJywJ5Nh6N
        X6I6x17rhUk0PKEl1o8ECf4=
X-Google-Smtp-Source: ABdhPJz37IWSAnyXgkYyZJdRdCh/UAUBACV0I5h25IUUuG9VcwyJA9izXY8dMoYjqP4jo4mAFHX+wg==
X-Received: by 2002:a63:1717:: with SMTP id x23mr889855pgl.182.1632766433406;
        Mon, 27 Sep 2021 11:13:53 -0700 (PDT)
Received: from localhost.localdomain ([122.161.52.120])
        by smtp.googlemail.com with ESMTPSA id q18sm18450160pfj.46.2021.09.27.11.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 11:13:53 -0700 (PDT)
From:   Ojaswin Mujoo <ojaswin98@gmail.com>
To:     nsaenz@kernel.org, gregkh@linuxfoundation.org,
        stefan.wahren@i2se.com
Cc:     dan.carpenter@oracle.com, phil@raspberrypi.com,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vchiq: Update TODO file
Date:   Mon, 27 Sep 2021 23:43:23 +0530
Message-Id: <20210927181323.10931-1-ojaswin98@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove completed tasks from TODO and add some relevant details to task
14.

Signed-off-by: Ojaswin Mujoo <ojaswin98@gmail.com>
---
 drivers/staging/vc04_services/interface/TODO | 43 ++++----------------
 1 file changed, 7 insertions(+), 36 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/TODO b/drivers/staging/vc04_services/interface/TODO
index 39810ce017cd..5a6b3fc2663a 100644
--- a/drivers/staging/vc04_services/interface/TODO
+++ b/drivers/staging/vc04_services/interface/TODO
@@ -16,23 +16,6 @@ some of the ones we want:
   to manage these buffers as dmabufs so that we can zero-copy import
   camera images into vc4 for rendering/display.
 
-2) Garbage-collect unused code
-
-One of the reasons this driver wasn't upstreamed previously was that
-there's a lot code that got built that's probably unnecessary these
-days.  Once we have the set of VCHI-using drivers we want in tree, we
-should be able to do a sweep of the code to see what's left that's
-unused.
-
-3) Make driver more portable
-
-Building this driver with arm/multi_v7_defconfig or arm64/defconfig
-leads to data corruption during the following command:
-
-  vchiq_test -f 1
-
-This should be fixed.
-
 4) Fix kernel module support
 
 Even the VPU firmware doesn't support a VCHI re-connect, the driver
@@ -68,22 +51,6 @@ The code follows the 80 characters limitation yet tends to go 3 or 4 levels of
 indentation deep making it very unpleasant to read. This is specially relevant
 in the character driver ioctl code and in the core thread functions.
 
-10) Reorganize file structure: Move char driver to it's own file and join both
-platform files
-
-The cdev is defined alongside with the platform code in vchiq_arm.c. It would
-be nice to completely decouple it from the actual core code. For instance to be
-able to use bcm2835-audio without having /dev/vchiq created. One could argue
-it's better for security reasons or general cleanliness. It could even be
-interesting to create two different kernel modules, something the likes of
-vchiq-core.ko and vchiq-dev.ko. This would also ease the upstreaming process.
-
-The code in vchiq_bcm2835_arm.c should fit in the generic platform file.
-
-12) Get rid of all the struct typedefs
-
-Most structs are typedefd, it's not encouraged in the kernel.
-
 13) Get rid of all non essential global structures and create a proper per
 device structure
 
@@ -92,6 +59,10 @@ for all the device specific data. This structure is then passed all over the
 driver. This is good practice since it makes the driver work regardless of the
 number of devices probed.
 
-14) Clean up Sparse warnings from __user annotations. See
-vchiq_irq_queue_bulk_tx_rx(). Ensure that the address of "&waiter->bulk_waiter"
-is never disclosed to userspace.
+14) Clean up Sparse warnings from __user annotations.
+
+This warning can be seen in vchiq_irq_queue_bulk_tx_rx(). Ensure that the
+address of "&waiter->bulk_waiter" is never disclosed to userspace. Refer the
+following link for a better insight into the issue:
+
+https://lore.kernel.org/lkml/YKxdCwsEb49Siwo6@zeniv-ca.linux.org.uk/T/#mc30d8c055c01952d2059873fedf6693948c0b1ca
-- 
2.25.1

