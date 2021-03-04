Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C2032CA74
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 03:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhCDC02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 21:26:28 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:21044 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231341AbhCDC0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 21:26:13 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 1242IrXF031099;
        Wed, 3 Mar 2021 18:25:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Us/vtfWOh8wcB/1tamCeklGgl4jBGfSmAXyDKl54w9M=;
 b=G/4Z5qiWikYNqT7S33Jij5xQEnrmMo60uqqhjOmiNKuHF1JBjqj+DVnmbru0UEEk/nWP
 eE61rBlGxGYwuJ1s47F93V6WWqatEkXHdDH2JC56uBiZQkwzi1b4Kf6ZIijBuUkDcJjL
 z4alq/DCgqriuG/vDUeIbMDN3bsvLRpVD7g= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 371trmh1we-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 03 Mar 2021 18:25:25 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 3 Mar 2021 18:25:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyG8vy8Q6PrrQl63oVQtUyNMfPCcPM+kLJpwhvjsgCX1RPXVtOI1Xn0aNw+JwKK/pIQX7n/HIM9G4sWVWsRaHAuL138tUSR2+IWL5YrEgA9E893ISSZZe3oiznQsA/ybjI4YvTDBwI5eIaDx2qqVSTFeZRRs1ztLBs0ccKR5Cd8Oz/ycNkF7s1JJoa1NmxkStFNJal4Hc7SoEyPtyXhi1S9GHqgGK1LaxdeEb+SO3SZvpN1bJ2Bd9n+XTrInDvZ1e+RFri4MS6LRQKFbpWv9ZnHoeJFZrX2Tx8kn0Em0XD16Cg/OoQNUL7DZOe95dQMr1Da9cP72X12u4r9IU1ySEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Us/vtfWOh8wcB/1tamCeklGgl4jBGfSmAXyDKl54w9M=;
 b=BrsFZeL4XEfveL1iUEP7QPJtiTw3IZHJ+Iwhf7jgrnAaJzy6bVKSYKdlGeJHf1cAF9wnCpFqSAhiYIpDAOXK1RHkI6Fm6u/ZgQp9nGEOG57QUWTszJyA4Oicfh/WY5ctX2qmPIodk2AgnECat1Jm0dAEKSIOW3iqD8ZR36XAOHpdlzhBwXu6R1WRL4YGyD5d7435WySezNEHz3Ol01YHRiIuEQx3Y9avgXavQeC9L/HtfwJNwPl+sUAhnt1pbuazQhJQJFL8TGcnfsSD8ftXx7eAwNEPiPjNTDIuhFG1D2/glGEOz0hZJLnDNsEepUcaoYrufc6eVWA7nePIy3OXkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB4133.namprd15.prod.outlook.com (2603:10b6:a03:9b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 4 Mar
 2021 02:25:22 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3912.017; Thu, 4 Mar 2021
 02:25:22 +0000
Date:   Wed, 3 Mar 2021 18:25:18 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Hugh Dickins <hughd@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] mm: /proc/sys/vm/stat_refresh skip checking known
 negative stats
Message-ID: <YEBFDtz9F5U3G1Su@carbon.dhcp.thefacebook.com>
References: <alpine.LSU.2.11.2102251502240.13363@eggly.anvils>
 <alpine.LSU.2.11.2102251512170.13363@eggly.anvils>
 <YDw67lSx5vLTgx/O@carbon.dhcp.thefacebook.com>
 <alpine.LSU.2.11.2103011301010.4832@eggly.anvils>
 <YD2IGxfOE5AgYuzc@carbon.dhcp.thefacebook.com>
 <alpine.LSU.2.11.2103012158540.7549@eggly.anvils>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2103012158540.7549@eggly.anvils>
X-Originating-IP: [2620:10d:c090:400::5:816b]
X-ClientProxiedBy: MWHPR12CA0027.namprd12.prod.outlook.com
 (2603:10b6:301:2::13) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:816b) by MWHPR12CA0027.namprd12.prod.outlook.com (2603:10b6:301:2::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28 via Frontend Transport; Thu, 4 Mar 2021 02:25:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2300109-0a8c-4fbe-236f-08d8deb4c2fd
X-MS-TrafficTypeDiagnostic: BYAPR15MB4133:
X-Microsoft-Antispam-PRVS: <BYAPR15MB41331A8F58369E47D593885EBE979@BYAPR15MB4133.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e+/Z+SiOFu39sySKORErl3x431HygYvkzU1AF8stF1EA2p5YdbAvSlPn1RGFCZl2Reyh9j1QpcMXWm9Y/CONHuctPwDuJ085SG8UmBC2noCb5OJbUiiz3EtoYhPLSLaxmUSHaBpTWTg3CR1ouSdZGcR3JwDZu/Ru1cSRKiIwVynQFU6rtjbHXl+rxjkyRVuhg8AaBIsiDaMeQWFr5dQu4/DFKa15F9CYT4BvEiB0bD+7fDxAktMaHqUKDawdN7OIV3pAl6/GMjpIW2UBl6rW+DLjsPPjDxCcXnJYfzjEMnB/rEK4OjuguNkMMncPREwKvQgnhAoP4Hi0y1gaq3DBEKCNe4Az+eAoseJkFjPWLD3m4BpHfx5TWRwBFLOlByu4wJ+nQEdOCbCEDgIQx+B9PnjYm24B8lPOYPDFL+8oHwiz1tLs2a4plrMOaJ2PJNaUdysf4CIDXttlXdociUfhlg/67S9MH+KQ+QRki6M01AEUt+a059pZNRQ/ZVwWYD9FYVcrOa8zcGfO9Ct0HV6BMQMFyFYirkqc8lRQZnoTxrltvGm0DFqQi2JNjaF+nmFYZFx6hkLSwZ9xHu5Zd+74ncxyd6VmePUDkO4edQvQ/ZY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(39860400002)(396003)(346002)(66946007)(6666004)(8676002)(186003)(5660300002)(86362001)(54906003)(2906002)(966005)(66476007)(66556008)(6916009)(4326008)(478600001)(16526019)(52116002)(6506007)(8936002)(316002)(83380400001)(9686003)(7696005)(55016002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?MFP3NdMQrlTQrM7+u0p0hY9V9RBPhp5RVdNBoV6WdcXa9XO9F66xmv2xrhfE?=
 =?us-ascii?Q?tA51AYEiBi0t3xXmqlgcnVVvUBQdiIQXl+BxZmYcyYBCTPkbjIbakRmOgPgr?=
 =?us-ascii?Q?goe15kAnY9XikHiSTtDhNP8U12I0r7oNcbIAQ5fRcxdzOPhd3L4fEXEVRUiY?=
 =?us-ascii?Q?6lxfJ4kZ6sCXURudNh60u8sbBPb1FlsLLIJ4gCYb4n3LyaVdymYRHuWDE4ew?=
 =?us-ascii?Q?8G5MyCTHU92x9hPrAIinl+P8kWNPR7kSuYCjGANP2KeriOn/9uJXVszizTJB?=
 =?us-ascii?Q?s8lYoMBfIwvPZ2gz0pUhzWSS6bmZJzvo6dEq7SEr7iMmn3HO6HWpOdCSANnW?=
 =?us-ascii?Q?NSZxx9fWdeg7P8gQWuqm1mw0waJb9dWN6NeVxSmMNdVb6GTdUpluc1Q2gUiv?=
 =?us-ascii?Q?uZVCCNwutFSq2TkWWHphomjV7XbwzDIQp7FTEF5aopiVE1YG7+8vzC7BXJWz?=
 =?us-ascii?Q?1TO+3AgIy8eXzQR21SD35K1w/AgXfQd5X5LJm9W/1WcithSr41nIKNN4cWHy?=
 =?us-ascii?Q?JT1bOhOmMdgTV0OlRw7Vng7kjiF+stDecJuKzlcem2srPGvO4Ij6GV/OXkmR?=
 =?us-ascii?Q?+KDwF0g/KIMOjlbD6TWvhiOYAYObNJ9ZhoSt0R71QJoVXE3kD5PpwN5sWbUM?=
 =?us-ascii?Q?dKIAGZocshcMwgFardPS8bCh6Vb1kCEEt5bXH0GuNOQ2gKnC5GoCU1t9C5b/?=
 =?us-ascii?Q?M4DaFJy8z5ZHPcCQQJUpmKLfhIrmVRFU8ye4B4OJJvLfMpdbbI72/kJ4GqE+?=
 =?us-ascii?Q?5wdGCn0DJ5uCcZ0n/8yG8bJ9kqs7WMRTNEFaQ125RZyDEzCM2Fb37riCiB2i?=
 =?us-ascii?Q?tFt2PHn6xlHh01WCdw5H2LiaUDDHj/ZiWxJDQbh88ax+r5u6qZtKMlluELiH?=
 =?us-ascii?Q?Yae7ruqBDnL1eLzH9DxszwYUi92DOYbqVdGtHQ3hCQB/kENrUI9qpj1JKpvK?=
 =?us-ascii?Q?mAwKiPkSj62o8sEdIvChGauOPfgZ09VkQoNGG9bBqHIGs3CQpBBZM7WfJQrI?=
 =?us-ascii?Q?xWChXnwccEcT5ewroBtKtiF+HMvLiKGPkS4LI5FSb4CORYz6enKTvz7ovylQ?=
 =?us-ascii?Q?iWSwJRsOa+1EOuKGr0FMG3GgohXye7FCCDOff848e7rG2XpPdAxrV/1Myy2V?=
 =?us-ascii?Q?kR5eG5i5CdsBTAe7TLhoTYb78uGpQNwjArWpYGClxtLXT2AY8LLmvVTOAw9F?=
 =?us-ascii?Q?DbbZCUZrVcB9vYxv3eb6XFjt3uiELr0wQqjpKww7hkt+jMi3UTSgasS3dFog?=
 =?us-ascii?Q?A2LW2SSUf30JVqohRARJMV97aotSNsiuP8QEosks/EpfzM5zBp19NBqRjElf?=
 =?us-ascii?Q?3NAIKlmpnUIoPPZCEUE3s8V4XybUN9AfRSBA07Rf9HElqA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f2300109-0a8c-4fbe-236f-08d8deb4c2fd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 02:25:22.1843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oATDn1XTB0V2q3AWlzeQrLuz3APr/FuXIs1aIM/hrOMPwRLdqPyFzEE7v36c37EG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4133
X-OriginatorOrg: fb.com
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-03_07:2021-03-03,2021-03-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxlogscore=709 priorityscore=1501 malwarescore=0 bulkscore=0
 suspectscore=0 phishscore=0 mlxscore=0 clxscore=1015 adultscore=0
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103040007
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 10:03:26PM -0800, Hugh Dickins wrote:
> vmstat_refresh() can occasionally catch nr_zone_write_pending and
> nr_writeback when they are transiently negative.  The reason is partly
> that the interrupt which decrements them in test_clear_page_writeback()
> can come in before __test_set_page_writeback() got to increment them;
> but transient negatives are still seen even when that is prevented, and
> I am not yet certain why (but see Roman's note below).  Those stats are
> not buggy, they have never been seen to drift away from 0 permanently:
> so just avoid the annoyance of showing a warning on them.
> 
> Similarly avoid showing a warning on nr_free_cma: CMA users have seen
> that one reported negative from /proc/sys/vm/stat_refresh too, but it
> does drift away permanently: I believe that's because its incrementation
> and decrementation are decided by page migratetype, but the migratetype
> of a pageblock is not guaranteed to be constant.
> 
> Roman Gushchin points out:
> For performance reasons, vmstat counters are incremented and decremented
> using per-cpu batches.  vmstat_refresh() flushes the per-cpu batches on
> all CPUs, to get values as accurate as possible; but this method is not
> atomic, so the resulting value is not always precise.  As a consequence,
> for those counters whose actual value is close to 0, a small negative
> value may occasionally be reported.  If the value is small and the state
> is transient, it is not an indication of an error.
> 
> Link: https://lore.kernel.org/linux-mm/20200714173747.3315771-1-guro@fb.com/
> Reported-by: Roman Gushchin <guro@fb.com>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---

Oh, sorry, it looks like I missed to ack it. Thank you for updating
the commit log!

Acked-by: Roman Gushchin <guro@fb.com>
