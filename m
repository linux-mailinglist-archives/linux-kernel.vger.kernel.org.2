Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAFCC33CD9B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235691AbhCPFsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235602AbhCPFsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:48:00 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DBEC06174A;
        Mon, 15 Mar 2021 22:48:00 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so784849pjc.2;
        Mon, 15 Mar 2021 22:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e8Vte+BbSap8YpwjFJ75g2azWXd0zsCfSFory9ijCek=;
        b=LoU/IxOthJou8zwK+tz3hGZJjyEE9k6/05PoHDFjex11wE1IcW2TEm9vDtxBxOdHwN
         hE9s8SKkv5JQyORt7Fg+1zVz0j4a+0Rg3uuhoe6k+cjVvVh6eLD2ypva9EpbTz22zmGi
         ghopwouOv6bhOpsVjiq2+dRJCyq6X0kcL7ydnG3YKufVZB2ZsjJm/WG9XsMtLN59NEun
         xNxIypqQTOS6kG8EZqiKYGB/KG8UiMOh2FGcJ42ZL+DmAfG99GG/V67TEY9go1x6x/jl
         WpHk4wHYkAzY6hexO6dWGDQvGu4e4GTQyxi15n50j4XkawIYdazZG5gX7mPHxOrQtzYi
         6pvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e8Vte+BbSap8YpwjFJ75g2azWXd0zsCfSFory9ijCek=;
        b=L/LgNkmy367sHQdA9i3NoCZK2h7mUOC8vJ9ZIrgygvdJyRd2DMobccMxK/tiCz4Khh
         AGpkrZl++JBMU5hX3FpH3PahdzQQhLjGqgKegObsUAQtfvRQrEsmaNEid1Pr76Te+H3f
         SXO70A7zhIEfLtsBQBO2c3+HHroUbYJ2KDfJ4U657yJutpgn51US16QjKQjd26gr0sxt
         WrYt54994JuThEprqwRIQ2RlMMlaF5iairfCj7wf3wlPSHTT0dOs+wLtkuYz0wGttNZS
         /oWGL8U91I4/qW2eSFevx9xyGmCdCVl7evedKyQgUr/KeAP+C1CUBXyJ985eWdt9gUDd
         Larw==
X-Gm-Message-State: AOAM532Xw0dEWwzk6PZOPJl7QcUz1RnVHUXlACHGRvVabZ+9ZryMTGBX
        CJaVjUY0iRpxTvFXjvO1sAk=
X-Google-Smtp-Source: ABdhPJysoBdyt8XhhrlqSQy2CkUGbw0a+AjALMH3pe3uBJ5kBl74wSekDfIF+sLi590XrILtrhLp3A==
X-Received: by 2002:a17:90b:4d05:: with SMTP id mw5mr3082534pjb.236.1615873679902;
        Mon, 15 Mar 2021 22:47:59 -0700 (PDT)
Received: from cl-arch-kdev.. (cl-arch-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fed6:fc0d])
        by smtp.gmail.com with ESMTPSA id l22sm15096513pfd.145.2021.03.15.22.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 22:47:59 -0700 (PDT)
From:   Fox Chen <foxhlchen@gmail.com>
To:     neilb@suse.de
Cc:     Fox Chen <foxhlchen@gmail.com>, corbet@lwn.net,
        vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 10/12] docs: path-lookup: update WALK_GET, WALK_PUT desc
Date:   Tue, 16 Mar 2021 13:47:25 +0800
Message-Id: <20210316054727.25655-11-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210316054727.25655-1-foxhlchen@gmail.com>
References: <20210316054727.25655-1-foxhlchen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WALK_GET is changed to WALK_TRAILING with a different meaning.
Here it should be WALK_NOFOLLOW. WALK_PUT dosn't exist, we have
WALK_MORE.

WALK_PUT == !WALK_MORE

And there is not should_follow_link().

Related commits:
commit 8c4efe22e7c4 ("namei: invert the meaning of WALK_FOLLOW")
commit 1c4ff1a87e46 ("namei: invert WALK_PUT logics")

Signed-off-by: Fox Chen <foxhlchen@gmail.com>
---
 Documentation/filesystems/path-lookup.rst | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/filesystems/path-lookup.rst
index 0d41c61f7e4f..abd0153e2415 100644
--- a/Documentation/filesystems/path-lookup.rst
+++ b/Documentation/filesystems/path-lookup.rst
@@ -1123,13 +1123,11 @@ stack in ``walk_component()`` immediately when the symlink is found;
 old symlink as it walks that last component.  So it is quite
 convenient for ``walk_component()`` to release the old symlink and pop
 the references just before pushing the reference information for the
-new symlink.  It is guided in this by two flags; ``WALK_GET``, which
-gives it permission to follow a symlink if it finds one, and
-``WALK_PUT``, which tells it to release the current symlink after it has been
-followed.  ``WALK_PUT`` is tested first, leading to a call to
-``put_link()``.  ``WALK_GET`` is tested subsequently (by
-``should_follow_link()``) leading to a call to ``pick_link()`` which sets
-up the stack frame.
+new symlink.  It is guided in this by two flags; ``WALK_NOFOLLOW``, which
+suggests whether to follow a symlink if it finds one, and
+``WALK_MORE``, which tells whether to release the current symlink after it has
+been followed.  ``WALK_MORE`` is tested first, leading to a call to
+``put_link()``.
 
 Symlinks with no final component
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- 
2.30.2

