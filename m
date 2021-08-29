Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377973FA962
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 07:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbhH2Fxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 01:53:45 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:48446 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229634AbhH2Fxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 01:53:44 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17T5qTsv029937;
        Sun, 29 Aug 2021 05:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=AVLC636WedSxXDGNM7junJLcZMGENx2afmB3xbvp7aY=;
 b=IQENjx0Of29F0TgG+OTAW7m/uoldRnWSEF0LsIOsGS1ST/L+JB8GQQsZ8k518t12ted9
 +XNrVYWvGg6MzhYzrnFnvWzwGuFpstY+cBGi20WpeU1JTb1DGgDrdSAJoAEotgpoYUF2
 yxxPL2J6Yd3EYTIrH0pbOxnoJ3lPHOyQLF5Ky7uK1T9tSS6IQTwJXF3XyrSRSz+NgK06
 iGywL6q6yf+zPKjCTaEuIaTPp4FYYliK3p+iUMkNbmPnaqAsWuQrCpnaAt7kAiDKDkqJ
 PA5vakGUBXUgBfWNIDzA7hUvtyjXKXalOnRDqRnLE+4f0aSWfBl/WkhaejHG9kKwgxEE 8Q== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by mx0a-0064b401.pphosted.com with ESMTP id 3aqac1gnk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Aug 2021 05:52:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R04e3IOs5R7dam/VUpa0NY1RHJbvjhzWpvghk0OFTDKKreS1du0ScjL2562w9TEBX0G/23zZ3IGrUDdkrvBBwiWgB0wOMaJkPYJ6bnm34lqakuax/HpAF2Q/TuljYNF0aHWuhsHV0Mjlz+GfgpHqesDRHkQ2BoNiWN7Bt3qJend2psAZWaCUreuMmSMlWaNu3M4rnEekVD1XnUGEhig8wZKWQwebnPdssD8oXxo6IiE/zwjW9JPYdyte4o6zO9MGFPcCST5mgOaRYWq6QDnSH/B45Agi/eeLnYhxtcK+Ybj2kzXRJSArDBppNeSOLOep+5Uj/bhBxC4wUggRPSLQEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVLC636WedSxXDGNM7junJLcZMGENx2afmB3xbvp7aY=;
 b=IEMXH/YgKYCgHHIKKERGBNiiBwUhs1qZimQZhxwnEkuhfQfzbu2kX6EqOzzIWtwK+AUm4ZwP3sCvys0rY+Xuepy6+RUEtSbnr3qGTGJM9ynXFB/Ymht/Nb+TPYgjI8esKqWNFlX2yOpdRYv0QmWw1/JZchvEHVCSuUQJ+dEBDed/EEvuW6GAo8ECVlscDoBrm8BWkmMnQocHrQAvxlRudAwZ1dT+5f5rWZTC4JxAqcF+l8nUTKXWo/76sd6jujuDAFC692iIj0i8hip3HjklLTfWKmaz4ZK9lGtz4t22dGcfSMuvbXRzs95Fj7btXwBiWkclnxYx9IWUh7Etf0wAGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=windriver.com;
Received: from BL1PR11MB5478.namprd11.prod.outlook.com (2603:10b6:208:31d::12)
 by BL1PR11MB5286.namprd11.prod.outlook.com (2603:10b6:208:312::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Sun, 29 Aug
 2021 05:52:26 +0000
Received: from BL1PR11MB5478.namprd11.prod.outlook.com
 ([fe80::b16b:d6bd:fb7:457f]) by BL1PR11MB5478.namprd11.prod.outlook.com
 ([fe80::b16b:d6bd:fb7:457f%3]) with mapi id 15.20.4436.027; Sun, 29 Aug 2021
 05:52:26 +0000
From:   qiang.zhang@windriver.com
To:     bristot@redhat.com, rostedt@goodmis.org, bristot@kernel.org,
        mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] trace/osnoise: fix missed cpus_read_unlock()
Date:   Sun, 29 Aug 2021 13:52:06 +0800
Message-Id: <20210829055206.137025-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0179.apcprd02.prod.outlook.com
 (2603:1096:201:21::15) To BL1PR11MB5478.namprd11.prod.outlook.com
 (2603:10b6:208:31d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qzhang2-l1.corp.ad.wrs.com (240e:305:7883:d1e1:bc7f:e2e1:355e:7306) by HK2PR02CA0179.apcprd02.prod.outlook.com (2603:1096:201:21::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Sun, 29 Aug 2021 05:52:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bedc6ce8-cdfa-4954-441e-08d96ab12d95
X-MS-TrafficTypeDiagnostic: BL1PR11MB5286:
X-Microsoft-Antispam-PRVS: <BL1PR11MB5286669DCB76568E479C2D4BFFCA9@BL1PR11MB5286.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IsTNC1d06kln9Xsb+Lu8n0qU2iZ31Aj8G7bEpAXJRjN+ZXf21dup9D1ygAIejeSBQsyw+cZwGWrXSxw2FqHTihvldUNDtXikXOoDg2a0gupAuQ7YCSdtzqfgfYHfFTmLgY5gNlZw5Pr7fnHs0gh0iXJA3l1P7AlQWpre7GRKIAny9OSlfHo8ldUKofnf0nJfCXUhPnxIw2wVwQcOzkg2+YkLiO85bR8zXm4a/Q/3rVDSSu+XwTF291vzQc2Cnn0y07WFkOP2fi8v9TSivhkav1cf64YJ2DZgDsKlb/nYf0wsYOk7bei2xOdErr0te2c2YVAC/EU9ZVR6jaUjQToplW1I+igm7A9DbXFsO3YFQP02un1jc0/z1yZdYqt2tAbuJgK3CjUiYwMhwU5APDQevVbZB3d7WY6jiYsO5Dp2GmjI1LijHDdiu4rgvst6FtuFRcf0UkDynBWDgFUoqovYYBBKUgoAjgT66pwqBjc/25iJEFvDFfAvvJ21YbhEiYx7dJR09oT+WEvD4OzAo2/u53HHRwFmLWhueeOryoI+Lfz/AtDoiw2OXgABwx1mDDRCzeTqsQx+O6xrf1TnumOIpX8VrLgPbI/DvB3sRB0+nb/X0bbsDBRHAFrsugaXtFFK+pHuOeEZ3f03CfpJl3PQgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5478.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39830400003)(376002)(396003)(366004)(346002)(66556008)(316002)(36756003)(5660300002)(1076003)(186003)(6666004)(478600001)(66946007)(6486002)(52116002)(38100700002)(6506007)(86362001)(66476007)(4326008)(83380400001)(9686003)(6512007)(8676002)(4744005)(2906002)(2616005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ix59c30zvur+SgVc9ZEaTjNe2TIlvm+dmxO4ulPCeyOV/qkeT8VhPebuDQfE?=
 =?us-ascii?Q?bXA22xRGhuzQmv7dE3j7OeCkYc7YYH00v2ccRuEAAb8yspqHyNShia7VTNx8?=
 =?us-ascii?Q?e4Aik8QajRfYJ3q+WeY1YLvXYL4tyZFYpHDo9Q+QlQxFiLnqS13W6Nll6cOw?=
 =?us-ascii?Q?s8ASevzhfCIVdTUh/bZYkOUEaLvanoH7QlGiBa+IfJa9f8lNI1lBR9ogcHIE?=
 =?us-ascii?Q?Ua40qe/V5mvrG6s93UcI831OODn2h+d1zl1svSmiK2lozEfRfe5VHNba59pQ?=
 =?us-ascii?Q?iursdpYUHSZ3tD484h23vdX6JNt3z4zzAd5tqoTA3ycZuCXaLSKsPzLZlD3y?=
 =?us-ascii?Q?mCOVjY2knQnY1FbZ/DzRMZTyXZyDv9UQnxh+3c/gwnq6wyXmokStqAj/hHAw?=
 =?us-ascii?Q?2Iircof6UFb6ZPIn2HztfKtjeKfZSt3R7Qh1bmmlwsHcPf4yXGPsjI2vgd2s?=
 =?us-ascii?Q?FAe2RiPZfy2FA+/E55xzH4NobS7LSQZ4IwuTZGWrfdc7kw5I87eBQZhVR2Jr?=
 =?us-ascii?Q?KtVV404F0emoQmDDSKJVBylV7BdhFLRxBjMB8da6T8u3crU8EnyW8NHUjbIf?=
 =?us-ascii?Q?0nq7nqC9dkTl2Io5DW82+FqEaOvE1rOwkvzLBW1psox+ChUqJT1CV3Vag95Z?=
 =?us-ascii?Q?nQ9Y3Q9GnFayoDFCeaet7JlBLxlU53rWl3Z9mOxIPDDKJ+dddsQNTg5PqVB2?=
 =?us-ascii?Q?a8/S3dnDr3D6FmqUhs+sEOxDUzuimvABEjluNkhmIm2uWPdmHp4u/rnRRcq/?=
 =?us-ascii?Q?K7DB2/dltKRyOpdthg72XuR+FZbY4BZuOHfkhNyIH0mcB4ICmctKaIrjxZeb?=
 =?us-ascii?Q?U+ZI6jcDTZFrdf6MaGuhpZ1NhOUSeOEIzy7tSuG8CaMsNvvMjWlbfS1RK3bK?=
 =?us-ascii?Q?5VV+aKjLnxtCBBlzVhSWHt9Ny0uM4TjiFmVwgj3n9IUh4YTWhAPRIkjB1MHq?=
 =?us-ascii?Q?Cya+UwZuUJKEV05kRwB0U+z7nyzdALn+0sCdJWMFp6IVUQPUaQzNlgKkASzw?=
 =?us-ascii?Q?grf/MPBG2vvOh9Br66bOjFCJ0Q+3O3Drs83w/NmRlRqgN+nn4njGR5lyL8kx?=
 =?us-ascii?Q?WTPel3vuLd+h3QQUzX+0Bp609JN6/hEqZzE5yw97W0IJXy5mVsj7Ez9JesW8?=
 =?us-ascii?Q?PYXZkQ3JrZa5vxzciGVe9tvT32vQwmcGKfW4xqpkzrDTFckMMloa4G3gnTgF?=
 =?us-ascii?Q?N6B8pRMqFJDVc6HiykJOk1BEbyppeuSFHhOf5JTpwm5030SzvY5z08d4bUXy?=
 =?us-ascii?Q?ROXYUo9XS+WgD1Jnw8X+iIY/OXHZmQPZCVrExmg8btbpIVclczUU0e+0LPNN?=
 =?us-ascii?Q?bBNbHlXU1PJJenFG5PC2+aIx5VpL3mpVGj9COooTH4ZKqcPyeCsGrWkf9Dgj?=
 =?us-ascii?Q?9+wOJFpCPybN90KdRvmvmScS1F5J?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bedc6ce8-cdfa-4954-441e-08d96ab12d95
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5478.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2021 05:52:25.9613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GA65JW3vbkugotUEOmqOpIn0SkEYHi013QFaULHEHo7WO8hNiAWIkP1vZLnEihjfEeExSxk5iDsE6Po22u60TFBCyuaPdRIqM/hlTRkRheI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5286
X-Proofpoint-GUID: YaRtWc3NmEWhI2_I7Krlk3dQLjmPiNAv
X-Proofpoint-ORIG-GUID: YaRtWc3NmEWhI2_I7Krlk3dQLjmPiNAv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-29_01,2021-08-27_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1011 malwarescore=0
 mlxlogscore=878 spamscore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108290034
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Qiang.zhang" <qiang.zhang@windriver.com>

When start_kthread() return error, the cpus_read_unlock() need
to be called.

Signed-off-by: Qiang.zhang <qiang.zhang@windriver.com>
---
 kernel/trace/trace_osnoise.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 65b08b8e5bf8..45d22d6f3acb 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1568,6 +1568,7 @@ static int start_per_cpu_kthreads(struct trace_array *tr)
 		retval = start_kthread(cpu);
 		if (retval) {
 			stop_per_cpu_kthreads();
+			cpus_read_unlock();
 			return retval;
 		}
 	}
-- 
2.25.1

