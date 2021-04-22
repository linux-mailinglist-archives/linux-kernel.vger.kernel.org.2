Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFDB368314
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 17:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237857AbhDVPL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 11:11:57 -0400
Received: from pv50p00im-hyfv10011601.me.com ([17.58.6.43]:48275 "EHLO
        pv50p00im-hyfv10011601.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236559AbhDVPL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 11:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1619104281; bh=a+6VQ8pLlz1642rIhBYQF/ryx1ofGc8+0N3JGfNATL8=;
        h=From:To:Subject:Date:Message-Id;
        b=A9TxkZcrX41py7jNK8WeMErTMTC7M9HStvqTMB+xF5WXGGsfrUF+BuZzga2NEAgbV
         9NZ7ohO/e5hJNNwivJG4oNZva4DcrX7Ph+VEt1aiOumN4AEwAYITkXZBLQGvmiynTD
         kfkwpFya2bR4dIzU+uQSy7jyJ8YIaC1jjFkC5c0YI/fZng8iqAoxSj9BRrxA1jCRV/
         CwVUiHOorGbSPKTmN2Ro2kP7JeKXZffpx1nAwZWoZRcRwTnQfCOKtdEGCuHL+lZUE6
         I41QVg6CaLaWdm5BgJtkGt/OEKmalM17i3yIgq9aytprNXgbBnJGKybut6HAhox4fL
         w6jPG404n79nw==
Received: from localhost.localdomain (unknown [120.245.2.61])
        by pv50p00im-hyfv10011601.me.com (Postfix) with ESMTPSA id E7C0C38058A;
        Thu, 22 Apr 2021 15:11:16 +0000 (UTC)
From:   Xiongwei Song <sxwjean@me.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        christophe.leroy@csgroup.eu, npiggin@gmail.com,
        ravi.bangoria@linux.ibm.com, mikey@neuling.org,
        aneesh.kumar@linux.ibm.com, 0x7f454c46@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Xiongwei Song <sxwjean@gmail.com>
Subject: [PATCH 2/2] powerpc: Print esr register when hitting Program Interrupt
Date:   Thu, 22 Apr 2021 23:10:22 +0800
Message-Id: <20210422151022.17868-2-sxwjean@me.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210422151022.17868-1-sxwjean@me.com>
References: <20210422151022.17868-1-sxwjean@me.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-22_06:2021-04-22,2021-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=675 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2104220120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

The esr register has the details of Program Interrupt on BookE/4xx cpus,
printing its value is helpful.

Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
---
 arch/powerpc/kernel/process.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 5c3830837f3a..664aecf8ee2e 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1459,6 +1459,7 @@ static bool interrupt_detail_printable(int trap)
 	case INTERRUPT_MACHINE_CHECK:
 	case INTERRUPT_DATA_STORAGE:
 	case INTERRUPT_ALIGNMENT:
+	case INTERRUPT_PROGRAM:
 		return true;
 	default:
 		return false;
-- 
2.17.1

