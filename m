Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E593948EF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 00:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhE1Wqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 18:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhE1Wp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 18:45:58 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AB1C06138D
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 15:44:20 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j14so4691298wrq.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 15:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=CcDQVZ0nU17dgGlT8JDrJAgpEne80TrIbiiyOtshi98=;
        b=PM1tWasXilBCst3gWMa2b/0/xpVoozvR0328xKHifsIy1fdFEWtsO4f5dnFiwe79z1
         /iJKuJaqO4B5y2CIpF/kD5zVrNkUwBEp4jk9AID9gpSeiDMZHb8kK8QXHLCuREsYk5XS
         FQ6yNduMsUOi19UGFM0jACee7rPqIoDvwsCadcQq+6jpXczE2U+HrjKe3fSVxOMWopj4
         Es+aMfv+b/Um6uULXP6qz5MK6w7pNPpy3J5c/98CHi1RfaDj7IeTGKCKHNfn71rZDxlR
         4H00nAZqm6DEc4gfaHxBrmS8RlmB7NYi3brGkb5RxLoWi8ScZjLXX6RpEYxVob/wZlAx
         OR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=CcDQVZ0nU17dgGlT8JDrJAgpEne80TrIbiiyOtshi98=;
        b=bvQaHQIPkyDTcMSvm8YdwsUaXMa4L3FARvIGpgECNjfaDPFzOPcufVBA/uqNdgKRQY
         EZAoOzOaIwV28ySrONlxFuGvhN6DI8oRMpaUSsQphNeh9sUjBg5JeP2WbhlhaxI3Y8y/
         160ECPRnqagjzjFgnWsR2duzOuIpxrh+fK7kK8oGXaiC3c4AeklMNK81edtMmG0x5asc
         WGJOvog9V69611hjxQ9u/rvhNoH2utM74jA5eNkz3a1A0bJ1KRRh9JCOYZQ0K5c5u6SC
         WDIOlo+lAjk8qbCYmsw7bPhjBONUmGMNEL7YaPcK8m0d1yFqDuSgU06bIyWh5Hp2IIT2
         tp5g==
X-Gm-Message-State: AOAM531ypZhmEDxdLY4rM/AMdYlAneqphSAcGCgonycjiAGgiFodad0E
        aLrRuV6ECMlGxK9I5CJkls7AZ3Pun069FWcWgwRX7xdFlstAkA==
X-Google-Smtp-Source: ABdhPJyzDouPR3C9BExdhA1/PxEx6Il0L8aZcbbeoyC8D0nVjpa46avb+GKBgyXYttW2Toq/PlW8URS0+HNIxjKD4Xg=
X-Received: by 2002:a5d:4e85:: with SMTP id e5mr10865910wru.68.1622241859093;
 Fri, 28 May 2021 15:44:19 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 28 May 2021 17:44:08 -0500
Message-ID: <CAH2r5mumd-nG0ikX0ZDFnJt+oGcgZBPgqzjuye=AjycSEYE43g@mail.gmail.com>
Subject: [GIT PULL] SMB3 fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
c4681547bcce777daf576925a966ffa824edd09d:

  Linux 5.13-rc3 (2021-05-23 11:42:48 -1000)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/5.13-rc4-smb3

for you to fetch changes up to 1bb56810677f26b78d57a3038054943efd334a1c:

  cifs: change format of CIFS_FULL_KEY_DUMP ioctl (2021-05-27 15:26:32 -0500)

----------------------------------------------------------------
3 SMB3 fixes: two for stable, including a fix for "UNSAFE MEMORY"
message logged, and the other fix addresses a problem pointed out with
a recently added ioctl including a build error on ARM)

Regression test results:
http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/2/builds/659
----------------------------------------------------------------
Aurelien Aptel (2):
      cifs: set server->cipher_type to AES-128-CCM for SMB3.0
      cifs: change format of CIFS_FULL_KEY_DUMP ioctl

Shyam Prasad N (1):
      cifs: fix string declarations and assignments in tracepoints

 fs/cifs/cifs_ioctl.h |  25 +++++++++++++++++++------
 fs/cifs/cifspdu.h    |   3 ++-
 fs/cifs/ioctl.c      | 143
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------
 fs/cifs/smb2pdu.c    |   7 +++++++
 fs/cifs/trace.h      |  29 +++++++++++++++++------------
 5 files changed, 150 insertions(+), 57 deletions(-)


-- 
Thanks,

Steve
