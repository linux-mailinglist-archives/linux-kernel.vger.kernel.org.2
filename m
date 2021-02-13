Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35BF231A979
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 02:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbhBMBXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 20:23:55 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:29678 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229648AbhBMBXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 20:23:53 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11D1KZka017030;
        Fri, 12 Feb 2021 17:23:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 content-transfer-encoding : mime-version; s=facebook;
 bh=JjlmblpcusExnLX2QHEBrdMqXh/GMXLlxxWghTI0vmg=;
 b=qyE7fVYZwHJMZXog/4AvtetR4Iyv1TKoNQ3x816nFF86frchFehLR4bUNYa5vOymI/Mf
 dbzfTqOccmGAYxfBP0sLwSCB60mdn6gTjxrHEP30PUfv3KCrCZJzk9cipgX4mDMDyx3j
 PGvNSBBlEgBV3p0+3hfrOlTrM7wrPsf4Szc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36nu0u3emd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 12 Feb 2021 17:23:02 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 12 Feb 2021 17:23:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6fyImz8Zl3YkYbche7E1bw73M9hcwHPHWF8uL6JAkm2NPaeiDJlzNBFWVlTjI0lYAU1CGqhOCz4Go2M4BGIngdNn2fu0Rv4ll9I/uLyWQ3KQcPzZaRNaGfW/p0Hl7UbeJzMCpQXmvFYFpVHykCaovM2pGY7VHjP4QZi3Oo+0ER4JbCvk+mvi25U4KcYM7ESeIzvly2BrZeja8e/3UJqyDFWyy5UuxaX9+WKtu3kZb0rswHVXh2WUEm5fzTYdnH5IshauWVyq6WUG+nUSGTd5w7NqiaBOd4X/ssy2owktMPuYeNi0QJf244o96UvUIRKoveH0GZDZ2VFlClHEOSrKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xL7VsYvJ6B6z7Nl5Sd0RspTiVfbUeqK3FXW2dMEnlQA=;
 b=jC9T5wnkv8bdhbZcrsopgDXC4QtM1j93eeiwQEATHSreF4k3jomhGakXLQCHAG3mJptwy+cAJs2IqTSUZGBHbH/vgpVDTlH/xWoD1melkVTS5ssN1oN6eKAPCeJOHSDs4kY5SfVTkIRpSYWQtwaVoz+6kPlu3CztytvKc9W57+EnLRuS6B8Oj28nfbKcsSBINTjbJdw2SZD1I8Er8j8DINoGnEIkzGSXjKIeLDZW+/ZeltVuXxwAA3vpantqiKFyX8t4MMnxA/7oIjUFmN78hke8TjyKdcD3L+FIWgozVrdMfzwukST9qjSIxy6Gfl43wcD+L96AxUWiLJyv44QM2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3158.namprd15.prod.outlook.com (2603:10b6:a03:104::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.34; Sat, 13 Feb
 2021 01:23:00 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3825.034; Sat, 13 Feb 2021
 01:22:59 +0000
Date:   Fri, 12 Feb 2021 17:22:54 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>,
        <lkp@intel.com>
Subject: Re: [LKP] Re: [mm] 10befea91b: hackbench.throughput -62.4% regression
Message-ID: <YCcp7pwzlQy15v5H@carbon.dhcp.thefacebook.com>
References: <20210114025151.GA22932@xsang-OptiPlex-9020>
 <20210114031839.GA415540@carbon.dhcp.thefacebook.com>
 <59b6fda7-509a-0afb-112d-46c1e73c589b@intel.com>
 <20210203024951.GA1837780@carbon.DHCP.thefacebook.com>
 <8ce56447-b416-4750-eeb3-0d5bb92e007d@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <8ce56447-b416-4750-eeb3-0d5bb92e007d@linux.intel.com>
X-Originating-IP: [2620:10d:c090:400::5:217a]
X-ClientProxiedBy: MW4PR04CA0180.namprd04.prod.outlook.com
 (2603:10b6:303:85::35) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:217a) by MW4PR04CA0180.namprd04.prod.outlook.com (2603:10b6:303:85::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Sat, 13 Feb 2021 01:22:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8beb0ca7-b72f-4461-25bc-08d8cfbde64f
X-MS-TrafficTypeDiagnostic: BYAPR15MB3158:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3158CB92D12CCC630F911814BE8A9@BYAPR15MB3158.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: acRQmp7Txu+Vw/9eRBPlTV0S3t89DCOGcdkyuX+xt4QZbM7ky/oFP7pmhX65RGb3k9RRj5tFYjs77hOwISRjcLg5uIbUdVg81MDHSPYfgSIQqfIh+2C6n5fJOiIdj1gibdG2TskKPdCWxybjHIgX+yPmuEKC1Os/Gv9Le89uz2mJDdOGagzgBl0nbVyNokGwbto159A2XE7GUT8y+DHzR1mWui6wKXh2Ki2mK9f5QiD3qJTVKvvAbeyZr9Hfn6vR/WGaftDUxG8gt8ikS41Akdug9EvthQW9R0ofcZR3dH460mh7gSGutss0Emnh32DoQVuu8dSBwioW2g64gSBWq2OJYMlsAVKjOi6glFC3sIc973xFv625Pm7Hp/RBfEzWdblpG50npHr7ulUngCAmL4fQa0n+d2Tx5WsM1wZnJSLmMwryOZqoy1SBBaYCkl/YQ/Xxnf7rfqLl1ak+Sv4dpz/Dkc3Qp5rYulEPZyIcl/l0mGtoV8oJ/dB7BzDPAqbxLymcStGoyCtxrNhfEV5b4i8RLjlRMbpnDORP/qVxsv5g9i0/eroSXHv1KT2Lf1NCI4yO8GsC7+9U5oawmVd8RVjwaehYF00aHMSKLhXM0sM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(366004)(136003)(396003)(8676002)(186003)(2906002)(966005)(6666004)(16526019)(7696005)(8936002)(6916009)(9686003)(53546011)(6506007)(52116002)(83380400001)(55016002)(66946007)(7416002)(4326008)(66476007)(66556008)(478600001)(86362001)(5660300002)(316002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-1?Q?0OrgX/oOUlPyUaZtatScLijH476MnXsDqmZOQgBwf2pRD7mBuEEP5tI8BP?=
 =?iso-8859-1?Q?sMBdQsX8GzrqAwHWz4b+dJQududk6K1mjvzIV9YX2ipOJKWe0VWFwVbnXT?=
 =?iso-8859-1?Q?aJST1w9a+1syiAxW+4G0Cgl5mhVYHD5/CxgnjaLUkNHSRTCf+QtXn3aflD?=
 =?iso-8859-1?Q?Ko/6o0DY5CQH+Ouou+V8SMpcjP+BeFlrSnZKZ/V7TjSBfZKFCBeXgffCSS?=
 =?iso-8859-1?Q?W7R37NKdY942NEZMlJaAqs4SBeANtO5Fvm1s7fGvXRUmZfTIx8JWzdRJrC?=
 =?iso-8859-1?Q?bERuA3x+Ji/uaNeOL/bq3MOMIA3iGB06r87v0X/zNDp7kbpkHy0wQ4W2zY?=
 =?iso-8859-1?Q?SLYckEHFvnJPpgpBQUEpK807UAezDR3xaM7j8bl9ZQRenWVdIjK2LoNnYg?=
 =?iso-8859-1?Q?zOfruEfdwKytGEz8fLn49/PIVDn0ErcKuHtKwfxnthrzSwnpyvbnqI2TTn?=
 =?iso-8859-1?Q?g/MFybr5OC0BZs4BNTu+JfSxXQEu7Ko3mx2lbs7bLTrcmtuM0RaBJHdqsf?=
 =?iso-8859-1?Q?o9Fc/fVhdh0n0teab8qJSlp2u/ccqCpH8hWm1LqPfhkE43wwNUZ6s+yCcW?=
 =?iso-8859-1?Q?rTQwOps7mw3h9lmOO1EZflYAYrzSsA6XwrgMXPe65N/AlSQ2SkILEFZDR3?=
 =?iso-8859-1?Q?keJ3X3ulJqbW9DeH9rHBha0krczj8m1LvJ6/ga90Pf4evi6ciR9bqTo9mB?=
 =?iso-8859-1?Q?LMmW3UVVvr6Xho0/IaSJLPYT192jE0LRthzrx20JSPgwJ4FtuMXMt9+XaX?=
 =?iso-8859-1?Q?Wzgtt+OfUFY5EKr8+6bhVyzutDNawxuLDjCSEG3b+2E+BlGI74LzuAe2Ij?=
 =?iso-8859-1?Q?Rgq53Y1gTE1xCA3BNvJbkp+uriQ92trxImaI0iIFHWnD7LDOqTtYc1Ye1e?=
 =?iso-8859-1?Q?icvT2e11szJEJJkxNyhbiMqh/UpPN1F62gNhl6LbN6K8JvrPFbcAE8nzF8?=
 =?iso-8859-1?Q?ShIqssuYtp8Y2iwX0+rCOeR/YEszL1eoObh76bvHxi6JuIDkrzMT82IVkl?=
 =?iso-8859-1?Q?mPBsoKfwM41MQbKYdch+AxLbMqQ8jGsk9fgX1oVSj6ZggC88p4rGB6kkzN?=
 =?iso-8859-1?Q?0MxvJLR+9cx6c1OKVTTGD3k1ej3AHDzNI3SjmloZYiUb7Gn9hCHpkrIKAN?=
 =?iso-8859-1?Q?R2buXoNVbLWIiAzuttBrY51aOJIq4ndFwU7CNL5aDhcOoNgdsTPISdQFMZ?=
 =?iso-8859-1?Q?Fpz7A0akq8+CUzs2D+I1edAtKXhfFPaacuymfYzHb0d5M4+qCUMa0Tk36i?=
 =?iso-8859-1?Q?KKw6emFE8U7f7XFb2HjRLQGdw4ynYh0K64TEqICjnK6RV2hyMaQeQVrt4c?=
 =?iso-8859-1?Q?R1rR69sPcm7EUcgoN0Zwz41fgXOKoQUQYIbN9ZAjg9QiSz2rdh4LFaFczL?=
 =?iso-8859-1?Q?9RdXfCD/xtevk5HrcNNH3ktVLErSD/jQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8beb0ca7-b72f-4461-25bc-08d8cfbde64f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2021 01:22:59.8157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o60qi8uvYglHFovSsdkpZJECqq11Yf4hNLCYBf45jGv0DSkif81Pivie11H7cjPY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3158
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-12_10:2021-02-12,2021-02-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 impostorscore=0 mlxlogscore=915 adultscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102130010
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 01:19:47PM +0800, Xing Zhengjun wrote:
> 
> 
> On 2/3/2021 10:49 AM, Roman Gushchin wrote:
> > On Tue, Feb 02, 2021 at 04:18:27PM +0800, Xing, Zhengjun wrote:
> > > On 1/14/2021 11:18 AM, Roman Gushchin wrote:
> > > > On Thu, Jan 14, 2021 at 10:51:51AM +0800, kernel test robot wrote:
> > > > > Greeting,
> > > > > 
> > > > > FYI, we noticed a -62.4% regression of hackbench.throughput due to commit:
> > > > Hi!
> > > > 
> > > > Commit "mm: memcg/slab: optimize objcg stock draining" (currently only in the mm tree,
> > > > so no stable hash) should improve the hackbench regression.
> > > The commit has been merged into Linux mainline :
> > >   3de7d4f25a7438f09fef4e71ef111f1805cd8e7c ("mm: memcg/slab: optimize objcg
> > > stock draining")
> > > I test the regression still existed.
> > Hm, so in your setup it's about the same with and without this commit?
> > 
> > It's strange because I've received a letter stating a 45.2% improvement recently:
> > https://lkml.org/lkml/2021/1/27/83
> 
> They are different test cases, 45.2% improvement test case run in "thread" mode, -62.4% regression test case run in "process" mode.
> From 286e04b8ed7a0427 to 3de7d4f25a7438f09fef4e71ef1 there are two regressions for process mode :
> 1) 286e04b8ed7a0427 to 10befea91b61c4e2c2d1df06a2e  (-62.4% regression)
> 2) 10befea91b61c4e2c2d1df06a2e to d3921cb8be29ce5668c64e23ffd (-22.3% regression)
> 
> 3de7d4f25a7438f09fef4e71ef111f1805cd8e7c only fix the regression 2) , so the value of "hackbench.throughput" for 3de7d4f25a7438f09fef4e71ef1(71824) and 10befea91b61c4e2c2d1df06a2e (72220) is very closed.
> 
> Regression 1) still existed.

Hi!

I've looked into the regression, made a bisection and tried a couple of obvious ideas.

The majority of regression comes from the kfree() path and the most expensive operation
is a reading of an objcg from an objcg vector on the release path. It seems that it
happens from another cpu, or just long after the allocation, so it's almost always
an expensive cache miss.

I've initially thought that zeroing is expensive and tried an option with not zeroing
the pointer until the next allocation which uses the same place (this approach brings
a penalty for non-accounted allocations). But it didn't help much.

Good news: some percentage of the regression can be mitigated by lowering the accounting
accuracy. For example:
--
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ed5cc78a8dbf..cca04571dadb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3261,7 +3261,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
        }
        stock->nr_bytes += nr_bytes;
 
-       if (stock->nr_bytes > PAGE_SIZE)
+       if (stock->nr_bytes > 32 * PAGE_SIZE)
                drain_obj_stock(stock);
 
        local_irq_restore(flags);

--

We also can try to play with putting the memcg pointer at the end of the object (we discussed
such an option earlier), however it doesn't guarantee that it will be any hotter. In some cases
we can try to put the vector into the tail struct pages (Shakeel brought this idea earlier),
but it's far from trivial.

As I said previously, because we've switched to a more precise per-object accounting, some
regression can be unavoidable. But real applications should not be affected that hard,
because the cost of an allocation is still low. And there is always an option to disable
the kernel memory accounting.

I'll think more about what we can do here. Any ideas are welcome!

Thanks!


