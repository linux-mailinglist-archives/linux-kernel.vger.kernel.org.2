Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6A031A24E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 17:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhBLQD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 11:03:28 -0500
Received: from mail-eopbgr1400128.outbound.protection.outlook.com ([40.107.140.128]:36150
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232277AbhBLQDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 11:03:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqMgNdNO+KLzevFlNrqbxMb7CUFfRrWPtxaxGAi8Pn6LrcPPG08UjguCF7u7RTynHKtUqWsJkfn/5cTUFj7E2fcWGg6TWJ4A+YseGLV9lTmfnN94huJupvStCUtKCVBOXl4pQgv7duacQP7gtFAFBp9aP0efHNIwY/WqG+oDHY9jB3t2XJDgUu2unAtwfmAp+8L1ihJeVoSamoRvSj65pmMo5f54YFo6hMK/7Xqb5RSbR+tUQsvzoiggZChqG6S5b49cA9TT/2cElrepxvMElouHrScgGuiVAHXW7G6TiFjdeOsbbJwShEfRAbedvrInMQHYT24A7inlPUjLH3K3kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elAKTtKnMul1V2S+WqmOMwLgSdpbVxwbXQrXmdn2E8Y=;
 b=MgfiKNpDGQ7/Q9rwDxmgy6Kw9gN01hjEbHXYpndNRx/OoJ4p74ZHWziX5zDCYsA5XMoNpr9q+Ql6JlNbSYzjrrTa7QABpd8CGG+ygF5IrMorjiaeBtDbgpNF0hUZBTdMPendMi1tcf0661Nz7BnOqWbsbj8Vh5tB/BAB2pWTL1by/ruIaebxmMvGR9iLfcIvfRWb43x3TYYNNbawHOW3zGqlTDKUPddoJutzAEnV09W615iMY21KjdCTamhb6c+K1n7GvSrphIAbjHT7/bTE6i1E2OY6qBLGT39mDqgzK3DErY8BVD9zavbJoYa6KGwHXEkGgZnVqk6ExPAyjUUNjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elAKTtKnMul1V2S+WqmOMwLgSdpbVxwbXQrXmdn2E8Y=;
 b=R2CmobvbEIHoXr0mh4XqpO/5YkP1eAlKwHla2MpNycNyVSf4756KD/QSGL6n3VZVLrla5lOIrMRElStGIVt/rQPsal/XPHjUk1iwE2zB4TRp9eWUDqW+Yvgu7IQTEUnwc5dVn1jFQnSTl6a6a6eiEwDNQ1vYUIC1IGhS02zzMXE=
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com (2603:1096:604:7a::23)
 by OSYPR01MB5509.jpnprd01.prod.outlook.com (2603:1096:604:92::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Fri, 12 Feb
 2021 16:02:15 +0000
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::1971:336c:e4c0:8c5]) by OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::1971:336c:e4c0:8c5%3]) with mapi id 15.20.3846.029; Fri, 12 Feb 2021
 16:02:15 +0000
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
Thread-Index: AQHXANy3Kc3xxVsbt0Wl/bCSqSMNqapUIqQAgACD5GCAAATlAIAAAqeg
Date:   Fri, 12 Feb 2021 16:02:14 +0000
Message-ID: <OSBPR01MB47734853C9CAAE5AD9C4AD0FBA8B9@OSBPR01MB4773.jpnprd01.prod.outlook.com>
References: <1613092575-17311-1-git-send-email-min.li.xe@renesas.com>
 <YCYwrNE8547uuODo@kroah.com>
 <OSBPR01MB47733A5CB20E20E48EE84602BA8B9@OSBPR01MB4773.jpnprd01.prod.outlook.com>
 <YCajam09pnhVHqkQ@kroah.com>
In-Reply-To: <YCajam09pnhVHqkQ@kroah.com>
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
x-ms-office365-filtering-correlation-id: 77e9e5d4-fdb1-47f7-b7aa-08d8cf6f90c9
x-ms-traffictypediagnostic: OSYPR01MB5509:
x-microsoft-antispam-prvs: <OSYPR01MB55092B6FE5B6CD795FEDAC9CBA8B9@OSYPR01MB5509.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uSOAFrD9dPDREE0Bg3rMzN3oLSgzPcG7wvoxfUXhY2z5v9EwlxPIaKmtWIICTczZf//4QNk8sinCmIP2Vwyv5AaJnp6QVwp2TBcqU/o4Gf87Yz2135hqBpiGKgmnHLh032sN4gc4/xfATbARMYjjFAF5bBs/IEEGuHQnWmkCVv8ls3luQXN+6z8zdn6VkcpuNomQBB+q4TSX/4IsHTDcijzTo8qaVDF/tMM1T0qLgWuQk0hWr9OLR4qh30yhBHeZNmo1D2rrQ/NIttrm2wCDv+KJGO6dG7uh/+l6EyZEsZJ2Y+jg9tOM584SLC+HIAHzMEbBJJdavDm4pIxZl3h5h6B23G6zS2EnGiQYHkTD/8twjg0jmymXPnVnLWm1pliV4dimT01r8OS7y92qLy2guKQOgr3fS8NfBl7FCU0MME37QxulM4A6eRpnUDS6GhFqFa+H2pycPaqsPG97eH+kix+Wom5J1mBBugNP3eyIWPfnRc5Lh3nGPulMuAas9xHmXZ+XpFARv9e/VeSVdsTv/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4773.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(39850400004)(346002)(136003)(26005)(186003)(6506007)(2906002)(55016002)(54906003)(86362001)(66476007)(316002)(7696005)(9686003)(76116006)(478600001)(5660300002)(52536014)(71200400001)(64756008)(6916009)(66446008)(33656002)(8936002)(8676002)(4326008)(66946007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?lk7RvqtBx1ImiOMqE6WGOzKdMx+4u3qKjzXgjoxUrf1eR84CJOlkG9TM8DKM?=
 =?us-ascii?Q?jXaPllBXV3DIsLjROFD0wCQyYwpaE2h0/O9cFwMkXJ1GZg22LQVbGxf5jhg2?=
 =?us-ascii?Q?h3qWXwZKV8746NfQQCFupgpjearSvMaLW7gtWEMPi7xSMmCdUQNTgX7kFHz6?=
 =?us-ascii?Q?UbrXH6FK2bSnTbpTRknfk9QZOrtcWhYHPISKgjmfi/SWqn6tvneYVOid84ei?=
 =?us-ascii?Q?d0V6mKQcAJelCQbOLPS71xkaZHGG7Ipnzqnpc8rADtDELm8EQXkzEj3sWxMO?=
 =?us-ascii?Q?8K3PA1r+8RZBp/SC/Rq4tI8ail0MPfnGffvD6JdbLJw1mi8qc7bLFtEUFnOV?=
 =?us-ascii?Q?ANciGXBwKWckhfxVCfv83scLsnFlCygs54lZysn7JGn6c+a1x9ENWSoIvznP?=
 =?us-ascii?Q?VkWznQfsxEfaI7dvBtr5mOxyEhfnOk3/VWQDNP2lSeYnmke7yWLksTtchrY/?=
 =?us-ascii?Q?kcMfAQynUASkdVBDurXKx+01uC5hsNTBVA4QyrF0tB8Co6AYWPzARmPViW/z?=
 =?us-ascii?Q?6wLtK/uwlhbFfF3+GUebO9A/hGI77kMhudmThKZw17GDGVanmXwwy/l1S/kN?=
 =?us-ascii?Q?TDsr5q8K062bx31Pzh3NTVmYp6Jousgy44Hz7ck5pnTw4kN4wo8FLiuzrmTW?=
 =?us-ascii?Q?dO7E4tFenfnFSIO/CEo4qH86ckhsHGBxZkDY4JJ98XmcEKIKEk6uluHdyABs?=
 =?us-ascii?Q?lfHzKmmT0e7kaNplRgQ4gLp/DIC9TqojovJBWfVk1f83y3/2T1R6TGLEtnIL?=
 =?us-ascii?Q?bwvBA7zqPX2TsZ68GdzKO5CxxD4LJKln+VIHNbDoySWbKb3h1Vzj7UL+fAtO?=
 =?us-ascii?Q?oeVnkB1bcr6ddQOuLmmELA0o0YHtkoY5ER7Vnk7aLufJFWJuugmZNubdQRRY?=
 =?us-ascii?Q?c/M+YmMxlzXyxsj5y3dCSQkPCnp078qD+0iZoS/jImEgoZMciyW9yr7W+bav?=
 =?us-ascii?Q?WbQTS0ZgusBXGQ9s1ltlpASsBx+RsGAEP2h/FhajTO2Fqscsxsqxvy4qUr3/?=
 =?us-ascii?Q?IZ4nyURxsOC7J0uziujJIUybfiqWbaLxVs3PPGPhkI8oyseMWxNvn/6NoICO?=
 =?us-ascii?Q?2ZLcguQZxYCSpiYUdJsKXX5M5RBthAt0AWNtv/y6OMzSKDArbsm7GUt0J+bd?=
 =?us-ascii?Q?BqYy5HGzR48YUJ4Iz5RW2FcPDL0YyGT5IikRM0Mo9D5jIl52SLFlA3t7tugb?=
 =?us-ascii?Q?LlEzXb+oKWEQcaj2r+SxprGLN31853OefcIylNgRg3z6fqrQC1/BQRvyue1G?=
 =?us-ascii?Q?7xXmy6YC++Gfgf+xf3w1CYYr06xLmPh0F/Vnbnq/ZXhrnVIFpA6JhSODdsgk?=
 =?us-ascii?Q?VirUq3neUp/zHIBI2hC+oAMI?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4773.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e9e5d4-fdb1-47f7-b7aa-08d8cf6f90c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2021 16:02:14.9054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EXGBdoJJ62PnxDJtYolG08KHkaLEsrD/nz8Q3Ups6WGTf9IMxBb+7/De9JVWYCGEbY4AgawtlY6NAf54GvdxdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5509
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> xilinx_sdfec.c has:
>=20
> 	static int xsdfec_dev_open(struct inode *iptr, struct file *fptr)
> 	{
> 	        return 0;
> 	}
>=20
> Which isn't even needed at all, but it is NOT trying to keep people from
> calling open multiple times.
>=20
> As for why the above logic does not work in your driver, think of what
> happens if someone opens the character device node, and then calls
> dup(2) on it and passes that file descriptor off to another program.  Or =
just
> calls it multiple times from different threads in the same program.
> The kernel does not know what is happening here, and so, "do not allow to
> be opened multiple times" does not do anything to keep userspace from
> actually writing to the device node from multiple processes or threads.
>=20
> So don't even try, it's not worth it.
>=20
> > I mean if an application failed at opening the device, how can it
> > proceed to talk the device without a file descriptor?
>=20
> See above for how to do this.
>=20
> thanks,
>=20
> greg k-h

Hi Greg

Thanks for your insight for this. Now I can see this change doesn't prevent=
 deliberate hacker from opening the driver multiple times.

What I had in mind is that it does prevent some unintentional mistake like =
some one accidentally opens the application twice. The second
one would fail due to the change here. =20
