Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D996A350D30
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 05:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbhDADc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 23:32:26 -0400
Received: from mail-m118208.qiye.163.com ([115.236.118.208]:40052 "EHLO
        mail-m118208.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbhDADcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 23:32:11 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.232])
        by mail-m118208.qiye.163.com (Hmail) with ESMTPA id 8AB01E00BD;
        Thu,  1 Apr 2021 11:32:07 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Jonathan Corbet <corbet@lwn.net>, Joe Perches <joe@perches.com>,
        Wang Qing <wangqing@vivo.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stephen Kitt <steve@sk2.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Eric Biggers <ebiggers@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Santosh Sivaraj <santosh@fossix.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH V2 3/4] doc: watchdog: Modify the explanation related to watchdog thread
Date:   Thu,  1 Apr 2021 11:31:33 +0800
Message-Id: <1617247900-23813-4-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617247900-23813-1-git-send-email-wangqing@vivo.com>
References: <1617247900-23813-1-git-send-email-wangqing@vivo.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTk1PTxkdTh8aS0IeVkpNSkxJT0xCSEtLT05VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NyI6SBw4PT8LFjQhSRFDPRoK
        TRlPC0hVSlVKTUpMSU9MQkhLSEpKVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISVlXWQgBWUFITkxLNwY+
X-HM-Tid: 0a788b7cff762c17kusn8ab01e00bd
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"watchdog/%u" threads has be replaced by cpu_stop_work. The current 
description is extremely misleading.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 Documentation/admin-guide/lockup-watchdogs.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/lockup-watchdogs.rst b/Documentation/admin-guide/lockup-watchdogs.rst
index 290840c..3e09284
--- a/Documentation/admin-guide/lockup-watchdogs.rst
+++ b/Documentation/admin-guide/lockup-watchdogs.rst
@@ -39,7 +39,7 @@ in principle, they should work in any architecture where these
 subsystems are present.
 
 A periodic hrtimer runs to generate interrupts and kick the watchdog
-task. An NMI perf event is generated every "watchdog_thresh"
+job. An NMI perf event is generated every "watchdog_thresh"
 (compile-time initialized to 10 and configurable through sysctl of the
 same name) seconds to check for hardlockups. If any CPU in the system
 does not receive any hrtimer interrupt during that time the
@@ -47,7 +47,7 @@ does not receive any hrtimer interrupt during that time the
 generate a kernel warning or call panic, depending on the
 configuration.
 
-The watchdog task is a high priority kernel thread that updates a
+The watchdog job runs in a stop scheduling thread that updates a
 timestamp every time it is scheduled. If that timestamp is not updated
 for 2*watchdog_thresh seconds (the softlockup threshold) the
 'softlockup detector' (coded inside the hrtimer callback function)
-- 
2.7.4

