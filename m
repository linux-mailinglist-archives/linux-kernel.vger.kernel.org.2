Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467B935E5B3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 19:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbhDMRzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 13:55:08 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55658 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232705AbhDMRzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 13:55:03 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13DHrYw9014305;
        Tue, 13 Apr 2021 10:54:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=eoIERI6ANf56eu8MncoU9mQWl6pv7Q35zRTbRJaE8mQ=;
 b=Jfq/0kgFdHHDiccTpbRcUwBZSB+ipYlHAr9jb4hNjTIbftREedM/JFxt8wOX3/KgfxpU
 y6psaOQ6rP8Me98x98gWCltNwEIw47z2yrbI9jbmLge5/aUVThvT6jbz3WXDAUHLngO5
 FMnTx/H+Y2xfpExTRZ2em9GadHjn6kiNdoE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37wabfa9n6-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 13 Apr 2021 10:54:35 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 13 Apr 2021 10:54:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAVCtjw8Hx7KZUqGq3DEtSIqDzVBHsc24nbJuNhaYseGU5D5qTv1rCzdIlVo84F+wM91kyLiK6OdReC2ckYqP6ft/myL3ss9FAKRSIN96GEhJ8XMoVRk9CJiKsPJeNMBR7sHDD6/zszghLrjmMvdjq8X4k/pMem/bzHjce8tYK+nzdAfqQdIITQOwsxx/cnQqERSYEykPRWzSNZhaOEBq0tZgFFFqv914uMuismzn53t72mSQxyPlM4AXMCtW+ha+sOVq+YCrnu2ha+7jMrt5rG0YnVCNb6/mhoVGI7e9ebfSednwnhT5+qRJ1s+K8b+C+KdosbhnB1tMQvzHdWlTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoIERI6ANf56eu8MncoU9mQWl6pv7Q35zRTbRJaE8mQ=;
 b=aYdzbX413Ikd9wcUSwQEdcVpt8QcT4vgtxzqoGlImoXoVnCI46YMs76bCJGDGy3+ynq+pURqgZ9sr6a2gvNc1Ghc3y4cqlirSPEqQLj9uqK1nu5zwansXwPCCVDpCrCIYhKBZ1N+9jrBG8Ak025m2C/QFrO59HDCRyVIB0bxFJJhKR5fWGq3nRDq21AJhZZArAEsnBVAGPe/oYSBYVuAs4aiHb5hjg20xHEucBhX6magb+Mq+qcK3kEoyNFkQyRq4go0lgQl6vKz2xSfVVEFOZy+OAk718lfbU9vwYd5UZ/a+tVYx34VNpQMoz5ErJYS0N7KAICDtKiswv/Cc6pRKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2438.namprd15.prod.outlook.com (2603:10b6:a02:89::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Tue, 13 Apr
 2021 17:54:32 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 17:54:31 +0000
Date:   Tue, 13 Apr 2021 10:54:27 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, <shakeelb@google.com>,
        <vdavydov.dev@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <duanxiongchun@bytedance.com>,
        <fam.zheng@bytedance.com>
Subject: Re: [PATCH 6/7] mm: memcontrol: move obj_cgroup_uncharge_pages() out
 of css_set_lock
Message-ID: <YHXa06rdCPih9YAv@carbon.dhcp.thefacebook.com>
References: <20210413065153.63431-1-songmuchun@bytedance.com>
 <20210413065153.63431-7-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210413065153.63431-7-songmuchun@bytedance.com>
X-Originating-IP: [2620:10d:c090:400::5:ec38]
X-ClientProxiedBy: CO2PR18CA0050.namprd18.prod.outlook.com
 (2603:10b6:104:2::18) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:ec38) by CO2PR18CA0050.namprd18.prod.outlook.com (2603:10b6:104:2::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Tue, 13 Apr 2021 17:54:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a602cd87-4484-40e0-8e9d-08d8fea530e8
X-MS-TrafficTypeDiagnostic: BYAPR15MB2438:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2438A961773BBEC8C7832C2DBE4F9@BYAPR15MB2438.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gg2Oy/uoTUKNg4n0Nh71FfYV0UaMn5UECYdIGiz1T5rdhDtPe07GegO/pn7k/6waxz904HYgYTEi20/vFV4B8BaN8JQpw/7X8mkOuUMmcdduEnwUMtbAWM+yVyoF2Gqb5qNyu8cWUx/k6rjCsg6eB383L+QBqLG0CM1AJlhR96xqIEJDZKXl/bYgYTsyddPgPvbiEQyEa2vopZQMdW2obXg+99xUyZT+Rj2UNHV9IZkb0hvFkGUhxZSZ0kV/AZHNsM2VfCXRZ7cSgNwJLyzrTLiBM2B0gMcry6z8D+F6H6WnCLFDk36WVNTuPGNJD4jAcBzAxvEwklqLmfKEJRkkLwBnpE0X/5TaTxIvODwg9qXg19ZDIWVRKCSwQxoxiWx+xbaRcIe2E+lcqrjGOy89kEt8yDlzb08y6PWaS1Abs+2rr4DgfOwmilRO8r2iotjMi2HHocJJkb3bqTDgAZjxrK5XVp4vD61gfOsPCgOb7xWWE+YrwMmEoX76ZVmvmuQ1zV8zbq6z9DW+HFBpFZule6KfHyCozqkRR9IYJK5lAY8D4LFdEd83RsFAuMI7CtnYREiqQL85pCBzzwxSUq1Aq2nRRzXBiZvcOG5rJz9sgG4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(39850400004)(136003)(346002)(396003)(6666004)(16526019)(7696005)(4326008)(66946007)(66476007)(83380400001)(86362001)(478600001)(6506007)(66556008)(8936002)(7416002)(8676002)(38100700002)(55016002)(9686003)(6916009)(186003)(316002)(2906002)(5660300002)(52116002)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?cgQ88mqDY5f18m1ndVFk98Iza0HxiQeI42o5xXZU0HCCOoI9YLBN/yJKB220?=
 =?us-ascii?Q?Fkmvco1QUFFQq/9LmisNgPYBZRzLWlTO/rd03hD9jx2YZmi8/ifQ6q9ibmLE?=
 =?us-ascii?Q?XrdJfyTqV/4v9VsDfjUPH5w3wEDCj0titvEC0wmdLcvQ5cGgUB4YXcBVS411?=
 =?us-ascii?Q?VqvKXvu0ZZw9uBnTRT6BWdo18uS+pK11+9aszK+UK/MgQgaKWfdAzn5W5n+b?=
 =?us-ascii?Q?EDVJCySIOvjRVpIrV+EPDIlSGkyvwJgJ0TAiAr36+2osz2kvURAbo38ARCVX?=
 =?us-ascii?Q?+4WU9wvYX+JnxzY17GvO7iK3TgE3VspUcpukCY4kyoEv6U+eGePSL3XwpDOM?=
 =?us-ascii?Q?f4LvbcSvbT65BSAE+s9I5wbBzppWIlaCi2b8ELjDbdxF6T0XbltBvEJSBAe3?=
 =?us-ascii?Q?vSQkLg9aODUoGiUpDA2C8dZV6OnT8gMn51+pP3b/BwvyBLcNTak1MXBbZTl8?=
 =?us-ascii?Q?W5D7fodg5SwLvO9DlfjJbiB+8sSDyAa9Fh7/i8s7LAy7IeF30AmlAyew2qlw?=
 =?us-ascii?Q?ABS4cnUsB4yMOK9gkENkMD7KwYXGVw1tGS3JuCq7Cuq+oDKTMCqLveZ/RRSr?=
 =?us-ascii?Q?AG/kJ/wbWgFmNWOsxfVTczcOTkSLZIUFq+jrQwsH8E92jKs2tzxh0TWr7ty4?=
 =?us-ascii?Q?5zvcFlykZc9enjReh1N5k6IMBSZWDWT1Xk6tS+vYQgWGnCC0j003/KWFsron?=
 =?us-ascii?Q?Q+rRVob6YtbsdwC73Kbkp/fJ1Z+gQhBGeRWACNzELVaBDbMNr47r+CtLbN6V?=
 =?us-ascii?Q?nXDPWZIJq+L5xHu9TxD5zETTBP3DcPJ4qdyMozwExG9sOM8tm5N34E6jNQfg?=
 =?us-ascii?Q?k4UlUNeDp3qfFKtmHDLJDeQrT4QtrQsMEdjflGAm2FVxqocX86WMw4xsQzSN?=
 =?us-ascii?Q?IqcFfucHlBt2Dha1XeOGxFJ1aR4cQ8EwOMnb3laAC+tkNWZIJv7i82ZvbYru?=
 =?us-ascii?Q?3BOmc8ioOoF0Q298O3KJ2WlPf7DluGQlgB5+YA9PbNV73TauAPoo920k+j3q?=
 =?us-ascii?Q?qT7f3eA1Qj3IwnN5qgXz/rFvxj6YWooasi0j71bnUTZLl6nTx3lajJ875YZQ?=
 =?us-ascii?Q?8mwFmbc8mM6sqYxQ5SoREDQH/jaVCOf3SRIpii2Pgk4vSJgG/gf1hwMIZM0D?=
 =?us-ascii?Q?TElYCkBCKeVPCWCoo7tWPreuBzkqIshV9bWs3HBtANT5ETqr7J066dg0unhV?=
 =?us-ascii?Q?ve69PXqB/+PsznxVAinEFuUk7H3KKIQtu3H0lyQGIZwGtWkAgAZYqPqXrsJE?=
 =?us-ascii?Q?nnD1KuO7oT7mzWE5q/ASX1/X6+BKQFlhY+EWsT3FTZxPLTIcYnFAcRTgBVy/?=
 =?us-ascii?Q?ZUv4B5w7L6+rRBK9bXZRLrj7YiDsW4rVWwa1Qyz2MEPjLSRhttXo1CnMXLn7?=
 =?us-ascii?Q?k21An6s=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a602cd87-4484-40e0-8e9d-08d8fea530e8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 17:54:31.8130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0x5wYeGDduji/MjkxItw6aHMmvWeA8k/UEmOcbhK2yROKsMhXQDW8ZHi1x1ZLa3a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2438
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 2csSGDw2I-o4xWgSmIYwIdsckRqRq54B
X-Proofpoint-GUID: 2csSGDw2I-o4xWgSmIYwIdsckRqRq54B
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-13_12:2021-04-13,2021-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 priorityscore=1501 adultscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=957 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104130121
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 02:51:52PM +0800, Muchun Song wrote:
> The css_set_lock is used to guard the list of inherited objcgs. So there
> is no need to uncharge kernel memory under css_set_lock. Just move it
> out of the lock.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Roman Gushchin <guro@fb.com>

> ---
>  mm/memcontrol.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 42d8c0f4ab1d..d9c7e44abcd0 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -289,9 +289,10 @@ static void obj_cgroup_release(struct percpu_ref *ref)
>  	WARN_ON_ONCE(nr_bytes & (PAGE_SIZE - 1));
>  	nr_pages = nr_bytes >> PAGE_SHIFT;
>  
> -	spin_lock_irqsave(&css_set_lock, flags);
>  	if (nr_pages)
>  		obj_cgroup_uncharge_pages(objcg, nr_pages);
> +
> +	spin_lock_irqsave(&css_set_lock, flags);
>  	list_del(&objcg->list);
>  	spin_unlock_irqrestore(&css_set_lock, flags);
>  
> -- 
> 2.11.0
> 
