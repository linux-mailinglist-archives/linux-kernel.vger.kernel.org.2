Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51878314430
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 00:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhBHXlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 18:41:51 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59102 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231438AbhBHXlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 18:41:01 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 118NVBP1013790
        for <linux-kernel@vger.kernel.org>; Mon, 8 Feb 2021 15:40:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=5kaplF3H6MDlvAZ2lzWWCei5T1sHu1BmlA/Lbu0P3P8=;
 b=pUCEm5DI9m8PSaeILQI6nJSZviqtXQO3yfCs7gc2E0R9An/4NRRmvC/NRXPWykU0MZiv
 08FXt8OVR9g4FkdwOjJzCnKwq167L/FjbSNMykPLzD8QIh2C9QeO9sK11ubHU7UvdHIF
 Ls+/40+q2Drg7fPKhy+aCHVjcbaabHJJ6nk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36jy96n03v-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 15:40:20 -0800
Received: from intmgw001.06.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 8 Feb 2021 15:40:18 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 94BAE62E0971; Mon,  8 Feb 2021 15:40:11 -0800 (PST)
From:   Song Liu <songliubraving@fb.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <bpf@vger.kernel.org>, Song Liu <songliubraving@fb.com>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH] checkpatch: do not apply "initialise globals to 0" check to BPF progs
Date:   Mon, 8 Feb 2021 15:40:02 -0800
Message-ID: <20210208234002.3294265-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-08_16:2021-02-08,2021-02-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 phishscore=0 mlxlogscore=644 clxscore=1015
 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102080130
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BPF programs explicitly initialise global variables to 0 to make sure
clang (v10 or older) do not put the variables in the common section.
Skip "initialise globals to 0" check for BPF programs to elimiate error
messages like:

    ERROR: do not initialise globals to 0
    #19: FILE: samples/bpf/tracex1_kern.c:21:

Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 scripts/checkpatch.pl | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1afe3af1cc097..24d1856187651 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4323,7 +4323,11 @@ sub process {
 		}
=20
 # check for global initialisers.
-		if ($line =3D~ /^\+$Type\s*$Ident(?:\s+$Modifier)*\s*=3D\s*($zero_init=
ializer)\s*;/) {
+# Do not apply to BPF programs (tools/testing/selftests/bpf/progs/*.c, s=
amples/bpf/*_kern.c, *.bpf.c).
+		if ($line =3D~ /^\+$Type\s*$Ident(?:\s+$Modifier)*\s*=3D\s*($zero_init=
ializer)\s*;/ &&
+		    $realfile !~ /^tools\/testing\/selftests\/bpf\/progs\/.*\.c/ &&
+		    $realfile !~ /^samples\/bpf\/.*_kern.c/ &&
+		    $realfile !~ /.bpf.c$/) {
 			if (ERROR("GLOBAL_INITIALISERS",
 				  "do not initialise globals to $1\n" . $herecurr) &&
 			    $fix) {
--=20
2.24.1

