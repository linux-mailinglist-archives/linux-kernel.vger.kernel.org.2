Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCEEC3D2754
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 18:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhGVPbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 11:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhGVPby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 11:31:54 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459B8C061575;
        Thu, 22 Jul 2021 09:12:28 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u1so6544904wrs.1;
        Thu, 22 Jul 2021 09:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DknKiUJ1n/RLZ4+I9ca+avCYVdAr6cHwKq7eFg5+Szw=;
        b=Gxc6+feSDwxy/kDJZFwuTtl8x0XIhG4/HY6AJSVZQS/yMXLirtt46OFoBlypl0kK9p
         G0pSbtGUQxF9MskmpLxHrIlptkC5xdNlNt4rDmjFkJtIhODYLVWu77dyo6kFWRb+952x
         IhOeM0SYJznAWqJaDUvoqgtsuKlkxVOWORg+9GZmxO4nK5HhEa4vFZz9HAx5Aj9sv73T
         StVdp/no0rd2qviEsN0eUXtRPMu5sv8W7pvvwM7buP6PCJ38xjxHaLOgoIMlVYIRSq/0
         CfNu3DKOrdjw1ksahy8d9OgQYTgl/YN8IeFTWRlpOXc1SM2dNtrZCYlknLm09b9qKkGI
         DyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DknKiUJ1n/RLZ4+I9ca+avCYVdAr6cHwKq7eFg5+Szw=;
        b=jRFKd9tvUp2My1GXS/1YwygwFCQ+zc5WnkrQozlpPir6BaglCSNrqw528F1tEQHEaf
         Z5R3TFaN2MH+3kkswv99odZCKyHJwCr0Wc9SfjQiVuEX+F6BvLo4yq8JNpBvNtQUl6vh
         dlAOQzboeauXG9PFlUsQprOrobl8PZZ1uwuwKpjAJrhukJvlBPssPqEMGTn3AvP+hmKW
         zHfznt6MFzBJmo7ROyENuPHn2Mu1lW/3olYghweesJQJDNc6AzMFVawKksUYy003VmtV
         i0m7LYzdCQ44BT3muX0/4t1cUF092vUhVlVFyAPbomEgZPDl/0OveEs8RsTJSc/j6vpC
         ZiMg==
X-Gm-Message-State: AOAM533BrXggRM8pfLTPrW0mC3dVNC3wVMSINgAFLD22Qpbfv2M9lvuc
        uwWfQrUP6FjWpdbdxL8mAh0=
X-Google-Smtp-Source: ABdhPJxus3TmI2AC0/9MZCiNd+lOPiUbsD2XoBS2EVm2jWx2T4xw2ho8fBhw+wTDLElVUsKpKhKTRQ==
X-Received: by 2002:adf:eed0:: with SMTP id a16mr730587wrp.324.1626970346872;
        Thu, 22 Jul 2021 09:12:26 -0700 (PDT)
Received: from kista.localdomain (cpe-86-58-46-198.static.triera.net. [86.58.46.198])
        by smtp.gmail.com with ESMTPSA id z6sm3585363wmp.1.2021.07.22.09.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 09:12:26 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, jernej.skrabec@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] arm64: dts: allwinner: h6: tanix-tx6: Enable eMMC
Date:   Thu, 22 Jul 2021 18:12:17 +0200
Message-Id: <20210722161220.51181-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tanix TX6 box has a 32 GB eMMC module. With changes in this series, I
get following figures with hdparm -tT:

/dev/mmcblk2:
 Timing cached reads:   1638 MB in  2.00 seconds = 818.44 MB/sec
 Timing buffered disk reads: 376 MB in  3.01 seconds = 124.74 MB/sec

First patch fixes regulator node names. Second patch sets proper power
supplies to GPIO banks and third adds eMMC support.

Please take a look.

Best regards,
Jernej Skrabec

Changes from v1:
- added patch 1 (fixing regulator node names with "regulator-" prefix)
- fixed regulator node name in patch 2 (adding "regulator-" prefix)

Jernej Skrabec (3):
  arm64: dts: allwinner: h6: tanix-tx6: Fix regulator node names
  arm64: dts: allwinner: h6: tanix-tx6: Add PIO power supplies
  arm64: dts: allwinner: h6: tanix-tx6: enable emmc

 .../dts/allwinner/sun50i-h6-tanix-tx6.dts     | 27 +++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

-- 
2.32.0

