Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C24350D2A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 05:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbhDADcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 23:32:22 -0400
Received: from mail-m118208.qiye.163.com ([115.236.118.208]:37146 "EHLO
        mail-m118208.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbhDADbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 23:31:51 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.232])
        by mail-m118208.qiye.163.com (Hmail) with ESMTPA id 88740E020C;
        Thu,  1 Apr 2021 11:31:48 +0800 (CST)
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
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH V2 0/4] kernel/watchdog: Modify the explanation and doc related to watchdog thread
Date:   Thu,  1 Apr 2021 11:31:30 +0800
Message-Id: <1617247900-23813-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGkkZSElJShhMHhhDVkpNSkxJT0xCS0JJTUxVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NRg6Agw6MD8RLDQjFBEhPk4S
        KAIwChBVSlVKTUpMSU9MQktCTk1IVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISVlXWQgBWUFJTk5MNwY+
X-HM-Tid: 0a788b7cb53f2c17kusn88740e020c
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

