Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893403F2A1D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 12:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239119AbhHTK2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 06:28:01 -0400
Received: from mail-bn8nam08on2062.outbound.protection.outlook.com ([40.107.100.62]:52064
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237319AbhHTK17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 06:27:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVEbi/OfS9bXpU5jon3NT7ruyujSiI/0mEyv7M+jbY7JT+EgQtVaENrR/1nlnJsr4RY9O1x4piAsoHLAx5knosBeKyQLYac4LEaWNdNIIgtQ8FP2s88S2H/kIPGy3cxd27Y+sUuCGQ/wCb2rDLDuXPIXFDaTZwGKqYP0YXJfBp+y3HJqDeAhd/ppVGR2VdMQbLevorfKbC3aRX3OXLMGsgSQCD3T491+/91fqFCXBMY7OLDu2tQjXu+i5mL9gmC3bfWWNXGnDal5g3RIDvxYhdJfF/05DJo2JZF9ZHjDgimtRW0OoTQHg0aF/g5S6E+bJHq/B4vj14yOYj2lkgFRkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgpQ6e1oyrIh6d/u2JyFYSL2xREale8T3E3mPh8xEnU=;
 b=Q6oTEsB7TRpubxQQNol+MDqg/mYQtWTzAQC2JX2XJzv9v+vrLzPufan7pJfiBc0FXRm/MqVN1viP/GatHH6aBppvZqKrM9koGKJ0EUAIdnNL83TgKq5lqSjVaKUaSgxlNEKKkHKjMZliOuWQsRuApXpqg0E2+CTNPTexU1iCrAi3XHyIX5Z2dOfIjQTvs2u1mkT+ZE7A1Fjm7BsTOL3h97VkgyLJrFex/inmSpCoxT7OCnPfLWQoeQoYdQJHwGy4UusaTrnN0lTJ+Q/Ag9YHzjzOmL5zCAaBkGVfOit/F9qbSmPVU3BKU7/Ijbt6IEEiNStTidmJ77/slhDQhi212Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgpQ6e1oyrIh6d/u2JyFYSL2xREale8T3E3mPh8xEnU=;
 b=gFtxAZvuoOgT4U/oGQjuw1L1PQB+07XfYzQ94BJAQ3xioXljCyZmhKjo74q6iEtal87Jt5aMT3kkSjFCLUGNajsF9/SAOr3/AMjRp47FtXkQgrr9khgy22j+05oxYyOaFh8tqmuHrKpzft7kV/YwpM0oK3y7b24zhotOg+poz4Q=
Authentication-Results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none
 header.from=synaptics.com;
Received: from BL1PR03MB6055.namprd03.prod.outlook.com (2603:10b6:208:31b::6)
 by BLAPR03MB5523.namprd03.prod.outlook.com (2603:10b6:208:293::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 10:27:18 +0000
Received: from BL1PR03MB6055.namprd03.prod.outlook.com
 ([fe80::5c54:a202:1128:1c8a]) by BL1PR03MB6055.namprd03.prod.outlook.com
 ([fe80::5c54:a202:1128:1c8a%6]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 10:27:18 +0000
Date:   Fri, 20 Aug 2021 18:27:08 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, soc@kernel.org,
        Rob Herring <robh@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: synaptics: add DT for AS370-RDK
Message-ID: <20210820182708.51d13e29@xhacker.debian>
In-Reply-To: <29e96ece-8541-a7a2-c6a9-453be6644eed@canonical.com>
References: <20210820173108.01d5c6de@xhacker.debian>
        <29e96ece-8541-a7a2-c6a9-453be6644eed@canonical.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0052.namprd11.prod.outlook.com
 (2603:10b6:a03:80::29) To BL1PR03MB6055.namprd03.prod.outlook.com
 (2603:10b6:208:31b::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BYAPR11CA0052.namprd11.prod.outlook.com (2603:10b6:a03:80::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 10:27:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fe112cd-c46c-4a18-8a2e-08d963c51636
X-MS-TrafficTypeDiagnostic: BLAPR03MB5523:
X-Microsoft-Antispam-PRVS: <BLAPR03MB5523480DEACA326EEBB8269FEDC19@BLAPR03MB5523.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EVlgAEh3GXhZJ57VGhd9gH06XTypVOEjJM+NFqHhbyZFpIJlD+1ynm6PKGaEr6JOWQJynPJzY9qhPHWs4JUpoakmaRiFQqS/10PicqX65nYhCDFIQdjBeCd4weeLyT+XK6iELmxq0oGC0yh5qeoA2xv8CCyfRJouhJlXLsI8KdhxUu/8dMJ1h3fN+xTK7dOy1Pzdhg+MHVlGBQlrVFtxaHgtqPpwWA2wWv7LYe414RR+I7LfRr40KeViASrbbS5W7ZK+79S1w8ifVZM+MFDR9XG1AqBogRCk5OF/Xao1T8/ahi5tYtP1KweujsDgHcyJU2mVXCZANo5co/GRg/pcIpu++H9cIG48kIS5n6h8mmsgkXkv+uNetZTkJqPRCwOxcfApZ7708owfaSKd+wNIgZramv6dnpDQ/jNh0tXkS3on/d3ntGfl+uAdsFGF1W220HJQsmOpBCySZ1FJaWQ9zqFTbvBw/YPqoMKr7fjOG7UdUPZ6LoD0GkUG8a9gzuFOMPDiGlWz8aXU3Gbe627Z9YovaYzOmoEcs1zUiDsnTYO/nZJHELNxyXN/imWZknAEqkTvQLnU+MVzLcLKr98toIxHIng8BsUbSSCaCM9FW3CCOH87H2FTTp3MEHU5/zCG+aSMvMiN1IRNoERI+tmqB1993IUyfjEEUA3+W1CYlaoO32wrJSUJsWON29eqjX0M2vx0WNYXMK6R+SeqCIxxBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6055.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(366004)(136003)(376002)(39850400004)(478600001)(316002)(4326008)(83380400001)(54906003)(38350700002)(38100700002)(1076003)(956004)(2906002)(86362001)(66946007)(8936002)(8676002)(6916009)(53546011)(66476007)(66556008)(55016002)(9686003)(6506007)(52116002)(7696005)(6666004)(5660300002)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WCfBqAQMqEQLaCiI1qdBxkSxGC802gAT8lhHHpCGEzoD7oUfzhUWffw1ooDr?=
 =?us-ascii?Q?9OsvM+W8L3w4guzdffblBaIseZXfAaZM8UpMjLWBxX60r+Sj3eO4Wfn5A3Rx?=
 =?us-ascii?Q?zAtOjko6PjmZCmIrHnKqpymD/vWCTmn4v1X6glQlfz+FHul5NDSBHCRE2KvP?=
 =?us-ascii?Q?rsJ0QL0i8fraKaeo7+x1LZrI3SIA2wBr2HwiNBPB9BKZ0FxW55QxEhhvUt9U?=
 =?us-ascii?Q?SDMQM5yQSs79uHMUDHnLxDzuh7K0sFG98SEW7DnYj2fxEoPZgF7+Vv4fBBei?=
 =?us-ascii?Q?YicF44I/1Afx2/ZVfYVTbmF3ZKSRMDXnQf0Nky8iovpuiHomBoBUGLQ2H3kf?=
 =?us-ascii?Q?h8K+lDfhKMXu+ZDngR8pTu2h+TincHPPVp74RdchURDbjny3fBsTqS8LKKgL?=
 =?us-ascii?Q?4+IXIwBRgfxJRZ18wcePAWC3g2gJCkC6bRuBqfQeh1/NOLHhENOEsKbz1tt0?=
 =?us-ascii?Q?/sTXPMK3SQOMMech55nAkDc5XuswFRUtKGLwHhl8aZrYaC7ReHFRGlZZC72+?=
 =?us-ascii?Q?ni7G5HZVEzLwnlAO1vu2VJx+Qd7tDJFoU7ESx94ye37T6BgUUd+UL3x6P/xz?=
 =?us-ascii?Q?QXV2WiMsoa58YzYpmdCn/jaGHzEQmXfJUsv6Aaf8qZpX68lbZvjStvKFgC3L?=
 =?us-ascii?Q?i9vRgTaeKdUmIPmlMxbi/mjZCoNua2xV8rN0tjnB07F45HIXtQXd0WOVxv4p?=
 =?us-ascii?Q?7GBiU3mlcVf5RvI0B5gWmncFKBR6RCwp76zvVQvd9/8ZdVfT+WnbhLOnkn6S?=
 =?us-ascii?Q?MzbytIsGgyVMJjSpG8QpxR7iQQ4NFYyiBdFJanLKwO3r5eyY2Rgz82qnQ6fd?=
 =?us-ascii?Q?rsniKantMUznEC6EZAgWorONfuSjogZ/ZyF/0qcmIm8GqRq8CEmGpjEX78R9?=
 =?us-ascii?Q?VEUmZtFqaHfNLBfV+hTw+BsJ7QruiBfjItNljxPMJjrkM92x6FhmhtHe2l0u?=
 =?us-ascii?Q?nHoGEvHy0vT/fyakWcM6a8mtpFKxiJgvO7U+LXjnXwnkk/6mOaeSN0kNxpTh?=
 =?us-ascii?Q?a2J/bix9+y+WPvJzZbBI2rHxhZ+kh58pNMltKvUZ+Ldx+A3kzQ+ivuI8JR+Y?=
 =?us-ascii?Q?Xpxwsb3ysANdS6Z4p7FlG0tMWztKApf12VvqfuyAIIBfblu9ZXeyAuxe1ubb?=
 =?us-ascii?Q?UgUboV8ZOEyePIMn73INieylYUnYd2mc1BmyigsEPtJrfFxHac8bzOdIFnFR?=
 =?us-ascii?Q?cmaNSGExlaLOrEsSoKS6uAkuJVmEGo94ICCkdfT+pKDEKdFOjxoa2TD1yElV?=
 =?us-ascii?Q?18pjdGJgiYH5jcqtvON1ndwleIcSPruC2s9fhA1iE/hyXTUfVIgOSv7NS+VU?=
 =?us-ascii?Q?hnSwk/q/mJUCHUW8UBvmbY9k?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe112cd-c46c-4a18-8a2e-08d963c51636
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6055.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 10:27:18.3031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fTykakcvWgYqcEvbDsaDS7CHZaffVoZdMB5p2y6ij9wvxFBBMw8q9agPQZ0LlwOalVBsyl88MbMKAPDfBxXbbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5523
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2021 11:59:30 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote:

> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> On 20/08/2021 11:31, Jisheng Zhang wrote:
> > Add a basic support for AS370-RDK board based on the AS370 SoC. We can
> > get a basic shell on the uart console now.
> >
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> > Hi Arnd,
> >
> > If it's too late, I will add it in a PR for 5.16 in next development window.
> >
> > Thanks
> >
> >  arch/arm64/boot/dts/synaptics/Makefile      |  1 +
> >  arch/arm64/boot/dts/synaptics/as370-rdk.dts | 29 +++++++++++++++++++++
> >  2 files changed, 30 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/synaptics/as370-rdk.dts
> >
> > diff --git a/arch/arm64/boot/dts/synaptics/Makefile b/arch/arm64/boot/dts/synaptics/Makefile
> > index de71ddda6835..c1c4f6c040b3 100644
> > --- a/arch/arm64/boot/dts/synaptics/Makefile
> > +++ b/arch/arm64/boot/dts/synaptics/Makefile
> > @@ -1,4 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  # Berlin SoC Family
> > +dtb-$(CONFIG_ARCH_BERLIN) += as370-rdk.dtb
> >  dtb-$(CONFIG_ARCH_BERLIN) += berlin4ct-dmp.dtb
> >  dtb-$(CONFIG_ARCH_BERLIN) += berlin4ct-stb.dtb
> > diff --git a/arch/arm64/boot/dts/synaptics/as370-rdk.dts b/arch/arm64/boot/dts/synaptics/as370-rdk.dts
> > new file mode 100644
> > index 000000000000..6f5c37c98be6
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/synaptics/as370-rdk.dts
> > @@ -0,0 +1,29 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +/*
> > + * Copyright (C) 2018-2021 Synaptics Incorporated
> > + *
> > + * Author: Jisheng Zhang <jszhang@kernel.org>
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "as370.dtsi"
> > +
> > +/ {
> > +     model = "Synaptics AS370 RDK";
> > +     compatible = "syna,as370-rdk", "syna,as370";  
> 
> There is no such binding. You need to update the bindings file (first
> patch in the series).

This is my plan ;) In fact, "berlin4ct" related binding is also missing.
I want to convert Documentation/devicetree/bindings/arm/syna.txt
to yaml, then add missing bindings. But it's too late for 5.15,

If it's fine to keep as370.dtsi without board user(s), we can drop
this patch. I will solve this issue in next development window.

Thanks

> 
> 
> Best regards,
> Krzysztof

