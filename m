Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45BB1402AC1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 16:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238085AbhIGO35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 10:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235545AbhIGO34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 10:29:56 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977E8C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 07:28:49 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id n2so10415368lfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 07:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=75RjxCfLjQSwmyhXcT0XtNjKX6pdVwXCyGclbHCUCpQ=;
        b=L/5MU7CfkLPnsnEReBQpY0KGqg07whucLQ2iYYbnZNCMZMjtzvDI2RBgb+/EYTpHl/
         0/wDWw44RncgeG8KrI+sFPq3TwkNgNJ968aKBoi9i2BxAJoZRmQafI7zU2SRalDQH+kb
         eof3wUnk5ZsJdGlLVFPMpqtqdeijEmx/muk6c6BUzA7/gqJGqL4NkGrTWuzEwHjb6cRl
         FDZ7Q6TVQpM84ap810C9B/utGA2LX66weKdhi8ZRbn0c//OhNvFJ1RdsZXPQ8NBkTPlA
         aDvpDBVOCaLpxSJNS4qFDgaSeZOagg4DsHshStOMvkdUz2s2CyYSY+HrE4dS6SXzc0ta
         pUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=75RjxCfLjQSwmyhXcT0XtNjKX6pdVwXCyGclbHCUCpQ=;
        b=i8/GaE6d6GKbAYzCUseEwSiQNpayCawOXnYPizudh4qjEv9AT04retm8e6WSEwWZQY
         h0d0Vb2lHxmNw1cil2s9dgjalZq/n3Gd9SWdInLkZuhz0SzlKUd7nXl1NGydXfsKT3OG
         HD02ngGWNcpYK3NUtgw4EHeftOluUYc+bOFyHM3A88/snallWcalBJy3MAA7TpcTyvMG
         st0HjeEDpBJ6U7puIqvi3TBCWG+VHZtWO0KMaXuLLadvlC//1qxIu6CFG2yJW9pudB95
         dm1CeSU8eV77RpV86YZC4ZZI6bXf1+RqdZ5NNLSzGFlrXBucwO82T2rVVwJVa93zgbJQ
         AXoA==
X-Gm-Message-State: AOAM53067gnh9lmkY7+Rtw3VyB6RbGSayJ2SHmGz0/8M5wL1xQhySk49
        DdgBJ8iIg05zm+zvSnaRUw4=
X-Google-Smtp-Source: ABdhPJyG8xBIROa64/VLmk5PgHtuVkqEq6vH2E0Jg9TtS8C0yerJDqL7XRAaK9CQ/XwlNUFqF4K+jg==
X-Received: by 2002:ac2:41c2:: with SMTP id d2mr6629172lfi.395.1631024927911;
        Tue, 07 Sep 2021 07:28:47 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy ([31.132.12.44])
        by smtp.gmail.com with ESMTPSA id l11sm1014251lfg.39.2021.09.07.07.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 07:28:47 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Fix error path and use kernel macros for min/max/calmp
Date:   Tue,  7 Sep 2021 17:28:38 +0300
Message-Id: <20210907142842.133181-1-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First fix some error path fault which I found during when I did this.
It should go to 5.15.

For better code readability we can use kernel defined macros. Patch
2/4 also removes some dead code so that it would be more clear why
do we do what we do in patch 3/4.

Series is tested with xfs-tests. No recression in my tests.

Kari Argillander (4):
  fs/ntfs3: Fix ntfs_look_for_free_space() does only report -ENOSPC
  fs/ntfs3: Remove always false condition check
  fs/ntfs3: Use clamp/max macros instead of comparisons
  fs/ntfs3: Use min/max macros instated of ternary operators

 fs/ntfs3/attrib.c |  3 ++-
 fs/ntfs3/bitmap.c | 11 ++++----
 fs/ntfs3/fsntfs.c | 68 +++++++++++++++++++++++------------------------
 3 files changed, 41 insertions(+), 41 deletions(-)


base-commit: 2e3a51b59ea26544303e168de8a0479915f09aa3
-- 
2.25.1

