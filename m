Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A44445AEC4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 22:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237394AbhKWVzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 16:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbhKWVzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 16:55:51 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4273C06173E
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 13:52:42 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id x15so1153473edv.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 13:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=zFcNkIoq5muaZLvXLLeD4MHIH39egtBeCwO9IdlTd4E=;
        b=OUP1+BWbRR1b3WBE5EPf7wawaImps7sZtcKoV3aIlzMbRSpLTdQG3C6V5eAUdnQz/9
         2CN3GYtDOAcZGPN1DWHeKieWuvM6fsscrVPn1tpZheCvVPW62pegPbUdk8zxulX8OHE3
         ++cSeYIku3cn92qeP43g0JPUX1hlMW9eNNBuGCkMbpL4fTsUVUIf/j+21Kynbiml+gOP
         aDrfpp7FPHb3uc82Jz5aNyhzzm9/HP8WzBu6Dd6KXdneq3I6P68VNltjQQj2x1pc7eb2
         M7DsZ6O1IehRqJkYGU7CbSejCoRh0AdUJGhOGDZmp0c2BO7n69Szl8W8vzlj8XfTpIdk
         9fmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=zFcNkIoq5muaZLvXLLeD4MHIH39egtBeCwO9IdlTd4E=;
        b=HRj896ICiayV+S3xLbrsq5udTWn0k8Nf317bC1hBnnJ8AXWzjOCE8H7XbbiiWmcfEP
         AoGS87vQ5+ASz5eS8WYJSInBR8cJOUBZZhqREMUQL1RUMvqPPpFD/Z/4zjKJm2fbbymg
         Gc+FYkEFcsE4WkW18rwZ0b//NFLi0Z0TH70nDMFgcGnwZQSR0plBYzzQ+OiwtB1s87/G
         rNCdbB6UdzN8IJgbOmYsSAbNA8bqFou/1ZjFuVpU97iph603vq1nJs5JOMERClFliSqA
         KyNierj86PbfjEX6pCAonws/vknQsmWjgDhKRYXO5EY/Y87USNjFf4MQH+WDUgyUTLvt
         v7kQ==
X-Gm-Message-State: AOAM5330gEaMdmwwo6x6VmJbKxL6IZL6T0BC097845ghBmRdL5DN4cNk
        1GmuTqJylit/btxKLVlIhbeIGqsPyXW3i79dxz+H
X-Google-Smtp-Source: ABdhPJwTLLnHLhScwB6svIWfEht4EV8Tpcy6SZUmpF3lSj+DYO8/zQWjYkw6wj7xPdoCdQ5T73OqDVj5c5I9dtLs4KQ=
X-Received: by 2002:a17:907:868f:: with SMTP id qa15mr12283769ejc.187.1637704361326;
 Tue, 23 Nov 2021 13:52:41 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 23 Nov 2021 16:52:30 -0500
Message-ID: <CAHC9VhS2Hqg2rvS=Fbkpj++HEs5Cxf=4Xcmd7kdgvOykY1Os+A@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v5.16 (#2)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

A small SELinux fix for v5.16.  As usual the commit description has
more detail, but it's basically a fix to make sure things are handled
correctly when an allocation fails; please merge.

Thanks,
-Paul

--
The following changes since commit 32a370abf12f82c8383e430c21365f5355d8b288:

 net,lsm,selinux: revert the security_sctp_assoc_established() hook
   (2021-11-12 12:07:02 -0500)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20211123

for you to fetch changes up to dc27f3c5d10c58069672215787a96b4fae01818b:

 selinux: fix NULL-pointer dereference when hashtab allocation fails
   (2021-11-19 16:11:39 -0500)

----------------------------------------------------------------
selinux/stable-5.16 PR 20211123

----------------------------------------------------------------
Ondrej Mosnacek (1):
     selinux: fix NULL-pointer dereference when hashtab allocation fails

security/selinux/ss/hashtab.c | 17 ++++++++++++-----
1 file changed, 12 insertions(+), 5 deletions(-)

-- 
paul moore
www.paul-moore.com
