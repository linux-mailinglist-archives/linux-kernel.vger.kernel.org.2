Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E61B3F29FF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 12:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238646AbhHTKTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 06:19:05 -0400
Received: from mail-dm6nam12on2047.outbound.protection.outlook.com ([40.107.243.47]:60192
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232572AbhHTKTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 06:19:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMo8oi5P6owDyyuiwF/E1zc8QBXc2idrQWjAZ154wcsuiH4Ein9qvrfAEKw4o8z4iKumjOvqkyCVe3ZnJUuPKEGRyElv3WzEY+OmPXuCagxW5u2nTBIz7R6WmbdqMOfFvOQ+sLDhOve3VBwF2oU4G9EUR+bm532ozAEdU9UboPXT1D6wAka1bSpfHOjM4zT7jhSHEBcZosIEO6Vy8KZIy/alm5h1GEwqR0bxxA+hGbINWM0B+1qTFLBUERsxGfOxXmL4g2z/RaTK3g5xgKIFDqjzZwoyix+Zd//iYkWr4O11XhSBeIRi0TdWU8UrPgrmS+PpqBqMWIF0cW7Dyenqxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Dal6PWzCLrjFKGS9SP1Xp1+3xetGaSXkQQihZGTCJ0=;
 b=QOMDetWgdeaNfu2Q47eSUs4wSkYyFcgEeME7o3rEeMvVbDp7figHM6M6vNZ3RhyK7Z/9S59BkfQ9SHy/DoPz6t0IkExWQOMjDXoBcV2SF7VZttX4IzFH/WI0gNOdIwUfiyMnuvxt/2+ul/JtnMuT9uGGmEGCAGPgGVvEaNPq0B/ieVUiNSNF2i2Z27wMwzKfHDiYTGW5w9qui5JP25Oct/K0G2efiXD9WIcMdyWBcAdPCO0u+ANuMh2EoQteyqSKUq5/WkqES1zH2oyVepGe705BdIz0hIM66hxOj4+GTEDI9Kt+T2oWfWo17m3hAnbWqIF75IzaoTfULGHZJeM0nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Dal6PWzCLrjFKGS9SP1Xp1+3xetGaSXkQQihZGTCJ0=;
 b=g+FFtwqtvJPokkWjRUG0R1VDfjVbiHyDgpqaVNJ9Eof/Csd73ppyKyII1Vr6zJrbcqBI7nmc0k+oZXx/YkRvMPSAxhXKBFOx2HnGBcJ7pIhIGkYH5a2oAbR89LaEsGxn3B+BbIYndbxDVKkN1XA1m6Xzzfp082wQe6c6Z67xjWQ=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=synaptics.com;
Received: from BL1PR03MB6055.namprd03.prod.outlook.com (2603:10b6:208:31b::6)
 by BL0PR03MB4289.namprd03.prod.outlook.com (2603:10b6:208:6c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.22; Fri, 20 Aug
 2021 10:18:26 +0000
Received: from BL1PR03MB6055.namprd03.prod.outlook.com
 ([fe80::5c54:a202:1128:1c8a]) by BL1PR03MB6055.namprd03.prod.outlook.com
 ([fe80::5c54:a202:1128:1c8a%6]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 10:18:25 +0000
Date:   Fri, 20 Aug 2021 18:18:14 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] timer: Use static_branch_likely() for
 timers_nohz_active
Message-ID: <20210820181814.2761b051@xhacker.debian>
In-Reply-To: <87im0dqohb.ffs@tglx>
References: <20210624163218.39ae3ec6@xhacker.debian>
        <87im0dqohb.ffs@tglx>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0362.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::7) To BL1PR03MB6055.namprd03.prod.outlook.com
 (2603:10b6:208:31b::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by SJ0PR03CA0362.namprd03.prod.outlook.com (2603:10b6:a03:3a1::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 10:18:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ca624c6-7ef0-4528-324f-08d963c3d896
X-MS-TrafficTypeDiagnostic: BL0PR03MB4289:
X-Microsoft-Antispam-PRVS: <BL0PR03MB42898F44ED57D9E9DEA8511DEDC19@BL0PR03MB4289.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B5ingbytSKUIce0Qo9cInK7tSC6XXqqYvZPZlBwj10FMDNWgtBMns1pXofDoeEKasxpDhkl8oJYSstLdrSkHjeUwX+OLLPvrcZBgqlxAdCZT0vpKERFr8Kzp28RkOyIvCPuNYLsqH2Yze/sYNp70FI0LERLrdNx2sKyDPUTGdrwvjhorxST862+fBPqxtOtDQLa668TKuGAV4a/TzbPQoBZn+eo4wCqql5fnw2Sy8huUgiEYgcbGuoxHEOYJTyVciLJbsY857kTItvHZgtDdS/IKVBjN4XrHT0zRtuqhLnXi59LEtFW4ZKDZ4JBSpgslhPvTb+TrTdy8CbCuRpWpvWEqXtzboN9/CZGBfh1fws425Ux/4zsvgOhN7VOa0zbsaJPaZD17J2SooeAQlwd5GACmO+pozuAl3cUiDY39N5x3EHSBM+vQREvsq2t++oOEE5F0aibJzWWDaKXh0dHPIQkoDoqJMnfKpoabj2nurPSS5jo4hBczb4ffkkxNq+RTaEb629ozkhgJfhausFpPm4Xv9qE4i1T+iw0kIFBBPEorX4xgt1cU8HLJpLLT2WjTP1EW3x11Xr8yfbln6LhbjCb16VFlcoWw1thlyZgcWEVOpVW4DZpOKWXyMIYs+MF+hRz3sWg+1+nN3ZmyddUa1DAVRVJMSZDmvyZE/cT5mJ0k+BWiqiIw6VZocQtUOKHY1CAntiAGHWBXl5PEKVH9AA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6055.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(39850400004)(346002)(366004)(956004)(9686003)(54906003)(5660300002)(316002)(6666004)(86362001)(66946007)(38100700002)(4326008)(7696005)(478600001)(66476007)(8676002)(52116002)(8936002)(6506007)(4744005)(38350700002)(66556008)(83380400001)(26005)(1076003)(55016002)(186003)(2906002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Si5eISsPCy4kKVi61yvMOxBqchVmZp5N1y9sTc+DvNy9c9cabO6JTj2CxO8G?=
 =?us-ascii?Q?J52AOvIWmXwS3p/nQ4pPe7N3OSfxkme3NEg3V7d/7Jt3C0YrMv8OgdZwj4sQ?=
 =?us-ascii?Q?hAR4WwJfzHXPi7kNvyIKTbbDB8b99y9e4AHLYJ+oyawJfk0k1dzQj9MtAW1Z?=
 =?us-ascii?Q?sMlHOYC+XSzpvIQ5QhiaRjSmVC17o6hFNRcb8z1c7J4xY3RF3HFI97j5JJ+M?=
 =?us-ascii?Q?M0bnRRMtQE5ffCb66N3/wNVK0jKNS1TPjjgZQjxRhcNMQtPRvl3Kmr2vmC77?=
 =?us-ascii?Q?fF9G2dc6oo2y/8aYqHG9YTk+9E3KBdC+VjUTQFcrq2Du8q1D2KATktcHYUA2?=
 =?us-ascii?Q?nSmyTjArmU5GQQWikd6PaPB2hqNMxePFIoGgH8VW/xhPmS8jiliwdVZ4F+Ea?=
 =?us-ascii?Q?EJ5d8viD80AKiUi6RK3XOjNy4O0Bf7Jc/K+pHMC/igDel2QxoBn4G/sf8LwC?=
 =?us-ascii?Q?5tznoQFU2ovzEVNlfju3aGG9j8opS0HWJHGixROWDMbNJTaJlZA7Cxq16Ut4?=
 =?us-ascii?Q?oxDBYpxgCLkOBgxF8kCj2DXogODs3iBTCVXd2M6oelgXMjsPHjXpE++UL9Zp?=
 =?us-ascii?Q?wq07ZI2DTvErd977SeJ/zHwjCxMtw+fecFB/KizSUF+5qNxU5DOHV023iVBi?=
 =?us-ascii?Q?DCwp2BGvEbUgewJPqlO7RDQiEyZ/70r+Fcptt0NJiskAdcOWrFQ9SmG9vlVb?=
 =?us-ascii?Q?RdQo4bQfXWgfRVOVF+CvINdE8z5NP6zclABHUhl7ceh2XmxACJ2hRYtpL9zN?=
 =?us-ascii?Q?9Fa6fGFQ6x6ebda/EgcDvm0DJJgRLj6Z78WZMYth2NathrGxxUpAWKgjFcUF?=
 =?us-ascii?Q?8yjsALfJTSnXAS5BQw7DPW7Oe44qLwsgLPqDzUiCGn2fhjkSGwNEA79T2c7i?=
 =?us-ascii?Q?xpSGkXNtT1SkAz0F+REcFsD+mcSwqhAsmo2UaYSJ7jnK9b1b/ceLuyeW6hgq?=
 =?us-ascii?Q?r+854jv1sMtPc+FJI4gIteT6KGxXn8e+xnOeIx1FRNTs/bnkXUJW2A1zNJWF?=
 =?us-ascii?Q?3AdNd5S6FhJZdSCYH7DLvoatkyJQG9VaW3GEndNgYDYLPfjklzrV4eeQ14yD?=
 =?us-ascii?Q?q9lhP1dRdIiDyuHZgPPCppMU+zmC9AiQojhJb+f1ouajZA0axxrmDIomY2u2?=
 =?us-ascii?Q?q+dzzKRpm1t/mgPmBQRzYbbFqICK0JexynGgs6Uz3Lfd/IKMregPpE7sGkiX?=
 =?us-ascii?Q?7uku5B7nLlx5SjPM8M7NwbXGHCAkj06iESIarpmBkld6fxY3fVrkKYeTTYER?=
 =?us-ascii?Q?XqML1Zde1AJyRSdV751Yv+0fX45mPel0aj+9t3PcfwcAH2zzOB0/rWglgOmP?=
 =?us-ascii?Q?uPd1SgDegUt43XYL27WTn1va?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca624c6-7ef0-4528-324f-08d963c3d896
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6055.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 10:18:25.5579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LHISzLnm0iB+lcyadDY3dWPcuXe123zYzMjbgn2K+dVqfwQSbTzHWxWXy1SC/ruOtL37XlmF/Q33n3ECam05Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR03MB4289
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2021 18:00:16 +0200 Thomas Gleixner wrote:

> 
> 
> Jisheng,

Hi Thomas,

> 
> On Thu, Jun 24 2021 at 16:32, Jisheng Zhang wrote:
> 
> > The static key timers_nohz_active is likely to be true, so use
> > static_branch_likely() to reflect this fact.  
> 
> you still lack any justification for your statement that NOHZ active is
> likely.

This patch only affects NO_HZ_COMMON=y code path which is enabled if either
NO_HZ_IDLE or NO_HZ_FULL = y.
Per my understanding, when the system has oneshot tick device, NOHZ active
is likely true. After going through drivers/clocksource/*, I found there are
about 86 drivers, 69(occupies 80%) of which support CLOCK_EVT_FEAT_ONESHOT.
Then I browsed apic, hpet and xen timer source code in x86 directory, they
all support oneshot feature.

I'm not sure whether I misunderstood the code or not.

Thanks

> 
> It might be likely for your system, but is this true in general?
> 


