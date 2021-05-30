Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3942D394F9A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 06:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhE3Esv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 00:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhE3Esu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 00:48:50 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAB4C061574
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 21:47:11 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id z4so3545848plg.8
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 21:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BcaEFmIjiTlfRXL6Zs6sX7KheP8a63KO4TggeivHn2w=;
        b=SzdHbLf3t92+Lzkwyopv67+VBSubjR1gwJBPtUB1c3Fw+bHbTcAgL5lgRZxpsHhXL2
         3CXA0ubZ33jG00qBeqpJqZbx51qz+J6XWnP0H4/k0a9FUTryEP7IRpVNUa1HoVeo25sY
         Xse3Kn+uMqGmOEMUXlQvF0LGZtL33fD8XQUGJpO0GmPF3RY4uTn6ems0ZFCKn6OQrwse
         DD63FHrQCEWSIltPJ1gw0edCT7zDUcN22ZrflxqTU8gdxHAo2sISmECv4RAnz/Stgl6p
         3cJ7rosmGzmox12DGwHuzG+oKwJYk+I+U06TOBBZ1uSOx3bTTTTYemUcQ6qM9U8PifKO
         vk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BcaEFmIjiTlfRXL6Zs6sX7KheP8a63KO4TggeivHn2w=;
        b=uL2Mn2rSOs2PvXfhOjecKJ9lTqjOtPKN3QFVMWsAqEgbUlX17MrgSYmjkyfOY/Rw5j
         5NMPwyoHfKj71hePhBmn6r3qfAaaEOZtTeEF1LTt+5LH8se+mlbgGIF0xzXzz//j22uj
         6YMLGyeZk8MHygnCxgphStp+q/5z2Op14669rOXi6zqSymUQHcbA5nSE0ZxrNA31C0LP
         q82zR4PYgG1okLFk2ZMv09LKJlNnlFxdenVdG2glrQ0eMZMTfMbEFL2kA+kvKZVEzfEk
         ZYymU3l8e+sp+MTN2eNoxznj1Y6QMu5/gcsMMsXA0qzNJnal6IUrQykt3kNuHL/10+2H
         28ig==
X-Gm-Message-State: AOAM531oU/F5TqPnk3f3NpiL2iP5zFj5FzbR3kKjmKErQTK//ZlKHG8z
        /NkCJiwczeh+4LBrIEml3jM=
X-Google-Smtp-Source: ABdhPJyFBYUwpV113mllzH1jJ184PbqLIO2OC+RGxCvuVJpltzGYofzQqtHXOK8gCOgQjMDmFs7Vzg==
X-Received: by 2002:a17:90a:e7c8:: with SMTP id kb8mr12092421pjb.60.1622350031432;
        Sat, 29 May 2021 21:47:11 -0700 (PDT)
Received: from localhost.localdomain (61-230-18-203.dynamic-ip.hinet.net. [61.230.18.203])
        by smtp.gmail.com with ESMTPSA id t1sm7471108pjo.33.2021.05.29.21.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 21:47:11 -0700 (PDT)
From:   Kuan-Ying Lee <kylee0686026@gmail.com>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Walter Wu <walter-zh.wu@mediatek.com>,
        Kuan-Ying Lee <kylee0686026@gmail.com>
Subject: [PATCH 0/1] kasan: add memory corruption identification for hardware tag-based
Date:   Sun, 30 May 2021 12:47:07 +0800
Message-Id: <20210530044708.7155-1-kylee0686026@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is for hardware tag-based kasan to make a good guess
on the kasan bug. Report kasan bug is slab out-of-bound or
use-after-free. Refer to software tag-based kasan detection
mechanism.

Kuan-Ying Lee (1):
  kasan: add memory corruption identification for hardware tag-based
    mode

 lib/Kconfig.kasan         |  8 ++++++++
 mm/kasan/hw_tags.c        | 25 ++++++++++++++++++++++---
 mm/kasan/kasan.h          |  4 ++--
 mm/kasan/report_hw_tags.c | 28 ++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+), 5 deletions(-)

-- 
2.17.1

