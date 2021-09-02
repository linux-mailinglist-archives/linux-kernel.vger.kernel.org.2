Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB843FEBD3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 12:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhIBKG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 06:06:29 -0400
Received: from smtp23.cstnet.cn ([159.226.251.23]:43004 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231770AbhIBKG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 06:06:27 -0400
Received: from localhost.localdomain (unknown [124.16.138.128])
        by APP-03 (Coremail) with SMTP id rQCowADX+BDLoTBh7RYDAA--.10653S2;
        Thu, 02 Sep 2021 18:04:59 +0800 (CST)
From:   Jiang Jiasheng <jiasheng@iscas.ac.cn>
To:     bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org, jiasheng <jiasheng@iscas.ac.cn>
Subject: [PATCH 1/3] bpf: Add env_type_is_resolved() in front of env_stack_push() in btf_resolve()
Date:   Thu,  2 Sep 2021 10:04:57 +0000
Message-Id: <1630577097-644528-1-git-send-email-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: rQCowADX+BDLoTBh7RYDAA--.10653S2
X-Coremail-Antispam: 1UD129KBjvdXoWruw1ruF4DXr1kWFWUAw4rAFb_yoWkuFX_K3
        W8uF1rGwsxKFsava1jvw4fury2k3yYqFn3Za1YqFs8G3s8WFy5Gr98Xas3Jr4DGrWkKrZF
        vr98C3sIgF1avjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8twCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAI
        cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb8hL5UUUUU==
X-Originating-IP: [124.16.138.128]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: jiasheng <jiasheng@iscas.ac.cn>

We have found that in the complied files env_stack_push()
appear more than 10 times, and under at least 90% circumstances
that env_type_is_resolved() and env_stack_push() appear in pairs.
For example, they appear together in the btf_modifier_resolve()
of the file complie from 'kernel/bpf/btf.c'.
But we have found that in the btf_resolve(), there is only
env_stack_push() instead of the pair.
Therefore, we consider that the env_type_is_resolved()
might be forgotten.

Signed-off-by: jiasheng <jiasheng@iscas.ac.cn>
---
 kernel/bpf/btf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index f982a9f0..454c249 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4002,7 +4002,8 @@ static int btf_resolve(struct btf_verifier_env *env,
 	int err = 0;
 
 	env->resolve_mode = RESOLVE_TBD;
-	env_stack_push(env, t, type_id);
+	if (env_type_is_resolved(env, type_id))
+		env_stack_push(env, t, type_id);
 	while (!err && (v = env_stack_peak(env))) {
 		env->log_type_id = v->type_id;
 		err = btf_type_ops(v->t)->resolve(env, v);
-- 
2.7.4

