Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851DD36E502
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 08:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238927AbhD2GpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 02:45:23 -0400
Received: from mail-m17655.qiye.163.com ([59.111.176.55]:56712 "EHLO
        mail-m17655.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238495AbhD2GpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 02:45:16 -0400
X-Greylist: delayed 406 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Apr 2021 02:45:16 EDT
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.250.176.229])
        by mail-m17655.qiye.163.com (Hmail) with ESMTPA id F353A400B8;
        Thu, 29 Apr 2021 14:37:34 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Jonathan Corbet <corbet@lwn.net>, Wang Qing <wangqing@vivo.com>,
        Joe Perches <joe@perches.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stephen Kitt <steve@sk2.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Klychkov <andrew.a.klychkov@gmail.com>,
        Rafael Aquini <aquini@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Santosh Sivaraj <santosh@fossix.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2,RESEND 0/4] kernel/watchdog: Modify the explanation and doc related to watchdog thread
Date:   Thu, 29 Apr 2021 14:37:10 +0800
Message-Id: <1619678239-2289-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGR5CSFZCTx0fSkhITxhIShlVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MS46Nyo*Oj8RMEk1IhE0DxFL
        TzwwC0NVSlVKTUpCTUxDSU5OQkpNVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5LVUpMTVVJSUJZV1kIAVlBSU5ITjcG
X-HM-Tid: 0a791c58d98fda01kuwsf353a400b8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"watchdog/%u" threads has be replaced by cpu_stop_work. The current 
description is extremely misleading, so we need to modify the 
explanation and documentation related to this.

Wang Qing (4):
  kernel: watchdog: Modify the explanation related to watchdog thread
  doc: watchdog: Delete the explanation about "watchdog/%u".
  doc: watchdog: Modify the explanation related to watchdog thread
  doc: watchdog: Modify the doc related to "watchdog/%u"

 .../admin-guide/kernel-per-CPU-kthreads.rst          | 20 --------------------
 Documentation/admin-guide/lockup-watchdogs.rst       |  4 ++--
 Documentation/admin-guide/sysctl/kernel.rst          | 10 +++++-----
 kernel/watchdog.c                                    | 12 ++++--------
 4 files changed, 11 insertions(+), 35 deletions(-)

-- 
2.7.4

