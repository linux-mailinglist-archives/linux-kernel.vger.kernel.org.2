Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDBC1320529
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 13:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhBTMC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 07:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhBTMC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 07:02:57 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EFFC061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 04:02:16 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id e9so5815500pjj.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 04:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PYn75oOTsCK1wv+wG6RJjEvw1yuvJVUno/JpN+AI5ys=;
        b=OI4MHEvQ/wRgHvcO2KzDnyInh0WB1yDezlJN10IBMm9fnata2or1Xv4bqd6JAg15h0
         68psk5RI8qSNFNuCkb5hnOKPoQz0l73QfZEDy1XfjI8xfaFiVI7bO6hHGQgXvV0hi6A0
         bnatR5EuH8N95/qQQP7/t6GuGId+vm93r7qVWhO9wnVskJ3PN2us5DQRwoaJRL4TM/2u
         6+QDJss+qSr+0Lb6emHTwB4hooNKoKCvshQ3i0o5pnEgTvIbH1749nhDEpi4Zbp+In0h
         0LXLPacJEyjADei5Ii+zn+mlGN8EbF+PszFcw7bfZgAGSleGqbd7IOzRrOlAy9XWHBv3
         O1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PYn75oOTsCK1wv+wG6RJjEvw1yuvJVUno/JpN+AI5ys=;
        b=XoZZRXG2UBj///vPNw7JWJXQbcqVRmnBFI+mpVxKq0Kb2nOLv5VrFfGJoDO5jK/RL8
         7x7VCOPdsEf1MRgU0CH0hSBei3sl95EMRwhYf5V0D2Ixr9A1EmD7FRd01Pct4ZZ2zd5A
         yfwpWgqdeGJJo4QL+2LXNUchwrd2vJyRH/AW/jkZs8S43ELdwa2W02FgdHaEvQUyhFpF
         sHQZct/X3KRcFEsi9EUgi1QZLCVnsvH/xg7U+zp/hGt1JbBU0SSdX2hFJXv/+5swZYlA
         iR/Qjv3G3FWsfW3rRgB0RH+2ii7PI6ZASUMbhZJmLBbDXBDzpm1dADnkJVtt+8/tZqM8
         UGNQ==
X-Gm-Message-State: AOAM531kKvN3UBTnozQPLuHfw8BZi31dVkk+K/MyWM4J725gu/aap5Gl
        l0IfY1iV4BYF096HOksOo9XoJAiYQu/ixA==
X-Google-Smtp-Source: ABdhPJw8Ulbtwws1WMMTR78vSG9oRFTWz5Ft7TjAAkbmFL4NTAgGjmgHHU90xqXMQ8/8G/Ivg8/+Rg==
X-Received: by 2002:a17:90b:ec5:: with SMTP id gz5mr13909019pjb.34.1613822536222;
        Sat, 20 Feb 2021 04:02:16 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:6b3c:bf56:7f84:6ce5:cf93])
        by smtp.gmail.com with ESMTPSA id ml7sm6567046pjb.28.2021.02.20.04.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 04:02:15 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: [PATCH v5 0/2] checkpatch: add verbose mode
Date:   Sat, 20 Feb 2021 17:32:18 +0530
Message-Id: <20210220120220.32585-1-dwaipayanray1@gmail.com>
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

Changes in v5:
- Change the reference format to use absolute links.
- Print verbose descriptions only for the first time
  a message type is encountered.

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

 Documentation/dev-tools/checkpatch.rst | 526 +++++++++++++++++++++++++
 Documentation/dev-tools/index.rst      |   1 +
 scripts/checkpatch.pl                  |  63 ++-
 3 files changed, 587 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/dev-tools/checkpatch.rst

-- 
2.30.0

