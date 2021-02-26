Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF05325BEA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 04:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhBZDYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 22:24:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:34982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229460AbhBZDYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 22:24:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2404364E7A;
        Fri, 26 Feb 2021 03:23:50 +0000 (UTC)
From:   Greg Ungerer <gerg@linux-m68k.org>
Subject: [git pull] m68knommu changes for v5.12
To:     torvalds@linux-foundation.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <66454ec0-9ca9-b4f5-1cd4-81204b2d120b@linux-m68k.org>
Date:   Fri, 26 Feb 2021 13:23:48 +1000
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

Please pull the m68knommu changes for v5.12.

Only a single change. NULL parameter check in the local ColdFire
clocking code.

Regards
Greg



The following changes since commit 92bf22614b21a2706f4993b278017e437f7785b3:

   Linux 5.11-rc7 (2021-02-07 13:57:38 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v5.12

for you to fetch changes up to c1fb1bf64bb63a1d6ae3311a9a3581a527c1f185:

   m68k: let clk_enable() return immediately if clk is NULL (2021-02-08 08:15:17 +1000)

----------------------------------------------------------------
m68knommu: updates for v5.12

- NULL clk parameter check in clk_enable()

----------------------------------------------------------------
Defang Bo (1):
       m68k: let clk_enable() return immediately if clk is NULL

  arch/m68k/coldfire/clk.c | 4 ++++
  1 file changed, 4 insertions(+)
