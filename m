Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557503BBB62
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 12:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbhGEKnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 06:43:01 -0400
Received: from mail-dm6nam10on2085.outbound.protection.outlook.com ([40.107.93.85]:38272
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230474AbhGEKnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 06:43:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+Ys+z61ElsQSK6nTfMAimKRrdDKPN8T7LrxFiiGafdeHss+15NMZH8enZkrVZM4DpjJojYC1LsrnVNfkcFg8T25nolMh3TLGKX84WIYA05CQP1mKEPWfj9OJcSAG/OjVLPjl3E0QNDFk8LUNKGwVvgpVdkNZonaX9lqxRoITwPlWv2GrB4xhX1kJ8R1oJ6dAs268bz6csI5Zc073Rj+FClieQlO66YH3pnEzjh8dVviypzmGTWWKCxZnHLjgifDv6ieZ+WBLTnSO6siXtvES762AJyD3OBF8KTnxfuJbCkCZXO8OmUrTT2ZlIYkzmRBSvYZABK2obP2afA0aOnhmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8n4NC91Ol3TQAYiY3Nqp/2LMQMMcm0NhKq7KESvfKI=;
 b=mZWtd0T4X4jdTX0/tGmsc3TueVVEC1BnjCIsjnP1tZAAyygY9RnjJ5dtz7JCOIaRMaw7MQitwukXL5Y6hYjmmZ/gaXfa/C3e5G1egvc9AG1WV+2g4YK89r3n5WGrHsS+qRBiS5EbxD2wssxoE+3kH5bXDLQj/aC7fHxuYLnJ7PQC0/ey/bFt8gx4UyAH2fBgElaNtndD7tmngvE7OjPqvKMazN07eovUlL+fSYtzUqmORMQHo9PdjlRFJWFXDFtMVfpuuPPBig/EVYFSB5sTbDZ71pcznMrlcPXytfU1LQIxmK/oWsDiUkQPt3SREKzEWuTkELwTjNehVluFRwXL2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8n4NC91Ol3TQAYiY3Nqp/2LMQMMcm0NhKq7KESvfKI=;
 b=gU4rXQq9Rb+1e1rwMjIi0lYo5DCZq6lnEQV3ilj8zuvxrZ2tcHpj8Ev784jig8/yD2OnmevuSREWwOD/GRhD9k6yVQZ41bl2fZSsMJL1AsRyJdf9OV4a9OgharxuLt1kTdZ5AiwUD89MmHGj8JKwnBDCt1LKBxL/1WYew2IRgIw=
Received: from BLAPR08MB6900.namprd08.prod.outlook.com (2603:10b6:208:325::21)
 by BLAPR08MB6866.namprd08.prod.outlook.com (2603:10b6:208:306::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Mon, 5 Jul
 2021 10:40:22 +0000
Received: from BLAPR08MB6900.namprd08.prod.outlook.com
 ([fe80::fde3:800c:617d:f516]) by BLAPR08MB6900.namprd08.prod.outlook.com
 ([fe80::fde3:800c:617d:f516%7]) with mapi id 15.20.4287.033; Mon, 5 Jul 2021
 10:40:22 +0000
From:   "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shiva.linuxworks@gmail.com" <shiva.linuxworks@gmail.com>
Subject: RE: [EXT] Re: [PATCH] nvme: Add abrupt shutdown support
Thread-Topic: [EXT] Re: [PATCH] nvme: Add abrupt shutdown support
Thread-Index: AQHXcYbB/F8jcejucEauG3F+rz+Qo6s0K71g
Date:   Mon, 5 Jul 2021 10:40:21 +0000
Message-ID: <BLAPR08MB6900B02E65B542A2C2F174E1B81C9@BLAPR08MB6900.namprd08.prod.outlook.com>
References: <20210705101157.1009135-1-sshivamurthy@micron.com>
 <20210705101554.GA12803@lst.de>
In-Reply-To: <20210705101554.GA12803@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Enabled=true;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SetDate=2021-07-05T10:40:19Z;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Method=Standard;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Name=Confidential;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SiteId=f38a5ecd-2813-4862-b11b-ac1d563c806f;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ActionId=87f173d9-6d34-432c-b96d-eca6df33f28f;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ContentBits=3
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=micron.com;
x-originating-ip: [95.90.192.255]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61894d90-c718-42ce-b966-08d93fa14a6a
x-ms-traffictypediagnostic: BLAPR08MB6866:
x-microsoft-antispam-prvs: <BLAPR08MB686611F9C10198FA7714036AB81C9@BLAPR08MB6866.namprd08.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TGHXLKpajgadfdQE8/m2Nsdvl2S3h8ZF+3wWgV+FJCixWMf4O7VoyhQuYtg3OGx5IzZAX+fMWF2LbekXxep+p0JWpKAYPdvYCiZ3NwYkTrQO5JpbZoJ4G1CcbFCSiP4O4PnGQXl0SZ49OLAFOnfUIn0T3BVWG6g46jPaCTBcr0NuS0d/n0mmxJQ0yddSymFjPYO+etx74HDCGAcmZHXfCQCxAaXd/2p/wO4r6GC50HttdAHxE0Il0S9m7wvjbc1Ia6Qmlr+Zunf23xxb1LPSaxv8pbju1YFxVKG36u5qF9fjQw3f4vl4VsDva/U8YzpTRZD/U5eIb8kXUQJhJtnQIQc4f1cshNs4Sdzn7V2ngqd0JaRYRkeVlZFtyqp5asb7Iw5yDKrRy4+N2+aefniCCnpUPO+AmL5sZQF8tWLcToTURMYRpx3YzOMss5qP6zla4P4OaRFbdIJiUjZyqVrz9W8Xc2OSvQRnwFlWB3AxMfyPNuEDeURce9sDkb0SlBPI6M2uZh6IcB4TiZtnN+ECI3KPA+GWD/G6AsczuELQz8KBxvSVRrMl6NiYKhEKM40/RGpWKuballGjK7oPM3L3xdrS0zk/vz1x6Rw3GxP7vzIbn8TKop8NpSAcU5sLsHj7rxXrtXmwn539RqGcckXP9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR08MB6900.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(478600001)(4744005)(6506007)(122000001)(6916009)(7696005)(66446008)(186003)(8676002)(38100700002)(52536014)(86362001)(54906003)(26005)(8936002)(71200400001)(4326008)(83380400001)(9686003)(5660300002)(66946007)(64756008)(66556008)(55016002)(33656002)(316002)(2906002)(76116006)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VnHcEzIev2VSZwfrqbS/78Uc90HHQi11dQuk8+gY8Vodcw4hFvhZddiVteF4?=
 =?us-ascii?Q?FWzljbe85V5eTVS+2DuQ1IiBRubzBHGi0V7nrPwM6ga+t0msg8Kw5rh5mQLz?=
 =?us-ascii?Q?cRsEi5qhMyeQrektosEvh/J0om88c4DlmYt6gaI6UmH3EQLr1j3BAs6pp98/?=
 =?us-ascii?Q?Umi3GE1yfoDTJdDlIdnce0PReRy19qJXobbWKfKRE+BNoVQP/QaUAQe7BUcA?=
 =?us-ascii?Q?dirBND13eLtTRDguEzSqrCw2f2jZoeOENutLYW9aLmxzNNULO6nJJobyhY5W?=
 =?us-ascii?Q?LQhmC3Iva0Ty9kWDHGOtnnTbnu0xc2giCe8AIdhW3n0nk/SAbTJEu0nhOI5Y?=
 =?us-ascii?Q?8gJUE0OtDWi8+TE61+M18rIsoXhsl7h39FITRhMdrtRqc/FG8qTFLAT1ryCA?=
 =?us-ascii?Q?OwLYjQhfvr8XBV08nxq8BfwHvypuHtKmDVh6M2v4t8ARmuzOmurzo5lyXyVl?=
 =?us-ascii?Q?eBZWjfDKKb5yPRzCtP5nzBAhOCAIWO460wuehzMh3iplU1K3Y+jbFvLty7ir?=
 =?us-ascii?Q?FaVIe4OFL10V0rL82daLKYBtZBK/AoSffVC4s1KACY9XAZoSkWy0Z/9RpmJl?=
 =?us-ascii?Q?jb2z/PBTy9HYW82L7ECwoX27hfqfJ+hJ0y5Ql/1JIXj5Kt/sgEzk7dk95/XD?=
 =?us-ascii?Q?xgEdShgkAfsTGF0hUPKJkdEo0pJkLJ57DHB2fM4E9tV2pR7SPTFhv477cb4Y?=
 =?us-ascii?Q?fTWmTOuqqvEt6B98krZsiWHSokuNOc4Gis+sA+X73Gh9NaLk+/5Ayq13rjPS?=
 =?us-ascii?Q?DhOlgQWdAuWGa9cxw2Yg2SdX9bOEh7ccr/jxDywmLDSgk+Q5Wt8MdmW0hbqb?=
 =?us-ascii?Q?90CPu8xkzLycLJU47IU/XyQO4gioUqj5e0kRC5T8bloDwZUUtvFkCRBeRb8n?=
 =?us-ascii?Q?3NiS1JcBptjfc36KUvQr4IwBx1nu2ce6E9wIHOZRUqXfTi0andDeGV34F3Dq?=
 =?us-ascii?Q?6KRskbXDG5PLy+4dgXHP9L2+JzWERZzBu/g8ZZPfBqC672+5JAL/wGU6a/FH?=
 =?us-ascii?Q?4FA1GTfTm24Jr+moGoFmjDdmznqGDvvLlCZDwG6iBSIP78VVdFDyMHD5lyTW?=
 =?us-ascii?Q?hURknP4VwYM2xymU7TsWICGPWeb7YBjRKyyDfhRrx8ZQwhFk9HxZFhZSWEPS?=
 =?us-ascii?Q?3sSB99uM0ydgVMDcUWtkLylFAtrvdG0IsfDR5z9yBKLdhaF7DK9YdgCI5uqO?=
 =?us-ascii?Q?N09CBYyiXWGJVBHX80iMTUvadHm7RLTCPcRbtJrxjSLLGWvD83J4dMdKqTbK?=
 =?us-ascii?Q?70Rf7vrh16CgKNeG7aJJeH3qY869otD0hj9Rlyr5bFeWoIYmqCUlYC5Z3p9K?=
 =?us-ascii?Q?p14=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR08MB6900.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61894d90-c718-42ce-b966-08d93fa14a6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2021 10:40:21.9303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pnCDW6734ja1s5Z15P4qIk8Ob3IhCFfD9z9ANiP3a7f8EYH8FcUHf/jgup5SiAC/IM8h8A495oMRJsyQWnV8Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR08MB6866
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Micron Confidential

Hi Christoph,

>=20
>=20
> On Mon, Jul 05, 2021 at 10:11:57AM +0000, shiva.linuxworks@gmail.com wrot=
e:
> > From: Shivamurthy Shastri <sshivamurthy@micron.com>
> >
> > Enabling the abrupt shutdown support. In this shutdown type host does
> > not need to send Delete I/O Submission Queue and Delete I/O Completion
> > queue commands to the device.
>=20
> Why?

This is to achieve faster shutdown at the cost of data in-flight.

As per the spec Deleting Submission queues and Completion queues are not ex=
plicitly=20
mentioned for performing the abrupt shutdown (CC.SHN=3D10b).

Thanks,
Shiva


Micron Confidential
