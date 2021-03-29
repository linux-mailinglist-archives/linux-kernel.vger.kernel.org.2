Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9583D34C2F0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 07:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbhC2FQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 01:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhC2FQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 01:16:36 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38623C061574;
        Sun, 28 Mar 2021 22:16:36 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id q26so11384561qkm.6;
        Sun, 28 Mar 2021 22:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NR2OyKQ3yX1lvi5hZTGPQTahpwHjXRqeJIGMUY6nDOg=;
        b=sYoVPoYEYW199tzNqyF2wrXyGI4NMwinPUzaydeO9vITPMlLe8+D5aIA1YQMkmdjgY
         dofji/dfruqom+XKGvn7Y2ihpWoFWQKeN3Q6DudCGhUkoqFSUwA5QrCi++6rEco0x5Nh
         GCg9i9Iw+nzvuHeSlU9i6tyK/bFujw6ysRozSYp1Guk+sL/HkPmcA5MGRxxEN0rqLXif
         ApvCcmV02YbYN7nS43YXHb9kVAHBWlcisGwjaZ0DU03FVt8Ym8byWwd9W4Zv/s40rrsb
         Q90vEJn0d6cUAm++N/KkDijLRGpAHDIr9/ufqcHg6nxymQAab0qYmbj8FelCvxR9OxbD
         X9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NR2OyKQ3yX1lvi5hZTGPQTahpwHjXRqeJIGMUY6nDOg=;
        b=EEBDW9nNuXOFoDpccp1ThKK2vwUUEXOz7zp0eaDMx8fbLx6k5v0sfmqW9XLIm2SnOn
         0HGU63aTCcooFrfSsTbarodM+Y+IuE/oCp1llHiqeLKhsYbbGWogm+2OuvkZUpBRW3zm
         LhitKDpc/vCdH5Oq8n+30y7B5ZSenzOkPUe9OHNgpbCVf0pD06SHcEklSYYGrg0810fS
         YN/aw9BaytVZR3X/FM/45iGLYZZoF1gonjsD5IPefOcMJKtN2j32EIz5Bv1J8ESlmGTu
         +AKLQdIFIfWj/VlG26g7RREFny7sfUp+2guHZ3ucmvnYojtd53Dz7b2lxHF6FzTZqYE+
         H7JA==
X-Gm-Message-State: AOAM531knFhzPxIVOGvCakKQHX8SzqDCEpUc1gAqOFM6cEoUnui5iiSe
        9rD8DVYflg1r2/TcBE14Lt/LITFDzKFgpw==
X-Google-Smtp-Source: ABdhPJxs3ZUmh0KIfhBpeTsR3AksRAPUK3szLlOoiBkwJJUSTBSztAT03/Mi86Rjj9wZrN3bKJZoJw==
X-Received: by 2002:ae9:e118:: with SMTP id g24mr23863009qkm.212.1616994995482;
        Sun, 28 Mar 2021 22:16:35 -0700 (PDT)
Received: from localhost.localdomain ([156.146.37.195])
        by smtp.gmail.com with ESMTPSA id z124sm12993181qke.36.2021.03.28.22.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 22:16:34 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 20/23] scheduler: sched-bwc.rst: Fix a typo
Date:   Mon, 29 Mar 2021 10:42:56 +0530
Message-Id: <c8503ef8e1656660220e48ac2cf24be87e249d3a.1616992679.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616992679.git.unixbhaskar@gmail.com>
References: <cover.1616992679.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/simultanously/simultaneously/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/scheduler/sched-bwc.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/scheduler/sched-bwc.rst b/Documentation/scheduler/sched-bwc.rst
index 845eee659199..a7f9be925ab8 100644
--- a/Documentation/scheduler/sched-bwc.rst
+++ b/Documentation/scheduler/sched-bwc.rst
@@ -133,7 +133,7 @@ average usage, albeit over a longer time window than a single period.  This
 also limits the burst ability to no more than 1ms per cpu.  This provides
 better more predictable user experience for highly threaded applications with
 small quota limits on high core count machines. It also eliminates the
-propensity to throttle these applications while simultanously using less than
+propensity to throttle these applications while simultaneously using less than
 quota amounts of cpu. Another way to say this, is that by allowing the unused
 portion of a slice to remain valid across periods we have decreased the
 possibility of wastefully expiring quota on cpu-local silos that don't need a
--
2.26.3

