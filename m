Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03CA3EE01E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 00:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbhHPWvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 18:51:33 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:42512 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234095AbhHPWvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 18:51:08 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17GMmh8b026759;
        Mon, 16 Aug 2021 22:50:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=T7aTzh/od8/z0na96515K7P39K5dkQ+t5If8qBwYzOo=;
 b=edybYuwKLsJcrHvoByUDAeW0vJ6YYB1kJyahImddiYC15m74wZxiTQxDPry+iMHvMcG/
 2A7mh0zhqan7MCGSAaYlqGw5IYJJ0WPRfnADa5hLhkSoy7G+GAVi+caek5c6JbLgpseT
 fcVcVFdw+YlkpTgCpmjQDBjM3uxSgz5k5sS381A7a45QFX+SNRpMph0/0VoeVAlnOST2
 wUHqYWJzduMIbRIsTSZbYPt7d6LhJj0diqcmgyUmLXk3Wh8RArTEZdbGCkG31gpfDK94
 9NQc8pWqp0UWlCOAfA+6mGn4ONbnRKk6vYd5B5BF4lr9f1AfFcBZtS6qFO5cQJZ8hOmu wQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=T7aTzh/od8/z0na96515K7P39K5dkQ+t5If8qBwYzOo=;
 b=Sw2ML0E57kLi6DKyz3Sanuo9uqKvZvyccZSFgxr8l9S9QfqWLpifWy8MqpX5//UZNZ5r
 o7V3XACI8yNtA2RS/jpLEG08r63cQ8iDKIisiVN/TAKQl3qiHhQXYvBYsMhi6ABUxOM9
 0WFkWnYP0y1qURieH9kPi5x+SXjiwMSiu2OUvw6pcbI4+psWWbB8SycjYv2t4OO/s5zH
 8/mgTnkZmHzULAbIENdGL65EDSeO8DzaJoKf66xHxeL238OMq3x5QwpqXIt6UAHv2nkC
 /kTMorsfgMpw/WB52PJDX2E/cysTIH71jv9pp5SRPjnaNw5ro96DtG2y/Hxiw5IclTBh Yw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3af8303230-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 22:50:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17GMium5171583;
        Mon, 16 Aug 2021 22:50:18 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by userp3020.oracle.com with ESMTP id 3aeqkt0pdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 22:50:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWCALtwRpId2oZMwZXesu/AG9pf9Tnl4EEmBAMItKUNZxUQxjFSoLGm7//fJ0A7/sulFqcAyWB4OnhluNHWM8Y1dfz0oVA0wHLxvCcqvXt45EKJc60RvvpRKoxWvWqr/vGfd+PE3wTiJ6FeMQnByOv475hhyBHya48b4YdBiAua12KlmS33NhZms1Ia8Fr6BhALHFh+eWijZn5L65nqL8zV0+3Y37N/BhptOZHVhfZQJeF6qoQGGlNSgn3DMxYhFLQrMXt6bflhNaBSp4gmnYiEX2FZXOizKeM68Mmg3IeYias1imOUlopLpQCsbP1fSVxYoCirclEfM3D1xwioD7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7aTzh/od8/z0na96515K7P39K5dkQ+t5If8qBwYzOo=;
 b=hQQeK2zW1mfsbyBcJE+5kShuMheKMTyQMDUWpgheEEBb0vyJItMFM7uSeMJmLWDRlt/3U1sWkqyWSrgEW//Am/+HntsA8KULlebj/BG/Yd1DZaNpsEz6oBocJSmqCBJFeum50tdXAM/gwrKbS6+179ZV7ORy1a0eJ13R/TOPxL6uWu0buQJckfnsTR+9yDUsFhGYnPelk4CwN7QOIU6Tn9pCv14yeVHJqlkKBPkeCQUwyNgldqUS2e2j2Q5xjuXZhq4Hxp/pQQOTyr4qWnGGrMhzwPrd//zx/Di/PxYKC5L+KstUN4rIId6b/1rnwEAUKC+OGticqYCr20WgPXpHDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7aTzh/od8/z0na96515K7P39K5dkQ+t5If8qBwYzOo=;
 b=AxDhJaaSmzT2IiMVzRxn/qyGn6otG1x9VfJ7W3Hwscopa8dT0/Lbv7SXYx7s+a+3xcusl9+oKx/VtwX3hM6f2e2cF0cNc4zV6QzXZAToG7GAmeHWaelY3rrZ6X/MPNMLwA5iV5m3tGnin2Td70UVAZvQK88ucKnL7vUqMFgQncU=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3397.namprd10.prod.outlook.com (2603:10b6:a03:154::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Mon, 16 Aug
 2021 22:50:15 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%7]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 22:50:15 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 5/8] hugetlb: document the demote sysfs interfaces
Date:   Mon, 16 Aug 2021 15:49:50 -0700
Message-Id: <20210816224953.157796-6-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210816224953.157796-1-mike.kravetz@oracle.com>
References: <20210816224953.157796-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR06CA0030.namprd06.prod.outlook.com
 (2603:10b6:303:2a::35) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MW3PR06CA0030.namprd06.prod.outlook.com (2603:10b6:303:2a::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend Transport; Mon, 16 Aug 2021 22:50:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab0beb7b-ceca-4e84-a3e0-08d961083689
X-MS-TrafficTypeDiagnostic: BYAPR10MB3397:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB339786830A71AB9D488D36ECE2FD9@BYAPR10MB3397.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qLLHsMKs32gTY5t9RdyqVDAiSiE+VFEaKaARm5cwZqrxN37qsNOEvog3pgfrWegj9bQ4R7jVNoYr3oL+7oWpMPDpLOHylwzLWxAI7zJeyUTbiT5/yo6Y/v5tp5niYkIwgizWm4dKPuEl7u+FlWipjCWuPGUUy4DNNWIA71f+C8bakM/1uwZ6/giw8oI0gKtcvz1yOrdPsUfJhLLDbah7v8+Fv/iIK22TvrMO0MPUxG6bqsIJ1y7ga7iv6wzIRkXui7C5SB+ZROF3uN36B6w8Z9Z5th6yfdiu2Uv8NSwVC//KwVZzPsYp60VVoIMzqstrOnd8HrbK1KvdI2UnI46LSvZgtuf0UjndkWyr4F/4nGL2d6RjHGsqCA5HTdf7kzxXtS+JeNtKn/f0DI7am6FKdCnC9rdkOQ99t2vj97Mfd/vjfcusH9fzqGnqTUP4qytnFYy29dFstxYtb4Dp5R61zjvPROrOyXZ5Djf38IOufO3CzISYnhcNRD7vzrTNO3kFOUw+jtImO254iI7yHrGVNOdyJyJDXZek/VfWpff3bib/lUg+i9HcUv/oqhYw2DXgZC7LTXuKBqezLbib4r+sa5oz8vT2kZUrn1pnzVfW8twAZwuEPm57cyxwoALC8yogMOpKftpKzezOkWimC9OXdNSnRwLeHt54yG/jAMTEguv5tYZLJhzFdz0p/kK749aBdlF/ns5WbqRDDIihEl1YnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(396003)(376002)(39860400002)(4326008)(54906003)(6486002)(956004)(2616005)(107886003)(44832011)(316002)(7696005)(8936002)(8676002)(52116002)(1076003)(83380400001)(38350700002)(38100700002)(2906002)(6666004)(86362001)(26005)(66556008)(66476007)(478600001)(186003)(36756003)(5660300002)(7416002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S1uk+sCyC7hlX2XXiWeFbcP510jfYXVQLd6maRFkURO1C8Ifr30lv91QK/CK?=
 =?us-ascii?Q?GNfdb3L2eDUaZ4vwsSpKDCRSk3sV2y5fI872+a3yOFOj/qLn5SwPp5RLGufV?=
 =?us-ascii?Q?mytcOPPgx17tZvkijCk/t1CskVTMp++8U8HLN+dR6T0Adrlte5BnMMGIV4L9?=
 =?us-ascii?Q?/uuGnwKI2KgSxmXI7X3L5Wa8tD6gXRsnwuo2FhS/CYMQfR/IGN3GlWcbl9rG?=
 =?us-ascii?Q?I4zzKo+tp4Ov+TN0sUQZhmw+xorMNxCPGREB0fIBSRJsfjbUWro3k6PWypww?=
 =?us-ascii?Q?AbtpTW7bnzF3MYZIKZo4/zJu4wJvD56S+D+YNyLkP2nuPmPN5a4vk6L2xbC8?=
 =?us-ascii?Q?CFaKScJjlUoI9KNCUN+uqHe6Vj/dDOyN1EDsD7dg3E0Ym4vbXfx5iLPWRM87?=
 =?us-ascii?Q?iM8natJSApEvx3FyrUEu6CH97e0wCcEd9QFdbNge1qA5eJp91Xh/fzPJBnf7?=
 =?us-ascii?Q?s0Uy0j8NT2L6VP79K+xrHgq7DmAzdo0+fEGFVrZMp04CrIsLOBQEhrgfgGTd?=
 =?us-ascii?Q?LSpD2lSSuHjU9QIRjdDsmhmyTroaith+4J4NIfE/YZb35gDbvk+Ucw3a69E1?=
 =?us-ascii?Q?T1cOeQFe2NKieaJ7lDlOtmCCZe6msdUILQ/MBAa1XAsdXt14QVWoMqS76Y+v?=
 =?us-ascii?Q?RakEUYeeukVLC56WAaIsrb6jn1AKr8epCFW8TqGYXKrw5H2WN+5RklWMdEX+?=
 =?us-ascii?Q?lWOfCv/18fY4Q25BySIc8S9BMteAN4LD+/xp0ho+7t/Nl6bWnqfrXjIC2jG4?=
 =?us-ascii?Q?elW0pjObjwoOrk9DBnatb7fOkQxb58SpQmPItefEsmk+xM/98j9qWTWqPl74?=
 =?us-ascii?Q?MEOIilze65sDMUwdXQkaaMzpGTrg5yo0NUzECU5ivEOdnv4YaIsBOltp7x8M?=
 =?us-ascii?Q?E/NisnJxesu6ogwjd/CxGASYQLVtnu0jnUApW8vPmpCVdB/dT1TJu7C0Q5Uh?=
 =?us-ascii?Q?DzWJmoTe3otDyNdqiy2lNN/LsuwCSP8nYFZ618Ho13iqEpoc/7MQ2YlPMiz3?=
 =?us-ascii?Q?gf1KuidviiakBsgYQV2G2wcm/GF+N2bMAVAMQUnM6lSFXvXyHL0e5d/M5xl/?=
 =?us-ascii?Q?fs0fcPu02gmSdURXiXyAg/7ZkbFnQOOZ9tPXrtPQWbSxWEBe/rvT58KzT7Cz?=
 =?us-ascii?Q?XRe2VgIR0p1l9PQLViUz2Qk8Mcb20NJYZQuFDqAted2y6bqOdBAsm9L8YY5o?=
 =?us-ascii?Q?W0ZclIm4XZJR8FVk/g+tel8EtANEWsDO6bFtiLNJ7JySZZ2E7ZM4GeuLmmq5?=
 =?us-ascii?Q?Rf+j1pzmZ6o4bEkdnpCmNI495t2JrNJGpaIJ0JEu4H0oiWTp0xf1kX2zaW6z?=
 =?us-ascii?Q?brqH9U50xvJKAqqItgilbbxd?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0beb7b-ceca-4e84-a3e0-08d961083689
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2021 22:50:15.3761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +EyTKzbcCLcFY+v/rxOCwRLgrPE0GvAwOmKnuqdJaRxp/NIXsKBydPtASgpe5+GmC3h0+jiQ4zuZbwNREh1h4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3397
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10078 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108160142
X-Proofpoint-ORIG-GUID: 2I9iKlqgijKvhs5LA6_8Mt-ygu8mJ1wm
X-Proofpoint-GUID: 2I9iKlqgijKvhs5LA6_8Mt-ygu8mJ1wm
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe demote and demote_size interfaces.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 Documentation/admin-guide/mm/hugetlbpage.rst | 29 ++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
index 8abaeb144e44..902059a0257b 100644
--- a/Documentation/admin-guide/mm/hugetlbpage.rst
+++ b/Documentation/admin-guide/mm/hugetlbpage.rst
@@ -234,8 +234,12 @@ will exist, of the form::
 
 	hugepages-${size}kB
 
-Inside each of these directories, the same set of files will exist::
+Inside each of these directories, the set of files contained in ``/proc``
+will exist.  In addition, two additional interfaces for demoting huge
+pages will exist::
 
+        demote
+        demote_size
 	nr_hugepages
 	nr_hugepages_mempolicy
 	nr_overcommit_hugepages
@@ -243,7 +247,28 @@ Inside each of these directories, the same set of files will exist::
 	resv_hugepages
 	surplus_hugepages
 
-which function as described above for the default huge page-sized case.
+The demote interfaces provide the ability to split a huge page into
+smaller huge pages.  For example, the x86 architecture supports both
+1GB and 2MB huge pages sizes.  A 1GB huge page can be split into 512
+2MB huge pages.  The demote interfaces are:
+
+demote_size
+        is the size of demoted pages.  When a page is demoted a corresponding
+        number of huge pages of demote_size will be created.  For huge pages
+        of the smallest supported size (2MB on x86), demote_size will be the
+        system page size (PAGE_SIZE).  If demote_size is the system page size
+        then demoting a page will simply free the huge page.  demote_size is
+        a read only interface.
+
+demote
+        is used to demote a number of huge pages.  A user with root privileges
+        can write to this file.  It may not be possible to demote the
+        requested number of huge pages.  To determine how many pages were
+        actually demoted, compare the value of nr_hugepages before and after
+        writing to the demote interface.  demote is a write only interface.
+
+The interfaces which are the same as in ``/proc`` function as described
+above for the default huge page-sized case.
 
 .. _mem_policy_and_hp_alloc:
 
-- 
2.31.1

