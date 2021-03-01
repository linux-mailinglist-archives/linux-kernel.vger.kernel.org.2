Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39FA3275AD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 01:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhCAAyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 19:54:40 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:11280 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231548AbhCAAya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 19:54:30 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1210nGWO017021;
        Sun, 28 Feb 2021 16:53:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=LfTrse+PZ5SSJROBKmEX2Vdx4c46ufhjp9OiBaFp01Q=;
 b=Gz/HSOC4QMGrShk6GhpQeQAArqK8ng1/hL9fxLm9Oi4teOhv++3bEklbYCxOShNdyjSX
 JATo2388u+sJArRaz6s9Wta5icj8/rcLKj636hTQ0iR2Zq+NHrVOn51+9F/eIXagKipI
 HxYYSuta5Oq/7BmrYbu0l9BGUC1N2nlcgkE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3706nn2fgt-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 28 Feb 2021 16:53:40 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 28 Feb 2021 16:53:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQ0qS+xHLha/tsGhdlJNsCBG0uw/V9dlmkmhZHy821EmADCmti6EcbdxlkB3uqwl7IyHq7+JCgT7vxTYevpTFIaTUSNaAnJCrsTOhJQqY8zvA8LKGf5schcesflX4XrN1F/M/wUkx2CoIdkZZCf01B4LG6Y8KZYIXv9y6Mj+g//ZAm6W1OQni/nTtvWE2Gkn7WSWZhqKO7bFungKF9NdEMvgCzrHjMikqZvgKg0b36G+Po5XyBPZtKMrj3RXk2ySqDKG9Kc4qAYzZ0bdMG32J1vmGy/YjthHz15ctYTBPYikE+McbBAwWdIgQ5sw41pL5Leip4anraa5fl5advbnVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfTrse+PZ5SSJROBKmEX2Vdx4c46ufhjp9OiBaFp01Q=;
 b=FsFDetQf0zCvASIxa79RqaVk7AHDz3tkEIfd3Wc1wG6wFVmGNsfXKGfBfptcgT2KXQBMJytPC2kEITjyTddJ75jbvTSmCKDTr91FL/LoOST9xX8B2RFtEBrdsrMXz5C6dA1ipZxMAyBtu43WxF2BCCxpAp1tS2oBsvTSRhv8TsashAmFPUz/AsR3X9KSGnv06BNMhqGiHP+CROpsEG4cevyMyL/J34bmhtkfDUUR5/OUStpuGNUOpXbwWCbFOP6mnPoM+C71MVu5lXUe0MqsiMcmSfqSlW8sMq0sQ/8fz6TekJvU4VaCZnDVgcJ98qD2gHKpIttJQaVHdGUHtW1UYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4219.namprd15.prod.outlook.com (2603:10b6:a03:2ca::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Mon, 1 Mar
 2021 00:53:37 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 00:53:37 +0000
Date:   Sun, 28 Feb 2021 16:53:32 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Hugh Dickins <hughd@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] mm: /proc//sys/vm/stat_refresh stop checking
 monotonic numa stats
Message-ID: <YDw7DN/Q6cBEyyuc@carbon.dhcp.thefacebook.com>
References: <alpine.LSU.2.11.2102251502240.13363@eggly.anvils>
 <alpine.LSU.2.11.2102251514110.13363@eggly.anvils>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2102251514110.13363@eggly.anvils>
X-Originating-IP: [2620:10d:c090:400::5:68]
X-ClientProxiedBy: MWHPR04CA0067.namprd04.prod.outlook.com
 (2603:10b6:300:6c::29) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:68) by MWHPR04CA0067.namprd04.prod.outlook.com (2603:10b6:300:6c::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Mon, 1 Mar 2021 00:53:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bfa5934-06aa-4d37-eba3-08d8dc4c72a4
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4219:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4219150A86F532303384081DBE9A9@SJ0PR15MB4219.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:597;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gnmV9PzOS/4NSym7FCpV9j3ksEbSNTbPXzzRrvfuuaPGBNtsKQxvGTHX/jU+GVobEq3cbgOVX+mFy3Sh6A5CmUD2F5uq0PrJriRPzvpw0+vFJ5fHsKi7ec4ls0vA0EQtRvmpPl9c+bu1nnVNzydwT6d5p+dxJqe2xG85cQ7ULtK0C1iELT/6I1ORdx9wXdtjoufwuvoSeedQjZZzEV8aFLFz7Tw4Amnl3f67EX5iNMDBozPv4E+6IWrouNZhTlM7SHuCCw8G1klmdrh5PfbFHA07sftm3iT0wfLs+a3QZ5E0tJZrxF92AzIc3jGYlNGXJteIxqCvIckDVOspgiHymQQB+r/1On8CfCaF4RfJz/2tOZgNexyqKLyLSpqSxMRRcp/RLfC2BUMieOpc8BIoj0i/IQJ1eQjnVs7gMwSWU60IU7GOXQxg2Yb1xyuV1/W3BNQSjX71slViVppZt640WdY3N9v5nLWfu3Usud0S/rk+CrpJVe6vwoC7uP2wfkpuzBJYMF0TDCnxPju2jdH2JQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39860400002)(396003)(366004)(136003)(55016002)(6666004)(9686003)(54906003)(83380400001)(316002)(2906002)(66556008)(7696005)(5660300002)(4326008)(478600001)(86362001)(66946007)(66476007)(186003)(16526019)(8676002)(52116002)(8936002)(6506007)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?UK/6/z0/o4pgyQFAH8MrVYwR9p90SoSVNdkeDvipJq1fLwKgCfYgN/w1SFyB?=
 =?us-ascii?Q?12x9etmus4bEbyflz+mhhCwj7PPMoExgSh519Wlhs2utIQiMHmOWZwst59aj?=
 =?us-ascii?Q?hTh5gVki/ac5pJSAuPt2JDLsAGhvdwNSQh+oRp0vU7A/A1YA1NcSpL8Lm2ou?=
 =?us-ascii?Q?IOm2vPrSTyQV2wgvbDOFRTiyukG1IZ9Uz1cC+4fmPnsgjk328n8R7RhN/6EY?=
 =?us-ascii?Q?HE0shvUNYk6i9QmYFfJv2paeyWRZh7cU634vq9Zor0ql39qT8yMLIlKvqMuX?=
 =?us-ascii?Q?d3bJb8h8SrbkC4iySZTL45jUnntTk4+d3cduHlINasEE+WtcrxcbAMi10aYG?=
 =?us-ascii?Q?MTmB817paieWOMOJsrEA5+2PlRWvagEu0hNuiC1bMB3VDuWmdxbOBWWF8e/t?=
 =?us-ascii?Q?I9LQmVInypzuxA1KwPM/aDIDWTWFxgVAp7FT/nV08tbvyvEOtzg5+L+seOn3?=
 =?us-ascii?Q?n23q2w0zdS1U+v+35YXubZ9n5oetNnh8TQyvyVZdZA/4RCIT8tUqnARV/Wlo?=
 =?us-ascii?Q?9zBiyvVQMD1DHPKJkW9oTeiW8POP5gXMbv99IXoSSX/iNS5tPUlLDSL0tR7H?=
 =?us-ascii?Q?rrFs7jNEI+VvHEUPJdwXXdmXInke3TZRHoMZQC6UUCOCUVScaiIkDcJTsYdY?=
 =?us-ascii?Q?Cer0uqLC3BPM8UcVGXmJvaCCzFxkrjMEgxmchZ8EOE9rFfjZiU5Dyw3MbdJO?=
 =?us-ascii?Q?zZ11cFCSx/Czmg0IoePMBOSBkzGGa3MDmRdduBMlNgKdJbC5YWGecMZIGXRk?=
 =?us-ascii?Q?HH/r3fnuH3SXkHGLihHloh161HE8bnZLZikwxhxdehBag5JVB93b02EVLtqi?=
 =?us-ascii?Q?st+yHVLcJFvR5hnM7thJMwb3VTVyoCUVruNvcPx5R0UiKcKvynTFMBC1r8QR?=
 =?us-ascii?Q?vH+tIUrVFLA42N8Fxx5sy5Ci6d57yxBB2PL4l7JmlSF7kX4qwys4tjehb0u7?=
 =?us-ascii?Q?gHeyxc2rv8Z9pJ4owNmzAShlkV3HcZ+sJjkq6r+3vd0jZ6EnZVRyh7edZV27?=
 =?us-ascii?Q?Nt8Pebmv76ULpm5GvtYSFkletJLLELWLNkhP1EptL22INgg/fKUTUHq15qkT?=
 =?us-ascii?Q?lnqUTpQHNpB3IfgJI+2t0NcGe8pGij3F0k6eb5Ldu6DddxExdg+bsKQ8xwZ5?=
 =?us-ascii?Q?qvF60OMtQtGXD7tTboVpT3Ws+7eWo7Y/890FGZaA3S/yRx3yx+kQCBVebukM?=
 =?us-ascii?Q?Gu/jSbRcf0hirTldRyly/tcdlNJCDoVUXmxuFwmoomACq3aUnONeKDLvSsV6?=
 =?us-ascii?Q?xGch++d3OwC1w3uzm5CVGQMtJw+TL01tjJv2qWiPj7LaqwkJfCDbBFfD3dc3?=
 =?us-ascii?Q?rc2JKd5Yg8c/BOPZoZC77H3u8aAgjraHJynjCEUKXieISg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bfa5934-06aa-4d37-eba3-08d8dc4c72a4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 00:53:37.3490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HnJ5MMjV0yBfd6cbPGBHTEA/yCEJE8tOav7qdCbCAZhcxJ7obDmzc6YKyPe83y+4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4219
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-28_12:2021-02-26,2021-02-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 suspectscore=0 mlxlogscore=997 malwarescore=0 priorityscore=1501
 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103010002
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 03:15:42PM -0800, Hugh Dickins wrote:
> All of the VM NUMA stats are event counts, incremented never decremented:
> it is not very useful for vmstat_refresh() to check them throughout their
> first aeon, then warn on them throughout their next.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!

> ---
> 
>  mm/vmstat.c |    9 ---------
>  1 file changed, 9 deletions(-)
> 
> --- vmstat3/mm/vmstat.c	2021-02-25 12:42:15.000000000 -0800
> +++ vmstat4/mm/vmstat.c	2021-02-25 12:44:20.000000000 -0800
> @@ -1854,15 +1854,6 @@ int vmstat_refresh(struct ctl_table *tab
>  				__func__, zone_stat_name(i), val);
>  		}
>  	}
> -#ifdef CONFIG_NUMA
> -	for (i = 0; i < NR_VM_NUMA_STAT_ITEMS; i++) {
> -		val = atomic_long_read(&vm_numa_stat[i]);
> -		if (val < 0) {
> -			pr_warn("%s: %s %ld\n",
> -				__func__, numa_stat_name(i), val);
> -		}
> -	}
> -#endif
>  	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
>  		/*
>  		 * Skip checking stats known to go negative occasionally.
