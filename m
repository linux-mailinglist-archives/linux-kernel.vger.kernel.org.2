Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2485730687F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 01:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhA1AQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 19:16:41 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37834 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231796AbhA1AQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 19:16:04 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10S05eGm019294;
        Wed, 27 Jan 2021 16:15:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=glGBVd7FwQnr/pUAjkk3URapNi1AincrbL44AbdJ/Uo=;
 b=UPkc55Yua617+V3DCRKryfx9BwSUKGlK+oz1TOOlfbTdZjJKti8zWro4UyzNUH/1g+zH
 j5PnblKegXf4uemLxN4VIEzqFtH1sKkb5EeFvkY+6EYlElzkAGuxiiNIyrUu/zZp9X6e
 zCwfFguhd2uaPPAuniJouKqr7lKjnaRI0WA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36b7vwkpwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 27 Jan 2021 16:15:17 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 27 Jan 2021 16:15:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5yhX7MaX25V0vNOrRWKgjLW+E/MClq4j4dzsj/g0UHADkJIW6phlW8JK6fSa0DnbRywC134kqgTGIh43LHFnF7hAIIHOf2bH8SPJrQZSF9k6zzVJAdJPBFQOwGGWv54jaNmVG4rPBkYby1T4l0w9svdrqV7VwK3Mb2Art1EwcyAMvP3iUYhVm0uw5DzYDvA/EJFc8bcwBvItrmPp2NyxvCfWsiSaHp0J9KEE3WCzoGoZuoddwtszK+4CiFwyQ8RF5OwC3vXCSFdrcFr1gedY0G8EOi3tJAJ37l+cn6aWI5k2PowWx7wKjWigWnqtE/7EO2ckTV+fa+yMMXjuUBjfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glGBVd7FwQnr/pUAjkk3URapNi1AincrbL44AbdJ/Uo=;
 b=bTrwUSAqUXo7oFKDmMOXk1RPRAm/MBcYpLmcfumP92qb02UvS5IFuskX0Zb7qu5ZkFSDYPBxBqfJxfA0aLrvpZBCZ8UlZtmafXjsu2fbMX+5jlhYdJuEISxKj3ECr3YeiQB3DMvSmwne32sJL69ZafEWQzkSYo6V6OxtOANhbhRdgSkt2NvBF0Vk70S/6dpzus7Y/gPLguJBX5HfoMfWQXVpfh8UUPm4wH4zpnGVrrGVkjGCOmLV1y4iAEJQ8Qn/jh9Vcd0kBxlrGLUmdQemK8h6/PtXX9yHnu+u6JHYMBsBjhL7YoEJuyC40DVnvPlaDxWly9yMBVV5kFcMxuKxZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glGBVd7FwQnr/pUAjkk3URapNi1AincrbL44AbdJ/Uo=;
 b=VqPsVZlz/5HQpH8u+P8EpCwYMAoajGRgHjyV8314PtlfpaGcqC3Ev9CBEi5YBLZb8PAk1Ea8ML7JLNFKEdq1swFxgKNepZJSv7rTE7l77vdj4lBSvagIdso6zgX49Y7WgvWzGjaOIwrXEpbbMtiOrHabMZ/vZ7nowA8N5aG/6rU=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2126.namprd15.prod.outlook.com (2603:10b6:805:5::14)
 by SN6PR15MB2413.namprd15.prod.outlook.com (2603:10b6:805:1b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Thu, 28 Jan
 2021 00:15:14 +0000
Received: from SN6PR1501MB2126.namprd15.prod.outlook.com
 ([fe80::e814:36cb:5723:8bf8]) by SN6PR1501MB2126.namprd15.prod.outlook.com
 ([fe80::e814:36cb:5723:8bf8%4]) with mapi id 15.20.3805.017; Thu, 28 Jan 2021
 00:15:14 +0000
Date:   Wed, 27 Jan 2021 16:15:07 -0800
From:   Saravanan D <saravanand@fb.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     <x86@kernel.org>, <dave.hansen@linux.intel.com>, <luto@kernel.org>,
        <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH V3] x86/mm: Tracking linear mapping split events
Message-ID: <20210128001507.zs5uuhniuttrjqjt@devvm1945.atn0.facebook.com>
References: <YBHc4JHc4ogwV93W@slm.duckdns.org>
 <20210127225059.246646-1-saravanand@fb.com>
 <a936a943-9d8f-7e3c-af38-1c99ae176e1f@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a936a943-9d8f-7e3c-af38-1c99ae176e1f@intel.com>
X-Originating-IP: [2620:10d:c090:400::5:7429]
X-ClientProxiedBy: MW4PR03CA0057.namprd03.prod.outlook.com
 (2603:10b6:303:8e::32) To SN6PR1501MB2126.namprd15.prod.outlook.com
 (2603:10b6:805:5::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from devvm1945.atn0.facebook.com (2620:10d:c090:400::5:7429) by MW4PR03CA0057.namprd03.prod.outlook.com (2603:10b6:303:8e::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.14 via Frontend Transport; Thu, 28 Jan 2021 00:15:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24c102bc-5f0a-419f-b79f-08d8c321c889
X-MS-TrafficTypeDiagnostic: SN6PR15MB2413:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB2413654AB1E11EA3D7FB83B2A2BA9@SN6PR15MB2413.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HUOPCb4QLNogU1SsTHqJe5+Up3IPrUchrjrjggMFeAOYB+CeoEk7ZcAeXELhnHMNYl7WY2+v6dCL9Lml/T/pkj4o7AKuEGWBVsLCNv71nlbPdoE+L3GGuEYelA35wtUF4qXYCP6YaX35Cqwtsrp5prMEydUHgZNgf1qyfyxGw9U2Vr+UeK2KHh2ZVrg5gwsYGfyQIAogR06Wa5/14A6JnOnEMV64Mxz64UigMvXdLeFgZfuwrYbdG/RoxUD9/zArvf/8G2hmT/vzwMQcfjQ7ZHLHkm+5mAN4bSNcGw+YoKdBjMuDVL2PRaYNSXDwriE3hnpV0gOm+hQtn2yG4FpO0zSAyeQKiM8eB/3OueAYg1VAuVfBICvpbQGSn4O5Hrt32LpM1NDM0fOxdmoExE9lwvDQOdeOCQRUMnxk5huQSJH3eGiSFZpmExg6IZjztgkjFR1Tpu6JDUvb+JHCpEr144/OiXLO8Iw02qB4nTKkVuvxtLjGETBe8QGUE/YdjBlY6LnC2s62ckr3YMUu0oZ8vw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2126.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39860400002)(396003)(376002)(136003)(6916009)(478600001)(4744005)(8936002)(8676002)(6666004)(4326008)(2906002)(86362001)(66946007)(9686003)(7696005)(1076003)(52116002)(66476007)(16526019)(5660300002)(186003)(316002)(6506007)(66556008)(55016002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YPmDa7/OtoKMOM0jKXeFWdlJzXCIO2RaVv3Dx8rVloy9GG1b2Ob44xXhwZBR?=
 =?us-ascii?Q?+vYyPPTUh/00hyDtotKHp7Ox1tB/P7v/TjT0QobtNaWqLbk6ZrBFrco8iTHC?=
 =?us-ascii?Q?9CVe1Yw8Yo3DGPORN6I3Dar1iq/XALJbhrjEugNpHYXk88QFgKsx1BKMFL8V?=
 =?us-ascii?Q?PleBLvTgkgUoIKKIpeuBLGlnS0/XUieTAwAU+30rpa6EIKPdUEHd/2cscnDU?=
 =?us-ascii?Q?JUYcLz4O+fo5IPUnJD+0ZOH8aU6mWNFGm3O1wBxD6YpHZCCcQSfmkxElg3HE?=
 =?us-ascii?Q?MclS9Ulf2MvXg2fVXoh4Hrf8asVTldololOsX841ylYWP/zQ7I0FMin0km2T?=
 =?us-ascii?Q?Mhr50FZP51vdIs+wyflo7rqqZdwPbWrvo5j3gtrmR+qH1SKoSq2d95W3f+AY?=
 =?us-ascii?Q?LZNYsBU5jJgLaycObs/ISJGmSkNzrSg21tL/4R+Qafp9pkyHABBWCOQ0KEqq?=
 =?us-ascii?Q?ZLQQN/4EDXSfxkaHRW8TxG6/fsVWN9bePr2R6hVKueeYYX2xVNuPfOP7A+Yt?=
 =?us-ascii?Q?u8rlLPv0mHF5gkzjQSCGlCJT3m+1/C5VNYC0AElbJfmcnYga7GUryDV5geZ+?=
 =?us-ascii?Q?jwHICSH38SehqH1o3ZwGdMeKp+kgQKVf7I7/NkTb7QkGNrxGwvhbeCqCZtd0?=
 =?us-ascii?Q?ksVUaz3ZzJPrfcz7dpsRRSUpUvioSqiz6XEBpoBI2R/9QqR2fhsz4AWDMSDA?=
 =?us-ascii?Q?Ct8AgrmbW+ieeByWUVQx63ti8t6Mw/cye9kvcWe3GDgzTK3ssR2Uhr72wQcT?=
 =?us-ascii?Q?nOy++Yki1FbhINSwXfRCf32/q7Kh4C7a6Dgb70EDbp3+fNEjOjDcrx91G6W/?=
 =?us-ascii?Q?gfEMxbL4n1fQ+CJvXy7C+I3lTult+F6DLZfRuOStAZb35/LGp6W5xQduMsR0?=
 =?us-ascii?Q?dRlvNwzmGrilrGD+hvWkZs92iw203Yy11ZBgcXB1t87TMhMbUQwUFKnSbgCG?=
 =?us-ascii?Q?q5vZrg/pAm6tsrFqHPhdKrFRlie/sgsr1Mz4w/5MCe4N5dE7y2+DvbE5tX0T?=
 =?us-ascii?Q?bNVEOX4i1Kk1QHRdtw4MrfrsGlTq7hu0vxIx8FMDAaqjoIlQTU7ikBgm6bCX?=
 =?us-ascii?Q?v+Ki9+kK3vbUmbEp2IQPJ7Io9kbi1IiBCKzX4pW0JrHX9ZjQ7TA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c102bc-5f0a-419f-b79f-08d8c321c889
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2126.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2021 00:15:14.1309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZ+j76kuVxfFQfWlMOLnKkaFW6+NPSOhlsh/+mYbnbkZvEfxy7XSaLtyYT8fGcwXeZyvTnLEMcx3u1hVDjC26Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2413
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-27_10:2021-01-27,2021-01-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101270119
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

> We don't use __x86_64__ in the kernel.  This should be CONFIG_X86.
Noted. I will correct this in V4

> or the level from the bottom where the split occurred:
> 
> 	direct_map_level2_splits
> 	direct_map_level3_splits
> 
> That has the bonus of being usable on other architectures.
Naming them after page table levels makes lot of sense. 2 new vmstat 
event counters that is relevant for all without the need for #ifdef 
page size craziness.

- Saravanan D
