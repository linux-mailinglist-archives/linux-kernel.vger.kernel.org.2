Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEB14363F6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 16:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhJUOUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 10:20:53 -0400
Received: from mail-mw2nam08on2050.outbound.protection.outlook.com ([40.107.101.50]:34499
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230072AbhJUOUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 10:20:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CcX4XqPepZrl2JxjGybrRqXJ+LY76tWbEIO0fI471pOvxS4zZmb/kmPZ5Qb8iAK7GRzjckFNsBoOhlQ30T7WfQJs1NFSa7VqLMbb/Iorkf63aNdbhhXOz4HHBmniZq5dOEiR6VMPfeXTCww/+A86/8ushkm/r+ckRJ+U2nAzRbrR1za8zH+91ksVDzrwzKrunGEA2/V3NcJnpNTg1L9AlIWEf0vBMe7BIa/QHVbHq8ZN3OOSNDIum0boT+dGdpiP/ZJxgP2arobCqHJg6UGOiWFe1X/WxPgamSx5ecCfahIOyB2hcD7OStYYS3wERFqwKicsksWt3EZsfOz5ceFBAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zqclewa9T83/gV2h3b0Ao1GuaJ7qEGu/pwz8snM1wPI=;
 b=jmzSnnMpCGG2yJ9DyfnNbv8J2TWneOXfkAZRJxv52C15KD0jqO9dlTttbD+XrBUjaenlnpVfwxbQAeO5nfF4785v1k1Z4dSaKanSfCazEXAb/DjHg9d1/4bOsbN97XASxn8KZNvXcSXkGajYiXqahZ8VXN0RSIQC8CM6kZQ+Oz6Y5OtBnFXuNnbxq1BRvDdUpTPVvMGQ3ZXQs4pv1RHNUTxM0SgF+c1IqyBWoBzuQOwaSm/ki68JbTkxehMrKvuPRHGejpVfTYlnmtowzlJz/KD/vmvca/5c54WnI51UowXC3oJciaIIEMwgkUYpZkLuSmlX4jHtQ1OM1p5kuEdSPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zqclewa9T83/gV2h3b0Ao1GuaJ7qEGu/pwz8snM1wPI=;
 b=q1xIX8FcszHbLKRMt+QtvonPj1/EKQ3SZkgTugWtQuoTp0l/85iLqLg/zTbLp5s9997OXehA74pFLvFh7WZIj/DHXsd7LGjLxR3ZmVPDlKbTLak4eZYXXbbup6p6mGW4I8q6hWcbQ+2Emhdn83e/nIkLj1bLXOF5k3P0NiiHMPk=
Received: from SA1PR02MB8592.namprd02.prod.outlook.com (2603:10b6:806:1ff::18)
 by SA0PR02MB7210.namprd02.prod.outlook.com (2603:10b6:806:ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Thu, 21 Oct
 2021 14:18:33 +0000
Received: from SA1PR02MB8592.namprd02.prod.outlook.com
 ([fe80::6d3e:7010:c43d:fb23]) by SA1PR02MB8592.namprd02.prod.outlook.com
 ([fe80::6d3e:7010:c43d:fb23%8]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 14:18:33 +0000
From:   Abhyuday Godhasara <agodhasa@xilinx.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Michal Simek <michals@xilinx.com>, Rajan Vaja <RAJANV@xilinx.com>,
        Manish Narani <MNARANI@xilinx.com>,
        "zou_wei@huawei.com" <zou_wei@huawei.com>,
        Sai Krishna Potthuri <lakshmis@xilinx.com>,
        Jiaying Liang <jliang@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 0/6] Add Xilinx Event Management Driver
Thread-Topic: [PATCH v4 0/6] Add Xilinx Event Management Driver
Thread-Index: AQHXqjPsj2n6NIOYSUC8o2qDqfgxnKvRBXFQgAAKboCAAAG/AIAADkYwgAAD9YCAAAIsMIAAAwoAgAAQ7gCADHfxcIAABReAgAABVpA=
Date:   Thu, 21 Oct 2021 14:18:33 +0000
Message-ID: <SA1PR02MB85924092AA6D1B87E03113A3A1BF9@SA1PR02MB8592.namprd02.prod.outlook.com>
References: <20210915131615.16506-1-abhyuday.godhasara@xilinx.com>
 <SA1PR02MB8592838B99062EFA6EAAE73DA1B79@SA1PR02MB8592.namprd02.prod.outlook.com>
 <YWbYKQXf8g8s55kG@kroah.com> <YWbZoPHDzc4e5Nme@kroah.com>
 <SA1PR02MB8592E68D021E12DCA45B70A2A1B79@SA1PR02MB8592.namprd02.prod.outlook.com>
 <YWbo660XPKlwDZH0@kroah.com>
 <SA1PR02MB8592EB312091543A1D564D70A1B79@SA1PR02MB8592.namprd02.prod.outlook.com>
 <YWbtSiHWNOf2djee@kroah.com>
 <f63e44a0-c187-8278-6c89-935b7006b64f@xilinx.com>
 <SA1PR02MB85922CC2DCFCDC902BC37E68A1BF9@SA1PR02MB8592.namprd02.prod.outlook.com>
 <YXF1W8a7NfvRWPTt@kroah.com>
In-Reply-To: <YXF1W8a7NfvRWPTt@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: acb9eb84-d316-491e-cb10-08d9949daa2d
x-ms-traffictypediagnostic: SA0PR02MB7210:
x-microsoft-antispam-prvs: <SA0PR02MB7210B2969FA846BA9EB9C5D8A1BF9@SA0PR02MB7210.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TBpDxCuUgr0bMtKBGmVVk+I7uckw8cgrBHG4EhlE/QGz6GTz5o4Kr294327WYVphr261gX7ixT5kuFktRtG0a+tf4GLWhOsECuYQkvOIA5aqoDh/IJntx87furF8RLgMA8DfbYo631jyKRId5w/g+edXUhYYF25PkJiRgfKY2Drz3dkxOEQjYMVYKHOACqJIrpQ8rQE0Uj4b1mekLJI2yot4SIKk/zjhH/tqYVJarkXcM4AnMuin3ft5zoFCanRWhLsCeBNEhvDtYrdbQJ6+rCn7xi30HeyCvj0JbxGAlXY03y+fZdg6vyri9czlDdhcr86Qqs7NGCdYsbVp8s9HWU/pUehEn4KyZcd54xZyqC5DPg5Jns4JfXWPc3FCr+9f2+pM3/46XJ9yxX6cl1JCocCwXnR/k8xC+3R4VyXgUooAvKnVwoUsf2Yt1blmlzo3XaRrb+IELNwFga7ZG14SZAL1fPG//fuPito952CHOWjg73ffV3ii6ruYsMGslJn97qyHQNeCQTMIO+OJmSx+MKs04R5/NFe6gutR51lgF8kSrZbiBLNVLIKgJ5QDdgIrFlI8GpKDCHTO+4RcoIiyWINxqku6Cg4+JdwlYiBtSUN8NbXnSYvDJnhQmPjQZ5gzOB+VXHIG5IrgI2ydbdVM5g/PXWmYEH7dr+F0ypT1xKMt6oNFpEuSvMdmo3h+rhlLd540qTxoPVG38+nGcOMwAw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR02MB8592.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(9686003)(55016002)(76116006)(5660300002)(122000001)(66556008)(66946007)(2906002)(64756008)(66476007)(66446008)(38100700002)(8936002)(52536014)(316002)(54906003)(38070700005)(83380400001)(6506007)(86362001)(26005)(53546011)(508600001)(33656002)(8676002)(71200400001)(6916009)(4326008)(7696005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3U/S4RS+2lB8RBm+yLZoAj1RG2WUjwNsrQ0MsYTinLDLZPGVbKDHGZXUj5OY?=
 =?us-ascii?Q?JETpnZb0vVThtAyPetHzpjB5/UeX3/pMul3Y+nQQqnczCJJIdTLNx6oghGI6?=
 =?us-ascii?Q?6yzYdIbMl16MC5n0IkaGnYirSIqdfZCNDKTUwMCWjXpCZbF89auaUEgwuQOn?=
 =?us-ascii?Q?/lW9F0oAFgy8brAAUSzty1NevnSi3Bi58UQ10piTL0lpIRBaTlbdDMVqT3Mw?=
 =?us-ascii?Q?trBIzVzYN6zsoLZJ4u6pnWAFYgSLdWp/6LMhrJRv3ZWk4iICzX04FXv16adU?=
 =?us-ascii?Q?t1++q1WLylrrNc/9nC6NZ6t9lax61dyRUj+fadKVYbSGU1h6D7Z1vl4XAe9z?=
 =?us-ascii?Q?d5UxrSptJPuzG58wkCDYVVd0iOhjDXmGIeftW3FWJ86NMOwB61lHH737S3Bl?=
 =?us-ascii?Q?920/msUreFAcTfpjklO4YeaGJRzGuBVngL9sv1KPg7vtcT3qQbsRqos58q/W?=
 =?us-ascii?Q?so5ifxKUSrQdKEPFiv2MdRGuSoeVOzAsodiilTcGxMDafUly3kKgExbna+Ka?=
 =?us-ascii?Q?zkNi0LRMlPD9Mp4M8K5BahOncdPEY/B0LqhSycBFGJk/lrW79hStR5/sQj7J?=
 =?us-ascii?Q?rHF7FEzZecJoUkG/wHXzSp9AejU26jP65N601V/z4grwcWrzcIlRwsUDc1Iq?=
 =?us-ascii?Q?ErpAUqA5kz7CegQ3Zz9EMI/kKgDBKaCQtYNg/GB9weae8RgxKYQBBC2ehv+g?=
 =?us-ascii?Q?6CxftRtU+4REKDshhkWg/3SLpbdYTeHJCUWeeJRtgSLgEfrJWkEWeaIUQEFq?=
 =?us-ascii?Q?twb0xT9WdJVKGNGeAriftN+2+gZ5TN0c61I8buovP93BcCF9gbIVhL+38m4r?=
 =?us-ascii?Q?ddT2zrkFYnFWv8KZHDfEto6C6zYql5Kbt9ouh8dfMB4oz7Z8Uwtqvgn4bmeG?=
 =?us-ascii?Q?2WpJTfmfuFig8KeOrKmECy1a1s8aKwA9JcBR/Y/gT16eTL73+vwy+YcbJH2m?=
 =?us-ascii?Q?CEF9aqb1xt/2aV3njxhwOA7aaRKXhRpLOJ+qhFlDJ20p6MLsPp7jlAwojr5a?=
 =?us-ascii?Q?FB7vdTmXeiFxNVhniML5SC/KF9NCTuxEJNsabFaRrWKplaBxwNbFo0FgO4IZ?=
 =?us-ascii?Q?uP+GyK6IdDZAtSUtOUPHLiWC3pzBxjofakuCwE4S/LDvMtHD7TBT4aqUNqrM?=
 =?us-ascii?Q?GHkceH8AmhMu6WPMw/uhWHXkceDDz4tiXKwj40M9LtSgP+QA/QZoKfB1hhNA?=
 =?us-ascii?Q?22HvPCAh8QtQCFfWUrYgI+DEhorgUfzLe3ygHMEyV+jXXzvqO0xpJ1imV6UO?=
 =?us-ascii?Q?x0c6OhoQ4rWmVarYkRxCWJ0rNrZiOxWG2cCuSqHFbU3EuYnvHBQ9DDl4BqWH?=
 =?us-ascii?Q?Nc0aHCLwYvr5dw0f85ymgKKVYW1UCB4mcIjcdLlNN5WFoyhC1ES7jLhuEoxl?=
 =?us-ascii?Q?odTJmsb4zlcQ+6oXVZvsGrL64psj2mDpjnJ607HlXVWQnjV3MuMj5YnxQBBx?=
 =?us-ascii?Q?ScdfBdy3mGY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR02MB8592.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acb9eb84-d316-491e-cb10-08d9949daa2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2021 14:18:33.2742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: agodhasa@xilinx.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7210
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> -----Original Message-----
> From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> Sent: Thursday, October 21, 2021 7:43 PM
> To: Abhyuday Godhasara <agodhasa@xilinx.com>
> Cc: Michal Simek <michals@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>;
> Manish Narani <MNARANI@xilinx.com>; zou_wei@huawei.com; Sai Krishna
> Potthuri <lakshmis@xilinx.com>; Jiaying Liang <jliang@xilinx.com>; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH v4 0/6] Add Xilinx Event Management Driver
>=20
> On Thu, Oct 21, 2021 at 01:55:49PM +0000, Abhyuday Godhasara wrote:
> > Hi Greg,
> >
> > > -----Original Message-----
> > > From: Michal Simek <michal.simek@xilinx.com>
> > > Sent: Wednesday, October 13, 2021 9:00 PM
> > > To: gregkh@linuxfoundation.org; Abhyuday Godhasara
> > > <agodhasa@xilinx.com>
> > > Cc: Rajan Vaja <RAJANV@xilinx.com>; Manish Narani
> > > <MNARANI@xilinx.com>; zou_wei@huawei.com; Sai Krishna Potthuri
> > > <lakshmis@xilinx.com>; Jiaying Liang <jliang@xilinx.com>;
> > > linux-kernel@vger.kernel.org; linux-arm- kernel@lists.infradead.org
> > > Subject: Re: [PATCH v4 0/6] Add Xilinx Event Management Driver
> > >
> > >
> > >
> > > On 10/13/21 16:29, gregkh@linuxfoundation.org wrote:
> > > > On Wed, Oct 13, 2021 at 02:21:01PM +0000, Abhyuday Godhasara wrote:
> > > >> Hi Greg,
> > > >>
> > > >>
> > > >> Thanks,
> > > >> Abhyuday
> > > >>
> > > >>> -----Original Message-----
> > > >>> From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> > > >>> Sent: Wednesday, October 13, 2021 7:41 PM
> > > >>> To: Abhyuday Godhasara <agodhasa@xilinx.com>
> > > >>> Cc: Michal Simek <michals@xilinx.com>; Rajan Vaja
> > > >>> <RAJANV@xilinx.com>; Manish Narani <MNARANI@xilinx.com>;
> > > >>> zou_wei@huawei.com; Sai Krishna Potthuri <lakshmis@xilinx.com>;
> > > >>> Jiaying Liang <jliang@xilinx.com>; linux-
> > > >>> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > > >>> Subject: Re: [PATCH v4 0/6] Add Xilinx Event Management Driver
> > > >>>
> > > >>> On Wed, Oct 13, 2021 at 01:57:59PM +0000, Abhyuday Godhasara
> wrote:
> > > >>>> Hi Greg,
> > > >>>>
> > > >>>>> -----Original Message-----
> > > >>>>> From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> > > >>>>> Sent: Wednesday, October 13, 2021 6:36 PM
> > > >>>>> To: Abhyuday Godhasara <agodhasa@xilinx.com>
> > > >>>>> Cc: Michal Simek <michals@xilinx.com>; Rajan Vaja
> > > >>>>> <RAJANV@xilinx.com>; Manish Narani <MNARANI@xilinx.com>;
> > > >>>>> zou_wei@huawei.com; Sai Krishna Potthuri
> > > >>>>> <lakshmis@xilinx.com>; Jiaying Liang <jliang@xilinx.com>;
> > > >>>>> linux- kernel@vger.kernel.org;
> > > >>>>> linux-arm-kernel@lists.infradead.org
> > > >>>>> Subject: Re: [PATCH v4 0/6] Add Xilinx Event Management Driver
> > > >>>>>
> > > >>>>> On Wed, Oct 13, 2021 at 02:59:21PM +0200,
> > > >>>>> gregkh@linuxfoundation.org
> > > >>>>> wrote:
> > > >>>>>> On Wed, Oct 13, 2021 at 12:27:58PM +0000, Abhyuday Godhasara
> > > wrote:
> > > >>>>>>> Hi Greg,
> > > >>>>>>>
> > > >>>>>>>> -----Original Message-----
> > > >>>>>>>> From: Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
> > > >>>>>>>> Sent: Wednesday, September 15, 2021 6:46 PM
> > > >>>>>>>> To: gregkh@linuxfoundation.org
> > > >>>>>>>> Cc: Michal Simek <michals@xilinx.com>; Abhyuday Godhasara
> > > >>>>>>>> <agodhasa@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>;
> > > >>>>>>>> Manish Narani <MNARANI@xilinx.com>; zou_wei@huawei.com;
> Sai
> > > >>>>>>>> Krishna Potthuri <lakshmis@xilinx.com>; Jiaying Liang
> > > >>>>>>>> <jliang@xilinx.com>; Jiaying Liang <jliang@xilinx.com>;
> > > >>>>>>>> linux-kernel@vger.kernel.org;
> > > >>>>>>>> linux-arm- kernel@lists.infradead.org
> > > >>>>>>>> Subject: [PATCH v4 0/6] Add Xilinx Event Management Driver
> > > >>>>>>>>
> > > >>>>>>>> This Linux driver provides support to subscribe error/event
> > > >>>>>>>> notification and receive notification from firmware for
> > > >>>>>>>> error/event and forward event notification to subscribed
> > > >>>>>>>> driver via
> > > >>>>> registered callback.
> > > >>>>>>>>
> > > >>>>>>>> All types of events like power and error will be handled
> > > >>>>>>>> from single place as part of event management driver.
> > > >>>>>>>>
> > > >>>>>>>> Changes in v4:
> > > >>>>>>>> - Rebase on latest tree
> > > >>>>>>>>
> > > >>>>>>>> Changes in v3:
> > > >>>>>>>> - Update the commit message.
> > > >>>>>>>>
> > > >>>>>>>> Changes in v2:
> > > >>>>>>>> - Removed updated copyright year from unchanged files.
> > > >>>>>>>> - make sgi_num as module parameter for event management
> driver.
> > > >>>>>>>> - Use same object for error detection and printing.
> > > >>>>>>>>
> > > >>>>>>>> Acked-by: Michal Simek <michal.simek@xilinx.com>
> > > >>>>>>> [Abhyuday] Michal suggested to merge this via your tree.
> > > >>>>>>> Please have a
> > > >>>>> look.
> > > >>>>>>> Please let me know if there is anything required from my side=
.
> > > >>>>>>
> > > >>>>>> Ok, I'll pick it up, thanks.
> > > >>>>>
> > > >>>>> Nope, I can not as for some reason it all did not show up on
> > > lore.kernel.org.
> > > >>>>>
> > > >>>>> Please resend this, with Michal's ack and I will be glad to pic=
k it up.
> > > >>>> [Abhyuday] Sent v5 with Michal's ack.
> > > >>>
> > > >>> Sent where?  Do you have a lore.kernel.org link?  Did you cc: me?
> > > >> [Abhyuday] I added linux-kernel@vger.kernel.org and linux-arm-
> > > kernel@lists.infradead.org in CC. also  added you in "To" for v5.
> > > >> Please let me know if require anything else also.
> > > >
> > > > Again, I do not see them in my inbox, nor do I see them on
> > > > lore.kernel.org.
> > > >
> > > > Are you _sure_ you sent them?
> > >
> > > I got it but I expect they are not sent out of xilinx.com domain and
> > > you are sort of blocked. You should talk to IT or just simply use
> > > any email out of xilinx domain to check that you got it.
> > > Also I am not able to see it in lore.
> > [Abhyuday] Now v5 are available in lore.kernel.org
>=20
> Looks good, all now reviewed from my side.
[Abhyuday] Thanks for the review, please can you merge it from your tree as=
 Michal suggested.

Thanks,
Abhyuday
>=20
> greg k-h
