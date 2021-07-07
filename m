Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCD63BE9BA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 16:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhGGOaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 10:30:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:42744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231737AbhGGO37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 10:29:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0A9D6199E;
        Wed,  7 Jul 2021 14:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625668039;
        bh=xwY0q1sjDuTRqB0UdUtznz1KoGnX54Ytx1rs+CyjLs8=;
        h=Date:From:To:Cc:Subject:From;
        b=TwVHyfS0KwM++DxyMITgbhz5gkWIbeCTAxwKoTDwysAn5L3KiS6aOlpyzgGXw5YMO
         uuYCxSq55EMSVy8rolycFxaJ/IhM6uT21l8jWjeNWdE3ngPzsm3J/S+S8AuPv4G9Cf
         Wp6y9QYh86NimqrReJJS9og0ITEZq+cf24bCnxkUR6hqYDUCA88yI7gbh36JtNB3kX
         fmacGXjrUxaIrUD6Sawi3ZEAsKRGg44qitp5rPqHFCClfwRESdnx0hyCXG6S8qxoT1
         nOzARHtqRLnzsmT0mne/9ZwnP2ENaFqlvEw7vATjcETvT4ugYnNY4DOIDmLdDMh8pv
         825u255LpDmfQ==
Date:   Wed, 7 Jul 2021 16:27:15 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Modules updates for v5.14
Message-ID: <YOW5w/4Gr3IPHj8c@p200300cbcf044300404ca642de146c7c.dip0.t-ipconnect.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull below to receive modules updates for the v5.14 merge window.
Only two minor patches this time, one cleanup patch and one kallsyms fix.

Thank you,

Jessica

---
The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

   Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.14

for you to fetch changes up to 2c0f0f3639562d6e38ee9705303c6457c4936eac:

   module: correctly exit module_kallsyms_on_each_symbol when fn() != 0 (2021-05-26 14:55:45 +0200)

----------------------------------------------------------------
Modules updates for v5.14

Summary of modules changes for the 5.14 merge window:

- Fix incorrect logic in module_kallsyms_on_each_symbol()

- Fix for a Coccinelle warning

Signed-off-by: Jessica Yu <jeyu@kernel.org>

----------------------------------------------------------------
Jon Mediero (1):
       module: correctly exit module_kallsyms_on_each_symbol when fn() != 0

zhouchuangao (1):
       kernel/module: Use BUG_ON instead of if condition followed by BUG

  kernel/module.c | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)
