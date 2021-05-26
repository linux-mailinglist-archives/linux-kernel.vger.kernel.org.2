Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484C9390E90
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 04:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhEZC6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 22:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhEZC6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 22:58:00 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D470C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 19:56:28 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso2857641pjx.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 19:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2UyXOnM3aTg90cC6788a9e+YlVPyj4bP+6GFHKBhjKs=;
        b=bkY8oi6/sNa/11XfqkFqadoUBjkjNhj9dc8K8aEyFZzSjTKdo/zJFtLx+Ct++VktBs
         jjRVlS/1+fJnilMtDE/UVuwVgCakfoSqYafxEQHqt754c5XdIgxY8QZ5ZTzIw0/S5v/2
         VOuUASggkntzH3XtHVFOWOew3hJCey0CK/7vQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2UyXOnM3aTg90cC6788a9e+YlVPyj4bP+6GFHKBhjKs=;
        b=VZR37et+GGnRb55uMYbBKDt8ZY3ylRysvQWwnBHGseDB01hW+iUITTOe+3aQMhkSWa
         TqZ1iURxt9ynmWALwgtsWLhSjIgz1ZLg5ahkqjOg8bADlY/SVWvGkyke300u9cj/CFEV
         v9JbFCfcbEnwVpZ6mIW3WtPszlr0JumIidzWulmqcHyE6vfncfrS++HxF00PGFjyAIt6
         xNPymAXMqfNoA3YNmRB0urC+xcmfpQ/A7r5YdfoBoabdI9j0mgmca7o2JiYykHBRUvVf
         K3gYadbQI7HhuUFlM1T8l3t24ZPkE4bwmrQ39DzJvIIB7Ny5pa/Cpex18l6201+9Q2cz
         S9Tw==
X-Gm-Message-State: AOAM533ZwiUSW+DrSd3ZCXmueD1zUECqDmjaWV0QaPji5J4pGlr0Ogm+
        dYGRCPe6EBWJQ7yDAIU3JUXkclTouBwJIg==
X-Google-Smtp-Source: ABdhPJy06rJHBxm8k6TUpfg/Ldo7hmcEA2eIN6QiK0c1BOX3gy5ZuvNCUIYlFe+gO6ckxqancQILtw==
X-Received: by 2002:a17:90a:bd05:: with SMTP id y5mr1557072pjr.213.1621997787719;
        Tue, 25 May 2021 19:56:27 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:5a1b:e4e5:eb10:8870])
        by smtp.gmail.com with ESMTPSA id 5sm2966295pjo.17.2021.05.25.19.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 19:56:27 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>
Subject: [PATCH v2 0/4] slub: Print non-hashed pointers in slub debugging 
Date:   Tue, 25 May 2021 19:56:21 -0700
Message-Id: <20210526025625.601023-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was doing some debugging recently and noticed that my pointers were
being hashed while slub_debug was on the kernel commandline. Let's force
on the no hash pointer option when slub_debug is on the kernel
commandline so that the prints are more meaningful.

The first two patches are something else I noticed while looking at the
code. The message argument is never used so the debugging messages are
not as clear as they could be and the slub_debug=- behavior seems to be
busted. Then there's a printf fixup from Joe and the final patch is the
one that force disables pointer hashing.

Changes from v1
 * Dropped the hexdump printing format
 * Forced on the no_hash_pointers option instead of pushing %px

Joe Perches (1):
  slub: Indicate slab_fix() uses printf formats

Stephen Boyd (3):
  slub: Restore slub_debug=- behavior
  slub: Actually use 'message' in restore_bytes()
  slub: Force on no_hash_pointers when slub_debug is enabled

 lib/vsprintf.c |  2 +-
 mm/slub.c      | 15 ++++++++++++---
 2 files changed, 13 insertions(+), 4 deletions(-)


base-commit: d07f6ca923ea0927a1024dfccafc5b53b61cfecc
-- 
https://chromeos.dev

