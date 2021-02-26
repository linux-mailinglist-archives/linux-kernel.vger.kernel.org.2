Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64949325D52
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 06:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhBZFvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 00:51:40 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:48770 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhBZFvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 00:51:37 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.2.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 1C21C200EF3;
        Fri, 26 Feb 2021 05:50:54 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id A48DE205E6; Fri, 26 Feb 2021 06:50:29 +0100 (CET)
Date:   Fri, 26 Feb 2021 06:50:29 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] pcmcia updates for v5.12
Message-ID: <YDiMJTK8eXxxCfSP@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

A lone PCMCIA change since commit e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62:

  Linux 5.11-rc2 (2021-01-03 15:55:30 -0800)

is available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git pcmcia-next

for you to fetch changes up to 4ce6b242b78d355ba899f1b16c6bfcd43df155a0:

  pcmcia: Switch to using the new API kobj_to_dev() (2021-01-04 08:16:00 +0100)


The patch contained in this pull request improves the use of the kobj API
in the core of the Linux PCMCIA subsystem.


Thanks,
	Dominik

----------------------------------------------------------------
Tian Tao (1):
      pcmcia: Switch to using the new API kobj_to_dev()

 drivers/pcmcia/cistpl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
