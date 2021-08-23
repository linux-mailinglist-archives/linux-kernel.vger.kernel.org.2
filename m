Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F8F3F5066
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 20:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhHWSeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 14:34:07 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:10910 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230160AbhHWSeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 14:34:06 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17NH3s7i005548;
        Mon, 23 Aug 2021 18:32:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=E3fhKwv9fV34Db6BiM3uSfrnVg3F+HQBc8aHxFNv8GY=;
 b=eUS1fKxPAIEkVs4saQ7JXU3SNRaaNm6DHy4PeS0OfdhzBKtBuaZCiqrc/ApB+NQwEqlM
 OtU06ngB5M/kaWiqX61IBWrqi13oQ1ywVJ2prAvvTYfKhpaLJqYFuW6uzvr17an4I0LT
 omDQXkuZH0i0ilHD3UK3QtVWAtd6zrq6R4dnS7GE6SH5hKer/dSXeoD04WpZU7C2m6ji
 1vIHjdX7SlV7emmSku1VG/yGQId8CB/3Yu42DzdIztO5zsz8rO/ukyKlhbDnTS6PrtDV
 p2vVgBeGVMAke8zBEnv4cQeu2j2wbJaTst21w/9JyBN+NQZ9njCwkyFGfMP2Rc5LLIGc 8g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=E3fhKwv9fV34Db6BiM3uSfrnVg3F+HQBc8aHxFNv8GY=;
 b=HxBgBkTmmQf4gO/oZNtpwDigelVNF1RxmZwx2miKgtWY33vUXI+6TOh58oxmroO+tYPI
 YboE4MlTFqsiTWIn2V9OJe/0V82ehKHDBjMyYidrxd0lhxFerdFcJ5cB2gGzW0qC12fO
 ZG5aTYIMot1dN0DWmIUzmOB7ZayPeJmo8HnK9c+A8k8mA0xpodh+gszloT579W23ZEJ7
 EG/JGH+WxX6qP5W2ynnRzFJQ0OdObwEN0033g3eTql4FyzNDz4zkZs/ilkCp/TkkSD4s
 Zw6uJVp7aBViPsc2ga8BDii9AeBcQJdtKJJWXhkAjBdseGorRmilQZk3VA+jsrzqYsOi Tg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3akuswjcvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 18:32:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17NIPHIt027500;
        Mon, 23 Aug 2021 18:32:20 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by aserp3030.oracle.com with ESMTP id 3ajqhd4y7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 18:32:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1zUdLNNyIhGCkMFdH74agQNsre4QuyfmzlZAjaBTbVMh3L9mD31PbIKUVNe2DyWHzg8bxa9NtIMsfsdAAZREXU5+2DBuCDbFavWVMKpKO7aY85ZSWzNK8H/Ea/Hd4cSazSrloxPveSxjZzjCkbmDBNWCYO/maMalvYKFuWxMjWywABAyO5Ziw3wkOZjMKBr51Eo8rddrekwxNB1m+9SOYxKS45Z+u2p0EpG8geAksb+/XHVBix17e6uVp23Y2YrwjDXZ2NHIRrQbLR2kaIq38JJs+FhFgqrdfdnJClFUnhd381w0465lUKYywEBr4ujSG2k+x5/nef7Qse50e2jUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3fhKwv9fV34Db6BiM3uSfrnVg3F+HQBc8aHxFNv8GY=;
 b=boKM2rPFOsS+3Cw+fgsEIwMv6APfPIStIkrQ7v2IjE4ET4FS5upQBrfKtZzULfTtRakUd4inioe96WNMBZjepS0t2PLdC3AOqdTWKCgUQob4l/Hb/lRHKTazbqWSdegCbpMQPadbTgn4Kqo6jRIai2wt/OI8Y/Tq4jWp00vF9itNNE9PTBcOvuLC2mq0PIecZjsD+TYTETlPI5AOk+3/RdoubFbjGi+aZA84UJQ7LSgHdaym+pHB6d6ihRqjh5yRmJRMdPr+s0xd7JSh0gfjgrW7DmHREc8yxlQ6CaJFIonLyCXHINZ9g1ksTwYwLd5D+sf7Pp/qvVpwFuXhmawuDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3fhKwv9fV34Db6BiM3uSfrnVg3F+HQBc8aHxFNv8GY=;
 b=fgdZCh+iVdvVzBK9XOmycv5faG5xH6uistR5LVr0cT15XOlKsvF9qX2iXE+BrY11YsKgi4UiTbJtAjTJQy8zn4oKx11d7O7f7m6Zo4ZXyvrj3u/WbBiwX6eXAOToc0O/5qtoX2hEj+VFpdiS9k990vfTOThPvxCQ8UZUqBcf3H4=
Authentication-Results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none
 header.from=oracle.com;
Received: from BYAPR10MB2966.namprd10.prod.outlook.com (2603:10b6:a03:8c::27)
 by BYAPR10MB3030.namprd10.prod.outlook.com (2603:10b6:a03:92::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Mon, 23 Aug
 2021 18:32:16 +0000
Received: from BYAPR10MB2966.namprd10.prod.outlook.com
 ([fe80::203c:7f44:c562:b991]) by BYAPR10MB2966.namprd10.prod.outlook.com
 ([fe80::203c:7f44:c562:b991%3]) with mapi id 15.20.4436.022; Mon, 23 Aug 2021
 18:32:15 +0000
Date:   Mon, 23 Aug 2021 14:32:10 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Huaixin Chang <changhuaixin@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        anderson@cs.unc.edu, baruah@wustl.edu, bsegall@google.com,
        dietmar.eggemann@arm.com, dtcccc@linux.alibaba.com,
        juri.lelli@redhat.com, khlebnikov@yandex-team.ru,
        luca.abeni@santannapisa.it, mgorman@suse.de, mingo@redhat.com,
        odin@uged.al, odin@ugedal.com, pauld@redhead.com, pjt@google.com,
        rostedt@goodmis.org, shanpeic@linux.alibaba.com, tj@kernel.org,
        tommaso.cucinotta@santannapisa.it, vincent.guittot@linaro.org,
        xiyou.wangcong@gmail.com
Subject: Re: [PATCH 1/2] sched/fair: Add cfs bandwidth burst statistics
Message-ID: <20210823183210.bih6p77fh3gwdfic@oracle.com>
References: <20210816070849.3153-1-changhuaixin@linux.alibaba.com>
 <20210816070849.3153-2-changhuaixin@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816070849.3153-2-changhuaixin@linux.alibaba.com>
X-ClientProxiedBy: MN2PR04CA0034.namprd04.prod.outlook.com
 (2603:10b6:208:d4::47) To BYAPR10MB2966.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from oracle.com (98.229.125.203) by MN2PR04CA0034.namprd04.prod.outlook.com (2603:10b6:208:d4::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.18 via Frontend Transport; Mon, 23 Aug 2021 18:32:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b496a69e-aa4f-4795-c477-08d966645494
X-MS-TrafficTypeDiagnostic: BYAPR10MB3030:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3030486CDB8DF4419D63ECE0D9C49@BYAPR10MB3030.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E3OOiVppZraiAszDvV/F5tdEo9rd5BPZrEZNPMVNP/xyZGMQ77T6kEDDZxItfIB/Nfg2uaMYxSaXE0yfvG+XIEQ+1Pwc9wCgPa0XfYBp3JE1AfMvhYaMJYckvfmRydve85IACmMp2caHhQ0i7xEeU4YekSQSxFBxv7Jl4ZyHSTH+/PGP5YBwON0v0GWEHuXMg8A3wsvnpAs9MveOihBNuA8YvBxlvENATg5hiw48H1vCI27Fnyb7h4picMQ0TYNGaD6pv/Gp3tlvfzWV8oAhTdrj0RJOJiq2ip+wVt7Sc/QxLaI4redC8+bitw7CstO9UnUyl6IT55iJPzqAS6ziTAP8Dzbn4cZRilz2MXtuekX+YTY4CzHQ3K3yqD2JviXI8b77L0Tc0kQ493Hu7/hQbVh8ajVjOOvSWqorTmYwjflhpg1tyPg1vQFiufsLUWDwMuZ8j4ROx4HCup/wKM3FRjbp7NdwSC/1A/yLvv0pglCuln2qXxGTcXBsigbSguU2pz3jkmSD5CI3RBNVmDcZooWjHYuA8QHkJNoUSIZ7KMmD8AkOmZgmxfipFmVDkRytTxAN4VBqDsDe47VYnTuz6Q8J6vrA/nGJDfJoXeLTRqJPG3GY+ErAPpnbPPtGiBzJIRjefTjh9fKJYZK1/P9f5iDWenK9TNzXzuVLSaG6fkL1T51IZQl/tPYtLNcD6Einq+iyGOid8iXUncp5KP2Xrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2966.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(346002)(39860400002)(376002)(55016002)(52116002)(4326008)(2616005)(66476007)(2906002)(8676002)(86362001)(8936002)(83380400001)(66556008)(186003)(7416002)(38100700002)(8886007)(5660300002)(38350700002)(66946007)(1076003)(316002)(956004)(7696005)(478600001)(36756003)(6916009)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1tlKKx/3pXaSe3BHXbs45Z/CzxtoYD1+7A2D1iCnNcU95td16hzI1cUxG86x?=
 =?us-ascii?Q?I+tIUofGHI5Rliz++XQPk38f6JNARke9/EBkDZdAf/mY63Dj8ub0hW1aFJoP?=
 =?us-ascii?Q?0JmTp0YWQsjv/pLT8BlpksvTXk4QgB0Nvm9UMaRbuVzMZ8gTNYBtTw7RwtKR?=
 =?us-ascii?Q?7kADGy7Dux83dT+z9EFQOYNyf6Z2lrOjl1EJB3isJhe6EmsIPsU6N/qQ9OR+?=
 =?us-ascii?Q?ImrCepTNwF37C1ZOXl989cbBHuh51q+Apeie8UzzvWBJukmcm4DAoNTNRsNm?=
 =?us-ascii?Q?tH8qAGNweJbEMTGtfdQJesdbKsZuQI7XCRFzpvTaDerAaMUTotLIB+pEc2cw?=
 =?us-ascii?Q?tiMZPmLxi7qqQZGwl/mPL6amz3AQWFFi6ExIartTkgy1MQaSjdfPXOFdYirS?=
 =?us-ascii?Q?DwSpQ9oLXgtyH8+pOjJ3OPc4pPgLQfoRH/k4J4Aciqg2Gg5xvKJiYIosdJMz?=
 =?us-ascii?Q?pxl+peoLt+Os1qECP/h8oNY3EgJjZ4E95Ju3vZVars18cVl4W1jnbSf9ZucE?=
 =?us-ascii?Q?2LxGyYbzxMzXaeWysG54fa/G5KoNKZ7K8mExi1lsdVxU3XEDAE2qnE03Bgaw?=
 =?us-ascii?Q?H11BNZ9b5JukIKwWut4gaS1rvDtWLPkF5VjAN/b4Z6qA4GjuQ00OCzeAJrfr?=
 =?us-ascii?Q?+DZTuaqz51jF7ThoHwOAsaw5FBONnINwkIJaXZkohrhVK6RteSK13ph6dyAE?=
 =?us-ascii?Q?nROsLPJfI2OwsbqERE4rmmzNXLok37DzR3kSBt3YtLzQ442puz/QnU1Clz+2?=
 =?us-ascii?Q?GLgBv9oPtfhdpBpAjKq9+Jk0STt/PJ0tB/aghrlHAiIQCT94uVXk/2n1E5kX?=
 =?us-ascii?Q?llwQLWRdHYVyAbRKkFRV8qd2RYOu7ninz2DqUcimURfcjLILMg5Nm9MuX7V4?=
 =?us-ascii?Q?U91Zjn7z1xnuQo/91gT5YmWiGXVBMSom4QifJKxbC6yUiuYG/4GHYKyXG2yV?=
 =?us-ascii?Q?jJRBToyyQKx686KONhdRYu8YJAXv6q6wI63ibuhTP4+1DvC+idx8nu7onSc2?=
 =?us-ascii?Q?LCdSY0Ecmr9Qgd9mLqKtBGfxjk2HexaWgYN8hxfwPC8jqLAe51ddl7MCQqoP?=
 =?us-ascii?Q?kuR++q87eSUjhOS+tfiry5V5XwrkIPlTuIikMB7ukrOYvjk2qFq2xWeB81N7?=
 =?us-ascii?Q?IzANhLVzovuYEnaoMHdUTxOyc8Xe7VLUFm2xHS0LIevMU5QdN0ngPtnd04t5?=
 =?us-ascii?Q?r2D4Dv3SDUAu6lKK4yqHA/d/6+dNowiN5IsiAr/MVxod7SOQleWuSaC+UHGE?=
 =?us-ascii?Q?PP3/apmC2YRbzvubPisz+BfSlduLJub+bc7+hkrTvY7CNWLp6aXrNsGNAinL?=
 =?us-ascii?Q?b6Me2qcLGFzgAkvBr8uxZjTB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b496a69e-aa4f-4795-c477-08d966645494
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2966.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 18:32:15.7181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dd1wMwUTqT4GTUFgxquF/7d2B9yB/wH5uy5hh4dcM0BWHCRfQJDLyZmGxHfJ3vmBH1xGk57Hd1curMJu/crBALy40SzO4oYNRbXGWKO1T9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3030
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10085 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108230126
X-Proofpoint-ORIG-GUID: LiS70GS7DAfgWAi4-WXS9UBnoPoRr6pT
X-Proofpoint-GUID: LiS70GS7DAfgWAi4-WXS9UBnoPoRr6pT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 03:08:48PM +0800, Huaixin Chang wrote:
> Two new statistics are introduced to show the internal of burst feature
> and explain why burst helps or not.
> 
> nr_bursts:  number of periods bandwidth burst occurs
> burst_usec: cumulative wall-time that any cpus has
> 	    used above quota in respective periods
> 
> Co-developed-by: Shanpei Chen <shanpeic@linux.alibaba.com>
> Signed-off-by: Shanpei Chen <shanpeic@linux.alibaba.com>
> Co-developed-by: Tianchen Ding <dtcccc@linux.alibaba.com>
> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
> Signed-off-by: Huaixin Chang <changhuaixin@linux.alibaba.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/core.c  | 13 ++++++++++---
>  kernel/sched/fair.c  |  9 +++++++++
>  kernel/sched/sched.h |  3 +++
>  3 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 2d9ff40f4661..9a286c8a1354 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -10088,6 +10088,9 @@ static int cpu_cfs_stat_show(struct seq_file *sf, void *v)
>  		seq_printf(sf, "wait_sum %llu\n", ws);
>  	}
>  
> +	seq_printf(sf, "nr_bursts %d\n", cfs_b->nr_burst);
> +	seq_printf(sf, "burst_usec %llu\n", cfs_b->burst_time);

burst_time is nsec, not usec.

Just "burst_time" seems the way to go for consistency with
throttled_time in the same file, though "burst_usec" nicely has units
and would have the same name between cgroup1 and 2.
