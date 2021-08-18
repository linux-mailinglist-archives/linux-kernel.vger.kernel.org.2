Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72ED3F0D3B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 23:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbhHRVWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 17:22:49 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:11248 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229531AbhHRVWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 17:22:48 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17ILFTlP011078
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 14:22:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=1XAcXeotTNZYxlSdxodQK4KYcxGdw6dJbsXyr2ovw/w=;
 b=oPQFYWXTUumFBRUyhJszg4FPNmD8yQBhl5SvBQ4oq0EIH/exE4rcoaPzQN494zDPNP6v
 ynPpDgFwBBsLXgSZIJHik9G1bqUdwAvwhizVPzC8yeyBvEHzf96LrqX13kQzwDpGSvqs
 LQiKRoKbf9jK1T2tS1cG7Xbj7O9w6e0Faz0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3ags1v5vyq-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 14:22:12 -0700
Received: from intmgw001.05.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 18 Aug 2021 14:22:10 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 7AF1DD1ADBC8; Wed, 18 Aug 2021 14:22:07 -0700 (PDT)
From:   Song Liu <songliubraving@fb.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <linux-mm@kvack.org>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH] x86/mm: add select HAVE_ARCH_HUGE_VMALLOC in Kconfig
Date:   Wed, 18 Aug 2021 14:21:48 -0700
Message-ID: <20210818212148.3927001-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: mKXZtB0TaRA7rwoeUZWCTURSx1B3LADb
X-Proofpoint-ORIG-GUID: mKXZtB0TaRA7rwoeUZWCTURSx1B3LADb
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-18_07:2021-08-17,2021-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=872 mlxscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108180132
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "select HAVE_ARCH_HUGE_VMALLOC if HAVE_ARCH_HUGE_VMAP", so that huge
vmalloc is enabled for X86_64 || X86_PAE.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a68bf2db0d3ea..6344c572555e0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -154,6 +154,7 @@ config X86
 	select HAVE_ACPI_APEI_NMI		if ACPI
 	select HAVE_ALIGNED_STRUCT_PAGE		if SLUB
 	select HAVE_ARCH_AUDITSYSCALL
+	select HAVE_ARCH_HUGE_VMALLOC		if HAVE_ARCH_HUGE_VMAP
 	select HAVE_ARCH_HUGE_VMAP		if X86_64 || X86_PAE
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
--=20
2.30.2

