Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2C539AC6B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 23:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhFCVPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 17:15:12 -0400
Received: from mail-mw2nam12on2078.outbound.protection.outlook.com ([40.107.244.78]:40398
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229656AbhFCVPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 17:15:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SORuA18k75hszJj6FLvFtljXD5NdDIRBNYWLqWn1JZtS9cLB3oLL7pojg4NLNlaRmLsx+lj9x7TcFwsaoTAzjR/wxHE18Gb3Iso7mQXJAeHrtbS2R3d1UKRf/uG/WQqVwJFm6GD/lsvnIpvayVleE46+RLYs0IhnNY8NnV3+6bU+wK/dS/KtwZ/b0eAGYb1ecqNu26Q0OOaqFjVr50MNIc8gC0OKOvB3/Fnd7xFnM1kSJWAk0aQmI0QCE/Sf+HzgA1+32Ww1MOfIDTYXdHbS8Fp6O7JKytKvYKVvTvd36WjEfHO2lgxWRIspveK0cntbNfbozaewhPIB9MgK+ERL1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ct34TsEuTumNDUbbDsFbANUXgh5pPU9LpUGzDohTucg=;
 b=YHH8Ww4w9fEAsPqyVQaPhxX3PunqxaYzgbmIDpgUj+svKsHaGHaUCMgVmI9qklZBk/8Oit55it6YTLD+sM2jHP/1ELWOtJ6PKgaxa5e+746Qn1Ore4nT6kooo8OyxsyPzLKj8u/4Asq7qtLgcr1kGtODIPOtUFg7GvoX1RTkAKDj6hcDweV6x/53l18Yb3QmMDd3Oow2JQRDm2U2g9iBCagljMz1yxltXF37LF1q//KTJjyZMxbDhZkWiImk4u8Zdr6FXCTgLs51v4L82L32d3qUtBKf9nGPgKwwqNaxtt+1cdNCRTW1esSF7HkG/4sTj+vInh9ioaDuPx1WWJ4/Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ct34TsEuTumNDUbbDsFbANUXgh5pPU9LpUGzDohTucg=;
 b=qSRkibspbyEV8Umhn1qubKH3EVsWEsgjLfaKL685Yz468syLc291Ri4cD2qPEehqENdfZ4up1WALoHFgAU2UOCaYeBGPpm2hbDz12TG2NVQDRMPxZEG6jmIV/kwkbPKaFU001fGhGfCmINvgDvkAdiJeBXiaHF2QNz/zfUDNCdI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR1201MB0146.namprd12.prod.outlook.com (2603:10b6:405:59::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Thu, 3 Jun
 2021 21:13:22 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::453f:6e2a:468d:ad6e]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::453f:6e2a:468d:ad6e%5]) with mapi id 15.20.4173.030; Thu, 3 Jun 2021
 21:13:20 +0000
Date:   Thu, 3 Jun 2021 17:13:14 -0400
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     "Joshi, Mukul" <Mukul.Joshi@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Alex Deucher <alexdeucher@gmail.com>, x86-ml <x86@kernel.org>,
        "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Register bad page handler for Aldebaran
Message-ID: <20210603211255.GA1410@aus-x-yghannam.amd.com>
References: <YJxDIhGnZ5XdukiS@zn.tnic>
 <DM4PR12MB52631035F875B77974FA8D21EE519@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJz3CMBFFIDBzVwX@zn.tnic>
 <CADnq5_Or5maEWTZFzS6iksyoFC=q9=y=-YmPTdPuWRKFhdw0yg@mail.gmail.com>
 <YJ04D8a6LaVRMuGH@zn.tnic>
 <CADnq5_NQonmqtFDpfsWygGzA2kv-W-daDSkxkY2ALf9a1eby9g@mail.gmail.com>
 <YJ0+YbwSpxTrghpo@zn.tnic>
 <DM4PR12MB5263A7ABC342C37CE6891707EE519@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJ4g1MagVNQOvyvj@zn.tnic>
 <DM4PR12MB5263BCFD05993959820430A5EE239@DM4PR12MB5263.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB5263BCFD05993959820430A5EE239@DM4PR12MB5263.namprd12.prod.outlook.com>
X-Originating-IP: [165.204.25.250]
X-ClientProxiedBy: BN6PR19CA0106.namprd19.prod.outlook.com
 (2603:10b6:404:a0::20) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN6PR19CA0106.namprd19.prod.outlook.com (2603:10b6:404:a0::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend Transport; Thu, 3 Jun 2021 21:13:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d48a5404-3129-48e1-b6dc-08d926d46a0b
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0146:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB014634D08F4EFA54384AA98DF83C9@BN6PR1201MB0146.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xnZSYhOE0h3Haf4o/phLznUh5E29tjnZwiLs38erQY3yIYkf6EvMWxVJk56w0ByF4VUWnzQ6SLlAiJfMuCV9+JKAJVZ80DJ9IXBLbpxBobxpE8d7UrK8luHF0PnJgW9s7kir4Irbbmv+9xM6FYqeCFQndmOMS6gY413oZZUJTBg4TPtZN6xEXWjlamJrtV/2d3KOBiHdyIS/UjwPX7E/9oBgQ0yWMegcSlMkQcQxTNBZ8N1cn+L+5//FQfvxbtXImBihJdfp6CoGabTssTFUrc301spoXa0u6GoFEpUyknHvNJBp7WkdrY1RND2KrEXJ6d61/tJUWnLPEi39DNIdvHWDWoyKWKi6JdocrHAOimRrPqU+w755520kZ7NXOYd/UfQtWdMPV+dq0ceZkicJttn+BxIbSZxM3zCikyVJOdnv0NkMyuWW18dHE0vx6aqqMbpe/YriF3oORDzyah7dxTQSWvUdhRh18BPJ6s/La15eX3gCChI5zzYZuaH5AmfZpEXJYB63e5O6MFdfMZxTpJDuVqd+cGLtlXmt3UiGzWBN1Hk5ooHv15L9fnNIhoEJKnl26ov3uaEraE43SwNdv4AWcPy1c4bqD8e/q3h8N00DioyQksiTUmlYUn53nypydrcUoqWTY4UBKddIREywuyMXnvrNu2Md+F7ONqGL9U4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(86362001)(66476007)(66556008)(66946007)(8676002)(33656002)(8936002)(52116002)(54906003)(2906002)(7696005)(316002)(6636002)(55016002)(38100700002)(38350700002)(478600001)(26005)(5660300002)(956004)(6666004)(44832011)(4326008)(16526019)(186003)(1076003)(6862004)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/qq55F37wUfSFIfYH9Gax57Arm5d0y4v48NZupcVeNZnmym1d/jCEiPLz6vk?=
 =?us-ascii?Q?R2XumEhePXA5wI7Pn2066TAGJ22bB+/+CuvOkJ2PAqWTYennVS/fPxGybyFF?=
 =?us-ascii?Q?aQTmLu7QZAzZtzB38qAshbLJ8YONp/4kTjsbrfZ2uf5m57Qxuor/yvmlkySX?=
 =?us-ascii?Q?7NyJ5mLYOIs04p20ZOX1ZOpbktS4LBjt8SChLYPKyjZ3vX/lx0nB8EXm93tx?=
 =?us-ascii?Q?y7vQGoGTX3UUsOntKN6oDFOsc6MhfpHmWS7rTyBzoGBR5OhgvmJGpVKxgFpy?=
 =?us-ascii?Q?pPG7gcUL8S7gph/FG4uBFoj9vF/EVz7WDpyQJsZvhtjtxWYEJRY3p7V9zm0J?=
 =?us-ascii?Q?gHZCmXTFuC5NPIxmyhMacPryjlnoG4EsF7suZdqzl9HRAzfhw4Gj7Zm9Vz+S?=
 =?us-ascii?Q?pqDpf0z+dK/5TWp5RDE5pfkT4lGDdWZLNE6scopRd4lidZ04yKLuFX53bl0X?=
 =?us-ascii?Q?XUu7vOkRObUi2Y9e/6i3IzSWKvEcp9FfQrktPWRhmlMMnvnWRzOGYRU5DHMk?=
 =?us-ascii?Q?rc577Ljpcu1zCS93XdcLBkQ73A2yxJV4H4pn9qWnMV0+3U1ZxK7s5OOCkbs2?=
 =?us-ascii?Q?rvMGJgU1HEXnw0GB/QFeSH5ciQv5hWB0CXKAzo//1PKT+AuLu7c/gHUQM7By?=
 =?us-ascii?Q?aB0wHljmOKUgaKpVe+d5XNjz8tZLld/FeSbGlS8dL/+gNyhyobNQrj+Vy5Ce?=
 =?us-ascii?Q?e0XuEaxuR47cDTnGpILnWQqadlJRMvwAdBFeSHQpl4Mtej21wBqjpI4+SCef?=
 =?us-ascii?Q?6ZbaghhlRATOMD5/9dOvrOlTHTV+LDNpNcYrQ6TTNCDAz1Bxmb8J2br4mCSL?=
 =?us-ascii?Q?3gzU2iYzkWBHVE8EeomTw3lr4VWFOld8HuBZZWzoZDpXiKi7yDk2z0RlY7ju?=
 =?us-ascii?Q?hbeay2SSDBF2KIaiWHEeLXWds3qsSVEWq9bxhX9C6iwZzfHixE5p9pgW9Zby?=
 =?us-ascii?Q?nX3zxJaWWEfmrIPGQ5JNFEWCwtid5Pk5TSWiWGhuF5D6XoeNzE8DE9hDDY+t?=
 =?us-ascii?Q?/gkzntr8cs82D4MqUFl4+1TgO+DaTNXQtcj4cbQvOuoxRUHsQbEJtlP1AWwf?=
 =?us-ascii?Q?Tdx+Sntl0Fn2pi0vvnRlyzx41Z+Hpnhl4BqiSe4gOhbdmtl+d/k94DZBoNkR?=
 =?us-ascii?Q?Drdo2YK3jhzoToJmRVBXadU/RSWUVtAN+pqX0pgeSymWoBYC7gV8FpNi2gs8?=
 =?us-ascii?Q?mPJewZstP8nmfuyegypuq9rk4U1EAq4JKl8QC8kVgfBhLlkviltC8gq+IH1y?=
 =?us-ascii?Q?pm8wyyKdA2ONSmUcD9kJ9upVSqTUVnP47s0/pJHCXo/Fzu1Yi4AvEfZ8DTR9?=
 =?us-ascii?Q?agafC0FrbcaVSHKKrrzBkPjC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d48a5404-3129-48e1-b6dc-08d926d46a0b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 21:13:20.6159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JpJ1UqrwPEhUKcsIu2mVCP2XHyZBnsQlzz8ASocGSqo04Pd0JEE6dyFmSAqc/yaz+B/ubRPMBNUwnSDZmqFZjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0146
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 03:54:27PM -0400, Joshi, Mukul wrote:
...
> > Is that the same deferred interrupt which calls
> > amd_deferred_error_interrupt() ?
> 
> Sorry picking this up after sometime. I thought I had replied to this email.
> Yes it is the same deferred interrupt which calls amd_deferred_error_interrupt().
>

Mukul,

Do you expect that the driver will need to mark pages with high
correctable error counts as bad? I think the hardware folks may want the
GPU memory errors to be handled more aggressively than CPU memory
errors. The specific threshold may change from product to product, so it
may make sense to hardcode this in the driver.

We have similar functionality in the Correctable Errors Collector. But
enterprise users may prefer a direct approach done in the driver (based
on the hardware experts' guidance) instead of configuring the kernel at
runtime.

So I think having a separate priority may make sense if some special
functionality, or combination of behaviors, is needed which don't fall
under any exisiting things. In this case, "special functionality" could
be that the GPU memory needs to be handled differently than CPU memory.

Another thing is that this behavior is similar to the NFIT behavior,
i.e. there's a memory error on an external device that needs to be
handled by the device's driver. So maybe we can rename MCE_PRIO_NFIT to
be generic (MCE_PRIO_EXTERNAL?) and use that? Multiple notifiers with
the same priority is okay, right?

Thanks,
Yazen
