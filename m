Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51C141E34D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 23:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349646AbhI3VZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 17:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbhI3VZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 17:25:00 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFF0C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 14:23:17 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id g2-20020a256b02000000b005b71ee6a855so1510756ybc.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 14:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CzR1tKPYxsGrhthMkcPeA5o22pdPd8tz6Qctx/cVYlY=;
        b=gWIUXo1GdYI/2/V6Rr0Wcg/w/YTCaQEWkjRdUxQleTXkOlKZoiyug35UB8njWqwc6N
         Sd8W8Xmk66GFnN6D6r5b5/zz+7i6TDEK1IY7LROn/GarYUXH7jOiR+N0kqZejScVN8v0
         1JsSHVa99roHMJQY9Wvb7OaU+3AIjLtjCFm3HXKKfxI5ORI4dwR0wFjvQbMLfp6FGZkT
         zwND7qotqTvMzSTUuuzdeWJAGuRhO+D0r4kVe9v9lhsFIWcbTDJGT2m9WVaetBIN4xWe
         y2mMalw2He5t5A/H5Fyt6RQiRlieDHoKS2g3NmKS5NEgR++Q0WSFpGVmy/tg7vaI7DPq
         H8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CzR1tKPYxsGrhthMkcPeA5o22pdPd8tz6Qctx/cVYlY=;
        b=E8Dn8eFejgz+wjrgfCQItFK4pHeJVQNDM4qC14rrVAjthUoVBED7AJBoPBPh9ahj+L
         eMR6kjsx3Mm7HmXFBDn7jGfCjZcvAmrtYFA+oOTtANay8tobYwT90HvBqJBch2VKr2M1
         5ie9JIzliuOucxYyybmtQjnuOe+09PXKVYg6JLly6mrGPMA6At+OhhAD8jUFRDLTU9S+
         YULWuT54EH3uCnAODnSqgzMxI4RMMjfUUutbjmGA0hJ05jEWOq1jdLp/x3lKzUr1YSvR
         8zpS980NjOc9xdZyS64iUTub2KjP7mLS4jtvdoXjn7L+sNcckK6fyJ4sA4JR+QpULZn2
         8eqQ==
X-Gm-Message-State: AOAM531wpjkuhIWUr55B7igRw7tctbFmz5uicJXFKr/BYm0sR8gu0M/g
        3B8nJuCftoB8w879TOES9lZLJEZQY6cGUXJ8teno
X-Google-Smtp-Source: ABdhPJyqGFnp6gcLABO3XZ/sJo1FcUdnzqjMRKQS555L9bpcOLELdLIvGzrLuAxjw5MiSpIQdd2Au+KnI0Hv5Q12xu9/
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:fa06:3b29:d3c:37e6])
 (user=axelrasmussen job=sendgmr) by 2002:a25:90b:: with SMTP id
 11mr1685537ybj.192.1633036996833; Thu, 30 Sep 2021 14:23:16 -0700 (PDT)
Date:   Thu, 30 Sep 2021 14:23:06 -0700
Message-Id: <20210930212309.4001967-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v2 0/3] Small userfaultfd selftest fixups
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v1 -> v2:
- Substantially rewrote "fix feature support detection"; previously, it tried to
  do some larger refactor wherein the global test_uffdio_* variables were
  removed. This was controversial, so it now simply queries features in
  set_test_type, and leaves the rest of the program structure largely the same.
- The "fix calculation of expected ioctls" patch is conceptually the same as v1,
  but changed slightly to fit with the modified feature support detection in v2.
- Moved patch 3/3 to 1/3, since it is uncontroversial and could be merged on its
  own. I don't want the other two to cause merge conflicts for it in future
  versions.
- Picked up a R-B.

Axel Rasmussen (3):
  userfaultfd/selftests: don't rely on GNU extensions for random numbers
  userfaultfd/selftests: fix feature support detection
  userfaultfd/selftests: fix calculation of expected ioctls

 tools/testing/selftests/vm/userfaultfd.c | 157 +++++++++++------------
 1 file changed, 73 insertions(+), 84 deletions(-)

--
2.33.0.800.g4c38ced690-goog

