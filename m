Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7CE2426256
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 04:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbhJHCNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 22:13:34 -0400
Received: from mail-bn7nam10on2072.outbound.protection.outlook.com ([40.107.92.72]:16257
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229501AbhJHCNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 22:13:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCPO+grtrqlsgdZKvmy4WkHNOP/2xgB+95m7jpzlqQ9uGek+QXrUyhUMX8NJ8mQ74+QzDh0d5atZPn4orvqci6CY3k+CbViKvkB30auve2Tu3UPBR8MB4OuNezXxnfXfXoSP+2+lRzs3Gh3Mi6fLcHEktpD731LSGsAjRvY9sUFL9s9gG5rR73ZnHh8kUv76ruJZg9glEAEiZjhKOz5wUiRaGiqzmjCT+f0wCMhTJTfuMoeHnTE/lLWl536SfR1RzD3/kWGyyNAY7Mrv53/NQhy3tK+/YauBd9mW2QEkEwHXJ3nRLB4oKl+PP/ESWhGHR4tdFsisPyKc3UQ2SijDmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SuHnTW7vJEgNDNeTpOjyfFlpB2EV5iWwtV7Pd7N2wQA=;
 b=jl7V/V2kTnKX3V2Rf68YWBZ16M06dKEJhMwNBMNPMxQajoGO23/Z8uWZ8UCuR/y8peYq7rpVO3aO/cB3Rl1kPeFUquKf/K7qtLBwzoM5m6cf60pKkkpzfEfMys1EaBOSyiXrJ3OOb4TDXddB5BnMxoo96WB8n9DovGUODR2Khj8zb5YpJssKEB4mWn9/tRlkg8nXHtaIxCmXmLnF614QG9hQqf2MSm/esQTqNQW479hIV2n4pwLn+2oi/gVjbrJX8oDVoEHW5NDwY+UQn1+VSHnkBebVITXz6Kjwqo4dUnC4aYhgEZlNFvIiWvApF1m4TFOL3ltsvJFygHdGlWBxog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuHnTW7vJEgNDNeTpOjyfFlpB2EV5iWwtV7Pd7N2wQA=;
 b=LbehY1c0xr3Ru1sBd0PWgziDgxM6Ylo6qxE3v20E1rgZQCvWqhqAe2Ro2U5npMzhhtlus1ani7t6KnjJVImj2PMxXbQ1UBhAdLI67lSDkSZm8k5ZLhBugkF1vEIh6kittTKRlUIMoYLH1KPltWB2ISVAMRCQZ7gQ4x0mFUPDIOU=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN9PR03MB6058.namprd03.prod.outlook.com (2603:10b6:408:137::15)
 by BN9PR03MB6140.namprd03.prod.outlook.com (2603:10b6:408:11d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Fri, 8 Oct
 2021 02:11:36 +0000
Received: from BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::19a1:1a10:ff3b:be65]) by BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::19a1:1a10:ff3b:be65%6]) with mapi id 15.20.4587.020; Fri, 8 Oct 2021
 02:11:36 +0000
Date:   Fri, 8 Oct 2021 10:11:22 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/arm64: add memory layout with 4KB pages +
 VA39-bit
Message-ID: <20211008101122.398e2cb6@xhacker.debian>
In-Reply-To: <YV3ZfmSHHKSWfDQu@arm.com>
References: <20210930185026.1609f12e@xhacker.debian>
        <YV3ZfmSHHKSWfDQu@arm.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0012.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::25) To BN9PR03MB6058.namprd03.prod.outlook.com
 (2603:10b6:408:137::15)
MIME-Version: 1.0
Received: from xhacker.debian (192.147.44.204) by BYAPR02CA0012.namprd02.prod.outlook.com (2603:10b6:a02:ee::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 02:11:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bde3e164-45a5-422a-f5f3-08d98a00f4c7
X-MS-TrafficTypeDiagnostic: BN9PR03MB6140:
X-Microsoft-Antispam-PRVS: <BN9PR03MB6140FD642213C2E0EDA46595EDB29@BN9PR03MB6140.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y77x9GI2ANPeQnefKWJjD2hKKeWmwj7rWO36PwDevF/9mOzod7rA97siNqFTDZ5DKEEBxLEEd7oBm3+US4lHAHWjBC+ERF2PkYdH/zB6rQ57eNMle4hGJg+utq4e/dbUFdW/l48XV7RaZKufq9qYgXRXKcxsj3K/0r9xZGWi0RNqEO44Een/PgrHajsqLX3I6LqEbtln7Wlbxb0LhfVJMI1eAqS61qyzN/OOxW2+k7+HjVEXKOqrhEATv3nLp/oHhmZjRjnSPKSAf8k0Js8Mnscyfh9gsVBifxWx8ARe3lnNdVP1PNxh/6O9pTMoTvhlRY02orHlTkPSR3WuFSGu91QA86ckrNiHC9kKlOzw0XHm67xN+Kfc1xGdSTpcLYXNF68IXWEzTHJinUlWo040Nb83voLJW9aFJ+Fb9hBbJdE3IGfVlCfZDZ+aoGXQ7ilRX+RFxief+rRj7V7aB9JmxfGW1I2mbbmUgULCw0aFoMSHy66iN4uoNpmwg1OdwRFVyR4eKsA0bop6tYwHrkNGpiDBE25DsXIp2OCyyVsFIq9YJrPFlfzHjrb2RrAF4MSLawqRa/zJzPX8EswUPB0cKYkHLRfa8+VR5kJ76nEPjJAl7HnW9BQ+WxV0orvtNDGOlVvqkZ/skGPPJMT6ybQtKboqUO/ABrwQbn5SG9T3kmvT5/8RNJTnXLprefm2RwD0kWVY6jjkhJScBab4BjgowA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6058.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(52116002)(7696005)(6666004)(6506007)(66556008)(2906002)(316002)(54906003)(83380400001)(186003)(26005)(6916009)(8676002)(8936002)(5660300002)(38100700002)(38350700002)(9686003)(956004)(508600001)(55016002)(1076003)(66946007)(66476007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eF3LQTrALM7XNd1EjbrXLnUf6AMDAgddXWuslA11HFcm8GCu+MgJ4X1T26nk?=
 =?us-ascii?Q?G/aX0EzDdoaIdcL76BtIgKge2o7pumhYlfEeKkUhXLrxk/CEX84uA/vPvWCc?=
 =?us-ascii?Q?+5IENkPdSiqsJbP8lniFarKU4rA1KPEirS0fFfmwjRH/N9E+QL4s/5hsfyD6?=
 =?us-ascii?Q?fikEuhlGCg6bD0wmCc+Eo4UBuRCWSImAmZYO6GZ1zK2G71cCLmtKPkwEhRDY?=
 =?us-ascii?Q?dtI1RF6Z1hp4C4thJSHaTFfG8fPgG/vDE/AH8jEyIfoDqBOLCvoPpNgNDpgn?=
 =?us-ascii?Q?X9kNK+HAiBxSegHjWGeGR9KjMqoPHdC39KIZLf9IeAuC3n2mZE8DUTRXIG3k?=
 =?us-ascii?Q?fqFJs3dGbqHRZV/dBuXEfkSvfIQrjo1ipjF9myWaoPoOty9b5Msyybb0287c?=
 =?us-ascii?Q?2md0y0WAx+e+Wt+C2c09LuzFwOAzEcBBMn3TYIfFhthDeDAsWPWKiIIG50FZ?=
 =?us-ascii?Q?clJR3Xkvn/kzCArNmTuzMFt374+plJmvkyBZzD42UCyKxHyuAUGQ2uVO6Ozc?=
 =?us-ascii?Q?qcKTXCFJZIcEQZ3Xj3LHZMGXqDzsBWzZHJGAcyyIZgo8+xBMP8W5MybvP9Xj?=
 =?us-ascii?Q?weeRrkvBKuJTKFBTfnFsdlo++IKE/ACHXFxKzSSeAo5XwXFs8Ziu2hkTLccy?=
 =?us-ascii?Q?6kWrCcB1M1w+cb0dWK3t4PH7ffVtXU4Pi3TAe9AMg+f/AvbcuKe1r1m1uGxd?=
 =?us-ascii?Q?xRSs1sxbaS39vTlM3jH0M8ZSffIXI6x3ZYtD0us2+SPCr2dbO2qwdLhO4AXJ?=
 =?us-ascii?Q?eKtx3W9+1Eie4m3kkhHu3K9ufulqEdMQTsyhpq8fhZlxhdvvkG3WtSs6C7H2?=
 =?us-ascii?Q?e52Btn/RFAPbQm/PHTe0bDwwER3/Ky1HNRptxoQizWdHCLGfUaq8V7gw4Mei?=
 =?us-ascii?Q?MZjSDsUE+zyJcEhv+oy3ez4UlVvRU1r1pnhyfImtBVYkzNN2v669eo2SYGwC?=
 =?us-ascii?Q?drTxJhEkmgj9Spjj9nwlF2JVpSsfSYthk0NYrYGg5kaWfLSe0Kbjtazd2S0B?=
 =?us-ascii?Q?aQZV+SOk2CX/l8Ea/E1DB4PzmuTN+fqkFvOPGzgVsbvauwYQzo1iVVl5NyFq?=
 =?us-ascii?Q?XteBaY5WtV8+usZC7ygM8t1Hs4sFxdIEiIi/vsUOKvaC+fvZTUTmi6SCurlK?=
 =?us-ascii?Q?larzx82N0bsyoxuBrxPDuf//44Di8b1rYY+fjpaW1elDhjwhAVJLr88jXciS?=
 =?us-ascii?Q?BC2E++tZzNApNZTQUUf5ob5ExP0B/2dCovYHnnV36dimAg/KHzmTibX0rWOR?=
 =?us-ascii?Q?K5mrKgfZctS1kZeQPQZ2oYoqRo163786BTSe20DhDA9TbUHFvsqUVR1yFHuO?=
 =?us-ascii?Q?/C5NyZ0kYJvuASK+b9jfCLiV?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bde3e164-45a5-422a-f5f3-08d98a00f4c7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6058.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 02:11:36.2308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Of5W61qA5ahK8q5Hn1TygahhHsMhw0o2QOfAgvkBJEWxNe3vwP0nO9Ioim1eTXLzck0n81o8WB9KmrUWyg2qcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6140
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Oct 2021 18:14:38 +0100
Catalin Marinas <catalin.marinas@arm.com> wrote:


> 
> 
> On Thu, Sep 30, 2021 at 06:50:26PM +0800, Jisheng Zhang wrote:
> > The 4KB pages + 3 levels (39-bit) combination is also widely used in
> > arm64 world, add the memory layout description for this combination.
> >
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >  Documentation/arm64/memory.rst | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/Documentation/arm64/memory.rst b/Documentation/arm64/memory.rst
> > index 901cd094f4ec..d1745b570f0c 100644
> > --- a/Documentation/arm64/memory.rst
> > +++ b/Documentation/arm64/memory.rst
> > @@ -26,6 +26,23 @@ The swapper_pg_dir address is written to TTBR1 and never written to
> >  TTBR0.
> >
> >
> > +AArch64 Linux memory layout with 4KB pages + 3 levels (39-bit)::
> > +  Start                      End                     Size            Use
> > +  -----------------------------------------------------------------------
> > +  0000000000000000   0000007fffffffff         512GB          user
> > +  ffffff8000000000   ffffffbfffffffff         256GB          kernel logical memory map
> > + [ffffffb000000000   ffffffbfffffffff]         64GB          [kasan shadow region]
> > +  ffffffc000000000   ffffffc007ffffff         128MB          bpf jit region
> > +  ffffffc008000000   ffffffc00fffffff         128MB          modules
> > +  ffffffc010000000   fffffffdefffffff      253440MB          vmalloc
> > +  fffffffdf0000000   fffffffdfdffffff         224MB          fixed mappings (top down)
> > +  fffffffdfe000000   fffffffdfe7fffff           8MB          [guard region]
> > +  fffffffdfe800000   fffffffdff7fffff          16MB          PCI I/O space
> > +  fffffffdff800000   fffffffdffffffff           8MB          [guard region]
> > +  fffffffe00000000   ffffffffefffffff           4GB          vmemmap
> > +  ffffffff00000000   ffffffffffffffff           4GB          [guard region]  
> 
> I wouldn't bother maintaining these. There are other combinations that
> people may use. The 4KB + 48-bit VA is defconfig while 64KB + 52-bit was
> more interesting, so we thought it would be useful.

If kernel config file isn't based on the defconfig, the 4KB + 39bit VA is the
default option in Kconfig:

...
        prompt "Page size"
        default ARM64_4K_PAGES
        help
          Page size (translation granule) configuration.

...

choice
        prompt "Virtual address space size"
        default ARM64_VA_BITS_39 if ARM64_4K_PAGES
        default ARM64_VA_BITS_47 if ARM64_16K_PAGES
        default ARM64_VA_BITS_42 if ARM64_64K_PAGES
        help
          Allows choosing one of multiple possible virtual address


I believe this combination is widely used if 48bit VA isn't necessary. In
fact, I think the default android GKI image is built with 4KB + 39bit VA. This
is the reason why I added description for 4K + VA39 but leave other
combinations.

> 
> I'm more inclined to remove them altogether and maybe just add some
> high-level ascii art as per the log of commit f4693c2716b3 ("arm64: mm:
> extend linear region for 52-bit VA configurations").

The detailed memory layout is useful, for example, I can immediately know
which region the virtual address belongs to when checking kernel panic logs.
If changed to high level ascii, I need to do some calculation, sometimes I
need to check source code to get the value of some MACROS defitions.
