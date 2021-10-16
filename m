Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E67142FF9F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 03:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239518AbhJPBTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 21:19:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:37888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233157AbhJPBTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 21:19:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2735D60FDA;
        Sat, 16 Oct 2021 01:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634347059;
        bh=/MNVPMeFHYltqD3R3YXzREiAEwC54RXmWzNJrWqFQh8=;
        h=To:Cc:From:Subject:Date:From;
        b=jOw7bSAAiHwir5uTg7LQxYyI7NK9SnhRQc+3+OPXz790kgfjztaNmdPlLylvw8Mxf
         Hnv7SQgyeQ5RFX2fDsMNXQRKZPxFTMMn39+xOyPgXmwjOqou2VkTslXgCnPdLEAa1K
         KU7vO2h+gtt7UJzDM6P0Jav7PAn6F6mvNxiO4ykgLyxIqpbr6GU0vgyuLfJDVXE5Np
         i+BNtPn9CQyxWkWBLB3zoUC5LnB9lO2SYRktq7oQUe9B1MJvzDE84r5wquKE5paeS1
         QHRzCG9jp1BnzgfPnTgaG4l6kCHnWezeHlDQq81MT2s1kOGhcubY7zJuiKolzPTbIC
         b0RDh5mxZG9Eg==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>
From:   Vineet Gupta <vgupta@kernel.org>
Subject: [GIT PULL] ARC fix for 5.15-rc6
Message-ID: <8dd82653-d44e-7470-6490-bc486c09590b@kernel.org>
Date:   Fri, 15 Oct 2021 18:17:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Fixlet for ARC, better to go in now. Please pull !

Thx,
-Vineet
------------------->
The following changes since commit 64570fbc14f8d7cb3fe3995f20e26bc25ce4b2cc:

   Linux 5.15-rc5 (2021-10-10 17:01:59 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ 
tags/arc-5.15-rc6

for you to fetch changes up to c3ca31ce0ea1e1ae34748ded54b6ccc319e7ed20:

   ARC: fix potential build snafu (2021-10-15 18:06:32 -0700)

----------------------------------------------------------------
Small fixlet for ARC

----------------------------------------------------------------
Vineet Gupta (1):
       ARC: fix potential build snafu

  arch/arc/include/asm/pgtable.h | 5 -----
  1 file changed, 5 deletions(-)

