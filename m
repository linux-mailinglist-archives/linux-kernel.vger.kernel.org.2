Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016193D1788
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 22:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbhGUT2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 15:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhGUT2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 15:28:19 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F898C061575;
        Wed, 21 Jul 2021 13:08:54 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id n1so3427884wri.10;
        Wed, 21 Jul 2021 13:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x6EutQE4FqvS74NAlrxQkWcx53oV130UW/bI7WrrBzg=;
        b=QDPdbsGqpdiDce06xAc2kqd5LqhpF3Wy/f3d69KqaPi1YvEHO2jYlYUWVLsYwNXUbV
         xN3yA+8BCcVtHz5j9TGJgqLFcd9geuyrv54XcYskHdo2bCfU5i/+ugnig5yrS8VOIssX
         Lq/AHrNAR6Fjw7S8O9q6dVqk0T5pSjXjAjJ8m1vPDEkKyL1Dzml7vie1E7OhAWcpyvnr
         NJkCe6uPZa7Tf7UAtLtKuRW6YS0or+8qZCwdf55sdl7wn8+tB3Ossg4VhYiW7ftTYAY/
         wxzuo92Pg8lZCRoFvKDoX5GX67M1lfP7d4Y6/xLC5LFZ0tWyIYjXcqer6cjSBX4mdoIF
         xZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x6EutQE4FqvS74NAlrxQkWcx53oV130UW/bI7WrrBzg=;
        b=CmN/SHzX6laSK/VteSd9Nn38fogVlJv4Hg+yI3OTJmbL4aSEbQNDeK2Z5Mm1T7p+W+
         6OKGkt7DTvYeHg0tWYIzkq5Zhho9JVoowNO+Wy0gm1xfuTaWJlk6gYukrPJJOEQMioZE
         WPMsiqz7b3wlqBxCEQqCfgnkPEIq7I2nC15nb0tsCEFm1oY6JkTRsXOu1TZIREoHkeam
         wwrPI/r5tuvZodfjQcsooRLs2Tgy9kD++5TGTGA7WRJNfxGc9cUNQrR9RjqUUr/A7vSM
         xUUaUWu0wd9TD4jowqNSopMhOrI7YxmZbayp7vWeicWVGDp9AhPSTWVE+BK3LoZwgupH
         7iMQ==
X-Gm-Message-State: AOAM531O0JiSs3vrvlFIEJcn4rVdse8PvQrses+wWhp39A2MMT/4aYgz
        TES6ZgrgOpC1egPc8meAXYA=
X-Google-Smtp-Source: ABdhPJyXut89uwmrQ6z/K4M5428MQGzr2KL0xdxshah/vl1jN7DmXpmJY+11e6EcMCiTdbPBWgldxg==
X-Received: by 2002:a5d:4912:: with SMTP id x18mr45935545wrq.310.1626898133125;
        Wed, 21 Jul 2021 13:08:53 -0700 (PDT)
Received: from kista.localdomain (cpe-86-58-46-198.static.triera.net. [86.58.46.198])
        by smtp.gmail.com with ESMTPSA id k24sm28927162wrh.30.2021.07.21.13.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 13:08:51 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, jernej.skrabec@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] arm64: dts: allwinner: h6: tanix-tx6: Enable eMMC
Date:   Wed, 21 Jul 2021 22:08:30 +0200
Message-Id: <20210721200832.916644-1-jernej.skrabec@gmail.com>
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

First patch only sets proper power supplies to GPIO banks and second
adds eMMC support.

Please take a look.

Best regards,
Jernej Skrabec

Jernej Skrabec (2):
  arm64: dts: allwinner: h6: tanix-tx6: Add PIO power supplies
  arm64: dts: allwinner: h6: tanix-tx6: enable emmc

 .../dts/allwinner/sun50i-h6-tanix-tx6.dts     | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

-- 
2.32.0

