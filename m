Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D285C34C2E9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 07:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhC2FQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 01:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbhC2FQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 01:16:10 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7481AC061574;
        Sun, 28 Mar 2021 22:16:10 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id c4so11391987qkg.3;
        Sun, 28 Mar 2021 22:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JSkxpavW56Tv10FJKwdHyyIQv1l5EPU54pjbcomxTCY=;
        b=IGkYjXooWSe/I7pUun/JwdSlJKAiWX6Nsn26Gy9pcKjIImTCnNLc8zQH5AJYOvzH7h
         2zZea88iHoR0FBY7eVKTYKINPs4A8yd2eSuhusUK0jj2D8JOF6Pmnci3sEW3oYEORSP0
         tym3cxGdvwMRvkhn6D3x5wjDp9Io2MYlRynjKnLP5r/k3xV5Rz1tksGSSpeIb6R6osr1
         nqkz6oon+367hdAoHV6lg7hNtgLYaT/qBCr+qE86St5mkZnAIQFt9cbEx7VIu3hcg8wV
         3y61VVD7BgYmawBi+ORGnsTE6M2bvH3f814dTzjtQDY7jY5xFWkDojVgD2gZ872Pa/x4
         Lfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JSkxpavW56Tv10FJKwdHyyIQv1l5EPU54pjbcomxTCY=;
        b=OXC9i7XiCbfmsIpSLKA9PEnSM7ZQWs1zfg6zbJtUfrZDRazGW2EEPMvStqJJvOO9rg
         dnGya9JosR0zwgdKlCWx6+szK/f7MIVCQ7uDYte8l4n5SLblOWkYsy2toT6j+VRiho0s
         1VoSaRiMTi99JZFuxIubXA4wyECfh0vnZ0Epra0xqzIl1d8kLNt+pD5ptT3uqG/qZEma
         /v2lrqBkH7nDcsJIZFkns95fCeG59pvcUDNZuNaQsUi3KhVdMPhzCUDmr1ppzCNbg091
         PZNNFYQAd3I8QBgIjlb8DNLUY+IOLR0+7SqKWNhnUXAJDWpYB9Nx1JA7GIOpysimyF4g
         Jlhw==
X-Gm-Message-State: AOAM5305MY3MlsqK2Dmjh9qowahSt4ERCehaltbhFkOZHdM8+nzssTz2
        5pL8Eb5WXDcKK3rscHtes3w=
X-Google-Smtp-Source: ABdhPJyxOBeq/ZddQVp9saDk/JONslrhxwittKF9nu+WLd5QcHt4fUdHy/yNzcHzUzpLbgpt57WurA==
X-Received: by 2002:a37:9b07:: with SMTP id d7mr23357955qke.130.1616994969770;
        Sun, 28 Mar 2021 22:16:09 -0700 (PDT)
Received: from localhost.localdomain ([156.146.37.195])
        by smtp.gmail.com with ESMTPSA id z124sm12993181qke.36.2021.03.28.22.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 22:16:09 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/23] trace: hwlat_detector.rst: Fix a typo
Date:   Mon, 29 Mar 2021 10:42:49 +0530
Message-Id: <3d7ca39a6be678852b448f5930fd538276cbb487.1616992679.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616992679.git.unixbhaskar@gmail.com>
References: <cover.1616992679.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/occuring/occurring/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/trace/hwlat_detector.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/hwlat_detector.rst b/Documentation/trace/hwlat_detector.rst
index 5739349649c8..f7811e2ddf34 100644
--- a/Documentation/trace/hwlat_detector.rst
+++ b/Documentation/trace/hwlat_detector.rst
@@ -14,7 +14,7 @@ originally written for use by the "RT" patch since the Real Time
 kernel is highly latency sensitive.

 SMIs are not serviced by the Linux kernel, which means that it does not
-even know that they are occuring. SMIs are instead set up by BIOS code
+even know that they are occurring. SMIs are instead set up by BIOS code
 and are serviced by BIOS code, usually for "critical" events such as
 management of thermal sensors and fans. Sometimes though, SMIs are used for
 other tasks and those tasks can spend an inordinate amount of time in the
--
2.26.3

