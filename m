Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B76F3A4CED
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 06:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhFLEzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 00:55:49 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:45773 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhFLEzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 00:55:48 -0400
Received: by mail-pf1-f178.google.com with SMTP id d16so6080894pfn.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 21:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CSf/plSIB/2hiYtwZfEusso9z7qFI1Lu/J4EiHpSzN4=;
        b=tqNr2p4XQ5wB5Z4ZjSL9bOu5p1wM8owR6C64aw9Yz7Q3kn7kk/E+fUNDqPFPJW9cBf
         mBSFVuRwA8aIP5vSMENzs6Ip8b+XgetGZrMMF74lPjzVLRSoH1s9XAsvjDSnG6fFELKn
         JmVKdvEIVCeotAKvpPTWKB2+/NTB6a74GWRiZbkUFTdKWfDwhJc+/79U8y2VkFELjMWa
         q1qtAm4YIKR6+rsDLMfyizsWtcRtRhfT1V8czOGj2cJKVBxobpw/CPI2VgV8uD5SwGLZ
         hI8iFFyLnMcWzmUuxDQufaHbQLQlFhKpxIPyPKq9joOf6ZG5lu/hjMwD2zBPSmKsGtCT
         UJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CSf/plSIB/2hiYtwZfEusso9z7qFI1Lu/J4EiHpSzN4=;
        b=KEUOc3gM6S1GPSABaDX7Ne4Kllms5Anqvd/BNy57p1GVu7sVbnsN82gojt2KaGOypp
         27Qkn3rmyXEzIp9WrIX0ZKOIgoMsxqfeaSB36k/u+f68YTT5CMdVdizANLMKDyoFHfDi
         ip2cn7e2M+Qd10GnJ+BWYqgqCfGRnE45M0riR/0yBmYRyKtwiB8ukXLZSonFzyA/3vPa
         uMaWS0aPk2qvK2J8fP3Zi1yfL6R0ddIlY2Pw2hikOjzxD8+7w+1TNFV3axROAA2IiEvh
         SXPRhqttpjhhfKPlgOlQxUNTePaJPqR8pbdjhEywxKCxTyG1RGVwe7mxl8Ppp95xsePI
         Km8g==
X-Gm-Message-State: AOAM5315FADBFiWPr047UwOv2J2Pte6kCxFJrx+7s0jb0C/t5323/DMf
        3jARR9lHhCv3j5fzENsjX/g=
X-Google-Smtp-Source: ABdhPJxM1VF1pnq9bbCHEuQNtN5CuUaS7/ptizl2HW1db0WbqmWKJmXMyoAw5uohIC6g9SxJTyBo3Q==
X-Received: by 2002:aa7:96e3:0:b029:2ec:e8a1:3d66 with SMTP id i3-20020aa796e30000b02902ece8a13d66mr11484855pfq.79.1623473556125;
        Fri, 11 Jun 2021 21:52:36 -0700 (PDT)
Received: from lee-virtual-machine.localdomain (61-230-42-225.dynamic-ip.hinet.net. [61.230.42.225])
        by smtp.gmail.com with ESMTPSA id m1sm6076572pgd.78.2021.06.11.21.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 21:52:35 -0700 (PDT)
From:   Kuan-Ying Lee <kylee0686026@gmail.com>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Kuan-Ying Lee <kylee0686026@gmail.com>
Subject: [PATCH v2 0/3] kasan: add memory corruption identification for hw tag-based kasan
Date:   Sat, 12 Jun 2021 12:51:53 +0800
Message-Id: <20210612045156.44763-1-kylee0686026@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add memory corruption identification for hardware tag-based KASAN mode.

Changes since v2:
 - Thanks for Marco's Suggestion
 - Rename the CONFIG_KASAN_SW_TAGS_IDENTIFY
 - Integrate tag-based kasan common part
 - Rebase to latest linux-next

Kuan-Ying Lee (3):
  kasan: rename CONFIG_KASAN_SW_TAGS_IDENTIFY to
    CONFIG_KASAN_TAGS_IDENTIFY
  kasan: integrate the common part of two KASAN tag-based modes
  kasan: add memory corruption identification support for hardware
    tag-based mode

 lib/Kconfig.kasan         |  4 +--
 mm/kasan/Makefile         |  4 +--
 mm/kasan/hw_tags.c        | 22 ---------------
 mm/kasan/kasan.h          |  4 +--
 mm/kasan/report_hw_tags.c |  6 +---
 mm/kasan/report_sw_tags.c | 46 +------------------------------
 mm/kasan/report_tags.h    | 56 +++++++++++++++++++++++++++++++++++++
 mm/kasan/sw_tags.c        | 41 ---------------------------
 mm/kasan/tags.c           | 58 +++++++++++++++++++++++++++++++++++++++
 9 files changed, 122 insertions(+), 119 deletions(-)
 create mode 100644 mm/kasan/report_tags.h
 create mode 100644 mm/kasan/tags.c

-- 
2.25.1

