Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282593BF9D9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 14:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbhGHMLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 08:11:32 -0400
Received: from mail-dm6nam08on2089.outbound.protection.outlook.com ([40.107.102.89]:11393
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231347AbhGHMLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 08:11:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7LBBTmDFSt+6i7Rmu2LyTNRo0AkbQualgjKUJWNt0VFeKZNiZdh7eRgCD27Fo6KQUNze02EmxSMn0hNHeQ3GsEyFLlgnOUz2MSdP5GmzfubNgaAOO1PTjbW4wsLMSKh3kN1zj5iZW8f/8XfTRga42bBNuYc8h/jRRB5EzSdsDWCOMETpI1y9oBb4S1kAPw/k6qan02tL0owyrX2JkEhxg43a71qEVkWsiHh6VGHOaWK6ZqSyagHL9ynB9Bggfp0yv8dNgIsvMaGf7jMGGpVA2+DyLGEWWSnGJLEuhELP7pfeGrqydeflh3kHqRzRaMQ4pQJPPVZE6hVvkNZEW8j1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41CQxsp/UHWlLzlJSobDTFCdsrn+Z0RHVOtc05xC8Ts=;
 b=GTq8Af+GqrdTD8/BV9SduepD9U019d/G/U4V4kmSJr+ibZtxelsA0oVGtkOv3apdcuXrEs9SsvfIS29rjnplFlYVQ77D3l5Avp5hscdyZuEE1TS7t0EmmVCIhQ8ZeGTpJ+UMhhV2WgEQUFy4uj42PN+0clW102T6n2eI3Hv9mVqyFEq3t4ocy4F/GNNO0TSjrwhR0V/kFyJAq2dHnV64ytb4SmFURD5DawgqrjZMjQM/RF5eyzSUMKBZi7m8pgJArbxfmQI65gJ10nvlIXdHjEpFQuLYMeye60bmeAz+DFHSwG+QpkKbN85m8H2hSbdTbeLxETMZtNB0O7WE2Vg1tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41CQxsp/UHWlLzlJSobDTFCdsrn+Z0RHVOtc05xC8Ts=;
 b=AWk8/T0i++61dCkXJTb9lTia6M5C+CiYFkdM434fgtoS+sHmpr3MdFcdas1JpYlZ1LcQ4xRNUP964unpwnIu6MT8E44WSU0+il0YPASbjpeWLESbgC6Gy/IWLUj4vP0OexFtu/Sqi2C6yqDVDvHLTCiltTJzHt7OkgoNb4LQ+f27ZKZ//A8eWv5CHw+WhfoviWFxGQHkOllc3xiv8siv6Uu8LlzvNpiF8PkHPo3A/tqYafJY8kn5pjgfubla3EX5muOVf19DsClOJvsDxCPSqbUn+2DpkZhSYg2NANfqTSbxb+frm0Lt5xs1IO25EfisRhcpmF/RLPopfAgCqBgzxQ==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5351.namprd12.prod.outlook.com (2603:10b6:208:317::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Thu, 8 Jul
 2021 12:08:47 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%4]) with mapi id 15.20.4308.021; Thu, 8 Jul 2021
 12:08:47 +0000
Date:   Thu, 8 Jul 2021 09:08:46 -0300
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
Message-ID: <20210708120846.GD4459@nvidia.com>
References: <bd509e3d-f59d-1200-44ce-93cf9132bd8c@intel.com>
 <87k0m2qzgz.ffs@nanos.tec.linutronix.de>
 <20210707221216.GA56594@otc-nc-03>
 <20210707235822.GB4459@nvidia.com>
 <20210708003335.GC56594@otc-nc-03>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708003335.GC56594@otc-nc-03>
X-ClientProxiedBy: BL0PR1501CA0012.namprd15.prod.outlook.com
 (2603:10b6:207:17::25) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR1501CA0012.namprd15.prod.outlook.com (2603:10b6:207:17::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Thu, 8 Jul 2021 12:08:47 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m1Spi-006FaI-Cl; Thu, 08 Jul 2021 09:08:46 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cb2f25b-f2e0-4fb2-6456-08d9420923bf
X-MS-TrafficTypeDiagnostic: BL1PR12MB5351:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5351F3DAA1006C682D9559F1C2199@BL1PR12MB5351.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6FOmqo5Xq1LFCpiGqfNXmevKZPYbYPqjofN4Ku6UWG55vvzvOUiCYi5moEMLNdko6HJEDbmMDMgSLBxfbhs1XUbclXA/+VC0FLxsay2IeWD85bBeNpUZtHE0T7HPSOQ1CzzafKcsy7WfskiMG55I4R8lwF9k++tOGhaaoeyFMt1NvWjEUP3bYHNO1hCVG+rWPzkdrgE1jF39UVrFD9RTB/LY7Sf1/IVeYVljhHVCpD4pAB4vFlJR5tI1lIZsBVSWfcvp6Jw/ZocqS0Toc4izA5PNJ+IhrKjg0ILjJGjQnfDfPHT1WCNZmu4s4fGnUXtaASEoQYjVQAXZH7nPEUG0LYRSpHHd4czE5gYZ3+/8HhUZJolCR23QbMAkj3lJPeDO3bhvG4rHMMb/nZqAHU0i7vnJ0A+KBeOothmVj+YUEzpQNGbrX5YAifojxuhVF8Zp+BDj+WjZzEX+4QaR+WjPD2vDlseHCAdZ5Bnz46d+v1pyBoIJ8FK7xKhOlpzfMNFH9suUEQ8ObpQ/Eb/RwUcd7KKYU2rlv/2oN+EG5HyHSPeZTDlSOnj3T4Hfqn0gJD+s5McIdIYWBFbI54yljeCKhc5rtKVEtuWahKjv4iBVEI95qOU89UrJ+3pkVh/VgY3kpY4BWZdPTJtvFiD1Ifjy6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(8936002)(9786002)(33656002)(7416002)(66556008)(66476007)(54906003)(8676002)(316002)(66946007)(83380400001)(9746002)(6916009)(36756003)(26005)(38100700002)(4326008)(478600001)(186003)(86362001)(2906002)(5660300002)(1076003)(426003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wqfi8XBRyCNM+DscLZ0bFkAcdfqGnoOlHAZHxSx7N3uyEcnB6XOzXBi+bnG2?=
 =?us-ascii?Q?yWqT+AAqWjubrXi5frER9Fqm/l/I2JKcYU85+e8l0hlyOE88610fXcd0/0mR?=
 =?us-ascii?Q?25w7ZqyMiHod+yIDcsLQFl+TjvfNyK1BmHl4nFyRYI6cHffLalTwunjvobpM?=
 =?us-ascii?Q?lVoU8QRmiuEkeUMjl6wS4z1zbmssKnFmOjEutW3IiedbzGVWQ7znb8vhI54q?=
 =?us-ascii?Q?hwpM9H9C5q2tkOnVckmN1uAdW65eMh3uJ0Qpl+Z+iKaEkv/6jwmemSlP3f0U?=
 =?us-ascii?Q?VFtSaQYCVKV/wYHRn4TJe7NBBH5lnscRUYjN73baJg1yVXF+Bm/bXW411Mrl?=
 =?us-ascii?Q?yW/uKcW+hc5lJl8z7ABEB8w3R3JrgeG/cw2Nyk/1et5HOEMvXe53iF9Zp4lT?=
 =?us-ascii?Q?AlQUD0JcfFcqY7RxPXN9vpNRvftS2NijDx/f83pojv3TsLaJ1aW0PnHgkOME?=
 =?us-ascii?Q?VaMagVzPTPVnaY4sxpO9Xa/2eXHv1AMxFtM6yvIP10mCfgYvZGOwfpOJTykp?=
 =?us-ascii?Q?K8POtDwmNT7hvCA1k5v1uIIPbf1cgDrG/WgUzYtFM7WeSOKM24mQ7F2Oq3f3?=
 =?us-ascii?Q?tZLDCGg2yXUzugCAmBvy9k9ZcM1gAWeHpWLw4Z13oXbFn+QtQcf5wwPlS38D?=
 =?us-ascii?Q?xKNfpPUV2pDrTlyATpNB2wHUwRh4R0q0zuzdfsK6WGryb3f0m9y/+HXgfaE9?=
 =?us-ascii?Q?harAhkmV/yOoMP7yB2Xy9DHCF5tFWJk13a2QcKR8BQiGvReIQ1E7YLC1SY6Q?=
 =?us-ascii?Q?JiS+mdGNzL6hWI9hENnu/pVZUx6TbzRokCYEmMQaTAcm4VdeGH7xr7OyV/RO?=
 =?us-ascii?Q?85w3E19z9zUGCfEYSLDCkspzbLBln1KaIlWuRYoLpzwRAp4B6p6E+QQLlKC+?=
 =?us-ascii?Q?MRCZs1qoZAWksVzS3i/1uKd41EY0INwtUX+Qk75k5gQqllrNDK9usRM+gh7z?=
 =?us-ascii?Q?GJPrvc3zKpUKqwbnYW8kOrIdDQHiiO2ulNqYvaqyFnuEhkKVpg5ZXqVxG7J6?=
 =?us-ascii?Q?ZbCR9/msK2W7wNhzvF3czZZCpWNYX59Jz0zIIT2c0t/OwzIiZQpnVO3SE3Q+?=
 =?us-ascii?Q?r1+50c9Br26keOE5PJvaWoQ+nM+cx7svuT/hmXlb1Fp2iNuweuycWT6UVAjZ?=
 =?us-ascii?Q?iM8n9StcTAiPUVWvARyx/UHWMDC1B7RJB525DOU/52tYu5KXOCwprKQPgSos?=
 =?us-ascii?Q?ByjZBIT0GvYSyGNVEFRi7RYiguFNoJYWaFDmU97T/tjI8z8SJ2VnoYd6yzxz?=
 =?us-ascii?Q?7WugT7uZbxUdGGkxA99vd01r4JfJlG/LaaS2WRnwm/VcxsLlGXhLMUB+HV6V?=
 =?us-ascii?Q?i/M1tNVRt/dBWJ9BoZy/9/zi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb2f25b-f2e0-4fb2-6456-08d9420923bf
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2021 12:08:47.4009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YLJEPTVR+auwbDsjjuFUtgSOaLhUfO4VvJS4uhlAem6TuXVgigxwLJCLmFVj2TqI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5351
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2021 at 05:33:35PM -0700, Raj, Ashok wrote:
> On Wed, Jul 07, 2021 at 08:58:22PM -0300, Jason Gunthorpe wrote:
> > On Wed, Jul 07, 2021 at 03:12:16PM -0700, Raj, Ashok wrote:
> > > Hi Thomas
> > > 
> > > On Wed, Jul 07, 2021 at 10:50:52AM +0200, Thomas Gleixner wrote:
> > > > Megha,
> > > > 
> > > > On Wed, Jul 07 2021 at 09:49, Megha Dey wrote:
> > > > > Per your suggestions during the last meeting, we wanted to confirm the 
> > > > > sequence to program the PASID into the IMS entries:
> > > > >
> > > > > 1. Add a PASID member to struct msi_desc (Add as part of a union. Other 
> > > > > source-id's such as Jason's vm-id can be added to it)
> > > > 
> > > > Yes. Though we also discussed storing the default PASID in struct device
> > > > to begin with which is then copied to the msi_desc entries during
> > > > allocation.
> > > 
> > > Using default PASID in struct device will work for sub-devices until the
> > > guest needs to enable ENQCMD support. Since the guest kernel can ask for an
> > > interrupt by specifying something in the descriptor submitted via ENQCMD.
> > > Using the PASID in struct device won't be sufficient.
> > 
> > Could you could store a pasid table in the struct device and index it
> > by vector?
> 
> Possibly... what ever Thomas things is clean. The device specific driver
> would have this already. So providing some call to get this filled in vs
> storing that in struct device. Someone close at heart to the driver model
> is best to comment :-)
> 
> IMS core owns the format of the entries right now vs device specific driver. 
> I suppose your use case requiring a vm_id might have a different format. 
> So this is yet another one the core needs to learn and adapt?

All entry format stuff is device specific, it shouldn't be in "core"
code.

It is is the same reason that the IRQ chip driver for IDXD should have
IDXD in the name, it is not a generic "IMS core" thing.

The question mark is probably the locking model, but if IDXD
guarentees the pasid table doesn't change while the irq is active then
maybe it works out well enough.

Associating a void * with the irq is also possibly reasonable, I'm not
sure which path makes the most sense.

Jason
