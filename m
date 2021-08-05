Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63213E1B53
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 20:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241106AbhHES3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 14:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237842AbhHES3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 14:29:54 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9E8C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 11:29:39 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g21so9729205edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 11:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=1c3VrQ3FItr1tlZhwJQtIGHjV4vRn9xHIa6kZJ9nIxc=;
        b=ENJ2jsN+dNUIpx8dGcAJJc8GzMluVKbrtwQDHErnQEU/A81cSqgkoF7qq0hI7vjVBC
         6SAeq763ZYep6+7i423qXiE3kOy6oCxfX7Y2JfLsPG1JLfWvy5mJ7LfxrZeBqyMCw4YA
         oEMOdMhyxUTJvSeiTF2Fg4TObSBepBxN/52U/KCJyHXGzFUXGscu8+7rP/mzed1T9JU8
         Zrf+y/MbvTrSGMA6Mlh/NoQTO+pIt3N1ECtqu9hZj5Mzh3p5OejjLV65uESnUJQiEP1v
         hUp8MlMC4lWTtoNH1DbTRLzTji+LBgC6kVMhfyCf37jljEY9wcDDBsVAC9WM3psi7tg7
         v6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=1c3VrQ3FItr1tlZhwJQtIGHjV4vRn9xHIa6kZJ9nIxc=;
        b=iHjgBSiZQ1x7a9/MZJUSjNbA9pYws1ZjQjyTelLm/pchAvXTjjr0XawlAUBTrP5Bax
         m9NuhmSz/yWadTBXMwVlfbn9eJVmxNJWuH/4iipYH1hqbs2kKXm47zK+kzCEkF+5s1mR
         b7ydQtlKpmm6CUlJBEpqGp7gJPUO0laivCWU+wa+nAAvtzZ6r+NSryqVSi5/jV/eCDTV
         Webem6GeSlCAfREq0Uro4sV97mA5sBa32GqdnCYoGdqYWWmTgKyRyRYJh7vzIuztew9r
         Wu+unKMVq6Ha9D5PLS4iGP5Wg5k1DLTBUbLOwq9QPIuSoQuzNs4FeKiFlAscDiYbZ3Zt
         uSAg==
X-Gm-Message-State: AOAM533aXCvSU92t1n6JS5Im5pmD0Lu/X3MYT/48P6KHXJYtOAHEhOwX
        uM9gUbkAfFt51SeeLDo4fHmGSGrmZcTjG4R2RXxfJisB3DY7sYI=
X-Google-Smtp-Source: ABdhPJxmgP4jWmPz3uLlSNLgR3I1TzKQRWyBUxibakNf4A77O6mTWX6u7RjsU7kbIgC5PZEppaJdr85FcRRrMvhw6P8=
X-Received: by 2002:a05:6402:b83:: with SMTP id cf3mr8328900edb.12.1628188177841;
 Thu, 05 Aug 2021 11:29:37 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 5 Aug 2021 14:29:27 -0400
Message-ID: <CAHC9VhSW0zVR7wB9dxR-AkQAMK_H_fKQ75tTbMLomkBQzfzciw@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v5.14 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

One small SELinux fix for v5.14-rcX to fix a problem where an error
code was not being propagated back up to userspace when a bogus
SELinux policy is loaded into the kernel.  The patch passes the
selinux-testsuite and merges cleanly with your tree as of a few
minutes ago; please merge this for the next release.

Thanks,
-Paul

--
The following changes since commit d99cf13f14200cdb5cbb704345774c9c0698612d:

 selinux: kill 'flags' argument in avc_has_perm_flags() and avc_audit() (2021-0
6-11 13:11:45 -0400)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux
-pr-20210805

for you to fetch changes up to 4c156084daa8ee70978e4b150b5eb5fc7b1f15be:

 selinux: correct the return value when loads initial sids (2021-08-02 09:59:50
-0400)

----------------------------------------------------------------
selinux/stable-5.14 PR 20210805

----------------------------------------------------------------
Xiu Jianfeng (1):
     selinux: correct the return value when loads initial sids

security/selinux/ss/policydb.c | 10 ++++------
1 file changed, 4 insertions(+), 6 deletions(-)

-- 
paul moore
www.paul-moore.com
