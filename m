Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CE8320A25
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 13:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhBUL6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 06:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhBUL6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 06:58:39 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC09C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 03:57:58 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id a24so5878103plm.11
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 03:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PuTW0NO8el9VftnBi7d1E863EASjdSSJ/VHcBqzraRk=;
        b=ifgjMjriBGhWNkwI70jM7BEA8mKVNwjvolh720mk9gkYK9Pry2OQxlbUQej+U6FCGd
         Ayi3c0LWnxZU8fmgzEeEwoTDK2amBuB+ydWVvrC6kfSEz0zirAHdFPaO4GP/bks/3wgM
         PCD4sVI/B70XLuHMJp6CojQLAcvONx3cjRNdzki7jBJr5clFENs6H6MIcOCE0Cw1wsZM
         ZgEmBpwQ3SlfZTibAEVy5dWyGf7UbGk/DrCvWqAMakHvP+X6TLGCfpBw947ChEsuZay6
         Ly5SWiJjX1plOAOn53KQMQ11lgOuzeWVCc28slpgmAzIxZzJ9D1Bn3VCC4codXHPtuiI
         FKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PuTW0NO8el9VftnBi7d1E863EASjdSSJ/VHcBqzraRk=;
        b=SZtVkV6DZ4AI2HEDntstTh1kRSX1aR6y5iDxM79MkJhI8PzkNI5vv90DmlKJASLIsT
         JTlFqIaQ7wyGyJba6XIC+ek03i0eQkORoUmSZNUd2qduWVC/kseJFuIyNZ4GAZ9Bo+pm
         OKGyIRjjEY1+733owjHdGPGGfGql1wptXC+ZypPOE4zhzZG3fygqgWO7Oo/fxGAXyduy
         JvsKYBhuZrGSiiUiD7T/QBxOklrVf5SF+qaTW4bG+aOIdAthnSplaCWFOV4i3JsV1Ihl
         Ahbxj/W2ug/r4pe2JH2nEadSTyC+SneoQqf8lelSWUlwjdM8h0H8PqRPUxWU2reP+V1Z
         00wA==
X-Gm-Message-State: AOAM532tKRB8OL5OXRPUL5ODzm3M/Cvfc5N15t11CG8RJhmuIeJQ6GuB
        kF35GaKbnt7mbx2Iz+1+GFD79qhICwTa+/kV
X-Google-Smtp-Source: ABdhPJykIeFlEGm/sq5p7mYj4xIHPcrhKnS/hfWZK7Ap/CtJ67E+DYJA1l7ROHSy2eDW68FQgIZMkQ==
X-Received: by 2002:a17:90a:af93:: with SMTP id w19mr18543481pjq.46.1613908678244;
        Sun, 21 Feb 2021 03:57:58 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:6950:6d00:817e:a84c:30d2])
        by smtp.gmail.com with ESMTPSA id r5sm15694563pfh.13.2021.02.21.03.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 03:57:57 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: [PATCH v6 0/2] checkpatch: add verbose mode
Date:   Sun, 21 Feb 2021 17:28:00 +0530
Message-Id: <20210221115802.19788-1-dwaipayanray1@gmail.com>
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

Changes in v6:
- Allow using verbose mode with --list-types option

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
 scripts/checkpatch.pl                  |  68 +++-
 3 files changed, 592 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/dev-tools/checkpatch.rst

-- 
2.30.0

