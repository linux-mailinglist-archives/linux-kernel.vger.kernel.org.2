Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2978B3FBA3D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 18:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237792AbhH3Qht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 12:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237774AbhH3Qhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 12:37:47 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4027C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 09:36:53 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id s25so22637254edw.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 09:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Hlf7A8r7y7wi73uxDoVnlmq0Xmtbe53qsJnuN57thhs=;
        b=NvOyTT8PfwGmcWoey1yZKLubCMBsgXts99GWu40fcXrSdRBTezFURGBL6hHDwGeO3x
         2x3uLwM7jE2PZoA2CcsMORXWQF34gzKHZGtBLixA1k4Z1xueXopLZZHbfgzYmTk2sgRl
         HIwHEVh6kYp/4h2yDS2NmWA/tdVQ0eac9OevEZHi2LAALWCaGUoMOSXuo18ST2K+nbPk
         liQrdmS25m3mnT5JKNQmcTtiIyyLh4cn6+RRCoMBw3/z7nSYYaoE/b4xsKnmX0dCcK87
         +P0prVrTYhdwpkSJMDuvyzyAnNtcNDU/Z7yLE+lXMVyPMxtwjQ1lXUPt+ZD3Yo1A+dwP
         Ti8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Hlf7A8r7y7wi73uxDoVnlmq0Xmtbe53qsJnuN57thhs=;
        b=U8fwF/71mbS8N0uAxyjBl0hkYoAc94g554PT3uAyH3ckX9KtcoHXcnp5iQuBpy5YCb
         q0ko5cBlC3UgYCpL6e63iWaRwJ/isq/ekeG606qGpjjFt8DCXMn0Lzu/pHXg/7fldBaW
         e55CoQW5/FKkELKkfWhsYpy+fQ8WOXAocEYpqQPV0L4zpYPSXZyD97QRZ5BuRjEQQIlV
         3VNjyN90GAcMl1Qt0GdpqrZdoceWA6ZTm91zf8ZpiyR6PeDkzT/LJ2zXcf2OczXXqukf
         rZfWbjSHpN0VFASQo8y1HCqh1jrFxovDPL/iKYU+5UeuHhUa+9nyxDbZcsKHxw76iAtj
         UfOg==
X-Gm-Message-State: AOAM531yNsY658KRLE3wBT48cF4qOJIbd7Y4fbXL0dt43OdN9imKrL9k
        nncsRtUyWBSMJdR+Kk5Rfe4WRLs0lK3WdRbLjO2UwETaZAv5
X-Google-Smtp-Source: ABdhPJzF3xU+nWY0Q4n+AxqozWuahCxrfBiesnS+gniNXKzfSVXZyGIy79UQX3KOlxif1YA+eKaOE7GTVEOsPJJWTJA=
X-Received: by 2002:aa7:d9d2:: with SMTP id v18mr25608229eds.128.1630341412379;
 Mon, 30 Aug 2021 09:36:52 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 30 Aug 2021 12:36:41 -0400
Message-ID: <CAHC9VhQDQ2WF+gsRdC+3g6FLa19nvbka99zE0s_ZbupucpmJmQ@mail.gmail.com>
Subject: [GIT PULL] SELinux patches for v5.15
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

We've got an unusually small SELinux pull request for v5.15 that
consists of only one (?!) patch that is really pretty minor when you
look at it.  Unsurprisingly it passes all of our tests and merges
cleanly on top of your tree right now, please merge this for v5.15.

Thanks,
-Paul

--
The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

 Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20210830

for you to fetch changes up to 893c47d1964f5c9b00c5468f2cd1a1e9351fbb6a:

 selinux: return early for possible NULL audit buffers
   (2021-07-14 15:25:27 -0400)

----------------------------------------------------------------
selinux/stable-5.15 PR 20210830

----------------------------------------------------------------
Austin Kim (1):
     selinux: return early for possible NULL audit buffers

security/selinux/hooks.c       | 4 ++++
security/selinux/ss/services.c | 2 ++
2 files changed, 6 insertions(+)

-- 
paul moore
www.paul-moore.com
