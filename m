Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1B33B6A1A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 23:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237853AbhF1VVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 17:21:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237034AbhF1VVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 17:21:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACF5E61CB4;
        Mon, 28 Jun 2021 21:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624915150;
        bh=cr8ezwjZnHWEljCFagoWyYqk9V6DhvaEN7pTu221zkU=;
        h=Date:From:To:Cc:Subject:From;
        b=t/UmKJ9+ImMGHlthBh+YQAbYEKXqvLBzb4mIm1moMq3ig/njy53YwQD4XmnYOTQdz
         afddWoF12QF2suI1tvpjRh+9D6rm7jrI1DBAXd32JR8kU3sWw9NXiLvo96EOeLaITo
         x5JzHUUso/p2DSQp0mET6OTxE+3NpIZlBwKzyRwAQVLc6WT6dOD8f6PRglHv65fhyE
         rAhUcyF1Xv5vsPZeMe1vnlnO/kOs6jUJiCyJHG1kIYiaUtFoS0A+DikQY7WJa7DLgi
         L7Ydr/PV6QBLRExT8aOdbDCtQabfLR6Zw1CZ4/jemtClFXzsk2ubR5oXSjXpSXvEUj
         fAOHG/R+Vw+Dw==
Date:   Mon, 28 Jun 2021 16:20:59 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [GIT PULL] array-bounds fixes for 5.14-rc1
Message-ID: <20210628212059.GA11158@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d07f6ca923ea0927a1024dfccafc5b53b61cfecc:

  Linux 5.13-rc2 (2021-05-16 15:27:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/array-bounds-fixes-5.14-rc1

for you to fetch changes up to 13dfead49db07225335d4f587a560a2210391a1a:

  media: siano: Fix out-of-bounds warnings in smscore_load_firmware_family2() (2021-06-07 14:11:47 -0500)

----------------------------------------------------------------
array-bounds fixes for 5.14-rc1

Hi Linus,

Please, pull the following patch that fixes an out-of-bounds
warning in the media subsystem. This is part of the ongoing
efforts to globally enable -Warray-bounds.

Thanks!

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      media: siano: Fix out-of-bounds warnings in smscore_load_firmware_family2()

 drivers/media/common/siano/smscoreapi.c | 22 +++++++++-------------
 drivers/media/common/siano/smscoreapi.h |  4 ++--
 2 files changed, 11 insertions(+), 15 deletions(-)
