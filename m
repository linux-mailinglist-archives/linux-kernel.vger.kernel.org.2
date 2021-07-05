Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE423BB498
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 03:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbhGEBSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 21:18:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229549AbhGEBSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 21:18:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4412611F2;
        Mon,  5 Jul 2021 01:15:34 +0000 (UTC)
From:   Greg Ungerer <gerg@linux-m68k.org>
Subject: [git pull] m68knommu changes for v5.14
To:     torvalds@linux-foundation.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, gerg@kernel.org
Message-ID: <f1a49aed-3498-ee1c-a29c-77f900970308@linux-m68k.org>
Date:   Mon, 5 Jul 2021 11:15:32 +1000
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

Please pull the m68knommu changes for v5.14.

Only a single fix, for a build failure picked up by the kernel build robot.

Regards
Greg



The following changes since commit 13311e74253fe64329390df80bed3f07314ddd61:

   Linux 5.13-rc7 (2021-06-20 15:03:15 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v5.14

for you to fetch changes up to 3f605ee17f8e785ba6ff69bee8e584e377a3cf28:

   m68knommu: fix missing LCD splash screen data initializer (2021-06-21 12:09:26 +1000)

----------------------------------------------------------------
m68knommu: fixes for v5.14

Fixes include:
. fix missing LCD splash screen data initializer

----------------------------------------------------------------
Greg Ungerer (1):
       m68knommu: fix missing LCD splash screen data initializer

  arch/m68k/68000/dragen2.c |   1 +
  arch/m68k/68000/screen.h  | 804 ++++++++++++++++++++++++++++++++++++++++++++++
  2 files changed, 805 insertions(+)
  create mode 100644 arch/m68k/68000/screen.h
