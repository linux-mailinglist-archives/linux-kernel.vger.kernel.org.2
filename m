Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991ED3DA034
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 11:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbhG2J2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 05:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbhG2J2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 05:28:05 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B06C061757
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 02:28:02 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id e21so6269467pla.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 02:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QMGPgCOvVbNELCqiHunNhI97RObJqZDzymnqU8gz9iY=;
        b=Bgf574kfzcObcONFeVBZweqQH0rjcq0br/kFMLYz10kOrAHlrNEyzdZIQec0i9OXGe
         CdQej9leC7S1cQhEu5zR0Ez/xXULeyOpl/oVsDNi3qJxBWWotW4Lmc3dmx/WuVSKgzXC
         5cpVfLlBGXQN0IdhhBHNPSY/hokagRmkk/XyMSjU7J8Fvp0qmvMfjLqs3CZzYKL+J0cZ
         yEbGVrbMHm9Aks2b3ILI2n68F1CbLVgEweB9j4kdgrMZW86KzU24PJCd5DWwhjJhuKyA
         F7UjvEvUodBJuiMIsj/fSzN0am3cWhjzluVGr2v+mwT+22eh203+WLH+pVmbUujfSiM2
         wLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QMGPgCOvVbNELCqiHunNhI97RObJqZDzymnqU8gz9iY=;
        b=OAJpJgQwtmPulbfykU5obKlvNm0eOvaAmTPZzbu+iTA//QbBDtCTDhwDNc5I/0IbmY
         0SLz6S4hxG1hKeGd0sAtWqHs5xM3cRpC9sw5or1xt8mKyJSZHducgtsTtyDPfDi+GUq6
         bkMGJ1gy+BJSopUCMByUZLmMQvcQFlVyp3TEdIyYJwAS/yNXkhi1MxHJyhmjwSg+iVff
         lgfpNHtkK6CvxSaeT4ogReNcOjH/+D5N6aYEf7ey1VUJ3bwN/AUfwrbAPfnI/c2YTXHq
         03SiJifeJN8yCWY5WbrKb/z4m9bnIgPOJHtfjmWn+UJyvb4VPulGJrQRwn+ma19U5Ggw
         PD1A==
X-Gm-Message-State: AOAM5334n6wBww3hPBAgIsHBZk0xQe63k79SBphKMKDdNFX0b68eN2+/
        ZnXSggZjzbxs+8wzX60ECYN5kg==
X-Google-Smtp-Source: ABdhPJwNcUw8x0iy+iAapcWhZmK4L74JhWxiAZ5cCa0hv3HhJReP4qHlDLfpRERmZNX9RceYGmKaZA==
X-Received: by 2002:aa7:9ac9:0:b029:377:8e8d:910e with SMTP id x9-20020aa79ac90000b02903778e8d910emr4116935pfp.28.1627550882205;
        Thu, 29 Jul 2021 02:28:02 -0700 (PDT)
Received: from C02FT5A6MD6R.tiktokd.org ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id 78sm2971334pfw.189.2021.07.29.02.27.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Jul 2021 02:28:01 -0700 (PDT)
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, akpm@linux-foundation.org, vbabka@suse.cz,
        axelrasmussen@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Gang Li <ligang.bdlg@bytedance.com>
Subject: [PATCH 0/3] mmap: mmap_lock: some improvments
Date:   Thu, 29 Jul 2021 17:27:56 +0800
Message-Id: <20210729092756.38032-1-ligang.bdlg@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series make some improvments for mmap_lock.
Please review!

Gang Li (3):
  mm: mmap_lock: remove redundant "\n" in TP_printk
  mm: mmap_lock: use DECLARE_EVENT_CLASS and DEFINE_EVENT_FN
  mm: mmap_lock: add ip to mmap_lock tracepoints

 include/trace/events/mmap_lock.h | 65 +++++++++++++-------------------
 mm/mmap_lock.c                   |  6 +--
 2 files changed, 29 insertions(+), 42 deletions(-)

-- 
2.20.1

