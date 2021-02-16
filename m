Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E23B31D137
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 20:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhBPTvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 14:51:45 -0500
Received: from mail-eopbgr1400129.outbound.protection.outlook.com ([40.107.140.129]:65309
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229572AbhBPTvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 14:51:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvUt6iIy1n8w9tYsF8uJ7UNA2HGSSbgjngOjV4VBnXbdOlixu7SQZGxEYW4enpOO40LiShzPF3a/HCqP0wD3iBlSNDzVRUqgo9nzdHPueyxysyuhuBUeLK1McULFLljA7Q8zyQ+MWlEX88kXK8/TnLDoOYf3Un8SEK/owspkcLbBEzO9WypJw4ANtokFptRAlY5rhSVYdm/6E9hIOeyEb9wio/o9KwtUyyV/ZZ6AcNj3RIksZOImzwGf+5BQTfXcB28eZXiNpfWWvF9a41elQH157VB0mRy+1VP1aJLN6sh3EyyiEUA77YC3VNs6SfhDuWJCmiSXDREwLK0oVy1xKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/3w1CU7jSRW/ltVJjMev0k0mSmm8JdelOisr+/HHGg=;
 b=YbiDRQmluFNT8jCJqPHdtNBsCOFsFv2AJfVw1pzFQxvIriFc3AlKzv++OxybAPDD7RrB7vhaTRsBx0xd/UDTIU3ME0n6UmPEJr3C3ZCaZ/LnUIsDAHoqX2z+R1xPp3BO7myzxu3Xut2rSBvFOXsNE0NyqFPDyJ1h8mmf46mU1rj1vFfUvUthT0vR/BoeIMSfbxneINjlvVYXsZv/jmP0K2/eFi1BI3p8S51Gxpkw12fxw1FDAxG4IiGs0Ld94ZHn2FOXYUAzVQ5jAiS2YcYBWSFYpoEVWQ7Sgrdhkutpc0z0zOcGzYxeYOsRxTbO/1QTAhkqlk5v4vNXrySaBrO08g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/3w1CU7jSRW/ltVJjMev0k0mSmm8JdelOisr+/HHGg=;
 b=Pnq86CPmm0Rv7S7sRAp1aM7LO6DHl9dKU4KOimHR7Z8XDrCtGIpCpyopNKvCq745SNwMvtsJGUfCQWkN9B6B0opfCGxXCYWh623sPM/iBOVf1zrs5smmYAjaBrXMrp9CmC3rlTEPfh5oz3V2KI7KJmQSVl0azSbpQwmNnzKjWh4=
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com (2603:1096:604:7a::23)
 by OSBPR01MB3767.jpnprd01.prod.outlook.com (2603:1096:604:46::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Tue, 16 Feb
 2021 19:50:49 +0000
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::1971:336c:e4c0:8c5]) by OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::1971:336c:e4c0:8c5%3]) with mapi id 15.20.3846.038; Tue, 16 Feb 2021
 19:50:49 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2] misc: Add Renesas Synchronization Management
 Unit (SMU) support
Thread-Topic: [PATCH net-next v2] misc: Add Renesas Synchronization Management
 Unit (SMU) support
Thread-Index: AQHXANy3Kc3xxVsbt0Wl/bCSqSMNqapUIuqAgACGZWCAAAPqAIAANK8ggADgqgCABXPvoA==
Date:   Tue, 16 Feb 2021 19:50:49 +0000
Message-ID: <OSBPR01MB477356F3FBDCB752286C65D0BA879@OSBPR01MB4773.jpnprd01.prod.outlook.com>
References: <1613092575-17311-1-git-send-email-min.li.xe@renesas.com>
 <YCYw5xXe16fSj6eI@kroah.com>
 <OSBPR01MB4773472EE0C8D34456C79121BA8B9@OSBPR01MB4773.jpnprd01.prod.outlook.com>
 <YCak7Eu2X0dzapPz@kroah.com>
 <OSBPR01MB47733B3FE2242E0338DC5983BA8B9@OSBPR01MB4773.jpnprd01.prod.outlook.com>
 <YCeNlIDDO+2SqNkx@kroah.com>
In-Reply-To: <YCeNlIDDO+2SqNkx@kroah.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=renesas.com;
x-originating-ip: [72.140.114.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6bf57a93-de03-4909-804b-08d8d2b428bd
x-ms-traffictypediagnostic: OSBPR01MB3767:
x-microsoft-antispam-prvs: <OSBPR01MB3767028C2BE58D76FA093F40BA879@OSBPR01MB3767.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vIVi2D6SCCEmXXPzr+2S7Uxpb7IgLXexP3PpmnH+/g9fzKIVwHrsQDFW1Ba8xTL6K7VIYJ+fLpP1y9b1LVtD0J9wLhiPXmB1rQkouMYE9dtYT1MluEpD9gqqQ0SbdVFaThXffvoYSKcjptO5k1SvNOGvcNn5TF9/n4V2wDxI60Q+RnlfhT5Mg76+CyX2GFxB03tCvCkwIzTS05uA7UfJR38YFDp4zlKkrYpc3PkRn3I/YnFaZtPGBhzH9PJ4FiDpSGce2zOj3uo2qf7EpyQqMQuu4GQMVz3wHkTvTtv02qovALYrPTQp/ivCToufGi3pql7kj/5rhyosKwwBrfeE27sUO/yvKV2mlwJNOlbxiuRwuldRRtjpb2tUtndQvOuGOvBLaRklKFl1OJUSIgwJmjOgybkl/gn1R8dmWmevbgku13kVXW/Okhz9g+nGCl/76FVsvCSCm0/vWeMtko+nWKj4nvoImwVhWLV2xl27R50Afw72SH8L2r7+CIk9Z1ui1gYYgKSltZwa2NbpjlPXig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4773.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(86362001)(33656002)(6506007)(478600001)(186003)(4326008)(66946007)(6916009)(8936002)(4744005)(2906002)(54906003)(71200400001)(66476007)(7696005)(66556008)(26005)(5660300002)(9686003)(55016002)(64756008)(76116006)(8676002)(52536014)(66446008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?xipuKPcuwHVqXGctDNrlONqoFPSHunAsf7Z8XLdknhqT2p3yFwqxlVuuc+B9?=
 =?us-ascii?Q?N98OJx//NzZXTmXj++gKMH8v6MuHIc7NkaN2KWbF3VkyvVk0MNq9yMC09AX4?=
 =?us-ascii?Q?Ta34iw/agEXHudeIekbVCDkOXDsqdsIVuzfCuoihm4m9WUC6yWqHPculcNar?=
 =?us-ascii?Q?WdG6YiIrAjHda9lp4vBFECT++xJnZ8v3Q92XnjzNHyKrhyijav253soW5OgU?=
 =?us-ascii?Q?pIRzzlR03HuYNDyVJ4VXrjOh8Gg7Q0oiziMUc3vDDfL/WsqYUjxgMHlkr9Qm?=
 =?us-ascii?Q?DQNIABbgzKgSBvAixhGPIqc0gzacZJeQWhwZVE22RmYpRkZzLv9ziwrd6kAn?=
 =?us-ascii?Q?GI4x+TJNL5PXL6ZF1it7xNdHtVPT4CzgyHAIIdBvoHJb2XZbe1eSdJafW8tZ?=
 =?us-ascii?Q?MAtodOT5tLVwH73fLw0k3JhpbPR7oL6irOTxKBLKQ5q+yYeSviGRqH2gZqsK?=
 =?us-ascii?Q?bQDLRSk8yKrCHzER3YNIg0GqTsK6MrZmUMU9RcjqAyRwnTGWpq/3ICN21reD?=
 =?us-ascii?Q?4tM4JneJbgPo0gkVRRhF7pqCMq5IRnYkOTiRezcqq4LRY5LYMFlxZMXj1goB?=
 =?us-ascii?Q?tt0Faup0s4Zy9yx7oEYzthxiGyKNjUhN/vS6A0uHNodXbitkoQmPCUP0peTO?=
 =?us-ascii?Q?b1gEzx/jJgFkiPvHi0Z289J5VT2YKgBml7HhPZwN4Ev3IHCi1KuQxBiT18AB?=
 =?us-ascii?Q?e0xuUOSU5pPSqSYbizhL+kCqqkdQ89lZ+YhrI92y2kjYDjinrTqKzkro+j0u?=
 =?us-ascii?Q?09i0CCdNb7hhrwjbM0Q9boHj9kNNwALdlaNjEt8lZUJ565WQ3Ckkvbm6o7rS?=
 =?us-ascii?Q?Nq0nEmeOjmgz1FCroKcPmZzh22sS7STB4lAp6PVj/mmtIbWax0BwPpSlZkoU?=
 =?us-ascii?Q?cS4U1X2iG860mJ87oPUyiPYr6s1sREllVzVSjq2nJ+wGEWmtgnUNXm2SAbFA?=
 =?us-ascii?Q?wSQ4Nde9GBOz6IvVNN2syVt380JKU1TiFbkqMExFr/yPOnWSoPFGTzwbKYqL?=
 =?us-ascii?Q?3lNLisQgAyWQUzgTrRQJc6aAMD80BeO+zewyNMsQGqkeLPzo7iv17tiKs8nl?=
 =?us-ascii?Q?GJhpBsPvThaVrfQ9NbwMkZPFrn2oce6ikeMqBENb1ZWAnwTmPckblZ0g4IET?=
 =?us-ascii?Q?iXMwmoCi6M79L4tcb5yUyz8+qi2scCJDsfsTonpE39PuUA6M16Q+h7XpxB61?=
 =?us-ascii?Q?dyWRHCA/8yAD2NFrd5TzTAkE1SqDTYK+QBJWPu3I5nMpUZflbVbiW226qpVG?=
 =?us-ascii?Q?CAU9ZKwTqwbBQo08/TqKdaAueHU+6HjsnLVtc5dv7nZ9bDb/k+gBXK6Az0cG?=
 =?us-ascii?Q?/WNzAdWJVKzTeTrmYfnS6t3X?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4773.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf57a93-de03-4909-804b-08d8d2b428bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2021 19:50:49.1249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LixSUshKVSRyY6juUNK9wFvO6PvTpxAGRhGqaC7R2gro/lzxJ/5r58NKqKU6ekIf1vCLay9coFE2mOIYA+hnJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3767
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> Yes, that line.
>=20
> The documentation should tell you how to do that, as per my patch bot:
>=20
> - This looks like a new version of a previously submitted patch, but you
>   did not list below the --- line any changes from the previous version.
>   Please read the section entitled "The canonical patch format" in the
>   kernel file, Documentation/SubmittingPatches for what needs to be done
>   here to properly describe this.
>=20
> thanks,
>=20
> greg k-h

Hi Greg

I read documentation. Am I supposed to add the "---" marker line manually b=
y myself when doing "git commit --amend"? git commit will
always add a "---" marker line before the actual change like below

Signed-off-by: Min Li <min.li.xe@renesas.com>
---
Changes since v1:
-Provide more background for purpose of the change.
-Provide compat_ioctl support
-Fix ioctl cmd definition
---
 drivers/misc/Kconfig      |  13 ++
 drivers/misc/Makefile     |   3 +
