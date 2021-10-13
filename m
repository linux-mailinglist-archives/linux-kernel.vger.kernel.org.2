Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31EEA42C2D2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236473AbhJMOXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:23:09 -0400
Received: from mail-bn8nam11on2068.outbound.protection.outlook.com ([40.107.236.68]:28513
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236309AbhJMOXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:23:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebCQ27rEf6P9068M6eltrYlNyllKNlf0D7GmFFm3T6dra6Hr+mRjt0TkdfiBfSQQ7CEqGr2jQ6/oygVgYklAUtiyfagB0YLF7frjKufCJ2qQc6iFSbfliuUIfYXmcofuFEw3GAoaBBAbkg32/lnN4exSsO0jOzG8NcxWb25Cc99gGpeW1G7L5tomQrLcj9WqOzoKvbT245fYqwNE7HjzJCWIm0kv4C/6d58kiuOP5qDMbVk0RXg0nTVuGOEYci2uQcKqRKFUTJWXo0AvbMdp39N7Zp+UNYPno0Owc6fapB9CPHMBt+jjPFEnNXN9S8NfM72Hg291FF7l1IBHCtJZbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pS7FSRqYlT3lQ8K6oKBXiMkEpLXCD9IRWmA+dE8yg/4=;
 b=f8KUtd4hqvi1HDAsZUGiFM5oaorCGl7p/JxKEC9sHKN5eSOctUENhaT/mfAcQhfu/fO8eCmnqH95P7MZC/9gZE2Q8qCXRuZkZ0Js2bIi7qoKc5RscdCHHhhtE5CIFsmqzCYdbENWafYOSW9BSPVqYkMaZ6qR1FhRjcP//q3pegQjma79a4LzazBby5uBT6lLmSfgiUWzoknCV/bSTKqKgI5UhJQ/w36wlFQTibjihskUGxnJsiHTO7RbciTSWcEcC26F5wAgIFls12H/MdVYlEMw0fuCjHJ0N10TNU0sqiQdnfjocHpfdN73FQx/mOTWNGqEBStkrAducIcQ1L/JsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pS7FSRqYlT3lQ8K6oKBXiMkEpLXCD9IRWmA+dE8yg/4=;
 b=KGTdfT9GTi4QNemELFvMfBkLSMStg/3r36iQBZdf4mUnQALvvTxDX7376zLUHOg2i3hR4GwkOgEgUOHuv+pm5AMaMv/dZCeuFk99RzGY+iDS2WDsGd932gtVnKFQLC8C3Et3xpCExIivCm+7qIBb8IPjJSi5s0LO/TLVrqAOXlU=
Received: from SA1PR02MB8592.namprd02.prod.outlook.com (2603:10b6:806:1ff::18)
 by SN6PR02MB4528.namprd02.prod.outlook.com (2603:10b6:805:b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Wed, 13 Oct
 2021 14:21:01 +0000
Received: from SA1PR02MB8592.namprd02.prod.outlook.com
 ([fe80::6d3e:7010:c43d:fb23]) by SA1PR02MB8592.namprd02.prod.outlook.com
 ([fe80::6d3e:7010:c43d:fb23%7]) with mapi id 15.20.4608.016; Wed, 13 Oct 2021
 14:21:01 +0000
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
Thread-Index: AQHXqjPsj2n6NIOYSUC8o2qDqfgxnKvRBXFQgAAKboCAAAG/AIAADkYwgAAD9YCAAAIsMA==
Date:   Wed, 13 Oct 2021 14:21:01 +0000
Message-ID: <SA1PR02MB8592EB312091543A1D564D70A1B79@SA1PR02MB8592.namprd02.prod.outlook.com>
References: <438b398c-a901-7568-11e0-cd9bf302343f@xilinx.com>
 <20210915131615.16506-1-abhyuday.godhasara@xilinx.com>
 <SA1PR02MB8592838B99062EFA6EAAE73DA1B79@SA1PR02MB8592.namprd02.prod.outlook.com>
 <YWbYKQXf8g8s55kG@kroah.com> <YWbZoPHDzc4e5Nme@kroah.com>
 <SA1PR02MB8592E68D021E12DCA45B70A2A1B79@SA1PR02MB8592.namprd02.prod.outlook.com>
 <YWbo660XPKlwDZH0@kroah.com>
In-Reply-To: <YWbo660XPKlwDZH0@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fab1d927-b1be-447a-22dc-08d98e54af0a
x-ms-traffictypediagnostic: SN6PR02MB4528:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR02MB4528F0EC6E41E437B8A0A915A1B79@SN6PR02MB4528.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g3szMis3Vr5Pk3xW5ulAnDFCrS7jgQWN4BFDUWoYPLGkcbIgUMm8afyjS18dLGUCQvRyc0hjktU7qiGq6QtAVR0hpyX1hTS6Rx/VmDpvrQlFoXjKHA2U2Tqss8mEY+6B3IPA/CbcJyzbxbE0yCQTzDAJygJjYL0G7KDV6mocod/ZG2tLkLQ4vDxZ+cnUpXYdsiIXg+LeCYeGIN0Ri8qzNn35WwPcJvm9WxKQLNjchwgXOOr74Vflq2JVKIfizikAjd3sJWOaCrL1NuLmf3FuAgVlW3Hd0O19aWXqb2A/NyNCFhqDZjhXKvbyG31yME35SfXgQjSJ2w8RKE4hz3UIMaArq/i5a9IoeyhCAPPOdP21LoDhL8+OHK4uWlGSiylKck56HBZdHWGIZ7Wl9Qx0sbe7XJNAfMmx5NqyWtMSP2nTrhmrKEPTHTFLOyaSzodpfOaIbpwRh08EGYV+cZlkwIUvJh0q2jPNcTk1HEZ428oXrPsklwVkMYjfq8uhAVvEmsO3nVMxQWyTqr1mmxYlKatsADsZzul9KlDFgvU1a3kblChThM+RVvisalgSzjx6apPJW/lOAk11VUayt47HwzAgQhF3+1pWxQBcyZo0LvzpsmzlvGKeF4D4Ro9DjSZYUnhbcyeGe66h2rG7nEkya2bhXddpJTRqa5FdAW0ab1ozh48jmlWpSNLyzytiSHY8mjrsmHyR96F3sOXYBXzk4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR02MB8592.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38070700005)(86362001)(33656002)(83380400001)(186003)(122000001)(26005)(66946007)(55016002)(66476007)(64756008)(66446008)(4326008)(54906003)(66556008)(38100700002)(8936002)(9686003)(8676002)(71200400001)(316002)(76116006)(508600001)(6916009)(6506007)(53546011)(7696005)(5660300002)(2906002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gAgWqs1qHNMUQYrRlk/IgQHD9Z/b7xYdxtQPl3pyb5OD29ujIeqm+2rnYtEH?=
 =?us-ascii?Q?Cojv4MPUb7OrYew//2938lS5nPgb4x55n0S8A2H+u22QXpHwHm03nUzLGf9P?=
 =?us-ascii?Q?kyFWeFoeHIBI2W59ZNUqq6cN3zPaWYrSAaYiAyJqJc+CTKYPWbkPh68xVPlr?=
 =?us-ascii?Q?NVv9uJMtarT0fplmHNyoo6ULdFPWVflSxInos3spIfVa3mkGBgkAjWo3I04E?=
 =?us-ascii?Q?kfzCvHUZYqxhDFCaE1mLdDWgagfE8qAcM6JMFXH5hswFUVvUbFzzRjQpOxfj?=
 =?us-ascii?Q?7qlOUCeK2S6fIsBPmXHn2SFulhnOpYrvXIPiw1o19P0qqS4m45oyISF0ZbKn?=
 =?us-ascii?Q?STk7OSdx7XZI2uHBlrv18t2KwlsLw7UTQBzp28Eu5gAPKtjYub4dAsyRwazV?=
 =?us-ascii?Q?qfCU9qGzgleT/hwPHLgi3lJhCYDDf5hBv7IYCuWdEXYN/UJIxkndH5zhLiB6?=
 =?us-ascii?Q?9daAH++rWKzLKwJq3V+P7aSp8rYUWeQp8481+Dq1JjCzZSXR/XLkt+SL2svM?=
 =?us-ascii?Q?J9Pf3qVBfIs3Ip6clLjdGq6+deZnNO1+JM8aWhWHzbwWnu5EPrFOP/SjdmIt?=
 =?us-ascii?Q?c/fxXsIbT4zvxONKS6VLyWMLA2hVaLYCqTfDkfwjfQ6khJ6ZjloD3QgQYHtr?=
 =?us-ascii?Q?wjtbjjJJj1fP7K3RFNdVh4UBClNmeuUIIaU6ucOsVJp4nQfRDtmut/EgGGK+?=
 =?us-ascii?Q?hT/GuohTfVIrQ0nrlNJhO/DVion7p8vFjXlqZQd34Rys5bz69Lcce92UuMTa?=
 =?us-ascii?Q?VzmAUTOvpfhjGydsSlDZ/CjPf03INhor/EF88RhUv1WuKdJIKzqMq3LDau+a?=
 =?us-ascii?Q?SDbnayC6aSrnCNun6JCzycu5eCRvZdQ1YKOPbVNhIY2LBxhvhzsOPM8nw5b+?=
 =?us-ascii?Q?0X8xRuyWh02eu6C6NVI497q+Vba3pEWbVW19wj7HmsHkQQDQBzW92F2dvAhQ?=
 =?us-ascii?Q?x4QKk9Npd7YEPIWi80rB/NSPhcD4XttcKNQE/GYpu9ueIco+aNRr6Bfe4dA2?=
 =?us-ascii?Q?QftrZHnijzqA9j9PHZyqGKLCIMYfd6ABb31gZ9KBYBAaq+FdO4ujI6qLWw9w?=
 =?us-ascii?Q?gmA54pgngNY6OK7uj8AAW1MJic5hr60RsLfAEtdsT+7/BvzebI8U/Q9i+3r8?=
 =?us-ascii?Q?t2lcr7GbevsnPRzoKc3hvrjCiPKMsXEzUBziTtxWBdnEZZR5E+GgEvyYIZDz?=
 =?us-ascii?Q?0hOtKafARgex2PziRkY6k3SlEAV6JYrlrd/xrA991RXcxIDZg6E6e71/SjU9?=
 =?us-ascii?Q?0Ztw5kEcKJ5jsDldORfyf+WvjDVr1tp1KoIjeF4vBVS+/JXN7tftrvQU5YmU?=
 =?us-ascii?Q?mxfwSOGnuVO28XEAu1BN+YaQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR02MB8592.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fab1d927-b1be-447a-22dc-08d98e54af0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 14:21:01.3644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X7N8FcfaSdI/RJ6czWXHSefNO/FigMqeclaeXMqpEPtEPtCAMsddIdQMFISjAL57+5Bc5y6B01czbv9LhO+hyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4528
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,


Thanks,
Abhyuday

> -----Original Message-----
> From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> Sent: Wednesday, October 13, 2021 7:41 PM
> To: Abhyuday Godhasara <agodhasa@xilinx.com>
> Cc: Michal Simek <michals@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>;
> Manish Narani <MNARANI@xilinx.com>; zou_wei@huawei.com; Sai Krishna
> Potthuri <lakshmis@xilinx.com>; Jiaying Liang <jliang@xilinx.com>; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH v4 0/6] Add Xilinx Event Management Driver
>=20
> On Wed, Oct 13, 2021 at 01:57:59PM +0000, Abhyuday Godhasara wrote:
> > Hi Greg,
> >
> > > -----Original Message-----
> > > From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> > > Sent: Wednesday, October 13, 2021 6:36 PM
> > > To: Abhyuday Godhasara <agodhasa@xilinx.com>
> > > Cc: Michal Simek <michals@xilinx.com>; Rajan Vaja
> > > <RAJANV@xilinx.com>; Manish Narani <MNARANI@xilinx.com>;
> > > zou_wei@huawei.com; Sai Krishna Potthuri <lakshmis@xilinx.com>;
> > > Jiaying Liang <jliang@xilinx.com>; linux- kernel@vger.kernel.org;
> > > linux-arm-kernel@lists.infradead.org
> > > Subject: Re: [PATCH v4 0/6] Add Xilinx Event Management Driver
> > >
> > > On Wed, Oct 13, 2021 at 02:59:21PM +0200, gregkh@linuxfoundation.org
> > > wrote:
> > > > On Wed, Oct 13, 2021 at 12:27:58PM +0000, Abhyuday Godhasara wrote:
> > > > > Hi Greg,
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
> > > > > > Sent: Wednesday, September 15, 2021 6:46 PM
> > > > > > To: gregkh@linuxfoundation.org
> > > > > > Cc: Michal Simek <michals@xilinx.com>; Abhyuday Godhasara
> > > > > > <agodhasa@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>; Manish
> > > > > > Narani <MNARANI@xilinx.com>; zou_wei@huawei.com; Sai Krishna
> > > > > > Potthuri <lakshmis@xilinx.com>; Jiaying Liang
> > > > > > <jliang@xilinx.com>; Jiaying Liang <jliang@xilinx.com>;
> > > > > > linux-kernel@vger.kernel.org;
> > > > > > linux-arm- kernel@lists.infradead.org
> > > > > > Subject: [PATCH v4 0/6] Add Xilinx Event Management Driver
> > > > > >
> > > > > > This Linux driver provides support to subscribe error/event
> > > > > > notification and receive notification from firmware for
> > > > > > error/event and forward event notification to subscribed
> > > > > > driver via
> > > registered callback.
> > > > > >
> > > > > > All types of events like power and error will be handled from
> > > > > > single place as part of event management driver.
> > > > > >
> > > > > > Changes in v4:
> > > > > > - Rebase on latest tree
> > > > > >
> > > > > > Changes in v3:
> > > > > > - Update the commit message.
> > > > > >
> > > > > > Changes in v2:
> > > > > > - Removed updated copyright year from unchanged files.
> > > > > > - make sgi_num as module parameter for event management driver.
> > > > > > - Use same object for error detection and printing.
> > > > > >
> > > > > > Acked-by: Michal Simek <michal.simek@xilinx.com>
> > > > > [Abhyuday] Michal suggested to merge this via your tree. Please
> > > > > have a
> > > look.
> > > > > Please let me know if there is anything required from my side.
> > > >
> > > > Ok, I'll pick it up, thanks.
> > >
> > > Nope, I can not as for some reason it all did not show up on lore.ker=
nel.org.
> > >
> > > Please resend this, with Michal's ack and I will be glad to pick it u=
p.
> > [Abhyuday] Sent v5 with Michal's ack.
>=20
> Sent where?  Do you have a lore.kernel.org link?  Did you cc: me?
[Abhyuday] I added linux-kernel@vger.kernel.org and linux-arm-kernel@lists.=
infradead.org in CC. also  added you in "To" for v5.
Please let me know if require anything else also.

>=20
> thanks,
>=20
> greg k-h
