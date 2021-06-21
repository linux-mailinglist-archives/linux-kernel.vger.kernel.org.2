Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4023AE1B4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 04:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhFUCnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 22:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhFUCnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 22:43:00 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238DFC061574
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 19:40:46 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id g4so9079530pjk.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 19:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=R+zDclVd6+MF8AmpSfvARcxTjI1VRTEmoNc6MqmkAtI=;
        b=W05GGJevbvZz2bk+fG2OykdTR9XPa6Xt3uNIHizgG9jFYTgEFj8LvXG3706Dy2AbN2
         YzV4EmQAvUdJjOPzk4GtjSXexpFmUzEuVfVISdS1RvDCte+Sm/yE7DAlVs//eIG7f6sv
         ebRPL2naD9gEuxMiqC6LHzcrHxj+plrXPtW33jYj4YsCQrLAWUjuly2DOSdjrBRSM8sy
         rw0WqvVer1Tk45DYAJun3gJsfE3YENnoGQnnMkGRztgH9U2YcZYM5HabVYFlBjW0HF43
         GN3ek5aMTTCwKTQc8+zDHnKt+/MntIIPkSt1BN9LnzZ8sxAucOf826+QzBVZVT7LuumP
         nNfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=R+zDclVd6+MF8AmpSfvARcxTjI1VRTEmoNc6MqmkAtI=;
        b=YuZKGkWXeTI/rDJLEpmxsHYBP4iO51QT3md93y5UxsujX4Vu+Twp1tErI/C6y2mE3v
         6E0+XGHNYZAkjiWh4FBItEvnN3U4cwEc7rbgc9OqYy1X7maYAcScY10deVFdPm+5uYCu
         98jTVaAFy8nlciN1f4MFI/xX0PbwJDCeGINbGDEowEXzpbBU+zuhkMOmKxv7f2dprPrr
         Puiy4IT6mRiRR/6wj4RXkBMYMt04Ss1HbCc8AeqCdCAOoiMLclm5/0hADorZRmyGZmQ+
         QEOzuqPgbRaNXNgBE1ctn1n0HLT+xN8XN5oJA4+N86fRTtqvPY46KAC+I41q4NC7WdVX
         JsQQ==
X-Gm-Message-State: AOAM530nL4JfxB+fqY87TGpNnJAGCSDLgUb/CDrNRAhgGI/m3EFRLhCl
        6JDurfzcYBOqGRVMzx6fJliDpfr+9ECtPw==
X-Google-Smtp-Source: ABdhPJyN2QefH8b0axptOESAvaGCW6oXAhlyrqN7RwA0MWTE2OlbTc+uHSDnO3qs2mVRwg20anAimQ==
X-Received: by 2002:a17:90a:4592:: with SMTP id v18mr24436412pjg.132.1624243245636;
        Sun, 20 Jun 2021 19:40:45 -0700 (PDT)
Received: from localhost ([209.9.72.215])
        by smtp.gmail.com with ESMTPSA id y1sm2080153pgr.70.2021.06.20.19.40.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jun 2021 19:40:45 -0700 (PDT)
From:   gumingtao <gumingtao1225@gmail.com>
X-Google-Original-From: gumingtao <gumingtao@xiaomi.com>
To:     cl@linux.com
Cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz, nathan@kernel.org,
        ndesaulniers@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        gumingtao <gumingtao@xiaomi.com>
Subject: [PATCH v2] slab: Use %s instead of function name
Date:   Mon, 21 Jun 2021 10:40:39 +0800
Message-Id: <cover.1624240708.git.gumingtao@xiaomi.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2
 - use %s replace function name for the panic() call
 - use %s replace function name:kmem_cache_destroy

gumingtao (1):
  slab: Use %s instead of function name

 mm/slab_common.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.7.4

