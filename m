Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF6044F000
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 00:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbhKLXWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 18:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbhKLXWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 18:22:07 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B7EC0613F5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 15:19:15 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id z21so43711445edb.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 15:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=PzfB2r9Lts83D+w1nh0/7Xk65VCP1/bBRA3N7CtjrYI=;
        b=LCt7VcLC+QrccI1OS6B4rH/tpoNKiTgVMgh07bXtFgeDmfUYoX2cRD0CD8mF2UbC4F
         H38YZf66EekQfZLxvqxtL1KADuSEt+7cdxnfAs4dFHETAK+a/bVy/iuEalo4wBV24CCu
         CU2jsmN2s66d188G+1P7ZHG4fKlIkLUrJ1344TEKCqmTYD2W4ytssAyOF91SvzMbwGhY
         D1leiipIeqZi2UH9CrqCFy56BhJZQJ++f+C4IxkugikdROddfSFR3KLudyC1cnuWpJ69
         qHhTJOLFRk7W+XpvDAWvb8ULWskl6u24LwKIAeFa0zA9FGjHGRQ7nGMdF+iX3NM8LW0t
         NsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=PzfB2r9Lts83D+w1nh0/7Xk65VCP1/bBRA3N7CtjrYI=;
        b=7LLLdAEh60AH3Xof2C6P3H93HeXk4Q2YCujMgGgPndXUORSQWrTthrZjMcJb4ERjVx
         7041+c42JeB4QJwQHaVb2FK/j72+h+75zVEKqLxAPSMmqPtdy+J6Y5u93uQPCm8926/+
         LrIZ7G8P7GIiEg5bAESMjtG3ff5CIaE3ZnFRKew6qx/ZUqMJwfYjKPG0kAg/ywhap8kh
         QQcmGgwAXedD6uReHH6oooZD1Fsggg613WCC95jU+OEeB+tzuQ73T5b+Gzhy4YXZc6QG
         z431OW/wsGWkIMeamIxlEBOxqO2h0vq74G/8W9DMKKjZa56SNEwOF45dezZQtl1v/g6h
         OjhQ==
X-Gm-Message-State: AOAM532LkFFopfunP4DNiYmOpejPSTXHSMz6b66DaowKOrPl4cX2NyVe
        0imnZKbNpcBkIf9jFFqvreuODDk81oL5IsLFLQ4sUSRhEtfC
X-Google-Smtp-Source: ABdhPJwlh9JjMWtJMDz75t58iKQ/UrL60fWqtv+4iD58UMzywsqCd7ezf3/QpGC1srSkk/JWEuyeAVj0gqIUgbcdbhk=
X-Received: by 2002:a17:907:7601:: with SMTP id jx1mr23713291ejc.69.1636759154232;
 Fri, 12 Nov 2021 15:19:14 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 12 Nov 2021 18:19:03 -0500
Message-ID: <CAHC9VhQVodwxiEheuUM=XgwdytuCE0boQ-h4xt=SqOTHv0PffA@mail.gmail.com>
Subject: [GIT PULL] SELinux fix / revert for v5.16 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Unfortunately I need to request a revert for two LSM/SELinux patches
that came in via the network tree.  The two patches in question add a
new SCTP/LSM hook as well as an SELinux implementation of that LSM
hook.  The short version of "why?" is in the commit description of the
revert patch, but I'll copy-n-paste the important bits below to save
some time for the curious:

   ... Unfortunately these two patches were merged
   without proper review (the Reviewed-by and Tested-by
   tags from Richard Haines were for previous revisions
   of these patches that were significantly different)
   and there are outstanding objections from the SELinux
   maintainers regarding these patches.

   Work is currently ongoing to correct the problems
   identified in the reverted patches, as well as others
   that have come up during review, but it is unclear at
   this point in time when that work will be ready for
   inclusion in the mainline kernel.  In the interest of
   not keeping objectionable code in the kernel for
   multiple weeks, and potentially a kernel release, we
   are reverting the two problematic patches.

As usual with these things there is plenty of context to go with this
and I'll try to do my best to provide that now.  This effort started
with a report of SCTP client side peel-offs not working correctly with
SELinux, Ondrej Mosnacek put forth a patch which he believed properly
addressed the problem but upon review by the netdev folks Xin Long
described some additional issues and submitted an improved patchset
for review.  The SELinux folks reviewed Xin Long's initial patchset
and suggested some changes which resulted in a second patchset (v2)
from Xin Long; this is the patchset that is currently in your tree.
Unfortunately this v2 patchset from Xin Long was merged before it had
spent even just 24 hours on the mailing lists during the early days of
the merge window, a time when many of us were busy doing verification
of the newly released v5.15 kernel as well final review and testing of
our v5.16 pull requests.  Making matters worse, upon reviewing the v2
patchset there were both changes which were found objectionable by
SELinux standards as well as additional outstanding SCTP/SELinux
interaction problems.  At this point we did two things: resumed
working on a better fix for the SCTP/SELinux issue(s) - thank you
Ondrej - and we asked the networking folks to revert the v2 patchset.

The revert request was obviously rejected, but at the time I believed
it was just going to be an issue for linux-next; I wasn't expecting
something this significant that was merged into the networking tree
during the merge window to make it into your tree in the same window,
yet as of last night that is exactly what happened.  While we continue
to try and resolve the SCTP/SELinux problem I am asking once again to
revert the v2 patches and not ship the current
security_sctp_assoc_established() hook in a v5.16-rcX kernel.  If I
was confident that we could solve these issues in a week, maybe two, I
would refrain from asking for the revert but our current estimate is
for a minimum of two weeks for the next patch revision.  With the
likelihood of additional delays due to normal patch review follow-up
and/or holidays it seems to me that the safest course of action is to
revert the patch both to try and keep some objectionable code out of a
release kernel and limit the chances of any new breakages from such a
change.  While the SCTP/SELinux code in v5.15 and earlier has
problems, they are known problems, and I'd like to try and avoid
creating new and different problems while we work to fix things
properly.

One final thing to mention: Xin Long's v2 patchset consisted of four
patches, yet this revert is for only the last two.  We see the first
two patches as good, reasonable, and not likely to cause an issue.  In
an attempt to create a cleaner revert patch we suggest leaving the
first two patches in the tree as they are currently.

Thanks,
-Paul

--
The following changes since commit 5833291ab6de9c3e2374336b51c814e515e8f3a5:

 Merge tag 'pci-v5.16-fixes-1' of
   git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci
   (2021-11-11 15:10:18 -0800)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20211112

for you to fetch changes up to 32a370abf12f82c8383e430c21365f5355d8b288:

 net,lsm,selinux: revert the security_sctp_assoc_established() hook
   (2021-11-12 12:07:02 -0500)

----------------------------------------------------------------
selinux/stable-5.16 PR 20211112

----------------------------------------------------------------
Paul Moore (1):
     net,lsm,selinux: revert the security_sctp_assoc_established() hook

Documentation/security/SCTP.rst | 22 ++++++++++++----------
include/linux/lsm_hook_defs.h   |  2 --
include/linux/lsm_hooks.h       |  5 -----
include/linux/security.h        |  7 -------
net/sctp/sm_statefuns.c         |  2 +-
security/security.c             |  7 -------
security/selinux/hooks.c        | 14 +-------------
7 files changed, 14 insertions(+), 45 deletions(-)

-- 
paul moore
www.paul-moore.com
