Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B67343BCDC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 00:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237303AbhJZWJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 18:09:34 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:61160 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234834AbhJZWJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 18:09:25 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19QL5CxL007140;
        Tue, 26 Oct 2021 22:06:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=wpJaVM73rY/OMeAOivsT+xjIS5v+jJbjnF5fVTXiYew=;
 b=YADW7jG/t9CLFEQlJBxwmYKgjy8nE2JWefDYLklDAmBe/v8hgsHzZ0QX6vRhM30EoBDn
 +qu3LA2rDF4OfTliCcKRT7Mr1dgL6L6sIUnI97c7Vb/p+mXXniL/5ED0B/+cVAK7b5Sg
 wXk+MKUxTn7wj7E6km/gmX/+rZvJWz9uUuZnuc/GN+u/oHEuTc0EXolcBcb/dztddult
 2I+6F4flsoVzWGZ7lJ4J2DFd9m5xMSkGM4GVGGhZrrOFqWAQ7Is0AKIIttfC6AJ/BGvY
 smRH8S7GYHUcAKu+tTH752qSGVF9KyCjv1Xnoj5i6cKHVr22YPKB+R6AUve1oJhBC0Jv SQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bx4fhyhwm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Oct 2021 22:06:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19QM1wka015492;
        Tue, 26 Oct 2021 22:06:53 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by userp3030.oracle.com with ESMTP id 3bx4h1ce2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Oct 2021 22:06:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8C+Gv1INAOuLpEhWqvkACCId95DpDtKf8HFc5TbkSx88a31rBfangUVUDwNmo4mdjQOGertP1O6KeadZoDXOJ8ZPwe2Iz6p3D3D5do66hIzSdS7cDBVroTliJZ4V+G9pVBIbImqTzVEdDzcXIa0Pj+eZ2G4pCXNxf/ac004bqROmTIT4ClFNtNS3Gl6f11vLZQwTfIYYvyJUE15agAiJMErn5/mhiFMpTrYfGm2uAfhzx7ld//xw+H5030zptYyCrqEUrNpsuF01w5+K46hA0vH1s8pUd0qMq73ICuvy2IxaFdUjq/QxvCWm3oUIuyrrP9quyddxj9NDpAfEju3uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpJaVM73rY/OMeAOivsT+xjIS5v+jJbjnF5fVTXiYew=;
 b=lh7G9yc3Ng+WgNQ46PQEMMeloL9MzRisT3ktG2elsbGc9ctjCVtxmnFwWQEvHViQZLRbfEBY7jZarOciOfxbaZyJiJm6Ga4RoxZopdc8qu+c/eUek4C/83hlUAbdq0KEP8gBZYoqveO0iZME4qH0DtehdZV3QzPDSdLPT015IBU1e+9FkV04LR1bHvJShX2a6rVUHYv6IneTmrpnhTUlbrpZcgEh3LLKjevpKcMi0iasLHreaxeg1tFWFJTr2sF2cIg/e6h7g6ju+Ou8Adb/sPEB/4IuE899Ah709C/BaD5fttTp/3MN1UtczQNzweOoQhcWKY6F0Q+5/dyK07MAuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpJaVM73rY/OMeAOivsT+xjIS5v+jJbjnF5fVTXiYew=;
 b=xqRj9yJaIA7oT9SmdJuI0Zod9RKDNjlf4ZuFVM2FUN5sLYv1EbidVJATjkrNgMbTNevFdnE+DsNR2kGSQ/8nylWIe38yDKN8w9CRJWAolMK41rRVsEOa4gXQYPlOhVzt1azR9LsIK9SGEbNzF2ksBom4Qqn6C4S24/efOHRRaeA=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2614.namprd10.prod.outlook.com (2603:10b6:a02:b0::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Tue, 26 Oct
 2021 22:06:51 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5%8]) with mapi id 15.20.4608.025; Tue, 26 Oct 2021
 22:06:51 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH] hugetlb: remove unnecessary set_page_count in prep_compound_gigantic_page
Date:   Tue, 26 Oct 2021 15:06:35 -0700
Message-Id: <20211026220635.35187-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0200.namprd04.prod.outlook.com
 (2603:10b6:303:86::25) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from monkey.oracle.com (50.38.35.18) by MW4PR04CA0200.namprd04.prod.outlook.com (2603:10b6:303:86::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Tue, 26 Oct 2021 22:06:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95d8d82f-4403-49fd-6066-08d998cce975
X-MS-TrafficTypeDiagnostic: BYAPR10MB2614:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2614C9394FDC91378C37C3D5E2849@BYAPR10MB2614.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:366;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WDjvaWkL6Fu3H/hJw1v3cD3kJNWlmDFRuD86Xg6YbuKteybEY6xIT3O0X+ER8B1L6cEavcVSv2uAsFTEF4UsWAL2RysaZr9ViQOiQLmCqdtqZvsrPYq0UupOk+S95Q+3ofH+JCaY5gsKhNyEs3FSYb8p5MlmUDMqbwSC79o2l658jbr1cY5E/K+Nb9gbHTDAcaSZ40wIHmv137Yb30N0t7C+aSou8wZ0xcL0239ZNGF2Aam4a9bfiuT5W0K+DJW+Ts9t4KjuPrG6hIaiAN14Dkxp1sNN/5leCtTm9y+1OzjPqKuPVuM30EXbwIuJ4rGCiXIU5/bHm5XXRfhXfS03oQz4mg6p/dJvOPvbpJrXut3oxpYmfHgVRKMkIVRs0e1RPCJHdA5deQQ2ygdqWgXJw8gNJqekljowhGM+yz3xRApCvjGU8ERY5fzeUf5X92MLHJiYsw5MbQBAmi+foKg3/9GK3hnAlnX+7AJXIr/q5tm9VGl2SJGv43WBZWJeb4ee88yAD+r1NBIs4aO+F7+uz7Z/9vOfjOPTCxYO7dwBp8607yrCdUR5DCH1HtFYWQI6th7xjqltcEd07sCsyIOZEJrXWYX1xS6CL5NuWH+dzQhw1hFEF563j/qBFEZ/KqDxcMtSynnr/YsrvguUzAUGUJSQ2VISJNrzg8bXdY1+bLIevXFLOZpz/+LqigGoviMx4LiMDEC2NzrzgJsEbMrvRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(66556008)(54906003)(66476007)(316002)(186003)(2616005)(26005)(956004)(36756003)(44832011)(38100700002)(38350700002)(6666004)(86362001)(4744005)(52116002)(83380400001)(8936002)(4326008)(1076003)(2906002)(6486002)(8676002)(7696005)(508600001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NUbMs2xwtUyWrZv9aBfN/NORurXXFLDxDDl27HDMYEVm2L4+sXi5y1t7brvL?=
 =?us-ascii?Q?4MpLeFfDOLZMO784Rhj1PHiKcU4jvmbSXGGr6vIXX95+ldeMHSwbEuPffH3f?=
 =?us-ascii?Q?s9lmBDZwNNcoTCB0u3+pOpRPoVNtgLmx6O2rQihdOM9HBRcUFZBcLkS6dfoi?=
 =?us-ascii?Q?DHlpckGNAWHDLA9DOBsZt0EV7PFhVa1xtSKM8IqUNAPw19vTmxC3pkuYCOau?=
 =?us-ascii?Q?UVUxM8G4LlICtmB2VvWY4pZyRTJayvVwzoCvIr7ZsUZq3TPk/L0ChOsRemTq?=
 =?us-ascii?Q?Qa8UhXdtOJnR+H0SyDqvdV7XSgEukbM/68ijkbZ/taj4uup2pz+sNMy1phtj?=
 =?us-ascii?Q?8eebLTNgw38dAiIieTKw9yxyRp+DpTYDynNReJcgUyTwsEsjJeXYiXF/SgbK?=
 =?us-ascii?Q?fADYFp9rz9FWwygrLmA1utEPRyruTmReoX5R/gl6hhejWq8Uam6sk73sMFzp?=
 =?us-ascii?Q?UHEb5t2RRRZCCr1tvcMrMm2e7vCoYPS4N2P6DkZb/DV3ugKraq8qVdHR6n8C?=
 =?us-ascii?Q?moXa68wUuP4eNaFXFpnHFp0dMPIlB96lm/KTwDkqlT1KbmFzBg2eJCLvePKJ?=
 =?us-ascii?Q?yoO8nqpqxhZajJrHaB2zewDC7LIyqeucA0HYwqJmRF9/yNv+PyO/uvIKHPqr?=
 =?us-ascii?Q?o8LMHfZCVTi6gVM1haZ83gswLrhx784/RmoMZ4F7zOU2NIkZsVNNQ9PgsAN9?=
 =?us-ascii?Q?wcqg2xpRuyfotck4YNc+JZoums37kNAUdl6DbogBZv+8dS6fGRibLR1jq5gu?=
 =?us-ascii?Q?/btH0iT93pBdN63v7tAPSujsPeE95SrzUBko+OaLBtW9VrKuNuZ41gMX0Nhp?=
 =?us-ascii?Q?o4U/unBxhjTNr/80QYK/Ezl03OERvCCL5jBSs2BEw/KCPGeX5B06SbOw0R5Q?=
 =?us-ascii?Q?vLT9fiDMwMOlhPA2DdlQzWfQjvR2TQwhZWBGgaWrJKdiBd17xPloUPzv/tXB?=
 =?us-ascii?Q?ImMKkg8GvMr8KteZyE3B4cY6Dbrk56BtZwWAeVZgdMElGqqBT0PvUPl7eqcQ?=
 =?us-ascii?Q?9sCw3v1gBF901ZHKmYhQ6a7qGsMFJJhY/p8q3SDRooR1PHdlgtzN2rMwwjxs?=
 =?us-ascii?Q?gBNA15uZKV563Ge4pYagF2Y1huIHtPKKKgK4fGaRb1gV3crQWu5731eKi/dw?=
 =?us-ascii?Q?/82BXBaxx8dPjl7J6l8DyFf1qkhhCwKqjuXP8nxynshTxYJYg/OUQmN337h9?=
 =?us-ascii?Q?bwdJ1YfvJ/dmfzxNIgMgeIdwpRuSgZvyVGdPivt6ckaZ57YtUjxPDcLfHdYi?=
 =?us-ascii?Q?h8c++/a9Hhk5fFm2Rk64XnSv/onrG9de0L7Li6jccV7SmeQxM06yYLBnYJ6x?=
 =?us-ascii?Q?aU9P9hkTYIOYk7Afu7I8DFa7H7cEczAs0fVwxpO/u0hq9TiEtaCzehuJk8Ka?=
 =?us-ascii?Q?uYFoSA8zoz+JbybYVqsDCFqiJg8tNZUGTzCvdtZ/BubWvoxH+VdURYhZQlu+?=
 =?us-ascii?Q?on/P9Ptl4HJ8fywvvwWLluWemUX4MLNruadLwlybArni7uZNXvMxU1qUThXD?=
 =?us-ascii?Q?t9op+ByjGz+L8sDCvOa7NsKWqhzCZcQH3NECmgNrb5OBvAnh6Nj6rXukRl03?=
 =?us-ascii?Q?7h98fmEk63K/BzKheP2Eef4L0TqpBf80urEdWhfPbhOEcoI8ce3RBGVlR/s+?=
 =?us-ascii?Q?FuaMGeoeAXjjXwMKB/eCxHE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d8d82f-4403-49fd-6066-08d998cce975
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 22:06:50.9370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oo7NO9gVRo0nHgRAJD5x8e6B9zTwS6Opnm2eogoh3usI6qui03shoZAfjGAVM8wDQwwMf45fCUMzdBf/sYpc9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2614
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10149 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2110260120
X-Proofpoint-GUID: H-6fUObRQT237FW62UftXAz4tetqxZ63
X-Proofpoint-ORIG-GUID: H-6fUObRQT237FW62UftXAz4tetqxZ63
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 7118fc2906e29 ("hugetlb: address ref count racing in
prep_compound_gigantic_page"), page_ref_freeze is used to atomically
zero the ref count of tail pages iff they are 1.  The unconditional
call to set_page_count(0) was left in the code.  This call is after
page_ref_freeze so it is really a noop.

Remove redundant and unnecessary set_page_count call.

Fixes: 7118fc2906e29 ("hugetlb: address ref count racing in prep_compound_gigantic_page")
Suggested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 906fe8a3b93d..88047a367080 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1795,7 +1795,6 @@ static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
 		} else {
 			VM_BUG_ON_PAGE(page_count(p), p);
 		}
-		set_page_count(p, 0);
 		set_compound_head(p, page);
 	}
 	atomic_set(compound_mapcount_ptr(page), -1);
-- 
2.31.1

