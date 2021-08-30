Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFBDC3FBA52
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 18:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237881AbhH3QsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 12:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237747AbhH3QsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 12:48:01 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838F2C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 09:47:07 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g22so22582813edy.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 09:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Mo0vOQHyTSp8U2GisgH844mCZQb1S1hK0Xminq7fEIM=;
        b=ftBHnfzgBrVL8mxltbLN+p7hBdAvELKkuY3k6DmTQK4gekVkfMEz769sG1Dy7Ha2FP
         3q8Ye8BmIF/0+yWSjQcMx8OkLwuUs3NC6Y9DBRuULINUwQm57y5CwUcKMyStfE5vYqeh
         F0hUqvbbe6OHiTbGpX0Zz37u9LhBBj8w66bXi9c1pLogdLbsvEkElWbYCf6/2w6rlTiz
         gN/XfustHDbvjeCHIQcocYawQgdBdbjVsm7jfuBWscZMzbVEp15tvEQSCEMDy8knzQFg
         O1jzy30xzysKnS3GmM4qIqRVlUamSvSY/GEuEhVy02U94xE1WMqobgdFXbLNdoJUFKzE
         NcUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Mo0vOQHyTSp8U2GisgH844mCZQb1S1hK0Xminq7fEIM=;
        b=e+SrVAzZjU6C/z2je+/kAU69c0zHip1Tf/kjbQC/pB7SRAN7/ui91k4sMBUhWowmJr
         t3VjcHin7MRKQFqKQi4tP9mV5PTIZaFccNxIFhPZR0rovf8Lgx/2XnQNc5a5KvBscfV9
         O2iHIV/gyA3RqhmetRBSOZvCc7g4Lemt66bW0DvIuD0hJiAgzCsRvaMoVw+tWGiZ8qKf
         hgZuzOMbySa8+ng9psBfEuIhABB0f+KFHYxzhpUyubborR9O8mM0uXRUv5h2w8YQAyYj
         T5RPQqTU8t5TDFA5r/K7rioz2JwVicF0TyhG3Mcmk1N0lbj4wjr8lujwAGipWtf1Y1la
         nZSg==
X-Gm-Message-State: AOAM530L59ufOPx/S6WgDL0oCGelV986i5yQSlVK3EfHwKPZ1TV0prCC
        xdSBtwOwy5ZAPZZnvDdHrpx9Az1Z21uDTXZ+iuPJ
X-Google-Smtp-Source: ABdhPJzFgczWFIdOsoArPl8oo0yfyYmDwqxMiF2Lpkj8LrH3JCsNSwjuh7fGnXubrmyNUwZ/kQzJSciSjgOldcUxejc=
X-Received: by 2002:a05:6402:4cf:: with SMTP id n15mr25555674edw.269.1630342026004;
 Mon, 30 Aug 2021 09:47:06 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 30 Aug 2021 12:46:55 -0400
Message-ID: <CAHC9VhRwfin0DgQ3VOLcQfmxbZLLi8TExA4hStR0vCODktRJfw@mail.gmail.com>
Subject: [GIT PULL] Audit patches for v5.15
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Two patches in the audit pull request for v5.15; one is trivial
("header protection") but the second is a real patch that fixes a
refcounting problem.  The refcount fix normally would have been sent
up during the -rcX cycle, but since we merged it less than a week
before v5.14 proper I felt it was better to wait for the merge window
to open; the patch is marked with the usual -stable markings.

Both patches pass our tests and merge cleanly against your tree from
earlier this morning, please merge for v5.15.

Thanks,
-Paul

--
The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

 Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
   tags/audit-pr-20210830

for you to fetch changes up to 67d69e9d1a6c889d98951c1d74b19332ce0565af:

 audit: move put_tree() to avoid trim_trees refcount underflow and UAF
   (2021-08-24 18:52:36 -0400)

----------------------------------------------------------------
audit/stable-5.15 PR 20210830

----------------------------------------------------------------
MaYuming (1):
     audit: add header protection to kernel/audit.h

Richard Guy Briggs (1):
     audit: move put_tree() to avoid trim_trees refcount underflow and UAF

kernel/audit.h      | 5 +++++
kernel/audit_tree.c | 2 +-
2 files changed, 6 insertions(+), 1 deletion(-)

-- 
paul moore
www.paul-moore.com
