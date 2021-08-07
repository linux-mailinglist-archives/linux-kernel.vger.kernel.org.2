Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482C23E327B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 03:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhHGBDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 21:03:39 -0400
Received: from pv50p00im-zteg10011501.me.com ([17.58.6.42]:59288 "EHLO
        pv50p00im-zteg10011501.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229512AbhHGBDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 21:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1628298202; bh=32oK1hrFCRUgWXFrkZdy+s7tZTvaBZCtulRTSPPphyo=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=twrXvJZSQyvONOmxI623LS+G1LNIgReTAfIgwDBkiBAmGSiZjTDIT60vKs5BlPD/Z
         NLIGdr5iYaKSLI0f/ApTzomgP4ZwOn4Oz9DN7/dLYZM2dtuHnZod8FFPkYqdhmD0zU
         OaA8AVgZsY0ZwEpEdVSBR00H9ELrus9kkmpKjomqS30neefHytW8oan/CIT38PrBhg
         o0MCzsUTmcv5OONvD1k6XJou0Wd71DBlFhKEYfc9xJkr8UvEpqL8R9/1G4pNHPaGHE
         Em6HxqODAY+p2hcadK626+gQs+iX6dQWkmLEKvt/0u7MZ89EPitb7roaFuAMfdQMeF
         F/K666fueZk6w==
Received: from xiongwei.. (unknown [120.245.2.134])
        by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 268B5B003BD;
        Sat,  7 Aug 2021 01:03:17 +0000 (UTC)
From:   sxwjean@me.com
To:     linuxppc-dev@lists.ozlabs.org
Cc:     oleg@redhat.com, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, christophe.leroy@csgroup.eu, npiggin@gmail.com,
        ravi.bangoria@linux.ibm.com, aneesh.kumar@linux.ibm.com,
        efremov@linux.com, linux-kernel@vger.kernel.org,
        Xiongwei Song <sxwjean@gmail.com>
Subject: [PATCH v2 0/4] Some improvements on regs usage
Date:   Sat,  7 Aug 2021 09:02:35 +0800
Message-Id: <20210807010239.416055-1-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-06_08:2021-08-06,2021-08-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=787 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2108070004
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

When CONFIG_4xx=y or CONFIG_BOOKE=y, currently in code we reference dsisr
to get interrupt reasons and reference dar to get excepiton address.
However, in reference manuals, esr is used for interrupt reasons and dear
is used for excepiton address, so the patchset changes dsisr -> esr,
dar -> dear for CONFIG_4xx=y or CONFIG_BOOKE=y.

Meanwhile, we use _ESR and _DEAR to get offsets of esr and dear on stack.

v2:
 - Discard changes in arch/powerpc/mm/fault.c as Christophe and Michael
   suggested.
 - Discard changes in UAPI headers to avoid possible compile issue.

v1:
 - https://lkml.org/lkml/2021/8/6/57
 - https://lkml.org/lkml/2021/7/26/533
 - https://lkml.org/lkml/2021/7/26/534
 - https://lkml.org/lkml/2021/7/26/535

Xiongwei Song (4):
  powerpc: Optimize register usage for esr register
  powerpc/64e: Get esr offset with _ESR macro
  powerpc: Optimize register usage for dear register
  powerpc/64e: Get dear offset with _DEAR macro

 arch/powerpc/include/asm/ptrace.h          | 10 ++++++++--
 arch/powerpc/kernel/asm-offsets.c          | 15 ++++-----------
 arch/powerpc/kernel/exceptions-64e.S       | 18 +++++++++---------
 arch/powerpc/kernel/process.c              |  2 +-
 arch/powerpc/kernel/ptrace/ptrace.c        |  4 ++++
 arch/powerpc/kernel/traps.c                |  2 +-
 arch/powerpc/platforms/44x/machine_check.c |  4 ++--
 arch/powerpc/platforms/4xx/machine_check.c |  2 +-
 8 files changed, 30 insertions(+), 27 deletions(-)

-- 
2.30.2

