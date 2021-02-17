Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4634031DDB7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 17:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbhBQQzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 11:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbhBQQzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 11:55:09 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A32C061756
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 08:54:29 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id g20so7724932plo.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 08:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bweBA//jaU5FvEQj4YLm3O5Xa+iWylyOBiGh4/hwgr8=;
        b=NXBCPz8P6qSWS/xS1gARF8RsLiLWsDgj+mFlx77DiGrvHHT8TvGDEWiFZkSmfB1wDE
         NnV6ker/7+k1wowVIY6zc+FW9LWcoJTyGErDhJh6vyA9vtQ+RgFUmPGQ4d5DuWcOe+CA
         VG12qrQhbc7a3nkiOPYajkd9ud8rGyoFDXMDYM/VS+HR5PFZAU6PyFE7hXqjvZsvR3IC
         LP8/Ghy9+xacq8T7X9Sz5EvbH6OzL2WtIrZFdkQmEX3BwDgzX5NUv8WLdRt2HI8TxI/I
         O9c5Or+KgZWqQyGW76r7QbRMP12KK8Wd+xauBPeGQ4DuCvJ/g/bjQcimRcKeVqbNGkeg
         +DhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bweBA//jaU5FvEQj4YLm3O5Xa+iWylyOBiGh4/hwgr8=;
        b=owTCUjozyU6FYZz9BhtbQZN8NtxX+uyKd9dmEnhvrkIKNgKIM1i3iVDRHgLuCHkrxO
         gvhhOHQ9/KI57bXJCqbKH4/ewp1czujblJXyE41dq1/TrdpPR2SFqkTAybt0NjYK3TkH
         /s1ePC+ZlNb2ZAEnKJf+xrl8JLEe8g8peoAgzUgkdKmZE6m/q1ViquG5RiGZkrIxdgT5
         Y+atYT2orItHc6mGGdHxlleKBpwOD6C6W37eQiKOSA5XAgjXUxKZb6IpzVp9yNKFikcd
         1/jPTRky12pduKgHwAtJ8ZQSBrSY6AcH/CXdfgOQtYzjwj1/HpEzc4Ts9jtt7JhhLe1S
         XCtA==
X-Gm-Message-State: AOAM532na9mJLqveRR0MpXcF0Eutw0CmfiwcrFAJ2TVEYgfP8Z67TS+Q
        SCptrOP19M7MK15YsbXp2Ew=
X-Google-Smtp-Source: ABdhPJw9/luIxIYytOSebjA9zZpEP+SGuAjxOeSgZrYX09NrPfLFvwK/rJlb+9dJ4tQg+KDchceI1A==
X-Received: by 2002:a17:90a:e7cd:: with SMTP id kb13mr9901806pjb.10.1613580868549;
        Wed, 17 Feb 2021 08:54:28 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:69b4:3f63:7c5a:6972:6781])
        by smtp.gmail.com with ESMTPSA id t21sm3063897pfe.174.2021.02.17.08.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 08:54:28 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: [PATCH v4 0/2] checkpatch: add verbose mode
Date:   Wed, 17 Feb 2021 22:24:32 +0530
Message-Id: <20210217165434.69298-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new verbose mode to checkpatch. The verbose test
descriptions are read from the checkpatch documentation
file at `Documentation/dev-tools/checkpatch.rst`.

The verbose mode is optional and can be enabled by the
flag -v or --verbose.

The documentation file is only parsed by checkpatch.pl
if the verbose mode is enabled. The verbose mode can
not be used together with the --terse option.

Changes in v4:
- Change the type description format
- Group the message types by usage
- Make handling of --terse with --verbose simpler

Changes in v3:
- Simplify documentation file parsing in checkpatch
- Document a total of 33 message types for checkpatch

Changes in v2:
- Use .rst Field Lists to specify the type descriptions.
- Add a few more type descriptions to documentation.

Dwaipayan Ray (2):
  checkpatch: add verbose mode
  docs: add documentation for checkpatch

 Documentation/dev-tools/checkpatch.rst | 525 +++++++++++++++++++++++++
 Documentation/dev-tools/index.rst      |   1 +
 scripts/checkpatch.pl                  |  61 ++-
 3 files changed, 584 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/dev-tools/checkpatch.rst

-- 
2.30.0

