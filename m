Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03473FDED0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 17:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343745AbhIAPjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 11:39:55 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:30810 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244612AbhIAPjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 11:39:53 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 181DBxgN016113;
        Wed, 1 Sep 2021 15:38:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=ERCuZ7LtZsbIJAKQ+bxPm8/ttUyT6b3u9G+9K4+MQc0=;
 b=iPH4c4Ysi4eiLkPCZ84KthnES4P9pmaZI9OVY9nCzSDB8ifz2WArTl4vhM1gMWidw11I
 nIlGNCEemi3UMpfroxgTw7+BpYA5suCJJZjIVesaXqW0hK+6W2iHzBY6vkZs/kLmxzGX
 4exTqOr0h06loPq02zttm3MgWWyEsVW3Giw3A1Rqe5NwAE70mANZP8FUvbISY/XzHoap
 1DPhmg6yA5cxx4eO7pvcYofstA4uFTAtGLu+UODCB0fHw7nkNUKb7iAb/9l1IhB20AoI
 jpqVAj8gn7BYyhPUqvxNaYuhXFoy88pGrgS0aRFKwCg0sLZeBzhvcgLDDrjkPUvttu/J Kw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=ERCuZ7LtZsbIJAKQ+bxPm8/ttUyT6b3u9G+9K4+MQc0=;
 b=BIPyEYrZb7m6GcCBAjYM4T549vgulrf+04NmyZzXGjxC30XKzL8m8oLFImGZBe5KiIX+
 z5bY82NJ90z1mpH//+nBgiAhG7hmG+f1GVeTmQQYZrpFR/yPPx4RwKIfpeowET9UvqZS
 zWitDX8msujosOOBtA18vpC41nTcHNrG8Q6ZDPwpxxzrAPDdDgJtQF/Ot7gcZi2q7VZh
 btUNMtX7XRFR4ZdpLmIzSCJ5H472+YQjCESBiX17tYgEZ13rVAwjYaQ3YnJojknoS5Ml
 2OeQq3ZyNMko+qwXqIjo7fCp8I79CIfBb4kulkXJ2ug8vLTWegoZ/jzgbJM1ZNE7m7cR Sg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3asdn1w9rn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 15:38:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 181FZgGP017697;
        Wed, 1 Sep 2021 15:38:04 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by aserp3020.oracle.com with ESMTP id 3aqcy6tm7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 15:38:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCWVP3ZHxyRF6KiaWSWSjm6u6HEC15UGZ92t5w2QJPhs2/0CQ8HIlnTkIbtb5M9Sbk4thSNX9EH0Jp4uqDcrtY74gQ0oY6autSMSFmwcuV4sGFxFQnGBY3dyZA6Z8DFtcmp+A1daMQu9PnY7LaMyza04vgeoLQrnUvznYw0gfiMcx6basIefXdi1vZXD6rx0CoaRiyT+JZxK6UXhN2gfetm5bv4/4Hv3vbHvlnQXU5c5X04uJP6BNQrEgnwncuO6r2jXM3sXo8QvtJjWLC3zxWrAVVI6sn8hT2/kqYMo1vE51TLppH3DTkr+3yTcnUxLjk2HO29P5xg7EMQPrnUQ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERCuZ7LtZsbIJAKQ+bxPm8/ttUyT6b3u9G+9K4+MQc0=;
 b=Ad9w1/MBrcV7hMWAQhMRcF4vGXOwTCRZimp2igWYKH7lHFeTcDQ0SmGEmKO8NpW0WgFtMgyrgtM8JTuSjbH43KBizPOc+cOo7is1boODrYXQ7JeYvLPpO1AqAVOniYYY9aGungZUSo1VRfBg11VnRvFkeOcLAcMqZrep+vE0p/BcO8cAG3lUFxvlC4M84TWrMkHdnQ02iIaRYKaEMrDR6vW2b2ksVErCBRjp5cact/ax3M8dgA6QONqLvXe0EN+jTQ9pec0o8ShnBRQIffQurTzFkuUcCyY0S3QKWFj3fSctW4utljat0C+3Bx6vir3+BsouE1otArDcwwD7eDwvJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERCuZ7LtZsbIJAKQ+bxPm8/ttUyT6b3u9G+9K4+MQc0=;
 b=cWNidC2jFKJ7k+EhPu9/qR9YJC0pVqLENwHTMfYf+CS2d3jYDOMVKxr8+O+SFXTfpcZmVz2iCrQKWKR0fIV9SxFlBUZ39ms5+dF7VZrZFQZPweXf+Zfh8O8PBDl3Z9Hju1fhTgEB3zeE8ODgj89k+k56AyPRcfrebgf8Oar5Bh8=
Authentication-Results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none
 header.from=oracle.com;
Received: from BYAPR10MB2966.namprd10.prod.outlook.com (2603:10b6:a03:8c::27)
 by BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Wed, 1 Sep
 2021 15:38:01 +0000
Received: from BYAPR10MB2966.namprd10.prod.outlook.com
 ([fe80::a01b:c218:566a:d810]) by BYAPR10MB2966.namprd10.prod.outlook.com
 ([fe80::a01b:c218:566a:d810%7]) with mapi id 15.20.4478.020; Wed, 1 Sep 2021
 15:38:01 +0000
Date:   Wed, 1 Sep 2021 11:37:55 -0400
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
Subject: Re: [PATCH 0/2 v2] Add statistics and document for cfs_b burst
Message-ID: <20210901153755.lpuajp7ndosfwgeo@oracle.com>
References: <20210830032215.16302-1-changhuaixin@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830032215.16302-1-changhuaixin@linux.alibaba.com>
X-ClientProxiedBy: MN2PR05CA0053.namprd05.prod.outlook.com
 (2603:10b6:208:236::22) To BYAPR10MB2966.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::27)
MIME-Version: 1.0
Received: from oracle.com (98.229.125.203) by MN2PR05CA0053.namprd05.prod.outlook.com (2603:10b6:208:236::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.6 via Frontend Transport; Wed, 1 Sep 2021 15:37:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b03bea3-9146-4063-4a8a-08d96d5e7b1c
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4290AECCF4BB365B7FEC457FD9CD9@BY5PR10MB4290.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: catlHTSHQmQ/aAYipVS15urwiflCKV0geMZTeYo3J34oq8oO0dS+O4l2hXSgouuCqeI0w7t+8UJrexBo1Is35KK49SoA03y41OdxFk+VYinDX0OYotXoDU7WdEXuM+BFRCtCCC35HyFXnI+jV8VqdqMdUctF/dvpl7Hj1uzYkgyM1dYL0F9xrP6v4Yujs3hb1OljqcGdzxhfIG8msTlfLgbCKvmdDP+At80Dktn2BENFAeEj7rrlD2BsfnOdXll9i4JyQ58vWBqtnnV7WUYqTAWl8U2KNtcGutGB3fA2TWj/uGAMlqIar7TvRfCPRmbIVAv7tVv93fv4mX8GPQ9hUbQP1kFtRfTKEWz9P/zVHuaoF1sKxX8et9Ab0OOSNqkO77/XJWK7G8xBYkVAd73rSZTWaTwdendwlxV+6gS/RchNbR7Z6bp3BruFDHTsS8a2zf37glJuFbWY05Wacc82KL75bh82EAeWc0Zzk9UTeaBA11PrmpxPtjDGmBVnxSwT6hoqyTamNVq/K8ZXJ4ZIbpZp6e/+W5Zjw/JksH4OnwjuPdH1xEYWgmqRtaktToqVk4HFBtr1sHrTi+FVEqjrC+zcYkRSTljg7mkOrnB8wCtX/A1zYnLSw9poyfba0IK8UvKzVXPgCAx7d0iaSd8iD7Xb9eQZF5aSan4Xi/wyyGA3ShDNO5dl2YB6wTCMicxFs4ODlkPv4VO4/VQFOUi/LmwTgaeHz3gshBmZUAe+fdH9r/s8AcKq4DkB31V03RD+VpLo9y56J/2unOvEB+3y7O3a6rumjmGuWbzUbrXhEDk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2966.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(136003)(366004)(396003)(376002)(4326008)(7696005)(478600001)(52116002)(2906002)(966005)(86362001)(26005)(38100700002)(316002)(38350700002)(186003)(55016002)(36756003)(8676002)(1076003)(8886007)(4744005)(6916009)(66556008)(8936002)(66946007)(66476007)(2616005)(5660300002)(6666004)(7416002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xVtTUnK+bZuPpeVbXbXPvpPK3beH/VS2qbcKKyIZfvuMDo9SnvTioNlpkHEy?=
 =?us-ascii?Q?jOfHOfQSbx0uT+9e/QYFgOLXNQ9cT8WTC7944jeF1wvaJXND6CyhX/ZGvmh+?=
 =?us-ascii?Q?3OeITjw+dx6dYYMKn5V2rfm9WTF6Ov9lSr24URc+ASkp4skhM7hBk3UdKBI2?=
 =?us-ascii?Q?0EhMEku8qR0nJ+Wp7xGQk0Kpr8MXxesyEM5h6UtOWWlLHQhpUqshNGb1BrZC?=
 =?us-ascii?Q?6tbDRxquMOlxDUO0k65eUq7nULq/IlFLNdqLBTRACtGmqg/8K+0ryzCyLT6T?=
 =?us-ascii?Q?AVbrYAg4mAgEKgZknTa33aNhXEXtYN0rGy0MTIVUgwMlF3E7PKz2CGkxjf3U?=
 =?us-ascii?Q?xfbH6jaNQ1gNVcTUEgwcSU/78zlLebdksxY6RseKYLT/X5+pHDavt/EZp+CR?=
 =?us-ascii?Q?wsHlpNJanuw4OXQxp20d70ewLGeY8MmReJuie+GZuT7BO0biA0Myr8hGjESH?=
 =?us-ascii?Q?Mc3+y2cMTQf2CO6T81jlvAK17MJo9D5LWKz6t3JrQ1BP4Ya7yuT+Vn7+SFxe?=
 =?us-ascii?Q?maosK6yWxTTTuf3EA58JVplNW6Wbmm+bs+4Hv2m8dMwCsbE/0c7cWdGn8Egy?=
 =?us-ascii?Q?TYwtlWRRNFWHkEni7ZGNgT6ktXLwfjzYPFFLrN7SHRRQbbnMd1KeGj4zcNNe?=
 =?us-ascii?Q?BtGun0g0pZmC35WSiUpx9/AsF4hlXrVbbBRSkbxBSKGANCI3G0ggjnqxQ5g8?=
 =?us-ascii?Q?a9FGR4qOfpZfnGRe/g3XNAkwv6eGiL8g+3wr+F9kjfzXyWMsMoMxM5n9hJPQ?=
 =?us-ascii?Q?vsfgJDbxAoLpQpPytWosYI3kj+zovRqkRInTF5V1jvs7/tJzdJ7G/iL9o9HF?=
 =?us-ascii?Q?IAwqLvqKjzWPxoYERv53DV+bef7Zm3/Alb1D+Q11BuW4lJB9/y32f9zTfl++?=
 =?us-ascii?Q?xsXZKPGzxgZh1nah1hpEp40brsjjNgSE3aPS788lNjj3jDrqzQ6eiBXM+Y+N?=
 =?us-ascii?Q?JoynM9PEezDouDpHQ4YVyMmvyD6b5JSHYeLDQvzBFG2GE6I8epfe2kmnJAei?=
 =?us-ascii?Q?ucZGRV7tr0+QNI9yw/EuXxQykoZ305PrlyFpHQKWaTrVH8TCDyLRgZe5pSOR?=
 =?us-ascii?Q?iNFH6i+v4eD2bgaGcDP6fxc8kc86twppOd4kHqo990Wjkln5ixZqDh152yTm?=
 =?us-ascii?Q?CSyBAA1E76FDUsatd/d5MUyqwkNf2D7dDDl7vw2Wp3kcN6ETY1L1MOtXDVtl?=
 =?us-ascii?Q?23c33jhw9uqlWV6L+NGr6oEZ/5ju0trlFmMX9PclOXOxwBPrtN3iprfadyE8?=
 =?us-ascii?Q?mS7kX06U6JE8wJpNd7S7W1icB/gBeMk9Zqr6Nl5rP1n0WpCkuoHQZ/duAmML?=
 =?us-ascii?Q?5478qxxA4/Nqg/+yRbeoBEAp?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b03bea3-9146-4063-4a8a-08d96d5e7b1c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2966.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 15:38:01.4977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: drVq8luxfXF3B7R88n9/sdoxIMpq3SkKjifPt5jCrxx6NeodWZupXPg27i1rt0EySDxxG/J5L8BX7ljyCM/Qy3rB7R2cwNV4ENf3lNgZdpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4290
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10094 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2109010090
X-Proofpoint-ORIG-GUID: gIcWW4K17GT_xMggnpDWMTli2_SWiDxX
X-Proofpoint-GUID: gIcWW4K17GT_xMggnpDWMTli2_SWiDxX
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 11:22:13AM +0800, Huaixin Chang wrote:
> Changelog:
> v2:
> - Use burst_time in nanoseconds for cgroup1 interface, and burst_usec
>   in microseconds for cgroup2 interface.
> - Minor document adjustment.
> 
> v1 Link:
> https://lore.kernel.org/lkml/20210816070849.3153-1-changhuaixin@linux.alibaba.com/
> 
> Huaixin Chang (2):
>   sched/fair: Add cfs bandwidth burst statistics
>   sched/fair: Add document for burstable CFS bandwidth

Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
