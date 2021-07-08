Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3AF43C1618
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 17:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbhGHPjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 11:39:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231956AbhGHPjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 11:39:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 55D9C61483;
        Thu,  8 Jul 2021 15:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625758582;
        bh=O/NggnEx8J+4ypCYFWNebhhMPPa1Y0HE3utxVeEZxYE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jMQpl1K5/KOpVLgFP8DZOu3y+yCuQytdaIsUVCVN525JWKvdJzD3uECw9ZrhPqjZ1
         BH5pl28eJM5JE6e8nKwdBkqHDaeXw1FFknRsh04+o2o7g5KXI2yk0m2+UBb0/Br6jt
         Bs08N3Y7O4TPiXMWPI7bgmRo0FrzgQoEueKto8WaeVe/2GLgDaFrkBSCGSa0H7vYya
         V0u2L11vR+ZjrUTmNnLa03vhCgwAihYSRn/eXuD35Kbxb4ppgulB6+1Iaj8V+Tw2w9
         KFWMz1ysAUXgTujDyLwL7ZwicJCcYW7FGx4Pcgk7X2/NBiOrRJiQtCgf+i3uudz27a
         dY0OOuDcfLmqg==
Date:   Thu, 8 Jul 2021 17:36:20 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     He Zhe <zhe.he@windriver.com>
Cc:     anna-maria@linutronix.de, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH v2] timers: Recalculate next timer interrupt only when
 necessary
Message-ID: <20210708153620.GA6716@lothringen>
References: <20200723151641.12236-1-frederic@kernel.org>
 <dfbf752e-91db-b128-76a8-98fde4c5d480@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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

And I'm not observing that on default aarch64 on qemu either.
Are you emulating a specific machine?

Can you enable the following trace events and send me the output from
one of the isolated CPU trace, say CPU 3 for example:


DIR=/sys/kernel/debug/tracing

echo 1 > $DIR/events/irq/enable
echo 1 > $DIR/events/sched/sched_switch/enable
echo 1 > $DIR/events/irq_vectors/enable
echo 1 > $DIR/events/workqueue/workqueue_execute_start/enable
echo 1 > $DIR/events/timer/hrtimer_expire_entry/enable
echo 1 > $DIR/events/timer/timer_expire_entry/enable
echo 1 > $DIR/events/timer/tick_stop/enable
sleep 10
cat $DIR/per_cpu/cpu0/trace > ~/output_to_send
