Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2EB40AD3E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 14:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbhINMPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 08:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhINMPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 08:15:21 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCB6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 05:14:03 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q11so19813819wrr.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 05:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WG3o0NPKF4oM/tA2/pUsvZD7ibEQxGbhXbUXWj0SZd4=;
        b=GJdn5Uh8WrxXCQERCWhk0lob2qap5Cd2LwunFkORyXmigauemhDPc0WA1v5RAWN3t6
         5qFk7ps3jFCQHR+cFXOO2/0njuA2aCphVwI2CueihLxFbBgF2LDr5sAvn82r9HTJCa+z
         2H38dT9nC7Ud1zsWNrHdTbwA4yFhVzvpR6RM+VGRGLNrsi+HJvYLOPs2GUCtyOabej8U
         OL7HvFLDy4NfVmscX8z4pi0tQkVowDZaIj+SfcBFZYY10Q/F+FyfNAu9dKV+/h2PsA0w
         aa/af0Hzk8Si2piLZvvGAsX89eBxsXHhqq2hwp/jhbGtUee9NI/1qB+K7UZoOudZpoLK
         6NHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WG3o0NPKF4oM/tA2/pUsvZD7ibEQxGbhXbUXWj0SZd4=;
        b=hQ1/+EY4tvoScdWJCIi1zJzTOrUe9YoR80lPOcXX3cly1UJHPjcRNRk2AVEUOezos3
         UPMhcpaotodsBKOr1tU9107MnqA8PYWpzfV6PyU2CIW9eHGg8NRFIMIaS8LaWaHfRd8K
         HLAIJIkN9HH36ifXaLLpwmZlG7KWrOfCxelPAz1NRVn1zwpjWhTfEvKlJ+Yuvjuk8gft
         035VLu969WNShWvQv+KEH9LYUQPGRl664XrqwtPaZTKAfCRD04uabmNKAFTUYVjZH9Vm
         ODRlqE2Hp2VHvhLctOc+PNAR7nRflXZcFKHQXzZIuL8JkwHkcpyUmeysN4epOMIGR+JB
         dVcg==
X-Gm-Message-State: AOAM531Cyjs8nlwQU12IO6MeyuUmyibatZbakyh5VM2Y2gzCEWtW+Dtn
        t3PiXpULH/p7BkhalRYD+AqGzftR/yxfcQ==
X-Google-Smtp-Source: ABdhPJzim/4QKv1GY4VteX70vQ+pZ2HZAuHh25CzF/BbtQBP6ceeJvT+s7LVwCwi9XaS4eKmGj4gMg==
X-Received: by 2002:adf:8144:: with SMTP id 62mr18661185wrm.144.1631621642459;
        Tue, 14 Sep 2021 05:14:02 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id j19sm10028100wra.92.2021.09.14.05.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 05:14:01 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/4] staging: r8188eu: remove unused fields from struct hal_data_8188e
Date:   Tue, 14 Sep 2021 14:13:48 +0200
Message-Id: <20210914121352.26052-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes some unused fields from struct hal_data_8188eu.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (4):
  staging: r8188eu: remove unused macros from rtl8188e_hal.h
  staging: r8188eu: remove write-only fields from struct hal_data_8188e
  staging: r8188eu: remove unused enums from rtl8288e_hal.h
  staging: r8188eu: remove unused field from struct hal_data_8188e

 .../staging/r8188eu/hal/rtl8188e_hal_init.c   |  5 -----
 .../staging/r8188eu/include/rtl8188e_hal.h    | 22 -------------------
 2 files changed, 27 deletions(-)

-- 
2.33.0

