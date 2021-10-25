Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58807438DDA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 05:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbhJYDds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 23:33:48 -0400
Received: from mail.loongson.cn ([114.242.206.163]:53836 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232157AbhJYDdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 23:33:37 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9CxhOb1JHZhrpgfAA--.56276S2;
        Mon, 25 Oct 2021 11:31:01 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org, corbet@lwn.net
Cc:     ananth@in.ibm.com, akpm@linux-foundation.org,
        randy.dunlap@oracle.com, mathieu.desnoyers@polymtl.ca,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Do some changes about kprobe
Date:   Mon, 25 Oct 2021 11:30:56 +0800
Message-Id: <1635132660-5038-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9CxhOb1JHZhrpgfAA--.56276S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKF4UuF4ftFWfWr45XF4rAFb_yoWxZrc_Aw
        48K3s5Cr4UGr4Yga13trZ2vw4qv3W3Gas7Zw48KrZrAw4UJrn8GFs5WFn3AayxXFZ5CF9r
        CF45ZrnIv3W3XjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbV8YjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kI
        c2xKxwCY02Avz4vE14v_Gr4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x07jOHUgUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is based on kprobes kernel tree:
https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/ for-next

Tiezhu Yang (4):
  samples/kretprobes: Fix return value if register_kretprobe() failed
  docs, kprobes: Remove invalid URL and add new reference
  test_kprobes: Move it from kernel/ to lib/
  MAINTAINERS: Add git tree and missing files for KPROBES

 Documentation/trace/kprobes.rst     | 2 +-
 MAINTAINERS                         | 3 +++
 kernel/Makefile                     | 1 -
 lib/Makefile                        | 1 +
 {kernel => lib}/test_kprobes.c      | 0
 samples/kprobes/kretprobe_example.c | 2 +-
 6 files changed, 6 insertions(+), 3 deletions(-)
 rename {kernel => lib}/test_kprobes.c (100%)

-- 
2.1.0

