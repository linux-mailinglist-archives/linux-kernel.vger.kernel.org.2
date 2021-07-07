Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269BF3BF2A4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 01:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhGHABH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 20:01:07 -0400
Received: from mail-bn8nam11on2060.outbound.protection.outlook.com ([40.107.236.60]:42593
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229519AbhGHABG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 20:01:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I79DSxAHkd97gJ5jnWE7cUrWvT5d6pMqzQeZMzDUe0eZBb2cztrZ46rhX+CGyI5bOZwjUhKvHdGAj4XwzQlZaPLz3NICl6bC5dy+IF36i/zniRkSMC9cx5UB2qOpk5Bb36ven14JuBuGZJpA/KuZyigtM1tCYg2EkiuTaLBqzM39ztP+hMp6adzup0WVY5NtrD5FnBGntoEE6fvw+vWldCrIdrEculEhJKoLN2euvjVrFdXMxmlV8AE2OKpRB843HtJH0xXJUwYoYzBiqVj6bw+me0c+4aVZHVJrdJOObKKqiLZ5TFnEFw+fYo9TsTQGhCtmZ6+DxEKEn5Pm5W9KCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzxBUB7TBtuToVaHwDushYXcCy+F+bATjUA1ZYqs/1E=;
 b=nzvMVjbapRF8tEyKRwEJiQ7Z/yoT+jh4X3FshAB2GNj/DyaCf6c5ON4t96two0HBKq7b+ipoBA054DzmIX8bnA4tpR6dj0UWe/m+J+LDy0HB5IQzUI/KNAMicuE9MlEZGyFtmQF8c74ykA2HvauIwIERO7JcwSZ4Rcuum9VAASnvPKe9c2h/hkpyoN/ZYIsGc+0IrW8bS3d0z9K5J+NpQrws62YD4Ghl7xv7A2i3ojr4HfGsNSWNQqBV0LRm/hSRlDBiJcD9YdQdvzM/+fp3ue0d8YI8NK5CHSoFBBF7lfuz5dwrja3aptRo7RvDoki4NOFBso7EDCgdRQ7P5TyCtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzxBUB7TBtuToVaHwDushYXcCy+F+bATjUA1ZYqs/1E=;
 b=aXtVc2i7KdkgwSlsy1cvBI7FsY6Dw3U1FdLkdmtgA8w0kPTu3OYEpBJKXmczu0TqzlYmV+xRpTZo4ES46ykWFBNnnV7J6Bu40GD2c963D8vRDEzD7jW4afsyqQeD/S06Hens97CdU4m1m1XY9k+oq3yfbeWWD6m6wD7tYZ6puE951Rij8kZmNSMXTJCK0kNSv348tRjNty99t8mLTTQTsoMiEIVEkpRndlVstfd+jpP91M+hxAtA3jwqYw9Lbz27ilmcbQr0aofXjpSnCg6GLDWX/MKyZmFHhoudn90Gpm+0johxHykeYyrovgK6WJyZmFDsjOf/g12Ip8SkH8RgdQ==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5047.namprd12.prod.outlook.com (2603:10b6:208:31a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Wed, 7 Jul
 2021 23:58:24 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%4]) with mapi id 15.20.4308.021; Wed, 7 Jul 2021
 23:58:24 +0000
Date:   Wed, 7 Jul 2021 20:58:22 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Raj, Ashok" <ashok.raj@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Dey, Megha" <megha.dey@intel.com>, linux-kernel@vger.kernel.org,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: Re: Programming PASID in IMS entries
Message-ID: <20210707235822.GB4459@nvidia.com>
References: <bd509e3d-f59d-1200-44ce-93cf9132bd8c@intel.com>
 <87k0m2qzgz.ffs@nanos.tec.linutronix.de>
 <20210707221216.GA56594@otc-nc-03>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707221216.GA56594@otc-nc-03>
X-ClientProxiedBy: BL0PR01CA0008.prod.exchangelabs.com (2603:10b6:208:71::21)
 To BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR01CA0008.prod.exchangelabs.com (2603:10b6:208:71::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 23:58:23 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m1HQs-00630c-U3; Wed, 07 Jul 2021 20:58:22 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39cc934f-7963-469d-adbb-08d941a31b11
X-MS-TrafficTypeDiagnostic: BL1PR12MB5047:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5047B9B972E6E8EB3545E21FC21A9@BL1PR12MB5047.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zttuY4OqIdWrsy7G5ByVs8D9KST87dUJzo3buDItrbJZ0DVVkUL0jVgSRfy5Usm5iSpg80QekSF3cwNiGBZRJ/2UgssgywS2VOTz0pPZ6wmpyKE4LkwJ7aBgxZrPSkchsrc/t/7Ki3554Lw6ISl5XZmXVXPWBgYeXkfHMhg7x2YXVzmd5GqwvRWsR2mLchnqm9nCTjuip+VdZHaMWJbhRQznj7imum8jIdjIQ/I7cLAtLpxKFr1ze4Jj4LOOYLBya/7D4YZXSi/fFhlKGTHk4lluEW2LJct296qCl9V1jSKdUHf3KgfHRXcGDmRv0GmxlafMvXBdkFW5UTL5p4fAeFC+HWdJLQIyAhkojwsHGp32LZkxQ+giDrdgqc1au4WlCUv6ZJwaOqIFvf5anO4DqAWsBzZDmsyc4pq1z5gMJqccUWump0Lr/EVekmY5vOPPnVccEFAHGYJGORNSWvHYDq5ZbV9Ocv1KmqAKFm+dw1zq44ScWIf81Iorbu5f5grBRUiHMyhAlpEA780JC1QpSCxt+pdUXVLIo+rIsaR/EAXXVyyqb1h3y3qgcsTY49U8rTzbMmy48xprDdoZ5AkR2++IniSM1vqysq2a4Mqv0NMLblgWV7f+GrHEPlDBMfThye1tHKMtOfLy61ORG9c3Tg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(38100700002)(186003)(8676002)(6916009)(9746002)(9786002)(4326008)(5660300002)(478600001)(83380400001)(33656002)(8936002)(316002)(66556008)(36756003)(66476007)(7416002)(2906002)(26005)(54906003)(2616005)(1076003)(66946007)(426003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zgu6w8IwMZK7f38zxA76iptdYPvyJ4kilJ5XRVL/128z6ZQdw/xgsiJT9muj?=
 =?us-ascii?Q?mw2fI/fMRwapDjQC7dMq/desZWbvPpaEQgYkc0J1qbv285RQvySySCzjgp2U?=
 =?us-ascii?Q?AB55OnlIcgBVM9js7vENIwCzy9Iw49fXVNr3/72HSOmQF/i1CABMmoLWhlir?=
 =?us-ascii?Q?Cxcn79926ntfSaSU9BsPtjdNcYOYo3Y36sortaQsBRyKoZGH2+sQcAv1JpNb?=
 =?us-ascii?Q?1D4hjZY4WAuilVB+S5qtf+uEqO5QxvMFh6DLTY7g4W7zbQWzKX492FAobN/A?=
 =?us-ascii?Q?G0+5xAo91T4Q9RtA2gylBTAxgafjdfN5ftpmzymC69P3TOKwI1K/dKg/iFsm?=
 =?us-ascii?Q?FxaCpjyBy2s810TtBWwuIFjNcOIOu9GZ3C96r/fVSt7oU6DOPIZ7klM84RuS?=
 =?us-ascii?Q?uG1+Bq7+8YF0HJaI6Yx/DEB3tnzVVji1ZRgB+ssF6avxBYEQCycxAyimmcSU?=
 =?us-ascii?Q?wcIvdfyJw2Pfzr2pn/daCE2O6F/R2y/zgxbUcxLpk48VPtcjpCVxv5uE/vYc?=
 =?us-ascii?Q?rjvTHuugLG0yiwXv5CZpnip4lgsbUlVdoMzDGxXDplwx6n8Q9lDUbJGvl+xp?=
 =?us-ascii?Q?hallQhkZxm4cxBY+RrEEEd/ChSPiPZH4HzS8w7hJCkNqaldU8euTdzhywUCE?=
 =?us-ascii?Q?WgvWeqRy5he7m9kpv8J6GM2U7wFDOMeNwF973+7hapLfX7GMBA3T6f+Bg2na?=
 =?us-ascii?Q?zmzL8vYd0jTh/6cSQxfwTxyRNFkPf8QrPi2chHY0xEx0IQXtPhQl3cri3hB3?=
 =?us-ascii?Q?fxICs3xas22BqioxpnxUM+Q7ED4mGPAyxxHlaHnp5F1mx8/nRq/bzomptQjB?=
 =?us-ascii?Q?uV+/5TTYyVHeVzWNPWDkvBXM+qpmbB9kodHDAj6gbzlggBIKkIFDt6UCIfPt?=
 =?us-ascii?Q?FdcMyBfZ2B1sP7PBuOgn859myEItIgiF+6knLDo7bS7iI7tBsBjb6+wmUt/o?=
 =?us-ascii?Q?6DdzqIF/E+OpF1BFsSciX+b/d2xX9IftqdciGB3SyUJ6HhrwhsHE6JTrO4M/?=
 =?us-ascii?Q?KgxOQL70fMwW9iIk6yCcFmwe/kXr1WRTsuCp6i6earf34lDPCkjeYJMZkg63?=
 =?us-ascii?Q?dkCcI3fFqI5qxAu6d3DjYpDS/41M77K+9rwc7NaCScMYdvit+crcQRC2noT/?=
 =?us-ascii?Q?sR+2yVcb8kRj33hgoiFNRSfAXZUH3v0Cm0h3z4IKVQX/GYKtHKISj3Exrxqx?=
 =?us-ascii?Q?laiPXdjyQjD9sCs2psDPz+VnYbXqNr2duKHOPKTympTnkVMzrdqxgfsxWM7p?=
 =?us-ascii?Q?iD2Jyg8VFj6ec+fmFcP3/Uydmxj+1MU8y2Z0fXuhAXqxTMhZ7D3Dshdoq/SV?=
 =?us-ascii?Q?MOXOGpMHR6DJGJP+xjqb8Q0x?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39cc934f-7963-469d-adbb-08d941a31b11
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 23:58:24.0169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T1SyvJ/kzoItQ9C21Db5IPtMzpZcEihECJ0/+C9fgoqwC5lgIdPvg65qcmf07JdE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5047
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2021 at 03:12:16PM -0700, Raj, Ashok wrote:
> Hi Thomas
> 
> On Wed, Jul 07, 2021 at 10:50:52AM +0200, Thomas Gleixner wrote:
> > Megha,
> > 
> > On Wed, Jul 07 2021 at 09:49, Megha Dey wrote:
> > > Per your suggestions during the last meeting, we wanted to confirm the 
> > > sequence to program the PASID into the IMS entries:
> > >
> > > 1. Add a PASID member to struct msi_desc (Add as part of a union. Other 
> > > source-id's such as Jason's vm-id can be added to it)
> > 
> > Yes. Though we also discussed storing the default PASID in struct device
> > to begin with which is then copied to the msi_desc entries during
> > allocation.
> 
> Using default PASID in struct device will work for sub-devices until the
> guest needs to enable ENQCMD support. Since the guest kernel can ask for an
> interrupt by specifying something in the descriptor submitted via ENQCMD.
> Using the PASID in struct device won't be sufficient.

Could you could store a pasid table in the struct device and index it
by vector?

Jason
