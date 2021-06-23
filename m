Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D1B3B1217
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 05:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhFWDTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 23:19:34 -0400
Received: from mail-bn8nam12on2083.outbound.protection.outlook.com ([40.107.237.83]:36448
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229890AbhFWDTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 23:19:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmTGJfq+R7Cc0Vk5NW6SulMYJBn+Qy22VePk+M/GK/C2zw4fwjw11+vbfmfGO7eXvYHKkAF8BcDxD+tjlzJQRv4BKR2N5KtKojgIKMRPehIuheO7cn4L+lih/x9befyAbXq7FO/mAsKcWzUaNpOmcqZ6u9MYmPVAHrWYYEAPLUkp62G5DuZSye+ZqbswCJMJnQIRnDuIUb2r/yW+W1RaTlX7/5UastRciVzmF4SjKFvcNCtEbVAIm9CJ1wzLiQKNBNo6eTBBmQCv2IzmVw92vB5Kw05f4IimgNfqB46oNsKLvYGskXPWGldmaQ9JK6wdqGpWNsN+5Kq/pNt2bGsMAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIKvgqOZUu3cFQmHnTj5QEI+L76MvOdoaMTTHCQ1Yyo=;
 b=JZjgc5N4ZO41/n+vL6w42q/EqnXIBd3NToh6uvRmFuW67bzDRjHl7YFBjOxJ2EMwwp81DyHmnmDGXsCKC159RKzzT44rCeB8M5H/eoqq2OR+J3BNWPE0c3dkfgpwso/I0mYiempT02j22H1YYAT0+a/wcUFBcupTFfOOy7f54PRqHaKjypqOueq8sI7xSrCr0SD3hsteLbwKXzfrc0aYyisoPq+7A5MLe45nCbEYpkKUAX6YPjfzZ8C30eGJjWooaUDO4Iuq8oBynnzKiiNwTCTSuOXTI9AQazu788ZbksJHpACMEobWaixgGRpB2ORFzW+YjZVqqAdX46tKkIwtkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIKvgqOZUu3cFQmHnTj5QEI+L76MvOdoaMTTHCQ1Yyo=;
 b=OQlLsYWPhuuq2r5nB8wH+ZMKe31Ah2RLQrq8YYWEiertTnFFSQC9pKx8ZXKiRvaleKvvYuiYRTYYp0+kEzMIqzzJ8oH7+/1NUHdGHnBwfuCl9izWkrX5dHPunhJRwYpJppKzCrK0ElkdGNbHrEqx15n45EreH0G/swGCHXqSjW0=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=synaptics.com;
Received: from BN9PR03MB6058.namprd03.prod.outlook.com (2603:10b6:408:137::15)
 by BN8PR03MB4595.namprd03.prod.outlook.com (2603:10b6:408:9c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Wed, 23 Jun
 2021 03:17:14 +0000
Received: from BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::502a:5487:b3ee:f61c]) by BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::502a:5487:b3ee:f61c%3]) with mapi id 15.20.4264.018; Wed, 23 Jun 2021
 03:17:14 +0000
Date:   Wed, 23 Jun 2021 11:17:01 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] timer: Use static_branch_likely() for
 timers_nohz_active
Message-ID: <20210623111701.0850fac3@xhacker.debian>
In-Reply-To: <87o8bydj0n.ffs@nanos.tec.linutronix.de>
References: <20210513143354.096c6baf@xhacker.debian>
        <87o8bydj0n.ffs@nanos.tec.linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BY3PR10CA0011.namprd10.prod.outlook.com
 (2603:10b6:a03:255::16) To BN9PR03MB6058.namprd03.prod.outlook.com
 (2603:10b6:408:137::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BY3PR10CA0011.namprd10.prod.outlook.com (2603:10b6:a03:255::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Wed, 23 Jun 2021 03:17:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d720eab-b58d-4ce4-39c2-08d935f56626
X-MS-TrafficTypeDiagnostic: BN8PR03MB4595:
X-Microsoft-Antispam-PRVS: <BN8PR03MB459541E6B11A46EC64A9A3C1ED089@BN8PR03MB4595.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cly8Igws68tVDbHRmdqGRA4bCIecVCkiElmcFtcvSneyvbrpvqcqjBfZQwh873M6Dfo9PxtBIORkpztkk0NF+Rg7jKDdJ9R8sgvF8CPL/ApspcLQ1832s3tRvl5qJm9+78LJHSQOJc93jrCnqYPYotiJydQjIdcmeuE2VdASL788K41qPRWA0JQDtkRQB4/YoC+Zt+LwZpcZ7ya19JYG8XrJR7TU5duipThtOAoXsM6F9HtGxPIF3ac7+ljNCllRIOMbE4utDtI8KYCukmnR6tbwhj6KlzC0e/N0MLkpHI+OMxytRg5zHgOhwm/xmn8lJ9ckUyhLTNB0Xyxrq7oJr0qeF2WepvTawpxvGw6M/BNytMfTYfbL2Or9oSeEh/UNKYcc6A/udBa+kwqeBSLW9E28x8TAVk6+ytNBoy/pCog9aUm3ce1DhlhipaEkydTj8o7YxIffYT4YVdwoQyahFQHYs3JTtlnMLQg0USqotCoU6RbXgNyzBskGeO0Az1EdyuTEplbwjaqz5FIA42pDCDbC+/y2ulsoxsGsiPO4QQrXOqUQqMa8kvV/EhhsChCwmA0OdBSb+zbj5jqKzq9+cWQFHf61drUaq5/0snYu5IEnh4x/y+6SgLOCylWuBHIr3HXEdet1hk36u+sUqwIRHHfmQb6wb9lVPd74mKUcqRY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6058.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(136003)(376002)(366004)(39850400004)(6916009)(38350700002)(54906003)(956004)(4326008)(316002)(1076003)(4744005)(66476007)(66946007)(8676002)(478600001)(16526019)(6666004)(8936002)(66556008)(55016002)(9686003)(38100700002)(6506007)(26005)(186003)(7696005)(86362001)(2906002)(5660300002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7EtJenMkAzYct3ZKjRkSiB0trH+Dersw473TSs2K+lAqdNqHf/lQjDd6VdiF?=
 =?us-ascii?Q?XmneR8Z9BgsWK21nt4GN6DIlEV6irC/B3Z7ERdMdZ8hXotSLPm3FfuuwhhU/?=
 =?us-ascii?Q?4QnKjChaIOJdwwqz6VkYd1yOV9+h10Gpl7m4guDEuDTOqvh/Qd4VrVV5YL7T?=
 =?us-ascii?Q?Fbx2muhRwsk+u50JCqzCy+/ya+XKYNAAZomnjBEIGuLojYERx9nRG17GtIEz?=
 =?us-ascii?Q?TtdCYCbLactqRXI+BLIorSBRhV5kxfmbjF7BQzQvsAJgQVgkXjjTAdSi+lHo?=
 =?us-ascii?Q?r7gkpzUH0UpaZks2YsZ/TABsjhY7PTGHEXTMLzmpLXjnbXabFhP54/3q1loV?=
 =?us-ascii?Q?ZXlrGHnSMOgILCWZXQ/l9fNjwcQ1xcYkfDWw5Ml7nNvj353Rnmx1gTLodPFe?=
 =?us-ascii?Q?93Ckg7+lRYxvq8+H/nHi/FMfF3G9es6j0xRXdhdzFNO42DdltxVXb7v/NgC/?=
 =?us-ascii?Q?M3bdwXYT2ft+REJf5NJ2cqjV9iEBEOfa5tTPuAxE8RpnMfyGtnamsgof4tgS?=
 =?us-ascii?Q?rlvIcpRmSZBVNY1ItyD4+rw5U/W3omXuoSNKW1CZAfiWsnkmYxtCm1sxGuIo?=
 =?us-ascii?Q?X53rSy7Lspoa9OmMaQyCzpFOZV4RY6yqyJr1bS30/keWxoQE0FXUGBt9s3Xn?=
 =?us-ascii?Q?dL1CZwB4WCAqoWnVYHXiZ7L+cJ5fDixAnqA3MQglklLn2k6090rCeZ3E7Ufq?=
 =?us-ascii?Q?jAwrm7mmMvi6hsiDQfUDwCzzm41LoY5rGv/zKYu39KRntO35EFrX1LYZqveK?=
 =?us-ascii?Q?STtflm3XSIu668mtf1Ef7Ebqhu24Llch+zheVH/9rWA7roA6FsapXxEtm8ll?=
 =?us-ascii?Q?tPcZZPmxUYgCpAlRbWTJDb2oKwHgpWFEliS1Vz9P3tJ3rjP3ClAaMn9tNKYA?=
 =?us-ascii?Q?JoY+sZiO3qJ7cTym3MrsjM9LV2yibvycQWsh4O6+Z8QdP5VFK+BGIa3+1ke6?=
 =?us-ascii?Q?lUWl55APMtS26yUk/Rte+x/5jF9LXsCfBplHctklt1dECNzk90JXskLnM4bT?=
 =?us-ascii?Q?JA9R5vM9ZsBmr7U2Da5KJ8CYcbAWf4ty8ZOrhVxr+bTr5u5R/4a7MfytlP4A?=
 =?us-ascii?Q?z2XbqpYyExdrMUOb2ZuE4FYf7KtWvkYUqG8ws7M3VgIra1d89JVCkGhwHXY9?=
 =?us-ascii?Q?l1BvyRonokGuvSreClyW4q8o08+jUiZDRIgqPe9EhtrwIystIREMEib1aPVF?=
 =?us-ascii?Q?T2F9eVs9mk2VmjtI4ugyH+ql80IY0FGFNbyNpCsyegWJXSna+RbpQsBwp4dN?=
 =?us-ascii?Q?mW+SaFFFjU/+dXp+bnWqe4ojRV0lhGYtKihk6TLJdmHUpzIMAF+ZLc9pytOQ?=
 =?us-ascii?Q?zl8WkgdveyP6RZVQUxfqhOe7?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d720eab-b58d-4ce4-39c2-08d935f56626
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6058.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 03:17:14.8896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2YRbgv3dXMr04YczS416+hxXdjoSmN50Utp+/EpzngMoESD9kLQYR0WQxahYKv4Woq9swleCGpyyRmzp1hi2Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4595
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Tue, 22 Jun 2021 17:19:20 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:


> 
> On Thu, May 13 2021 at 14:33, Jisheng Zhang wrote:
> > NOHZ is likely to be enabled, so use static_branch_likely() to  
> 
> Why is it likely to be enabled? Did you make a survey of the wider
> distro universe or what?

No, I didn't make any survey. I only checked debian and ubuntu kernel
image config file, both have CONFIG_NO_HZ_COMMON=y
So IMHO, if CONFIG_NO_HZ_COMMON=y, the static key timers_nohz_active is
true in most cases.

> 
> > reflect this fact. This could improve the finally generated code  
> 
> could improve? Either it does or it does not.

Per include/linux/jump_label.h, if the timers_nohz_active is true,
it can save two jmp instructions.


 * type\branch| likely (1)            | unlikely (0)
 * -----------+-----------------------+------------------
 *            |                       |
 *  true (1)  |    ...                |    ...
 *            |    NOP                |    JMP L
 *            |    <br-stmts>         | 1: ...
 *            | L: ...                |
 *            |                       |
 *            |                       | L: <br-stmts>
 *            |                       |    jmp 1b


Thanks
