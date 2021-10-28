Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E4043D96D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 04:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhJ1Cof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 22:44:35 -0400
Received: from smtp23.cstnet.cn ([159.226.251.23]:44578 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229534AbhJ1Coe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 22:44:34 -0400
Received: from localhost.localdomain (unknown [124.16.138.128])
        by APP-03 (Coremail) with SMTP id rQCowABnb2frDXph0XU9BQ--.45455S2;
        Thu, 28 Oct 2021 10:41:47 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     andraprs@amazon.com, lexnv@amazon.com, alcioa@amazon.com
Cc:     linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] nitro_enclaves: Fix implicit type conversion
Date:   Thu, 28 Oct 2021 02:41:46 +0000
Message-Id: <1635388906-2856355-1-git-send-email-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: rQCowABnb2frDXph0XU9BQ--.45455S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZrW8JFyDKw1DtF4DAF45Awb_yoW5XrWDpF
        4rX34UJrW8AasFkayxAr17uF15ZFZ3W3y7J3y3Cay8Cry5ZFy8ZFWDK3sxJryUCrWkXFy2
        y34Yywn0gF45C3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
        4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK
        6r4UMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbYhF7
        UUUUU==
X-Originating-IP: [124.16.138.128]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable 'cpu' is defined as unsigned int.
However in the for_each_cpu, its value is assigned to -1.
That doesn't make sense and in the cpumask_next() it is implicitly
type conversed to int.
It is universally accepted that the implicit type conversion is
terrible.
Also, having the good programming custom will set an example for
others.
Thus, it might be better to change the definition of 'cpu' from
unsigned int to int.

Fixes: ff8a4d3 ("nitro_enclaves: Add logic for setting an enclave vCPU")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/virt/nitro_enclaves/ne_misc_dev.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev.c b/drivers/virt/nitro_enclaves/ne_misc_dev.c
index e21e1e8..2d80879 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev.c
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev.c
@@ -168,9 +168,9 @@ static bool ne_check_enclaves_created(void)
 static int ne_setup_cpu_pool(const char *ne_cpu_list)
 {
 	int core_id = -1;
-	unsigned int cpu = 0;
+	int cpu = 0;
 	cpumask_var_t cpu_pool;
-	unsigned int cpu_sibling = 0;
+	int cpu_sibling = 0;
 	unsigned int i = 0;
 	int numa_node = -1;
 	int rc = -EINVAL;
@@ -374,7 +374,7 @@ static int ne_setup_cpu_pool(const char *ne_cpu_list)
  */
 static void ne_teardown_cpu_pool(void)
 {
-	unsigned int cpu = 0;
+	int cpu = 0;
 	unsigned int i = 0;
 	int rc = -EINVAL;
 
@@ -516,7 +516,7 @@ static int ne_get_unused_core_from_cpu_pool(void)
 static int ne_set_enclave_threads_per_core(struct ne_enclave *ne_enclave,
 					   int core_id, u32 vcpu_id)
 {
-	unsigned int cpu = 0;
+	int cpu = 0;
 
 	if (core_id < 0 && vcpu_id == 0) {
 		dev_err_ratelimited(ne_misc_dev.this_device,
@@ -562,7 +562,7 @@ static int ne_set_enclave_threads_per_core(struct ne_enclave *ne_enclave,
 static int ne_get_cpu_from_cpu_pool(struct ne_enclave *ne_enclave, u32 *vcpu_id)
 {
 	int core_id = -1;
-	unsigned int cpu = 0;
+	int cpu = 0;
 	unsigned int i = 0;
 	int rc = -EINVAL;
 
@@ -1017,7 +1017,7 @@ static int ne_start_enclave_ioctl(struct ne_enclave *ne_enclave,
 	struct ne_enclave_start_info *enclave_start_info)
 {
 	struct ne_pci_dev_cmd_reply cmd_reply = {};
-	unsigned int cpu = 0;
+	int cpu = 0;
 	struct enclave_start_req enclave_start_req = {};
 	unsigned int i = 0;
 	struct pci_dev *pdev = ne_devs.ne_pci_dev->pdev;
@@ -1360,7 +1360,7 @@ static void ne_enclave_remove_all_mem_region_entries(struct ne_enclave *ne_encla
  */
 static void ne_enclave_remove_all_vcpu_id_entries(struct ne_enclave *ne_enclave)
 {
-	unsigned int cpu = 0;
+	int cpu = 0;
 	unsigned int i = 0;
 
 	mutex_lock(&ne_cpu_pool.mutex);
-- 
2.7.4

