Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9393F5D58
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 13:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236847AbhHXLxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 07:53:11 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:37950 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234787AbhHXLxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 07:53:09 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17O8iCKE015031;
        Tue, 24 Aug 2021 11:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=tSAtuqbYaNEZyjZ5drWwZydTcnOX3xNBJQJkO4uBSLw=;
 b=SnUxYMF9WL5VL7ZZNGdxIR/NWIDRy6lGnLNOqPd3AWm2NoIUplp1R6iIDRYDA4AhgGg3
 vsjkM3FGEEBggs2wigch2R/rKqZSIRgCdwbzCtYF4Xuy0LqRdTtsf7cMxuMLsxOEHXnx
 MTBCEsET8f/vnfcl8FTjn+uA24BgDZj5ELiEGv913O47gRe0UiPwLlwWTeTgDaL81tsU
 QQzft7pRAD+msjn+8eKuo1fbRs4RZ+VciIVZKuTt597KOxHP6uQ/xFsnjdLKomkcUuJ7
 3yrp+gNsFhRrd1Six3C/YvQZQ5pSp+XhW8yxmHf/dYTsgdm37plX74pxaaKZvODtBQeb xA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=tSAtuqbYaNEZyjZ5drWwZydTcnOX3xNBJQJkO4uBSLw=;
 b=s6v+bXrZ6kGbIEKluPYZq+iGwPcVDoyz4AwUY9zRzr1IqVY1zQou4No+zxNIvm/V/00x
 BqH/9LpGBgRZGS0XhK7oCwDhznK4izH3TbDPoCtU3mofhswX/Q9M5vb6cOr3ZTqfq4hw
 maqX1mx/I3CR18OommvoKBQo1cgdfPPekFkklKUaNx/oeyTFL0DgI3qcFZqOo+Z7YSr2
 /bnrs4Ue6ILlmwFWpdetHAXRG/Q2CWnSFM4pc8TgKKI/WXrw8pnfTw8FkUufagrqbtMs
 VIWb7g8X0NOw9Ou7E/lMDMzyoIxRwD13VadM4mN78hfw+njzssLMoB3z9Jb6gNL8KKPr FA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3amwh6gcq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 11:52:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17OBjKB3192215;
        Tue, 24 Aug 2021 11:52:04 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2047.outbound.protection.outlook.com [104.47.74.47])
        by aserp3030.oracle.com with ESMTP id 3ajqhefr87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 11:52:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YV9TCdaHo78qtfiuVW5orZBujdJKFEJCQ5wLLZkIwCc2FjtFpIDZX6abmZnzdmdNBKwF9lgs/7bvSU5spAdiuOo/PtkVCzIjHGRb+Ed8UFaAY3r+7P6nkbXT4pu7DpK4ZYimxVcwOiI2p2EenEN0CnYhzzGI+HEscX6Ld5zpuwVKRZMUHhlvhGRhqqnAJx11Oo83eunun3vamQkYgHL29YoT/x6jVLl1Ve3DKJuT/bLdE2DkYHUmkbsezVSqU7XCuvXNLEFbp3Oaejn2bRvEfelZOBZvhrL++qy6Rz5fQqOvte0abrvKPgLWyRon2J9gGSjxCrn0ktcHcXVAbbf9NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSAtuqbYaNEZyjZ5drWwZydTcnOX3xNBJQJkO4uBSLw=;
 b=LtyYgV3nqUfisdL5pRdBJ8UQaDHWHmMps0ZDo1hq/oCSAzVqbMNwyci9LgOq2P1b7I2y3uoqU/1iVJIkNFNbHDPBj6UZlnG/34BMfr4sfxEDu5/r5RN4teOcEfXSLS5mn9sPxNkRAoLLsIQ9fTAlS7E5e/2S3xoFi99rR58PJuX44rHv7GM1F1TbLjH9yrLVA3e4FcYz7iLc1ND2qE80G6JR8GnnI64MBsck2CD7YbLU49XPcKVIDXeP9EWdap9wcMwDsqMYP2V6ghRnNU4xtPz7sMuk5ZejhPw7j/bakQDsvhKU0Rmt7irFIK2IETEyMh6usIApeVEWNvu7XeDO7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSAtuqbYaNEZyjZ5drWwZydTcnOX3xNBJQJkO4uBSLw=;
 b=rt39EFAXu+97EsMaBuTX1u9XZ2w/On8TDBmkvCsfklNrWpK8aW5zqt8SQv/i8OarCIQKM2JIh2TK85ySKy2xRgEnkWF39cVneZWudm3oBUmH0TJIp1aoJ3sTa2Pr1awonKLz/gueoC87FNIQUMwv1l67NNkPEimFiAgC40wU6yg=
Authentication-Results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4595.namprd10.prod.outlook.com
 (2603:10b6:303:98::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.23; Tue, 24 Aug
 2021 11:52:02 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4436.025; Tue, 24 Aug 2021
 11:52:02 +0000
Date:   Tue, 24 Aug 2021 14:51:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] tracing: Fix some alloc_event_probe() error handling bugs
Message-ID: <20210824115150.GI31143@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0160.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::18) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (62.8.83.99) by ZR0P278CA0160.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:41::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 11:51:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9391ab7b-a12e-40e1-d10d-08d966f595e9
X-MS-TrafficTypeDiagnostic: CO1PR10MB4595:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4595EEFBD8DAC86BD32876968EC59@CO1PR10MB4595.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2wbapfX7GCkQ6Kxk6Nsn0EMMrlAp/ZGcqC/YPUcq9KrB2Y3ow9Qj66jQmZKal1AaEN0+ZjPATrCdIm0X4F23bLzEAG2oZ1MIFfCdIYSumBA3Rz3NgAeRmxjZblS12akoZe1HkVnrsguERf7Q3pXLuS2qNlRzYWWvFSSeT0npyCF80iRbQr5xIibUQXRAcYFWH9yUTi6AYc234BdONuoILAqawcY1HBp58zcKKeQWVgHwqo/b2paIdDrfcSwbgnRwGMCbT4nyESdWb1Jmzwjp7sFRCpaM+HYXtGJFRXFlJRl+GyGxikOeCgE3SbN0kftoXCA6oBMcNlyD17b6SQIdOoM+aMMpAq0WtT4r3Smx/MhLrmLt5Fe5OBg3texDTOLAiwBxJjRzwCQOqC3dRRIIsn30DhhRNgwsdH+Zn+B021/JnxN3RInl4Cuv3ET+2MqeJAlrY985BHjTSb2BBl7PIoha1l9bTaxPZnhV18cGWB/49BBSSSGjJQrzU7iFA7bo8OK05NyvOnB8i0IiSqMsgXylayTZDjuCE0GJbm4ld/qa43VBwxBRSF/VzINxL0YynbXl1GHq6PR2Yq+lsdfnIX9pQqEqi0QiPlm/zGeia1G0XSbhaGkLkoJx7A8SYzNBPFOdsve0YB7AvfntJePzpqOzY2TZjsE+xMlcCJNZR7hqJJ9/sFSGGsXVzgHdDN/3ctSjvhXCvZ4NoNQiD5cGzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(39860400002)(366004)(376002)(396003)(38100700002)(38350700002)(54906003)(6666004)(1076003)(86362001)(9686003)(66946007)(4326008)(2906002)(6496006)(66476007)(33656002)(316002)(55016002)(52116002)(26005)(478600001)(186003)(5660300002)(6916009)(8676002)(33716001)(956004)(66556008)(83380400001)(44832011)(9576002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6mcWe/2hX1rkkoDtR4Tx8I7AS7kWyj9MxGrEtg/t95enQSelNCP5IfmWNbps?=
 =?us-ascii?Q?MI2pYT6xW/NbPey0ORZ2u+/lbEpNnnYfgueT4M95KR+m+pKLauItNFWIaCOW?=
 =?us-ascii?Q?NcXFua3jugkvZX9Cvz64LJkWnePd5WziNLwVtyVWlJRzrU9oBn0dQ18W13kn?=
 =?us-ascii?Q?PhYRhofNBK59AO804gOuXFUCSNEegM7SqdTCRh3lu3hEX+kiBvRwPsEg0L6x?=
 =?us-ascii?Q?BcP01am3djBAdpJihIDd9pCmUT8IN01oGcXQEsfFyTEV0/CdwbttmCMsylSL?=
 =?us-ascii?Q?mo3f/RxYSXTXWxCekiBezZqP8PzbkEJECYn6rlxuNwtabZDP6EMXRWt1Htk6?=
 =?us-ascii?Q?Y7mflIGQUUbIS7cdWh5biv4Vk+aYAasBjzByIInhSQS3g3BrqFuV2kIbxflj?=
 =?us-ascii?Q?0B352VYIjOYYr8yicwFo3wVmedYFz/4+Ijmq+EFCadrg51cQM4DGc3Z1qXRZ?=
 =?us-ascii?Q?Z0itSo6kC6X9f9JhasvxGdmfYrzT7IiftZhXNWUii9dinzo3W47eXksX94Bm?=
 =?us-ascii?Q?/K6lutYek3TZDPB07JYxpvFqytiCGSh8NmJn5J9NbhhuKbY8Ls+9uEgAOQza?=
 =?us-ascii?Q?YwcxmC5fiZn2nC2x7WercJtnIfGFlRD9fz3qlft0mpJzzmWr25Gv24GiTATx?=
 =?us-ascii?Q?UX6r+CY55JcLYP503NSkVGoO6arVkzZmc8CRKAOkkqpICbRrme8Xo8SmOdLt?=
 =?us-ascii?Q?6J8V3R15FlY+e22POisJJoLffjedFUJzA8E8nBpNBualvfdDXU5viAPARBu8?=
 =?us-ascii?Q?HklY2M9BvkgSknbmImqc4asof8Zl99ivPR1QQx8K7vjFfxs/i8AvGGMErBsp?=
 =?us-ascii?Q?KpfxDZxv/bm3l3wdJw6txEU4654LfQpf0R5nTCY7AJ+MeV7FUBST4Y9fs4h6?=
 =?us-ascii?Q?g/LOBeXf3b5i4iJT2zmStVLB64rzrXrZ/oUDOWn5N2YhwhXYoV9PsiL24rzJ?=
 =?us-ascii?Q?aRpI+eSVNZ5SAwawSZc1PVDPIO9sz/RIfggv1qgFNMNKL872O+2TycKPrbsj?=
 =?us-ascii?Q?uocN5U6mfOhISb2TZSmHNRdesxqvuO570DZwb8kgy1o+6JJMsxPvKzfubOc4?=
 =?us-ascii?Q?AHSlkqOUjKOcX9vKJoaAiZUGl87pz4680tXFB4IC5Hta/9CLQ8K/nfBECdn2?=
 =?us-ascii?Q?/5IVANQBUDVAv+tH9VlrfVagXeOsdACLmLu17jSvtSiLMExW9DpXRU182cdW?=
 =?us-ascii?Q?ZdPeqV+siYxQOuKQKQBT/46LALgfxt9Qt5PKHyheaQGeH1+k36NA7aZQtZF+?=
 =?us-ascii?Q?CtO3UElwyJeKAHl8EEQW/3ysHxUnax/jvSmyTvKaHFJVpSextKaHQnzCpQ3O?=
 =?us-ascii?Q?I6XEfDHlFRX2k//RxHGegxif?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9391ab7b-a12e-40e1-d10d-08d966f595e9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 11:52:02.1263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+8sZE11f9f3XOS2siPwesbx7ickp/WAQmH2Td00UDAhOl+1FGH93shqp3a2dzrOmAAuFgWDhBD1JscdIbF4jW+Z5RZD1Lsv74OHu4ymQlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4595
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10085 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108240079
X-Proofpoint-ORIG-GUID: WEHiP4XV87-jIZGEBM6fdLDEJDKpkKuI
X-Proofpoint-GUID: WEHiP4XV87-jIZGEBM6fdLDEJDKpkKuI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two bugs in this code.  First, if the kzalloc() fails it leads
to a NULL dereference of "ep" on the next line.  Second, if the
alloc_event_probe() function retursn an error then it leads to an
error pointer dereference in the caller.

Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace events")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 kernel/trace/trace_eprobe.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 56a96e9750cf..3044b762cbd7 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -151,7 +151,7 @@ static struct trace_eprobe *alloc_event_probe(const char *group,
 
 	ep = kzalloc(struct_size(ep, tp.args, nargs), GFP_KERNEL);
 	if (!ep) {
-		trace_event_put_ref(ep->event);
+		trace_event_put_ref(event);
 		goto error;
 	}
 	ep->event = event;
@@ -851,7 +851,8 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 		ret = PTR_ERR(ep);
 		/* This must return -ENOMEM, else there is a bug */
 		WARN_ON_ONCE(ret != -ENOMEM);
-		goto error;	/* We know ep is not allocated */
+		ep = NULL;
+		goto error;
 	}
 
 	argc -= 2; argv += 2;
-- 
2.20.1

