Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550FF36BC15
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 01:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbhDZXgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 19:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbhDZXgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 19:36:22 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF1DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 16:35:39 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id zl7so7245090ejb.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 16:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=z9nwM+xGXppOI0Ks+fmVvRjiIDun7SjvWhFDgg46BCU=;
        b=d2H+6AyeUiH/Pw2MeksNKePigxWd+ab0G8oCa/5sLcqxCt5Jf3n91bbUCUC7Qi4L29
         kJ9oYk06v0gMtHiqBwcQBUD+boyptN/I8OrDGEhAgcs1dyF8Vr8e8k6q+G3/epYDSdsE
         HEMhtO1vp1PRcKlrFvb+S4HmRDHFS18Uemj25HdvQJccTzFOpQahKRufaVrQAFsRuuio
         ZZFFyXTg+5i/ANQIAR5EXtXdjWljQNRP/hO0shLkfglm9FubPLfx5z7eXyo6/N6hnAGl
         36Qohkj1BI4SOCo8p41Pu252z4AjhJdWLQlopn2tmr+VcdSQV5hUMGNhYQi625iFAdXM
         Y9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=z9nwM+xGXppOI0Ks+fmVvRjiIDun7SjvWhFDgg46BCU=;
        b=Bv0TQuoGW+MyTuBZUJjgadSoV4ctV+szxaF4s49ofXiMt0CTwSLFySk6e7k+ag+ETz
         BctZjDOKS0wvVyA+E8IV6zPI5PlvIOor2+r9VYrSeVJU4jd6tidjroPqp0oVRmCs9mkR
         C0aicXYvNLOBz1b6jM9www0tWzGSki83TBRvuNoiE4qnQl/lZc8cNUt3n1e5/f17rnPd
         aBxBuImpwu5whmhEBY/4hNGZlQoRDzCq7GxZruUm1C7Nn8X8iWE0Jw/B51jdxGqbAlb9
         kQy+4tiZf+AjelY8aDI/50ZolXLFQi/ThfpjTJYjv0Fw0QdI7dLErUo2qEvSfR9j4/Pz
         VBmg==
X-Gm-Message-State: AOAM5329biGfyvOAUXlERsHE38B0XyPZ7uq1GuPjGOj0QVISr2PTs1Sf
        IsK+pLu+hCsZaZRSmMFw0+NCHi7KFA/CZg16n9bs
X-Google-Smtp-Source: ABdhPJypP0qmW+oe/zm/ATaVIhbgFTpfuaTwreU8xoMWPk++Oye2A1v54uUNWQM5CVzM/494TAw4PuNzG+Q/WcadoVw=
X-Received: by 2002:a17:906:79a:: with SMTP id l26mr3560154ejc.268.1619480138335;
 Mon, 26 Apr 2021 16:35:38 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 26 Apr 2021 19:35:27 -0400
Message-ID: <CAHC9VhRBXj+WfsvqTKJNWBUOQgb=Ezarbm47RKMN4rRby5fd+Q@mail.gmail.com>
Subject: [GIT PULL] Audit patches for v5.13
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus

Another small pull request for audit, most of the patches are
documentation updates with only two real code changes: one to fix a
compiler warning for a dummy function/macro, and one to cleanup some
code since we removed the AUDIT_FILTER_ENTRY ages ago (v4.17).

All the patches have been tested using audit-testsuite and as of about
thirty minutes ago the tag applied cleanly to your tree, please merge
for v5.13.

Thanks,
-Paul

--
The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

 Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
   tags/audit-pr-20210426

for you to fetch changes up to b75d8f38bcc9599af42635530c00268c71911f11:

 audit: drop /proc/PID/loginuid documentation Format field
   (2021-04-01 18:32:24-0400)

----------------------------------------------------------------
audit/stable-5.13 PR 20210426

----------------------------------------------------------------
Arnd Bergmann (1):
     audit: avoid -Wempty-body warning

Richard Guy Briggs (5):
     audit: further cleanup of AUDIT_FILTER_ENTRY deprecation
     MAINTAINERS: update audit files
     audit: document /proc/PID/loginuid
     audit: document /proc/PID/sessionid
     audit: drop /proc/PID/loginuid documentation Format field

Documentation/ABI/stable/procfs-audit_loginuid | 27 ++++++++++++++++++++++++
MAINTAINERS                                    |  2 ++
kernel/audit.h                                 | 12 ++++++------
kernel/auditsc.c                               | 11 ++++-------
4 files changed, 39 insertions(+), 13 deletions(-)
create mode 100644 Documentation/ABI/stable/procfs-audit_loginuid

-- 
paul moore
www.paul-moore.com
