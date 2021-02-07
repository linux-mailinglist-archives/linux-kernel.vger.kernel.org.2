Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1F831267B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 18:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhBGRrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 12:47:36 -0500
Received: from smtprelay0130.hostedemail.com ([216.40.44.130]:46120 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229510AbhBGRre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 12:47:34 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 8F4A4182CED28;
        Sun,  7 Feb 2021 17:46:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:2:41:69:355:379:599:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1535:1593:1594:1606:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3355:3622:3866:3867:3868:4117:4321:4605:5007:6119:7652:7903:8603:10004:10848:11026:11232:11658:11914:12043:12048:12296:12297:12438:12555:12683:12740:12760:12895:12986:13255:13439:14659:21080:21451:21611:21627:21990:30012:30051:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: side02_2f0318a275f8
X-Filterd-Recvd-Size: 6214
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Sun,  7 Feb 2021 17:46:52 +0000 (UTC)
Message-ID: <45cde3a597e932e3e81264034455582b21e72642.camel@perches.com>
Subject: Re: [PATCH] staging: gasket: fix indentation and lines ending with
 open parenthesis
From:   Joe Perches <joe@perches.com>
To:     Mahak Gupta <gmahak1@gmail.com>, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        rcy@google.com, benchan@chromium.org, toddpoynor@google.com,
        rspringer@google.com
Date:   Sun, 07 Feb 2021 09:46:50 -0800
In-Reply-To: <20210207140928.11029-1-gmahak1@gmail.com>
References: <20210207140928.11029-1-gmahak1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-02-07 at 19:39 +0530, Mahak Gupta wrote:
> This patch fixes warnings of 'checkpatch.pl'. According to
> Linux coding guidelines, code should be aligned properly to
> match with open parenthesis and lines should not end with
> open parenthesis.

Perhaps try using temporaries to reduce line length when used multiple times...

Something like:
---
 drivers/staging/gasket/gasket_ioctl.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/gasket/gasket_ioctl.c b/drivers/staging/gasket/gasket_ioctl.c
index e3047d36d8db..3cb2227d5972 100644
--- a/drivers/staging/gasket/gasket_ioctl.c
+++ b/drivers/staging/gasket/gasket_ioctl.c
@@ -44,6 +44,7 @@ static int gasket_read_page_table_size(struct gasket_dev *gasket_dev,
 {
 	int ret = 0;
 	struct gasket_page_table_ioctl ibuf;
+	struct gasket_page_table *table;
 
 	if (copy_from_user(&ibuf, argp, sizeof(struct gasket_page_table_ioctl)))
 		return -EFAULT;
@@ -51,8 +52,8 @@ static int gasket_read_page_table_size(struct gasket_dev *gasket_dev,
 	if (ibuf.page_table_index >= gasket_dev->num_page_tables)
 		return -EFAULT;
 
-	ibuf.size = gasket_page_table_num_entries(
-		gasket_dev->page_table[ibuf.page_table_index]);
+	table = gasket_dev->page_table[ibuf.page_table_index];
+	ibuf.size = gasket_page_table_num_entries(table);
 
 	trace_gasket_ioctl_page_table_data(ibuf.page_table_index, ibuf.size,
 					   ibuf.host_address,
@@ -70,6 +71,7 @@ static int gasket_read_simple_page_table_size(struct gasket_dev *gasket_dev,
 {
 	int ret = 0;
 	struct gasket_page_table_ioctl ibuf;
+	struct gasket_page_table *table;
 
 	if (copy_from_user(&ibuf, argp, sizeof(struct gasket_page_table_ioctl)))
 		return -EFAULT;
@@ -77,8 +79,8 @@ static int gasket_read_simple_page_table_size(struct gasket_dev *gasket_dev,
 	if (ibuf.page_table_index >= gasket_dev->num_page_tables)
 		return -EFAULT;
 
-	ibuf.size =
-		gasket_page_table_num_simple_entries(gasket_dev->page_table[ibuf.page_table_index]);
+	table = gasket_dev->page_table[ibuf.page_table_index];
+	ibuf.size = gasket_page_table_num_simple_entries(table);
 
 	trace_gasket_ioctl_page_table_data(ibuf.page_table_index, ibuf.size,
 					   ibuf.host_address,
@@ -97,6 +99,7 @@ static int gasket_partition_page_table(struct gasket_dev *gasket_dev,
 	int ret;
 	struct gasket_page_table_ioctl ibuf;
 	uint max_page_table_size;
+	struct gasket_page_table *table;
 
 	if (copy_from_user(&ibuf, argp, sizeof(struct gasket_page_table_ioctl)))
 		return -EFAULT;
@@ -107,8 +110,9 @@ static int gasket_partition_page_table(struct gasket_dev *gasket_dev,
 
 	if (ibuf.page_table_index >= gasket_dev->num_page_tables)
 		return -EFAULT;
-	max_page_table_size = gasket_page_table_max_size(
-		gasket_dev->page_table[ibuf.page_table_index]);
+
+	table = gasket_dev->page_table[ibuf.page_table_index];
+	max_page_table_size = gasket_page_table_max_size(table);
 
 	if (ibuf.size > max_page_table_size) {
 		dev_dbg(gasket_dev->dev,
@@ -119,8 +123,7 @@ static int gasket_partition_page_table(struct gasket_dev *gasket_dev,
 
 	mutex_lock(&gasket_dev->mutex);
 
-	ret = gasket_page_table_partition(
-		gasket_dev->page_table[ibuf.page_table_index], ibuf.size);
+	ret = gasket_page_table_partition(table, ibuf.size);
 	mutex_unlock(&gasket_dev->mutex);
 
 	return ret;
@@ -131,6 +134,7 @@ static int gasket_map_buffers(struct gasket_dev *gasket_dev,
 			      struct gasket_page_table_ioctl __user *argp)
 {
 	struct gasket_page_table_ioctl ibuf;
+	struct gasket_page_table *table;
 
 	if (copy_from_user(&ibuf, argp, sizeof(struct gasket_page_table_ioctl)))
 		return -EFAULT;
@@ -142,12 +146,13 @@ static int gasket_map_buffers(struct gasket_dev *gasket_dev,
 	if (ibuf.page_table_index >= gasket_dev->num_page_tables)
 		return -EFAULT;
 
-	if (gasket_page_table_are_addrs_bad(gasket_dev->page_table[ibuf.page_table_index],
+	table = gasket_dev->page_table[ibuf.page_table_index];
+	if (gasket_page_table_are_addrs_bad(table,
 					    ibuf.host_address,
 					    ibuf.device_address, ibuf.size))
 		return -EINVAL;
 
-	return gasket_page_table_map(gasket_dev->page_table[ibuf.page_table_index],
+	return gasket_page_table_map(table,
 				     ibuf.host_address, ibuf.device_address,
 				     ibuf.size / PAGE_SIZE);
 }
@@ -157,6 +162,7 @@ static int gasket_unmap_buffers(struct gasket_dev *gasket_dev,
 				struct gasket_page_table_ioctl __user *argp)
 {
 	struct gasket_page_table_ioctl ibuf;
+	struct gasket_page_table *table;
 
 	if (copy_from_user(&ibuf, argp, sizeof(struct gasket_page_table_ioctl)))
 		return -EFAULT;
@@ -168,11 +174,12 @@ static int gasket_unmap_buffers(struct gasket_dev *gasket_dev,
 	if (ibuf.page_table_index >= gasket_dev->num_page_tables)
 		return -EFAULT;
 
-	if (gasket_page_table_is_dev_addr_bad(gasket_dev->page_table[ibuf.page_table_index],
+	table = gasket_dev->page_table[ibuf.page_table_index];
+	if (gasket_page_table_is_dev_addr_bad(table,
 					      ibuf.device_address, ibuf.size))
 		return -EINVAL;
 
-	gasket_page_table_unmap(gasket_dev->page_table[ibuf.page_table_index],
+	gasket_page_table_unmap(table,
 				ibuf.device_address, ibuf.size / PAGE_SIZE);
 
 	return 0;

