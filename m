Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA803C6084
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 18:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbhGLQaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 12:30:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:24940 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234227AbhGLQaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 12:30:12 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16CGGxdO030010;
        Mon, 12 Jul 2021 16:27:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=Mr/085WOzmgvS8bkX548a89nvUgwwti9WSr86IIqLyk=;
 b=IX6VPHzBc+g3+jlJFy9AtdLTvguLxz75UqwiaTVkwMYIXyvT5cYO6onKuErQziUY4wTb
 QxLSYbkTtWoVTUGKDehY0bH8D8GDAaX4H5Bf6keIFIIoYnYUPW0OmMVQPthLfaXWRESk
 /kpr3HJhYedUIUkooTdf4XMy+kzqtQekxKifwkgG+AojEfhHby80HOHH2J+8K/24AMgR
 TbOjpvanwjXBrZr7Dhb5p/cXP4dJelIlhmSjv+0z4PNsiRDuObm9cE/nc/ARQiwkIlCG
 ZB8XexTL8XFX0zmMMRkA5WFRlbzyb6aXDLkt0NSugtroklqI8HOA1vmNY6JD+2DK3+7x lQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39rqkb09k9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jul 2021 16:27:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16CGGpXj123412;
        Mon, 12 Jul 2021 16:27:02 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by userp3020.oracle.com with ESMTP id 39qnauj1gb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jul 2021 16:27:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDQaX/bZwonSUAWIpdH5AJxf1J29qQlYVFxRiWVgKSJyHwYD0ql7XcVA1Wef2svCIvlC5f2r259asdORkA/vbKsa900OVDaUxVEsnpAkYHKASSC1qOkVAS/y9exkja9jqfDMoSbW9YnSZswS9+3vVtNQwJQmybFMuWh6CKNJxfKGFhMwzh1L5kMMVLHYfUGjvUgEs/N3X4I/eH7C7NrIJo5jWc9mO30vjDLMg8CPrtkjUYzIyf7pNDr9BgaVzVIsFcDRaIkInvnRI09F2aTzWNDNrlsKmsn37OofqIQL4vqi9NJHQkL2i6bVNkfZ0jMIZ8XxVc88Onm3zWO6r/ArxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mr/085WOzmgvS8bkX548a89nvUgwwti9WSr86IIqLyk=;
 b=JWdlDntKzXdS/5VKv1rBPaECmfntmYZRFAtuQWOhQ4t1xmbiY9QN8JQ5SwU6X5YHiRQOOGY9MmAWgCow6wuHAJqnPjIIfB8NdFDfd9BTTDBMbF486ybkXXIrzMrmccvJhx9fNyk68zv0AI0AXdxkiQRVrWEj/oI81lvsTfC883Mk7OpDuG4MizAWDiklBo2Wc43QWw9iRyD83/YcHpvvGUPIn2FJE4iL1+S3bNQlCTrPZ5UhSdTfwYVv5YiE3TP+b7l9P5nAeq4mCM2aWPeKSUDA7Uw3nTKlXzpM32gK/eUSvMYM9bruf6Rlsk7+WmjjDKMMKT8mqjIDauJq8NBWvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mr/085WOzmgvS8bkX548a89nvUgwwti9WSr86IIqLyk=;
 b=Z/GiwGMr1icJUdZgznV/wQEfhekq/SWCG9sHf48iM9DRIYWRbKIQepxHhSTZNL0lnJxcCGvLDWNSVfqrUwVwP/vAYJxQMUvwu1ngAHkaRErWRJ2QZYr5oROJi94UBhLVavpnwnZSI35cH/zeZvkrQSQJrK5Gtx77kMirxiO8Ibc=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2966.namprd10.prod.outlook.com (2603:10b6:a03:8c::27)
 by BYAPR10MB3047.namprd10.prod.outlook.com (2603:10b6:a03:83::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.26; Mon, 12 Jul
 2021 16:26:59 +0000
Received: from BYAPR10MB2966.namprd10.prod.outlook.com
 ([fe80::9478:368e:93b4:6b48]) by BYAPR10MB2966.namprd10.prod.outlook.com
 ([fe80::9478:368e:93b4:6b48%4]) with mapi id 15.20.4308.027; Mon, 12 Jul 2021
 16:26:59 +0000
Date:   Mon, 12 Jul 2021 12:26:55 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Zhang Qiao <zhangqiao22@huawei.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, pjt@google.com,
        linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH -next] sched: Dec __cfs_bandwith_used in
 destroy_cfs_bandwidth()
Message-ID: <20210712162655.w3j6uczwbfkzazvt@oracle.com>
References: <20210706083820.41358-1-zhangqiao22@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706083820.41358-1-zhangqiao22@huawei.com>
X-ClientProxiedBy: BLAP220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::9) To BYAPR10MB2966.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from oracle.com (98.229.125.203) by BLAP220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Mon, 12 Jul 2021 16:26:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 341b4d7c-4438-42b2-3696-08d94551df6e
X-MS-TrafficTypeDiagnostic: BYAPR10MB3047:
X-Microsoft-Antispam-PRVS: <BYAPR10MB304782B11A18EC2A0852ACB6D9159@BYAPR10MB3047.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6etTlsPq5vuqeWfBOBBD87K3GdnZqizU14LZV27OoWv83fSXq5hlBcNUfH87pB9h/t0OmvU0hkmTXLueX5nddIDfAjKJT+H1hrJJZ6QBbjKszTJpviEzOtx2vUTR+Qom2dnyvczw3emiuL6nrzbZRrddwSzVV1nr+GFUQq6jVgpekCWxKo19MiThiSO587tRd6tdQsqsGFWzyNRIymplz0eiEudMwVOFX2Wi4e+m5FslLRbiaexoKJv1B8/u2+HbPznZduwlMOhSboh3OK99N4jlREYRkIurAbBbM//IyupY4xihZ0w1mR11LqG1PduS1xcq6n1Sfj3Y22EwBs0/0RD/5eSrHqqHyHP5IRH4OfrilEcA1eyT9WV/ARYHT0xEllEXioCcBi5791Fpjt+kiyNoFxDywSE0DYnfY5uxzWTuGZ4+AQkhOgR29zf4z9pv6m7TER6tHXEgUCBMjR2RYdOo2+eEKPTapfuisDGrohR5jmOZpQZJ7KaDbnrKDBRIgfbbSE0A5AgGOdzDGeQvL4MFuqBnTPlsAOdm7ZS3AquCQjGAnzp6BIJCqAD/Hrjk/lMEK0IUeCTG7gekvNs6Eh9FRfZhb86++yak8AdOzs0XpfEBfFqPsnJOG3Y1VjVL6Wo65ci0MMAagxYKceHq/62ANZV+aDfBERj34OWdz0HMms6TiIp1VNYCQatzuLKH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2966.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39860400002)(366004)(346002)(136003)(1076003)(55016002)(186003)(38100700002)(4326008)(38350700002)(52116002)(478600001)(2906002)(5660300002)(7696005)(956004)(8886007)(6666004)(36756003)(26005)(2616005)(8936002)(66946007)(66556008)(54906003)(6916009)(86362001)(83380400001)(316002)(66476007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ceYdCcHSIIK9WH3hEL21uTei4gJ73FUFyxFW+WN10alTKf4rtPdSpMZEJZgi?=
 =?us-ascii?Q?I6YN2jV3UQUgls+OsFyZZEsfSmjHrHSOHgYHk3qr9g0nOXWE/2sCWuKimu+m?=
 =?us-ascii?Q?lCGHewMuebD0GFjUx447Sh+wWt+PoB9id3PTu+1vGp2CoLH4gBoUuGNNhnrg?=
 =?us-ascii?Q?Q+rI9U3KBx2EcUfyyJWSdgOOQC3OAgmXyZ5T94vgbibJ7mc3W9W2139jD2Wb?=
 =?us-ascii?Q?pRXPsyAwM1W+Va4mFvLDdq91jr44Vk4tETdb9RhKbYKifA9Knjezw6cx1D5l?=
 =?us-ascii?Q?906yt2Ulr+D8y3ccWGXf2bDOuCMBiwtSTMXZ5Cq9f2HtUkl1sJUObKVcge7n?=
 =?us-ascii?Q?Suj9pqIwQGXjbyuZxhiHDi3Iu7aw+1EBxGwGAZC7V35KnHIZgXeAsdiqTpib?=
 =?us-ascii?Q?UFqOtYZfhtn3DZBazrTNheL+LeKdmGUL28cDffYVFJ3iFw/+Eksuywev65xF?=
 =?us-ascii?Q?VrAzIM6gF8LC+IJmk1uFoDzRPcdieEj6o8VqKFdqMHvfKuMkObYNygyBfTt8?=
 =?us-ascii?Q?uL6Hogz8Ju8K5vvcVTMfyuKeJf8/PGlulqiLJMbqXlQHKLtopMitqsGLsvc7?=
 =?us-ascii?Q?DcVomRrQnRoiSNejerz1FTiwj2GanqtUzvOxkaQbtU5XzAnyzrWxxM2i9X7p?=
 =?us-ascii?Q?GHug89ODC0wbksleEtQ2W4oGEvmvVdrt3KrAQWM52CKnDVgJ0dwLk7t0yBNB?=
 =?us-ascii?Q?+tiscP1o3Yfcu/QXUfCZQH4BMB1D33eJQv0ALUuLk+3LyeF575euwJ8zWKdl?=
 =?us-ascii?Q?wxRicHQBxvhsYTMImmA6oVoXAOQSKTq4+VUJqINx9NmRDqqns0F9nzBtrrKH?=
 =?us-ascii?Q?gn2sLpoN3eY26bO+EU0xBIwAtTZP22KeXlp9Hj3YtPaul1Oe/3MkslX4KMG0?=
 =?us-ascii?Q?I3m2ZkrsPyDqBZLxqCEKVDOqTq1RZy9J4LHqrMG+mISl/T7jc+wIm35FsJJO?=
 =?us-ascii?Q?gFyrvO+c/pJdgXTVEmFzHCqaz5AvnLuQRI4gsBtLgMvWAGBGLHvi/9WSpi3r?=
 =?us-ascii?Q?AyS2Xi9EkqKjqV0sTtgz5yOl567mV2dJFI1ASz6uLA5QP5DqSa2/tR9uFjo4?=
 =?us-ascii?Q?seGXJ6wHNrqLkKVkPOh19KpJVP3Adg8EdvnERFO0raYM3J6PWaJdZeOSAuXY?=
 =?us-ascii?Q?k6nD5fXGzY0Ei89nkVfmTr9Qqd3+G93TxU1RLBwHzbGijMXA69IS7tiQlhjE?=
 =?us-ascii?Q?e7FQvPvLtnoPck8zLakyxQJopViS5pKt0pXHNYa6CXsW6gQ0QE2q8+5TbyPC?=
 =?us-ascii?Q?R/ibfRhWzAelpnAv6z77HZNajWmkaQj0wPK1f6o041c4A8NVLNy21bF871KY?=
 =?us-ascii?Q?oiJp+ewQB7j8iBgNLrpXFdgG?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 341b4d7c-4438-42b2-3696-08d94551df6e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2966.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2021 16:26:59.5695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aIhUBM6CV/gHlApolm4VzOhnkXAX1G97F8yrVq2G7etMaAvt0dJQnZohOemEuqx6o5l2OkC9dh37pGjzDnQDCgUbsCu2U6uIFObAT/OAWzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3047
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10043 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107120124
X-Proofpoint-ORIG-GUID: -DcKE62OzNj6V3AS4C1YDP6PG8cAZYFf
X-Proofpoint-GUID: -DcKE62OzNj6V3AS4C1YDP6PG8cAZYFf
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[cc more, leaving full context]

On Tue, Jul 06, 2021 at 04:38:20PM +0800, Zhang Qiao wrote:
> __cfs_bandwith_uesd is a static_key to control cfs bandwidth
> feature. When adding a cfs_bandwidth group, we need increase
> the key, and decrease it when removing. But currently when we
> remove a cfs_bandwidth group, we don't decrease the key and
> this switch will always be on even if there is no cfs bandwidth
> group in the system.

Yep, that's broken.

> Therefore, when removing a cfs bandwidth group, we decrease
> __cfs_bandwith_used by calling cfs_bandwidth_usage_dec().
> 
> Fixes: 56f570e512ee ("sched: use jump labels to reduce overhead when bandwidth control is inactive")
> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
> ---
>  kernel/sched/fair.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 103e31e53e2b..857e8908b7f7 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5344,6 +5344,9 @@ static void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
>  	if (!cfs_b->throttled_cfs_rq.next)
>  		return;
>  
> +	if (cfs_b->quota != RUNTIME_INF)
> +		cfs_bandwidth_usage_dec();

This calls static_key_slow_dec_cpuslocked, but destroy_cfs_bandwidth
isn't holding the hotplug lock.

The other caller of cfs_bandwidth_usage_dec needs to hold it for another
reason, so what about having both cfs_bandwidth_usage_dec() and
cfs_bandwidth_usage_dec_cpuslocked()?  In that case, the _inc one could
be renamed similarly so this isn't a stumbling block later on.

> +
>  	hrtimer_cancel(&cfs_b->period_timer);
>  	hrtimer_cancel(&cfs_b->slack_timer);
>  }
> -- 
> 2.18.0.huawei.25
> 
