Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDEEB3211A0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 08:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhBVHwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 02:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhBVHwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 02:52:42 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1714AC061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 23:52:02 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id t25so9745872pga.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 23:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lRdSl2m/DMw9bKAYBWJVHZp5b5x9JGXOXuV0kEEo+DU=;
        b=V7GyxQv+4AvJQ6fvEkKee4b+z+sdzaBU7VwJ3OuVYzc/xPDATqo+h+7sikRDqoFqnx
         nzN09NkHOknF9HZpI/SmcRKsdVLqj6sDI3jtcdwYqqm4zTZ+86fsGerBsanQZ9vo1U2i
         nJocEX7YK8zCMUN/2qmn5gPG13d7Thj+YdpuANMSfwZPi/guEs5ZKbMq2qt58VbzD6OF
         MzjQozqZyBKLw3zPiQH1PE9DETFFPZp7dyV9w3G7SKfdFujZ92SeWWy3q7hiWjsJVfac
         nayaFLfI2iUAmAG6uYqQ8qrtiLYKh4a6iMFyqctv05VEOdOF9FAMTW+rJwzjEO93iuOR
         sjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lRdSl2m/DMw9bKAYBWJVHZp5b5x9JGXOXuV0kEEo+DU=;
        b=dNnU4/0Ghs4wDvbszVlSmSV1qrzzhF+tvmKpcEukU9ILP4/sX1MwGkD6mSzQFImM9C
         9ZhETkt54lkNP0NW/wWftk9J/HDsNnFjvTwbWx6ZPgPRQio6cOHlOO+WibNC6Po0fvmU
         G3qJGINhjlEjChT9p2HbDcB31fC8xBSXVFMFAE2AjWiCkjsH9RWf6ukYOO9q8E1x65S/
         B214OY3i/bIFOZEJBbQeEvXtvX8J546L56PxqWKbrKeR+ra9nbBkysZfGdZjq1LqOOMd
         WvYgQPFbehPKk9djhjW7a4G4nWEJno9GheddV3ul/hc/WZWsDrdplptj7orLKyOenn8W
         oaUg==
X-Gm-Message-State: AOAM532OVHe697oZS8nkocDgyBZHlYrQ9cj92wnqbJk4WeSJ/dVtY/sI
        Jy1DLi1qZTTicRlwOdHxCfXvZw8YmeD4yg==
X-Google-Smtp-Source: ABdhPJyaCJTv0MM/9NNtnTu5jhVRvMA+OT2i3iufHlLkw+IkvGydM5/vNLM0LErty1D3EoVLhuJ25A==
X-Received: by 2002:aa7:80cc:0:b029:1da:689d:2762 with SMTP id a12-20020aa780cc0000b02901da689d2762mr21072088pfn.3.1613980321393;
        Sun, 21 Feb 2021 23:52:01 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:6a36:aa32:eebb:1da7:c90b])
        by smtp.gmail.com with ESMTPSA id br2sm2651665pjb.40.2021.02.21.23.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 23:52:00 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: [PATCH v7 0/2] checkpatch: add verbose mode
Date:   Mon, 22 Feb 2021 13:22:03 +0530
Message-Id: <20210222075205.19834-1-dwaipayanray1@gmail.com>
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
  checkpatch: add verbose mode
  docs: add documentation for checkpatch

 Documentation/dev-tools/checkpatch.rst | 525 +++++++++++++++++++++++++
 Documentation/dev-tools/index.rst      |   1 +
 scripts/checkpatch.pl                  | 133 ++++++-
 3 files changed, 639 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/dev-tools/checkpatch.rst

-- 
2.30.0

