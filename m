Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3061B30806C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 22:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhA1VWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 16:22:22 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:17066 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231429AbhA1VVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 16:21:55 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10SLFHuH005474;
        Thu, 28 Jan 2021 13:21:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=CdMacxditgD6YwVTPpBxnkNWyowFxcQx+XVxJPDijyg=;
 b=GmrktdYFbJwAJST8IqAWFVw6XDYrlB/pQrXaPG8NCkCVdp+lQV7WlsH2i4N/xRWK6etj
 GrQ0JH6ir7TgaaWH7PCWor1mZ+vmFlcXASypNGX8oXeDAvvswT2WKAVjRLyH2LaEpkqi
 24ndYILFaWIhXTamYr2ucYDEo1d2M4TVha4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36b82t96hv-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 28 Jan 2021 13:21:02 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 28 Jan 2021 13:21:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5Ro5hyZSr/D8fyWugIxpGhc3bFfL8y+ISBUo1j5XAGSyQ2G0vNszn9fMfoj1/Ry3elc5V7udScyEPJT42aQk/mCBhEMSnD2ih52HpAPoqpeXj1cRvm9Jc1DEY0WXM/8rJWxTdQ/MmqlYrblJT2j9ro3mfECJ3ZZ6vIqxnSuaiSO7GwAwo3QT3vm/oTHXMhoXbp2CZyWgftBmCk/8TESC9BusqniV6XdxkGZOxWOVcM6j1TfpilWWdkE4dObVufqkpbGmfkD/4Wx78+i265IXnndaUg8buma4XkJc/ByC26KyHMxJKH3xLd7nW7r8TVAhPDl8i+txYCLbbWM5O43Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdMacxditgD6YwVTPpBxnkNWyowFxcQx+XVxJPDijyg=;
 b=l/u2/tS2EBv700IZyNW46Y2JBvg3nHH339+U2GAHhZi1NEqlHwa6DSgX95qrrWQujcVeUxtz+DVMW66jKeoxCPflfAIC8CKVkOJYloxCPmIGuYnvVvFheoLXaKq4iiI8Sht1Y1am1xA1wpNTBjqNJyD85NVcaWK8E41aPKLgbkMNYGZ6wEmh4gbaANEXR69swmrYGYC0YchKfq20I+KK7INuLrLfVKe/Bl7AJWsjWxzBrbXll5tOkTXJOXlS9M6RJV4TxkHmkQ3zxqB20x/oph4QiDHulAfIfd3UP7WzhdRxAYE0oo3MtCCHE2h4voM7UCyKblvAvzuMq8PI3GAUXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdMacxditgD6YwVTPpBxnkNWyowFxcQx+XVxJPDijyg=;
 b=OkrW7sv0kM7zS1BBsUuobSBri3i/Oh2hjairQcB6LyAwgbI/XMyH36XaoCuACOuTzFBCHvFyIgAfz8WlK995KQQ1nQQywTrCkDgUtPTfcR2rWGF7YrHlbe2wXb6TwHNatLKB0VjurAFfL87joy6cBcXzU1KVzvq/i0fsLJNHjsA=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2126.namprd15.prod.outlook.com (2603:10b6:805:5::14)
 by SN6PR1501MB2031.namprd15.prod.outlook.com (2603:10b6:805:8::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Thu, 28 Jan
 2021 21:20:57 +0000
Received: from SN6PR1501MB2126.namprd15.prod.outlook.com
 ([fe80::e814:36cb:5723:8bf8]) by SN6PR1501MB2126.namprd15.prod.outlook.com
 ([fe80::e814:36cb:5723:8bf8%4]) with mapi id 15.20.3805.017; Thu, 28 Jan 2021
 21:20:57 +0000
Date:   Thu, 28 Jan 2021 13:20:48 -0800
From:   Saravanan D <saravanand@fb.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     <x86@kernel.org>, <dave.hansen@linux.intel.com>, <luto@kernel.org>,
        <peterz@infradead.org>, <corbet@lwn.net>, <willy@infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <linux-doc@vger.kernel.org>, <linux-mm@kvack.org>,
        <songliubraving@fb.com>
Subject: Re: [PATCH V5] x86/mm: Tracking linear mapping split events
Message-ID: <20210128212048.oopcyfdf4j2lc663@devvm1945.atn0.facebook.com>
References: <20210128045153.GW308988@casper.infradead.org>
 <20210128104934.2916679-1-saravanand@fb.com>
 <3aec2d10-f4c3-d07a-356f-6f1001679181@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3aec2d10-f4c3-d07a-356f-6f1001679181@intel.com>
X-Originating-IP: [2620:10d:c090:400::5:7429]
X-ClientProxiedBy: CO2PR04CA0081.namprd04.prod.outlook.com
 (2603:10b6:102:1::49) To SN6PR1501MB2126.namprd15.prod.outlook.com
 (2603:10b6:805:5::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from devvm1945.atn0.facebook.com (2620:10d:c090:400::5:7429) by CO2PR04CA0081.namprd04.prod.outlook.com (2603:10b6:102:1::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Thu, 28 Jan 2021 21:20:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78eeafc7-f9d0-4159-7f69-08d8c3d29a48
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2031:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB2031B8A3AFB838D4B29A3FA1A2BA9@SN6PR1501MB2031.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dWfusrQtflQRYEGjEcjz29OlRDRGrMhINYLt5ORaGTMxjPK9xdVSw0Bqp/hVrub/5HjFHgkmu9hR8HJ+8rHZxuN83FkC0ogNT3NqYBpMs7FEnp+fi08jKVArOryojC0HXasLUV6xJfhi6turT2KyQ6ufL5dkKH7qU9JthkpCGvtEZ5itUjs81AQwSU2uR8PIpM/P6cHZidUpYyrlWeXvztIPIw4XFSVhZschO/0uq/Mhbr4cnEXqqTLMyyNggy6vNzEtqlHq8i/ziLbAqZqYxbP3WNMxzLjgORQW4eUzkQktQ5yDFUoc25MVDBVt5SRuXEKFvCvFSTZjyafQHipzYIvTNuHAxoEMj33D8UtZkCjLIpCRHHYlNQciGVhmdZLLxqo4nbUUQ0eiFhvG+6rZ5NgxBP3IxX8Hfegp5vxEJ5LEh3nyfAas9q4vHK3LnU3s09/YtaYhGTUiAv3TLUu8SC5TpyJ0QoeXgx7RUlBRK74FucmxdauOC0IUcHu6joiRxIPa72Nzz/VrEeBbpufBHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2126.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(366004)(39860400002)(396003)(55016002)(7416002)(8936002)(6916009)(5660300002)(4326008)(83380400001)(86362001)(1076003)(6666004)(6506007)(16526019)(8676002)(2906002)(66946007)(66476007)(9686003)(316002)(66556008)(478600001)(7696005)(52116002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?8Tz/3P8VyTNjdoKGSCGPLOndrk1BGJxcLy/5iqA+HyI7H9CUbKHoTzWx4Llm?=
 =?us-ascii?Q?n4oWc/QqBmFzUU71VDi5/QCtvPmRjtq6Jq4rsGOlBxvt51kLFo+Ot1mVYM8l?=
 =?us-ascii?Q?t7L0fHcbM98G4uNFHZdJzaCfJChBPe1AK1AvIqSXqxei9dt0MT8IXNSCDY4v?=
 =?us-ascii?Q?G1mMkKy1qSEIOKsN7u81qMApj9crhBWATbN95uRDVQSJkuLUSKMO22jzfngg?=
 =?us-ascii?Q?pQStlPcjmRANDwQUwAKoFaEc6cGj2oVWjXNYQSTe66Jzgz86Y6YqlpdsWYk2?=
 =?us-ascii?Q?GEpNy3Y7KUrp6wjcRVhHKG9XP5DFJbh5rfegCjWj8Lng6VfspX5fYeybweQl?=
 =?us-ascii?Q?0I7Qdut4ozeqcdQlmJSAitp98ybve87YvY9xlEUojlwWzVW206bcrcH6PmXw?=
 =?us-ascii?Q?9KNJXPt3UduKS4gbHViqVxJcCdW2MbbKIqrhzYmr4nzZzjbc8stLGdmSm5zx?=
 =?us-ascii?Q?Gp3hUHvg4vGfxQ2B4eaxOy/Zb7Nxz5cYW6eLYwRkCLhrN4523kV/NJa6xgH0?=
 =?us-ascii?Q?1RTi/Up5PBwGiYcxuj3iKCNKUavgu3WXoBd6HpMTYHO+fhsc94C5wkoOIyc/?=
 =?us-ascii?Q?pj36NOA+DfC5D0K7T81KQZjT2kjPspOS3J+VQMtb6dCgCyj5llC5xztK4C35?=
 =?us-ascii?Q?mfIWEFU3pIvPtB+zgBmJXRrDOEZNejy4A5GUTsKyA9MaDPGctPII1qaaf3dk?=
 =?us-ascii?Q?3MSIPRg781L03LwPNw+sqVnF6gjMvfjO95EVmbPsO1Rz2ybTMNpizyJK6S/M?=
 =?us-ascii?Q?G2VKam9m3W6VrE7j4WGC9anB+WxthoXiQGGzn5FiPdpFpfEtWe7X3Ocp6Wdk?=
 =?us-ascii?Q?r13Qo9sLNAnt6leOFHfCrhWljZ4duyONbX1IXAJ0+TjY1iAs5WZ2F6MD0gQh?=
 =?us-ascii?Q?tCz9is/85rJEKOSEVTIKKVtuLjlRyCRpfIN8yYVBaLjNLHNrvAUlp1/vIRQx?=
 =?us-ascii?Q?OpmUpMXmE2w4pszlGnl6B5cRgDe2SSbIXdSe3qNTmAx5FLB9LKDTOXCspoNH?=
 =?us-ascii?Q?IEb0R6foPkfsNCEOqnJnHptdhFhaT5nhHPoVzu/7XnPun8w1oIojN13sPvcw?=
 =?us-ascii?Q?frLs5uztoszG5UrIcL796L1NhNaxYEa1TBsF7OcLa3mrubOPquY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 78eeafc7-f9d0-4159-7f69-08d8c3d29a48
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2126.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2021 21:20:57.4734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e28s1yYgHKvflHiTvarwp2SpmKAG8xewb8GGEDyeM5zWCwVHrG28vO6p6A93e7GYKTRtD1vbIf99xanuifK2EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2031
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-28_12:2021-01-28,2021-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101280104
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,
> 
> Eek.  There really doesn't appear to be a place in Documentation/ that
> we've documented vmstat entries.
> 
> Maybe you can start:
> 
> 	Documentation/admin-guide/mm/vmstat.rst
> 
I was also very surprised that there does not exist documentation for
vmstat, that lead me to add a page in admin-guide which now requires lot
of caveats.

Starting a new documentation for vmstat goes beyond the scope of this patch.
I am inclined to remove Documentation from the next version [V6] of the patch.

I presume that a detailed commit log [V6] explaining why direct mapped kernel
page splis will never coalesce, how kernel tracing causes some of those
splits and why it is worth tracking them can do the job.

Proposed [V6] Commit Log:
>>>
To help with debugging the sluggishness caused by TLB miss/reload,
we introduce monotonic hugepage [direct mapped] split event counts since
system state: SYSTEM_RUNNING to be displayed as part of
/proc/vmstat in x86 servers

The lifetime split event information will be displayed at the bottom of
/proc/vmstat
....
swap_ra 0
swap_ra_hit 0
direct_map_level2_splits 94
direct_map_level3_splits 4
nr_unstable 0
....

One of the many lasting sources of direct hugepage splits is kernel
tracing (kprobes, tracepoints).

Note that the kernel's code segment [512 MB] points to the same 
physical addresses that have been already mapped in the kernel's 
direct mapping range.

Source : Documentation/x86/x86_64/mm.rst

When we enable kernel tracing, the kernel has to modify attributes/permissions
of the text segment hugepages that are direct mapped causing them to split.

Kernel's direct mapped hugepages do not coalesce back after split and
remain in place for the remainder of the lifetime.

An instance of direct page splits when we turn on
dynamic kernel tracing
....
cat /proc/vmstat | grep -i direct_map_level
direct_map_level2_splits 784
direct_map_level3_splits 12
bpftrace -e 'tracepoint:raw_syscalls:sys_enter { @ [pid, comm] =
count(); }'
cat /proc/vmstat | grep -i
direct_map_level
direct_map_level2_splits 789
direct_map_level3_splits 12
....
<<<

Thanks,
Saravanan D
