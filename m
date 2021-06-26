Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D833B4C39
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 05:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhFZDmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 23:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhFZDmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 23:42:43 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20382C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 20:40:22 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id r14-20020a4ad4ce0000b029024b4146e2f5so3062207oos.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 20:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aZRQ+Z7ZKg3Guf0a3/0wt5Veyx0fWzKR+rnTvGqfncA=;
        b=Tb+j/gyzLJMan4q6fO+RiI8OVVWYgKMem29kcVqFyIhPLD97nqgrtVEplnNp2MT0xD
         f2yaqnA3zGo6l0eRbzZfDqA2wDRI/7zpJKhErQUGMHvCipJ2JMvlmz8h0GYm4WXsDZzg
         3gzRby5rTU/kkjs4ANitfLm98WFJm8VHro2U88QmfXq6ACTtHgxwOFlNL/JO0RvsG3Hc
         ucwNfgt8rnHbMOqE1K/U0Bhtq98ucBWNRlb8lZzdtVJdbsxMpeVV07Gv1tLLOAJtKc3J
         LGC60ihBhuqsucn92wB0ocgMfdMXYlhMMRPiDYSp+GrRXtlAN8dFHCqy5yAW4tyS3KIT
         2n6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aZRQ+Z7ZKg3Guf0a3/0wt5Veyx0fWzKR+rnTvGqfncA=;
        b=PCo1uASQB0K19i4AGin5ImUkz1Jki4PSJpJoMnoUVUAtEd677b4RhhID7soGn1A4sv
         Hl/35VPtAKuydFzZ9ZQHg3o/erDW92KH+QLy/CK86louzoO1zLgFh7WvrDwjY5VX8bWP
         WlzMSEn8H85g/f1iUib6tOOyoTkMbiU9AVoizRASeviZqRJWGxI650XbEO25QHusRWx4
         5L+BDwV21gzqbWZw1Fit9lZIH9kYNLsElIN/9vkF/qhxQ1X86vcVz4eohivy+B3A52Kz
         u0gEmEJor2Ho0Eu32GHknH9sNaelFIaajDTTTC+yAmllPpP9GWoTYF0KdYAwSbPYOup/
         J/Vg==
X-Gm-Message-State: AOAM531zt6qTZ90JrdLvGa4HI/qKW5MfQSbE9e7+ZAOZiVOVFPwLHJ88
        UsFQU8FGpza+OCa2FwIb4Vs=
X-Google-Smtp-Source: ABdhPJwFVyPjJpNNmeM59p9XE3mrOCUfWZGKM6vn22TmTifDwhzAkFGKx/OeCssKHExsglmC+pKlCw==
X-Received: by 2002:a4a:9c8a:: with SMTP id z10mr11724753ooj.56.1624678820756;
        Fri, 25 Jun 2021 20:40:20 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id k26sm1174817ook.0.2021.06.25.20.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 20:40:20 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     joe@perches.com, linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 0/3] checkpatch tweaks
Date:   Fri, 25 Jun 2021 21:40:13 -0600
Message-Id: <20210626034016.170306-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

here are 3 minor tweaks to checkpatch
- skip reporting of a SPACING test, based on filename exclusion.
  *.lds.h are linker scripts, some rules don't apply
- exclude extern-C warning for symbol patterns common to vmlinux.lds.h
  (_start|_stop|_end) currently, pls tweak as fitting.
- subdue warning on BUG_ON if BUG_ON is mentioned in commit log

Jim Cromie (3):
  checkpatch: skip spacing tests on linker scripts
  checkpatch: tweak extern in C warning
  checkpatch: suppress BUG_ON warn when it is named in commitmsg

 scripts/checkpatch.pl | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

-- 
2.31.1

