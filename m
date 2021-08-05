Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFB03E0E40
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 08:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbhHEGVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 02:21:10 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:50698 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhHEGVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 02:21:10 -0400
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.2.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 70C88201243;
        Thu,  5 Aug 2021 06:20:55 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 9EE0220694; Thu,  5 Aug 2021 08:20:41 +0200 (CEST)
Date:   Thu, 5 Aug 2021 08:20:41 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, zheyuma97@gmail.com
Subject: [GIT PULL] pcmcia bugfix for v5.14
Message-ID: <YQuDOeJ7QQ7g8sqj@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

the following change since commit 2734d6c1b1a089fb593ef6a23d4b70903526fe0c:

  Linux 5.14-rc2 (2021-07-18 14:13:49 -0700)

is available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git pcmcia-next

for you to fetch a change up to e39cdacf2f664b09029e7c1eb354c91a20c367af:

  pcmcia: i82092: fix a null pointer dereference bug (2021-07-23 08:08:54 +0200)

Zheyu Ma found and fixed a null pointer dereference bug in the device driver
for the i82092 card reader.

Thanks,
	Dominik

----------------------------------------------------------------
Zheyu Ma (1):
      pcmcia: i82092: fix a null pointer dereference bug

 drivers/pcmcia/i82092.c | 1 +
 1 file changed, 1 insertion(+)
