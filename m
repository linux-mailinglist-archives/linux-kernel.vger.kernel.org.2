Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C663417C87
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 22:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346014AbhIXUvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 16:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348484AbhIXUvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 16:51:04 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5234C061764
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 13:49:30 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t8so31114067wrq.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 13:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wdgqtRpc9sO5oNDV8qMEuEdtDpa8CWTtIfeCG6MLKKE=;
        b=UJr1/0VX7iWfrNdJ0ZBTDMXjpi0+Texx0ens2JfWS2BM7Du//txUvRaKrJpGzoO9ad
         Gt5jxdeJAm2NK5N8FXOiCF43BVpVXE0OXMkz95qzws1ZaQiNRzSFx72MPp7JUPJk4QYx
         0tsq+2HT8GuPupKgllCF/UVDcOhvbcm06t00yItAx2NSJ21bQmFOHF1ZjQT0CIvC/wFT
         jk2BV42a6h/yiwK4gP74+JBipJQmGtrpJhe9YMyFA40gbLxbz8Q7KB4Yy9IHY542ZVk4
         qAlHbdem78znbSwGV+tBM7B4PfesS3T2H57Z29oAO++9xDCxsySGIOWw/8S92gtA0ct5
         E7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wdgqtRpc9sO5oNDV8qMEuEdtDpa8CWTtIfeCG6MLKKE=;
        b=qnS7hHbsHmryr+XOWrQvSY25/yYEmwhox0wtNMQT/TJkr2PlIeK5IEhbXjuf3Lspiq
         3/9zAmQh/3/ZSEIIdgExvvIrqCD7AWG7Ik3ntVbJvMyQvo4XsrrJ856Mg35XRybhr9eZ
         DV1vrilRzh3IA6TgwmlejhP3bWK2cPWcPp0AQsdwxIWJixbwSlYsM6FfRgB1TNmammmv
         up6b7EgIFDLGQnQi2LMr/O44tkXlsCqFOAe9lj00zdQvQ0NVH76MdZpa06AomA8caiUs
         vKennlEj0/fbhHSXvRlBj/Lp9DoEjEkkvsUz3zTr9jnlg2XxNZ5M295Y6cV2U3V8V+5m
         mLYA==
X-Gm-Message-State: AOAM532OH5kgdsKHP6XL835DCG0zYLAB9/I02dIQPfxssoaYvfq546ZX
        1mom/Y4DhU1l+I4Shc+cbJw=
X-Google-Smtp-Source: ABdhPJzYKEcoKAOo9GMtejXGeZ+EdzpLVvd8n3ZmykcBMrgyzuYfWL2zCFuGNHIvYiMBg9DrhOKNJA==
X-Received: by 2002:a1c:2246:: with SMTP id i67mr3982600wmi.157.1632516569444;
        Fri, 24 Sep 2021 13:49:29 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::51da])
        by smtp.gmail.com with ESMTPSA id j19sm9040292wra.92.2021.09.24.13.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 13:49:29 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/5] staging: r8188eu: remove dead led code
Date:   Fri, 24 Sep 2021 22:49:12 +0200
Message-Id: <20210924204917.6313-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes led related code that is not used in this driver.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (5):
  staging: r8188eu: remove dead led blink functions
  staging: r8188eu: remove dead led control functions
  staging: r8188eu: remove unnecessary comments
  staging: r8188eu: remove _InitHWLed()
  staging: r8188eu: remove LedStrategy from struct led_priv

 drivers/staging/r8188eu/core/rtw_led.c    | 1364 ++-------------------
 drivers/staging/r8188eu/hal/usb_halinit.c |   15 -
 drivers/staging/r8188eu/include/rtw_led.h |   18 -
 3 files changed, 90 insertions(+), 1307 deletions(-)

-- 
2.33.0

