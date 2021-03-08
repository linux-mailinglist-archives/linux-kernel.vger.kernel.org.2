Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94E63313D4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 17:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhCHQvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 11:51:32 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:9005 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbhCHQv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 11:51:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615222286; x=1646758286;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qA2nAMX+yREIpio47SaWA56ZGSgFWG45sJ+CnVOhY2o=;
  b=eIFZzm90XtIaoJ6kB9HobnKtylXZc25POnF87BmtMZwNkFDqpCbBlrK3
   bTqrsYnJwuMQRxvanIiR7QcgGYQtQ8mtqPOg2g0brjO8Xr8MtG+1zreZf
   p2/ZMk01pPpToqvqOYalEH4uz/mAEVyHhMyjJohDUi00iMfEJWgZReT3+
   Q9kL+cdfITWEWbHRDf5IECnS8Th9fGUNhnXcNIbSPoPYhAnYNc2x7TNYu
   x8Zqz1KfjqmkNI+0TRixQfk0RfQXK39xPeQhLXyCtCMe+Lf6xv6xrjL67
   MTO8wn18hEfEm52gqGvCmYcdBX1gbUmOzd4fT+LUsQf+x7VhfPlIG3C/C
   w==;
IronPort-SDR: G6vT32osA0Q/ofMatKuW9b9NnA92bU8+1HXqTzg4fQcEYPvgKi/HVl2LI7wH8HSO4ac1jysNQ5
 TC3HI4bHIHdup8cTDSgFRh8R36BZxv9iQ0zBPA44dTGKufu525Y3hcqDafJFnDKfeCXTvnXFJ7
 DoRc7XmhJsBVOxvm5dyK5pFszUMEXRYWmoUd9k+HhtCSCiomV9pNsN8K37dcL6EcLj5F6C8WtG
 kuArSh4HIYianLGIBeXkjiYhKnB8Z+T1PVl5ksA1dFEjYli7ZjqzKzDrePjh3KMZk8tcaXvTNk
 nAI=
X-IronPort-AV: E=Sophos;i="5.81,232,1610380800"; 
   d="scan'208";a="166126015"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2021 00:51:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktNqakizS1ljEAXAC7BLEluMCVxlIzPxcl8ppgEZHe8B1A5wePv432NasADZzayLGCdgrVvIqOJhNeAcsy2k0NzRZGEB5fn7vpqVt+XrifRZMc3LFSb1akd1tAKKXA3LNioqKFQFXIpK2MZLhFULd5NlgbPsbiFthB0pSyBoCeRpTPPgb8Iy07y8lBXd812jKTi9hqF/25Kdm2sFpdncnC/TS6ChEMrjm6AGabB6qo7LzT7BgVDPGAxtP4XI2f8qQ0UKjeQGVrwTNxTOiq34kB93vnu2Q9xSnwP+kUIZ1+/xAXukKE5w5C8TG07ZBWkFEOUtnEmBWHkzZer9gUqp5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qA2nAMX+yREIpio47SaWA56ZGSgFWG45sJ+CnVOhY2o=;
 b=BmYCoC7oIrxfYmtRNIeh+yGeNgrCHMrdMtnLwA8rzl5dDvlPGSpfuLLoDErZG5HXimgJGJ2zZhF0hkQ0X92H5DEJEof7PBvpwkcGnfKyJhDblXpJVz39eDmfJuDgCX6AwAFgV+bnR3GAU4BT1M3F2zEg9FGs6230h2ozQYMaxuZFbIW//lBOHjFbcyQWEZC1Y07LZpy/lnQ0WMngJU4e63qS11w8ZHKyd7bmYs7LH3Lljd7FB+NWo6SvJ0JRTE2vR7X5VG2LBtt7GuR/Yd729MGUy5y32WbxC3H2sU1ef/JsWrhZ5s4+g9CvVqfBy4wMSJwowJYAgYUNRsJrAebM2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qA2nAMX+yREIpio47SaWA56ZGSgFWG45sJ+CnVOhY2o=;
 b=SaJis6Oe4AlmCX4uinnsOkROtZdDrRrzQI6n3bTX3vVtF9CmxJNJeFIrgvnEJ39z+mcBlKXwmYYCo6hFR7jqYKHwwjG+sKQWKaC/UbaAnGNk4wEq+3ZX8YnwXHzA/nikRekOECWl/9yj66LvEy8snlRf39liSUqpYDcDZcrbYLM=
Received: from DM5PR04MB0684.namprd04.prod.outlook.com (2603:10b6:3:f3::20) by
 DM6PR04MB4122.namprd04.prod.outlook.com (2603:10b6:5:a3::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19; Mon, 8 Mar 2021 16:51:22 +0000
Received: from DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::11d3:8b30:e11f:87e5]) by DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::11d3:8b30:e11f:87e5%9]) with mapi id 15.20.3890.038; Mon, 8 Mar 2021
 16:51:22 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Kanchan Joshi <joshiiitr@gmail.com>
CC:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert "nvme: cleanup zone information initialization"
Thread-Topic: [PATCH] Revert "nvme: cleanup zone information initialization"
Thread-Index: AQHXFAe/O1qthbSdYkihoP//+y7iVap6SRaAgAAFYoA=
Date:   Mon, 8 Mar 2021 16:51:22 +0000
Message-ID: <YEZWCUBvbh11Z7yJ@localhost.localdomain>
References: <20210308104226.165814-1-niklas.cassel@wdc.com>
 <CA+1E3rLY_FrjhXSFr4_V0OEiv6uFnD4bvY-XLyi9O4C3n_0CGA@mail.gmail.com>
In-Reply-To: <CA+1E3rLY_FrjhXSFr4_V0OEiv6uFnD4bvY-XLyi9O4C3n_0CGA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c6da0267-3eab-4413-76ae-08d8e252678a
x-ms-traffictypediagnostic: DM6PR04MB4122:
x-microsoft-antispam-prvs: <DM6PR04MB41223183BFA183660ECC0015F2939@DM6PR04MB4122.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7Ye7SPfpTAg1IakI2tFNsiR69kCpKBSz1pQ1jhf6emw7m9vykDJGOt/ZpSY2INVC4psa3i3lQTBL+BdpgjUD0J/j/cHDP3H0sJQwqJTCPe/yucwjKkD2XGhlosL+KhIR2EPmnPO+n2W/pJ5deAZKZskz6ilRyRfKRfGzLsvebUbHeeQeluBSeBT8N5P0krjuYgCl2tOPBj+6XNSc1u3+hraVUOI1giP0DvNGPooyfJkySG4t9hRZdLv8fn34IooD2Tc+RwAKFyxKKZ02ZGuqY/wOycpBVqp94YxbrLcAt9GRHClypS6rTnvjHndyihO3uMKVxnr6WSJrcTxWIUIvPZAl905vPWkqyWCgWzNHSimmxNWt98U/F8e1d9Qi6pvQ679lhjdHW9y5QtgbRWoIkN27MzU0nWcBER6xsWQ7sJhK+hrE85YihTWGq0/HYpRyDz/6vgryug9Ri5zh5PN2j3vU5/3Joss6KNxjZNcE5cp8xbT2zbLfcbRZq7GTV+/g/ILX7B/eeEM0Y8LoIYgO8iYZ4hUN5NMFuz0lmArD5wvQkuFw6sAsmwdPsN9Z9UpOihn5A4zrq6SeZXtM/KBfBKdkuwQJ2L/UarzsrCLGehU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR04MB0684.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(4744005)(4326008)(26005)(966005)(186003)(316002)(8936002)(478600001)(54906003)(9686003)(6512007)(83380400001)(6486002)(8676002)(86362001)(2906002)(66476007)(66446008)(66556008)(64756008)(6506007)(5660300002)(91956017)(76116006)(6916009)(71200400001)(53546011)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?is6GDfW7d70Qm1eX6l6AOjFQ0Ln0hWy1TfF4D5QVXvXiOUjqDf21ab0wX2RC?=
 =?us-ascii?Q?QCpXhKU8iCuBwfDyNowaYuWLuZOH4i59QJTJJPd356waNLmKOCFguT2yknod?=
 =?us-ascii?Q?aCYBxWi0q10IuCmnV/PGCidQkhMJ75FnGj0N2gb6Hv+msgfNYirWjPHk6Jfd?=
 =?us-ascii?Q?gkWGxngUE2T8TvUCJUnukxoOvJ3VDB0d1vZMgHr03eqafPDmxhp/rC6CCmYk?=
 =?us-ascii?Q?dpyczRabZyDkL+8w3cYU0kAK21muOfZSmM0GlbnoTKdTQAl5ARetTHZKK7Cn?=
 =?us-ascii?Q?szKjHFhY4w0+NArIWhOTcc9e2DegTtlTFh1B0/DklMJrMZa9HGe+rMn6FG4R?=
 =?us-ascii?Q?GI0BwOW1FGWbWo9NFWPHtQsaWUJBdKwh+GWu+v9cZaxOzBhYtfW7DuT1joBJ?=
 =?us-ascii?Q?S/f1+RmVf2Zt6AZYw8sP73PY52UVS8gVb9N27e1vixxBlLPRqli3TnyIn47t?=
 =?us-ascii?Q?UoVHm6JTMoSNBMvcX0ex6zvCEPRmdFKjv67WoSB+6oZnsIfoSkLWy9An0jeF?=
 =?us-ascii?Q?JdzEUi4x8tmZe6Yi2TzoPy1LzFMTFVF2F1pfoIFvQDBjfltZa3jwPUy4wOFI?=
 =?us-ascii?Q?Kb2aUI6xiXMZMZXeP/igTs/nlYnEq4C+jS6lbT62XEqwVyoMvMfBexFcHI5M?=
 =?us-ascii?Q?Gh5J3RakqHNUGrbOwXhMVxRVz2qi5vDeqnde0fCKG94Rctt83BlvQDAPs0Uc?=
 =?us-ascii?Q?3cUvlhM4LR0wzY7zspndHk2VVCWU4FqC1FLwp36Rc/iaKnqKsFE32LpVR8mL?=
 =?us-ascii?Q?2GsBFbxI/c+CPRZmJXgT3+SuHoodGrOgqbIzJsZenT/ygO+vmhN/ckz3vyqL?=
 =?us-ascii?Q?1hKfh8p6z2P2l/s16Z1r3Mh8cogRbn1SF4m9OfwziAEgoV9/ztd54q2lmsi2?=
 =?us-ascii?Q?ZXLPVNY7DBBlrqwuO8D40S0UzXhI+E5U+gJeC3dTvR0xwr6Ibtthf++XCOwD?=
 =?us-ascii?Q?fttbQBbmjZ11UgWzn+N5lSGVdZ1/pPCipiW2UAyQSZMkMMxWqUPCH+bjn/5U?=
 =?us-ascii?Q?t50ZT80AC1y7BfZXDwJJXUW+jekWaZEdJ0FhXKMspfTRpH7YJElwC03DkhK8?=
 =?us-ascii?Q?vZWcTZyPWvLRaLrLb9Ksjr2JApJymmsuzaUBqlB6ibs2bMFfacyIi6DYheqk?=
 =?us-ascii?Q?8mWKov6dd8reupF263x5GuTXuQsb+8CKWxGRcy0Lt6giQjeC2Cn/O6Dg2GdL?=
 =?us-ascii?Q?T5Xtdjzcz81tsHXKIoEpIYqzFg0lRve8Q5c7Yi92TvJRM3/RPcYI8kb5Wj0Q?=
 =?us-ascii?Q?g26XDhrCCNdhxiEhzBTQ9ZpaecGjh/hMO5eR983eRRudIee+JC5G7WhQwEBF?=
 =?us-ascii?Q?ORhVdbFga4R/1iJsQ+svBqI3?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7434A807933FE74C86BD3BE521F1CDB4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR04MB0684.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6da0267-3eab-4413-76ae-08d8e252678a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 16:51:22.4488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: naQXiRobAQaRzFvFHZTuAiYl0ucaksgRJomRJSENNTdJlY4q8Y+YF3wLT2XZzRnK6LMH2VMVOLsHO0di41x80g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4122
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 10:02:05PM +0530, Kanchan Joshi wrote:
> On Mon, Mar 8, 2021 at 4:21 PM Niklas Cassel <Niklas.Cassel@wdc.com> wrot=
e:
> >
> > From: Niklas Cassel <niklas.cassel@wdc.com>
> >
> > This reverts commit 73d90386b559d6f4c3c5db5e6bb1b68aae8fd3e7.
> >
> > Commit 73d90386b559 ("nvme: cleanup zone information initialization")
> > introduced the following warning at boot:
> > WARNING: CPU: 0 PID: 7 at block/blk-settings.c:252 blk_queue_max_zone_a=
ppend_sectors+0x7d/0x90
> >
> > The warning is the result of chunk_sectors being 0.
>=20
> This looks same as what Chaitanya posted the fix for -
> https://lore.kernel.org/linux-nvme/20210303224717.51633-1-chaitanya.kulka=
rni@wdc.com/

Hello Kanchan,

Indeed, thanks for telling me.

Kind regards,
Niklas=
