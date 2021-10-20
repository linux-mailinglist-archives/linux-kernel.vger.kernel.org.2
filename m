Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1966B43430D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 03:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhJTBpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 21:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhJTBpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 21:45:23 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03232C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 18:43:10 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id i20so19710662edj.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 18:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=oHyNu7qJGC+9nw2fsQZ6J+tr947f4mjfdkIAroavod4=;
        b=p/XkLeU7ZnAzdx1dp/UJIMqA3GIHMxSfNQUhBsGW53WCMQ8jzILvbhuyNe05v4Vw77
         qKWR6g28UY5F3WZKEPflJThVBXxoB03NYWZgYrM2LOTAdc/mx/si1XF0PPdCwI5xYntC
         JCqyo7ZOPhMz1X6NpfVCYpravbw6cGlUqDugmDwdTOMVDJfDuKffdojyfjAiy9gp45qQ
         5HuVsSSDpqsrQ/kfvtRn+yD7n1GgtCnvUxBv5gmtOBvBcBAGvKM68kDTazloSTsemqk1
         Edt9CwZ+6SyVmvjf0nuD6RGdfSqh+6N0YAQ1qRo/vMg2i2Eh94TEd108pAdZMVgnABXg
         UbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=oHyNu7qJGC+9nw2fsQZ6J+tr947f4mjfdkIAroavod4=;
        b=HdzaqVfY7vpHNDuWPBrrDw4LiNA5RRPt6nst+jYRMtxk+VSKXD8mVd/CbHit2E0Z+r
         /d3/rNxwbelo3qF4vWMbbE9jMRrmgqW+3CB875gAvSoVCSMyCsJ/ebNfQn98/Fg5Xfy4
         RjzDQqHUw87tVZyBy/ek1VjJurEa4fAhUQg4J9jRwaaa1R59CXkAXwq31spthB+G0Q0f
         qlWg6lLpRchTrXvCMoF/D4qAPTGrsGnCjIHbcl/P/6KLsCUdndvqeAImWl0KkUHGy6nQ
         D2CrXND5oy4Crgj/S42N44HtrTzCLX4t+qYfOlY5T+fTpIwHs4n4RgpJhQybKLeDP2x7
         ECNA==
X-Gm-Message-State: AOAM531MxQayTLwGA12d8lGXH7X/zx9dVbdkQcrVRRlqfbZ86PPf0o9Q
        TvmfL0WdRXQbsWrBsNAAt9tbLdKUO+ElZpZqBN1I
X-Google-Smtp-Source: ABdhPJymIJKL/271AbiBzjsN/HbzJXB0lNuEzjumPwfE1Bd4nf1DySgGzhw2EIrv2nexZC7AMElM3+ZTm3OrFiqHPEc=
X-Received: by 2002:a05:6402:5112:: with SMTP id m18mr57444646edd.101.1634694188371;
 Tue, 19 Oct 2021 18:43:08 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 19 Oct 2021 21:42:57 -0400
Message-ID: <CAHC9VhSfwi2NhS4HtmqjfrnQcK+YjaH1xm5XdAZ=MUcE78oCRA@mail.gmail.com>
Subject: [GIT PULL] Audit fixes for v5.15 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

One small audit patch to add a pointer NULL check, please merge for
the next v5.15-rcX release.

Thanks,
-Paul

--
The following changes since commit 67d69e9d1a6c889d98951c1d74b19332ce0565af:

 audit: move put_tree() to avoid trim_trees refcount underflow and UAF
   (2021-08-24 18:52:36 -0400)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
   tags/audit-pr-20211019

for you to fetch changes up to 6e3ee990c90494561921c756481d0e2125d8b895:

 audit: fix possible null-pointer dereference in audit_filter_rules
   (2021-10-18 18:27:47 -0400)

----------------------------------------------------------------
audit/stable-5.15 PR 20211019

----------------------------------------------------------------
Gaosheng Cui (1):
     audit: fix possible null-pointer dereference in audit_filter_rules

kernel/auditsc.c | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

-- 
paul moore
www.paul-moore.com
