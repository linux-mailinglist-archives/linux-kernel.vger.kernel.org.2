Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF96E3249E5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 05:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbhBYE5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 23:57:09 -0500
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net ([206.189.21.223]:52655
        "HELO zg8tmja2lje4os4yms4ymjma.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S232139AbhBYE5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 23:57:07 -0500
Received: from centos7u5.localdomain (unknown [202.43.158.76])
        by c1app2 (Coremail) with SMTP id AgINCgBHTrriLTdg4QAgAw--.35049S3;
        Thu, 25 Feb 2021 12:56:03 +0800 (CST)
From:   Zhiyuan Dai <daizhiyuan@phytium.com.cn>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zhiyuan Dai <daizhiyuan@phytium.com.cn>
Subject: [PATCH] mm/filemap: minor coding style tweaks
Date:   Thu, 25 Feb 2021 12:55:36 +0800
Message-Id: <1614228936-22337-1-git-send-email-daizhiyuan@phytium.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AgINCgBHTrriLTdg4QAgAw--.35049S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw13KFW5uF15AFy7WFyrCrg_yoW8XFW8pF
        15G345C3y7Jw109r1DWayqva4Yg3W0gayjqry8Was09w1DKrnI9FyFgFWUAFy5Xr1kWr43
        tw4Dt345Ww1YkrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_
        Gryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVW8JVWx
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUb4SoUU
        UUU
X-Originating-IP: [202.43.158.76]
X-CM-SenderInfo: hgdl6xpl1xt0o6sk53xlxphulrpou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete whitespace to fix coding style issues, improve code reading.

Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
---
 mm/filemap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 6ff2a3f..20f27b6 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3111,7 +3111,7 @@ vm_fault_t filemap_page_mkwrite(struct vm_fault *vmf)
 
 /* This is used for a general mmap of a disk file */
 
-int generic_file_mmap(struct file * file, struct vm_area_struct * vma)
+int generic_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct address_space *mapping = file->f_mapping;
 
@@ -3136,11 +3136,11 @@ vm_fault_t filemap_page_mkwrite(struct vm_fault *vmf)
 {
 	return VM_FAULT_SIGBUS;
 }
-int generic_file_mmap(struct file * file, struct vm_area_struct * vma)
+int generic_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	return -ENOSYS;
 }
-int generic_file_readonly_mmap(struct file * file, struct vm_area_struct * vma)
+int generic_file_readonly_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	return -ENOSYS;
 }
@@ -3567,7 +3567,7 @@ ssize_t generic_perform_write(struct file *file,
 ssize_t __generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
-	struct address_space * mapping = file->f_mapping;
+	struct address_space *mapping = file->f_mapping;
 	struct inode 	*inode = mapping->host;
 	ssize_t		written = 0;
 	ssize_t		err;
-- 
1.8.3.1

