Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFE3447DB6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238743AbhKHKU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:20:26 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:31136 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239094AbhKHKT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:19:29 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A89s56m000979;
        Mon, 8 Nov 2021 10:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=w2fI1y6HG8sZVhifpNdxYZrje5PYy5UBaps8t9fjmMM=;
 b=HxP0XxHnyKfI6XLT5cx5ZpkD576gZU7jrpqzxkRfBDLCJein3FgJPSsYC915g1oHVvAf
 /VHDRpWbwJpW7QUFOkrN0t+wOGGmcCfpld55cj/TVenuYjppTAaViDYWlU+JBc+ZEp5W
 I5d6WrRcRt4Cqavueq3gvSC245q2hQ/IxNVKddu1PEvtO5PZrVXmQ4Bq3AvOwYIRgcU6
 +vamM/tKbZ1NbHVwihMUaamGFPKH6tFrq+6Cbhn3/1H/7usu5HyDg5xGNiVRCrpmdSn2
 yMZ41EncfJP691bsT/UIaaIUZb/1iEyn2eIl8eQ2beZlyodbAhbFO3FnTP85qVMbn4/X FQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c6t701xba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Nov 2021 10:16:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A8AFxdF045937;
        Mon, 8 Nov 2021 10:16:38 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by aserp3030.oracle.com with ESMTP id 3c5frc3nmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Nov 2021 10:16:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNjA8J7rLPG4SC68262seBCqd+fhlQAcXZn16otamJsarm+Ez3AAivhyIX9IOvZJNoSmLBjR2zkuHCbfucAaELHwP9vSz2nil+ZCdk/tzXbkysTTdalxRfLSgFMp53jFiNjlqwqaYvJIUJWAfgTVYWmBktTitAxQ/ic680XgfOLoSzMc7oiV1xKvm8FeZN/D3LYv4jR2s37QXXxdCHx2q7KbdI1Hvxq57vrryoqoDGTLY7SNf3Z5IsBxYSUmSMIwIkc372S7nGT1gYeAntfDx1dFlvFI3KwU+LNR0Su1J1svRvCvGAIHp3CvfxnSBEU8QwID38y34APbf2NsjMGOpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2fI1y6HG8sZVhifpNdxYZrje5PYy5UBaps8t9fjmMM=;
 b=YRPicETZymcmPiflSK1ZcIM7S8RhCUf0Y/ebdte+5+6YmmsUomCNkSpXHccO0B4uV7Hs2E5Ff2JxnQfKeNUrbUlWif1KmpvCfUliKCXyYR54FBqgmnmQ5il957uTzghh2+dBoDX2iOHxlzmn9jt0d1eqlQ0eABQlyZL7r9wOTU+uiHHaIwQH8tMaavb+Apwl/uTNRFd/iwmA1oGu+lgkpL1aDquM3NXkA4uzEMnktRIaMBJcEpwz0kOsAfT37v6Z7GKZqnulVH1Vre+ym/3a/VNfeX/RqVMp76mO2h9qe6ZR4pIyEdFFXrxtZ6XHBVb3gd8htBxbi5WEg2RVlW1Hlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2fI1y6HG8sZVhifpNdxYZrje5PYy5UBaps8t9fjmMM=;
 b=e9BsKKmDH6QwDLAq/X7e6dSKyStxePM2A5agoPzxut/RdLQlqVpRf8nKEdNZ7TAzXNOxKBBkHpj4Kvr0uPK10ddpzNwgZAkPXE97OvmuOtBv9LxdBA+/i8F9yUNn/YVmiSM1Nzxr09LzxnFTFJz5yPQmvkeAKWQqNd9nOAowN8g=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2318.namprd10.prod.outlook.com
 (2603:10b6:301:2f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 8 Nov
 2021 10:16:35 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 10:16:35 +0000
Date:   Mon, 8 Nov 2021 13:16:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Karolina Drobnik <karolinadrobnik@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        forest@alittletooquiet.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/8] staging: vt6655: Remove unused `i` increments
Message-ID: <20211108101611.GE2026@kadam>
References: <cover.1635773679.git.karolinadrobnik@gmail.com>
 <79a4f03c8f2bfa555ea149ddd1c0f938dd431a0b.1635773680.git.karolinadrobnik@gmail.com>
 <20211104133803.GC2794@kadam>
 <0a4c26bdabadd666ddf124bbb767e5cc802af937.camel@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a4c26bdabadd666ddf124bbb767e5cc802af937.camel@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0070.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::18)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0070.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16 via Frontend Transport; Mon, 8 Nov 2021 10:16:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66e90394-d003-4aaa-c125-08d9a2a0d831
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2318:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2318FF5F3FFC1E2A3255698A8E919@MWHPR1001MB2318.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K7YjC+DwCJ5GeGxjUzHUPlG6iIewQgKHij55mFBG9JqqMVMT8L2L0VNAWefau/kgpfRDrqQrWo1lwwyJiJAxqO10s/AJ6jwRyT5f2niU5vX/HkxeZ8RpIvbWkLbIGGoYOLmb5nhNqrM4zecTQzurx5VgI2p3FJbmaxeEUEd3Hwzl8oNGNN0IpI9Lw5DmXz2ZaXmgGfEv8L9g9vnzAUTZ/tsVwZX7Ahr7NI3Y6IzN3WwByYg0RKeTA369nyybsPlqOleNvbx1Y1Yn8hmY7Tdhgfgr6rx87tcs84RPr8FxHsgSz1FVYjdIgiJ2mJfv1yXztgTCIcUN+PChydaQ28jObgI967fOElK62MlkROQ2eOjSVGHLPVIufE6fnOezxXQhLSOvDxgA+faJWOrtInqtxCKRUHFLX5aVcumFSNH+66Cvo7j7hGYRvd9tfDByvkox1H4hUEiVBsjklUfkhYel308iSQ4WQoB1alKqZFK+wNp88s94qzDwZRiVHAxoCe7u3tlilFRUZQgPZ7cDQ7L51I5VxCo88tyL8Xcx9x/kLiojrxbOaXrqXue4Cag7L3DM0l4qYFUke5fQQfgDs1x73tXcsv9NPuDXWVT+omWROXQrYlZzf9sOseKv+JAl/2/h+tHEx723jSotyzDKTCLv4Yp/LRd7wUWFDeit2CqZS+tgSqI59KY+4yEEDjTBdq42LbHPoJ/mdXNuw2nKOiAXBOnAGkDZuXxHF7+4iz3CpwM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(8936002)(86362001)(8676002)(38100700002)(5660300002)(38350700002)(26005)(9686003)(9576002)(186003)(52116002)(6496006)(6666004)(1076003)(66476007)(6916009)(44832011)(55016002)(33656002)(66946007)(83380400001)(33716001)(956004)(2906002)(4326008)(508600001)(66556008)(81973001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NITPWDx9nEkprDU+dF8pqNSgEowZWTpiAOyvU7Ffjb+Ex8lsAqo6htkIN3b2?=
 =?us-ascii?Q?8A8scpgwutICMXudC3AFIAl8t7D64dNRP7NvLgC9FfreZn4Otyl01fCsDCTr?=
 =?us-ascii?Q?1CoxlA+J03LbmSXvmj0xF7UmyqOgOdaOGp3zEcs8FiZoTrm8cALjcusXX4iS?=
 =?us-ascii?Q?kv/UtcEsE0KQKXKds+De1u9XEi2IEKonWRSrqTGq5EubvztYEK6fnWWysHAs?=
 =?us-ascii?Q?eYdy8DB/rmC54oyzhmfX3FJ99qiGiypstsrqEBljtCu/KKHJQqNLrv9QPCV3?=
 =?us-ascii?Q?vGfXLAhy1e4b40+wvPcDwVrolDNTYhRob2Ecd9wGfg1ERI/N/kQ6dJt5oaZL?=
 =?us-ascii?Q?sKOptxwsgPm0n1WXw9TFr7WzCxyM0Ucx4PQSyJx078BvaSO65mFflr755wxM?=
 =?us-ascii?Q?MRqIImmNUIdrM8W7GGF3I8E7jLT0bPENKLTtuH84QeDAa3dEyc89XqLvJNcg?=
 =?us-ascii?Q?PYsbpKjN8D38l2uDAx06XroxbKVNQir58CUh7hrdt1c9cELJvmJqVqaCgQtA?=
 =?us-ascii?Q?u1UjQDVW4s3SqcyVy9a+mjZe8KYr/fXi9eo5+gzshfhtCGf/OC3/e1hFuaQi?=
 =?us-ascii?Q?kqV8Qgstznu+GRaZpXQF4wmbuYVlpXe97C47DL3+8KYZqcObp4Gp3g5znDoN?=
 =?us-ascii?Q?8/SarPGh4BKYHAXnIkloQ7Ho+Ue6eGV1TdHB7MCaMK880uDNRWD8yDchStle?=
 =?us-ascii?Q?vMeaqxuk/YXr8uM8egjEwW0d3l6uSPxcsdIr/5uvLLQ7JrnUwPYGxHlicAkO?=
 =?us-ascii?Q?XRkFGoeZVigF0J/s9H+o1KvYNrp/VZfjB4VFVdGyiD4RiNuZTtngXexf3kYB?=
 =?us-ascii?Q?cVN0MLN1akqXGf6/aYOWvJKwmQRPmAi21KbEj3K7EtZzTkCwY+6Oq6PYfwGs?=
 =?us-ascii?Q?HHcYZxZOuQPWv61ZVhQRjofPwZO/8ozYPZ20rycS+0Tp4Vh3AYJhRbqbN1g1?=
 =?us-ascii?Q?DuIcsRqQsIHNxQooLe2IJ8EXAzyMyORqifAq3hiZ3UAfDQVYUATWXrHedch8?=
 =?us-ascii?Q?xXaU6fS6e5Csu3PY81uyNYhWzw6mK/+pUlC/YUtIgPxha5xtbZnz9aQhUcSY?=
 =?us-ascii?Q?AhLs2Q7m+q8652pw3coKtlgyXO+9ceEYimXR5C+8SafvPRuhdzI6dBQY1qfL?=
 =?us-ascii?Q?aSWiUr5x6FVnGjRDHIrdmlapn6KRcgrPR7h95TXnmwUwTvYwhTFxwnWS8BEy?=
 =?us-ascii?Q?rsQn/s0v2NLvUsrKrcM2uWYk8OttdF0/WW7UTqrPMkdriQuBR2GoKXvx30GU?=
 =?us-ascii?Q?HJFToC31vtjx6uDQ0MoQg5MVLHdfwnMi3+zM4wTm0ah+vhYNuRtZtkGBE5ws?=
 =?us-ascii?Q?MbaFnOF5lO2Nn1aeZxGsYw94fCpu0JuuQFtL/bEILxBkXaVd2xKov/eVep49?=
 =?us-ascii?Q?xv9AyUAiv9Y3gTV6gU7UHq847DfDTWRfgtDKw1v4ksQRAwhYtEm70zqkLbgT?=
 =?us-ascii?Q?+5wZNe3caWAmooyLRwusFpoXJFYO2hPhBeDveSUYcKrraMdZS/6STr2DMJ2N?=
 =?us-ascii?Q?iAyVRY2GQXfGpFVOndddhezzH9fDecfnuNW96eY1CHNoze1gcd/H/T8PbT48?=
 =?us-ascii?Q?eaRwKL5ExU+R6eUryd4kqwlYH9jsNMBvC/y/9itnOZ4JwOoobaqAa926FVvb?=
 =?us-ascii?Q?7LfSegahXBtTZY13hf4KT7Ywi/nUmg0zsLWzqwpb0xC6gIk9QNhUk+/HJXtR?=
 =?us-ascii?Q?y600XvwwdqmIhjngzq7FanaHUP8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e90394-d003-4aaa-c125-08d9a2a0d831
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 10:16:35.6551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DwEh1YaADRkihcC4xbRnp04ijjok3iP6iBdhARBho7j9FIxEpGYFqtLt5HAMmvtQsHHCsbSA+/R5fZwklJWS1dRHrtRb4iktiOEnv7uhjBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2318
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10161 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111080066
X-Proofpoint-GUID: sr2nSVptru5J_GW7hmi4B5msNk5nCyJ_
X-Proofpoint-ORIG-GUID: sr2nSVptru5J_GW7hmi4B5msNk5nCyJ_
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 09:57:25AM +0000, Karolina Drobnik wrote:
> > This commit is cleaning something that was left in a different patch
> > in the same patch set.  Just merge it into the original patch.  Don't
> > make a mess and then fix it.
> 
> I tried adding more than one logical change per patch some time ago and
> Greg asked me to stop doing this.
> 
> > It's tricky to know how to break up patches.  My suggestion is:
> > patch 1: remove all the unnecesary (unsigned short) casts
> > patch 2: merge the rest of patches 1-3 together and send it at once
> 
> Sounds good. If Greg is happy with your approach, I can merge these
> patches, no problem.

The one thing per patch is tricky, but it means one *whole* thing per
patch, not half a thing per patch.  This patch does the anti-pattern
of half do something and then clean up the fall out later.  Sometimes
that is actually a good approach because it can make reviewing easier
if you're doing a ton of similar changes.

The one thing per patch is also about how you present it in the commit
message.  One way of thinking about this is that your first patch
introduces static warnings about "idx" set but not used warnings so you
*must* fix it in the same patch.  At that point it's not an optional
part of the fix.  If it were just a related cleanup then "Oh, well,
that could go either way." but now that you point out the static checker
warning then it's not optional or it sort of almost violates the rule on
bisectable code.

regards,
dan carpenter
