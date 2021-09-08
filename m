Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDEA64038AF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 13:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349071AbhIHLXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 07:23:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232430AbhIHLXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 07:23:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A15961153;
        Wed,  8 Sep 2021 11:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631100158;
        bh=43QXOKS7fUsSTDp/qu8je+Na+H8oS3+/94gc6dT2CFI=;
        h=Date:From:To:Cc:Subject:From;
        b=YOXOCkR9o5SNn11L1Axy6Jh/F87BINHGNByo3pszbSFRV4W94IeLmboLMY5eWDkXe
         0cQ2R7tAHnCuYJPnAnxNcieRMg/K044gQTo2ZdXh4cGUUfijmvi9SOrszZuPorr30F
         zbCMqNLslFuAo79IJc9X3TcrJhoLfqbHBcSB/DlgEW10/uFy8yGuK2L0gofFivRqZQ
         UtDraM219qDNC/aWNjpa4KNVvrsHRlZUpfD17W8fVLLFrcCnMrXC1/l80e0jh4YUOV
         6jDCQB1UM36LxYC52uuxPsqFb3B94qNS9es3ymrQadBiFIgVaxNHEzxERlZkxz0poh
         phDv5cexrUtLw==
Date:   Wed, 8 Sep 2021 13:22:34 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Modules updates for v5.15
Message-ID: <YTic+hlkHGgdv6hY@p200300cbcf13dc003adeadfffec0265a.dip0.t-ipconnect.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-OS:   Linux p200300cbcf13dc003adeadfffec0265a.dip0.t-ipconnect.de
 5.13.8-1-default x86_64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The only main change I have for this round of updates is the modules
MAINTAINERS update. As I find myself with less time to devote to
upstream these days, Luis has kindly agreed to help maintain the
module loader, to eventually transition to being the primary
maintainer. Since Luis is already very involved upstream with
experience maintaining various areas of the kernel including the
kmod usermode helper, I think he is a great fit for this area of the
kernel.

Thank you,

Jessica

----
The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

   Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.15

for you to fetch changes up to ced75a2f5da71de5775fda44250e27d7b8024355:

   MAINTAINERS: Add Luis Chamberlain as modules maintainer (2021-08-03 13:24:40 +0200)

----------------------------------------------------------------
Modules updates for v5.15

Summary of modules changes for the 5.15 merge window:

- Add Luis Chamberlain as modules maintainer

- Fix for .ctors sections in module linker script

Signed-off-by: Jessica Yu <jeyu@kernel.org>

----------------------------------------------------------------
Jessica Yu (1):
       MAINTAINERS: Add Luis Chamberlain as modules maintainer

Reiner Huober (1):
       module: combine constructors in module linker script

  MAINTAINERS          | 1 +
  scripts/module.lds.S | 1 +
  2 files changed, 2 insertions(+)

