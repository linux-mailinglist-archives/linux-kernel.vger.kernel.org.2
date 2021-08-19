Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24993F13A4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 08:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhHSGi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 02:38:28 -0400
Received: from mail-dm6nam10on2076.outbound.protection.outlook.com ([40.107.93.76]:48353
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230463AbhHSGi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 02:38:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOJ6Ldf4AFMcJMAtsaV3x6vZF1vBs8IDgDsoETzjR1vlk2MDKleVX6Camt0+8sNOFDxTpe5P4G8sVcknJDKpATQqVgAWdHchxOhxhkqqsWfnkk8b6ApdCjpgK7qjAcQ8sIriolUIN/JgSNZElbgRXGj5iwfGNr6d2PEGwMVI6oVceEXuIGT6u7WAAv/hFNcEoiPg8fx/wfaDxYV4GPCk6b/PNEMcpxL/NtjuJgU/CmM9IzUsUngO7yT/CjAw+eywKEAHbgZsrERsErwmU2GImQ+v+PrQ/V9Tn45meJHWpzfiyO6A6zWeA37XSd4TrpimIEr9O2Yz9DV1Xp/bijt90Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoHM6VKRP3dt01g6Q7Andf2TCADa6kVwJG5gbEKFTGE=;
 b=Pz9ZVcOOHdyNZVJ43CDyY9kMT4bXdwUDmrKJEuwTUCIqfEY+0e0CA04BQDA1VCdIJHVNYXw/myRPNRs16M+uNTgWV6Y4rnaSPqyP6cBw44/LDxF5AaZSuDcNSL2FXr63MDbZrNuNGmzBYRmO/9ecWneJQO598W+pSUthQzO+d9YzEALRJYIzAkwztzQQ83hgEu7WZussvn29BN3sCKKlkoO8AHu1yTiA9sVVR/C8u5lNk5kHWQO+GvELLytCPBlqNHyMD4W4Pt1gwSnc+X/F2PoJ63mFCLM6wF1+Llxy0TialW58r6qU5be5AU7NOCfM5Qd3S+CVOVzA9RelKxjM9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoHM6VKRP3dt01g6Q7Andf2TCADa6kVwJG5gbEKFTGE=;
 b=ElnN54mjLbV+GrTma7D9AFHRcSBjOaFBEIWcY/LQ+l+2PKguHZEVMRkIbJAHmDBKygtMa0WzaAioOFr3YRIc4qn1Wqdr+7ZNbI9I7qt+Zf3eaM6UhIXQ16VIj9pZZJTYAud/Bp+IJOvBUYjl3azvKL5tjSwVy93Rg3fWErXeNWc=
Authentication-Results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=synaptics.com;
Received: from BN9PR03MB6058.namprd03.prod.outlook.com (2603:10b6:408:137::15)
 by BN6PR03MB3073.namprd03.prod.outlook.com (2603:10b6:405:3c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.22; Thu, 19 Aug
 2021 06:37:48 +0000
Received: from BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::80c6:5858:36d0:33d4]) by BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::80c6:5858:36d0:33d4%8]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 06:37:48 +0000
Date:   Thu, 19 Aug 2021 14:37:35 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: dts: synaptics: remove unused DTSI for AS370
Message-ID: <20210819143735.5171af23@xhacker.debian>
In-Reply-To: <CAK8P3a0QtpBq8i2_RhW=isLSNULc2z7DbjohZReMY+rhyXEbJA@mail.gmail.com>
References: <20210806082635.20239-1-krzysztof.kozlowski@canonical.com>
        <YRbDNInfG7caSr2r@robh.at.kernel.org>
        <CAK8P3a0QtpBq8i2_RhW=isLSNULc2z7DbjohZReMY+rhyXEbJA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0037.namprd11.prod.outlook.com
 (2603:10b6:a03:80::14) To BN9PR03MB6058.namprd03.prod.outlook.com
 (2603:10b6:408:137::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BYAPR11CA0037.namprd11.prod.outlook.com (2603:10b6:a03:80::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 06:37:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4dcfbed7-4d48-4e92-05ee-08d962dbdc42
X-MS-TrafficTypeDiagnostic: BN6PR03MB3073:
X-Microsoft-Antispam-PRVS: <BN6PR03MB30737E50F9E7CB62EB7BB299EDC09@BN6PR03MB3073.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SN1pUpAymELke2QoxDnDrWsh669WOZ9qvG1X3S/mwlN5JXakxRrrbBXJBAxOk8iogoeBe/uzI+E/bvUQGjAq4xRkF/52JVLAo4m4iXsai8lLP3CrVICEQfpk4UZ/eylzgQNzfslesiprsmyaRhGj0cEforU9TBCRDyKj3EXzOp35Jwn6NWltuatP1sxTLCAK8r8BwJEEZdR40CfLdk/0Sawo/50IV7G9nXwef3STkE+FgWm+a1fxkoNnSGMXmaBs+kfUdNYd6oqalczN666H++gLuYg9YL8ZG912eRrAYY9zuvpGgNK4VRg62L9908KsUT7ndSHSQSzUcEZTeRXVn7TG81pMaIU/I+srK+Ogxd6JtYIPorxZ1uv/d1SxedrcuZK/vAR1ufiKoA0UQuS0G3crJ91amjPuGEQs/d52KvuaBVZT2Ld9Qm2mhrdFR3iMzP9B0dQ7S4vzpvBjP9LF2una9pFuK03/b7M/CY68FdBkoGk8HQhVdAgwBme+7w61IMk9kQkqvAc3xfBI1l10P0PRrXVhijF95tB6NKdgxI/WqLln/ymtKr/8aqoVHK8nIMcgm+cQfYDo+LH6I80bXdV19Efp54Pis8YK/2Muvdk+e3r9aoXja0Fj6vgunSTG0ydnkEt1gXKmCWC+6O2U25suil5irsftgrrSQi7pbF9Rigva4PqII7oemilK8ggxHYqhR/m4TpnAVvvTH0sxsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6058.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(39850400004)(366004)(396003)(376002)(6666004)(6916009)(186003)(52116002)(26005)(7696005)(83380400001)(1076003)(2906002)(6506007)(316002)(4326008)(478600001)(55016002)(9686003)(54906003)(38100700002)(66556008)(66476007)(956004)(66946007)(8936002)(38350700002)(8676002)(86362001)(53546011)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RT/wz/HuZks802PoLCj5SIO5kgPyhyPe5z+4Vljzy42fXUdMpBwE/Pl3blZX?=
 =?us-ascii?Q?IxI3Q7pXmJ0sgN6BSwsHVIvnMAP8kIyg/qIRgYid3oTg+RafYgMNjusW/wTy?=
 =?us-ascii?Q?hydxs5GmYGU06aENjzRjOzxrihlXjEp2zKCzT/PuicThdHl8r5eiVSO0CNX3?=
 =?us-ascii?Q?KR7KifyZbUHNJ0m8/geLkMFjgCRpToprVDerBHk3F8ST0WRp/9kECKXLQDjl?=
 =?us-ascii?Q?/vZ8d9i0B2CSLXXTUeEMHvYa2rzamdCD8q06Pyws8GoqQgdvng5YdLcqUJ/K?=
 =?us-ascii?Q?nJEhwe4l3Fi9eXGg0vrB/M9NnfX+Mzx5UUz3jFT3QIeBvEBbe2r6MiwoLvQZ?=
 =?us-ascii?Q?SqsGhhEIF7Lz3ta+n1tshaUzAlxdzhuoJkYC01oVzy6dmoOjf4H7BjdOhFak?=
 =?us-ascii?Q?8zJxjB+AfYchMBqaOttbQjdR0Lti7Kkp2v+U8hLMrlbtfo5nEP6yFDaOZsz/?=
 =?us-ascii?Q?ujlFXxP99r/ajQfVpFGDqRxxCVyIHT9CHUpk17MtVIqcL+ZlDOuzj9xdZUIS?=
 =?us-ascii?Q?2L2Xm7PA6TgsgRs7xO9ZDr5R9UreOoJ5eFx3TcEw3kqSpbd1Pzp6E/HkNqPk?=
 =?us-ascii?Q?DhkQnm5+4HL6+hdplBWVXE+7dmZTKaPGEO4zSWktiaD9WzKBn0zv085jW0mU?=
 =?us-ascii?Q?NP7Ro+FqWXwTbwDs/XyCIZTSog3F4KjNmD3GuJAOn3I1hL+XFCe/UqR7ticr?=
 =?us-ascii?Q?nqnIJHuTd02HbyWKSITTY8UMhAJ041tXQd5N0TTafnMNa+hJLtqybkH4eA6O?=
 =?us-ascii?Q?i22Uy2CoTqIiDksIjCpANtsaSmD/M/PHmWUKap+HySjqvF6+bk9ckdBa+x4+?=
 =?us-ascii?Q?L2Yj0WwQ3mStZDArsSdeixiG+36ld4WYKHquxzxFfQCJg/HezxiztkVLVUNW?=
 =?us-ascii?Q?GkwD/M7/xBNNqr/bjsv4tK536Z55JFmMagQLiUq2rWJGkn7+PUz9tyhHk9bD?=
 =?us-ascii?Q?cr04yCn6ODxWKl+PCIVIxMPaTPBUYDiW+Ewa0bSP0C9YFKBfp7mXamsg4Gsw?=
 =?us-ascii?Q?eLsHnDvST6AQFCXqX6fRO6+ZhETRSXagf7PUEwMpiThTN21i+cWbWOc1ZZKG?=
 =?us-ascii?Q?3z7Owg57fYm7R/1V8pWplOFCAWRFM7DIbP3gmYuoEcornGUJJ00qUbrjWovy?=
 =?us-ascii?Q?IQsMa1Ko9N4J5Jxy+CafoqpJUKQ5l/BA4ZE5+NiDzgMiModKEN7GesgGnJBs?=
 =?us-ascii?Q?eGAA8cRb9gDBRyVZfH2dHUZKVp+k+uDtBUi6y+fBCTnVV+NcbtAWZNv4+xRu?=
 =?us-ascii?Q?RWhYC64IQFsC9rGqPVtf31OJN7CE+8EPfW7/D+Zv7eYm7E0ktNs6T3aXm7g/?=
 =?us-ascii?Q?dGBXAn+Dhl9C1SURijSlTgDu?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dcfbed7-4d48-4e92-05ee-08d962dbdc42
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6058.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 06:37:48.3534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WjNR647W5abaO8Jt9fZCRCUZv4uYCIGyUMYPcKOpzNBdMqyPoXYpb5h+S9YW4ZdidgynmhX3s8kGrS1i6jehpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3073
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Aug 2021 22:43:26 +0200 Arnd Bergmann wrote:


> 
> On Fri, Aug 13, 2021 at 9:09 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, 06 Aug 2021 10:26:35 +0200, Krzysztof Kozlowski wrote:  
> > > The as370.dtsi for Synaptics AS370 SoC does not have a user (DTS board
> > > file), is uncompilable and untestable.  It was added back in 2018.  No
> > > user appeared since that time, so assume it won't be added.
> > >
> > > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > > ---
> > >  .../devicetree/bindings/arm/syna.txt          |   4 -
> > >  arch/arm64/boot/dts/synaptics/as370.dtsi      | 173 ------------------
> > >  2 files changed, 177 deletions(-)
> > >  delete mode 100644 arch/arm64/boot/dts/synaptics/as370.dtsi
> > >  
> >
> > I assume Arnd/Olof will take this.
> >
> > Acked-by: Rob Herring <robh@kernel.org>  
> 
> Sure, I can take that, but it would be nice to hear anything from Jisheng Zhang
> about this.
> 
> I can see that the only two 64-bit Synaptics SoCs are as370 and bg4ct,
> but both of them have apparently been replaced with newer versions that
> never made it into the kernel: as371, as390, bg5ct, according to press
> releases.
> 
> Jisheng, can you clarify whether you plan to complete the as370 support
> or add the later SoCs?

Hi Arnd, Rob, Krzysztof

Sorry for being late. I was on vocation in the past several days.
As for this as370 removing, I think we'd better keep it. I planned
to submit the as370-rdk board dts two years ago, but latter I focused
on Synaptics SoCs related drivers support such as gpio, pcie, sdhci and
so on. I will send a basic as370 rdk board dts. I'm also considering
to mainline basic support for a new SoC.

Thanks
