Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D4E3D3A79
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 14:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbhGWMHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 08:07:35 -0400
Received: from gateway23.websitewelcome.com ([192.185.48.104]:33760 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234853AbhGWMHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 08:07:34 -0400
X-Greylist: delayed 1499 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Jul 2021 08:07:34 EDT
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 2DFD637DF
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 06:58:43 -0500 (CDT)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id 6tpDmF3y9rJtZ6tpDm0hY6; Fri, 23 Jul 2021 06:58:43 -0500
X-Authority-Reason: nr=8
Received: from host-79-37-206-118.retail.telecomitalia.it ([79.37.206.118]:60642 helo=x1.bristot.me)
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1m6tpA-0016jT-Vi; Fri, 23 Jul 2021 06:58:41 -0500
To:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dhaval Giani <dhaval.giani@gmail.com>,
        Clark Williams <williams@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kate Carcia <kcarcia@redhat.com>, Phil Auld <pauld@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        =?UTF-8?Q?Luis_Claudio_R=2e_Gon=c3=a7alves?= <lclaudio@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Wagner <wagi@monom.org>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [ANNOUNCE] CFP: Real-Time Microconference - Linux Plumbers Conference
 2021
Message-ID: <4c666746-a4bd-5111-1512-58d030987f8b@kernel.org>
Date:   Fri, 23 Jul 2021 13:58:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 79.37.206.118
X-Source-L: No
X-Exim-ID: 1m6tpA-0016jT-Vi
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-79-37-206-118.retail.telecomitalia.it (x1.bristot.me) [79.37.206.118]:60642
X-Source-Auth: kernel@bristot.me
X-Email-Count: 2
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Real-time microconference focuses on finishing the last lap of getting the
PREEMPT_RT[1] patch set into mainline. Many of these missing pieces, however, 
are not at the core of real-time features (like locking, and scheduling), but 
instead, on other subsystems that compose the kernel, like file systems and 
memory management. Making this Linux subsystems compatible with PREEMPT_RT 
requires finding a solution that is acceptable by subsystem maintainer, without 
having these subsystems suffer from performance or complexity issues.

Suggested Topics:
 - New tools for PREEMPT_RT analysis [2].
 - How do we teach the rest of the kernel developers how not to break
   PREEMPT_RT?
 - Stable maintainers tools discussion & improvements: [3]
 - The usage of PREEMPT_RT on safety-critical systems: what do we need to do?
 - Make NAPI and the kernel-rt working better together [5]
 - Migrate disable and the problems that they cause on rt tasks [6]
 - It is time to discuss the "BKL"-like style of our preempt/bh/irq_disable()
   synchronization functions.
 - How do we close the documentation gap
 - The status of the merge, and how can we resolve the last issues that block
   the merge
 - Invite the developers of the areas where patches are still under discussion 
   to help to find an agreement
 - How can we improve the testing of the -rt, to follow the problems raised as    
   Linus tree advances?
 - What’s next?

If you are interested in participating in this microconference and have topics 
to propose, please use the LPC CfP process, and select "Real-time MC" for the 
"Track". More topics will be added based on CfP for LPC microconference.

MC leads:
 - Daniel Bristot de Oliveira <bristot@redhat.com>
 - Steven Rostedt <rostedt@goodmis.org>
 - Clark Williams <williams@redhat.com>
 - Dhaval Giani <dhaval.giani@oracle.com>
 - Kate Stewart <stewart@linux.com>

 
Links:
[1] https://wiki.linuxfoundation.org/realtime/start
[2] https://github.com/bristot/rtsl/
[3] https://github.com/igaw/stable-rt-tools
[4] https://www.linux.com/news/in-the-trenches-with-thomas-gleixner-real-time-linux-kernel-patch-set/
[5] Discussions:
        https://lore.kernel.org/netdev/20210514222402.295157-1-kuba@kernel.org/
        https://lore.kernel.org/lkml/YJofplWBz8dT7xiw@localhost.localdomain/
[6] https://lore.kernel.org/linux-arm-kernel/20200924082717.GA1362448@hirez.programming.kicks-ass.net/T/

