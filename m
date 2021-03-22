Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1DF343FF9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 12:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhCVLgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 07:36:02 -0400
Received: from mail-db8eur05on2053.outbound.protection.outlook.com ([40.107.20.53]:1059
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229987AbhCVLfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:35:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hf8rfqbrmCNcieVUKDVaknxsgyo/WJkk+/mw4PVO8f99iN4icoTbUcKdHZ0XANFAeCzBmCkcODHouzSqDorvIrlaxqu3qVkekbvfdtRZ0SwmQPJqJikCNoMU1znjCswSUfs6CWcz49rBEWbGrva3Jax7EFSWMr4VvgwFTn8OjJZmjFATWA84qfoATGv/bOwD3FDZq1fXGW35cBohzjt1z3Hfm2qWDw19AW97/LE8MmF3BbF5vmj9XPYjclAnQBqLyql0c5ieW2jKYR+XbI8j6Lh4FSM8rMz4MHuIbwD6FqdRhzYZqQLAK8q53WjPP6qIfasc2BdrC2pE49J8jGa7Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBgiXRxGhAFOJwluoufcP2RRfgcccW5C+rozlZlvpv8=;
 b=F+rZal9vNZBVNmOuo4NKbWy961Uta1bpbyjzITcVX+UaMe60aTybFwKGvmRcaGb3Tmc/D+7HfMaZ1+XFknmNcaOSK7Dcm8jC1B3wMsSmo2XYmrAHxeq9Y0CIoWEziTGgrpn84QTQhZMT+Ml4gBiii3v70eoQ5WYVLzs4vZwy4TuaKld/h3uUuBrOQfUJtGyyzOtAoetHNHcmlnYnwsg1RzH9BRcBY4UgJzn/0XKc10r6053V+RvBWUuiwmVN+KWqgQGG6F9GxFMqJT5KdkH+0p9+ZwWG/Mnh/erg+6VXgepl+G5bq1WhewSDXwlsaDMxb6+rc0VwwkVG7K0VdFiFRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBgiXRxGhAFOJwluoufcP2RRfgcccW5C+rozlZlvpv8=;
 b=koG0Cz107/CWqGp0ut+pPXAKb68aHT7CUlMoYOkhDTaTVKro3hsXEiaoXS2zo8bdNHwT5Ph8ruTs8JqN81vHMX4T1BxSKyWIbaBj7BQeFzLw8B2Mw30VIGEoW6ZxvtlDg837Kybbbc/mI6AOXWg6sUpXS8vR8gjxWiFDKyr08HY=
Received: from DB7PR04MB5322.eurprd04.prod.outlook.com (2603:10a6:10:1f::15)
 by DB8PR04MB6940.eurprd04.prod.outlook.com (2603:10a6:10:11a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.25; Mon, 22 Mar
 2021 11:35:46 +0000
Received: from DB7PR04MB5322.eurprd04.prod.outlook.com
 ([fe80::7c4b:7e9d:a414:d34]) by DB7PR04MB5322.eurprd04.prod.outlook.com
 ([fe80::7c4b:7e9d:a414:d34%3]) with mapi id 15.20.3955.024; Mon, 22 Mar 2021
 11:35:46 +0000
From:   "Sahil Malhotra (OSS)" <sahil.malhotra@oss.nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        "Sahil Malhotra (OSS)" <sahil.malhotra@oss.nxp.com>
CC:     Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] arm64: dts: ls1028a: enable optee node
Thread-Topic: [PATCH] arm64: dts: ls1028a: enable optee node
Thread-Index: AQHXHw+A8sKUEAWuw0Kyz3ixI5eK+w==
Date:   Mon, 22 Mar 2021 11:35:46 +0000
Message-ID: <DB7PR04MB53222C380128CF22C81485CC82659@DB7PR04MB5322.eurprd04.prod.outlook.com>
References: <20210305083351.13598-1-sahil.malhotra@oss.nxp.com>
 <20210315042821.GC11246@dragon> <20210318084029.GY11246@dragon>
In-Reply-To: <20210318084029.GY11246@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.64.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 70b0fd70-f18f-46ef-d5dd-08d8ed26a2be
x-ms-traffictypediagnostic: DB8PR04MB6940:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB6940241C9F084D81B89B4EB0C3659@DB8PR04MB6940.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e2J3gVFKqx2mmYLuiyHHxGQcV5a3YvK2xORWSKYKtYSjjEXRcuU2kX2ib2IwJ4XEpFPyn8wen6Tb4j2s5XOXl7zsAiQiz023I6YeYLRDpC14khPOJpRH/ZRDqjGH/cEk9RKWVaOln4cPmSdVD+NiiDDp2sBSm+7Fp80qGEH/rGU95xxlOiWvVzY6gRZbO2UmTxcrgiHCXAqatk175FisQjRajTnmt2FXqHQAoVvne5DtSpdDoNHwG4dzKjddIaPnOZJt1bJId9pA9h/FCLqBpruPQ3sFCdvm4Tn9f3FzGmJ+rTbJG8UtnhsPwaHXCvGlT77oK8zJyDpXhtCy1YPrZu7egLHAUJQTErvQ+hJgKWyVpOjYEleJob91qdwVbhKVM96BFsi0o9eYXNQZ3FNQk+lTIQ+Vxh/e5y/FiX9lq2J20zMs1PsWaTVQYRMrmLwYuHSL8A/a7tKJFc8ZaNdbRxb3DgfEqpk4G0Dqw1LNl1xgVAOWakiuApslwGJ741wT+KO3XcbPJlT64kE3b2QbQo3MruYg5HMyuQYEfXU6X1895EDM99SGmTm/WjGGUA7DYCKQdWjQsXDtuHijiUhEJKYJwx/vVNa8UwORjBuob7KrtgAVfGbmX852qsrPCSLu5KXv1g0za4atc+mGBPZoHHDssGGo/Wfr1QK0n55fz7x/+pudFOUvrbwLzVoxgMxvMUDmfxWu0cXTEBuGYDjaqUT9mN6oa3Pys2xLUWuES1g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5322.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(39860400002)(346002)(376002)(7696005)(4326008)(66946007)(53546011)(66446008)(86362001)(6506007)(4744005)(478600001)(966005)(76116006)(66556008)(38100700001)(33656002)(66476007)(64756008)(110136005)(52536014)(26005)(5660300002)(55016002)(316002)(83380400001)(9686003)(54906003)(8676002)(71200400001)(2906002)(186003)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?p711v7wy/skX3PydSv07v2+iaS/2W6Cx4PwRkKe0C8VdrXERja8HFbu/nG1u?=
 =?us-ascii?Q?8ilMQNLmEvsstavnR7YODlv3OAYt12NDWFkilUlJJ+cg8cj6nhOsftJnw9Ii?=
 =?us-ascii?Q?5fCQ0yNc2mSlQKaV8r6rE0jDXQq2KD0eS6svX+oprC+ogffTSb/LbwYCuvxv?=
 =?us-ascii?Q?SIrSYoHJklESC+5lJB2F0opph7r/mJq6dCnh5pKp+k3Zy265ZemsfaBri2Do?=
 =?us-ascii?Q?DT5r/Lujl49LEvHph3jruXiOUJ5tzKslM4pQsX5ushwyen2KPpAMV5h+l68b?=
 =?us-ascii?Q?PQNdamGA/3lDww91X71k2NNvbUXdJ4HH7ngICG3ejqpmlkfNo3gDSzADmgRU?=
 =?us-ascii?Q?eokIXUqWuHU1nU8xU3iZKHuMYMdl1YwzAoZb9U7GN+Oq2tXuvTcSQ8guGh05?=
 =?us-ascii?Q?KLD3bCXvaXga6M1YBFCJSSWtlWFhNg+bG8+jNQtLtvPjEamX5OApwN5SBgUD?=
 =?us-ascii?Q?m2wAw9FiEwhxosBuzyfin8CuFvSNDGLmbTucLmAHSYcKg0MZPXvy9YzBBcYo?=
 =?us-ascii?Q?39O6jfmuZYBPg4E5/LL3KmRZDz6fdYVFlFC8CrO+ekdnTz9T2oHmgXPAGvTy?=
 =?us-ascii?Q?2M87KJJfYn+oJRm2P4m321wPq0pdexIWNOPUHbWr3PrZz8PFgOFgsTz9joQp?=
 =?us-ascii?Q?5pcOLxtOf9P6bPJfvEbULUe4cdOUK75nNs3nOGHDTNimeHfhBq2c5C0ziO0x?=
 =?us-ascii?Q?CDtziH8kAZoacfuzLhaAGCIkLxi5vvmOeLWjC9QnAqZhHmAYydwtRUIITcyw?=
 =?us-ascii?Q?tE+mSazzD3OfRJTkxyHHIDsXPdxvcjf3h1di+TM6F6ysrAhlj/fd7UDPBCnb?=
 =?us-ascii?Q?xi7oToVoB8TPrG4ZJBXPeA7lhnojGAD+R6OgnWy/Nob0fGXGcA4BK2HSKw0c?=
 =?us-ascii?Q?zAIBjpLnonBFOLKv7ApFEgAc6kCaRcWJGjv2BP1RUPWXLoS272+BWyAc1azK?=
 =?us-ascii?Q?TM8qxJw2WNYGxk0NwhrMjIdtduGvCegafQNuDe4YUvijUMKpZZGZQC6yRCXt?=
 =?us-ascii?Q?P0GnnbMNYEbUsmrqJXj33cfA9LOKTdnB8fo69hCpy6ywFb5HLgPAfexnTNsN?=
 =?us-ascii?Q?u3M07cilY8vlvqSQBv0tGuhRumbxju3re9mnLqabXNodhRbualemQiDWOIds?=
 =?us-ascii?Q?d3JIx125N7w2ZL1mAWnx2BphUvR5nsNsKDKe0HBODnpclfzc+j5zxxOQmSPY?=
 =?us-ascii?Q?9k3Z0gWglMnbHPX2pGXLirSVZNNV4NQ8W96PhZ58AFxLEf1F+3fydDxLa78a?=
 =?us-ascii?Q?KF56SAuQnzacrmQZSt69qWSfxz35pPEK2mhpoC2G+t1hRYxShUzm+CV5rvnm?=
 =?us-ascii?Q?w9EKAzAq3frqlA7WKhp+AXVj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5322.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b0fd70-f18f-46ef-d5dd-08d8ed26a2be
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 11:35:46.6601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vqr7k8+tTmvJVPolFjxJLt3ag1MXc+0A/vEKLaupTniYSnXLhOfkV3xLyD6Rry6KriMbZvNqPd9ciNb9MjFsRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6940
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

Which OP-TEE version is being picked up for this CI ?

Regards,
Sahil Malhotra

-----Original Message-----
From: Shawn Guo <shawnguo@kernel.org>=20
Sent: Thursday, March 18, 2021 2:10 PM
To: Sahil Malhotra (OSS) <sahil.malhotra@oss.nxp.com>
Cc: Sahil Malhotra <sahil.malhotra@nxp.com>; Leo Li <leoyang.li@nxp.com>; R=
ob Herring <robh+dt@kernel.org>; moderated list:ARM/FREESCALE LAYERSCAPE AR=
M ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; open list:OPEN FIRMW=
ARE AND FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>; open l=
ist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ls1028a: enable optee node

On Mon, Mar 15, 2021 at 12:28:29PM +0800, Shawn Guo wrote:
> On Fri, Mar 05, 2021 at 02:03:51PM +0530, Sahil Malhotra wrote:
> > From: Sahil Malhotra <sahil.malhotra@nxp.com>
> >=20
> > optee node was disabled in ls1028a.dtsi, enabling it by default.
> >=20
> > Signed-off-by: Sahil Malhotra <sahil.malhotra@nxp.com>
>=20
> Applied, thanks.

Patch dropped, as it causes regression on kontron-kbox-a-230-ls [1].

Shawn

[1] https://lore.kernel.org/linux-arm-kernel/38c31f5c-4400-eed7-d561-8f45e2=
61ab01@collabora.com/
