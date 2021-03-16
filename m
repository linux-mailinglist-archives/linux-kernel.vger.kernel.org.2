Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A2A33D34C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 12:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237459AbhCPLoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 07:44:06 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33824 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237426AbhCPLng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 07:43:36 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12GBdaPH160273;
        Tue, 16 Mar 2021 11:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=qV1Rq+2H1o2CbC83Mj76nXd65U3V69TV6d/S19mcjpc=;
 b=fpcLUJHxkujAMjYRWLKXvBPuG8Dq4yC+zwwbbyRV2gyfhWiv128eF1brBs28gxnQRzYl
 aNz+TXi7ZvSOFDL1Pxns9s++CqI2PenpKiOvRuIQV8iN8SIDqK73lgWZFLStvPksAamd
 CbiukjlZTcbNsi37ms/GqCPZHMN/bxOKYqfTAy3j8NDKSdxZgN10hWBgL7UTuWXugDWy
 4Z87OBnQ1PFvYohcinoSce4avaQZVYy6/1dIsfLhtHF8dUahEwzxB3motl4MdAb37LS9
 yDAWbTm1MGyKSWZ5ryblQqTAoL2uNO2PsWdfWzDbuD3GdR/cx6zpj1Ao/3EEpfUR+IOk Ew== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 378nbm7cmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 11:43:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12GBacCf004230;
        Tue, 16 Mar 2021 11:43:25 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 3796ytb1pm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 11:43:25 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 12GBhOKl013102;
        Tue, 16 Mar 2021 11:43:25 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Mar 2021 04:43:24 -0700
Date:   Tue, 16 Mar 2021 14:43:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] lib/test_hmm.c: fix harmless shift wrapping bug
Message-ID: <YFCZ1NNfMoixOjWP@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9924 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103160081
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9924 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxscore=0 clxscore=1011 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103160081
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "cmd.npages" variable is a u64 that comes from the user.  I noticed
during review that it could have a shift wrapping bug when it is used
in the integer overflow test on the next line.

It turns out this is harmless.  The users all do:

	unsigned long size = cmd->npages << PAGE_SHIFT;

and after that "size" is used consistently and "cmd->npages" is never
used again.  So even when there is an integer overflow, everything works
fine.

Even though this is harmless, I believe syzbot will complain and fixing
it makes the code easier to read.

Fixes: b2ef9f5a5cb3 ("mm/hmm/test: add selftest driver for HMM")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 lib/test_hmm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 80a78877bd93..541466034a6b 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -930,6 +930,8 @@ static long dmirror_fops_unlocked_ioctl(struct file *filp,
 
 	if (cmd.addr & ~PAGE_MASK)
 		return -EINVAL;
+	if (cmd.npages > ULONG_MAX >> PAGE_SHIFT)
+		return -EINVAL;
 	if (cmd.addr >= (cmd.addr + (cmd.npages << PAGE_SHIFT)))
 		return -EINVAL;
 
-- 
2.30.1

