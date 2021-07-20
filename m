Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4843CF1E5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 04:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245671AbhGTB3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 21:29:21 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7393 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239983AbhGTBYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 21:24:21 -0400
Received: from dggeme751-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GTMQ46xMvz7wQd;
        Tue, 20 Jul 2021 10:01:16 +0800 (CST)
Received: from huawei.com (10.67.174.96) by dggeme751-chm.china.huawei.com
 (10.3.19.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 20
 Jul 2021 10:04:54 +0800
From:   Zhang Jianhua <chris.zjh@huawei.com>
To:     <corbet@lwn.net>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <chris.zjh@huawei.com>,
        <rostedt@goodmis.org>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: [PATCH -next] trace doc: Fix the wrong example of tracepoint
Date:   Tue, 20 Jul 2021 10:06:07 +0800
Message-ID: <20210720020607.4128715-1-chris.zjh@huawei.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.174.96]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme751-chm.china.huawei.com (10.3.19.97)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The example in tracepoints.rst is out of date, the build error below
will occur if coding according to example in the document.

drivers/irqchip/irq-riscv-intc.c:24:24:
error: macro "DEFINE_TRACE" requires 3 arguments, but only 1 given
   24 | DEFINE_TRACE(test_event);
      |                        ^
In file included from include/trace/events/test.h:8,
from drivers/irqchip/irq-riscv-intc.c:22:
include/linux/tracepoint.h:368:
note: macro "DEFINE_TRACE" defined here
  368 | #define DEFINE_TRACE(name, proto, args)
      |
drivers/irqchip/irq-riscv-intc.c:24:1:
warning: data definition has no type or storage class
   24 | DEFINE_TRACE(test_event);
      | ^~~~~~~~~~~~
drivers/irqchip/irq-riscv-intc.c:24:1:
error: type defaults to ‘int’ in declaration of ‘DEFINE_TRACE’
[-Werror=implicit-int]

There are two reasons for this error. On the one hand, the macro DEFINE_TRACE
has been refactored in commit d25e37d89dd2 ("tracepoint: Optimize using
static_call()") from DEFINE_TRACE(name) to DEFINE_TRACE(name, proto, args),
and the doc is not updated in time. On the other hand, the tracepoint has been
defined in header file, and it does not need to define repeatedly in C file.

--------

Signed-off-by: Zhang Jianhua <chris.zjh@huawei.com>
---
 Documentation/trace/tracepoints.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/trace/tracepoints.rst b/Documentation/trace/tracepoints.rst
index 0cb8d9ca3d60..fbb2cb4abd3d 100644
--- a/Documentation/trace/tracepoints.rst
+++ b/Documentation/trace/tracepoints.rst
@@ -66,7 +66,6 @@ In subsys/file.c (where the tracing statement must be added)::
 	#include <trace/events/subsys.h>
 
 	#define CREATE_TRACE_POINTS
-	DEFINE_TRACE(subsys_eventname);
 
 	void somefct(void)
 	{
-- 
2.31.0

