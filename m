Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B08A3AFFE3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 11:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhFVJJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 05:09:34 -0400
Received: from mail-m17639.qiye.163.com ([59.111.176.39]:39094 "EHLO
        mail-m17639.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhFVJJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 05:09:33 -0400
DKIM-Signature: a=rsa-sha256;
        b=Qr8ylLUjBrQTIUIWWNaU7r9oy7vsz9ft3CnytznZT7VIQAdcQHpS75DiW2DZ0kgO+f2KjovrE9MbTZ2xstk8uh0HBPkfk06Z8ycKhMp8AzghCX/mxLlBcbk1T6uA9V5ikaCF0aeTRb1Blveix+WpMC0gamirV8dL6dHqiHFy8Zg=;
        s=default; c=relaxed/relaxed; d=vivo.com; v=1;
        bh=6/4Ix/diGsJvpcpyDuWCQ3aAfHsc4/cqPw/gF7QU/lc=;
        h=date:mime-version:subject:message-id:from;
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.232])
        by mail-m17639.qiye.163.com (Hmail) with ESMTPA id EECFF38025D;
        Tue, 22 Jun 2021 17:07:14 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>, Wang Qing <wangqing@vivo.com>,
        Santosh Sivaraj <santosh@fossix.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC 0/2] hrtimer: watchdog: support hrtimer suspend when CPU suspend
Date:   Tue, 22 Jun 2021 17:06:45 +0800
Message-Id: <1624352816-26450-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGUtPQ1ZJTRhKSxlMSB9KTEtVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kyo6EQw4IT9DED4aOjgtNE0Z
        H01PClFVSlVKTUlPSE5JQ0hOTkJLVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISVlXWQgBWUFJSkJPNwY+
X-HM-Tid: 0a7a32f946c5d994kuwseecff38025d
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the CPU suspend, in order to achieve a more power-saving effect,
it is hoped that the CPU sleeps as long as possible, but the timer is an 
important reason for the CPU to wake up. 

In some cases, when the CPU suspend, the timer doesn’t have to work either,
such as watchdog hrtimer. The maximum suspend time of the CPU is 4s if enable
lockup detector, which is unacceptable on some products, and in fact, watchdog
timer can suspend when the cpu suspend.

This is a patch for comments, I'm not sure if there any ill-considerations. 
If this feature is really needed, I will continue to develop.

Wang Qing (2):
  hrtimer: support hrtimer suspend when CPU suspend
  watchdog: support watchdog hrtimer suspend when CPU suspend

 include/linux/hrtimer.h  | 3 +++
 kernel/time/hrtimer.c    | 4 +++-
 kernel/time/tick-sched.c | 7 +++++++
 kernel/watchdog.c        | 3 ++-

-- 
2.7.4

