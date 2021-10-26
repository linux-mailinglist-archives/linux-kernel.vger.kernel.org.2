Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A483243A9F0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 03:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbhJZByU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 21:54:20 -0400
Received: from mail.loongson.cn ([114.242.206.163]:43202 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231971AbhJZByO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 21:54:14 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxj2okX3dh6gIgAA--.33960S2;
        Tue, 26 Oct 2021 09:51:33 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, corbet@lwn.net
Cc:     akpm@linux-foundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] Do some changes about kprobe and trace
Date:   Tue, 26 Oct 2021 09:51:27 +0800
Message-Id: <1635213091-24387-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dxj2okX3dh6gIgAA--.33960S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZry7Cry3Kr1xurWfGw15urg_yoW3XFg_Aw
        s7K3s8Ga4UKrs0gw45Jrs29wsFya13WFyxAw1ktry7Zw47Gwn8Gan5Wrnxuay5ZrZY9FZ2
        yFsxZrnIqF13XjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbsAYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc2xSY4AK67AK6w4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnU
        UI43ZEXa7IU8xMaUUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is based on linux-trace.git:
https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git/ for-next

v2:
  -- Update patch #4 to use linux-trace.git for KPROBES and TRACING entries

Tiezhu Yang (4):
  samples/kretprobes: Fix return value if register_kretprobe() failed
  docs, kprobes: Remove invalid URL and add new reference
  test_kprobes: Move it from kernel/ to lib/
  MAINTAINERS: Update KPROBES and TRACING entries

 Documentation/trace/kprobes.rst     | 2 +-
 MAINTAINERS                         | 5 ++++-
 kernel/Makefile                     | 1 -
 lib/Makefile                        | 1 +
 {kernel => lib}/test_kprobes.c      | 0
 samples/kprobes/kretprobe_example.c | 2 +-
 6 files changed, 7 insertions(+), 4 deletions(-)
 rename {kernel => lib}/test_kprobes.c (100%)

-- 
2.1.0

