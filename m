Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF4431C3F5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 23:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhBOWMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 17:12:33 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:43593 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhBOWM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 17:12:29 -0500
Received: by mail-ed1-f54.google.com with SMTP id r17so3367353edy.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 14:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=pYLA+3nnxoVua5LijBXQo1mBB+NhAGqtgS8dvq0VqEQ=;
        b=H28qz+PPhlC6P/1uSmaWCS7UU4wjZgeYNiKbwSuTmQkwpJjz5su8DCsWx96VwXIC20
         2M76K//hMOhzfNVppawGox9gUqJ41ofJxrVXSagADwSteO0zUQsD2SxpnuYmXfjFN8wO
         M0uad4X0EuPqdhsq/0WvTZy/dEZ5ibkBTSWMPHexZWSN5HYFeJgonTKXFGYHbUMraR3l
         ZUQlMdSJkdEBuINrI0ID8YNpT4dCqZcS03ADwopgiYvQfRTYoyuYfj8CWbVtCLMPfcCh
         fe0J5pHzY6x1/TMgtFQsjjwN115Ib2VVCeeWZMnpMScpk8t1cX+u/65nnNvnhD9AL46j
         vbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=pYLA+3nnxoVua5LijBXQo1mBB+NhAGqtgS8dvq0VqEQ=;
        b=j8jYOzt5nWIYo91hdYgb9UY0m79OahZ0sbUuZzo05pckuIn/qYxQdCdtN832rvx34h
         BMZ0seQKlm/VyRyFmQiIafneOas3sLy7c3xYyKTRD9kQoYUPmWLL+g7tTMMovWL31SQD
         27b9e1KYQ/r66AGvA/5+vlTE2d5q1PG0Nus6bNHmjvq1sm7fLKjk98PYL1zcGnb9MoqI
         Nt9D0A1Y6dfsjMpJMHzsHpjEPJrI1jwH+BLUa1d8+0ohejJivb6D0UgS32EunORQB4wr
         nQShtxCTqUDeZHZ8VJ2P+98j+ZHakHfxTyifC/DZWWqxXQCxVYvrzTcl/Uzn3m4AlhPD
         kdyw==
X-Gm-Message-State: AOAM530PwTXZrFrRYfaK+H2ZShRwGRvqU+2bQJfheAuKfwVMAn3/D7Yq
        G3JSIwryimeLqJMnpy1bPQXVzk9vISIODe1C40/N
X-Google-Smtp-Source: ABdhPJzNieooTTb9kdYmB0WNp4KiC6FvilXH3aiCdHddttzvcMJzQiB5YK3rK6kWfWl8EYDm7LhIUgul6cQ48a9ahtM=
X-Received: by 2002:a05:6402:438d:: with SMTP id o13mr17563068edc.135.1613427047768;
 Mon, 15 Feb 2021 14:10:47 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 15 Feb 2021 17:10:37 -0500
Message-ID: <CAHC9VhR8gwyPpGnHbELBJ+2AZKQD0YTmhtSsLULjNbp7M-UM8g@mail.gmail.com>
Subject: [GIT PULL] Audit patches for v5.12
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Three very trivial patches for audit this time.  All pass the
audit-testsuite and apply cleanly to your tree as of a few minutes
ago; please merge these for v5.12.

Thanks,
-Paul

--
The following changes since commit e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62:

 Linux 5.11-rc2 (2021-01-03 15:55:30 -0800)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
   tags/audit-pr-20210215

for you to fetch changes up to 127c8c5f0589cea2208c329bff7dcb36e375f46c:

 audit: Make audit_filter_syscall() return void (2021-01-27 21:55:14 -0500)

----------------------------------------------------------------
audit/stable-5.12 PR 20210215

----------------------------------------------------------------
Davidlohr Bueso (1):
     audit: Remove leftover reference to the audit_tasklet

Yang Yang (1):
     audit: Make audit_filter_syscall() return void

Zheng Yongjun (1):
     kernel/audit: convert comma to semicolon

kernel/audit.c   |  4 ++--
kernel/auditsc.c | 16 ++++++++--------
2 files changed, 10 insertions(+), 10 deletions(-)

-- 
paul moore
www.paul-moore.com
