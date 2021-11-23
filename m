Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E64545A372
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 14:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbhKWNJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 08:09:40 -0500
Received: from mail-eopbgr80044.outbound.protection.outlook.com ([40.107.8.44]:38669
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231255AbhKWNJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 08:09:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdgDCOm8fVm+QgTD86Ad17SxTPOhjBxOYqXAYRffUc9L8ZzmMfpcbXS56feLWWKIqIfRwH4wgmDYKXxM/2TBnZ2f5GWTLkAq16rM+VG0e63pqo5Y8kcBZAylsXYWC101WcwxntOJvB1OUds2LNxQyYvvR8iZUMLH2ssbe4hgkRIHEWoaRA22/gDLAt5WGu/wrFIvLBYcQAHcJGaq8M9Tk62PwYisOpfgaptSLX0LorQ/Bkbg9NkfXxG5ZxQxFbbzbouP8LKHFKflUJrbFLL4CYkXn1YPAyoDFgG2xNEs7/H+h6t0l0BdjWcSBFJKcnUkoQOXycAgt9LYeLlD1jpv7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJoNhkkVxjOxVLby299am+mstgf/rFEAIOYsjhO+5mk=;
 b=cK9OFEwZgFrM/lXVzfw+J19alysvCL/ZrPUlcNVkPthczUZTjP3puyayfN39uNgE3Wefei6Vhl1xguu0N+YbzU+nQ8Yqqft/McSDf7DJLoG4/Sgx0A+9cyPiT26gPifrb+9v++F7GA97Rw1pjCzHgMe13I/nSE3lqRWpVTA7dJuGp0IOzDCGQDbztCO9ctALHoIrhbEkQZj3e1iVQBrPkQ8Q8CMGGc3Vsh4+og6n5XZqSwVOJBBkLz9xcW08UMBnhIpGrv9PLgy5p3JQdiM7F0IReXJHrRMWpZ7HpwwdWhmczBapOyjFyU1uOGXJ5L9nGcQ3QV1XJKf2CqXwStdYBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJoNhkkVxjOxVLby299am+mstgf/rFEAIOYsjhO+5mk=;
 b=qlBaTXMTf2CMXepznhCmivPL2RCbhg4+ZnbbvBtxdY98GgoN+fz6CTBVqkU3T3CPFgFiIL72bGgd6ykGg8tNjroBlA+VuwWLdI68ZiST7tEGUJl/GkGCaOuxQjtER8LGj4D8v/YEa/Cq4NlbWgRfs+rmaexYo4wd5WYOEZCQ0UI=
Received: from VI1PR10MB3167.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:12d::15)
 by VE1PR10MB3936.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:16a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Tue, 23 Nov
 2021 13:06:23 +0000
Received: from VI1PR10MB3167.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d15d:7ee0:39c6:4617]) by VI1PR10MB3167.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d15d:7ee0:39c6:4617%5]) with mapi id 15.20.4713.025; Tue, 23 Nov 2021
 13:06:23 +0000
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
To:     Mark Brown <broonie@kernel.org>,
        Adam Ward <Adam.Ward.opensource@diasemi.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH 1/2] DA9121: add DA914x binding info
Thread-Topic: [PATCH 1/2] DA9121: add DA914x binding info
Thread-Index: AQHX4GReCY/K4xL24kOKVfWBJNfHdKwRCvEAgAAHjnA=
Date:   Tue, 23 Nov 2021 13:06:23 +0000
Message-ID: <VI1PR10MB316716A5C73693A95EE120F3EC609@VI1PR10MB3167.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1637669927.git.Adam.Ward.opensource@diasemi.com>
 <49e5f47c79c0fc1d2b52ffdf7f5872f0adfa5ba5.1637669927.git.Adam.Ward.opensource@diasemi.com>
 <YZze1uynsB+d1YWx@sirena.org.uk>
In-Reply-To: <YZze1uynsB+d1YWx@sirena.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4fe0fe91-5358-41a8-5f30-08d9ae820cf3
x-ms-traffictypediagnostic: VE1PR10MB3936:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <VE1PR10MB393624A7842290F545D2C7F5CB609@VE1PR10MB3936.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: olf0IraDytFNY1uJSwVXgfsxwOCG9Bu05oZ2ZUXupWvnj0delr6560nrVXs0ABxlukbZCYy5dwdjxYst20U8yJak1BGGArG4arwpri0qLXDGE3sB4kqL2nT/alDT5o0/gO+zklnktb5BZOTGGU46B2ifskBQkbNiNKi03rExDaB/wYUrRKuN+FUSaxsNfaW6l6KiBkZpiMfMX+myROQp0xvv0D9vYhqex2qhuX2SCqJh8HPWHPtkIyN37M6A/E5nTDhaFBn8XdBo8uBBnIDDsS9eJ6/XdzsfMlWQW5T6esDJlj10DNfWvxg/Ind395KQdqX7MU6aj5I2k0BvHYfxxpRxLnRxBcTeEsRNNkp3mNQJ2HKnM33FLRtv2spVD46FTg0GFNvYxqisfs5zbV9iGnx+wiJ3DaAy/Ez+wqzVIVnH8XaGi1QaUOTKtx/msJ3b8UkAlCvdaYCwQ1W01gHSaxBDVEhaBSK9ymmXFqJCTNKnIEwSVkHdCvh1htHXZ4YhM++xdbmWbeIuisIaEpeisyfFqiQWeJVc8LjC0e55wZaWZWvY3gXqvqYFu0BVTqsTz7bPghzo8Xfs2czbSs1HE9W9pXj2/5zUuPZmmAf4QOkEe/o40z0+ISH9Y1c2vAtkJZuchMF3KwrpY2AA9J6Day8iKyfSg2Ok/rD9sfZZv1kdEaUjm9NJSrUXxdn1i5/2EXqZQVQ9fS4Kn3gnK42sPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB3167.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(33656002)(76116006)(122000001)(9686003)(508600001)(110136005)(558084003)(38070700005)(86362001)(66556008)(66446008)(66946007)(2906002)(107886003)(38100700002)(64756008)(8936002)(71200400001)(186003)(54906003)(8676002)(55236004)(6506007)(5660300002)(26005)(4326008)(316002)(55016003)(7696005)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R9hR05zl0A5fbLtlhZBOeO6Hr4Pi3a0wpFGZQ++/uKu2IBw6f+5JZSxZqNBa?=
 =?us-ascii?Q?BaoQlULmKAeenR+bXtwWTJ2l67lK8BQfYITkij9P0kKC/YO+7N1fO8wjl5Y7?=
 =?us-ascii?Q?5JLhZYB2OXWI4uqJBnWWRHqh7r/lSQnfzvKjwUl/wQAWyeqDxUyhBhrP5vdY?=
 =?us-ascii?Q?cp7At850xOWVqOWe2yL1INC2UegZQerXfjzkMoe1GAPM74VRWmMkwK8B0345?=
 =?us-ascii?Q?1QN4tjZ7Pb5OveA37s59hd4bGzsuFg1JonShVr0DvPFSxVLPa5FQ20b0YgBQ?=
 =?us-ascii?Q?5NKGlzspsTzxbSKg9cwgJ/0jrLe2RekVvJ8YwHU7DzsxpZksO9WQ8YscuhPq?=
 =?us-ascii?Q?h1lnyX+qMwMlCC7P5lvID9fReIzjFUDGFswvh4g5SyvOhe+CkjRtKiKp+Bmh?=
 =?us-ascii?Q?iAEDpSh/OZLJcYosgjVJPcmdcgh+fyXl9PenRHl85xVn0DoXNXMpmBhAXjp8?=
 =?us-ascii?Q?jjEh39aCDJ63Et0KCGHOEAvheQOIQijK0WR/m/ofgJfVMWdl9zf3kKrQokbC?=
 =?us-ascii?Q?6JVn8vOx5Y+V/gAnlY9dWuY6QiQ/5DAF15hJK+3rlJ9WrvfFkB16mMVsH6EB?=
 =?us-ascii?Q?kFRhRXwF8ujhcL7FNETQxs0yXfQ8QRrlBOAXz71J4Dx8QcQC3y20xS+13DGW?=
 =?us-ascii?Q?pFQPvFDmuyReCdmmwFBLU/ZLEPKFZxQYUSEUP03ATvE1USIvCsorxxBBFZ5j?=
 =?us-ascii?Q?D/4W2mXX9RKKQl542eDjQnJjLWyHjlSD2MXwAcCH3LhGcHLLyhR7s5uUZwQ+?=
 =?us-ascii?Q?otLFfQ8pBshaRBzEggIhSoEA01hQrxV2CNkNItrqjInxAdjcceW/oZtOroMr?=
 =?us-ascii?Q?3GrSrL76Wqr8aEEmrcfJATMzJgShhOnkanVsAxr5YQ5zVJXL4ydk1HeefZZY?=
 =?us-ascii?Q?MLaCCzKuTqnasv01Fv/i3ziq0xL1YobEI4Fe7bfzzcJLkbpE8H9vwruAMmjs?=
 =?us-ascii?Q?anlWOGPzKUNNaCbGJrlHVktSL9HCMNYN9TZ7mf+vHrDEPp4CgnCumz0aWuf/?=
 =?us-ascii?Q?cKJiwXB2K04CUigu0sbsD04/u3nqD+PR9AVSC4BsQjiDXNTpQaEeB7aOExCz?=
 =?us-ascii?Q?nkyu2QM6hukaEPdv+Zmm8cKWkPJ3m6sFsiN5Q9KIMv0d9mxbzob4M9ty/GMP?=
 =?us-ascii?Q?fKwPDLaxZGeJTkNoLdHIGhnvRUAGKtqnKGbdSYZxxxlQBFmaC6IN7V69z2rQ?=
 =?us-ascii?Q?Lor8wRqLQY/ciSIcwhcG5OB3FcN/AhmthOwC/SB5+Isv1MKV3SDK5jiVUat0?=
 =?us-ascii?Q?zTsghFGWaoBFnboss9nyWgw/OR/JBXMlBHu+A7HbjI+tGkapSy6bKusGud/5?=
 =?us-ascii?Q?q+sc9Sx88KqWzkn04m/jOoW4ys75fUtW/wEVtqm/UpNCt01VGOrV8nno96B/?=
 =?us-ascii?Q?lT7N+YnLUr/BKTK6wLBG0Dz+UwS3hkbeWHQQuAWUbnNY7atd2/IPVeuk3cAP?=
 =?us-ascii?Q?K2hRoCsUEg0ACPvPoGta3Bsvbe2B7Pw2u8BLNq3/VmxzCRyu7JeZvtTJUCD3?=
 =?us-ascii?Q?MHyL5Nc9iyZcbtQ+4lEhTriJMFYJn/Xjq2eL+QGQpa4dEm5xRjkamszEYIr9?=
 =?us-ascii?Q?xPnXiW8QdoXnSA/TailHF+5+8VwDUhNYux5QUAwphG7nEZGUjuOXy0JGLtC7?=
 =?us-ascii?Q?HttiqUrP5hQfNtEpKMnMNgg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB3167.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe0fe91-5358-41a8-5f30-08d9ae820cf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2021 13:06:23.4200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QKH1FmeLOBClfVBS2ZepT00VRKJMphkjIpBPhXdWDMS9QzR7/9YwsupNROWLI7uj3l0kAVnA8l19NRP7WW2o3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3936
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Nov 23, 2021 at 12:30PM +0000, Mark Brown wrote:
>
> This is removing the existing DA9140 compatible?

No. It's never been recognised in the driver itself and shouldn't have been=
 there.
Detritus from an obsolete test.

