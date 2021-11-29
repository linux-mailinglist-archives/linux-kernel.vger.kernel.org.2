Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC66460B8A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 01:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376373AbhK2A0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 19:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233716AbhK2AYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 19:24:05 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD30BC061574
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 16:20:46 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id 132so20972371qkj.11
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 16:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n1iIWR8y8i1TsM47bqS8ycmKwC5SFhPu4DtybjjRQCo=;
        b=c9YKVhBAmFRuPXPUOiRmNYdz1hbseITir4fWP5RVw4YtJydwrJ2jOuHIL2BStBZZAB
         Oul42L8Gwn3RBNVvDVbdTLpyfrqnZnLoSdkTndCtL3vSIUACsdnFyRcBZnni4A0QzT95
         8jSM7aQY5ZHqn9ictQ3ddTHmfX72/XZFYKB6bPtyiyEAY4RSA3J6bJqiMHSIb2mhjgcW
         V7wQmovEZVIr5eEFQCstoG2YhX2OmjfR6mytNdAO2rtvi8khA4LXz/G5YSBF1HLkWa56
         gp4Itq5qaRIqD8uJ1TmmiZ5FSh5PDH5PYJmm1oTzMFYaygaGJ/dLzvNpHWWVY38+sqvy
         CD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n1iIWR8y8i1TsM47bqS8ycmKwC5SFhPu4DtybjjRQCo=;
        b=pyz1Pa1PjC/5LgVFnHhoi4NaNuICCKRKHZKos49L0QH5z486uE5OOg8NCkFSWD5wWo
         oSsnBWms2t6zx7NnZnkcJ/F/yUhIfwwZEEPbeeu1ufcrtCgvYdKDDE/qXTL50KTtNpN7
         NRUtfB9m/PeAwWHjyI6WLMnL+OW87OdXTKM/wb/iX+8QWA8+r4/TcdB6g3FKWChjvVmw
         7sDcT80LpmjLjrmEJQf20Mb1tnlMKgbSJDPXYM2eojXwiBnjRb0lbUR1tG5CjlYqGcEi
         Bx9cVfVlg5UR7edWUGR7DP5oMmBDw83lVaAzCLWBJIWnX10bW3/55HLNTh+JjZiHRcqF
         FGBA==
X-Gm-Message-State: AOAM530P/1w9MdA8XCwrg7eUSA8ixQk4JY+42fmuIjVlUf6oHzUzi0a1
        EU2FuSeea7aJWQ1pZDuZg4VTBA==
X-Google-Smtp-Source: ABdhPJymTL3iurFKWi/T094JBxjCqiBM5gpkauSBZKbRXjO2SLzDvbBHUNJj0HDnTl5XRp284KJ2Dw==
X-Received: by 2002:a05:620a:4101:: with SMTP id j1mr19737802qko.593.1638145245976;
        Sun, 28 Nov 2021 16:20:45 -0800 (PST)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id n74sm5681022qkn.83.2021.11.28.16.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 16:20:45 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] staging: r8188eu: DBG_88E_LEVEL removal
Date:   Mon, 29 Nov 2021 00:20:34 +0000
Message-Id: <20211129002041.865-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series converts all in-driver calls of the DBG_88E_LEVEL
macro to use netdev_dbg/dev_dbg as appropriate, and then removes the
DBG_88E_LEVEL macro completely. This is part of the ongoing effort to
cleanup and standardise debugging code in r8188eu.

Phillip Potter (7):
  staging: r8188eu: convert DBG_88E_LEVEL calls in core/rtw_mlme_ext.c
  staging: r8188eu: convert DBG_88E_LEVEL calls in core/rtw_pwrctrl.c
  staging: r8188eu: convert DBG_88E_LEVEL call in core/rtw_xmit.c
  staging: r8188eu: convert DBG_88E_LEVEL calls in core/rtw_ioctl_set.c
  staging: r8188eu: convert DBG_88E_LEVEL call in
    hal/rtl8188e_hal_init.c
  staging: r8188eu: convert DBG_88E_LEVEL calls in os_dep/ioctl_linux.c
  staging: r8188eu: remove DBG_88E_LEVEL macro from include/rtw_debug.h

 drivers/staging/r8188eu/core/rtw_ioctl_set.c  |  6 +--
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 46 +++++++++++--------
 drivers/staging/r8188eu/core/rtw_pwrctrl.c    | 13 ++++--
 drivers/staging/r8188eu/core/rtw_xmit.c       |  2 +-
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   |  2 +-
 drivers/staging/r8188eu/include/rtw_debug.h   |  6 ---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  4 +-
 7 files changed, 42 insertions(+), 37 deletions(-)

-- 
2.33.1

