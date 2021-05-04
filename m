Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191A33723D4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 02:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhEDAPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 20:15:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhEDAPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 20:15:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89E8F610E6;
        Tue,  4 May 2021 00:14:47 +0000 (UTC)
From:   Greg Ungerer <gerg@linux-m68k.org>
Subject: [git pull] m68knommu changes for v5.13
To:     torvalds@linux-foundation.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, gerg@kernel.org
Message-ID: <b2180862-6e08-d813-ac65-83052f87be1c@linux-m68k.org>
Date:   Tue, 4 May 2021 10:14:45 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the m68knommu tree for-next branch.

There is a fix for interrupt number range checking for the ColdFire
SIMR interrupt controller.

The other changes are for the binfmt_flat binary loader. To allow RISC-V
nommu support it needs to be able to accept flat binaries that have no
gap between the text and data sections.

Regards
Greg



The following changes since commit bf05bf16c76bb44ab5156223e1e58e26dfe30a88:

   Linux 5.12-rc8 (2021-04-18 14:45:32 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v5.13

for you to fetch changes up to 6b3788e5fb8041211ac2fa7c818ca9010e976a74:

   m68k: coldfire: fix irq ranges (2021-04-23 15:33:40 +1000)

----------------------------------------------------------------
M68knommu fixes include:

. fix interrupt range check for ColdFire SIMR interrupt controller
. add support for gapless sections flat format binary (needed by RISC-V)

----------------------------------------------------------------
Angelo Dureghello (1):
       m68k: coldfire: fix irq ranges

Damien Le Moal (2):
       binfmt_flat: allow not offsetting data start
       riscv: Disable data start offset in flat binaries

  arch/m68k/coldfire/intc-simr.c | 12 ++++++------
  arch/riscv/Kconfig             |  1 +
  fs/Kconfig.binfmt              |  3 +++
  fs/binfmt_flat.c               | 18 +++++++++++++-----
  4 files changed, 23 insertions(+), 11 deletions(-)
