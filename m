Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B327E3C2C0A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 02:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhGJA2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 20:28:16 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:30016 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231453AbhGJA2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 20:28:11 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16A06bW2025727;
        Sat, 10 Jul 2021 00:24:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=A2p/1wEN+/NdxzZ6OgXtrlPV3G+oyVgqmHvsTjCCwyU=;
 b=GaeKlauosvy3i7YTWlFjWvWZYtmGHwo9wxpBPRBiA+JkC9jjdcD6z5vCFhlkTpgOu1lT
 q2NmVPRQV0h4TtUkCDgIEBHzedDAxHRcBKIw/okNwg0YoTNFGa+nYJ/YulZK0wAgY5wn
 pjjfKYpIYExpH0iDmx2cC+wAIFY+4+tW7PB3kHEIQXMl4dsmmMhRWk0eMK85A8J0eYF4
 xmat/pz5MiJ/VYL8rtbHqn/es02kunmFEIbataoRJvU5zvuzomcNI73jFMZNCb9K2NKt
 TNpv2SU6esuPLygFad48pMXzhNbBCnZGhFbgxJezCjDnld7H2TCfbJ4HQUATD8qgYqWn DQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39nphgmm8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Jul 2021 00:24:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16A04f8B177920;
        Sat, 10 Jul 2021 00:24:55 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by aserp3030.oracle.com with ESMTP id 39nbgawubg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Jul 2021 00:24:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNy9XmP68zpobmd+sO23kH3j+qrb82thKGV5SfPXLpcW/qktIe17p1n+o7CBtPWUH45ePQJaIGiEQ2IETweS6Zj1ZPKWAnTWb/ZamJDx4lEfxKGPdxVbbfcTpKn6Bcwggl5enm6KmnpOU9MfPPw6sABh6vQISy7Vg/S1yEhUrHHAS5hCt5dWExCdGO+gAGeTZpiX/aU/UUVc8HZNQPb1ndst7VyfB1o6L4xDnUKvWo5MtD64BaA/GFrs6GcrJrOI53Iu02rSYbrSthKnBadxWepa6emdEnHKHKV9i7Mf5vxdq3SlrPMEtWCRVmkjVHiLCWA75yDMwQT98NacA/dB6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2p/1wEN+/NdxzZ6OgXtrlPV3G+oyVgqmHvsTjCCwyU=;
 b=jV6Q+QHqZwHFFCTm5r0G0k18/A5KWNuoxo0lmrADTVFt08ztceDHLnlr4dBeB07ZlEZgkTuAbis0VvOxyPcG3QyBh4O869p6yjsb/5ypNRS2TSWTz53n/6bDDSvpCL8W8M3Q0vhGcjIr22ueT3Sm1wVJGsIgqstGkzSWy5Sl+E1coNvSFDzy/EWugjXQVOaSI+yubhlhBAIsfKWny2Bv3adGr+toNVmAm1G6NGCjxsIQxJ1p83KFCHJ6yyWvOgjv7bQdm5wYkm0CrY1dSoODIWJQyDtOLEvW4DB2et5zOTXYk6dK08SBEUgDNCGOmdGZjCYaAllWkY8/dB4KRVVoZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2p/1wEN+/NdxzZ6OgXtrlPV3G+oyVgqmHvsTjCCwyU=;
 b=M1Syt3kc/YGEKpd7eB/8o4HN0hKLP7VN88rhLbbytMuDLEc+unAx9tbrKRSSiLUqKt8xnh+nMhKhOw0L7WpcXcoyDqnqbtkoSm1liRakP4+uEsSWJiYGQX0LERSkM3j/FVPHky+kkszVJkKL9yCAWZYUSgzsATTc6/xnEMYqf78=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5439.namprd10.prod.outlook.com (2603:10b6:a03:303::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Sat, 10 Jul
 2021 00:24:52 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%5]) with mapi id 15.20.4308.023; Sat, 10 Jul 2021
 00:24:52 +0000
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
Subject: [PATCH 0/3] hugetlb: fix potential ref counting races
Date:   Fri,  9 Jul 2021 17:24:38 -0700
Message-Id: <20210710002441.167759-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR14CA0041.namprd14.prod.outlook.com
 (2603:10b6:300:12b::27) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MWHPR14CA0041.namprd14.prod.outlook.com (2603:10b6:300:12b::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Sat, 10 Jul 2021 00:24:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38391a42-1a8d-4ba6-8540-08d9433922a3
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5439:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB54398061AFBD5CC3EF3F4E6FE2179@SJ0PR10MB5439.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9FDaCWVGeNN8S3Sls6SBa2wqux1MaFpRGTklWgaFB60lOPaqeDLvR2A9IL1QxawPBNakiKvXmvd8jQb7rxlhOqYZOTm+ByW4Zga6XnDfFstCR0POnEYS7epWZxVaceqgpKkuGxQFlb5jK4ApeVTtvELXJ+ETpZMiEK6BCUjmG+KfZLJ4YmDXt3i4IwN+CYG+DW/chL+kxzPsPS1dKeGkf4gLq8qx/mhRz3R2WWnxQQtaP7KSLyajYm4bJ9/jKf1p/DRNMhTSeGKUUXP+HevlfuFJzMbiEFFrcFQ+Ce2IDizs4m8XjwZ6O6/REiZr/sdvPf9ua9AfrUYU3IMy1jLG151FzAtuFVoXVBPK6Ya7bttQuZ7A1+o+TQUB5ocYxGDxGNL0WDRL/neXChXiPEokdCGOwlV53B2g3dPyc2E9F0BVH7T05EwOcoEVHLN3auuXXGrrUSidJqh1il6Hsa+UPPqMhwyDLsa+vXZUg/MsE9Sha7yeDUntjYCXarTrcNxzbqtxArS4ScXK+gNXr2/LooyGHumAGfnboRLFXHnB7/eNAeYQ7zKRMYF2qcQAYukzT6armMbG5CUvPHDd5uhW1eKwQ5wBVc3GTUcCwgVQll7cvMx5o8aMsIJYyOQmtxhClJ7cZnZYvUnCwxXjov0zVxJlIt8dDzucMwFO9CwbUl9Vz3k+48ctEmODu+9/5xg4l60aED8uQan6a95zLGISfcnL5+2u2Kadwp1BgEIekgsGlGRfyrbn/C7BozkFtjs1sIrSXwQsNCj4sk9xxpjpwNKN33+KyHu1RHGBOls6Wyg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(376002)(396003)(366004)(346002)(2906002)(1076003)(52116002)(38100700002)(66946007)(38350700002)(186003)(86362001)(7696005)(83380400001)(36756003)(107886003)(8936002)(26005)(66556008)(66476007)(6666004)(54906003)(478600001)(966005)(8676002)(5660300002)(7416002)(6486002)(316002)(44832011)(956004)(2616005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vO+4Kl9eD6F/WvuCXFLG7uVXsU6BtNmkJC4SHfzknxVc922UQOhR3TzwoW1i?=
 =?us-ascii?Q?17nDHvVbD3tn+DqYsJAMD9oOom2DxaTEP0HtnEPkyPWjIt2BzcJghI/fBT2p?=
 =?us-ascii?Q?UEkjaBwPxXqW7fzu/xP/4OIkHUTO0Nn0vKOOXLhfMgvr4YeF1iIGeCEXFR3f?=
 =?us-ascii?Q?bH9m3Ok/xdV/odInk3e8MS9dSvvD4v6AXb9+E3LJIijy/PMYxEEwbw8BUAL4?=
 =?us-ascii?Q?4V+pdKT13d/l1psYzjmlqXsF8w0Nt5KJvMp4lFSD692HnTsm9qUdlwv3tGEI?=
 =?us-ascii?Q?UbY6gl+MLPfl/Anyj+0YMoXaYk3B173M20ySI8yGZ+VC5h3k8pZY0gqw5yCH?=
 =?us-ascii?Q?Pjizfx4eiP8E94qGshOor66gsmX9I30Ep4Ytn3MAW3DPCWwvuv4IIjnEOzeK?=
 =?us-ascii?Q?m2XSutmIhmK/JQXJHlR7N828iwUfX92gODJB0tIK3R7aHtukbBdMG+dY5YIM?=
 =?us-ascii?Q?BGjGjSfppmEDZuikGOqqhgRicKy2EZlQRe0o7N5He9J5OfUWlGNjIBmPLrNi?=
 =?us-ascii?Q?vLOKMwuBld0Rnzk4cXIo9nNRYUMz/ODez51V1YQDWEY0JTY5fRQCfZke8Adm?=
 =?us-ascii?Q?AJRn/g8QsicS20SOGYBQTWLk1YwnXMSj3RDApQ9TTpzWa5N1kBzvHet15Bzg?=
 =?us-ascii?Q?tvswXQZbWpeGmcRNx1jGFB7E2WX2g7wXurp/JxIZYa5ai4obix2hDBzhoeiz?=
 =?us-ascii?Q?tg2DJRBsT7csdMvSEDKySeW9cSaRjcOkEpRODOXLA3yaq0H2f9AW9Kcr9OyG?=
 =?us-ascii?Q?2gYyqiaOQ2LZd83Qjm+1/UOSkgpS+E+XSJ0S7U6SQ3TJ4Ea7K3pPZ3CiB4oV?=
 =?us-ascii?Q?McVhc6MHI2k680SR/PviN5vYzeekvU+AvORpOxwOj+uG0Mdkxr1GzNZCdggG?=
 =?us-ascii?Q?AoJLm8njvwLXjFOU8ckzLQEPfrQsaJ8iANkxdUxaNqUy7r8loRb4UFD9igSk?=
 =?us-ascii?Q?ljrk7vh7X9+6QJt1A0eVJloaLT45rEXl4u41y/v5Zw6yfdwnKETJas/nTkzt?=
 =?us-ascii?Q?OXnM2q6Re75aGJAZRIM117uMZXY3AIISx7WD2NV5298MhkkqByP5uUPHDXSK?=
 =?us-ascii?Q?D4dUeue+Q9C6Jtab3k84VEHcH5ITdzjKj2NtgYJirt0Dv7aqwQFg2bMEcG1w?=
 =?us-ascii?Q?NQwS17Nk3WJ6zSFW5j62V9M3J2BQCWQ7qmr1uEKUIfy+BH39cQmhNi+hBp5B?=
 =?us-ascii?Q?P1hQ1lrsYrk9VEzdv4Zhq3bN4AnASqNKQaN8N5oSoO6TxwoVB9p1cvHxJGx4?=
 =?us-ascii?Q?M24YzQerLe8hoJzPFeyykmXO+GSHVfYAgOj7u0tEnUeLGZP9epvtB1AcaI1R?=
 =?us-ascii?Q?5wqnpMJezmOENRwRZmeFWXL8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38391a42-1a8d-4ba6-8540-08d9433922a3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2021 00:24:52.5413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HdwhYOqOuT4mXVVbB8kbw89GWua0lFhwCmSxUT6MCVLkCLrFUxA2slIut5QWF+hK301Tj4E9EZTYGsM0fOeOqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5439
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10040 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107090126
X-Proofpoint-GUID: giHDP-Izwq3RJdslQpceaewc03lGqF6a
X-Proofpoint-ORIG-GUID: giHDP-Izwq3RJdslQpceaewc03lGqF6a
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

Mike Kravetz (3):
  hugetlb: simplify prep_compound_gigantic_page ref count racing code
  hugetlb: drop ref count earlier after page allocation
  hugetlb: before freeing hugetlb page set dtor to appropriate value

 mm/hugetlb.c | 137 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 104 insertions(+), 33 deletions(-)

-- 
2.31.1

