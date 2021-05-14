Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAFDE381201
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 22:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbhENUvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 16:51:36 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38340 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhENUvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 16:51:31 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14EKj1f0058283;
        Fri, 14 May 2021 20:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=f65agFedW/7FHmFwnLxf44LNQ9enwgW1NG+Erz7jeB0=;
 b=ZUhUroWv1t6rHwyN7N+BqfnSpVx4IYbrQMYEUdrvPJ0ogUzyRwEPBvO8ZuV8ZwoxNHfv
 3vfVr9907XT9JHdLyGuljTqT8JgXl/qEC7JK8U2A5lW4sSJUZ60eOr4P0Ra5L8aqnkVl
 tjUvBjZWZHKSoeMI1IChameVdse4zcN7lM3nBTKw/X9uSijqpyLeQVceO5cv2NDO+i/h
 16LxfOJzXCdWlFj9rAB7b1dxv37iH7TRQeSTePFULEUqBTbsGQsuncvO4uQr2HY82tLp
 dR/eQPYACv/XBE0oUgT4o09FaW/epRfqvHO+EL2A0eEMUo3vBSxjj9igQMiZTrrnbCXE dA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 38gpnddb6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 20:49:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14EKnq2T075943;
        Fri, 14 May 2021 20:49:55 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by userp3030.oracle.com with ESMTP id 38gpq3e148-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 20:49:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvHOFr0VLWIMr4bV0MyWsd3Z3fjK19f0M0ku9M+YvkLFwcfcHrdz+YEC3QxVggO0AAWEU+Vt5tyQEaAt+y77HBBHerDPYrId73xy905RpY1UhtB64jPGDAJtyMl/wxLaPucT80h3dapraD358DMr5vGDpu9uKI6F2vu43SlLvPaLGhut9EtlrBMY3KFjUPNe7tHznsnN6+K2QbRx/976XBejes0U5sFYKki+zi9zHZtDRlPhG1IKqGnf0pyDzDwISM8dtvjEwub/kH269yxMoMdmP+gpQbR/PiOalOUKpAB9bVhxp0qGw5ffaMYsba4lvjnp2XDpELKB/0Dr/YA2SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f65agFedW/7FHmFwnLxf44LNQ9enwgW1NG+Erz7jeB0=;
 b=L07QInMRj23K1ewRY0/Ap386SFK5vjZXfti3RYUOZFMN9ncGXJZAFfT98tNonup0wyjP6CH2NF5Ga9WaeCS3D71p37mDy5xaI3dcngp+Ci6LWKPTSCqqgKUlml9vOXFcJvL6tkcY+sViHs0L+/D3c776PSGfC5ZhNqroDgqZ4fJisGK+VIsw4xzagy5iFv4C+o176BWAr8woYO8hHkzTQgHRF7dv/TP6xtI9lpVm4hgX0N/zSZblOsPXkVjpgt/kHQ8v0gTgD6WVOgfVzhQoLyibeM9+pjUoRvBz1PhaMLBQFD+/B1ZH+zsc28hiHSmrxb203EE8FbgthVklgJaaAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f65agFedW/7FHmFwnLxf44LNQ9enwgW1NG+Erz7jeB0=;
 b=F/Btn8yT+tEM5obyzrql5qFhsLqOMo1ivYpL5RI3sS5VUpnUzTqxrH7bmhN5K8spHfK8eASGqR4yQaHgrbQiJcafsmQ1YrYvXiXPOfgvUWmXIrFZzC4wFsQXFAHFWJvcu7+SOYQA/x7yX1KY6A/abYPxRqsJFPTUbQE0YlTTr28=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2966.namprd10.prod.outlook.com (2603:10b6:a03:8c::27)
 by BYAPR10MB2693.namprd10.prod.outlook.com (2603:10b6:a02:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 14 May
 2021 20:49:52 +0000
Received: from BYAPR10MB2966.namprd10.prod.outlook.com
 ([fe80::144d:392c:6407:169]) by BYAPR10MB2966.namprd10.prod.outlook.com
 ([fe80::144d:392c:6407:169%5]) with mapi id 15.20.4129.028; Fri, 14 May 2021
 20:49:51 +0000
Date:   Fri, 14 May 2021 16:49:47 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Omar Sandoval <osandov@fb.com>,
        Paul McKenney <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH] mm, swap: Remove unnecessary smp_rmb() in
 swap_type_to_swap_info()
Message-ID: <20210514204947.g5nznqwo6gnt2vnu@oracle.com>
References: <20210513064837.3949064-1-ying.huang@intel.com>
 <YJ0fkhuAZ7JnNmEw@hirez.programming.kicks-ass.net>
 <20210514015946.nivgnoobef4nqwmw@oracle.com>
 <878s4iezeq.fsf@yhuang6-desk1.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878s4iezeq.fsf@yhuang6-desk1.ccr.corp.intel.com>
X-Originating-IP: [98.229.125.203]
X-ClientProxiedBy: MN2PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:208:fc::30) To BYAPR10MB2966.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from oracle.com (98.229.125.203) by MN2PR02CA0017.namprd02.prod.outlook.com (2603:10b6:208:fc::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.32 via Frontend Transport; Fri, 14 May 2021 20:49:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f548e45-fccd-45b2-e230-08d91719d1fc
X-MS-TrafficTypeDiagnostic: BYAPR10MB2693:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB2693C3ED6A76793338AE03BDD9509@BYAPR10MB2693.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KpO9Q/vfHL9m1e3KmEJXw52ZUgIiOEO/0DTk0TCdiI8TqzT1ShbWXoLHfR+aa8YS/O6K5Pmo5AM4w8hO2t69xL97vkOg5U/mozjnejolm4M1GV6CfTC293ezDdqVzeCGIlRoSJq1TYtx6PYpSapNF9hLkcqNrQLvjbSB+oEWnF0REPcsepvm5gAkn2kMAWN5ALvq+7179jnD+dVlODwAYYAwhh0UUIRoVHKANxfnXM3V4U12d0Z0ZbdlcnCiRu0rWQ2lHK5F4BZczbPZQLTT3YitvifIJ+oK0/uUbNbX9XixZkWkU+YbH1yZvy4Sp9UXwFWpRA3zfvqKKtOASaORoFzD9BmwsixP/iyGFpPovermsBRa/ugv9ehpbDrS+0Eg1lVQIKBmuG6LN0QZ/is0r60UXhSr6zNSTLmTsWB3umGvhipxRRkwMkoCmVaiKxYdyuCL9OgBldbT48R2Pk7hyOpZYLrVouHPAbMxYkLA29MK3zBDRUJb5JpyKF9j0hrDlpKI7VbhIHsY4bduq5W1/bp2Dh70roXi+ypWom6Vzuq/QVaaTR749wzF5kc4OgK95oa1wvae+W9rnuEicFmPO6s9rVcXvt193Q8jWijXpeGWR7cZaDy+HgI/+QcH7oiCic0SKbMVcl9swoxna8iVqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2966.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(39860400002)(346002)(366004)(8676002)(8936002)(55016002)(66946007)(86362001)(26005)(4326008)(1076003)(6916009)(38100700002)(38350700002)(7416002)(2906002)(5660300002)(66556008)(54906003)(52116002)(66476007)(316002)(478600001)(83380400001)(956004)(2616005)(7696005)(186003)(8886007)(16526019)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?rvPq0n5yTPV4eZua0e0zSKwnlgZmtVZGeEknU0MTDsIvk5VpF3PXsXbalPUt?=
 =?us-ascii?Q?Wt0JSa7HH00i6gR4qzU2lzuV8fxfkMz/fGhnw9Zqs5Z3nQTxa5HWIKNZHhZs?=
 =?us-ascii?Q?1rtTi74iMOafZECMK55/2fFyAQG17+L++/80bBzvHxHoHX9sa0dd9MP4WXle?=
 =?us-ascii?Q?rTHnvWs+siYw8y9Tz1rg96DnnaOfHViHQutY3DLONHnYDXepYGNatteYLlu3?=
 =?us-ascii?Q?37xc9DtGel5/4j2LY7KbbM239J/BoEWgmCycuk63XP/waXqH9Af+O7X/VOVN?=
 =?us-ascii?Q?We9tj2VYnFbnfNzeggQGIgo0kLtsUQp9EySAd5plWDNBPtV9vZNYrEbUsmAl?=
 =?us-ascii?Q?+rwiw+o3k9Pxg245/HlIK1seGvj0NnMHehPornuBZegthdv7HUMfaXd/UOUu?=
 =?us-ascii?Q?1qYxa3wLl8d5eCuVDdte2qh2mu5gXgxBSsZaImMgT1aijqbfr0/WRFVcDKNC?=
 =?us-ascii?Q?RMSEhfYA4uM9sILKI7O5XQ60lFqX/nTXGchP1vzJzaZ7FqVFJ14Sag1mT1h6?=
 =?us-ascii?Q?E0oDaH9hUytNbpK0qRUfotCpF2szsOqZNarmT8lq2wehlB2EJs9sMV3MxZdP?=
 =?us-ascii?Q?OsMkzPKAqPUU2jQ/qs2n/hweZopoDTvRcCP2h0pVbq3Lr0oZbG00EHlEWrej?=
 =?us-ascii?Q?5u9usBxCDOqZ9cX5hmoybSDrTs1OVBHiF9RQHopZoQBwaegzOPvPDEo0X9PE?=
 =?us-ascii?Q?3VC6qm32WJjnLD/rxsGaLk8Xyup9kJsnpkfVYUn78n2fcSqwocyMqf4BNeLA?=
 =?us-ascii?Q?BXnSIJdjHfo1HAPgjcovOFjoYAyizLhHFtz7mzeSFvj7EZwoqinPJBIRuwyt?=
 =?us-ascii?Q?+Iz6cbBkCwcyZ7/ic7ShG1dJGcww+yAAsGZq7sX7Lsay+bX9Xgwcvz2pHAvl?=
 =?us-ascii?Q?oU6s4DCMpolIFYYnOiERra3GOxcPwZnmBaXymqF6wP+IFgahHtGJf1uudUxi?=
 =?us-ascii?Q?e3MGsCZx/s+K17Sldr/Zy1FqSQ2Bif+10BmnBZuv9FjgUDWS3XBqW97LO52m?=
 =?us-ascii?Q?t3aTIRrnLtOh2sWxzCZT5cExFEPKY3qWcIv4436Yl0bJsf+PwnAT40H66Ugt?=
 =?us-ascii?Q?R115TQS98EZ5qKVLQf1i5m31gRhljn8cIUAeqRnjyQNAwg69FS4KXcLuxhnh?=
 =?us-ascii?Q?VU9xJmSK+c8Rf5fItss7UIYjoArXIrNoHql86BcdO+kKky3Z2rosOZM8RZxI?=
 =?us-ascii?Q?nk751wSks0JXpIDdADNLJqqHL99BX0fXBJVuftpzT4CrqI0aphlbL7bDW09X?=
 =?us-ascii?Q?UhpqbfCXt0nlT1me/U3VZcPV1ptgfijaWcJn3MclUh7Nq9aVKyhkD+XwHY6m?=
 =?us-ascii?Q?HEd0Rjrqt7eoPM0vY/nPSi+h?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f548e45-fccd-45b2-e230-08d91719d1fc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2966.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 20:49:51.7996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ysSvPz/qh/JwOVVSeyxWXnNB0flEoMIudaLU2CzEtYE1DH6HQectET3d77qwc5399HNFuTrTDFp3JCwhnN/pDULyzS+cZxlKfdTV1ePAXbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2693
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9984 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105140166
X-Proofpoint-ORIG-GUID: LqHy2X15MqhuxdsAN_pLuUdCdrSe_Pz7
X-Proofpoint-GUID: LqHy2X15MqhuxdsAN_pLuUdCdrSe_Pz7
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9984 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 mlxscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105140165
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 12:02:05PM +0800, Huang, Ying wrote:
> Daniel Jordan <daniel.m.jordan@oracle.com> writes:
> > Yes, this does help, I didn't understand why smp_wmb stayed around in
> > the original post.
> >
> > I think the only access smp_store_release() orders is p->type.  Wouldn't
> > it be kinda inconsistent to only initialize that one field before
> > publishing when many others would be done at the end of
> > alloc_swap_info() after the fact?
> 
> In addition to p->type, *p is zeroed via kvzalloc().

So it is, good point.

> > p->type doesn't seem special.  For
> > instance, get_swap_page_of_type() touches si->lock soon after it calls
> > swap_type_to_swap_info(), so there could be a small window where there's
> > a non-NULL si with an uninitialized lock.
> 
> We usually check the state of swap_info_struct before other operations.
> For example, we check si->swap_map in swap_start().

Yes, we usually do.

> > It's not as if this is likely to be a problem in practice, it would just
> > make it harder to understand why smp_store_release is there.  Maybe all
> > we need is a WRITE_ONCE, or if it's really necessary for certain fields
> > to be set before publication then move them up and explain?
> 
> I think we have initialized all fields before publication :-).

Probably all the ones that matter in practice, yes :-)

Still feeling slightly uneasy about the theoretical p->lock, but that
was possible before this change too so it's out of scope.

A comment explaining the pairing and that we care mostly about the zero
init would be nice.
