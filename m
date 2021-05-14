Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCD0381218
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 22:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbhENUx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 16:53:28 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:39884 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbhENUxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 16:53:24 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14EKo1a3068686;
        Fri, 14 May 2021 20:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=zA7JyGzT63CNup9RxSPCumf7uy98XRXrhE5d9fyISmM=;
 b=wF/pvRgDsbjOO2jksZYy5cilmAW9V3GMkGcQO8/SMMVrJj79MhLY+OGYr2MO/39jUo9c
 WMSFoAi6A0ox3pyw+laCYo9qsgYzfFd7yPfmOFxK07gIg9u0+YUTJ5TQqpksA3ZMNQRy
 vNLnxJUSGeiJ9y5DuNym/Q4kKj0KUxlKplNs/y9CJsYWNWroQ68iaiACc/PLDljhRzFV
 tktWIU5MZaCZKWG8SILN1y9JoXYrIcUAe4zye6hjHLBlW14xfYai8yq+sm0CLm0ALD4X
 ZyvtSNDYnvEJIs2dVIFmXi6TqSUM8KScKg7x7JSlKozGKYSAcyY7HkFoi0t3ryFSxv2A wg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 38gpnenb03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 20:51:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14EKouRF149419;
        Fri, 14 May 2021 20:51:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by aserp3020.oracle.com with ESMTP id 38gppfasjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 20:51:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DnFtNW//W3E2um964lLXI9ZP6ONfnRQeI6tQX6nMq6vdPTx/bm7U/2FQAgVODGcs1yLMYX+RGl7NIwmjMz4hwboOmPwsT0OAwAxkwOqLLQxnRJ+YTVjXvq60Y08yNWR3UpaG6Lut+e88FtmYJOOl5sfo6Pm26D338SP6u9hopYKjj0LYEFL8pfN06gCT+S8iCj/nRfEJzU8h8po92hSv81gd+8ppGEwz7TZ9xl1xPCKUQ/oWpirSYhUs13KqUxThsioAf1usWP/gHGNa/exrF2I/7c3Fi4CnCQoaNWQgCYtcGAeTd2Jm5Epyhq8WrY4kEK8sNJB92MFUzJLw7Hj3lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zA7JyGzT63CNup9RxSPCumf7uy98XRXrhE5d9fyISmM=;
 b=QPqkQ66vsX81rC7QwVDbv0vFMK5i0sQnXGCFsPzShuyJnvoHq3c1AuAos657sr1b7+U23rhaLfRJNNNrGLQbI9LVRoJyRJL5tLZQCMmyqmKATwK9jR98YwZxUtRK/PoHXFeoxMohm6sTIykZFf2Rmu0luz2EoVzktRWxnIur98jvgWwl4XWc2dO9gPXwWlRFXjxwq9boUhwHc6crmRBGEjSq07WT3NrnInHZ9TZHPRLCw1v+tPzcFb0WgZnnWA75dRFFuRVHyUR3BxXbTPqhthDC+C4wmUdvhfRtPAIQ0LU6+7bvn4PPauYedjEb8FOiCoOHIbU01p6tnSFroYuFjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zA7JyGzT63CNup9RxSPCumf7uy98XRXrhE5d9fyISmM=;
 b=a3ys3MQLO0PxAvJqfEuNk8/RFgEHYawMt0WA/8+HuJUhxvXQXQlQiJg2e6+eYaY1G2ahMU4rhaK/6u/1pWp0BZ4Zq+0K94c26xurWeL0lswqG/qq4CQb/PO80E/d0wxWGW52RmOpcLPDNF0CNFdwb7qM08/oThRr2QRHG0b7hOI=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2966.namprd10.prod.outlook.com (2603:10b6:a03:8c::27)
 by SJ0PR10MB4624.namprd10.prod.outlook.com (2603:10b6:a03:2de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Fri, 14 May
 2021 20:51:53 +0000
Received: from BYAPR10MB2966.namprd10.prod.outlook.com
 ([fe80::144d:392c:6407:169]) by BYAPR10MB2966.namprd10.prod.outlook.com
 ([fe80::144d:392c:6407:169%5]) with mapi id 15.20.4129.028; Fri, 14 May 2021
 20:51:53 +0000
Date:   Fri, 14 May 2021 16:51:49 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Omar Sandoval <osandov@fb.com>,
        Paul McKenney <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH] mm, swap: Remove unnecessary smp_rmb() in
 swap_type_to_swap_info()
Message-ID: <20210514205149.hxwcuvlnydxafrcc@oracle.com>
References: <20210513064837.3949064-1-ying.huang@intel.com>
 <YJ0fkhuAZ7JnNmEw@hirez.programming.kicks-ass.net>
 <20210514015946.nivgnoobef4nqwmw@oracle.com>
 <YJ5nPolKPE6xgVsV@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJ5nPolKPE6xgVsV@hirez.programming.kicks-ass.net>
X-Originating-IP: [98.229.125.203]
X-ClientProxiedBy: MN2PR12CA0033.namprd12.prod.outlook.com
 (2603:10b6:208:a8::46) To BYAPR10MB2966.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from oracle.com (98.229.125.203) by MN2PR12CA0033.namprd12.prod.outlook.com (2603:10b6:208:a8::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Fri, 14 May 2021 20:51:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e766251b-79a1-4a40-8493-08d9171a1acb
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4624:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4624D641199540FBAC0CC55CD9509@SJ0PR10MB4624.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g9aFRlTMqx6fNfSKPlOniJyi0QchtABx8RVuXI9IS3bWsIJFFJKuSLDsd8TMdFWaJA7o96WMJ8ozbwyM8i3dhLO+iBGGV6M/ay9RrovLi4zjQE0fjoJiYmI0+NoP7aesph/9/+gHYAgzZsmRuPlZtCYMv00FWGmxIliIlon+okV3y4oCvoYZxUl13yRKWHgzGxZXBbsjzq6Ld1jJqDGhzfPfHROJGZCiU24xAsDVcfXy9bZoRllt/0mwjmEQHTLdPyU15D/CbEf78ls+lDAqUizgyKJnZ+lZhS+YbK/EIupmHwsM4u1aDkj13jc0E1OoM3dho30ThZOPwbyobdL7OyZrE2af0PSfyx8yWIbWltLwhUqgBaDIcbMnED69mzhhJxII17K2D/lbT8hPiNhEqb+gGighaoaDN7wknBhJA6ovGQJCAX1g07LFicx7nARZQyX/c7VoZDl3nu6by1MrTBgUgKGrCaqjKVQtgBp0I/HWep/64tB/7GeS3ERGz1f0n4LD1XhZlIw0o52lItvlOgYBHP4djIpHtnE0bLMjTqYCvBzazYWNnzgJpqrOC3W8/d/uLBp7oPCHM1QVFKtUY5zdgn4jS129BEohstJWl4mrB7knN2CIx1NDIjB7hyoA7YBBEamt8zWdxu7ez/P3Uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2966.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(136003)(346002)(376002)(396003)(8936002)(4326008)(3716004)(6666004)(2906002)(54906003)(66946007)(186003)(16526019)(38350700002)(38100700002)(66556008)(2616005)(956004)(26005)(86362001)(6916009)(36756003)(5660300002)(7696005)(7416002)(8676002)(55016002)(66476007)(316002)(8886007)(83380400001)(1076003)(478600001)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?8h21A39jTMHpXv54veILpOs6hSOWkRadDONmy8SjFq+uvDk6cBMoLWoNqW5o?=
 =?us-ascii?Q?tYbbZu1eBZUTm/T8rnJOT6A0wMRM7b0j/LCgyz6yzxsVYv0VcX5UtXRQK4AU?=
 =?us-ascii?Q?yNCpsprjKN+vgEwNE3SEOZTSay/y8nrOVMgLXBONcwz1mjvlLJUJee44AQXF?=
 =?us-ascii?Q?rlSNBM1JQsid+dm8FwM5cT4Vg5Hj9UEBFWvI3xFxDFpoFCha3u18Exwcd0Zk?=
 =?us-ascii?Q?h0nuOfGR2JUTO+SizR/zLipayGg/9uP1IdU32USqwGHSsXOywexJMmoyMNzC?=
 =?us-ascii?Q?0CLqDNWHmjRwLr9I4ae0U1RpsXMvao3kkhqqFJ6jfWgntvbp7PPjzwz3f/En?=
 =?us-ascii?Q?SX8QxV5W/V0y5Pd5qAphmlR0SbwKaDnm+f59HXcawtVvd1EIj+TrGDExeqHT?=
 =?us-ascii?Q?77uLlJhdIQA9UrHc8MJs4cLho6Mz/HYG9ilzwRWkFh4b6OywJqtZ4L2+x78X?=
 =?us-ascii?Q?hCa26ZlGNmlZJEgcDx3vKShQF0cFyUOYTrOVqbY6QP5O4qKi1cQ2UtOaHT9N?=
 =?us-ascii?Q?kV3yqsfTapFBx88m1yAxmkSvRlLNZGNCVGMSeW5ctTLbVFEgYFbZKnLWzskl?=
 =?us-ascii?Q?jXLQ7ZWXsVEa7I1SilvB/iWmWhKfFVH4CgR4eX8DQUpiA/pk6xSPbw8kCflp?=
 =?us-ascii?Q?b4QsfkH/coAeSD6jIIgQd/4+Lt6t5Nz5t4PW0SL/1O5ulOVu0ZeGpI784Otk?=
 =?us-ascii?Q?fHTTLJfwIrvSNWO2DTB7uEXl1FjQ3goPblOBFVL0w8OBgrC+nwH3C+6ytRRl?=
 =?us-ascii?Q?wzUYCLFvRt7JBubPYq9tXWHgLEr/oSDDYuiIKtAJ1cudHFbRKficN9dhpmpn?=
 =?us-ascii?Q?FMJba7J3+8azH0UD/b1cgz7PtqsF/Lp6fQcTzW9C4fogn82/idOm6TpPPkCa?=
 =?us-ascii?Q?ihaXawOVdX9Dzae1xKO3JoUBcWt6sSyHz9mMWcP0VnMNf9zrU1rGnLb4rxwn?=
 =?us-ascii?Q?zixTmabrIFOd2rYPlPoVuEpxqXxe4GOyuIqxjBtfq6/xpZdsOXbYFHanAjIn?=
 =?us-ascii?Q?/I9LBK7lUZ/AWO4VsupJ5RhW3tcfyPWi2zD4f3xWMk75FsmT3j8e71D0mW7H?=
 =?us-ascii?Q?nFNjDvfJ5IvduEz67z2tcTwLEDO4YFn/Xw7ffclmScw1XWabCWrgs5C9ijYg?=
 =?us-ascii?Q?ci8Wssqo0GUZAlQENHy7I9Ckp0VAzXMajreKbNXO+Bsh/sITyfOhm81oPmNj?=
 =?us-ascii?Q?Xm2rYaGSQa2vBXXggKGrODRczKhoeFrN4wyec09Lw+Qrad3ETl2YrMlyWsE0?=
 =?us-ascii?Q?NjQnGm3ACvex4BGOqkGOsMdPmIQAooqg8OOZ+vxJetMOju/tmuxroCsbRUEx?=
 =?us-ascii?Q?NbZonx4NPYbA6DRHPyDi60vM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e766251b-79a1-4a40-8493-08d9171a1acb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2966.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 20:51:53.7948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p2Ta8X5qP02JTkMbjgWqOjcRzYgwdMEb0I/HyD5aEoLthKR3CRi6Xx2ouZU/K7Y39MbUYK7HHVjxqOwDQMJXwk8pY3ELiV/jnyXE7x4uNRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4624
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9984 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105140166
X-Proofpoint-GUID: GPQ8YjO-JzofzhWGRlZysoDrN3SWir0H
X-Proofpoint-ORIG-GUID: GPQ8YjO-JzofzhWGRlZysoDrN3SWir0H
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9984 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105140166
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 02:04:14PM +0200, Peter Zijlstra wrote:
> On Thu, May 13, 2021 at 09:59:46PM -0400, Daniel Jordan wrote:
> > Yes, this does help, I didn't understand why smp_wmb stayed around in
> > the original post.
> > 
> > I think the only access smp_store_release() orders is p->type.  Wouldn't
> > it be kinda inconsistent to only initialize that one field before
> > publishing when many others would be done at the end of
> > alloc_swap_info() after the fact?  p->type doesn't seem special.  For
> > instance, get_swap_page_of_type() touches si->lock soon after it calls
> > swap_type_to_swap_info(), so there could be a small window where there's
> > a non-NULL si with an uninitialized lock.
> > 
> > It's not as if this is likely to be a problem in practice, it would just
> > make it harder to understand why smp_store_release is there.  Maybe all
> > we need is a WRITE_ONCE, or if it's really necessary for certain fields
> > to be set before publication then move them up and explain?
> 
> You also care about the zero fill from kvzalloc(). Without the
> smp_store_release() the zero-fill from the memset() might only be
> visible 'late'.

Aha, yes, didn't consider that!

> Unless that also isn't a problem?

No, you're right, we need that for p->flags at least.
