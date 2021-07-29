Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C5F3D9B98
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 04:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbhG2CJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 22:09:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233162AbhG2CJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 22:09:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D52560462;
        Thu, 29 Jul 2021 02:09:26 +0000 (UTC)
From:   Greg Ungerer <gerg@linux-m68k.org>
Subject: [git pull] m68knommu changes for v5.14-rc4
To:     torvalds@linux-foundation.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, gerg@kernel.org
Message-ID: <5e52d59b-09df-be5a-8be9-459949eb16e2@linux-m68k.org>
Date:   Thu, 29 Jul 2021 12:09:25 +1000
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

Please pull the m68knommu git tree, for-linus branch.
A single compile time fix.

Regards
Greg



The following changes since commit ff1176468d368232b684f75e82563369208bc371:

   Linux 5.14-rc3 (2021-07-25 15:35:14 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git for-linus

for you to fetch changes up to 9f66861181e64dc192bea136da6c91528910002e:

   m68k/coldfire: change pll var. to clk_pll (2021-07-26 08:41:38 +1000)

----------------------------------------------------------------
Randy Dunlap (1):
       m68k/coldfire: change pll var. to clk_pll

  arch/m68k/coldfire/m525x.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)
