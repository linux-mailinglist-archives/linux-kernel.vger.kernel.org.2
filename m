Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF10A438DDB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 05:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbhJYDeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 23:34:00 -0400
Received: from mail.loongson.cn ([114.242.206.163]:53852 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232239AbhJYDdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 23:33:37 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9CxhOb1JHZhrpgfAA--.56276S6;
        Mon, 25 Oct 2021 11:31:08 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org, corbet@lwn.net
Cc:     ananth@in.ibm.com, akpm@linux-foundation.org,
        randy.dunlap@oracle.com, mathieu.desnoyers@polymtl.ca,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] MAINTAINERS: Add git tree and missing files for KPROBES
Date:   Mon, 25 Oct 2021 11:31:00 +0800
Message-Id: <1635132660-5038-5-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1635132660-5038-1-git-send-email-yangtiezhu@loongson.cn>
References: <1635132660-5038-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9CxhOb1JHZhrpgfAA--.56276S6
X-Coremail-Antispam: 1UD129KBjvdXoW7XF18Kw48XF48Kr4xArW5KFg_yoWfCrXEyw
        n8Jay3Wr48JrWUXw1rKrZ2vFsxtw4fG3Wfuan3t3y7AwnrKr98Jan3K3WDua9xWa98uFZF
        qF17WrnY9F45WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbyxYjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7
        IE14v26r126s0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0
        c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2
        IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04
        v7MxkIecxEwVAFwVW8GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC2
        0s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI
        0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv2
        0xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87
        Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIF
        yTuYvjxUc_-PUUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no git tree for KPROBES in MAINTAINERS, it is not convinent to
rebase, lib/test_kprobes.c and samples/kprobes belong to kprobe, add them.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4372473..0e9bc60 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10506,10 +10506,13 @@ M:	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
 M:	"David S. Miller" <davem@davemloft.net>
 M:	Masami Hiramatsu <mhiramat@kernel.org>
 S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git
 F:	Documentation/trace/kprobes.rst
 F:	include/asm-generic/kprobes.h
 F:	include/linux/kprobes.h
 F:	kernel/kprobes.c
+F:	lib/test_kprobes.c
+F:	samples/kprobes
 
 KS0108 LCD CONTROLLER DRIVER
 M:	Miguel Ojeda <ojeda@kernel.org>
-- 
2.1.0

