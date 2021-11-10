Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0BF444CE05
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 00:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbhKJXwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 18:52:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:60804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234279AbhKJXwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 18:52:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C57E61213;
        Wed, 10 Nov 2021 23:49:17 +0000 (UTC)
From:   Greg Ungerer <gerg@linux-m68k.org>
Subject: [git pull] m68knommu changes for v5.16
To:     torvalds@linux-foundation.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, gerg@kernel.org
Message-ID: <318e7461-6fec-a6ac-5c88-e17b6fb914cc@linux-m68k.org>
Date:   Thu, 11 Nov 2021 09:49:14 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the m68knommu changes for v5.16.

Only 2 changes. One removes the now unused CONFIG_MCPU32 symbol.
The other sets a default for the CONFIG_MEMORY_RESERVE config symbol
(this aids scripting and other automation) so you don't interactively get
asked for a value at configure time.

Regards
Greg



The following changes since commit 3906fe9bb7f1a2c8667ae54e967dc8690824f4ea:

   Linux 5.15-rc7 (2021-10-25 11:30:31 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v5.16

for you to fetch changes up to 6dbe88e93c351a6cf5b7c70850d7a1a7f67d83ab:

   m68knommu: Remove MCPU32 config symbol (2021-10-26 08:46:27 +1000)

----------------------------------------------------------------
Fixes include:
. remove unused CONFIG_MCPU32 symbol
. default CONFIG_MEMORY_RESERVE value (for scripting)

----------------------------------------------------------------
Geert Uytterhoeven (1):
       m68knommu: Remove MCPU32 config symbol

Randy Dunlap (1):
       m68k: set a default value for MEMORY_RESERVE

  arch/m68k/Kconfig.cpu          | 11 -----------
  arch/m68k/Kconfig.machine      |  1 +
  arch/m68k/include/asm/bitops.h |  2 +-
  3 files changed, 2 insertions(+), 12 deletions(-)
