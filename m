Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E758742327F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 22:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236588AbhJEU7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 16:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236590AbhJEU66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 16:58:58 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA0EC06174E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 13:57:07 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t8so1876862wri.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 13:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VIhiZko/HdZRRX8wV8ISQub/+SSvOguPPMhdzz4lBsI=;
        b=F55aWN7B0tWVyyqkDpMB35S/HuZ/y5OfbQ3UQB86GaKfqZ0py0u1QrjhhAaQlThy4E
         7pnNICzzoTMcEH/JSoPXF9/irnPwwIYUZnGEI3gHwajirg7f1fuOpZTu6DTXVaEiMKQo
         n8W9FQN64cwQL//MQGkX/m21WXAQapWmu2EGeWy+peRf6oIwe21TMwNhtRL5GyAUE4LH
         YhDa4SGn0WzrWXbQtkWYw5s7+5MoVLIxdxhDrhmJv3flJJSeaJneEG/vwJN/dbTVHhMT
         nG10yuzh9LeIDrPmC5tZ9orYoQL8tuwJOx9w/cV17ms+u3i5X6KEF+3BGDPlI33A9uUc
         y2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VIhiZko/HdZRRX8wV8ISQub/+SSvOguPPMhdzz4lBsI=;
        b=CrDkdAdO7smGwewg31/7M/bFSyT/PiefTtGj1RFVyabS6et9geJubaDKomI6T3SoeI
         L6bAAa0mQSfdDpjCY6tToXW1UUlxAry4jjnSa1FdeRHaYxnbn/8qWKFizOxc6+lFQVXT
         HPRZdrMAsF1io3SRCsFw4g/fmrQor287ejyIZ0/YjhnbKVkqZusSDxvJhhKfCUzANiEs
         0/MUvF7+jcyf8NiPa6ba7idersEdTLxLq5WJMlYt0tvVteYX2+IBzs7w89PnVEjbVdpe
         dA60sgavKUpUe1W4u5QcaGiKLMqAdJG5aAU8p3X9oSMd1ZeZ7FJsUffs8l0H4/2tXFDc
         wr9A==
X-Gm-Message-State: AOAM533z1RbqcmMpsoyPGQmJurED0HqQcnBKcEvStOl5FeoRdHc0zbud
        1K/pbI8S9p9FpjSI8/e/k+c=
X-Google-Smtp-Source: ABdhPJxMcxauFEQGHdkkYeRphHVrjZgzBs8tyPX4bB6G74U+UgQGtcrW1hhPRdeepx7NtGQGv4g6jQ==
X-Received: by 2002:a7b:ce8c:: with SMTP id q12mr5856041wmj.14.1633467425703;
        Tue, 05 Oct 2021 13:57:05 -0700 (PDT)
Received: from tom-desktop.station (net-2-42-54-217.cust.vodafonedsl.it. [2.42.54.217])
        by smtp.gmail.com with ESMTPSA id p14sm2944109wmc.18.2021.10.05.13.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 13:57:05 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     tomm.merciai@gmail.com, Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/3] staging: vt6655: replace camel case variables
Date:   Tue,  5 Oct 2021 22:56:56 +0200
Message-Id: <20211005205702.14029-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series replace the following camel case variables into
equivalent snake case variable for vt6655 driver.

bShortSlotTime -> short_slot_time
ldBmThreshold -> dbm_threshold
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

