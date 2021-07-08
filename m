Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3B9F3BF918
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 13:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhGHLhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 07:37:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:38198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231578AbhGHLhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 07:37:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF56961436;
        Thu,  8 Jul 2021 11:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625744103;
        bh=O1NRUbTGoovuQfXQ41KSL73wAlcNNQqmMI5h95/5xL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R+OmlyPziOM6YZAqlKsLbup5e8lzoHEW+j1Ps6Ym3K4Qf2BalYh+EHqSOeCldnj1U
         GXlbSf2u5gepwYrDy81z8bhrV8JlaQCB7KohUeAchlBbUNIYUOZ/WbvLgxNH/QcgaK
         Bf0HtH3/WT7tZF7FT5lyw9jrQ8wjGt7SeNjXjtHf5NsZjmKG96kl3Yedja8GbUnbAM
         HVMnuOXlZqHfFeAjC88xVQlkczh+K0iY8zcm9jymlyb4LgyLBGjcRrCJbPdkO0Eg4x
         K/mJfx7lRPyu1SmVZ+RkRjrAK58Z07lpv/qenITNVKelgcNHH5YhBULD4IfltkScK7
         cl6jlNiiRJv/Q==
Date:   Thu, 8 Jul 2021 13:35:00 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     He Zhe <zhe.he@windriver.com>
Cc:     anna-maria@linutronix.de, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH v2] timers: Recalculate next timer interrupt only when
 necessary
Message-ID: <20210708113500.GA130061@lothringen>
References: <20200723151641.12236-1-frederic@kernel.org>
 <dfbf752e-91db-b128-76a8-98fde4c5d480@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dfbf752e-91db-b128-76a8-98fde4c5d480@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2021 at 02:43:01PM +0800, He Zhe wrote:
> Hi,
> 
> Ever since this commit merged in, when nohz_full enabled, the counts of arch_timer interrupt on arm64 arches keep increasing on cores that have been isolated. This can be reproduced on several arm64 boards. After reverting the commit, the counts would stop increasing after boot. my .config is attached.
> 
> root@qemuarm64:~# uname -a
> Linux qemuarm64 5.13.0 #1 SMP PREEMPT Mon Jul 5 07:11:27 UTC 2021 aarch64 aarch64 aarch64 GNU/Linux
> root@qemuarm64:~# cat /proc/cmdline
> root=/dev/vda rw  mem=2048M ip=dhcp console=ttyAMA0 console=hvc0  earlyprintk isolcpus=1-5 nohz_full=1-5 rcu_nocbs=1-5
> root@qemuarm64:~# cat /proc/interrupts
> CPU0     CPU1    CPU2    CPU3     CPU4    CPU5
> 12396    326     325     323      320    321    GIC-0� 27 Level���� arch_timer

Strange, I'm not observing that on a raspberry 3b+ (arm64 defconfig):

# cat /proc/cmdline 
console=tty0 console=ttyS1,115200 root=/dev/sda2 rw fsck.repair=yes net.ifnames=0 cma=64M rootwait isolcpus=1-3 nohz_full=1-3

# uname -a
Linux rpi3 5.13.0 #3 SMP PREEMPT Thu Jul 8 13:08:39 CEST 2021 aarch64 GNU/Linux

# cat /proc/interrupts 
           CPU0       CPU1       CPU2       CPU3
108:     165376         25         25         25  bcm2836-timer   1 Edge  arch_timer


But let's see if I can successfully boot your own config...
