Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68923ED30C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 13:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236189AbhHPL2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 07:28:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11090 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236120AbhHPL2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 07:28:11 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17GB2QNV192188;
        Mon, 16 Aug 2021 07:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=ZAJ3HD3hTF9FDZadWiASIX8CDNpECPY8KCdTJNIjjHM=;
 b=GC9onUdfwb52C4GLSbFOGe7WFXDDpFrrP9YFKD2sbCYSE4c621cSAyt0ptnDURRH1Q5i
 YHy6kJAgDl0CmciB1jnV1ciOEOuwxkpwGqtfGGcg8FI23e/h52Oo30asoIrPTQxTq7ep
 OphMzvoNxDLiJpuDkeCVceuVcrAKXrxZEcWqrxD1b2GeLTiNDNj92DYUlNaHAggg/2xf
 CPFSA3F491JiE0yf/IjlkxYGz9StINKR+GXhp2xgkNZIdQSIMFg9cvi/V8mbAIYMhD9V
 AUPET650pFfROcp0giDydGsmvPJPM3moimLp2cyGukZJBqNXzyijqbK0/AqqKpyr0Avv eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3aeu4c4tr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Aug 2021 07:27:36 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17GBDwae053170;
        Mon, 16 Aug 2021 07:27:36 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3aeu4c4tqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Aug 2021 07:27:36 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17GBOAYQ030342;
        Mon, 16 Aug 2021 11:27:34 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3ae5f8b52g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Aug 2021 11:27:34 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17GBRWAF50856344
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 11:27:32 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63A32A405D;
        Mon, 16 Aug 2021 11:27:32 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBEEAA406D;
        Mon, 16 Aug 2021 11:27:30 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.8.54])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 16 Aug 2021 11:27:30 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Joe Perches <joe@perches.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Simon Thoby <simon.thoby@viveris.fr>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] checkpatch: make email address check case insensitive
Date:   Mon, 16 Aug 2021 07:27:25 -0400
Message-Id: <20210816112725.173206-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7TOh_Kv5DiOC4-kZ1NTMprN71iPGa6MD
X-Proofpoint-GUID: KpgwfF_b9DfnT4XBXxGvsJ4zrUVY2eDW
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-16_03:2021-08-16,2021-08-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1011
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108160069
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of checkpatch requiring the patch author to exactly match the
signed-off-by tag, commit 48ca2d8ac8a1 ("checkpatch: add new warnings
to author signoff checks.") safely relaxed this requirement.

Although the local-part of an email address (local-part@domain), may
be case sensitive, exploiting the case sensitivity of mailbox
local-parts impedes interoperability and is discouraged.  Mailbox
domains follow normal DNS rules and are hence not case sensitive.
(Refer to https://datatracker.ietf.org/doc/html/rfc5321#section-2.4.)

Further relax the patch author and signed-off-by tag comparison by
making the email address check case insensitive.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 scripts/checkpatch.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 461d4221e4a4..1efa2997df62 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2909,10 +2909,10 @@ sub process {
 					my ($email_name, $email_comment, $email_address, $comment1) = parse_email($ctx);
 					my ($author_name, $author_comment, $author_address, $comment2) = parse_email($author);
 
-					if ($email_address eq $author_address && $email_name eq $author_name) {
+					if (lc $email_address eq lc $author_address && $email_name eq $author_name) {
 						$author_sob = $ctx;
 						$authorsignoff = 2;
-					} elsif ($email_address eq $author_address) {
+					} elsif (lc $email_address eq lc $author_address) {
 						$author_sob = $ctx;
 						$authorsignoff = 3;
 					} elsif ($email_name eq $author_name) {
-- 
2.27.0

