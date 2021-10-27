Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6315E43CCCB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 16:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239206AbhJ0OzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 10:55:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:55478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237296AbhJ0OzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 10:55:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C683460F21;
        Wed, 27 Oct 2021 14:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635346375;
        bh=4rh3R5i7kahTMHdRJpaS+YjKGx3i0TD+40QeIK22NS0=;
        h=From:To:Cc:Subject:Date:From;
        b=fCEeE9967IvrFwc0EwYpy17DDGaJlAWHn+GXGOCCXAIuzYQ9SVRst10LnqhqakaXF
         6If8pnjtNVQ2ObXlgnKx21aoWW0CpJCuihF7U/7x+yrGrzYL7gh6iIK1KH70e4jsB8
         d5pUSjtSpoolgDSEfNXFEYwCmWJ2Lji8/QQ8Bu6mUJDB01GO+pws8uJ0/RbqIn185+
         bWcnMomWFfeQCikPPBRbw8u+QGCEA9BTdWKrzGLFcwU5cSQURc/ZpD/8p18eNOhsg4
         FLWnRSAUmAcmBvkp9XtZE7kDxjo0rHpXCef037hu+mO1fk0qnnREAnpm8/6Nfs1i9N
         ZVPkqlEG29Q5Q==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] NIOS2: fix for v5.15, part 3
Date:   Wed, 27 Oct 2021 09:52:53 -0500
Message-Id: <20211027145253.454811-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this fix for NIOS2 for v5.15.

Thanks,

Dinh

The following changes since commit 3906fe9bb7f1a2c8667ae54e967dc8690824f4ea:

  Linux 5.15-rc7 (2021-10-25 11:30:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/nios2_fixes_for_v5.15_part3

for you to fetch changes up to 4a089e95b4d6bb625044d47aed0c442a8f7bd093:

  nios2: Make NIOS2_DTB_SOURCE_BOOL depend on !COMPILE_TEST (2021-10-27 09:29:07 -0500)

----------------------------------------------------------------
NIOS2 fixes for v5.15, part 3
- Fix a build error for allmodconfig

----------------------------------------------------------------
Guenter Roeck (1):
      nios2: Make NIOS2_DTB_SOURCE_BOOL depend on !COMPILE_TEST

 arch/nios2/platform/Kconfig.platform | 1 +
 1 file changed, 1 insertion(+)
