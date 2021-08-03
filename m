Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4353DE4B2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 05:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbhHCDbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 23:31:01 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:62016 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233197AbhHCDa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 23:30:59 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1733Nm0M011555;
        Mon, 2 Aug 2021 20:30:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=oRtwW5O7ZV7fpZbUsBUpcibJRsl5cPaqW2CnQXKDIzI=;
 b=ALlR/GKwUVBsY3yJIrh2Iu8FgOLrNngKdLnmLqsz3E7qahdCwtxNeHV+4/DH3IQe9tvU
 KgwNkV2Li3ctAPODP8GOiofjJ7GYlJFs7kNI+NtjSg2gf8dnFeHK+NoruoEV7fcwyWDJ
 jfkUlX/0eEUUVAuCsvvd68ChmhQP7yOOPqk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3a6qe1j1j9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 02 Aug 2021 20:30:29 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 2 Aug 2021 20:30:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZk48rHljK/4OLYwcpV1AQtwF8iNckoP20/PYGp2eW+CtX/INrM2zCgOOMZfsah7izOZrV3SlxPUvvDM3BXrD2G11dr2H2/H6jvIcQIxgxwV+feHZoRdfqltDqZ4HZsKZsVqS3KNdHHwKLR2ed++wu/XBvNbT969lHGqW4U7ElsJK0tFyX0ScEedIboc/lUm48amIpFyzDOh9YXkx1wdwgvjz7ih+PGYe28C7VMLAhAYYmcPecuNOP0/TIY7VqfOkiXo3cdnJoRQ9OmioRKODbkE1DNHPRXx5bq2gur95eG4Nq7/o7BvWpLxP7uBMreFn1nsjnPShw6btVazXYMI7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRtwW5O7ZV7fpZbUsBUpcibJRsl5cPaqW2CnQXKDIzI=;
 b=S2TK9LDXqIQV1TSArYJeLb5EdNeTb8AoJJfMDLaFGQqew1IAz1UHQGnDgQCnexhureUJEQkO75GfiikCkEeemWu/DIeV51c+Or882ZnWZRcQEFM5Kvo5yUHZNXxcVn47PnpPT0sPLGtDoVZdAFtMB4jXRz+9DtqCbe/h7EgBUaLiGxhRUal8O/QGfHLGwCg1AGWhylF+Tq9/5M8bAiCbz7mStu3c2ZHpKRGWxu9Sh6rTyIWI4xQvDERgUzoGfqHLR9GHJpLtnA0LWpy9QTsUyosnuklmZbmPJdSjhzBjO+npZrZYfOo3MH01T52XPQKIW0KfW+9N7HiFl+1INwnqPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY3PR15MB4962.namprd15.prod.outlook.com (2603:10b6:a03:3c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20; Tue, 3 Aug
 2021 03:30:25 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7%6]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 03:30:25 +0000
Date:   Mon, 2 Aug 2021 20:30:21 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Wang Hai <wanghai38@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH] slub: fix kmalloc_pagealloc_invalid_free unit test
Message-ID: <YQi4TUMDTBrcXxEX@carbon.dhcp.thefacebook.com>
References: <20210802180819.1110165-1-shakeelb@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210802180819.1110165-1-shakeelb@google.com>
X-ClientProxiedBy: MW4PR04CA0235.namprd04.prod.outlook.com
 (2603:10b6:303:87::30) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:dd54) by MW4PR04CA0235.namprd04.prod.outlook.com (2603:10b6:303:87::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Tue, 3 Aug 2021 03:30:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25a89cb5-d8eb-4b33-39f1-08d9562f0879
X-MS-TrafficTypeDiagnostic: BY3PR15MB4962:
X-Microsoft-Antispam-PRVS: <BY3PR15MB4962964D5D7D54FB60ADCFE9BEF09@BY3PR15MB4962.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:446;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UKbQZ2n5zdPpaZDrZ/mCwsh94/RLYeKc3APWVuUyZiWunuI73i2NBfu5NDb1WOx6McSNjOLnp2utZsyiWNU0yRgFTbJLwInUyViH6sK98vOHqqHMFdyqft9L2uadOi5C+nqYrzI/91fVZn3Qb/XbQbRH97KiXbcZdNGPdNQppsH7l0HJrMizYkNbX0oowoFc4+FqA6C8K09R8zYFXpIJ7edDFbaMjkpPS7kMjXdqGC9UsHsPuf3jMmhqhLBSY/mE1AkQrfuhG5ZVySyXFJMPxDSFNnuK9ZXy8aLr8ingKw2DI8xPHFlzsBg9xdy8ueOL+ybPuuKj42/8/8OcU1IYhjCUWVOtRQtMCylGd5GTYKMgr1/Tahl+TElhReRa9fFLExzauLsX6j89dIqePuf4127KRKHUflKiWFSiGGIpYM+Yo2AcEuElRhT151TmQ9I0iydVGBcDUjM1apx5VP5+NZUBUAYP9/AC5smXm2j1/QhZO7IgX9J5nkkUlUvfcnbo+UzuLd7hyre4SlDW028+l1oojRIX1MDGy7A8nJCunjgw3FWSegXVYftJVnQqxC5hLPaOcd39IA9f7VpYmJAhYxDNn6I54weH/TYKLT6Z1wD8xQr2uMA/9GvzljOWuMNQcZGNR4l2g1qCuw/ejc0bWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(316002)(186003)(478600001)(66556008)(66476007)(66946007)(8676002)(38100700002)(8936002)(55016002)(5660300002)(4326008)(9686003)(6666004)(4744005)(86362001)(52116002)(7696005)(7416002)(83380400001)(6916009)(2906002)(6506007)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FrvGK1JiWpX5YX9beWD93Ad90s+TD3bps4rnK7EsxpFKUWz4XcIblHNKJoKZ?=
 =?us-ascii?Q?OmEGqEf7vyQXMb+h8zE1RmKOOcUHocWnZlbXgy63DCO6yEbyg2n3rIx2/Qdc?=
 =?us-ascii?Q?YGisFEpWbzV97w8VJNBMv/yV10HW2EIFxdZMmAqUqSOExa6xmZvUXqCmKgrv?=
 =?us-ascii?Q?OXk4Xv+cF9jPvofNlhkuSwQYKR9ZUurGq/LfnMUdxMZmbkbB4Z3reTXtX++g?=
 =?us-ascii?Q?WJgJ6/mDZyyiTRBO7dsv/vmIFBe7a7GE3NqUF9HwN7yl0dKcHDwbj4oE/2KA?=
 =?us-ascii?Q?u+2cVjig+snXP8Fd8xYANEgkbCNhYDMMw6eE03advu/qUU+K/83ZSNL+J0AP?=
 =?us-ascii?Q?sX/KPP4kPag6K1sONcBeoT3Z8mRrWx4mqSXg1qDmRa9muKSFuKmAMGPm9N+O?=
 =?us-ascii?Q?5OoSqTMp8j8YjCUC7HDKW7c+RnVFSwrTpkUx8hySKSUXCUA9tHA0OlFeODtE?=
 =?us-ascii?Q?fzuS2xqGm/52ATbmjyhioM1ZrYbJ5hTpNYZnbvuiqnUacsGIzxGqjg4CLQg5?=
 =?us-ascii?Q?juC/nx8ayPwHJgK8l2nHhF4Qg7eNC0IjYIgTguZnGxI7NQiHGf2O+KuKEawh?=
 =?us-ascii?Q?54j1bT2A914cJz0iav2kGvK+26aVoPQRYPJE6CIs17TAdOuUiJt/Kg22rOIO?=
 =?us-ascii?Q?zFa56l1Plc8nz1T/nMDuDQaMTh38urVCLWc7cNsq1kLD6kOy1v2vPfiuWDZI?=
 =?us-ascii?Q?P+0GXtkYP19KXWmXRV5FEkWaJ9mJIzCK6xuYXvS8io3UnvrY29MbsjTunCmd?=
 =?us-ascii?Q?JJn9Mdsss+tr95tQTxhAl2aUR7jjpCJIN8/f7ad0SwFlTbuv5Ip+UbulszIU?=
 =?us-ascii?Q?iFyTGvZ/ykk9uUwml4ZVD4BVH0mJhaU3aCcXsgDu1itMcI9RX7y5JPeIF017?=
 =?us-ascii?Q?XUl2gj5djSnj2WzZePqIirHrjVNy+YC4CXloIDmh2EFgnvS+Q7x5TIqUtigF?=
 =?us-ascii?Q?oWYiKmAh8KcRL55EGsnZTYyE2v1072heOW4vrk9lpfajydfu8Fb+zgCNWQpc?=
 =?us-ascii?Q?6os30SCH1A7OsLzttyh093vmL0z5DKNXcaR3C28uHaT42Tl00vBXVjQCW+9t?=
 =?us-ascii?Q?VZ6BmyKILnNVpe0p19xGMB53TV0TlZvgAjuOawgXMrBgHJKTfWghmZIPCe3l?=
 =?us-ascii?Q?rvCTUj8nWAj6eMhMnj3E05kK2C8AvEZQVFqDUDPZZrlqk1y39LeZqzBoFOUM?=
 =?us-ascii?Q?fCPNzxLZg+J/FD3jKa9s2tifRVe3WHiS1S/Qhrdq/Ca57itpcBYncZiT65If?=
 =?us-ascii?Q?G+dNmWlSmA0X8FlMsIt6b4kDApWgvJvjF1c3AgG5zpCcD2dxmv52onNy09d8?=
 =?us-ascii?Q?9uTwUTkVOBx25/gnV1I7rn9RFdTu4da32+1xm9lGshBxCg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a89cb5-d8eb-4b33-39f1-08d9562f0879
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 03:30:25.6299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O2tv9GU4hI1nxe/IZAqYkEsriHDTHPI8haRvd49NZnvleHEhVafF5w2NJkXmUj45
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4962
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: WqfKHqqZ2ZcpLJlk3tlp1jK7zf8WGiUL
X-Proofpoint-ORIG-GUID: WqfKHqqZ2ZcpLJlk3tlp1jK7zf8WGiUL
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-02_10:2021-08-02,2021-08-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=751 adultscore=0 clxscore=1011 bulkscore=0 phishscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108030018
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 11:08:18AM -0700, Shakeel Butt wrote:
> The unit test kmalloc_pagealloc_invalid_free makes sure that for the
> higher order slub allocation which goes to page allocator, the free is
> called with the correct address i.e. the virtual address of the head
> page.
> 
> The commit f227f0faf63b ("slub: fix unreclaimable slab stat for bulk
> free") unified the free code paths for page allocator based slub
> allocations but instead of using the address passed by the caller, it
> extracted the address from the page. Thus making the unit test
> kmalloc_pagealloc_invalid_free moot. So, fix this by using the address
> passed by the caller.
> 
> Should we fix this? I think yes because dev expect kasan to catch these
> type of programming bugs.

I think so too.

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
