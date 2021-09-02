Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBC33FEF15
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 16:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345403AbhIBOEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 10:04:31 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:7686 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345364AbhIBOE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 10:04:29 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 182AiZxJ010680;
        Thu, 2 Sep 2021 14:03:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=rcptzYHPGMlt48m1KPpMRVL/LBOUt/b4vs8JDrlB85M=;
 b=oVJ9Vl6SEY4iG3TvN/7OalS5yZfM0JYnm051rNiyRLVcXY+Jyi4f9LkngyGIGJA9e1rQ
 ii/RICfcGaMAPYBrVNISp3L55EVZ4Nspc1BD2cGo7DN7ZLJouIb+9JkRC/T9M8d0NqzL
 H1yyxulBp5QI+zn3ixrunXYYaBdnv/N25D/XWjOiDj79d8J/GZQAcYxR5IMtifgWY4a+
 kpRvlBF0Ae0KR3VVOwQzMAmgFLD+IrByk3ax9qlBvOKteTXHAaBCAbyuyTvntgY5vEEX
 nm8BPEv4g75IzWWMH4XMJeObQ2MLlMaPyd6CfPqjWbiyiNlYl72kKqT92nO14oYU09ct Hg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=rcptzYHPGMlt48m1KPpMRVL/LBOUt/b4vs8JDrlB85M=;
 b=fEz3eBbCD/zD8ue6fmJGxS7aaLA9K94zzN0Yif7yEcU3cpy7ip4HrC9rDo+Hdh0wxPwa
 9qP6hJvSuRyLGQXNmonavcYGb4OwBCFBoDkkRHBY196417r2AJWAtU5/aDQWCymOuAZ9
 orT6dpUpLPAu56bAikUEyTTiKLj+N0rOzOFptE6s4ZcfLNKnCEsXFmIy+TGJMJ/jf8Yc
 kT26k470X1j5HzgHS0AI60RvuFJ9VW002draJ8RLeDbq4lBZspix1Prf/ILqaNgadcvH
 BLROP9TKVm1kT5zoUNxGmLsP18LxAI4g5MBFzHxhwp5izrFr93UTBZoOmdvipoZ/ON5r tA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3atdw5atc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Sep 2021 14:03:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 182E1jAC029022;
        Thu, 2 Sep 2021 14:03:26 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by aserp3020.oracle.com with ESMTP id 3atdyvkxx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Sep 2021 14:03:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAqcluTrZ4KyLhLleIYa8tFulz20eQiN/2rMQkrAz+BcZLk1TwpzLbEOBsn8PfdQVAqZre9BrebOIdfqWR42wUtyrP3v2mvsLG1aNglUH/Hgoi1AkZX7AdmIHho1841/+Wf81wujZvm/MegqXTg+40NXeLA+1RUTEpenDmWyL7d1OCQli1UiOtNR9ybG940lopt228Xg38SPC0jloqUUveysWGsWLT4v9N51UjSzw5ybuBG8m7EkDT/2s8AVbwGDaT0n2zWKdrJPcS9j46PGQRFrTPd2dDIh/aZKh/mhC9LmZ7you/Lv6th0Um91BAdMKhTfuhMTSC6v+HA8hJ0S4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcptzYHPGMlt48m1KPpMRVL/LBOUt/b4vs8JDrlB85M=;
 b=JjvXeQWaweubInQgN+9m8xR8gW9zloT0BmuV0wmZ0nRka3QIOz5hsKys2QYyxrrEnK50NEXkQX4HtqVlN5pSbyq6pL5b+YlSjka5vm2XZzvqKYOieFXEZ3Zi9KjW+AXtD3UIOPFrvr66aOWiZBrtK0Fo53shGe4Kerz6YedjTQcWpRdJif2ck1KZGF2rxxtj1Fcoo1dLaB9H8+EEqqO/3JeoMs+00ffZmwaWs9+dxobWZcaO1ENMrPC+o8O0ReIspjtp5zfCvu8G5k6UEUlfwrGbtHl3CODsegxopw7aTw31qzvZ3qUEw8cJrGR9Mt396Yb20hgNiGopGR2obmMv0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcptzYHPGMlt48m1KPpMRVL/LBOUt/b4vs8JDrlB85M=;
 b=YeD2+Mtax6vrB053UgVw04+gxZKglW49G6DZCDPhOWw7pvT3EcNqTirBZSVFNEEWM1evR8A2p6a42fwtbyaZmUM9WMOFlmiyIiMWQ5FjqVbf/AzUyvqvGs0iJGrhljSjgcVQiTePRG19KkWP+YHzxsf6mnNe0ActGdmH+uu7MUo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by SJ0PR10MB4686.namprd10.prod.outlook.com (2603:10b6:a03:2d7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19; Thu, 2 Sep
 2021 14:03:25 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::cdbb:4673:98bd:7f2c]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::cdbb:4673:98bd:7f2c%5]) with mapi id 15.20.4457.024; Thu, 2 Sep 2021
 14:03:25 +0000
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     linux-kernel@vger.kernel.org, vijayendra.suman@oracle.com,
        mlombard@redhat.com, rppt@kernel.org, pjones@redhat.com
Subject: [PATCH] Fix for iBFT compile issues on ARM64
Date:   Thu,  2 Sep 2021 14:03:12 +0000
Message-Id: <20210902140313.1555053-1-konrad.wilk@oracle.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR2101CA0001.namprd21.prod.outlook.com
 (2603:10b6:805:106::11) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from konrad-char-us-oracle-com.osdevelopmeniad.oraclevcn.com (209.17.40.42) by SN6PR2101CA0001.namprd21.prod.outlook.com (2603:10b6:805:106::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.1 via Frontend Transport; Thu, 2 Sep 2021 14:03:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab5813c2-ed2c-464b-5f06-08d96e1a6e2c
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4686:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB468647CD203DFE49D497E1FC89CE9@SJ0PR10MB4686.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HVdDXLVb9SpbEoKBEmxcq6Na9myEQnMc3K7spzlVxQM3LlyNWgKgMITX1/DedvDzIITk6Vr1zyz1IlaBk/BEPWZjUhCajehTbyHKJ53IKLB1/KANr9p1GimBCG/nwFB8SFIAJgliyrTtHjx6Q8wRHnG/9NKN1KPOhe5NiLc7em+58GHiFt1P/DnTYkmiw2+C3wQB5RHT86o9W7LpVvYNde1i8EH0UtMlcShWUoPbfXsQazJ9n3NghJVsLuNqvIn2egEKm8uR9yfe72HFhpjAa8tSypHyKewhGTJLdjsmf1rmrjad9WBgLbGirTJArnW3BT3PoVV3aPtRpEtmSsp++z4ZgcLIrnX4HR8HRn7ftN2ooseAJpppsNJojan9foiRuEnK03zMWtCl+aT7jJHHD1zEntSI1xZ7R0FJ01NXSh4YypIYD7aOsm7f3aiZ/1YPwCD6jbYN49+NeZrxIutBcPjiV6RqASiP8XT/8d4o2Rz0nm75/+IdTlECWlIk+GEpEBRUAFDt+rg/ft4FtZjvh9KTaXec1oGhnIIMZo++dWqva384WFlMR4KeR5/5CAJ4SnWuCVWrECJfsUHOJtgkAn6aDGHVHXb4DyCO9U75yVc39HDkYubasLaLv/K2dITVH58aho+AHwVKy3r4ySUGH1ppexwPZ6yDkK6kZq1SYbdyQQ2lm4T6v+cflHy4nz+u0puTEMHdPgWCP4/Idev1u4tnljKIyw4uukNpBCrYq/QB6DnRNlkvtr9McqB4p7Ig6JLVL1WdDWo+NpqOwezyTPWrZlEPQktLR6auuy2Gfb8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(396003)(346002)(376002)(366004)(66476007)(86362001)(66946007)(1076003)(5660300002)(38100700002)(2906002)(83380400001)(316002)(478600001)(2616005)(956004)(186003)(6506007)(52116002)(6666004)(66556008)(38350700002)(26005)(8676002)(6512007)(4744005)(8936002)(966005)(6486002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+NRldmt4LbI5i+aQ3jYzG8cM99gkgaCxYGnzbx2xepqvop9VOFIMKDXVbOxs?=
 =?us-ascii?Q?pijQ+gsiEjnqwF/mDjjdDObMSkP+wL7QmLYBBBrprLWPEa5FgnDgyL+3yoN5?=
 =?us-ascii?Q?2AbzLVy9CniBqN/xIT7mmz54kzVbkkk4pI1gApHv5UFJg1xEDjv2yPexIT77?=
 =?us-ascii?Q?fxGhNcC7R5io7xyuaowASYdFxFC5JCyUC/RCnlF4gGou6tjfZjLJKrqNjgNX?=
 =?us-ascii?Q?3YszWr/HNW5UoJ1gx2GdFWa77O89fxOL2Qa1ZH6r299CN9HuPkcUwU/ZPdQK?=
 =?us-ascii?Q?kHbbUpXZk/c3vJZRBlhYskneTYBhGCGwTfudLgs4pOjn87DfY3sBaY0UZqkp?=
 =?us-ascii?Q?Xroe3Vt2v4DBMINJNFmdbWPKLYaoPuGEWiWXksmsERsZN/H6YS4TtWhOPnIm?=
 =?us-ascii?Q?UlL4VMlndC0PwM8ccaSh8IWlQnFTUNRyu5LBZ4wz/Pt/v2xhQcje2Opj3GKZ?=
 =?us-ascii?Q?knjhQIr47AkfEFYsaP8nOFemR9LTNtlduReEqEPzHd1EsjtKyeCqo39WxXJC?=
 =?us-ascii?Q?0oLq6VxNc6u1ub6zDoyXIKNur0xnh4CYb6zLkwhzirmmpbdXrshKoFupSevh?=
 =?us-ascii?Q?JBYn895CxBtUa+q2rbzcDu6w3HMmyRHYyHbdsqJRB9HS2FqOwEr3nlXi5XhR?=
 =?us-ascii?Q?9LjjNRyAqG6ZmsLoUFZ/tyOS4Wptv2GxdOrX2tFytqMJaeC5P91VKGThRwt+?=
 =?us-ascii?Q?QLlpbuel3KW3RuJF+GIpI/LdsMWJsK4CKmaXvuAyAEeLDNOXuaD1MQlwNQOC?=
 =?us-ascii?Q?lgAn1vNcPcCys3lHeemq+FlOJOiw4rz7o3oobbtrNY8pS0zyP8yVAUe9U1ut?=
 =?us-ascii?Q?XO46OTtRIBpji6xxd6wcssGw9G7Ltu7HsddKl7tMS1d6QWahqeAHFY05e0U9?=
 =?us-ascii?Q?HIDSLiUzaZPeu+gOfFmoZ58Iru3t/MYKCbLF5QFv6GPlBh/d9kTj1eCmeDTG?=
 =?us-ascii?Q?ySqHdqcuDUcHBje82Sj4pH0s7NhvPxwDD2DdA7pA3qxSVmRTvXliegOuWhxs?=
 =?us-ascii?Q?nJW/M7yDxS6HN4fqKbFuBY51X5upwIfbM+wy2sZS3fhx14ZDNRI8czb5mfSI?=
 =?us-ascii?Q?81uuqIEdJfK6RuK5+JUO4J1T6LL4+oSFRq52cyF5yryMZRB1d61v9vnbPdF8?=
 =?us-ascii?Q?3OUgzOYD7IF6ajui9GRDBNei0gF8ZxSc/vTzwiq02RVbv4bTbfq/Z7oGKE9J?=
 =?us-ascii?Q?P3IBp2eUHGcBDapJNr0f3pz/A0j9t3dNGC9/dOZH6rPkaoCgN8rzTYdw8ySm?=
 =?us-ascii?Q?WJSh0CTeUlNa93KKrJZZ4IG/vn58e8KrKWBzIop3woAzuyKAtT4N6jWJS186?=
 =?us-ascii?Q?+cLyVEQTJCdve1CgxNw3lyLY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab5813c2-ed2c-464b-5f06-08d96e1a6e2c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 14:03:25.0500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TXIChfwkeC5Db+hzFu8Q9rHnhb9M+dpOMLT3OlaKKYy7I3/Lrd4jDSm+7bGCArBbz/1puTCHWtOEeTJxRfc/SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4686
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10094 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=913
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109020086
X-Proofpoint-GUID: McBVQlU6hOBxRK4L4nkkRN1y2sqXVpu_
X-Proofpoint-ORIG-GUID: McBVQlU6hOBxRK4L4nkkRN1y2sqXVpu_
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch to fix the https://lkml.org/lkml/2021/8/3/108 compile
issue which I managed to miss. My apologies for the late fix - please
see the attached patch.

The fix is rather simple - only on X86 do we need to search for the
iBFT under 640KB, so lets ifdef that code.

I also put the patch in linux-next and devel/for-linus-5.15

 drivers/firmware/iscsi_ibft.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

Konrad Rzeszutek Wilk (1):
      iscsi_ibft: Fix isa_bus_to_virt not working under ARM


