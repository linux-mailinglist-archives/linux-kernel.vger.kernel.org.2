Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522C33FC565
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 12:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240890AbhHaKEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 06:04:34 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:53108
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240676AbhHaKEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 06:04:34 -0400
Received: from wittgenstein.fritz.box (i577BC18B.versanet.de [87.123.193.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 58DF53F070;
        Tue, 31 Aug 2021 10:03:38 +0000 (UTC)
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] sys fixes
Date:   Tue, 31 Aug 2021 12:03:26 +0200
Message-Id: <20210831100326.2298176-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

/* Summary */
This contains a single fix to set_user() which aligns permission checks with
the corresponding fork() codepath. Noone involved in this could come up with a
reason for the difference. A capable caller can already circumvent the check
when they fork where the permission checks are already for the relevant
capabilities in addition to also allowing to exceed nproc when it is the init
user. Apply the same logic to set_user().

(In case any question come up I'll be on vacation next week so responding might
 take a while.)

/* Testing */
All patches are based on v5.14-rc5 and have been sitting in linux-next. No
build failures or warnings were observed. All old and new tests are passing.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with current
mainline.

The following changes since commit 36a21d51725af2ce0700c6ebcb6b9594aac658a6:

  Linux 5.14-rc5 (2021-08-08 13:49:31 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/kernel.sys.v5.15

for you to fetch changes up to 2863643fb8b92291a7e97ba46e342f1163595fa8:

  set_user: add capability check when rlimit(RLIMIT_NPROC) exceeds (2021-08-12 14:54:25 +0200)

Please consider pulling these changes from the signed kernel.sys.v5.15 tag.

Thanks!
Christian

----------------------------------------------------------------
kernel.sys.v5.15

----------------------------------------------------------------
Ran Xiaokai (1):
      set_user: add capability check when rlimit(RLIMIT_NPROC) exceeds

 kernel/sys.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
