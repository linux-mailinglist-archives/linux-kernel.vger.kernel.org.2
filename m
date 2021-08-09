Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E2B3E4D68
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 21:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbhHITuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 15:50:54 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:4674 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229516AbhHITux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 15:50:53 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179JgVkh031855;
        Mon, 9 Aug 2021 19:50:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=ZPiS8JzcrxC7gZnaG520COCdmmNQNlMz/ZtXyDJMtIw=;
 b=pH19/O8dJDI0IxZTYENqDErXWwUNsB/15lsZbDRljyYTxylfUXA1zZSFTwa1Hup0UD6B
 v/hCaJNIfu4oT5NNMYIA8csFEPjzCjv0EPvlE+w9jk2wOXtCn4BvY7UqqJB/mzo62DYu
 qOO2JjuUPEaMfyTpGXiTY2XSS1MBFUyJA1u+yaCjhjX5zy1Nj06MkxDNeY6iyI2QA6xS
 9n9yvfaicUdhxpcKwSSk21u5S97PlJTbXGN9M6MpT7l+kBuh0OROJr6l0mIHsC8I+QUT
 wJJn/pXQtD0bLwPtA87s1ep6w4blAn+DZpJ0KBJWKJfYPe7ICISzfq5Pz299an2Ggcp9 BQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=ZPiS8JzcrxC7gZnaG520COCdmmNQNlMz/ZtXyDJMtIw=;
 b=j7RIQTHEmWs6FArycMkZpyp/k4MnXpCDobE4ruQKCM3inHQXvBgg9vaJz062zd5alvyX
 aIzkMx/bRoJcHRN5VIenzxfyjfsd2dYvDUvtOCkV0/yaeMSmEQbsv01VXgpPzcavVNVV
 EiRZaM2AJ4uif2GDbCX7EsF9083/sZC72eR/KPD/ifSGs25cd9RM99JBMrq1QPtctrNA
 MmiSWvsgRRUqdatAhT1W8o+fj5QcGsb30bUPtyA2+4H8SIwWYdfl8P8if1Lz568kKzq9
 vHI1ltqD/AbYLvOPn8Bh2ZknTwiaGl3hHqTQp7UdHkgZZJEchoFMJ+42Xl4mwF5/j6FB Rw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ab17dshfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 19:50:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 179IqFxR152908;
        Mon, 9 Aug 2021 18:52:50 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by userp3020.oracle.com with ESMTP id 3aa3xrrm96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 18:52:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gm8BnsuP5mV50JO64rk6IZaxUMAIiAvtZi66+BFtifegg/yGRyfFnaGpzW2/uhbpBXtWYstEdXfzz+aq2QVPQ8z0+HTBuWkl7vavksiCOcviEE1U6FF345W5iOM1897gjY7TXEiMVX6LpMXGdfldA7L99B7Q3mHv+U4qToXfNQwdlHf+4twzi2KMBIUsbfXhHbiyZ4S+Du5ni+U+cUFOmNAKfKpxUJL7g5UtP+DZUDw+m2o1mtLOoGRFhoyHqSm40BMa/qP2qGR1u2FGgsUjCSRJzb075gZ+Fa/N+tygLd5Xcvy73GTnyzbmKjD58k1GGqamP7nzipRpESk2VCBWUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPiS8JzcrxC7gZnaG520COCdmmNQNlMz/ZtXyDJMtIw=;
 b=Y/WRzwNMQvkFpZWlQXkvIyIvV9S/SBMOQRHvNScZZaM9Chm8nFgDbYd6PMwX9PP9EkV+f0IS6FcNQxYL2bJyi1WYJL1Bu3cKpZpqQL+jUY8ojxEPcKZvtuAHE+sGRi/8suUsJLLLuEHKv5e99VDek92hoy6qIjHbCNFr4GIF1vtuG57YzkSFHmkfCTfXpATsSQYh829iV9O/RfZk0qS57hJMMj0dniZoWKI/nyP/UGf6R/xnfBjDJjAI0utNbIlS3Db3QQHRn27xvIbbCxI2jw4XEW1r9dxYHbaWIVt2Oa+QAmoiC9hhLV8BHrCTbNI87PRMjz3foVDpltyZ2zKrnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPiS8JzcrxC7gZnaG520COCdmmNQNlMz/ZtXyDJMtIw=;
 b=cxcdBfBZoEEmDrAdz/Brx5qZb3KTZDU7yaHQNJ/miF1UzejbVQFKwYDKnWytcDD8uhPhaXpByPJRKiR75ACp9ACS8MmNFLiekR6/ECRsAPJNkYXKKjoJ1yB/Axo8SnadzWjpfS1JUZN69XMaE3hKFy4bxD5u9NeLs+nfslGCJo4=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5455.namprd10.prod.outlook.com (2603:10b6:a03:3b9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Mon, 9 Aug
 2021 18:48:45 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%6]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 18:48:44 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v2 0/3] hugetlb: fix potential ref counting races
Date:   Mon,  9 Aug 2021 11:48:29 -0700
Message-Id: <20210809184832.18342-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0341.namprd04.prod.outlook.com
 (2603:10b6:303:8a::16) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MW4PR04CA0341.namprd04.prod.outlook.com (2603:10b6:303:8a::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Mon, 9 Aug 2021 18:48:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c9c02f4-16ba-4e4d-677e-08d95b665071
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5455:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB54550FA0AD66CF3FDB3A35D0E2F69@SJ0PR10MB5455.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 66MY+KL/xTkAIfjubyetKAWPQbLIyFfoF0HEaaBmhrzBvSc49mmQW3RQv8Leb5RzrFZ7lMgP08z/BobsWcZgMVn3ua3IcrjP2SyDdQ40PjN03M+z/DRh4rtIMakVIR4uq/nIClnJUqJ6TqSg5CQDiomsn5s4MG22Ar/Iz2s6n+rt5u0lTR5V8dyEJtFb5rhhO04zbpjycRVOcNe4RQ5A0zvT59jUGmYwOE1avaQ7ASopuu3gKt0RqXu6v2mvMtS54UfrgB2AhmhKNkmvuUoM4LA5mGM1RpHsKqMv71bfZefkcxYl8iyQD9bQjUofVUbW/A43U+a1tEZ9xi/TvOlWU/40DetOb0N0g1JWTbq3yhBZtHnjNFj5oc41LhHYQZnhxkPiCbJs2dweIeHP2mtNJp/TjWKnHUGRUcdG8eix7PzX43LHdfTJ92WrUze/zDJmJASWw2McZKwE+MP/gEuX+SY1P11CfqF6Vb/oSi/Hu+55VeaT7jst2qkkZxeDJEZCpW5Prxh8cfClwuPnes31aXF87G+6RjlQecPECfgD7EzNN6N/reu/SkCS95HVWml4Pcppivz0qPM5AJHB7uezL+MJ46n+fCIxBjP8f+X1rmdWnolaBTZne3Jw2//Gs2g0hreSgS+BgT8hkiI3KaTVz6i/Re5smjuVFStobSfxBo/QwVEsMhG/cjrhz3tAZ7kDLZr2L7XOZVrC4H8apv7SqYvGFZl9qfX5Q5wHsuNC3bO67b4JFqTTCH8A5F85CkYrszDCvxYw4t6lpx+UJwZPxRWtx6ADdxT/DE+zvM9nRfg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(376002)(396003)(136003)(346002)(7416002)(83380400001)(86362001)(316002)(956004)(2616005)(5660300002)(8936002)(1076003)(38350700002)(6666004)(38100700002)(8676002)(186003)(6486002)(966005)(66476007)(66556008)(107886003)(66946007)(36756003)(4326008)(478600001)(7696005)(52116002)(2906002)(44832011)(26005)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KfluoCJ6Nh1jaXtbHP6ICx04U1x6S4JgY0ZsrkYmq74zU/OKI2A38lnKtYMM?=
 =?us-ascii?Q?xsInZEKgvtwieu+tNuxFQpLYevMXMZDNG2X6dZw2Q2Gb3pDYPoE9o0om+Z5o?=
 =?us-ascii?Q?i7gAEM4yTF05NsJMuXkMyPcigqDZyBe0eRW6xdtBPiMV5BEsewkrX5wmv9d0?=
 =?us-ascii?Q?psehBxffHGbEW7hd2CFfZftYiwnBUbSLCGZNotumqGxCRc8udfdC/Gtty3c1?=
 =?us-ascii?Q?uuH/C62syiRB2u7K6ZfzEhwhqd3NGHXvNNL6Zj3vPzKTIjsyG3/V3kJWrU17?=
 =?us-ascii?Q?/ybiewq5OIRUTtOImwv0OCJ1KSzBBiqEBQ578rkxFp/tIG0CA6cs+xt8lpjP?=
 =?us-ascii?Q?zN8re+JvFsuzT80XKajb3JPGbCmqKAJlxez04p0mOqSZzvfjD8G/ATkFtJ/v?=
 =?us-ascii?Q?OtoWLSG1XaOUzKX/2OLvvnD0v3Xf+Fkvm1S135M4T0ghFIMKQSwA4b6SUeJN?=
 =?us-ascii?Q?fwaux+uoYrio7jTnHxJqZyBWjCjZyRJwxrvgq5jm1qkFsoPGYbgTvVhh5hKU?=
 =?us-ascii?Q?k7ijC0KJEnAf1AqYACB2n0H9Yx/BhucMkwwSKfpvTX6P1859ZQ6fn0bcrzQd?=
 =?us-ascii?Q?ZvhJolnQyy28eHW0YqKyyhe9qABVF34dZqBbTP7RyxDBrlZiqJ+6MeevJ2Ag?=
 =?us-ascii?Q?uB1hlNKpG+scv9mq1IhrYSg2vvTzyKXMNVRQrW7YIXaRGJm94CTBNbOrex7u?=
 =?us-ascii?Q?io74S0dBZz3EoVWGvInh8zZlBP3SEIHivydRTM9tecBqKCeaeKEww/nv8lTF?=
 =?us-ascii?Q?EHDZLTnHKFtsicqjFK/W3cxJUlF8baFotUJoHvKtqYfHSqpRg3PecaBAcAnK?=
 =?us-ascii?Q?Lukp8SOXdPPfgyg9Yf7ZmjYJHQlFtXHjxXOctkJ9QQQhzvIsZ3LXZrSDfDvV?=
 =?us-ascii?Q?d7is47PAB7l/z86VnyoGTUiLCkbWwb1sqJ4h7IXtF85XvL6iJSrOJUQ6Vo1Y?=
 =?us-ascii?Q?LSvGDq4j0pho/ULl6AWr4ldVQniEl/kHlqHJUiDmFhm/Vz8wNAMhftQEWNpl?=
 =?us-ascii?Q?musbi/xGkto7Ps4+HJ8Vj8EsKU5KB9Kwlkb5vdMXMIc7Q/7QpoPfG+zwMxL1?=
 =?us-ascii?Q?o2pja0sWmo2n6CjUCDeywfvP6+7Vb4zLGfpj6NDNKusycuTUymr7hyOukLFG?=
 =?us-ascii?Q?p3CpWsgzdUWGgQnuR8jr4t0fZYNB1Kejys5/tWYoyvUL86aZp3TXoE/aioPb?=
 =?us-ascii?Q?VUQwADJV5q3olbnFMTE9ZndEBpaWBYesOTO1gwuZjWKAM/PQdWp4vhagVcB4?=
 =?us-ascii?Q?fg59QviXbKEEh0tr3FqkumIavTR2Jkg8Aft3t/1jxb5WTs0awpW7QR8jJI+l?=
 =?us-ascii?Q?Um7BlKN8p3nVDMO8zcnyiABI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9c02f4-16ba-4e4d-677e-08d95b665071
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 18:48:44.6018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: me1IpgGNNEDS05E8MuPI6sXsWeYNzn2RpVHy+IVwuM4ouWQb4whmxY6wrtMNcD6WFl8h9iip40ZmUDwe+5mlpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5455
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10071 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=958 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108090133
X-Proofpoint-GUID: 63vAd4vy9Ge23elati-AN2MyzboVAInx
X-Proofpoint-ORIG-GUID: 63vAd4vy9Ge23elati-AN2MyzboVAInx
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When Muchun Song brought up a potential issue with hugetlb ref counting[1],
I started looking closer at the code.  hugetlbfs is the only code with it's
own specialized compound page destructor and taking special action when ref
counts drop to zero.  Potential races happen in this unique handling of ref
counts.  The following patches address these races when creating and
destroying hugetlb pages.

These potential races have likely existed since the creation of
hugetlbfs.  They certainly have been around for more than 10 years.
However, I am unaware of anyone actually hitting these races.  It is
VERY unlikely than anyone will actually hit these races, but they do
exist.

I could not think of an easy (or difficult) way to force these races.
Therefore, testing consisted of adding code to randomly increase ref
counts in strategic places.  In this way, I was able to exercise all the
race handling code paths.

[1] https://lore.kernel.org/linux-mm/CAMZfGtVMn3daKrJwZMaVOGOaJU+B4dS--x_oPmGQMD=c=QNGEg@mail.gmail.com/

v1 -> v2
- Update comment in prep_compound_gigantic_page as suggested by Muchun
- Add Muchun Reviewed-by: on patch 3.  Still an open question on whether
  the free_contig_range should be removed.

Mike Kravetz (3):
  hugetlb: simplify prep_compound_gigantic_page ref count racing code
  hugetlb: drop ref count earlier after page allocation
  hugetlb: before freeing hugetlb page set dtor to appropriate value

 mm/hugetlb.c | 139 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 106 insertions(+), 33 deletions(-)

-- 
2.31.1

