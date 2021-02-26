Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F969326042
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 10:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhBZJjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 04:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhBZJjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 04:39:11 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A0EC061574;
        Fri, 26 Feb 2021 01:38:31 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id d2so5757571pjs.4;
        Fri, 26 Feb 2021 01:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zPJxlvDtqyS+QVulOcRddj9Qq62vU/rkbUisQE4o2V8=;
        b=UBJJEceql1d/vuTPvNuSeQPwIKFdI4tM1iC/6Um9d7d1TeInPATInyvQ6w7FVqBgZQ
         A2tDUzL7uzjVQzeEd/9yTNWQ7vj/Mb3lAPx2ygqidht6DmG6ys24Wo57CQvfBkUCuOUF
         TfD4DsZJCyhnHQm8l53gXO90THkIDTtnUHXf8OObtHfetF7aWku5lHlBoB8oJGI4opR7
         53yPZRuq1wDObpb85lhfAa6xBPf47D28ukEs9BBwmM89A5gwLu2SlJZIO6XAJldIO+aj
         ErRobQmFosUeF0Yy0vwXJlqgZKhcJH6Y7JupgHFJ+oB9Tfoozb0CoBt8E5zijT4nWopc
         qsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zPJxlvDtqyS+QVulOcRddj9Qq62vU/rkbUisQE4o2V8=;
        b=oCIiIWJ/6cpEMU7ON9xaXr8Ii8FXjcXoxlnO36vs/Y974GQb1huzavd3zSK1cToJyZ
         VLv3EBdF49XVjS72npPS/Fi+YzPcGq9/LupbgauNi7X1ERCg05reVafiS/6KLQ1LFf6T
         oV0H+2sB5uprzE7hT9oDcOBJejVpy7tS7ogOUkwB4urzWwq+LGPvmyjtTp50kGGUVMDE
         tMEJPIeTvVxSPXGMZF2JV1b+2xzH6PRQh1KD9BdhnDbO6JbdA7NKOc7FxfsLiKMt0hWu
         T8xCBadF0BNYLVIJB17wff6lEkAmsb8H+B8NPJ76UFIW1imtcw9uRTXxx0WP1MXpANbG
         vvIg==
X-Gm-Message-State: AOAM530s7Qy/FY1163sH07bujBWJMkYltgB4Tr/PTyDEHFP05/8+HMu7
        v4UeSJ1IoViblsFavB4wcLA=
X-Google-Smtp-Source: ABdhPJxn1at9tHb3fbqBCb35cWozOLn/ktt9MhDH3+IDPw7urhhpsmoSL1D/qIsPxttvfeW0T5NJfw==
X-Received: by 2002:a17:902:b781:b029:e4:545d:77 with SMTP id e1-20020a170902b781b02900e4545d0077mr2259006pls.59.1614332310589;
        Fri, 26 Feb 2021 01:38:30 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:6adb:2468:cd7e:b0b6:7857])
        by smtp.gmail.com with ESMTPSA id n1sm8548833pgi.78.2021.02.26.01.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 01:38:29 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com, corbet@lwn.net, mchehab@kernel.org
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: [PATCH v8 0/3] checkpatch: add verbose mode 
Date:   Fri, 26 Feb 2021 15:08:24 +0530
Message-Id: <20210226093827.12700-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new verbose mode to checkpatch. The verbose test
descriptions are read from the new checkpatch documentation
file at `Documentation/dev-tools/checkpatch.rst`, which
is also added by this series.

The verbose mode is optional and can be enabled by the
flag -v or --verbose.

The documentation file is only parsed by checkpatch.pl
if the verbose mode is enabled. The verbose mode can
not be used together with the --terse option.

Changes in v8:
- Remove custom table of contents from checkpatch rst

Changes in v7:
- Add color coding support to --list-types option

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
  docs: add documentation for checkpatch
  checkpatch: add verbose mode

Lukas Bulwahn (1):
  MAINTAINERS: clarify responsibility for checkpatch documentation

 Documentation/dev-tools/checkpatch.rst | 513 +++++++++++++++++++++++++
 Documentation/dev-tools/index.rst      |   1 +
 MAINTAINERS                            |   9 +
 scripts/checkpatch.pl                  | 133 ++++++-
 4 files changed, 636 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/dev-tools/checkpatch.rst

-- 
2.30.0

