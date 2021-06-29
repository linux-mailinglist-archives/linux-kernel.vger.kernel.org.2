Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C82A3B7A7E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 00:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbhF2Wo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 18:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbhF2Wo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 18:44:26 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF507C061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 15:41:58 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id hq39so653685ejc.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 15:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=UdLleetRcAut/EhT07OFhViYCDmhcaWl/jLM2clj0do=;
        b=sFyDUv4DcdJzx72z8HliMSxd42YVU9w76tids4SMakah2/MDtVXGDAFWoKqqV7Ybyg
         4s5yfXLcL5MGS+F3Nt/HGgt1SaqTHlJZS4DfIbG4x64D+PYOwYftqp90rVuP1rmYF5cq
         evCPgdN0vWG3NWENYvaqd4uGiZSX0izHVumk0NcENGwH9CWxJRT9Uhw590dc45bA29Yq
         oKUHoDFe+706hark6VICSAWGQ+pG3D2gGWFL+ODByWhrDto5coA4cFRZ7g/TTBLiWilT
         YfxKiRQpYB0t8C7sVtDCLZZ+F7TvuUMLp9FsX+bVStMCs2qlRhINhAOtb4BGzSHUmJW7
         jTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=UdLleetRcAut/EhT07OFhViYCDmhcaWl/jLM2clj0do=;
        b=e6Eaw5z++9VuZnbvaMw75PRaNaz0XaIzI3GLAJv0Y294ClA4QFFWIvx9V3i5QueIQ8
         2XNvw6D4QGCWydTnp+2ph1ssfjyQM97fzi51UVKpR65ZByxVWyEcIR0pEzy47r+SsRFj
         22zkJk0uRHsUpdKXSA2FK6ly9vm8eh9t0B+egwUtP1Kcd1eyqaJj5MItdS1rVLTx0goQ
         c53mQnra4fed8H8rlaIeKV9+6URJeh9kM0BKrvkcU2MQtCs+B0CHNefX5lOgrWLfF3xx
         vkqmPqnsoRg8TWV8jXlfzbmEUz2oEsyxqHXjDOC8LoOFSqCX056HxeQddNDorC5nWZEN
         YRqQ==
X-Gm-Message-State: AOAM532ZHThDfTlCMUJJoWgWPJSJCqOPTUd7Xsn//jRyV2MT+SB6fzqj
        cFA7EJLBIw9yL35H/Mo7EJNRZYW1VPBZgUKsBxHp
X-Google-Smtp-Source: ABdhPJzcbwuTh8/hOY03Pv7JPGdy+W54HfuVG8wScOokVEpCoh5/H/FcLrm769WiyTi7HqGQH1vQ7C/GG8jpP5IQ51Y=
X-Received: by 2002:a17:907:9603:: with SMTP id gb3mr1046636ejc.398.1625006517153;
 Tue, 29 Jun 2021 15:41:57 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 29 Jun 2021 18:41:46 -0400
Message-ID: <CAHC9VhRu2eydfdx4kYTzLC37pzi=RBpgJM0PCCyw_=XHRSvvrg@mail.gmail.com>
Subject: [GIT PULL] Audit patches for v5.14
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Another merge window, another small audit pull request.  Four patches
in total: one is cosmetic, one removes an unnecessary initialization,
one renames some enum values to prevent name collisions, and one
converts list_del()/list_add() to list_move().  None of these are
earth shattering and all pass the audit-testsuite tests while merging
cleanly on top of your tree from earlier today.  Please merge these
patches for v5.14.

Thanks,
-Paul

--
The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

 Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
   tags/audit-pr-20210629

for you to fetch changes up to 0ecc617858fce305bedcf735eb18a46cb7e9921f:

 audit: remove unnecessary 'ret' initialization (2021-06-11 13:21:28 -0400)

----------------------------------------------------------------
audit/stable-5.14 PR 20210629

----------------------------------------------------------------
Austin Kim (1):
     audit: remove unnecessary 'ret' initialization

Baokun Li (1):
     audit: Use list_move instead of list_del/list_add

Roni Nevalainen (1):
     audit: add blank line after variable declarations

Sergey Nazarov (1):
     audit: Rename enum audit_state constants to avoid AUDIT_DISABLED
       redefinition

Zhen Lei (1):
     audit: remove trailing spaces and tabs

include/uapi/linux/audit.h |  4 +--
kernel/audit.h             | 10 ++++----
kernel/audit_tree.c        | 12 +++------
kernel/auditsc.c           | 63 ++++++++++++++++++++++++++++--------------
security/lsm_audit.c       |  1 -
5 files changed, 53 insertions(+), 37 deletions(-)

-- 
paul moore
www.paul-moore.com
