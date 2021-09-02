Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB94E3FE64B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 02:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242632AbhIBAKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 20:10:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232490AbhIBAKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 20:10:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 20D4060FE6;
        Thu,  2 Sep 2021 00:09:22 +0000 (UTC)
From:   Greg Ungerer <gerg@linux-m68k.org>
Subject: [git pull] m68knommu changes for v5.15
To:     torvalds@linux-foundation.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, gerg@kernel.org
Message-ID: <40f5e521-673a-dbfb-efff-62bdd8c01f49@linux-m68k.org>
Date:   Thu, 2 Sep 2021 10:09:20 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the m68knommu changes for v5.15.

As per the tag comment, changes include:

. flexcan platform support (for m5441x)
. fix CONFIG_ROMKERNEL linking
. fix compilation when CONFIG_ISA_DMA_API is set
. fix local ColdFire clk_enable() for NULL clk

Regards
Greg



The following changes since commit e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93:

   Linux 5.14-rc7 (2021-08-22 14:24:56 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v5.15

for you to fetch changes up to db87db65c1059f3be04506d122f8ec9b2fa3b05e:

   m68knommu: only set CONFIG_ISA_DMA_API for ColdFire sub-arch (2021-08-23 08:40:05 +1000)

----------------------------------------------------------------
m68knommu: collection of fixes for 5.15

. flexcan platform support (for m5441x)
. fix CONFIG_ROMKERNEL linking
. fix compilation when CONFIG_ISA_DMA_API is set
. fix local ColdFire clk_enable() for NULL clk

----------------------------------------------------------------
Angelo Dureghello (2):
       m68k: stmark2: update board setup
       m68k: m5441x: add flexcan support

Arnd Bergmann (1):
       m68knommu: only set CONFIG_ISA_DMA_API for ColdFire sub-arch

Dan Carpenter (1):
       m68k: coldfire: return success for clk_enable(NULL)

Randy Dunlap (1):
       m68k/nommu: prevent setting ROMKERNEL when ROM is not set

  arch/m68k/Kconfig.bus             |  2 +-
  arch/m68k/Kconfig.machine         |  1 +
  arch/m68k/coldfire/clk.c          |  2 +-
  arch/m68k/coldfire/device.c       | 44 +++++++++++++++++++++++++++++++++++++++
  arch/m68k/coldfire/m5441x.c       |  8 +++----
  arch/m68k/coldfire/stmark2.c      |  6 ++++--
  arch/m68k/include/asm/m5441xsim.h | 19 +++++++++++++++++
  7 files changed, 74 insertions(+), 8 deletions(-)
