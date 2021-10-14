Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2AA42CF7F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 02:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhJNAXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 20:23:25 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:64676 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229496AbhJNAXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 20:23:24 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19DMYX4V028682;
        Thu, 14 Oct 2021 00:21:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=vC8BaRfi+45a4+pelne4vtrg4Bq+r2JQgPr9zbftHug=;
 b=pjcuBDOgZ31jF1DlTOzlq5frHhTv/41NWZ6zufUH9gVbe7+nneRYb/kkUU8H+dxA594Y
 QKMFmBPjtiQBGw95uCatOPyk+jk/oMS18AEVBs5AY9ke9APj8SANEwpm9UcUus2/Yfkh
 bDPB2V4miobqe8zv65mBwmQTiFj3b/O3zEE2LgH/K9LdpmtEgfy8XiOA6tXtkcZV7mtd
 N2NnFxYli0tv+9XOgkFzI7eVWSs262fzv31YKh80Gp+bvzLMRslQqncCOq2OW3QN2O56
 8GapMdNWVG3AtDw0lhbm6zHX3i6AVbzGjHdfCD7C36046U6+ntmZD55cuUjZGfflQr4u Rw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bnkbkfh0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Oct 2021 00:21:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19E0FBL9107166;
        Thu, 14 Oct 2021 00:21:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by userp3030.oracle.com with ESMTP id 3bkyvbqujg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Oct 2021 00:21:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ge17ffF9yFlVhrh0GJH5/l8Njg87cDmyMZnztLP0Au1K1+NBnJfewcrWadAWnqdSLtSCYmubGNTTp4alZIMNMbZMKygduajOHO8VlG5h0ICMv8UX0MYJatpAPe3lCw5a0JlTiabzRtODHYcEqV//zE9TfHf/IB4YoJpwaAcMSJfB4HNXCost2FfBAyzUIIhlM8rZn3rHELHFq3QejTBvunjTcXNvt66UDtV1dnVFhqCY7RpQi8Fz7tU6X81jlqwBxl7zJk7aGZxfHClxLMy2mWb4FQqw5x+fk1CZ0vAaGg52u4FYrNcEW5fEZgmiVQuL5Xjv+epL3d9g3RbhvqfVnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vC8BaRfi+45a4+pelne4vtrg4Bq+r2JQgPr9zbftHug=;
 b=HJSx15Qr3NW6DTbJN9599fXchjfvFyXVnSnJpZNp/w27F81fC7g04u2fs/r2ftWE2D5pXGXcnQF52h2w84VbszWBDg/DbBE03nLopIo77Q62Us+KDVl2Wkchh5nYHS4BNF0DzrZCtLESy/QpChE0zI9ZotEsI9S+ongSNdytOY95pLe+3J/L6nn8B6ljPZiBwGHu7/EUfpLn5aXSa/jyGXda+UjLgDG77ZBn4ucOts3x38yYHoGGF19CKGY3Zw+76valMcGnG1M+KEgevntW7N1gzjo2s9nAuAIWutViDh7qoh1wF98sR9lXMqEshGsT85RuQiBD6zKukZ0CVBmhCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vC8BaRfi+45a4+pelne4vtrg4Bq+r2JQgPr9zbftHug=;
 b=zhmkOz7/1vwiPi9PtrWi6gqvrQJGif7+jcwoP2n/t9PGxSNzRCpJQNawdFGHPxDebLB9n3sL8VauLl5uefHybGestomnoOckRvuRZ0HkcX7SbBRyh+WgUNTGWrAc6pdVKNpxKTdLvLThz9puLIqbtbaNZJPHsNkV922squ1O6/c=
Authentication-Results: shutemov.name; dkim=none (message not signed)
 header.d=none;shutemov.name; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2661.namprd10.prod.outlook.com (2603:10b6:a02:b2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Thu, 14 Oct
 2021 00:21:02 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5%7]) with mapi id 15.20.4587.026; Thu, 14 Oct 2021
 00:21:02 +0000
Subject: Re: [PATCH v7 2/2] mm, hugepages: Add hugetlb vma mremap() test
To:     Mina Almasry <almasrymina@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ken Chen <kenchen@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kirill Shutemov <kirill@shutemov.name>
References: <20211013195825.3058275-1-almasrymina@google.com>
 <20211013195825.3058275-2-almasrymina@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <2ad01712-1a2d-76dc-a2ef-2fc4650c74cf@oracle.com>
Date:   Wed, 13 Oct 2021 17:20:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20211013195825.3058275-2-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO1PR15CA0105.namprd15.prod.outlook.com
 (2603:10b6:101:21::25) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by CO1PR15CA0105.namprd15.prod.outlook.com (2603:10b6:101:21::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Thu, 14 Oct 2021 00:21:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 637da8cd-7add-46ad-b4bc-08d98ea880a7
X-MS-TrafficTypeDiagnostic: BYAPR10MB2661:
X-Microsoft-Antispam-PRVS: <BYAPR10MB26612DA867E23C696BA8925EE2B89@BYAPR10MB2661.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0REAoWlKt/ylr0RuNJ7nBCYf3wsmqvQGISWOR5a2a23pYZ2jDJomHXIw9SbpcuCN7PZL1j+cVv9VCjpwgyU9WAZfqLFXz7Yp0ZB2T3s5m/KPR1/EX9kreZ/ZexhdLAYZU5oXisTPfYTqmSBAq+uqKf7jMbrXj4b/FMQzUXa+JjjCfEPvbCaLnH5zvlgpDlqWTS1xMkDqND+zdgs6fHXWsAHUFpUutAr+wVGyvkanSrzRYS/YFqJ/TNllG3ON7SP2zhUtfX/987NBGT3bOBsXJL7UNExHygzheCmhnOOI2Crz8M0JDBtEPxeY5+eEdH9t0rvuRR0Lf1iXeOFsCKX03T53ck7BBfpI7s90MtRnpl46fL2sHBC42mLQm0ouiGyhDvNyjhPjlfWYCd5Q+z9cuW0R8I5+NZ2B53AYHZfYaxc1DxSVOTsI+s51eXsg4ZZL4lAEi8OLQf5wEIZ2uv9ABQRudRGWBXxhNtDFSA5wxYURjnzpDpels8D38ma40XStDPRBqqThxo8+eFFZsYftEEL1otjur1ynwIoUJt+l/1DC1MBWSpcuc2/jMpQTopPE6m3vPmEdDWvpzGX21cjLDzZtYGKFh/6WTpYrOvYxl9u1vP9CfWwNsI++DFfBp4v3uKcINmmKQZW1gnj/Mv0gcRDo7l7qhbbebc/5pNgDOKCBvTy5fhGnUZKwOQXGH/a6JmBBeXM/TNDd7sKVS/Mjs0ZzRANrwzOxEc/mu77Cr5mJXyOSRd/C9Vit3Uw8oS+m3AoXz2eRYTGNMcpn+ks4j+KavVq4AiCqeYvGd8NFkvFvblqhMiZKABU5VUNOHrAR93g47gxE+SAzKHk0jhztBqtS2X2iA7bog9aJlAwZzr0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(186003)(38100700002)(16576012)(6916009)(6486002)(86362001)(8936002)(2906002)(83380400001)(66476007)(31696002)(38350700002)(66556008)(66946007)(8676002)(44832011)(54906003)(52116002)(26005)(31686004)(53546011)(6666004)(4326008)(966005)(2616005)(36756003)(956004)(508600001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkhYdHNmQVBpMnhqbFljWmE5U0U3bzVHOVFyYUVMY1JXOGt1ZmM3MnQveHZJ?=
 =?utf-8?B?UUdwbmJ2UHhSck1teXIvOEQvWFpGY3hzZ1FDMkdTK0N4OERwQVRwTWd1M0pv?=
 =?utf-8?B?V3J0SjZPc2NsNWRZK1BITnFmbE9QU2wxeHpwQ2RtMmMvOVFocG5zNzc0WWhT?=
 =?utf-8?B?S1d3N2JaekVHS0ppbEhwRWhpMEQ4cGljSHJJbDZ5OXhQc1Q5N2dVdzVwQW50?=
 =?utf-8?B?c1F6K3pFRHJzOVo5cFRQR1lMaU5OcUNqYUpqQ3Q4K3NIZ3hmcHRVNVozVlFV?=
 =?utf-8?B?RngvWWhRcDBLVUNsb1JtT25tZFgxRjN2dlhnRWVRaDFaeGdrL3JIZHl6UDBJ?=
 =?utf-8?B?d1RzVGRTRE1Gb3NMc2ZmNW1BTmJNUzFWUUNzclQ3N1pWbmIwbnpQYnBvR0U4?=
 =?utf-8?B?NDJ5OGxINno1dXNETDQzSGlIc3JGRzdHUHBpLzVqamw0anpBTi9pUFp2UEg5?=
 =?utf-8?B?SjlTSXpvQzV0dVhEWWxmaTBhNkd0bTRub0lSd2F4RzZ0Q0FCSVV0cFZmeXRY?=
 =?utf-8?B?V3lFUmVKdW1LaXY0Ny9IS0xvamZuNE53TjdkWmFubnpnbGNmak11S3g4eU90?=
 =?utf-8?B?WE11ck42T2xwSDNwWFJPYUU4K1JqcFhHYVk2U3Q2cVFsSkp3MFdqTHUrUmVa?=
 =?utf-8?B?aGtkUTBPVFJsamY0Nmx4eldNckh1bVVBR1ZGSk10a0ZzRWRSY2k2ODdiZmpp?=
 =?utf-8?B?UklIYUx3NjkyTlUrRzV0Q3R1QUFSZnZGdUhPQTg3UE15QTFlOGVJYmIzRUtZ?=
 =?utf-8?B?WWdZcDEwNGg5UVNCM2FqcmY4WmhsMGU5dFVKcVUzUkNyVkVKWEJNdjFQUHZz?=
 =?utf-8?B?WmN3b2U4eGhRT2pWUzJYeUhGeWNKRkhGdWxXSzVRY2ZYb0FJdFhOWmJXSmlD?=
 =?utf-8?B?UjdnTU5VZWQvTGpmKzJLWjR3cHNCbXJERjdCS3NzVHgwSm56N1NNK051c0pr?=
 =?utf-8?B?cTRYcGtKSW5JZUw0REx4QWpDeFZWUGdFcm83ZW1SeVY3ZFVCcWNuTzFXVXQ2?=
 =?utf-8?B?MUhkZTZXN3Y4d0NZeW1HSTBtSEN4TmtnUDdQN202Q3pZK0Q2TUdJRGVhbUIz?=
 =?utf-8?B?ZGk0NnR0aTFuNmMvUy9vcW1ITmJsMmdlWnRTZ3doQld6RHRJdk5ZNERmdCtz?=
 =?utf-8?B?MVRzc1REYjNqMTNqL29QMFBBZ2xNRTZ0OXZ1cHFIWGhxVEJOemRaOTBQeGdB?=
 =?utf-8?B?RHg2a3FReHBrcWFJeTMzZldZR1NrMWdLNkM0TVlyQnRyRzBOSU10RXYySzI4?=
 =?utf-8?B?cVM2bWMxcTZZVHgyWVdZVndpRWVhM211Tkd0VlFWQitHclJJSGlwVi8zYTBh?=
 =?utf-8?B?Nkx3V2Y1VWlnY2xvdElNQTZPT3JtRGEycEVJckg4WHFyQ250bVB1dXpXK2xB?=
 =?utf-8?B?V3UrTjJTUWJNU28rUW9PRjdSTnU0NE1Scnp2U3lNbmorVi9KYy9XY3NqRlk3?=
 =?utf-8?B?Qm1HMGkyZVF1ZVlySDRCQWpBVXVlRElHUWlJTGp3dVBKaW9nTndlZ08zcHU0?=
 =?utf-8?B?ZHdFUEpKSHdsa2hzdUtXSmdnWjRmaFNSZE03OEJkWXN6RkZUVHhSSjAveGlX?=
 =?utf-8?B?MERoTXJYWXIwOERnUlJ4Mmg1Wm5vUUFYc1VheTg0UUh1SGFuRFNaVE93cmZu?=
 =?utf-8?B?M1RZWFhYNlI1ZXBiWW1qbE4vekVLNlNUNHd2VnlKRGdUUXNPWGlYV0JpOUhV?=
 =?utf-8?B?RDJORlc3amFPSUFBWmFJZWpUTEUwWkJJREZ4N01IWWg3d0Fub1BVNlp5ZGVi?=
 =?utf-8?Q?VcWeI7ZhFsEri3L8o40asyMBFmj8P3U0EFe/kH1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 637da8cd-7add-46ad-b4bc-08d98ea880a7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 00:21:02.1247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8WHQAiTe6s7NImYm+on43o5ASO93B3Clz9AJujCDOWRGs2mX+XvdFOOyNklInL8zpbNJlIZiWIyBj0+e/vNGsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2661
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10136 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110140000
X-Proofpoint-GUID: _v25rL3hudBviulwcghd6fUvbIrMWh3x
X-Proofpoint-ORIG-GUID: _v25rL3hudBviulwcghd6fUvbIrMWh3x
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/21 12:58 PM, Mina Almasry wrote:
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Thanks for adding the test!
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>

How about adding this to the run_vmtests.sh script with something
like the following:

diff --git a/tools/testing/selftests/vm/hugepage-mremap.c b/tools/testing/selftests/vm/hugepage-mremap.c
index e84b79922fe6..c7ffbc848542 100644
--- a/tools/testing/selftests/vm/hugepage-mremap.c
+++ b/tools/testing/selftests/vm/hugepage-mremap.c
@@ -3,12 +3,8 @@
  * hugepage-mremap:
  *
  * Example of remapping huge page memory in a user application using the
- * mremap system call.  Before running this application, make sure that the
- * administrator has mounted the hugetlbfs filesystem (on some directory
- * like /mnt) using the command mount -t hugetlbfs nodev /mnt. In this
- * example, the app is requesting memory of size 10MB that is backed by
- * huge pages.
- *
+ * mremap system call.  Code assumes a hugetlbfs filesystem is mounted
+ * at './huge'.  The code will use 10MB worth of huge pages.
  */
 
 #define _GNU_SOURCE
@@ -109,7 +105,7 @@ int main(void)
 {
 	int ret = 0;
 
-	int fd = open("/mnt/huge/test", O_CREAT | O_RDWR, 0755);
+	int fd = open("huge/test", O_CREAT | O_RDWR, 0755);
 
 	if (fd < 0) {
 		perror("Open failed");
diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
index 45e803af7c77..a24d30af3094 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -108,6 +108,17 @@ else
 	echo "[PASS]"
 fi
 
+echo "-----------------------"
+echo "running hugepage-mremap"
+echo "-----------------------"
+./hugepage-mremap
+if [ $? -ne 0 ]; then
+	echo "[FAIL]"
+	exitcode=1
+else
+	echo "[PASS]"
+fi
+
 echo "NOTE: The above hugetlb tests provide minimal coverage.  Use"
 echo "      https://github.com/libhugetlbfs/libhugetlbfs.git for"
 echo "      hugetlb regression testing."
