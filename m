Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6243DEC45
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 13:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbhHCLir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 07:38:47 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:21030 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233638AbhHCLiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 07:38:46 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173BUt8B008128;
        Tue, 3 Aug 2021 04:38:26 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by mx0a-0016f401.pphosted.com with ESMTP id 3a6sfua3ac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 04:38:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVAyD+uDuG306hwyzSscyaW1QT85TDeyOVoWCi4eyKRyPaftA/MbbffQTiwdZ+aiAq5TUsKqjIpW1mCtSTofGS11KNy5iDQ1XhEs84rKqGK+Aw5ZTtx1O+e1aSj/+H4B1efDH9AkvGpVEfecMQ8MgxX8EHrbYxI3MN0D9A46nD54FLUDE8giNua1YPvosPxc0llnF8yKiezpO2U5MsuJ1B3FUAXBYNUpt1FcFBjsPLKIDF2DD369hSmhjF0yuYZgqUXC24ZpXAty8KHolV+4NuW4TXD6oEgJBsUn+lWgsXeLROISKO+KkqZ4PZytxyGXgvOPFJEvBk7fLIQfulpilg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DL+7NaqkWmnoqpDj2bsKFjbvptIfbYHDcwEPKAHXOGM=;
 b=K01EOqpyNxV0iiBavWhgZeUTclwFnPiT0347FotYCMxDi70tuh6HA3tgiBQdRlFFkdSc7IjbHzP82xBQ83mxynFyES7xI4KD+rHRM37MGuI+L84jD0Bp+4VWFU9LlROya5QQJS8EHL/Bpk7LHCi4gp5fm/ie8MaMIEvLfp2c85FOMIDWNBhYmtn5/j41nEWUZJs17Un0OsGon8eDpS2mWj0PGNyyEe3eDkmB/lLqJCcXahMg3fkX1XdCVfl/JslWdjknenH/sQtwrg8oDZ95HIGmPDaSEy9Gnvct0NORxuIua4rTgPEIcL664sldPkX1UdGP4NRMO38wfp6SRRe6kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DL+7NaqkWmnoqpDj2bsKFjbvptIfbYHDcwEPKAHXOGM=;
 b=b9Ds0+XacgUpZPPqHvSHVPsVZlX2+a5Ex7rT/oBqqsllulxQRic374dkO/5oewvesDAADD4Hhp3ezxwLsWH7k657arv8q/0L5aCgUdJ0cod4VHu8e9kOAuRMPSlsEuwzphM3C0WLzBOWG6q1X/1dLbpBA3mFceSyBEA4nwhmM0o=
Received: from CO6PR18MB4465.namprd18.prod.outlook.com (2603:10b6:303:13b::10)
 by CO6PR18MB4417.namprd18.prod.outlook.com (2603:10b6:5:354::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 3 Aug
 2021 11:38:24 +0000
Received: from CO6PR18MB4465.namprd18.prod.outlook.com
 ([fe80::7412:17a6:caa5:8df2]) by CO6PR18MB4465.namprd18.prod.outlook.com
 ([fe80::7412:17a6:caa5:8df2%9]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 11:38:24 +0000
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     Rob Herring <robh@kernel.org>
CC:     "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>
Subject: RE: [EXT] Re: [PATCH 1/4] dt-bindings: perf: marvell: cn10k ddr
 performance monitor
Thread-Topic: [EXT] Re: [PATCH 1/4] dt-bindings: perf: marvell: cn10k ddr
 performance monitor
Thread-Index: AQHXgf4emPenZcnlnEyhnjI+6pJ1B6tanz8AgAcUJLA=
Date:   Tue, 3 Aug 2021 11:38:24 +0000
Message-ID: <CO6PR18MB446536021939F4F3E8F4C6E4E3F09@CO6PR18MB4465.namprd18.prod.outlook.com>
References: <20210726091027.798-1-bbhushan2@marvell.com>
 <20210726091027.798-2-bbhushan2@marvell.com>
 <YQM56mlxM19UDu93@robh.at.kernel.org>
In-Reply-To: <YQM56mlxM19UDu93@robh.at.kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38327c4f-80a9-494d-db90-08d95673342f
x-ms-traffictypediagnostic: CO6PR18MB4417:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR18MB44176CABE8FFAFECD24754E6E3F09@CO6PR18MB4417.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8zhQSdO424lAbdik6ruylC60hAGzM8rAwYTlCEUoCauldx3Kq1vc7yxVFeNxFRhTpzhm+kHDCSZWO7dpik3ZYUMLxR1PGQUayoP+UsItGGM3o5YeeiB88aVnMetgen8QBatUR2tgi1XZfUP4z5Z3lauFA8980oa1x9NDzJjaoylymYh2NEYtQc7xpdC5Wa7AE2DpNk9LmEGLliYBXLYCgSDTwUoWsKCpKNd4fqwFTlbN+Zg015v+tjBYfh/DwqxtUxhL3IRD0Oyt1pLNYSAz7XMI07uJvrNNAGy/vEqqtHc9LLGjnVVZr3D1OVNBMdYg4ok0j3AsKM5NcDhC94EuUIWIRqomOqc6NSUYC7Tz2K0fat/0DPGNmNjCC5uAr4AdN/eksMgGrPyQTOkedv6pRqVRUyd/vETV57pecjyzOhobekMtU//EiPU58EXwAmf+DCoFvzQhcc6opuI2X53oz7I65VyqXg4C8sj1xPJwW+FdoVsX3lo04+mfgM/7Yf9lsqJCfVDMg/gtNdAnDN3nnlX/Wbpi+eU51ZYkRJttVoz97aEOsBEpyJ9l6sv4Esn4LQGps+ppX9mwtufv86Bd6IjS1/WUalcRwup59c/Gx69JaCrXC3TW44REXSJUeHgAoNpinaf14BogPk9VsntEfp2iZZNGZg9c1kVtSgJgJhX3cqhV8LTgRk68qS2jtbJUllfGmzsIPoQ3yHKG6Mkk7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4465.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(52536014)(66946007)(8936002)(7696005)(508600001)(66556008)(54906003)(83380400001)(66446008)(5660300002)(186003)(53546011)(6916009)(66476007)(33656002)(6506007)(64756008)(8676002)(71200400001)(9686003)(55016002)(4326008)(86362001)(2906002)(76116006)(316002)(107886003)(38070700005)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RVgYHqszOKe2jLLRPnb8QxmcgHguYqBbH4JWA/w2umvH7kGk05I3B8ZeAJsm?=
 =?us-ascii?Q?RdVQSCI/j/X9QOJF3yB4UBcZPqzhTmsWi/OInbEtJToK9+e1WcokTOMmgjSZ?=
 =?us-ascii?Q?eT5vYf4ll+5Ye4FdIFuM9hrUCsTiycdKkgBHfh1qrKpxr0PX8Q261ULUqDXS?=
 =?us-ascii?Q?Ewi0ffJsWvYmmuJ0M0mgsU620KKp2PR9Kwvm5BWLFC00Xxv7em3ZAgetshI/?=
 =?us-ascii?Q?fJL/cN+9lkK3Dd20WZSYrGk7I9xyuCidO107pZsRFXFr/nBDEbG3iYepKYIF?=
 =?us-ascii?Q?Izu/Q5ziWQfr3bgvxog0yaekQ6kUq6mS7D+hAjh1fzVmA5bW2J8+9/r04WSN?=
 =?us-ascii?Q?+NkgQALInzylE3F6lVTzyBxCGaivVYSZv+1EG43XZmBBQUPyTo+iShsAMAf3?=
 =?us-ascii?Q?nrVwxioOTiz8AQVE3DyUaexWHmnD0pKhHbi19dfkeBbmki9fveDZvoRZ/KxF?=
 =?us-ascii?Q?rJWIXAmooV76Ax0YKBI20G4Xw7jbh3ubaigjEPCWEH4uRCpkTiHghPuuQ39J?=
 =?us-ascii?Q?7WzWM3Nx9dLtofivy6TYIvCQljldE+FTFLe9pKmfLOW63VUJ0o485C0KG5j+?=
 =?us-ascii?Q?BQN+/6Tokd1WfQ8TvTV7oX6LqX0sjVp0AjpWtAtRuEoscM4Ot95txHkh+AuJ?=
 =?us-ascii?Q?h/qirkZY4mNqt2fZhav/298zyRyGE1pvGC5rmMoS/HaywZlacx8Wvmxz2rVt?=
 =?us-ascii?Q?UuXNoGrDhM02GCPq0S/9pEkY7b4fb1jGNKcznEKEbPTPEhtVJxx0d/2q+Kaj?=
 =?us-ascii?Q?s7sptVif58AT0aH7td8y8zKowq/ZLkcD6sLprjI2KALBqj8dg6zNv4EiUL7n?=
 =?us-ascii?Q?vOonOKqtnrkU3CMt9OVssUjeJyA9TeWIX7fokRO1FDoINJol0Fv+UcIyQWUR?=
 =?us-ascii?Q?lCaJqw5Ub0EAmq/OQgscuKJw0I9nmbpq+evV4NZEE1PWdm4wJAeliv21U9bp?=
 =?us-ascii?Q?53s4/+4SyfDEP0tzwipjn1ZIVBQ6V/FCo5AD6ZjgEmajotpHgC3bXWB7VWmb?=
 =?us-ascii?Q?M7BBmxvOliU6gLizi5qa8sMNEaijkiGJsR5dIGNBoVEITHYfj3W692rR59F2?=
 =?us-ascii?Q?Nd23x3EghvywmA70WY3N4zFTPfoOCANFVXmGCwAEciJOMI0lbRvxDAvoNu7Q?=
 =?us-ascii?Q?WYUY2GXv5kLvSJ5bJILC5LTJXa8mPvDahQUxh7uEnbgbbFBn1HJbTpt6rrbW?=
 =?us-ascii?Q?JMSN8FFOuHnKDL/boI86F9Jb2D+c2u1EemjnU2Pcw9KSa8SE21VkcQJusy4f?=
 =?us-ascii?Q?Kpj32+o/J+OTHQ1QKW9oRx+cyat19UJuld6GJp+R/uVcQrmN+/qC8wIZguwf?=
 =?us-ascii?Q?8Y94JVwKht7478CHi763RFSZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4465.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38327c4f-80a9-494d-db90-08d95673342f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2021 11:38:24.5330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t8RlfIVzh5vY9HUixZLrJcQJ7O7voE6l16fpP72yuOzbor5UGFg3CzXXRu42OHSvd46t/IEd2iisnaq/pCzfEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB4417
X-Proofpoint-ORIG-GUID: 3xvf9HqvkgStSlD5X1U3lwz4cpITEGxB
X-Proofpoint-GUID: 3xvf9HqvkgStSlD5X1U3lwz4cpITEGxB
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-03_02:2021-08-03,2021-08-03 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Friday, July 30, 2021 5:00 AM
> To: Bharat Bhushan <bbhushan2@marvell.com>
> Cc: will@kernel.org; mark.rutland@arm.com; linux-arm-
> kernel@lists.infradead.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; Sunil Kovvuri Goutham <sgoutham@marvell.com>
> Subject: [EXT] Re: [PATCH 1/4] dt-bindings: perf: marvell: cn10k ddr perf=
ormance
> monitor
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Mon, Jul 26, 2021 at 02:40:24PM +0530, Bharat Bhushan wrote:
> > Add binding documentation for the Marvell CN10k DDR performance
> > monitor unit.
> >
> > Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> > ---
> >  .../bindings/perf/marvell-cn10k-ddr.txt           | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.txt
>=20
> Bindings are in DT schema format now.

I did not paid attention it changed to DT schema. Will do required changed =
in next version.
Just waiting for comments in other patches.=20

Thanks
-Bharat

>=20
> Rob
