Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D016F42C19F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 15:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbhJMNo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 09:44:26 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:6008 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233922AbhJMNoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 09:44:24 -0400
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19DDVqh6009558;
        Wed, 13 Oct 2021 06:42:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=mq++lUR0MTpH8s7R9svFVUeK4MDjELLDKJ2VecwMEGY=;
 b=MRZpkjNYNf0oXoRxtFQKsJ7X0QIx/echT/a8J6umBWCUDg6b/Fp7vG7XFY78IPQmTCC6
 nCXFi6m8JaCwqZDVsoc8YdArMfASoo3gkrmcbOhuqiCwDzQBnD8YuBJgWmsfE6KkIUZ8
 +ZzcuqijoTWSG8SF6Z21R8RsYtESHg+2AzJ1lxqFelFc94m3v/GKkzUaok/mFQa/nJwq
 hLRuXHFxVV6xRGMV62CR+myqtVh9vc9JYQvUHUXQcv6CeDbd+HwGwZb4uKOP11u/MoE1
 dlDanATavxE7Sw4eMW2XC4eRqcY9pNF7KBQy5nI85XXvBi0L1emjxocujfosjrIIm87n EQ== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by mx0a-0064b401.pphosted.com with ESMTP id 3bnka70k5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 06:42:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXPR4m5/dZGXGmdM8+xMVSmfbMXHOVQfQ/yn+bPfhnjTtDbxoKVpB3D5fVNrw1gllUlBKMdTqNsr/JQ8GeGgUOE1Z2XPMzmRF30oT7n8j9YmPiMd63GdKVmBNkAG4+wuN7BXc0qIRWWMC8/K31AYfZl9smUN28QfuMqNzCJ1e64p46iMH63Y0tXndNjibU925AAYOBwd4m2LyTAiLPTxBA0ksX5QCliQF6G/EZG/p0ajsqmhFdYogI2wJAc1y6CJ0NAmXgeFN9XuaOwgAnON3pvGi5XSHqTv96y0KZ8RtinNpEORwltBnJbwbkdATIqF4ueOr5DsTBtD10uwuydZQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mq++lUR0MTpH8s7R9svFVUeK4MDjELLDKJ2VecwMEGY=;
 b=KfINqt8K6roB3S+IFpYPuXMCW7TLItVCkVuh0evHzeDndzc3LjlSEUvf8XUusCAM+55SZUlIfoJI2bQtfzXgZRcCHZTWZ4PZyYJDs11gGD+FPV5pU7n1EqMwL9hOIsvQCUsNCEDUZmyqO8XT1cB8PCR0oElTkhE1d1X6pcjXeDSWP07btJolqhPYzYIgL4xNK+OYwD/i030hSMPMGAhTmO0/pnj3FDSZIK+DC/XFXdD3cIu6qDBAEb+7LtlPX3Kuwbrz29vDiiNoxCr9M8PNQWpEv6gUmFlzqzY76F+6G8wphBRMyD3TrsCx2iGsrzVgYYSFqjFIoc/3Jlm4c4BaLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM8PR11MB5734.namprd11.prod.outlook.com (2603:10b6:8:31::22) by
 DM6PR11MB3290.namprd11.prod.outlook.com (2603:10b6:5:59::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.25; Wed, 13 Oct 2021 13:42:09 +0000
Received: from DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::5db7:737e:8ef0:c831]) by DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::5db7:737e:8ef0:c831%3]) with mapi id 15.20.4608.016; Wed, 13 Oct 2021
 13:42:09 +0000
From:   Yanfei Xu <yanfei.xu@windriver.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/3] misc patches for mutex and rwsem
Date:   Wed, 13 Oct 2021 21:41:51 +0800
Message-Id: <20211013134154.1085649-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0148.apcprd02.prod.outlook.com
 (2603:1096:202:16::32) To DM8PR11MB5734.namprd11.prod.outlook.com
 (2603:10b6:8:31::22)
MIME-Version: 1.0
Received: from pek-lpggp1.wrs.com (60.247.85.82) by HK2PR02CA0148.apcprd02.prod.outlook.com (2603:1096:202:16::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 13:42:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41f53693-4af1-48cd-b607-08d98e4f40d5
X-MS-TrafficTypeDiagnostic: DM6PR11MB3290:
X-Microsoft-Antispam-PRVS: <DM6PR11MB3290850CC8E7233D8167D02AE4B79@DM6PR11MB3290.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Gez+vi1suCQN29OXHStdaBsUKH57xjQKWWwwzVvqV6Q9k22f1CRaTrxvkekrYa08vggA8QUD+vKztjgMHxh54xCw2nO7yXq+XGw9nOA2Uh+f3uRp4n9KvgZCseSWanZvZECmMOxY+z1DkCRnIxe9NqyMmdz6stb/Ja4Z2i9LwmBkxg5dZKb+X30RhqD44cmrsOX9BRPv0xdcxSVEQXiQJ9Du8o13W79aE70FpgdaEojOZ+fW05aLjJm341vgqKrCA7oUhCnzOz+BsLsqjNrUVVCZ7uhX1/LtJkcYuJwQNEXobTSGDqoIA680Kb46MUP5Q0HLQv7jNRbteRNeh2W3MBtdyQRhmlqrRI0WkLC88C15r/Tw7Mrr3txQeY4XiCswF/Vl/qBNaycWexjYMnr+Do4se2OpjSXldLR6bGDP7CCuRvu+LopkDnFXCJx2yEa3vqbP/t0fpK6GJTjdCF5zszJtm+1PLXNDmAyMWrajjW4BTL6LhQqU+KpNzKe6k1GGwXCaU3VO3iEATrvs62AM7loKrYg25+6YMXy4f+TzKMgPa/YY4SwMxJ0ZMWgy9wd4VFnbADM0HnsoU6QZRee6ii6MIPfZpreEdireLYqzVaNfvWE3wTnfI0M3jQqSZPlYbayANo0th4ajwAZpNAiineskROhSKyCoCotqF09Q7kL227IoqSzNaBCPrqwFwi1ydcQMhj24qDMiMtKiuUTkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6666004)(956004)(4744005)(2616005)(66476007)(26005)(66946007)(5660300002)(8676002)(36756003)(66556008)(6506007)(1076003)(6512007)(8936002)(38100700002)(186003)(44832011)(4326008)(52116002)(83380400001)(2906002)(508600001)(6486002)(316002)(86362001)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VlQOJYPY/gPI65wUJC3BODGU9NFxSqUUOaQHZSnJxF5J+zGaEzY7Ozw/rSMb?=
 =?us-ascii?Q?KAhXRwAArMVodsfQwhgkqof9Iie4xYPLAP1zLYNNTIyHVtzT6xtRiKpPE2t7?=
 =?us-ascii?Q?Yub64V8bhSWv+bILDLm7mb1PcH7E6awUDWDy2jPz7DXohkoOz87llrbaBh93?=
 =?us-ascii?Q?e1uERtBPzh2q7lk9fHtj9r2JkkllOiupQW3dN/eDsGWqq2JGG1iFirKHyMfQ?=
 =?us-ascii?Q?E2OFaFS1fLbzzw8QqNt1ZXUpMSRuSIjxLzCHHQeSZp8MvLjyCI/pziMSaiLL?=
 =?us-ascii?Q?xTFA4GZi84mHt7ay9Q6TFHvCMgak3sHGSoyKuokDyCNjVAz9REehyod+ZBKd?=
 =?us-ascii?Q?CLqT8dZ3YcoTgw/Hl5T6cZP4JBE05ZwNRlFz+EOviJsbrbRzp34CRzWhOba0?=
 =?us-ascii?Q?TmHwYwwHCh1FhTrxGR0FdXW/ffB7MjBO3Qn1UYLG/X3XgrcMYgloDtazkfZO?=
 =?us-ascii?Q?gYfisNGMx5jamH/YBTlwKXLP0VsTRpm8EwyoSITZZ1zhmv1WHGqvUNNZ86iH?=
 =?us-ascii?Q?qTCE+cmpopEirlW5hdnzSKBZNkUqJYYpL4jnNdY0UfGFfa5rS20KvC6LQdYn?=
 =?us-ascii?Q?MAA1cTFrKlhtQCpOAzaq3+dgrZdKFshiBiOKaZn8nl7pwdXGhg13lVbK2emH?=
 =?us-ascii?Q?sFGduQr1BmnHXf17ICrOFOPWYZW1yD4wBA0P8yb9x8IIAJFuFeAI2y0MgnRF?=
 =?us-ascii?Q?T5BdOPwr+79j7crnRnE2Pzh5i1vADj+Ad9U3Gz6xbyoiFQnpZUlzXkXE8lES?=
 =?us-ascii?Q?1OwisCkK6s1SfRMFc1gYjP2ZgVepmTx8AIvVgJjsJQ02jX0VcXTN+4rqzz66?=
 =?us-ascii?Q?aapu3oBBFEkRlyhV5pHDXBVBfGVIxKBCmRIco/fIjBzqE1VGIm1iEzMpYoyX?=
 =?us-ascii?Q?AVSi9m3BDuugq8rkORESguwU5LrEnZfIBG7RvmAPa7IMBPCcCsmEGZPH3e8B?=
 =?us-ascii?Q?4BrX8J0iaclS0de7Dm38Jh314R+36jxqo1I25hI+xfp937tVzagwybIJ4RYp?=
 =?us-ascii?Q?7tivF21mL+/OXXpqoka+qfScb02g3g/7eyk4zbtQ1CDNI7h5eeJJcc2xV5tF?=
 =?us-ascii?Q?KHVf8mOxK3a2XkuslZq86ZLhy1JKmIQaSz7YH0i/+rwFqiVw/n3LE3r1/nf4?=
 =?us-ascii?Q?9e2te5Du8lNEvN5jAlgNKT8PbRTQDRZo0bPQpzbNog2S1IoDyH0HnTt8jmjp?=
 =?us-ascii?Q?UEFQum0mz4/GSwoQqTuUHInZfA6pGG4MoA1TDmddt7s8aZziKvZBh9fCKmte?=
 =?us-ascii?Q?jjNBfOEG/Tn1buMtj6Lwp4XHJAfCGxg7cqTwEDsAjcZoWGpOXJTgBdUGBaht?=
 =?us-ascii?Q?WuUaMTwht2dIe1GtlQjoeUq6?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f53693-4af1-48cd-b607-08d98e4f40d5
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 13:42:09.5195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /9IB4HyYEMCKQBYP7aiEV/ANtQ+Gj9X6h7sv3zWlDFwuy8eOJNnJ/iZp1nDplWYs6nR+RsrjjMPM+DVLKSKNXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3290
X-Proofpoint-GUID: eSATdk4b52FKgWEH37xoiUF5wPfhqLIR
X-Proofpoint-ORIG-GUID: eSATdk4b52FKgWEH37xoiUF5wPfhqLIR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_05,2021-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 adultscore=0 mlxlogscore=746
 spamscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110130093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[patch1] locking:remove rcu_read_lock/unlock as we already disabled preemption
v1->2: also remove the unnecessary rcu_read_lock/unlock in rwsem

[patch2] locking/rwsem: disable preemption for spinning region
[patch3] locking/rwsem: fix comments about reader optimistic lock stealing conditions
These two patches were sent to mailing list some weeks ago, but it seemed
to be missed, so send them again.

Yanfei Xu (3):
  locking: remove rcu_read_lock/unlock as we already disabled preemption
  locking/rwsem: disable preemption for spinning region
  locking/rwsem: fix comments about reader optimistic lock stealing
    conditions

 kernel/locking/mutex.c | 22 +++++++++++++++-------
 kernel/locking/rwsem.c | 28 ++++++++++++++++++----------
 2 files changed, 33 insertions(+), 17 deletions(-)

-- 
2.27.0

