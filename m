Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308AE31FC23
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 16:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhBSPim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 10:38:42 -0500
Received: from mail-eopbgr70077.outbound.protection.outlook.com ([40.107.7.77]:59025
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229571AbhBSPii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 10:38:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2rUj4OEMFK9xZdE7IYHEqkhy/EZkzCHBWf+SgW3oQs=;
 b=BMUTH9+GWeYKSTxnomajwRBh/bqdtaeHOsW+CxoUEK3a+FCd1JTNYpVAKwMKvj9MbUsQHcbCpUBF88k7eKo2KPYRZSqJn1m4Wr7QhMyBNdrqbrxT9NFGbzUs+FcxfxUUDVvYV8sUW5VErCRIpmpQm/u8+Tk4afE0Yeq6ccUA5wE=
Received: from DB9PR01CA0017.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::22) by DB9PR08MB6826.eurprd08.prod.outlook.com
 (2603:10a6:10:2ac::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.39; Fri, 19 Feb
 2021 15:37:48 +0000
Received: from DB5EUR03FT026.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:1d8:cafe::66) by DB9PR01CA0017.outlook.office365.com
 (2603:10a6:10:1d8::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Fri, 19 Feb 2021 15:37:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT026.mail.protection.outlook.com (10.152.20.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.27 via Frontend Transport; Fri, 19 Feb 2021 15:37:48 +0000
Received: ("Tessian outbound cae1e71cca86:v71"); Fri, 19 Feb 2021 15:37:48 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 37cab13a163c2566
X-CR-MTA-TID: 64aa7808
Received: from 5e2d9afe54cf.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id C1E25A1B-AA9A-4ECB-8727-6D799B6611B2.1;
        Fri, 19 Feb 2021 15:37:31 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 5e2d9afe54cf.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 19 Feb 2021 15:37:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGVBGuJOP6w+Jg58BgGi9PxUVwNDyJtqNInQkkpYJpY1u4TV0KRkg2Mvyy5CWuroIczoAzPouGRlT1oFq0xANquPV+3TSwl+5AH/K+QkkRWwJXwGQ5YwALoDUevbHJqVJbjyfvlPFSTENDonrmLf0OYw0XaBngUfzzc2Fxkd9tMBe8mQguww2ioo/hVfzPYrR8dzVDTim4oKIu8pDQ5r4KKHHKhXZgjhNnEHpeVmmywoKT2v4V9+aLz/iq47m/CjMKVBIyas2dISst+riroNYUELe8YAq+uK4PMZGZ7oDFibx74hwz4z/N6+5+tDnd71fmsEWop7zxw57NhSYak4+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2rUj4OEMFK9xZdE7IYHEqkhy/EZkzCHBWf+SgW3oQs=;
 b=FbTWg+w2GnZPklNefnWQ6VRVNom0dXTXTiPBtNukOsfAt6RJPSaTRhI3tYlez2T0pCWyck5oAB7SLm1wZBzypPjYUi/SAKS5Wf7XG+g42XXNcTDogi3JmvNF2z2zUX8LrFr9QcEqCEgpbgnzcobI0mwpy7pT0WcShhUFO0AkkRHNQqty2HWkbnLKaNvj80E6plEag6aR76Ej+pIMAQsYpiU/Eh0otacYZdDQFNXsaCb01F12omoCrtALKwCNwRKioQ+KM2glgzjNOXFiifPqq7F65Pa40K+lL8+npkNz1YMsRboCfDDlMfllQs1lizz4LHlUo6/BVcT0MzNJts1aMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2rUj4OEMFK9xZdE7IYHEqkhy/EZkzCHBWf+SgW3oQs=;
 b=BMUTH9+GWeYKSTxnomajwRBh/bqdtaeHOsW+CxoUEK3a+FCd1JTNYpVAKwMKvj9MbUsQHcbCpUBF88k7eKo2KPYRZSqJn1m4Wr7QhMyBNdrqbrxT9NFGbzUs+FcxfxUUDVvYV8sUW5VErCRIpmpQm/u8+Tk4afE0Yeq6ccUA5wE=
Authentication-Results-Original: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
Received: from DB8PR08MB5433.eurprd08.prod.outlook.com (2603:10a6:10:118::13)
 by DB9PR08MB6428.eurprd08.prod.outlook.com (2603:10a6:10:263::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.28; Fri, 19 Feb
 2021 15:37:28 +0000
Received: from DB8PR08MB5433.eurprd08.prod.outlook.com
 ([fe80::1cd8:27a0:a98f:29a3]) by DB8PR08MB5433.eurprd08.prod.outlook.com
 ([fe80::1cd8:27a0:a98f:29a3%8]) with mapi id 15.20.3846.039; Fri, 19 Feb 2021
 15:37:28 +0000
Date:   Fri, 19 Feb 2021 15:37:25 +0000
From:   Joey Gouly <joey.gouly@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, marcan@marcan.st, james.morse@arm.com,
        maz@kernel.org, tglx@linutronix.de, will@kernel.org, nd@arm.com
Subject: Re: [PATCH 8/8] arm64: irq: allow FIQs to be handled
Message-ID: <20210219153725.GA43917@e124191.cambridge.arm.com>
References: <20210219113904.41736-1-mark.rutland@arm.com>
 <20210219113904.41736-9-mark.rutland@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219113904.41736-9-mark.rutland@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [217.140.106.50]
X-ClientProxiedBy: LO4P123CA0190.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::15) To DB8PR08MB5433.eurprd08.prod.outlook.com
 (2603:10a6:10:118::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from e124191.cambridge.arm.com (217.140.106.50) by LO4P123CA0190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:1a4::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.38 via Frontend Transport; Fri, 19 Feb 2021 15:37:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e0ea12ba-ccbe-46cf-a958-08d8d4ec4fa4
X-MS-TrafficTypeDiagnostic: DB9PR08MB6428:|DB9PR08MB6826:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB9PR08MB6826BD46694FAB0B23CF2DA994849@DB9PR08MB6826.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 9rDFp4wg6uvUxfPSR83Fo5H3tUca4M0PkZeG+3Ta2JHbRbbhFpW1p/L8LHvD7gHUBuYIkQDscojFtE9zinRn80ciNPzzKlGIqeelMpamyDbCckGh2Id8A1ghcy5rgzLKGRIJ0IZDIN7iru7bPFm2/u/SVm+iBIgeQMlrVHyzipX2IGTeJ6x5ot08YFMF55Mfq/9SNmBlsNEAYIsHKdexLnuF5pMKS0P2R86t+j/Jbf3zazPX+/uHV+PyofEG50eG20xN9te0Awsu0pO54QWfbXhIfcJCoBsCutaYRhtzzRfW+vd6lNUPD8LNrW4suu5ah0f/dCPcq3vEngF+SBk3FY70eBEES+Tiept/D128h20OgCwU2RukvD/3Ta4qRXgRl9k7Pltt/JIIMEQAGg3r6VYYJDmF677sRqvcLGoPS5xhJ6SZkbwsTB3jBjTkDaqY3EeHuMbuwt30ovkBD8164Nbgb00s2f3pQO+54cy4heE3Um5l2cMFoXO8S88OALHdEgj1udzXYq5fVdc+B7iaJg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5433.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(26005)(8936002)(33656002)(5660300002)(55016002)(16526019)(186003)(6862004)(66556008)(478600001)(4326008)(66946007)(44832011)(86362001)(6636002)(66476007)(52116002)(8676002)(7696005)(956004)(1076003)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?y1vW+Qr+YdWfnD8cXMqRkA5JiMF7hXqRDf1anJHd8ooPNYSIIG0hC4g2ZhkC?=
 =?us-ascii?Q?5Xv++ZWnTH+EEkUozyqIlvbYsTC/+zKcOgSpoK2MV9sP0uevAvbz5pfN5dki?=
 =?us-ascii?Q?J+EDK8TAEGMeiPO3QnHmcMpthJAS6hCjcY+8LKycW6qf/WIah77HUFcaijmy?=
 =?us-ascii?Q?SS/osT5HKJ2IAZfaL1EtN/3kGRwC9Kmaj6BA9Q5b7zgS6rR3JAZFqfQsIDlb?=
 =?us-ascii?Q?OLTyjwOAJens87UxGeLIKMHoi0xDkjVxjAaejEbelARoWbeCacdA2kK2VOrv?=
 =?us-ascii?Q?KroeZ60TtZGEXf3O8gyrLuOLA1Paqg5dXKdQ0LjIJDXdZhT+AMPvwWqoH2RK?=
 =?us-ascii?Q?DRoynVzHiS1SVdLQTHmV1Ir5dtnosYsoHeqfmpfk3x5I8xSnNsMg1H7H/ApY?=
 =?us-ascii?Q?+bc+dPq2PVbt0+/SfotZczuY/uTRMqv4UipPxAaYyg3xBZ80cV8y35Kkq4X/?=
 =?us-ascii?Q?2OKymknFF7ubqcr/JOSMJaKSeGPJx+rG+xanvFlRNpr1zvIIacqdsyaDtnQd?=
 =?us-ascii?Q?C+XMKueuX0Xj2criPUPsVYRGnCEsubg6xqIdSxwXqWm+zPvMslKCl+0SHMbe?=
 =?us-ascii?Q?wrs6vpTbtfQpCgwqYtFQbC/RuWGJoIZ3sVrDl0qB9jIZ73ik2xY9FQ+ZW5Un?=
 =?us-ascii?Q?QCw48xo6LhwVWDNhn2DZSPu6TgrngS2ZGKUE2yOSr8C4SNuXMuonCBX8Qs8h?=
 =?us-ascii?Q?gm8e+5Q/z20/LzQuARBVGodlR5jz9afzz5/8riLRVsVegDuBhkp+M91wTLy/?=
 =?us-ascii?Q?WlttqCxs7+m0fcalg9ZWoMngD5uUqbNjuLy3F6/VVb9FkWZfxxTIbiU/UBd0?=
 =?us-ascii?Q?RdzL+l0nMCZ0yZDsTSIt0GMPC1GwH7UAC2rs3yaA8wKhdZDKxPFpw67bZUR/?=
 =?us-ascii?Q?4XUCMenAG8E4FyEouBeJcQeJHaaIV5V6TMTTXyAH5BzsJ2AT1tSqOSf1Xow9?=
 =?us-ascii?Q?DfOOyFzJl28bxEzLfwSv/TtAdJTlbdpmyFbUVegMVeFyfxRtOER04g8WE6YM?=
 =?us-ascii?Q?nQ8hDIJ2VOWElYp1eI+L7wXAsOnLBWWvUIWJ7KAlhPmOkSpbB/7kYIxUUz+C?=
 =?us-ascii?Q?R2riJ089ivbpfZZrEsTjxPp87ZSSvNRxwXqtph7VTvKR+R3D9yWGVpdm+/rR?=
 =?us-ascii?Q?k0RTAeU8F7cyU+ZTT/R+zMdlTB6k1ec/lTaMU084tHi0YOKPtRmd3nq2DOiA?=
 =?us-ascii?Q?1Ku+3CaluB+z0tr6AVCuyAKpCsc1QrxgDZVk0Ad3rpwqR9AUMynsMxebEnob?=
 =?us-ascii?Q?JhlSbKtklqMnSQCKDszyb7Kt2+r/AWEt5UuWvRaYbRQTtJ3EkHJfFbpr1Qp3?=
 =?us-ascii?Q?/WoMVHGd34WfK4lR6O1zm/Gd?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6428
Original-Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT026.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: e6e2500c-3d8f-4282-7eba-08d8d4ec4338
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3teG/291X13TATHIbefTtuFsqlsOY9ap8n3C0GsVvVTXe0TLnfLUE1cXfyqD3UbBKqXZNeqHDZ/TZYBk2wd71upXXyr1Hj6thVIrXm1a+a9s1ei929bEuP9hggOFvIrOybiUJG79FYdloTHTpy6kfoch37gtIkIntAo4l8cF/DKu6UlUZvuH2W2hQaHVRG22udugkQ6qPLQT6KjlxX3yVeHomTKTpkZ3k09rfwFoFPi9wnvd8gBCfVn4AB9x4EdKHqxkGSBYYJpmIlGCZRsySBY3NuER/RGxSmWj7K6tMbyFxA96T2KVzIhTya29OedT+H2fhaIl9GPWyDM6tuCvyU0sRxVdmpNrZOd+yLnABPABr9ln9NGv53pjVhFmn3gML5sq4L13nst/nXAEm2qJz/KGHkhwQCobOyKSbpzyanZRaxixRRQ0T1ECjCDu8hHa7Rwen/ktyLSGeMtz6MR9RmpSfytkv5KLtnlvh8t/8sJ7UmDfDWbOcoO6Of0dCku0kTb1dnv9G7p9MlrEMcTrCPgfRVZ3JK0D6G5nJCP42LhjhYMXh+hJXpsO74kWt0e9WaK1v95iYk0JJpxK7GC4s6P7adH54BNQIzi5YYqvtnp8XsjcSKXJQfHbJVbQt0ih+SkPD5iW6Fl4oolTLELjgw==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(39860400002)(346002)(36840700001)(46966006)(6636002)(956004)(82310400003)(1076003)(70206006)(33656002)(2906002)(36860700001)(6862004)(47076005)(8936002)(5660300002)(4326008)(86362001)(70586007)(44832011)(8676002)(316002)(7696005)(82740400003)(186003)(478600001)(55016002)(16526019)(356005)(26005)(336012)(81166007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 15:37:48.6416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ea12ba-ccbe-46cf-a958-08d8d4ec4fa4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT026.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6826
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Fri, Feb 19, 2021 at 11:39:04AM +0000, Mark Rutland wrote:
> On contemporary platforms we don't use FIQ, and treat any stray FIQ as a
> fatal event. However, some platforms have an interrupt controller wired
> to FIQ, and need to handle FIQ as part of regular operation.
> 

[...]

> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 0474cca9f1a9..a8290bd87a49 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -586,23 +586,23 @@ SYM_CODE_START(vectors)
>  
>  	kernel_ventry	1, sync				// Synchronous EL1h
>  	kernel_ventry	1, irq				// IRQ EL1h
> -	kernel_ventry	1, fiq_invalid			// FIQ EL1h
> +	kernel_ventry	1, fiq				// FIQ EL1h
>  	kernel_ventry	1, error			// Error EL1h
>  
>  	kernel_ventry	0, sync				// Synchronous 64-bit EL0
>  	kernel_ventry	0, irq				// IRQ 64-bit EL0
> -	kernel_ventry	0, fiq_invalid			// FIQ 64-bit EL0
> +	kernel_ventry	0, fiq				// FIQ 64-bit EL0
>  	kernel_ventry	0, error			// Error 64-bit EL0
>  
>  #ifdef CONFIG_COMPAT
>  	kernel_ventry	0, sync_compat, 32		// Synchronous 32-bit EL0
>  	kernel_ventry	0, irq_compat, 32		// IRQ 32-bit EL0
> -	kernel_ventry	0, fiq_invalid_compat, 32	// FIQ 32-bit EL0
> +	kernel_ventry	0, fiq_compat, 32		// FIQ 32-bit EL0
>  	kernel_ventry	0, error_compat, 32		// Error 32-bit EL0
>  #else
>  	kernel_ventry	0, sync_invalid, 32		// Synchronous 32-bit EL0
>  	kernel_ventry	0, irq_invalid, 32		// IRQ 32-bit EL0
> -	kernel_ventry	0, fiq_invalid, 32		// FIQ 32-bit EL0
> +	kernel_ventry	0, fiq, 32			// FIQ 32-bit EL0
>  	kernel_ventry	0, error_invalid, 32		// Error 32-bit EL0
>  #endif
>  SYM_CODE_END(vectors)

I believe you can now remove functions `el0_fiq_invalid` and `el0_fiq_invalid_compat`.
`el1_fiq_invalid` is still used by Synchronous EL1t, so can't be removed.

Thanks,
Joey
