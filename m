Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2483066B0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 22:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234689AbhA0VrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 16:47:09 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48350 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234801AbhA0Voq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 16:44:46 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10RLUAXl032552;
        Wed, 27 Jan 2021 13:43:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=shnvsc8vjUoDZDGU+XWuc3BbpAW+rWLS08x5H8Zm67E=;
 b=ec5oUaj4Q36LWUEkS1uld4X7MldMRrjlgh3IWGrXtPOSfKwbtmwF3QwYcpVJsP8lkK+s
 cuLblellOR4xEpE4EFg0a1nYTt6pJBpF7QhbrsimLKeHBm/niGnKnr5q7mB0VCdezZWu
 0HBtoQv7NGTtcZcse995kSnaStuF3IUlHqE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36awcpnh9t-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 27 Jan 2021 13:43:00 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 27 Jan 2021 13:42:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUrYVVGRnSLlq/qxi2aMgjy9siH3P7uwkHn9LFJau1G1WJhqdWbKAgNjnLiKAbVt2mbmIeP09zaEi15AdauwpkXg8DKrZEdCC6tfYV0/CpkifvFp5jGZRgI5N+un7DEvQWOUo14wSLEn22wJICTVtLO5rurE4aFOZiVi6RavRH1/Ymrov2DuD3KbAwquvm/Uy9lFI0zBxYcT1/3Wcu0bTYk1TvEH7Uf9R7RttvyK7kZIO8QxysxX6Qs4kdGrdYmIZVlcYtJcv6PlMXIyGiOTOjkHGelK03cbhqqDPBGD2Ba5O+oH6YLEGpKLBm/m+YTnqAoMl50nnwEuz8yngMtciw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shnvsc8vjUoDZDGU+XWuc3BbpAW+rWLS08x5H8Zm67E=;
 b=ZU2TH+qaKELaapRbPRTHPqI4WFzocFWlw+t6EKO2oIBN2YCO9+DDL3tpnp7Mqxc5632AmT6A1qkRR0CuSJrzHXwrbniIexS5PVQ7P4KMLJGmfkLhMRuX44syvxROYXDP4SU1umgtVuh76bvsvq4o6Zaxe9PQLqpIBV+cwgEBBSgcAZiAvOR2BkLB4asnHfU96Wu+VtfW3HgG/JjMeUz+nGnTCnjaFVgFoq91XI5JpLaI6fuWcofkqPgZhcGzL7hETYaryQZZ3Vg0bkELTMV9k0fH/RaDFL2nXT1YOyz0xLHdX/mwASU1g+H2sKw+D0cBn0g+IuI1HwIKccS1WA1Wag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shnvsc8vjUoDZDGU+XWuc3BbpAW+rWLS08x5H8Zm67E=;
 b=dhNmz1RE1S0vG6fU67PHEOeomZjL+hD/Q8oRhk1KAtRTtjh9j+66w2yDzCrAExsBFLDCUFedbf8DY9cEkvL0MyK3t7ybdq9hY0cMlRK5a0AZZEfOJ4dne6fviAhSgfYV2HmyqOCsXyqJ1Gwpb45MGCTHK8hteWKS3Ik4XtMnn64=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2126.namprd15.prod.outlook.com (2603:10b6:805:5::14)
 by SN6PR15MB2256.namprd15.prod.outlook.com (2603:10b6:805:1b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Wed, 27 Jan
 2021 21:42:54 +0000
Received: from SN6PR1501MB2126.namprd15.prod.outlook.com
 ([fe80::e814:36cb:5723:8bf8]) by SN6PR1501MB2126.namprd15.prod.outlook.com
 ([fe80::e814:36cb:5723:8bf8%4]) with mapi id 15.20.3805.017; Wed, 27 Jan 2021
 21:42:53 +0000
Date:   Wed, 27 Jan 2021 13:42:46 -0800
From:   Saravanan D <saravanand@fb.com>
To:     Tejun Heo <tj@kernel.org>
CC:     Dave Hansen <dave.hansen@intel.com>, <x86@kernel.org>,
        <dave.hansen@linux.intel.com>, <luto@kernel.org>,
        <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH V2] x86/mm: Tracking linear mapping split events
Message-ID: <20210127214246.gwxvbdvi6g7pjprn@devvm1945.atn0.facebook.com>
References: <bd157a11-8e6b-5f44-4d91-d99adb9f8686@intel.com>
 <20210127175124.3289879-1-saravanand@fb.com>
 <YBHVCZscdVsxbFUk@slm.duckdns.org>
 <5562757e-578b-0ad7-1a9c-c64238283ab7@intel.com>
 <YBHc4JHc4ogwV93W@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBHc4JHc4ogwV93W@slm.duckdns.org>
X-Originating-IP: [2620:10d:c090:400::5:7429]
X-ClientProxiedBy: MW3PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:303:2b::30) To SN6PR1501MB2126.namprd15.prod.outlook.com
 (2603:10b6:805:5::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from devvm1945.atn0.facebook.com (2620:10d:c090:400::5:7429) by MW3PR05CA0025.namprd05.prod.outlook.com (2603:10b6:303:2b::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.7 via Frontend Transport; Wed, 27 Jan 2021 21:42:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2be96e9d-79f7-41c3-c994-08d8c30c8065
X-MS-TrafficTypeDiagnostic: SN6PR15MB2256:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB2256632DFCA02588ED9185EBA2BB9@SN6PR15MB2256.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ur9OlkCqITkuABMKfs/eMXYeCe/QXccFppVS/B2KkxIYO/OOfVWGqdo9bsJPgPBX7NcHiKMakIVf/IAzQaWe8rkV4SQp2+mwn3G+DV1d1lZI8m+oCtYnAcctteuTDo+7HPVMz0th/FZIa+7SDhFBftq9gnaEHR4iCdS8WoC+ikkFHbHiySAPnI3pLrHmTiAleX7qbbAI1HQPEf4GbHTtqS7gzDgsZDebqYIDbqNkXQolSzKCQEBfdWncHxe+kyysKaPCDH6c6YEkXPgYgP6cJWGTurqMPuD/+G+bVirBqFv1lq6baD/0qQHa51aGmPpMrWp0hIGM72+wmGm2w/XniAmdSvjyQZKuzScraY6ZK3IH8HBQC78WHuCNHIDto2ZWnIEF980bbhJB8E2m5/XqsDooFvg8bV653lMWGeiN6Ul8ZDFupywfRQUdEKSKbssH5a5yDc4RP3aOn3YZl078YIysmuhoSlZMJjixtNyT/F3v3KC8CBaqHPy7viLxNK9e2hRRx7ZvEWR4p69J5r1Mjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2126.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(39860400002)(136003)(366004)(4326008)(6506007)(558084003)(66946007)(8676002)(66556008)(186003)(316002)(5660300002)(478600001)(16526019)(1076003)(66476007)(9686003)(2906002)(6916009)(6666004)(55016002)(52116002)(8936002)(86362001)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?DNTpDtY0f8UxLo8g1UkSAwYgPs0dtald9+JFX5anw7wtnIE+AXyQYHM4+eq7?=
 =?us-ascii?Q?/swHsZnGwV0QZhCw81zi/uTX63XgF477er4A+MwztVjAdpz9FtqiIAWyEpyL?=
 =?us-ascii?Q?NEvgu0orQZeJACbrbF99G5SgNUGYxhJLv+kSv3Pok+5yfDhkbWn6v91FVSaV?=
 =?us-ascii?Q?ggEshJYK6pK1uUrIorioXy6/Z19UVgK0rhHi001HUto7Gx3J7QsaGKJomipN?=
 =?us-ascii?Q?GJykj3ciF0ky6a3dvMf4h8G2p0doAvrIkQlYAMmOO/oqe/tvh0Py21b23B/X?=
 =?us-ascii?Q?dr3T+zkX3C9OC0/vqWBveB3gEYEbuh5qpDohADowuZ43AjMZmCz5nhYlROOW?=
 =?us-ascii?Q?wzPRWe1cvLs8+eu6pkB8M3F3x50S3mGdkuSbaSmM7RC4QfJmSnSr0Xb4bdbY?=
 =?us-ascii?Q?HXJQ0kToRPyaX5l34bXs01Xtf7JW5PCX2zURP7nYhXd/DJBQz6CsM/JfD9q+?=
 =?us-ascii?Q?XV0vvqkgUqpvsWoZDztXMuBJ+C+x/4N81xLA4OBD+LB7RUHrDkNNfuZo00Pt?=
 =?us-ascii?Q?Rtwg8IZa52EQOQiaP2DipijllTUEou0qwrpXlv/aJQOOcpiY59oTYVvmG8iy?=
 =?us-ascii?Q?J+S3FbSUBuzxQzyYW+V3dqIi8TjYUnz7ViTufkiNDvLOPOvUfzLmEoY+lJgT?=
 =?us-ascii?Q?Dh8ajKDqXwvGRlvir4zUyZcm/vgBc9wFOE/r8F5TCkyMrDfZPAOF215rgj5x?=
 =?us-ascii?Q?qFzffxnddhB7ZJVOgnc8wHzFh8X52ct8Xmt4jUp2WctM4kQowjXnVBqhgODn?=
 =?us-ascii?Q?6tRbYIeFJpnQSLYI4AxdVrWZ6/9mLjRexTeA4wGRbujTne2S5yPDHmN31g41?=
 =?us-ascii?Q?+zZQCqbSYW3/i8tXmXOeh2eFY+JkdUvcUjHYoGaxLAJ65aaQ9hLcMws++nmp?=
 =?us-ascii?Q?hC29tQY4UZu5VfjnWO3NPFl6IctkLhfs78uPcGVUqf04VC9o1utjJL31shcH?=
 =?us-ascii?Q?+JHXhCbVY0uIxk8gSJGwyI7aDueAmEJfKk6RKk5I+ZNZdY9d5SdWk0YgHyJz?=
 =?us-ascii?Q?qEAyUINyintt2PkPpTyBoCKtcLI3KZocSjp9prsE2bc4WyndX2liPOpNKCYS?=
 =?us-ascii?Q?x4CHKE6jC0FNFDeRQiNc+K4gVmr5cDXFeqYLJsj24lBXN3tIOqA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be96e9d-79f7-41c3-c994-08d8c30c8065
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2126.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 21:42:53.8910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7h+ezdK0SHdJP4DANti720SdCAS1ngzW96iwlWlWbPSceP6L2nYViEwEP04Ha6/fwrKXgjCrUdsBVOQqmU1YtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2256
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-27_09:2021-01-27,2021-01-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 bulkscore=0 mlxlogscore=922 priorityscore=1501 spamscore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101270109
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

> Saravanan, can you please drop the debugfs portion and repost?
Sure.

Saravanan D
