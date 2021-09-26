Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5C9418A23
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 18:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbhIZQ1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 12:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbhIZQ1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 12:27:10 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64AAC061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 09:25:33 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id y12so22403259edo.9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 09:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nqXZqy6TiqE8eE00BF1LDOzBg1qch1dHyP2OJeEPPiA=;
        b=XazMtSJSZkz1wAJVLRJT1NXQav3+p2ru3lzc0Oz4oBgxrL/DZuNeWb1gWdwSvcqopE
         Vh9nj/eNuLTqz+NhKMRNPY8abUgcpXRQfw5bRKYGgiSC9C+lmS4QRQqvTuwK/deBsS4z
         hu7I+d7PGPXXL3zTWs1nx0ODCNU+O2AovTTfVvUHjtkXszDJsA27+N2fyGWu13gQfZBX
         46r9Dcl3kkIVbLXPeISF6GzVNsYuTewz7BHx45IWQD+vnyOzMPH1OZ6aG8SDUzYJwSt0
         ZOmnjV3Qu90ckuUKQdPoTzTLrERthCRnCB68VDNPIQF9hpml7+EJKQdXTU+BrqGLKDjK
         NfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nqXZqy6TiqE8eE00BF1LDOzBg1qch1dHyP2OJeEPPiA=;
        b=5lHA1f5g854VHu4u8NzkU+DfsU+0m7SdmIgyNPM0039FZJvs0/GOTKGXDiRRcZyR3U
         qYYkTq82f/IC1/E9RHJvSij0bRWkhGQuhUg52X2KTwxYWv27bsZT60icH9sK845Nd7sn
         hMluE4MMtozQqBko6daT4i7cRHQzX4gYyFzVVkd1QQL5zow1/xFYrTJOTpz/IXmNuCOz
         9EbMwCNSjMer9GLiWaMRpwnIrTebtfgChQ0NWqpP2ON3/yLgk1bMtymBU/upULnVh/2P
         zAlZ9G5n3uNdu/DrXCzZPlaDDRT14UCiCGOeobTcbT75HFmTUToxUmc8n/JIUP5VHLlR
         EeiQ==
X-Gm-Message-State: AOAM5321x4xV7nmDNwSKLvXmAeLdSQIn+NaJZstk/W6M+7ruAbkiJbKV
        fCsUxFH3OMmMXCBywiXN7YE=
X-Google-Smtp-Source: ABdhPJzz9IowKn8GMH2gzlTte3YhVM2UvIVb7EE6s1r3A7uSbgkK9LmsPpX3A5ORbGAQrx0+AkWSyw==
X-Received: by 2002:a17:906:a394:: with SMTP id k20mr7954254ejz.137.1632673532093;
        Sun, 26 Sep 2021 09:25:32 -0700 (PDT)
Received: from tom-desktop.station (net-93-71-218-228.cust.vodafonedsl.it. [93.71.218.228])
        by smtp.gmail.com with ESMTPSA id z18sm8983208edq.29.2021.09.26.09.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 09:25:31 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     tomm.merciai@gmail.com, Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Yujia Qiao <rapiz@foxmail.com>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        =?UTF-8?q?Aldas=20Tara=C5=A1kevi=C4=8Dius?= <aldas60@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] staging: vt6655: replace camel case variables
Date:   Sun, 26 Sep 2021 18:25:17 +0200
Message-Id: <20210926162527.21462-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series replace the following camel case variables into
equivalent snake case variable for vt6655 driver.

bShortSlotTime -> b_short_slot_time
ldBmThreshold -> ld_bm_threshold
PortOffset -> port_offset

Tommaso Merciai (3):
  staging: vt6655: fix camelcase in bShortSlotTime
  staging: vt6655: fix camelcase in ldBmThreshold
  staging: vt6655: fix camelcase in PortOffset

 drivers/staging/vt6655/baseband.c    |  58 +++++------
 drivers/staging/vt6655/card.c        |  90 ++++++++--------
 drivers/staging/vt6655/channel.c     |  10 +-
 drivers/staging/vt6655/device.h      |   6 +-
 drivers/staging/vt6655/device_main.c | 150 +++++++++++++--------------
 drivers/staging/vt6655/mac.c         |  46 ++++----
 drivers/staging/vt6655/power.c       |  24 ++---
 drivers/staging/vt6655/rf.c          |  12 +--
 drivers/staging/vt6655/rxtx.c        |  12 +--
 9 files changed, 204 insertions(+), 204 deletions(-)

-- 
2.25.1

