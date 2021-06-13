Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C438C3A5ABD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 00:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbhFMWDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 18:03:23 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:45045 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbhFMWDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 18:03:21 -0400
Received: by mail-lj1-f170.google.com with SMTP id d2so17331989ljj.11
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 15:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IuKzpRirfVOS5Gk5Z2HWNzA9wqs1tgOjY1RVjElESO4=;
        b=jVU9UqWAVt/ZUQbdCzoJfsQnuMYUTLINnFEW2yVkI3/Gu7aYAA9wURhXRqNXguMEZA
         uqJLrQUlI6YBEU18ZXKB8J+jO67/yUWLWUkwDioHOr+oeuYXQ6tzkei/Ukd7MxO2sP7O
         EHbdHBMqMz4MML8Gn5yimoPxyYqDyw5XJyiS/6dxBfDYdFJG94jhj2Nk5yZFtvfc+Sa3
         PB3fy7KHCsd0BTNhSmio0q9HBEW8HQlaZZewR+hg2DaU+2Cf+vUDRRokf9RZ+V2CIPzD
         bYheJO/OM8nuhgaRXK7q5SvzjMIfUaz4wEHBhAhI0P9fQwc0jK7m3MT6PLqL81QAPZhM
         IblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IuKzpRirfVOS5Gk5Z2HWNzA9wqs1tgOjY1RVjElESO4=;
        b=YpCnCE2MZx/W8eMiZOpzd0GacSTTxzd2IF4kfLLNcru+yKBqjKrMXCMSj/AZqz5UP8
         3aBkO1Qh4YMxv6oRprd+UP9Ct5AYmzMdVMrK8OuHL/gFvMBq6obnWMSZVurGIo7D3vtE
         P7sZn7otP/FZBS8inJaGZ2CDLfBEK0sfKy2zFeIsJ+bqB5SRLcqMP3UfvG5BJZ44yaU2
         eeV+uZdiQv67YljiAb44JlwpY3ub0VZVL0oIRaO5eZImQE47HySJDkNtCfO4kVxEWNoW
         mGfEzC2kHdBbuCveHPxGhr4Fs2rQTRZuNwMON5361wKFtpuLWbF8YAw2d5QZ3toS2hMm
         e6dQ==
X-Gm-Message-State: AOAM533uaoKz++IzKzNFWMT1kjw87WdQyT/LV8KPHfcVqH2aNhPDuOej
        D+Q3QGTWgPKHPCwCKNZUD+I=
X-Google-Smtp-Source: ABdhPJwcPbPJhxO/kVLIRVqR+pqTqLB8htlWu/WFMC9nEMP4vtCWY0g1pZYxO7zAK/YIMRBUkk3e7w==
X-Received: by 2002:a05:651c:38b:: with SMTP id e11mr11214582ljp.198.1623621602348;
        Sun, 13 Jun 2021 15:00:02 -0700 (PDT)
Received: from localhost.localdomain ([94.103.229.24])
        by smtp.gmail.com with ESMTPSA id o20sm1282335lfo.302.2021.06.13.15.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 15:00:02 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH 0/3] staging: rtl8712: code improvment and bug fixes
Date:   Mon, 14 Jun 2021 00:59:30 +0300
Message-Id: <cover.1623620630.git.paskripkin@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this patch series I fixed 2 memory leaks in rtl8712 driver and
made some code improvment. In the fisrt patch I removed redundant
branching to improve code speed and make it more straightforward.

The folowing 2 pathes fix 2 memory leaks in this driver. The first one
fixes memory leak in the error handling path in r871xu_drv_init and the
second one fixes memory leak in case of fw load failure.

Pavel Skripkin (3):
  staging: rtl8712: remove redundant check in r871xu_drv_init
  staging: rtl8712: fix error handling in r871xu_drv_init
  staging: rtl8712: fix memory leak in rtl871x_load_fw_cb

 drivers/staging/rtl8712/hal_init.c |  3 +++
 drivers/staging/rtl8712/os_intfs.c |  4 ----
 drivers/staging/rtl8712/usb_intf.c | 32 ++++++++++++++++--------------
 3 files changed, 20 insertions(+), 19 deletions(-)

-- 
2.32.0

