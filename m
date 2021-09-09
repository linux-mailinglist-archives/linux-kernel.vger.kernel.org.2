Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9A1404209
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 02:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347801AbhIIAJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 20:09:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235595AbhIIAI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 20:08:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49C1661074;
        Thu,  9 Sep 2021 00:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631146067;
        bh=JToiE/PvHZiWLiE6jJBXtvk44C1fCas3I68bTFErSrU=;
        h=Date:From:To:Cc:Subject:From;
        b=mdm4qfrqKdXGhcRc53f25M5x492as8/DtfmhHBqerPLj0ihHTpyKCxhT5jSrm7OkM
         CTy6DNGnE6CEs3o++ynnotzanGL6trzvBaA52GnMcgqoEdKSRTXen9kztS6HUAOLwg
         c5ecB4NLs1bbRbh4qV841yc0cZbRUSTEALu0r27GbCXmGgzILFagzleHbCk3QDt2vz
         Q8kTihGstT1CTa0vi6wvbRX5gtfHbxxWGWuM/JvEQ9+3BZZ1zMrOKjgSoiYcizQl57
         H3hp4cIU4qpGD96pKq2VdkFabO9G0Rh+PrIineavHgplURh7wteOyfRHzAq23FNuNc
         O5OVOLFdA9OPg==
Date:   Thu, 9 Sep 2021 02:07:30 +0200
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jinchao Wang <wjc@cdjrlc.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars Poeschel <poeschel@lemonage.de>,
        Ralf Schlatterbeck <rsc@runtux.com>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] auxdisplay for v5.15-rc1
Message-ID: <20210909000730.GA23567@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these improvements for auxdisplay.

These were sitting in my queue for a long time.

(And apologies for the late PR)

Cheers,
Miguel

The following changes since commit 614124bea77e452aa6df7a8714e8bc820b489922:

  Linux 5.13-rc5 (2021-06-06 15:47:27 -0700)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.15-rc1

for you to fetch changes up to 24ebc044c72ee6e88dc902a0041bac672f012537:

  auxdisplay: Replace symbolic permissions with octal permissions (2021-07-16 07:42:35 +0200)

----------------------------------------------------------------
An assortment of improvements for auxdisplay:

  - Replace symbolic permissions with octal permissions (Jinchao Wang)

  - ks0108: Switch to use module_parport_driver() (Andy Shevchenko)

  - charlcd: Drop unneeded initializers and switch to C99 style (Andy Shevchenko)

  - hd44780: Fix oops on module unloading (Lars Poeschel)

  - Add I2C gpio expander example (Ralf Schlatterbeck)

----------------------------------------------------------------
Andy Shevchenko (2):
      auxdisplay: charlcd: Drop unneeded initializers and switch to C99 style
      auxdisplay: ks0108: Switch to use module_parport_driver()

Jinchao Wang (1):
      auxdisplay: Replace symbolic permissions with octal permissions

Lars Poeschel (1):
      auxdisplay: hd44780: Fix oops on module unloading

Ralf Schlatterbeck (1):
      auxdisplay: Add I2C gpio expander example

 .../bindings/auxdisplay/hit,hd44780.yaml           | 31 +++++++++++++++++++++-
 drivers/auxdisplay/cfag12864b.c                    |  2 +-
 drivers/auxdisplay/charlcd.c                       |  4 +--
 drivers/auxdisplay/hd44780.c                       |  2 +-
 drivers/auxdisplay/ks0108.c                        | 18 +++----------
 5 files changed, 36 insertions(+), 21 deletions(-)
